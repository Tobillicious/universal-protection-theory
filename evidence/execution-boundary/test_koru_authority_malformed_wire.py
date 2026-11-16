"""Disposable Linux: malformed and unauthorized wire requests fail closed.

Uses the actual authority-owned Unix socket service with real separate UIDs.
No source mocks, no production-effect outputs, no changed service implementation.
The only effect under test is the fixed synthetic marker in a temporary tree.
"""
import json
import os
import subprocess
import sys
import unittest

import test_koru_authority_owned_marker_service as base

RAW_CLIENT = r"""
import socket,sys
path,payload=sys.argv[1],bytes.fromhex(sys.argv[2])
with socket.socket(socket.AF_UNIX,socket.SOCK_STREAM) as sock:
    sock.settimeout(3)
    sock.connect(path)
    sock.sendall(payload)
    sock.shutdown(socket.SHUT_WR)
    response=bytearray()
    while not response.endswith(b"\n"):
        part=sock.recv(1024)
        if not part or len(response)>2048:
            break
        response.extend(part)
sys.stdout.buffer.write(response)
"""


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "requires disposable root-launched Linux cross-UID fixture")
class AuthorityMalformedWireTests(unittest.TestCase):
    def setUp(self):
        self.fixture = base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def send(self, uid, payload):
        f = self.fixture
        proc = subprocess.run(
            [sys.executable, "-B", "-c", RAW_CLIENT, f.sock, payload.hex()],
            preexec_fn=base.drop(uid),
            env=f.env, cwd="/", capture_output=True, timeout=6)
        self.assertEqual(proc.returncode, 0, proc.stderr.decode(errors="replace"))
        return json.loads(proc.stdout)

    def assert_untouched(self):
        f = self.fixture
        self.assertFalse((f.marker / "fixed.marker").exists())
        self.assertEqual(f.ask(base.REQUESTER, "fixed_marker")["code"],
                         "peer_or_operation_denied")
        self.assertEqual(base.AuthorityAdmissionJournal(
            base.TransactionalHoldWitness(str(f.db))).unresolved(), [])
        self.assertFalse(base.TransactionalHoldWitness(str(f.db)).read()["held"])

    def test_unterminated_fixed_request_denied(self):
        reply = self.send(base.EXECUTOR, b'{"op":"fixed_marker"}')
        self.assertEqual(reply["code"], "bad_request")
        self.assertFalse(reply["ok"])
        self.assert_untouched()

    def test_oversized_fixed_request_denied(self):
        payload = b'{"op":"fixed_marker","padding":"' + (b"a" * 520) + b'"}\n'
        reply = self.send(base.EXECUTOR, payload)
        self.assertEqual(reply["code"], "bad_request")
        self.assert_untouched()

    def test_invalid_json_denied(self):
        reply = self.send(base.EXECUTOR, b'{"op":\n')
        self.assertEqual(reply["code"], "authority_unavailable_or_uncertain")
        self.assertFalse(reply["ok"])
        self.assert_untouched()

    def test_nonobject_json_denied(self):
        for payload in (b'null\n', b'[]\n', b'42\n', b'true\n'):
            with self.subTest(payload=payload):
                reply = self.send(base.EXECUTOR, payload)
                self.assertEqual(reply["code"], "peer_or_operation_denied")
                self.assertFalse(reply["ok"])
        self.assert_untouched()

    def test_extra_request_fields_denied(self):
        reply = self.send(base.EXECUTOR,
                          b'{"op":"fixed_marker","path":"other.marker"}\n')
        self.assertEqual(reply["code"], "peer_or_operation_denied")
        self.assert_untouched()

    def test_malformed_controller_request_never_commits_hold(self):
        reply = self.send(base.CONTROLLER, b'{"op":"hold","extra":true}\n')
        self.assertEqual(reply["code"], "peer_or_operation_denied")
        self.assertFalse(reply["ok"])
        self.assert_untouched()

    def test_unprivileged_hold_attempt_does_not_commit(self):
        reply = self.send(base.EXECUTOR, b'{"op":"hold"}\n')
        self.assertEqual(reply["code"], "peer_or_operation_denied")
        self.assertFalse(base.TransactionalHoldWitness(
            str(self.fixture.db)).read()["held"])
        self.assert_untouched()

    def test_malformed_followed_by_real_hold_remains_effect_denied(self):
        self.send(base.EXECUTOR, b'{"op":\n')
        self.assertEqual(self.fixture.ask(base.CONTROLLER, "hold")["code"],
                         "hold_recorded")
        self.assertEqual(self.fixture.ask(base.EXECUTOR, "fixed_marker")["code"],
                         "authority_denied")
        self.assertTrue(base.TransactionalHoldWitness(
            str(self.fixture.db)).read()["held"])
        self.assertFalse((self.fixture.marker / "fixed.marker").exists())


if __name__ == "__main__":
    unittest.main()
