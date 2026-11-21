"""Disposable cross-process signed witness tests. No production anchor."""
import json
import os
import socket
import subprocess
import sys
import unittest

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_independent_hold_anchor_gate import IndependentlyAnchoredHoldGate
from koru_signed_remote_hold_witness import SignedWitnessReader

CHILD = """
import socket, sys
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_local_hold_ack_socket import _read_frame, _send_frame
from koru_signed_remote_hold_witness import serve_witness_once, DOMAIN, _encoded

sock=socket.socket(fileno=int(sys.argv[1]))
sock.settimeout(2)
key=Ed25519PrivateKey.from_private_bytes(bytes.fromhex(sys.argv[2]))
kind=sys.argv[3]
state={'generation':2, 'held':kind=='held', 'event_id':'event',
       'authority_ref':'authority'}
try:
    if kind == 'drop':
        sys.exit(0)
    if kind == 'stale':
        query = _read_frame(sock)
        body = dict(state, domain=DOMAIN, nonce='0'*64)
        _send_frame(sock, dict(body, signature=key.sign(_encoded(body)).hex()))
    elif kind == 'forged':
        bad=Ed25519PrivateKey.generate()
        serve_witness_once(sock, private_key=bad, state=state,
                           permitted_uid=int(sys.argv[4]))
    else:
        serve_witness_once(sock, private_key=key, state=state,
                           permitted_uid=int(sys.argv[4]))
finally:
    sock.close()
"""


class LocalFloor:
    def __init__(self):
        self.state = {"generation": 2, "held": False, "event_id": "event",
                      "authority_ref": "authority"}
    def read(self):
        return dict(self.state)
    def permits(self, event, snapshot):
        return not self.state["held"] and event == self.state


@unittest.skipUnless(sys.platform == "linux" and hasattr(socket, "SO_PEERCRED"),
                     "Linux Unix peercred required")
class CrossProcessWitnessTests(unittest.TestCase):
    def setUp(self):
        self.key = Ed25519PrivateKey.generate()
        self.raw = self.key.private_bytes(
            serialization.Encoding.Raw,
            serialization.PrivateFormat.Raw,
            serialization.NoEncryption()).hex()
        self.event = {"generation": 2, "held": False, "event_id": "event",
                      "authority_ref": "authority"}

    def exchange(self, kind, *, server_uid=None, public_key=None):
        a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
        a.settimeout(0.8)
        b.settimeout(2)
        proc = subprocess.Popen(
            [sys.executable, "-B", "-c", CHILD, str(b.fileno()),
             self.raw, kind, str(os.getuid())],
            pass_fds=(b.fileno(),), stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True)
        b.close()
        try:
            reader = SignedWitnessReader(
                lambda: a, public_key or self.key.public_key(),
                expected_server_uid=os.getuid() if server_uid is None else server_uid)
            gate = IndependentlyAnchoredHoldGate(LocalFloor(), reader)
            return gate.permits(self.event, None), reader
        finally:
            a.close()
            out, err = proc.communicate(timeout=4)
            self.assertIn(proc.returncode, (0,), (kind, out, err))

    def test_signed_fresh_external_process_allows_matching_unheld(self):
        allowed, _ = self.exchange("valid")
        self.assertTrue(allowed)

    def test_external_held_witness_denies_even_with_old_local_floor(self):
        allowed, _ = self.exchange("held")
        self.assertFalse(allowed)

    def test_forged_signature_denies(self):
        allowed, _ = self.exchange("forged")
        self.assertFalse(allowed)

    def test_stale_signed_nonce_denies(self):
        allowed, _ = self.exchange("stale")
        self.assertFalse(allowed)

    def test_unavailable_process_denies(self):
        allowed, _ = self.exchange("drop")
        self.assertFalse(allowed)

    def test_unexpected_peer_uid_denies_before_query(self):
        # Client must refuse before transmitting; server then waits for EOF.
        # The disposable server exits with an error due to missing request,
        # so test the reader directly without starting it.
        a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
        try:
            reader = SignedWitnessReader(
                lambda: a, self.key.public_key(),
                expected_server_uid=os.getuid() + 1)
            with self.assertRaises(PermissionError):
                reader.read()
            b.settimeout(0.05)
            self.assertEqual(b.recv(1), b"", "no query bytes should be sent")
        finally:
            a.close()
            b.close()


if __name__ == "__main__":
    unittest.main()
