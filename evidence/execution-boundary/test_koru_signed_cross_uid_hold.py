"""End-to-end *synthetic* signed marker, cross-UID HOLD and restart test.

Disposable privileged Linux fixture only. Controller, writer, and broker use
three distinct UIDs. The permit describes synthetic data, not actual consent.
No persistent service, authentic X3, host-root resistance or certification.
"""
import json
import select
import os
from pathlib import Path
import shutil
import socket
import subprocess
import sys
import tempfile
import time
import unittest

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_ed25519_permit import issue_ed25519
from test_koru_shadow import fixtures

WRITER = 65532
CONTROLLER = 65533
BROKER = 65534
LOCK_GROUP = 65531
LIBS = ("koru_cross_uid_fence.py", "koru_cross_uid_authority.py",
        "koru_writer_signed_policy.py", "koru_writer_enactment_fence.py",
        "koru_isolated_marker_writer.py", "koru_ed25519_permit.py",
        "koru_shadow.py")

WRITER_SCRIPT = r"""
import os,sys
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_cross_uid_authority import ControllerOwnedSnapshot
from koru_writer_signed_policy import SignedWriterPolicy
from koru_writer_enactment_fence import SignedWriterEnactor
from koru_isolated_marker_writer import IsolatedMarkerWriter
sock,marker,lock,controller_dir,pubkey=sys.argv[1:]
fence=ProvisionedCrossUidFence(lock,shared_gid=65531)
snapshot=ControllerOwnedSnapshot(controller_dir,controller_uid=65533,shared_gid=65531)
policy=SignedWriterPolicy(
    public_key=Ed25519PublicKey.from_public_bytes(bytes.fromhex(pubkey)),
    issuer='fixture-issuer',clock=lambda:20,
    current_state_check=lambda event,permit,now:snapshot.permits(event))
server=IsolatedMarkerWriter(sock,marker,broker_uid=65534,
    signed_enactor=SignedWriterEnactor(signed_policy=policy,shared_lock=fence))
print('READY',flush=True)
try: server.serve_forever(poll_interval=0.05)
finally:
    server.server_close()
    snapshot.close()
    fence.close()
"""

CONTROLLER_SCRIPT = r"""
import sys,json
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_cross_uid_authority import ControllerOwnedSnapshot
fence=ProvisionedCrossUidFence(sys.argv[1],shared_gid=65531)
s=ControllerOwnedSnapshot(sys.argv[2],controller_uid=65533,shared_gid=65531)
print(json.dumps(s.hold(fence)),flush=True)
s.close()
fence.close()
"""

CLIENT_SCRIPT = r"""
import json,socket,sys
with socket.socket(socket.AF_UNIX,socket.SOCK_STREAM) as s:
    s.settimeout(3)
    s.connect(sys.argv[1])
    s.sendall((sys.stdin.read()+'\n').encode())
    print(s.recv(4096).decode().strip(),flush=True)
"""


def drop_to(uid):
    def apply():
        os.setgroups([])
        os.setgid(LOCK_GROUP if uid != BROKER else BROKER)
        os.setuid(uid)
    return apply


@unittest.skipUnless(sys.platform == 'linux' and os.geteuid() == 0,
                     'disposable privileged Linux integration only')
class SignedCrossUidHoldTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='g3-signed-cross-uid-')
        self.root = Path(self.temp.name)
        self.root.chmod(0o755)
        self.lock_dir = self.root/'fence'
        self.lock_dir.mkdir(mode=0o700)
        os.chown(self.lock_dir,0,LOCK_GROUP)
        self.lock_dir.chmod(0o710)
        self.lock = self.lock_dir/'effect.lock'
        self.lock.write_bytes(b'')
        os.chown(self.lock,0,LOCK_GROUP)
        self.lock.chmod(0o660)
        self.control = self.root/'control'
        self.control.mkdir(mode=0o700)
        self.control.chmod(0o710)
        os.chown(self.control,CONTROLLER,LOCK_GROUP)
        self.state = self.control/'authority.json'
        self.event, _ = fixtures()
        self.state.write_text(json.dumps({
            'generation':self.event['generation'],'halted':False,
            'event_id':self.event['event_id'],
            'authority_ref':self.event['authority_ref']}))
        self.state.chmod(0o640)
        os.chown(self.state,CONTROLLER,LOCK_GROUP)
        self.socket_dir = self.root/'socket'
        self.socket_dir.mkdir(mode=0o700)
        self.socket_dir.chmod(0o711)
        os.chown(self.socket_dir,WRITER,WRITER)
        self.sock = str(self.socket_dir/'writer.sock')
        self.marker = self.root/'markers'
        self.marker.mkdir(mode=0o700)
        os.chown(self.marker,WRITER,WRITER)
        self.lib = self.root/'lib'
        self.lib.mkdir()
        for f in LIBS:
            shutil.copyfile(Path(__file__).with_name(f),self.lib/f)
        self.key = Ed25519PrivateKey.generate()
        self.permit = issue_ed25519(self.key,issuer='fixture-issuer',
                                    event=self.event,expires_at=100)
        self.public = self.key.public_key().public_bytes(
            encoding=serialization.Encoding.Raw,
            format=serialization.PublicFormat.Raw).hex()
        self.env = dict(os.environ,PYTHONPATH=str(self.lib),PYTHONDONTWRITEBYTECODE='1')
        self.server = None
        self.start_writer()

    def start_writer(self):
        self.server = subprocess.Popen(
            [sys.executable,'-B','-c',WRITER_SCRIPT,self.sock,str(self.marker),
             str(self.lock),str(self.control),self.public],
            preexec_fn=drop_to(WRITER),cwd='/',env=self.env,
            stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
        deadline=time.monotonic()+5
        while time.monotonic()<deadline:
            if self.server.poll() is not None:
                raise AssertionError('writer failed: '+self.server.stderr.read())
            if os.path.exists(self.sock) and (os.stat(self.sock).st_mode & 0o777) == 0o666:
                return
            time.sleep(0.025)
        raise AssertionError('writer socket not ready')

    def stop_writer(self):
        if self.server and self.server.poll() is None:
            self.server.terminate()
        if self.server:
            out,err=self.server.communicate(timeout=5)
            self.assertEqual(self.server.returncode,-15,err+out)
            self.server=None
        # SIGTERM does not run server_close(); clear only this disposable
        # fixture socket after the old writer has exited.
        if os.path.lexists(self.sock):
            os.unlink(self.sock)

    def tearDown(self):
        try:
            self.stop_writer()
        finally:
            self.temp.cleanup()

    def request(self,event=None,permit=None,uid=BROKER):
        payload=json.dumps({'op':'create_signed_marker',
                            'event':self.event if event is None else event,
                            'permit':self.permit if permit is None else permit})
        p=subprocess.run([sys.executable,'-B','-c',CLIENT_SCRIPT,self.sock],
            input=payload,preexec_fn=drop_to(uid),cwd='/',env=self.env,
            capture_output=True,text=True,timeout=6)
        self.assertEqual(p.returncode,0,p.stderr)
        return json.loads(p.stdout)

    def controller_hold(self):
        p=subprocess.run([sys.executable,'-B','-c',CONTROLLER_SCRIPT,
                          str(self.lock),str(self.control)],
            preexec_fn=drop_to(CONTROLLER),cwd='/',env=self.env,
            capture_output=True,text=True,timeout=6)
        self.assertEqual(p.returncode,0,p.stderr)
        return json.loads(p.stdout)

    def test_signed_write_hold_and_restart_refuse(self):
        # Forged permit fails before filesystem effects.
        forged=dict(self.permit,signature='0'*128)
        self.assertEqual(self.request(permit=forged)['code'],
                         'writer_authorization_denied')
        self.assertFalse(list(self.marker.iterdir()))
        self.assertEqual(self.request()['code'],'empty_marker_created')
        self.assertEqual(len(list(self.marker.iterdir())),1)
        self.assertEqual(self.controller_hold()['code'],'hold_recorded')
        self.assertEqual(self.request()['code'],'writer_authorization_denied')
        self.stop_writer()
        self.start_writer()
        self.assertEqual(self.request()['code'],'writer_authorization_denied')
        self.assertEqual(len(list(self.marker.iterdir())),1)

    def test_missing_snapshot_after_restart_denies(self):
        self.stop_writer()
        self.state.unlink()
        self.start_writer()
        self.assertEqual(self.request()['code'],'writer_authorization_denied')
        self.assertFalse(list(self.marker.iterdir()))

    def test_writer_cannot_rewrite_controller_authority(self):
        script='import os,sys;os.open(sys.argv[1],os.O_WRONLY)'
        p=subprocess.run([sys.executable,'-B','-c',script,str(self.state)],
            preexec_fn=drop_to(WRITER),env=self.env,cwd='/',
            capture_output=True,text=True,timeout=6)
        self.assertNotEqual(p.returncode,0)
        self.assertIn('PermissionError',p.stderr)


    def test_controller_hold_waits_for_writer_effect_fence(self):
        """A distinct-UID controller cannot commit HOLD during writer's fence."""
        script = (
            "import sys;"
            "from koru_cross_uid_fence import ProvisionedCrossUidFence;"
            "f=ProvisionedCrossUidFence(sys.argv[1],shared_gid=65531);"
            "f.__enter__();"
            "print('LOCKED',flush=True);"
            "assert sys.stdin.readline().strip()=='release';"
            "f.__exit__(None,None,None);f.close()"
        )
        holder = subprocess.Popen(
            [sys.executable,'-B','-c',script,str(self.lock)],
            preexec_fn=drop_to(WRITER),cwd='/',env=self.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        controller = None
        try:
            ready,_,_ = select.select([holder.stdout],[],[],5)
            self.assertTrue(ready,'writer never acquired fence')
            self.assertEqual(holder.stdout.readline().strip(),'LOCKED')
            controller=subprocess.Popen(
                [sys.executable,'-B','-c',CONTROLLER_SCRIPT,
                 str(self.lock),str(self.control)],
                preexec_fn=drop_to(CONTROLLER),cwd='/',env=self.env,
                stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
            time.sleep(0.25)
            self.assertIsNone(controller.poll(),
                'controller completed HOLD while writer owned the effect fence')
            self.assertFalse(json.loads(self.state.read_text())['halted'])
            holder.stdin.write('release\n')
            holder.stdin.flush()
            stdout,stderr=controller.communicate(timeout=5)
            self.assertEqual(controller.returncode,0,stderr)
            self.assertEqual(json.loads(stdout)['code'],'hold_recorded')
            self.assertEqual(self.request()['code'],'writer_authorization_denied')
        finally:
            for p in (holder,controller):
                if p is not None and p.poll() is None:
                    p.kill()
                if p is not None:
                    p.communicate(timeout=5)

    def test_existing_marker_after_restart_is_never_reported_as_new_success(self):
        self.assertEqual(self.request()['code'],'empty_marker_created')
        self.stop_writer()
        self.start_writer()
        self.assertEqual(self.request()['code'],'marker_exists_needs_reconciliation')
        self.assertEqual(len(list(self.marker.iterdir())),1)

    def test_restored_old_snapshot_demonstrates_unresolved_rollback_attack(self):
        """KNOWN VULNERABILITY: this is a witness, not a protection test.

        Controller-owned snapshot alone cannot prevent same-owner rollback.
        A root/independent monotonic authority commitment is required before
        production; a green test here means attack *exists*, not protection.
        """
        old_state=self.state.read_bytes()
        self.assertEqual(self.controller_hold()['code'],'hold_recorded')
        self.stop_writer()
        # Root here emulates a compromised controller or recovered old backup.
        # Old bytes retain correct mode/owner/group and valid old generation.
        self.state.write_bytes(old_state)
        self.assertEqual(self.state.stat().st_uid,CONTROLLER)
        self.start_writer()
        outcome=self.request()
        self.assertEqual(outcome['code'],'empty_marker_created',
            'if this changes to denial the rollback vulnerability was repaired')
        self.assertEqual(len(list(self.marker.iterdir())),1)

if __name__=='__main__':
    unittest.main()
