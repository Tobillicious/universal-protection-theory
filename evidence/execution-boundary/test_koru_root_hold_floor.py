"""Disposable Linux ARM64/x86 root-floor rollback denial integration.

The original controller-only test in #524 deliberately demonstrates rollback.
These tests install an INDEPENDENT root-owned floor, checked by the writer at
effect time under the same cross-UID lock, and verify that old controller state
cannot resurrect the signed synthetic permit. Not a production service.
"""
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time
import unittest

import test_koru_signed_cross_uid_hold as base
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_root_hold_floor import RootOwnedHoldFloor

WRITER_WITH_FLOOR = r"""
import os,sys
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_cross_uid_authority import ControllerOwnedSnapshot
from koru_root_hold_floor import RootOwnedHoldFloor
from koru_writer_signed_policy import SignedWriterPolicy
from koru_writer_enactment_fence import SignedWriterEnactor
from koru_isolated_marker_writer import IsolatedMarkerWriter
sock,marker,lock,controller_dir,floor_dir,pubkey=sys.argv[1:]
fence=ProvisionedCrossUidFence(lock,shared_gid=65531)
snapshot=ControllerOwnedSnapshot(controller_dir,controller_uid=65533,shared_gid=65531)
floor=RootOwnedHoldFloor(floor_dir)
policy=SignedWriterPolicy(
    public_key=Ed25519PublicKey.from_public_bytes(bytes.fromhex(pubkey)),
    issuer='fixture-issuer',clock=lambda:20,
    current_state_check=lambda event,permit,now:floor.permits(event,snapshot))
server=IsolatedMarkerWriter(sock,marker,broker_uid=65534,
    signed_enactor=SignedWriterEnactor(signed_policy=policy,shared_lock=fence))
print('READY',flush=True)
try: server.serve_forever(poll_interval=0.05)
finally:
    server.server_close()
    floor.close()
    snapshot.close()
    fence.close()
"""


@unittest.skipUnless(sys.platform == 'linux' and os.geteuid() == 0,
                     'privileged disposable Linux fixture only')
class RootFloorRollbackTests(unittest.TestCase):
    def setUp(self):
        # Reuse the previously tested three-UID container fixture verbatim.
        self.case = base.SignedCrossUidHoldTests(
            methodName='test_signed_write_hold_and_restart_refuse')
        self.case.setUp()
        c=self.case
        c.stop_writer()
        self.root_floor_dir = c.root/'independent-floor'
        self.root_floor_dir.mkdir(mode=0o755)
        self.root_floor_file = self.root_floor_dir/'hold-floor.json'
        self.initial_floor = {
            'generation':c.event['generation'],'held':False,
            'event_id':c.event['event_id'],
            'authority_ref':c.event['authority_ref']}
        self.root_floor_file.write_text(json.dumps(self.initial_floor))
        self.root_floor_file.chmod(0o644)
        self.assertEqual(self.root_floor_file.stat().st_uid,0)
        shutil.copyfile(Path(__file__).with_name('koru_root_hold_floor.py'),
                        c.lib/'koru_root_hold_floor.py')
        self.start_anchored_writer()

    def start_anchored_writer(self):
        c=self.case
        c.server=subprocess.Popen(
            [sys.executable,'-B','-c',WRITER_WITH_FLOOR,
             c.sock,str(c.marker),str(c.lock),str(c.control),
             str(self.root_floor_dir),c.public],
            preexec_fn=base.drop_to(base.WRITER),cwd='/',env=c.env,
            stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
        deadline=time.monotonic()+5
        while time.monotonic()<deadline:
            if c.server.poll() is not None:
                raise AssertionError('anchored writer failed: '+c.server.stderr.read())
            if os.path.exists(c.sock) and (os.stat(c.sock).st_mode & 0o777)==0o666:
                return
            time.sleep(0.025)
        raise AssertionError('anchored writer unavailable')

    def trusted_root_hold(self):
        c=self.case
        fence=ProvisionedCrossUidFence(str(c.lock),shared_gid=base.LOCK_GROUP)
        floor=RootOwnedHoldFloor(str(self.root_floor_dir))
        try:
            return floor.commit_hold(fence)
        finally:
            floor.close()
            fence.close()

    def tearDown(self):
        if getattr(self,'case',None) is not None:
            self.case.tearDown()

    def test_pre_hold_signed_effect_then_old_snapshot_replay_denied(self):
        c=self.case
        stale=c.state.read_bytes()
        self.assertEqual(c.request()['code'],'empty_marker_created')
        self.assertEqual(self.trusted_root_hold()['code'],'floor_hold_committed')
        # Simulated recovery from pre-HOLD controller backup, unchanged valid
        # inode owner/mode: previously this bypassed #523 without root floor.
        c.state.write_bytes(stale)
        self.assertEqual(c.request()['code'],'writer_authorization_denied')
        c.stop_writer()
        self.start_anchored_writer()
        self.assertEqual(c.request()['code'],'writer_authorization_denied')
        self.assertEqual(len(list(c.marker.iterdir())),1)

    def test_crash_window_floor_committed_controller_snapshot_stale_denies(self):
        c=self.case
        self.assertFalse(list(c.marker.iterdir()))
        # Root commits floor before controller snapshot; simulated crash here.
        self.assertEqual(self.trusted_root_hold()['code'],'floor_hold_committed')
        self.assertFalse(json.loads(c.state.read_text())['halted'])
        self.assertEqual(c.request()['code'],'writer_authorization_denied')
        c.stop_writer()
        self.start_anchored_writer()
        self.assertEqual(c.request()['code'],'writer_authorization_denied')
        self.assertFalse(list(c.marker.iterdir()))

    def test_controller_cannot_rewrite_root_floor(self):
        c=self.case
        script='import os,sys;os.open(sys.argv[1],os.O_WRONLY)'
        for uid in (base.CONTROLLER,base.WRITER,base.BROKER):
            p=subprocess.run([sys.executable,'-B','-c',script,
                              str(self.root_floor_file)],
                 preexec_fn=base.drop_to(uid),cwd='/',env=c.env,
                 capture_output=True,text=True,timeout=5)
            self.assertNotEqual(p.returncode,0,p.stderr)
            self.assertIn('PermissionError',p.stderr)

    def test_missing_or_corrupt_independent_floor_denies(self):
        c=self.case
        self.root_floor_file.unlink()
        self.assertEqual(c.request()['code'],'writer_authorization_denied')
        self.root_floor_file.write_text('invalid json')
        self.root_floor_file.chmod(0o644)
        self.assertEqual(c.request()['code'],'writer_authorization_denied')
        self.assertFalse(list(c.marker.iterdir()))


if __name__=='__main__':
    unittest.main()
