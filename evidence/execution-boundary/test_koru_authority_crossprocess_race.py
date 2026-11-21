"""Cross-process authority-owned effect/HOLD ordering, disposable Linux only.

Use the already-existing #551 Unix socket service and kernel UID boundary.
A test-only authority subprocess pauses AFTER acquiring its SQLite effect
transaction and BEFORE writing its one fixed marker, allowing a separate
controller UID to race a HOLD. The unmodified production research service has
NO test hooks. This adds adversarial evidence, not another permit protocol.

All effects are one synthetic file marker, not general OS confinement.
"""
import json
import os
import select
import subprocess
import sys
import threading
import time
import unittest

import test_koru_authority_owned_marker_service as base


PAUSED_AUTHORITY = r"""
import os,select,sys,time
from pathlib import Path
from koru_authority_owned_marker_service import AuthorityOwnedMarkerService
sock,db,marker=sys.argv[1:]
service=AuthorityOwnedMarkerService(
    sock,db,marker,executor_uid=65532,controller_uid=65530,
    expected={"generation":13,"event_id":"fixture","authority_ref":"ref"})
original=service.write_fixed_marker
def pause_inside_effect():
    entered=Path(marker)/"entered.test"
    release=Path(marker)/"release.test"
    entered.write_text("entered")
    deadline=time.monotonic()+4
    while not release.exists():
        if time.monotonic()>deadline:
            raise TimeoutError("unreleased test callback")
        time.sleep(.01)
    entered.unlink()
    release.unlink()
    return original()
service.write_fixed_marker=pause_inside_effect
service.timeout=.05
print("READY",flush=True)
try:
    while True:
        ready,_,_=select.select([sys.stdin],[],[],0)
        if ready and sys.stdin.readline().strip()=="stop": break
        service.handle_request()
finally:
    service.server_close()
"""


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "privileged disposable Linux test fixture only")
class CrossProcessAuthorityOrderTests(unittest.TestCase):
    def setUp(self):
        # Compose the existing full isolation fixture instead of inheriting
        # its seven ordinary tests a second time.
        self.fixture=base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def _start_paused_authority(self):
        f=self.fixture
        f.stop()
        child=subprocess.Popen(
            [sys.executable,"-B","-c",PAUSED_AUTHORITY,
             f.sock,str(f.db),str(f.marker)],
            preexec_fn=base.drop(base.AUTH),cwd="/",env=f.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        f.server=child
        ready,_,_=select.select([child.stdout],[],[],5)
        self.assertTrue(ready,"paused authority did not start")
        self.assertEqual(child.stdout.readline().strip(),"READY")

    def _client(self,uid,op):
        f=self.fixture
        return subprocess.run(
            [sys.executable,"-B","-c",base.CLIENT,f.sock,
             json.dumps({"op":op})],
            preexec_fn=base.drop(uid),cwd="/",env=f.env,
            capture_output=True,text=True,timeout=8)

    def test_effect_first_hold_ack_waits_across_real_uid_clients(self):
        self._start_paused_authority()
        f=self.fixture
        requests={}
        def exec_worker():
            requests["effect"]=self._client(base.EXECUTOR,"fixed_marker")
        def hold_worker():
            requests["hold"]=self._client(base.CONTROLLER,"hold")
        executor=threading.Thread(target=exec_worker)
        controller=threading.Thread(target=hold_worker)
        entered=f.marker/"entered.test"
        release=f.marker/"release.test"
        try:
            executor.start()
            deadline=time.monotonic()+3
            while not entered.exists() and time.monotonic()<deadline:
                time.sleep(.01)
            self.assertTrue(entered.exists(),
                            "authority never reached locked callback")
            controller.start()
            # The controller is a real separately credentialed process,
            # not merely a policy callback in the executor's thread.
            time.sleep(.15)
            self.assertTrue(controller.is_alive(),
                            "HOLD acknowledged during locked effect")
            self.assertFalse(f.marker.joinpath("fixed.marker").exists())
        finally:
            release.write_text("go")
            executor.join(5)
            if controller.ident is not None:
                controller.join(5)
        self.assertFalse(executor.is_alive())
        self.assertFalse(controller.is_alive())
        self.assertEqual(json.loads(requests["effect"].stdout)["code"],
                         "synthetic_effect_returned")
        self.assertEqual(json.loads(requests["hold"].stdout)["code"],
                         "hold_recorded")
        self.assertTrue(f.marker.joinpath("fixed.marker").exists())
        self.assertTrue(base.TransactionalHoldWitness(str(f.db)).read()["held"])
        self.assertEqual(f.ask(base.EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")

    def test_hold_first_blocks_real_executor_and_direct_filesystem_write(self):
        f=self.fixture
        self.assertEqual(f.ask(base.CONTROLLER,"hold")["code"],
                         "hold_recorded")
        self.assertEqual(f.ask(base.EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")
        attempted=subprocess.run(
            [sys.executable,"-B","-c",base.DIRECT,
             str(f.marker/"fixed.marker")],
            preexec_fn=base.drop(base.EXECUTOR),cwd="/",env=f.env,
            capture_output=True,text=True,timeout=4)
        self.assertNotEqual(attempted.returncode,0)
        self.assertFalse(f.marker.joinpath("fixed.marker").exists())

    def test_executor_cannot_issue_hold_even_with_old_valid_socket_path(self):
        f=self.fixture
        self.assertEqual(f.ask(base.EXECUTOR,"hold")["code"],
                         "peer_or_operation_denied")
        self.assertFalse(base.TransactionalHoldWitness(str(f.db)).read()["held"])

    def test_controller_cannot_issue_effect_even_before_hold(self):
        f=self.fixture
        self.assertEqual(f.ask(base.CONTROLLER,"fixed_marker")["code"],
                         "peer_or_operation_denied")
        self.assertFalse(f.marker.joinpath("fixed.marker").exists())

    def test_repeated_executor_request_fails_after_first_effect(self):
        f=self.fixture
        self.assertEqual(f.ask(base.EXECUTOR,"fixed_marker")["code"],
                         "synthetic_effect_returned")
        for _ in range(2):
            self.assertEqual(f.ask(base.EXECUTOR,"fixed_marker")["code"],
                             "authority_denied")
        self.assertEqual(len(list(f.marker.iterdir())),1)


if __name__=="__main__":
    unittest.main()
