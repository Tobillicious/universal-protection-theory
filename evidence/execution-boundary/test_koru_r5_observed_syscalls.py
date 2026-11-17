"""R5 trace-reader unit regressions; no privileged Linux setup required."""
import unittest

from koru_r5_observed_syscalls import (
    CLOSE_FD, CONNECT_FD, FD_MODIFY, SOCKET_FD,
    live_connected_unix_sockets,
)


class R5ObservedSyscallsTests(unittest.TestCase):
    def test_regex_patterns_compile(self):
        self.assertIsNotNone(SOCKET_FD)
        self.assertIsNotNone(CONNECT_FD)
        self.assertIsNotNone(CLOSE_FD)
        self.assertIsNotNone(FD_MODIFY)

    def test_closed_setup_connections_are_not_live_authorities(self):
        before = [
            'socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0) = 3',
            'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/setup-a"}, 16) = 0',
            'close(3) = 0',
            'socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0) = 3',
            'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/setup-b"}, 16) = 0',
            'close(3) = 0',
            'socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0) = 3',
            'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/authority"}, 16) = 0',
        ]
        self.assertEqual(live_connected_unix_sockets(before), {3})

    def test_closed_secondary_socket_is_not_live_at_filter(self):
        # Reproduce the exact-head Linux CI diagnostic: the authority
        # connection remains, while descriptor 4 has a successful close.
        before = [
            'socket(AF_UNIX, SOCK_STREAM, 0) = 3',
            'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/authority"}, 16) = 0',
            'socket(AF_UNIX, SOCK_STREAM, 0) = 4',
            'connect(4, {sa_family=AF_UNIX, sun_path="/tmp/temporary"}, 16) = 0',
            'close(4) = 0',
        ]
        self.assertEqual(live_connected_unix_sockets(before), {3})

    def test_failed_close_does_not_authorize_single_live_socket(self):
        before = [
            'socket(AF_UNIX, SOCK_STREAM, 0) = 3',
            'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/authority"}, 16) = 0',
            'socket(AF_UNIX, SOCK_STREAM, 0) = 4',
            'connect(4, {sa_family=AF_UNIX, sun_path="/tmp/temporary"}, 16) = 0',
            'close(4) = -1 EINTR (Interrupted system call)',
        ]
        with self.assertRaisesRegex(ValueError, "ambiguous"):
            live_connected_unix_sockets(before)

    def test_two_live_connected_sockets_are_not_a_single_authority(self):
        before = [
            'socket(AF_UNIX, SOCK_STREAM, 0) = 3',
            'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/authority"}, 16) = 0',
            'socket(AF_UNIX, SOCK_STREAM, 0) = 4',
            'connect(4, {sa_family=AF_UNIX, sun_path="/tmp/other"}, 16) = 0',
        ]
        self.assertEqual(live_connected_unix_sockets(before), {3, 4})
        self.assertNotEqual(len(live_connected_unix_sockets(before)), 1)

    def test_untracked_connected_fd_refused(self):
        with self.assertRaisesRegex(ValueError, "not associated"):
            live_connected_unix_sockets([
                'connect(9, {sa_family=AF_UNIX, sun_path="/tmp/other"}, 16) = 0',
            ])

    def test_descriptor_duplication_refused(self):
        with self.assertRaisesRegex(ValueError, "ambiguous"):
            live_connected_unix_sockets([
                'socket(AF_UNIX, SOCK_STREAM, 0) = 3',
                'connect(3, {sa_family=AF_UNIX, sun_path="/tmp/authority"}, 16) = 0',
                'dup(3) = 4',
            ])


if __name__ == "__main__":
    unittest.main()
