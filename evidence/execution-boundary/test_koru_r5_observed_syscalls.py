"""Unit tests for R5 research-only strace selection; no privileged effect."""
import tempfile
import unittest
from pathlib import Path

from koru_r5_observed_syscalls import summarize


class R5ObservedSyscallsTests(unittest.TestCase):
    def _trace(self, folder, seq, *, extra="", after="", include_exec=True):
        lines = []
        if include_exec:
            lines.append('execve("/usr/bin/python", ["python", "-B", "-c", "x"], []) = 0')
        lines.extend([
            'socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0) = 3',
            'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/test"}, 110) = 0',
        ])
        if extra:
            lines.extend(extra.strip().splitlines())
        lines.append('prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, {len=11}) = 0')
        if after:
            lines.extend(after.strip().splitlines())
        result = "synthetic_effect_returned" if seq == 0 else "authority_denied"
        lines.append('write(1, "{\\"code\\": \\"' + result + '\\"}\\n", 57) = 57')
        (folder / ("trace." + str(100 + seq))).write_text("\n".join(lines) + "\n")

    def test_one_connection_and_two_hold_denials(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i)
            result = summarize(root / "trace")
            self.assertEqual(len(result["children"]), 3)
            self.assertEqual(result["observed_outcome_counts"],
                             {"authority_denied": 2, "synthetic_effect_returned": 1})

    def test_closed_startup_socket_does_not_create_second_live_capability(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra="""socket(AF_UNIX, SOCK_STREAM, 0) = 4
connect(4, {sa_family=AF_UNIX, sun_path="/tmp/temporary"}, 110) = 0
close(4) = 0""")
            self.assertEqual(len(summarize(root / "trace")["children"]), 3)

    def test_annotated_successful_close_releases_temporary_socket(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra="""socket(AF_UNIX, SOCK_STREAM, 0) = 4
connect(4, {sa_family=AF_UNIX, sun_path="/tmp/temporary"}, 110) = 0
close(4<UNIX-STREAM:[12345]>) = 0""")
            self.assertEqual(len(summarize(root / "trace")["children"]), 3)

    def test_failed_close_does_not_release_temporary_socket(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra="""socket(AF_UNIX, SOCK_STREAM, 0) = 4
connect(4, {sa_family=AF_UNIX, sun_path="/tmp/temporary"}, 110) = 0
close(4) = -1 EINTR (Interrupted system call)""")
            with self.assertRaisesRegex(ValueError, "ambiguous"):
                summarize(root / "trace")

    def test_untracked_pre_fence_recvmsg_attempt_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra='recvmsg(9, {msg_iovlen=1}, 0) = -1 EAGAIN (Resource temporarily unavailable)')
            with self.assertRaisesRegex(ValueError, "pre-fence descriptor transfer"):
                summarize(root / "trace")

    def test_untracked_pre_fence_sendmsg_attempt_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra='sendmsg(9, {msg_controllen=24}, 0) = 4')
            with self.assertRaisesRegex(ValueError, "pre-fence descriptor transfer"):
                summarize(root / "trace")

    def test_untracked_pre_fence_pidfd_getfd_attempt_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra='pidfd_getfd(9, 10, 0) = 11')
            with self.assertRaisesRegex(ValueError, "pre-fence descriptor transfer"):
                summarize(root / "trace")

    def test_close_range_after_authority_connect_fails_closed(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra="close_range(3, 4294967295, 0) = 0")
            with self.assertRaisesRegex(ValueError, "pre-fence close_range"):
                summarize(root / "trace")

    def test_close_range_cloexec_after_connect_is_ambiguous(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra="close_range(3, 4294967295, CLOSE_RANGE_CLOEXEC) = 0")
            with self.assertRaisesRegex(ValueError, "pre-fence close_range"):
                summarize(root / "trace")

    def test_close_range_before_first_socket_is_not_tracked_capability(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i)
                trace = root / ("trace." + str(100 + i))
                original = trace.read_text()
                trace.write_text(original.replace(
                    "socket(AF_UNIX,",
                    "close_range(3, 4294967295, 0) = 0\n"
                    "socket(AF_UNIX,", 1))
            self.assertEqual(len(summarize(root / "trace")["children"]), 3)

    def test_untracked_pre_fence_sendmmsg_attempt_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra='sendmmsg(9, [{msg_hdr={msg_controllen=24}}], 1, 0) = 1')
            with self.assertRaisesRegex(ValueError, "pre-fence descriptor transfer"):
                summarize(root / "trace")

    def test_two_live_connections_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, extra="""socket(AF_UNIX, SOCK_STREAM, 0) = 4
connect(4, {sa_family=AF_UNIX, sun_path="/tmp/unexpected"}, 110) = 0""")
            with self.assertRaisesRegex(ValueError, "found 0"):
                summarize(root / "trace")

    def test_successful_post_fence_connection_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, after='socket(AF_UNIX, SOCK_STREAM, 0) = 5')
            with self.assertRaisesRegex(ValueError, "unexpected successful socket"):
                summarize(root / "trace")

    def test_missing_fixed_exec_segment_cannot_qualify(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            for i in range(3):
                self._trace(root, i, include_exec=False)
            with self.assertRaisesRegex(ValueError, "found 0"):
                summarize(root / "trace")


if __name__ == "__main__":
    unittest.main()
