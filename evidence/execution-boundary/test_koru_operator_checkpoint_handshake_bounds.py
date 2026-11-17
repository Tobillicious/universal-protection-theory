"""Disposable loopback TLS handshake head-of-line and bounded worker tests.

All client sockets connect to the local research fixture. No keys or network
services outside its temporary trust domain are contacted. No live effects.
"""
import socket
import threading
import time
import unittest

from test_koru_operator_checkpoint_mtls import OperatorMTLSTests


class BoundedOperatorHandshakeTests(OperatorMTLSTests):
    def test_silent_plain_tcp_clients_do_not_block_valid_tls_read(self):
        silent = []
        try:
            # Three silent clients occupy three of the four worker slots.
            for _ in range(3):
                sock = socket.create_connection(self.service.server_address,
                                                timeout=0.5)
                silent.append(sock)
            # The accept loop must remain free to admit a real TLS reader.
            # Use a signed checkpoint against the same monotonic custodian.
            started = time.monotonic()
            receipt = self.remote("a" * 64)
            self.assertEqual(receipt["nonce"], "a" * 64)
            self.assertLess(time.monotonic() - started, 0.9,
                            "TLS handshake blocked the shared accept loop")
            self.assertEqual(self.custody_floor.read_floor()[0], 0)
        finally:
            for sock in silent:
                sock.close()

    def test_authenticated_slow_drip_cannot_extend_absolute_read_deadline(self):
        # A fully authenticated client is still not entitled to occupy a
        # checkpoint worker indefinitely by writing just before idle timeout.
        with socket.create_connection(self.service.server_address, timeout=2) as plain:
            with self.context.wrap_socket(
                    plain, server_hostname="localhost") as tls:
                tls.settimeout(3)
                started = time.monotonic()
                tls.sendall(b'{"op":')
                for _ in range(8):
                    time.sleep(0.17)
                    try:
                        tls.sendall(b" ")
                    except (BrokenPipeError, ConnectionResetError, OSError):
                        break
                try:
                    reply = tls.recv(512)
                except (ConnectionResetError, OSError):
                    reply = b""
                self.assertLess(
                    time.monotonic() - started, 2.4,
                    "slow-drip client exceeded absolute checkpoint deadline")
                if reply:
                    self.assertIn(b"bad_request", reply)
        # A rejected client must not alter the operator's custody floor.
        self.assertEqual(self.custody_floor.read_floor()[0], 0)
        self.assertEqual(self.remote("e" * 64)["nonce"], "e" * 64)

    def test_many_incomplete_handshakes_keep_worker_threads_bounded(self):
        sockets = []
        before = threading.active_count()
        try:
            for _ in range(24):
                try:
                    sock = socket.create_connection(self.service.server_address,
                                                    timeout=0.15)
                    sockets.append(sock)
                except (OSError, TimeoutError):
                    continue
            # Half-open transport peers cannot generate an unbounded thread
            # per accepted connection.
            time.sleep(0.1)
            self.assertLessEqual(threading.active_count(), before + 6)
            self.assertEqual(self.custody_floor.read_floor()[0], 0)
        finally:
            for sock in sockets:
                sock.close()
        # Allow the bounded TLS timeout to return the reserved capacity.
        time.sleep(1.2)
        self.assertEqual(self.remote("b" * 64)["nonce"], "b" * 64)

    def test_no_worker_slot_negative_configuration(self):
        self.assertEqual(self.service.max_connections, 4)
        self.assertGreater(self.service.tls_handshake_timeout, 0)
        self.assertGreater(self.service.request_timeout, 0)


if __name__ == "__main__":
    unittest.main()
