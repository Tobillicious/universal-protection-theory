"""Bounded AF_UNIX G-Mesh boundary adversarial probes.

These probes measure kernel behavior, NOT signed G-Mesh permission enforcement.
In particular, SCM_RIGHTS succeeds unless an actual receiver policy rejects it.
"""
import array
import os
import socket
import struct
import sys
import threading
import unittest


@unittest.skipUnless(sys.platform == "linux" and hasattr(socket, "SO_PEERCRED"),
                     "Linux SO_PEERCRED and AF_UNIX required")
class TestGMeshSocketBoundary(unittest.TestCase):
    def test_concurrent_peer_credentials_are_structured_and_stable(self):
        # socketpair avoids an unserviced listen backlog and bounds every worker.
        n = 12
        results = [None] * n
        start = threading.Barrier(n + 1)
        errors = []

        def worker(i):
            try:
                a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
                with a, b:
                    a.settimeout(2)
                    b.settimeout(2)
                    start.wait(timeout=12)
                    raw = a.getsockopt(socket.SOL_SOCKET, socket.SO_PEERCRED,
                                       struct.calcsize("3i"))
                    results[i] = struct.unpack("3i", raw)
            except Exception as exc:
                errors.append(str(exc))

        threads = [threading.Thread(target=worker, args=(i,))
                   for i in range(n)]
        for t in threads:
            t.start()
        start.wait(timeout=12)
        for t in threads:
            t.join(timeout=8)
        self.assertFalse(errors, errors)
        self.assertTrue(all(not t.is_alive() for t in threads))
        self.assertEqual(results, [(os.getpid(), os.getuid(), os.getgid())] * n)

    def test_unconfined_scm_rights_transfer_is_possible_negative_control(self):
        # Valid sendmsg succeeds in unconfined processes. The protected
        # receiver requires a separate tested kernel/policy restriction.
        a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
        fd = os.open("/dev/null", os.O_RDONLY | os.O_CLOEXEC)
        received = []
        try:
            self.assertEqual(a.sendmsg([b"probe"], [
                (socket.SOL_SOCKET, socket.SCM_RIGHTS,
                 array.array("i", [fd]))]), len(b"probe"))
            data, ancillary, flags, _ = b.recvmsg(
                64, socket.CMSG_SPACE(struct.calcsize("i")))
            self.assertEqual(data, b"probe")
            self.assertFalse(flags & socket.MSG_CTRUNC)
            for level, kind, payload in ancillary:
                if level == socket.SOL_SOCKET and kind == socket.SCM_RIGHTS:
                    integers = array.array("i")
                    integers.frombytes(
                        payload[:len(payload) - len(payload) % integers.itemsize])
                    received.extend(integers)
            self.assertEqual(len(received), 1)
            os.fstat(received[0])
        finally:
            for acquired in received:
                os.close(acquired)
            os.close(fd)
            a.close()
            b.close()

    def test_closed_unix_peer_cannot_receive_handoff(self):
        a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
        fd = os.open("/dev/null", os.O_RDONLY | os.O_CLOEXEC)
        try:
            b.close()
            with self.assertRaises(OSError):
                a.sendmsg([b"probe"], [
                    (socket.SOL_SOCKET, socket.SCM_RIGHTS,
                     array.array("i", [fd]))])
        finally:
            a.close()
            os.close(fd)


if __name__ == "__main__":
    unittest.main()
