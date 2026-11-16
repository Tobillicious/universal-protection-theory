"""Deliberate write-FD leak counterexample and closed-FD executor tests.

All paths are disposable. A preopened *file* descriptor is itself authority
to write; DAC checks on the pathname cannot revoke it after descriptor
transfer. Demonstrate the vulnerability explicitly, then ensure fixed
executor inherits no such descriptors. No arbitrary production effects.
"""
import os
import subprocess
import sys
import unittest

import test_koru_authority_owned_marker_service as base
from koru_no_inherited_fd_executor import launch_fixed_executor_client

PROBE = r"""
import os,sys
fd=int(sys.argv[1])
try:
    os.write(fd,b"leaked")
    print("WROTE")
except OSError:
    print("BLOCKED")
"""


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable privileged Linux fixture only")
class NoInheritedFdTests(unittest.TestCase):
    def setUp(self):
        self.fixture=base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def _probe(self,fd,*,leak):
        return subprocess.run(
            [sys.executable,"-B","-c",PROBE,str(fd)],
            preexec_fn=base.drop(base.EXECUTOR),
            close_fds=True,pass_fds=(fd,) if leak else (),
            cwd="/",env=self.fixture.env,
            capture_output=True,text=True,timeout=5)

    def test_explicit_write_descriptor_leak_bypasses_private_path_dac(self):
        marker=self.fixture.marker/"leak-only.test"
        fd=os.open(str(marker),os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o600)
        try:
            # A distinct EXECUTOR UID cannot open the private directory.
            child=self._probe(fd,leak=True)
            self.assertEqual(child.returncode,0,child.stderr)
            self.assertIn("WROTE",child.stdout)
            self.assertEqual(marker.read_bytes(),b"leaked")
            # This is a counterexample, not a security success.
        finally:
            os.close(fd)

    def test_close_fds_prevents_same_write_descriptor_leak(self):
        marker=self.fixture.marker/"closed-only.test"
        fd=os.open(str(marker),os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o600)
        try:
            child=self._probe(fd,leak=False)
            self.assertEqual(child.returncode,0,child.stderr)
            self.assertIn("BLOCKED",child.stdout)
            self.assertEqual(marker.read_bytes(),b"")
        finally:
            os.close(fd)

    def test_fixed_launcher_can_request_one_authority_owned_effect(self):
        result=launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=base.AUTH,
            authority_pid=self.fixture.server.pid)
        self.assertEqual(result["code"],"synthetic_effect_returned")
        self.assertTrue(self.fixture.marker.joinpath("fixed.marker").exists())
        second=launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=base.AUTH,
            authority_pid=self.fixture.server.pid)
        self.assertEqual(second["code"],"authority_denied")

    def test_fixed_launcher_stale_authority_uid_denies(self):
        result=launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=base.CONTROLLER,
            authority_pid=self.fixture.server.pid)
        self.assertFalse(result["ok"])
        self.assertFalse(self.fixture.marker.joinpath("fixed.marker").exists())

    def test_hold_first_denies_fixed_launcher(self):
        self.assertEqual(self.fixture.ask(base.CONTROLLER,"hold")["code"],
                         "hold_recorded")
        result=launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=base.AUTH,
            authority_pid=self.fixture.server.pid)
        self.assertEqual(result["code"],"authority_denied")
        self.assertFalse(self.fixture.marker.joinpath("fixed.marker").exists())

    def test_launcher_requires_trusted_observed_authority_pid(self):
        with self.assertRaises(ValueError):
            launch_fixed_executor_client(
                self.fixture.sock,executor_uid=base.EXECUTOR,
                authority_uid=base.AUTH)
        with self.assertRaises(ValueError):
            launch_fixed_executor_client(
                self.fixture.sock,executor_uid=base.EXECUTOR,
                authority_uid=base.AUTH,authority_pid=0)
        self.assertFalse((self.fixture.marker/"fixed.marker").exists())

    def test_wrong_authority_pid_fails_closed_before_effect(self):
        result=launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=base.AUTH,authority_pid=os.getpid())
        self.assertEqual(result["code"],"authority_unavailable_or_uncertain")
        self.assertFalse((self.fixture.marker/"fixed.marker").exists())

    def test_launcher_rejects_same_identity_or_relative_socket(self):
        with self.assertRaises(ValueError):
            launch_fixed_executor_client(
                self.fixture.sock,executor_uid=base.AUTH,
                authority_uid=base.AUTH,
            authority_pid=self.fixture.server.pid)
        with self.assertRaises(ValueError):
            launch_fixed_executor_client(
                "relative.sock",executor_uid=base.EXECUTOR,
                authority_uid=base.AUTH,
            authority_pid=self.fixture.server.pid)


if __name__=="__main__":
    unittest.main()
