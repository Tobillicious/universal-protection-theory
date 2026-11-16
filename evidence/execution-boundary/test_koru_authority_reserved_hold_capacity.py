"""Disposable Linux hostile-load checks for the G3 authority-owned service.

The controller is a distinct real Linux UID. Ordinary/root-origin connections
must not occupy the controller's reserved capacity. This does not prove
liveness under host-wide exhaustion, controller compromise or DB lock stalls.
"""
import os
import socket
import sys
import time
import unittest

import test_koru_authority_owned_marker_service as base


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "requires disposable Linux cross-UID fixture")
class AuthorityReservedHoldCapacityTests(unittest.TestCase):
    def setUp(self):
        self.fixture = base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()
        self.stalled = []

    def tearDown(self):
        for sock in self.stalled:
            sock.close()
        self.fixture.tearDown()

    def stalled_peer(self):
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.settimeout(3)
        sock.connect(self.fixture.sock)
        sock.sendall(b'{"op":')
        self.stalled.append(sock)
        return sock

    def test_ordinary_connections_cannot_starve_authenticated_hold(self):
        for _ in range(8):
            self.stalled_peer()
        # Make sure the server actually acquired workers rather than merely
        # queueing connections in the kernel backlog.
        count_path = f"/proc/{self.fixture.server.pid}/task"
        deadline = time.monotonic() + 2
        while time.monotonic() < deadline:
            if len(os.listdir(count_path)) >= 9:
                break
            time.sleep(.01)
        self.assertGreaterEqual(len(os.listdir(count_path)), 9,
                                "workers were not saturated before HOLD")
        started = time.monotonic()
        result = self.fixture.ask(base.CONTROLLER, "hold")
        elapsed = time.monotonic() - started
        self.assertEqual(result["code"], "hold_recorded")
        self.assertLess(elapsed, 2.0, "HOLD exceeded bounded fixture deadline")
        self.assertTrue(base.TransactionalHoldWitness(
            str(self.fixture.db)).read()["held"])
        self.assertFalse((self.fixture.marker / "fixed.marker").exists())
        # Let ordinary timed-out workers vacate their slots before a new
        # executor probe; HOLD was already committed independently.
        for sock in self.stalled:
            sock.close()
        self.stalled.clear()
        time.sleep(1.1)
        self.assertEqual(self.fixture.ask(base.EXECUTOR, "fixed_marker")["code"],
                         "authority_denied")

    def test_slow_trickle_read_deadline_and_recovery(self):
        sock = self.stalled_peer()
        start = time.monotonic()
        for _ in range(8):
            time.sleep(.16)
            try:
                sock.sendall(b" ")
            except (BrokenPipeError, ConnectionResetError, OSError):
                break
        try:
            data = sock.recv(2048)
        except (ConnectionResetError, BrokenPipeError, OSError):
            data = b""
        elapsed = time.monotonic() - start
        self.assertLess(elapsed, 2.5)
        if data:
            self.assertIn(b"bad_request", data)
        self.assertFalse(base.TransactionalHoldWitness(
            str(self.fixture.db)).read()["held"])
        self.assertFalse((self.fixture.marker / "fixed.marker").exists())
        # A normal request must still work after an incomplete slow client.
        self.assertEqual(self.fixture.ask(base.EXECUTOR, "fixed_marker")["code"],
                         "synthetic_effect_returned")


if __name__ == "__main__":
    unittest.main()
