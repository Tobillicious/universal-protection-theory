"""SIGKILL authority-owned fixed-effect regression (disposable Linux only).

Tests deliberately terminate the authority process at three verified stages:
  1) after admission commit, before durable started marker
  2) after started commit, before filesystem effect
  3) after fsync of fixed marker, before acknowledgement

The test-only child patches existing #551 fixture methods. Production service
gets NO fault hooks or extra operations. Crash means unknown outcome: no
success reply may be inferred, and the same operation must never silently
replay after restart. This is not a power-loss, root-rollback or fsync proof.
"""
import json
import os
import signal
import sqlite3
from contextlib import closing
import subprocess
import sys
import unittest
from pathlib import Path

import test_koru_authority_owned_marker_service as base

# Intentionally patch methods only in a disposable subprocess. No test hook
# added to the authority's normal network protocol.
FAULT = r"""
import os,select,signal,sys
from koru_authority_owned_marker_service import AuthorityOwnedMarkerService

sock,db,marker,phase=sys.argv[1:]
service=AuthorityOwnedMarkerService(
    sock,db,marker,executor_uid=65532,controller_uid=65530,
    expected={"generation":13,"event_id":"fixture","authority_ref":"ref"})

def die():
    os.kill(os.getpid(),signal.SIGKILL)

if phase=="after_admit":
    original=service.journal.admit
    def admission_then_die(*args,**kwargs):
        outcome=original(*args,**kwargs)
        if outcome.get("ok") is True:
            die()
        return outcome
    service.journal.admit=admission_then_die
elif phase=="before_effect":
    def before_effect():
        die()
    service.write_fixed_marker=before_effect
elif phase=="after_effect":
    original=service.write_fixed_marker
    def after_effect():
        result=original()
        if result.get("ok") is True:
            die()
        return result
    service.write_fixed_marker=after_effect
else:
    raise ValueError("unsupported fault location")

service.timeout=.05
print("READY",flush=True)
try:
    while True:
        readable,_,_=select.select([sys.stdin],[],[],0)
        if readable and sys.stdin.readline().strip()=="stop":break
        service.handle_request()
finally:service.server_close()
"""


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable privileged Linux-only SIGKILL tests")
class AuthorityOwnedSigkillRecoveryTests(unittest.TestCase):
    def setUp(self):
        # Reuse the exactly provisioned #551 authority/UID fixture, but do
        # not inherit its ordinary tests a second time.
        self.fixture=base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def crash_at(self,phase):
        case=self.fixture
        case.stop()
        child=subprocess.Popen(
            [sys.executable,"-B","-c",FAULT,
             case.sock,str(case.db),str(case.marker),phase],
            preexec_fn=base.drop(base.AUTH),cwd="/",env=case.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        case.server=child
        import select
        ready,_,_=select.select([child.stdout],[],[],5)
        self.assertTrue(ready,"fault authority never became ready")
        self.assertEqual(child.stdout.readline().strip(),"READY")
        command=subprocess.run(
            [sys.executable,"-B","-c",base.CLIENT,case.sock,
             json.dumps({"op":"fixed_marker"})],
            preexec_fn=base.drop(base.EXECUTOR),cwd="/",
            env=case.env,capture_output=True,text=True,timeout=5)
        # A missing response is not a success acknowledgment. Failure can
        # manifest as EOF or connection reset depending on kernel timing.
        self.assertNotIn("synthetic_effect_returned",command.stdout)
        self.assertEqual(child.wait(timeout=5),-signal.SIGKILL)
        child.communicate(timeout=3)
        case.server=None
        if os.path.lexists(case.sock):
            os.unlink(case.sock)

    def assert_restart_denied_and_hold_still_available(self,marker_expected):
        case=self.fixture
        marker=case.marker/"fixed.marker"
        self.assertEqual(marker.exists(),marker_expected)
        # Direct SQLite audit is done as fixture root, NOT by a normal
        # executor. The record is retained across the authority restart.
        with closing(sqlite3.connect(str(case.db))) as db:
            rows=db.execute(
                "SELECT operation_id,state FROM authority_admissions").fetchall()
        self.assertEqual(len(rows),1)
        self.assertEqual(rows[0][0],"single-authority-marker")
        self.assertIn(rows[0][1],("unresolved","started"))
        case.start()
        self.assertEqual(case.ask(base.EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")
        self.assertEqual(marker.exists(),marker_expected)
        self.assertEqual(case.ask(base.CONTROLLER,"hold")["code"],
                         "hold_recorded")
        self.assertEqual(case.ask(base.EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")
        self.assertEqual(marker.exists(),marker_expected)
        self.assertEqual(len(list(case.marker.iterdir())),
                         1 if marker_expected else 0)

    def test_sigkill_after_admit_before_started_denies_replay(self):
        self.crash_at("after_admit")
        self.assert_restart_denied_and_hold_still_available(False)
        with closing(sqlite3.connect(str(self.fixture.db))) as db:
            state=db.execute(
                "SELECT state FROM authority_admissions").fetchone()[0]
        self.assertEqual(state,"unresolved")

    def test_sigkill_after_started_before_effect_denies_replay(self):
        self.crash_at("before_effect")
        self.assert_restart_denied_and_hold_still_available(False)
        with closing(sqlite3.connect(str(self.fixture.db))) as db:
            state=db.execute(
                "SELECT state FROM authority_admissions").fetchone()[0]
        self.assertEqual(state,"started")

    def test_sigkill_after_fsync_before_response_never_replays(self):
        self.crash_at("after_effect")
        self.assert_restart_denied_and_hold_still_available(True)
        with closing(sqlite3.connect(str(self.fixture.db))) as db:
            state=db.execute(
                "SELECT state FROM authority_admissions").fetchone()[0]
        self.assertEqual(state,"started")


if __name__=="__main__":
    unittest.main()
