"""Adversarial tests for a source-based fixed-effect workload contract.

The audit checks reviewed source structure, not arbitrary Python semantics.
Reductions in the audited assumptions must fail; any future expanded
workload requires a deliberate contract update and independent review.
"""
from pathlib import Path
import unittest

from koru_fixed_workload_contract import (
    ROOT, SOURCES, verify_checkout, verify_fixed_workload)


class FixedWorkloadContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.authority=(ROOT/SOURCES["authority"]).read_text()
        cls.launcher=(ROOT/SOURCES["launcher"]).read_text()

    def check_rejected(self, *, authority=None, launcher=None):
        with self.assertRaises(ValueError):
            verify_fixed_workload(
                self.authority if authority is None else authority,
                self.launcher if launcher is None else launcher)

    def test_actual_checkout_matches_narrow_contract(self):
        self.assertTrue(verify_checkout())

    def test_new_unreviewed_operation_rejected(self):
        self.check_rejected(authority=self.authority.replace(
            '{"op": "fixed_marker"}','{"op": "arbitrary_write"}'))

    def test_missing_executor_uid_gate_rejected(self):
        self.check_rejected(authority=self.authority.replace(
            "uid == self.server.executor_uid","True"))

    def test_missing_hold_authorization_rejected(self):
        self.check_rejected(authority=self.authority.replace(
            "uid == self.server.controller_uid","True"))

    def test_request_path_substitution_rejected(self):
        self.check_rejected(authority=self.authority.replace(
            'os.open("fixed.marker",','os.open("other.marker",'))

    def test_no_follow_removed_rejected(self):
        self.check_rejected(authority=self.authority.replace(
            "os.O_EXCL | os.O_NOFOLLOW | os.O_CLOEXEC",
            "os.O_EXCL | os.O_CLOEXEC"))

    def test_fd_fsync_removed_rejected(self):
        self.check_rejected(authority=self.authority.replace(
            "os.fsync(fd)","pass"))

    def test_inherited_fd_passthrough_rejected(self):
        self.check_rejected(launcher=self.launcher.replace(
            "pass_fds=()","pass_fds=(17,)"))

    def test_uid_drop_removed_rejected(self):
        self.check_rejected(launcher=self.launcher.replace(
            "os.setuid(executor_uid)","pass"))

    def test_landlock_install_removed_rejected(self):
        self.check_rejected(launcher=self.launcher.replace(
            "_install_write_deny_landlock()","pass"))

    def test_seccomp_install_removed_rejected(self):
        self.check_rejected(launcher=self.launcher.replace(
            "_deny_fd_receive_syscalls(deny_new_connections=True)","pass"))

    def test_preflight_fd_audit_removed_rejected(self):
        self.check_rejected(launcher=self.launcher.replace(
            "_assert_no_ambient_fds()","pass"))

    def test_authority_socket_identity_check_removed_rejected(self):
        self.check_rejected(launcher=self.launcher.replace(
            "socket.SO_PEERCRED","socket.SO_TYPE"))


if __name__=="__main__":
    unittest.main()
