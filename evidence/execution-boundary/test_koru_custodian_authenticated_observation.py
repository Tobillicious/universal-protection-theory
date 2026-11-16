"""Agent 3 custodian obtains signed revisions from its own pinned TLS readers.

All services are on one disposable CI host. This proves transport wiring
and monotone observation only, not independent administration.
"""
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_client_revision_floor import ClientRevisionFloor
from koru_operator_checkpoint_custodian import OperatorCheckpointCustodian
from test_koru_dual_mtls_endpoints import TwoLiveMTLSEndpointTests


class CustodianAuthenticatedObservationTests(TwoLiveMTLSEndpointTests):
    def setUp(self):
        super().setUp()
        self.operator_floor = ClientRevisionFloor.provision(
            str(self.root / "operator-retained.sqlite"), self.a["public"],
            self.a["witness"].read())
        self.operator = OperatorCheckpointCustodian(
            Ed25519PrivateKey.generate(), self.operator_floor,
            self.a["public"], self.b["public"])

    def observe_operator(self, *, secondary=None):
        def primary():
            return self._call(self.a, {"op": "read"})
        def second():
            return self._call(self.b, {"op": "read"})
        return self.operator.observe_authenticated_witnesses(
            primary, second if secondary is None else secondary)

    def test_two_pinned_reads_advance_operator_floor(self):
        held = dict(self.base, held=True)
        self._advance(self.a, held)
        self._advance(self.b, held)
        record = self.observe_operator()
        self.assertEqual(record["revision"], 1)
        self.assertEqual(self.operator_floor.read_floor()[0], 1)
        self.assertEqual(self.operator.respond("a" * 64)["revision"], 1)

    def test_divergent_signed_reads_refuse_floor_advance(self):
        self._advance(self.a, dict(self.base, held=True))
        self._advance(self.b, dict(self.base, pending_ids=["pending"]))
        with self.assertRaisesRegex(PermissionError, "disagree"):
            self.observe_operator()
        self.assertEqual(self.operator_floor.read_floor()[0], 0)

    def test_secondary_outage_refuses_floor_advance(self):
        def lost():
            raise ConnectionError("secondary witness unavailable")
        self._advance(self.a, dict(self.base, held=True))
        with self.assertRaises(ConnectionError):
            self.observe_operator(secondary=lost)
        self.assertEqual(self.operator_floor.read_floor()[0], 0)

    def test_caller_cannot_supply_unsigned_latest_state(self):
        self._advance(self.a, dict(self.base, held=True))
        forged = lambda: {"ok": True, "code": "snapshot_only",
                          "receipt": {"revision": 1, "digest": "0" * 64}}
        with self.assertRaises((ValueError, PermissionError)):
            self.observe_operator(secondary=forged)
        self.assertEqual(self.operator_floor.read_floor()[0], 0)

    def test_absent_operator_floor_refuses_authenticated_read(self):
        import os
        os.unlink(self.operator_floor.path)
        with self.assertRaises(Exception):
            self.observe_operator()
        self.assertFalse(os.path.exists(self.operator_floor.path))


if __name__ == "__main__":
    import unittest
    unittest.main()
