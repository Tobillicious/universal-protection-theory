"""Fail-closed target-distinct strace receipt tests; synthetic traces only."""
from pathlib import Path
import tempfile
import unittest
from koru_r5_kernel_denial_evidence import summarize

FENCE = 'prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, {len=30}) = 0\n'
SOCKET = 'socket(AF_UNIX, SOCK_STREAM, 0) = -1 EPERM (Operation not permitted)\n'
PATH = 'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/g3-fake-authority-never-created"}, 110) = -1 EPERM (Operation not permitted)\n'
ABSTRACT = 'connect(3, {sa_family=AF_UNIX, sun_path=@"g3-r5-abstract-alternate"}, 27) = -1 EPERM (Operation not permitted)\n'

class KernelDenialEvidenceTests(unittest.TestCase):
    def review(self, contents):
        with tempfile.TemporaryDirectory() as root:
            for i, entry in enumerate(contents):
                (Path(root) / ('trace.' + str(i+100))).write_text(entry)
            return summarize(Path(root) / 'trace')

    def test_three_distinct_denials_and_targets(self):
        self.assertEqual(self.review([FENCE+SOCKET,FENCE+PATH,FENCE+ABSTRACT])['status'],'PASS')

    def test_no_unconfined_denials(self):
        self.assertEqual(self.review([SOCKET,PATH,ABSTRACT])['status'],'FAIL')

    def test_repeated_path_cannot_substitute_abstract(self):
        self.assertEqual(self.review([FENCE+SOCKET,FENCE+PATH,FENCE+PATH])['status'],'FAIL')

    def test_repeated_abstract_cannot_substitute_path(self):
        self.assertEqual(self.review([FENCE+SOCKET,FENCE+ABSTRACT,FENCE+ABSTRACT])['status'],'FAIL')

    def test_concentrated_counts_cannot_substitute_children(self):
        self.assertEqual(self.review([FENCE+SOCKET+PATH+ABSTRACT,FENCE,FENCE])['status'],'FAIL')

    def test_successful_post_fence_operation_rejected(self):
        self.assertEqual(self.review([FENCE+SOCKET,FENCE+PATH,FENCE+ABSTRACT+'socket(AF_UNIX, SOCK_STREAM, 0) = 5\n'])['status'],'FAIL')

    def test_wrong_errno_rejected(self):
        self.assertEqual(self.review([FENCE+SOCKET,FENCE+PATH,FENCE+ABSTRACT.replace('EPERM','ECONNREFUSED')])['status'],'FAIL')

    def test_socket_wrong_family_rejected(self):
        self.assertEqual(self.review([FENCE+SOCKET.replace('AF_UNIX','AF_INET'),FENCE+PATH,FENCE+ABSTRACT])['status'],'FAIL')

    def test_missing_traces(self):
        self.assertEqual(self.review([])['status'],'FAIL')

    def test_extra_fenced_child(self):
        self.assertEqual(self.review([FENCE+SOCKET,FENCE+PATH,FENCE+ABSTRACT,FENCE])['status'],'FAIL')

    def test_duplicate_seccomp_install(self):
        self.assertEqual(self.review([FENCE+SOCKET+FENCE,FENCE+PATH,FENCE+ABSTRACT])['status'],'FAIL')

    def test_strace_escaped_abstract_path(self):
        escaped='connect(3, {sa_family=AF_UNIX, sun_path="\\0g3-r5-abstract-alternate"}, 27) = -1 EPERM (Operation not permitted)\n'
        self.assertEqual(self.review([FENCE+SOCKET,FENCE+PATH,FENCE+escaped])['status'],'PASS')

if __name__ == '__main__':
    unittest.main()
