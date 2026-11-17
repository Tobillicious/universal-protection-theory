"""Fail-closed R5 process-distinct receipt tests; no privileged operations."""
from pathlib import Path
import tempfile
import unittest
from koru_r5_kernel_denial_evidence import summarize

FENCE = 'prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, {len=30}) = 0\n'
SOCKET = 'socket(AF_UNIX, SOCK_STREAM, 0) = -1 EPERM (Operation not permitted)\n'
CONNECT = 'connect(3, {sa_family=AF_UNIX}, 20) = -1 EPERM (Operation not permitted)\n'

class KernelDenialEvidenceTests(unittest.TestCase):
    def review(self, contents):
        with tempfile.TemporaryDirectory() as root:
            for i, entry in enumerate(contents):
                (Path(root) / ('trace.' + str(i + 100))).write_text(entry)
            return summarize(Path(root) / 'trace')

    def test_three_distinct_actual_post_filter_denials(self):
        self.assertEqual(self.review([FENCE + SOCKET, FENCE + CONNECT, FENCE + CONNECT])['status'], 'PASS')

    def test_unconfined_eperm_is_not_proof(self):
        self.assertEqual(self.review([SOCKET, CONNECT, CONNECT])['status'], 'FAIL')

    def test_successful_post_filter_socket_fails(self):
        self.assertEqual(self.review([FENCE + SOCKET, FENCE + CONNECT, FENCE + CONNECT,
                                      FENCE + 'socket(AF_UNIX, SOCK_STREAM, 0) = 5\n'])['status'], 'FAIL')

    def test_missing_trace_fails(self):
        self.assertEqual(self.review([])['status'], 'FAIL')

    def test_aggregated_denials_in_one_child_are_not_three_proofs(self):
        self.assertEqual(self.review([FENCE + SOCKET + CONNECT + CONNECT, FENCE, FENCE])['status'], 'FAIL')

    def test_wrong_errno_fails(self):
        bad = CONNECT.replace('EPERM', 'ECONNREFUSED')
        self.assertEqual(self.review([FENCE + SOCKET, FENCE + CONNECT, FENCE + bad])['status'], 'FAIL')

    def test_double_denial_in_one_child_fails(self):
        self.assertEqual(self.review([FENCE + SOCKET + SOCKET, FENCE + CONNECT, FENCE + CONNECT])['status'], 'FAIL')

    def test_extra_fenced_process_fails(self):
        self.assertEqual(self.review([FENCE + SOCKET, FENCE + CONNECT, FENCE + CONNECT, FENCE])['status'], 'FAIL')

if __name__ == '__main__':
    unittest.main()
