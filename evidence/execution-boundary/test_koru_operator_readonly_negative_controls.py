"""Agent 3 A07: operator mTLS API refuses caller-directed history changes.

The operator read endpoint must never expose advance, reset, HOLD, or
effect operations to an authenticated application client. These are
disposable loopback regression tests, not independent hosting guarantees.
"""
import json
import socket
import ssl

from test_koru_operator_checkpoint_mtls import OperatorMTLSTests


class OperatorReadOnlyNegativeControls(OperatorMTLSTests):
    def _raw_authenticated_request(self, packet):
        """Use the test fixture's valid pinned client certificate."""
        with socket.create_connection(self.service.server_address, timeout=3) as plain:
            with self.context.wrap_socket(plain, server_hostname="localhost") as tls:
                tls.settimeout(3)
                tls.sendall(json.dumps(packet, sort_keys=True).encode("ascii") + b"\n")
                response = bytearray()
                while b"\n" not in response:
                    part = tls.recv(1024)
                    if not part:
                        raise AssertionError("operator did not return a complete response")
                    response.extend(part)
                return json.loads(bytes(response).split(b"\n", 1)[0])

    def _assert_denied_and_unchanged(self, packet):
        before = self.custody_floor.read_floor()
        response = self._raw_authenticated_request(packet)
        self.assertIs(response["ok"], False)
        self.assertIn(response["code"], ("bad_request", "operator_unavailable_or_uncertain"))
        self.assertEqual(self.custody_floor.read_floor(), before)
        self.assertEqual(self.custodian.respond("f" * 64)["revision"], before[0])

    def test_authenticated_client_cannot_advance_operator_floor(self):
        self.create_partial_commit()
        self._assert_denied_and_unchanged({
            "op": "advance", "nonce": "a" * 64,
            "revision": 1, "digest": self.a.read()["digest"]})

    def test_authenticated_client_cannot_reset_operator_floor(self):
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        self._assert_denied_and_unchanged({
            "op": "reset", "nonce": "b" * 64, "revision": 0})

    def test_authenticated_client_cannot_issue_hold_or_effect(self):
        self._assert_denied_and_unchanged({"op": "hold", "nonce": "c" * 64})
        self._assert_denied_and_unchanged({"op": "effect", "nonce": "d" * 64})

    def test_authenticated_client_cannot_request_signature_on_own_checkpoint(self):
        self.create_partial_commit()
        self._assert_denied_and_unchanged({
            "op": "checkpoint", "nonce": "e" * 64, "revision": 1,
            "digest": self.a.read()["digest"]})

    def test_bona_fide_challenge_still_returns_operator_held_floor(self):
        self.create_partial_commit()
        self.assertEqual(self.remote("e" * 64)["revision"], 0)
        self.assertEqual(self.custody_floor.read_floor()[0], 0)


if __name__ == "__main__":
    import unittest
    unittest.main()
