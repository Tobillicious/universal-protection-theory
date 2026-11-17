"""Offline fail-closed parser tests; no privileged operations."""
from pathlib import Path
import tempfile
import unittest
from koru_r5_kernel_denial_evidence import summarize

class KernelDenialEvidenceTests(unittest.TestCase):
    def review(self, contents):
        with tempfile.TemporaryDirectory() as root:
            for i, entry in enumerate(contents):
                (Path(root) / ('trace.' + str(i + 100))).write_text(entry)
            return summarize(Path(root) / 'trace')

    def test_three_actual_post_filter_eperm_outcomes(self):
        prefix = 'prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, {len=30}) = 0\n'
        a = prefix + 'socket(AF_UNIX, SOCK_STREAM, 0) = -1 EPERM (Operation not permitted)\n'
        b = prefix + 'connect(3, {sa_family=AF_UNIX}, 20) = -1 EPERM (Operation not permitted)\n'
        self.assertEqual(self.review([a, b, b])['status'], 'PASS')

    def test_unconfined_eperm_is_not_proof(self):
        denied = 'socket(AF_UNIX, SOCK_STREAM, 0) = -1 EPERM (Operation not permitted)\n'
        self.assertEqual(self.review([denied] * 3)['status'], 'FAIL')

    def test_successful_post_filter_socket_fails(self):
        prefix = 'prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, {len=30}) = 0\n'
        a = prefix + 'socket(AF_UNIX, SOCK_STREAM, 0) = -1 EPERM (Operation not permitted)\n'
        b = prefix + 'connect(3, {sa_family=AF_UNIX}, 20) = -1 EPERM (Operation not permitted)\n'
        c = prefix + 'socket(AF_UNIX, SOCK_STREAM, 0) = 5\n'
        self.assertEqual(self.review([a,b,b,c])['status'], 'FAIL')

    def test_missing_trace_fails(self):
        self.assertEqual(self.review([])['status'], 'FAIL')

if __name__ == '__main__':
    unittest.main()
