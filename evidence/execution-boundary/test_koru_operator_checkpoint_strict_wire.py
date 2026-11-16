"""R4 strict operator request schema, including duplicate-member negatives.

Uses the existing mTLS fixture, operator key and custodian. Raw requests
are sent through actual pinned client TLS, not a JSON parser mock.
"""
import json
import socket
import unittest

from test_koru_operator_checkpoint_mtls import OperatorMTLSTests


class OperatorCheckpointStrictWireTests(unittest.TestCase):
    def setUp(self):
        self.fixture = OperatorMTLSTests(methodName="test_remote_signed_read_is_not_effect_permission")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def send_wire(self, payload):
        f = self.fixture
        with socket.create_connection(f.service.server_address, timeout=3) as raw:
            with f.context.wrap_socket(raw, server_hostname="localhost") as tls:
                tls.settimeout(3)
                tls.sendall(payload + b"\n")
                received = bytearray()
                while b"\n" not in received:
                    piece = tls.recv(1024)
                    if not piece:
                        raise AssertionError("operator closed without reply")
                    received.extend(piece)
                return json.loads(bytes(received).split(b"\n", 1)[0])

    def test_duplicate_op_rejected_without_advancing_custody(self):
        n = "a" * 64
        raw = (b'{"op":"ignored","op":"checkpoint","nonce":"' +
               n.encode() + b'"}')
        result = self.send_wire(raw)
        self.assertEqual(result, {"ok": False, "code": "bad_request"})
        self.assertEqual(self.fixture.custody_floor.read_floor()[0], 0)

    def test_duplicate_nonce_rejected_without_advancing_custody(self):
        n = "b" * 64
        raw = (b'{"op":"checkpoint","nonce":"wrong","nonce":"' +
               n.encode() + b'"}')
        result = self.send_wire(raw)
        self.assertEqual(result, {"ok": False, "code": "bad_request"})
        self.assertEqual(self.fixture.custody_floor.read_floor()[0], 0)

    def test_nonstandard_json_constant_denied(self):
        nonce = "d" * 64
        raw = (b'{"op":"checkpoint","nonce":"' + nonce.encode() +
               b'","unexpected":NaN}')
        result = self.send_wire(raw)
        self.assertEqual(result, {"ok": False, "code": "bad_request"})
        self.assertEqual(self.fixture.custody_floor.read_floor()[0], 0)

    def test_invalid_utf8_denied(self):
        nonce = "e" * 64
        # This literal contains a genuine 0xff byte, not the ASCII
        # characters backslash, 'x', 'f', 'f'.
        raw = (b'{"op":"checkpoint","nonce":"' + nonce.encode() +
               b'","bad":"\xff"}')
        self.assertIn(bytes([0xff]), raw)
        result = self.send_wire(raw)
        self.assertEqual(result, {"ok": False, "code": "bad_request"})
        self.assertEqual(self.fixture.custody_floor.read_floor()[0], 0)

    def test_valid_checkpoint_still_succeeds(self):
        nonce = "c" * 64
        result = self.send_wire(
            (b'{"op":"checkpoint","nonce":"' + nonce.encode() + b'"}'))
        self.assertEqual(result["code"], "checkpoint_only")
        self.assertTrue(result["ok"])
        self.assertEqual(result["receipt"]["nonce"], nonce)


if __name__ == "__main__":
    unittest.main()
