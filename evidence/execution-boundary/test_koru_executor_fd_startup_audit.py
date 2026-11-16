"""End-to-end fixed-launch startup descriptor audit, real UID authority.

Contrast injected extra FD with close_fds=True fixed-launch behavior.
No protected effect may be produced by failed checks. Other injection
paths after successful startup are outside this narrow regression.
"""
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

import test_koru_authority_owned_marker_service as base
from koru_executor_fd_startup_audit import FD_AUDIT_CHILD_CODE
from koru_no_inherited_fd_executor import launch_fixed_executor_client

AUDIT_PROBE=r"""
import sys
_assert_no_ambient_fds()
print("CLEAN",flush=True)
"""


class FDInventoryProbeTests(unittest.TestCase):
    def test_clean_child_inventory_accepted(self):
        p=subprocess.run(
            [sys.executable,"-B","-c",FD_AUDIT_CHILD_CODE+"\n"+AUDIT_PROBE],
            stdin=subprocess.DEVNULL,capture_output=True,text=True,
            close_fds=True,pass_fds=(),timeout=5)
        self.assertEqual(p.returncode,0,p.stderr)
        self.assertEqual(p.stdout.strip(),"CLEAN")

    def test_deliberately_transferred_writable_fd_denied(self):
        with tempfile.TemporaryDirectory(prefix="g3-fd-inventory-") as d:
            path=Path(d)/"private-test-file"
            path.write_bytes(b"intact")
            fd=os.open(path,os.O_WRONLY|os.O_APPEND)
            try:
                p=subprocess.run(
                    [sys.executable,"-B","-c",
                     FD_AUDIT_CHILD_CODE+"\n"+AUDIT_PROBE],
                    stdin=subprocess.DEVNULL,capture_output=True,text=True,
                    close_fds=True,pass_fds=(fd,),timeout=5)
                self.assertNotEqual(p.returncode,0)
                self.assertIn("unexpected inherited descriptor",p.stderr)
                self.assertEqual(path.read_bytes(),b"intact")
            finally:
                os.close(fd)


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable privileged Linux UID fixture only")
class FullLauncherFDInventoryTests(unittest.TestCase):
    def setUp(self):
        self.fixture=base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def launch(self,authority_uid=base.AUTH):
        return launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=authority_uid,
            authority_pid=self.fixture.server.pid)

    def test_parent_open_writable_fd_not_transferred_to_real_executor(self):
        # Parent may hold a real open writer to a separate disposable file;
        # the fixed child must still start with no ambient descriptors.
        parent_path=self.fixture.root/"parent-only.test"
        fd=os.open(parent_path,os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o600)
        try:
            os.set_inheritable(fd,True)
            self.assertEqual(self.launch()["code"],"synthetic_effect_returned")
            self.assertEqual(parent_path.read_bytes(),b"")
            self.assertTrue((self.fixture.marker/"fixed.marker").exists())
        finally:
            os.close(fd)

    def test_parent_open_writable_fd_cannot_override_committed_hold(self):
        parent_path=self.fixture.root/"parent-only-held.test"
        fd=os.open(parent_path,os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o600)
        try:
            os.set_inheritable(fd,True)
            self.assertEqual(self.fixture.ask(base.CONTROLLER,"hold")["code"],
                             "hold_recorded")
            self.assertEqual(self.launch()["code"],"authority_denied")
            self.assertEqual(parent_path.read_bytes(),b"")
            self.assertFalse((self.fixture.marker/"fixed.marker").exists())
        finally:
            os.close(fd)

    def test_wrong_authority_identity_fails_closed_with_full_fence(self):
        result=self.launch(authority_uid=base.CONTROLLER)
        self.assertFalse(result["ok"])
        self.assertFalse((self.fixture.marker/"fixed.marker").exists())

    def test_replay_fails_after_single_authorized_effect(self):
        self.assertEqual(self.launch()["code"],"synthetic_effect_returned")
        self.assertEqual(self.launch()["code"],"authority_denied")
        self.assertEqual(len(list(self.fixture.marker.iterdir())),1)


if __name__=="__main__":
    unittest.main()
