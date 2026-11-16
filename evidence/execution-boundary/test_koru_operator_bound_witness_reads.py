"""Operator-bound witness readers must not be substituted per request."""
from koru_operator_checkpoint_custodian import OperatorManagedWitnessReads
from test_koru_custodian_authenticated_observation import CustodianAuthenticatedObservationTests


class BoundOperatorReadersTests(CustodianAuthenticatedObservationTests):
    def setUp(self):
        super().setUp()
        self.calls = []
        def primary():
            self.calls.append("primary")
            return self._call(self.a, {"op": "read"})
        def secondary():
            self.calls.append("secondary")
            return self._call(self.b, {"op": "read"})
        self.bound = OperatorManagedWitnessReads(self.operator, primary, secondary)

    def test_bound_service_advances_only_after_two_authenticated_reads(self):
        held = dict(self.base, held=True)
        self._advance(self.a, held)
        self._advance(self.b, held)
        observed = self.bound.observe()
        self.assertEqual(observed["revision"], 1)
        self.assertEqual(self.calls, ["primary", "secondary"])
        self.assertEqual(self.operator_floor.read_floor()[0], 1)

    def test_caller_cannot_swap_read_adapters_when_observing(self):
        with self.assertRaises(TypeError):
            self.bound.observe(lambda: {"ok": True, "code": "snapshot_only"},
                               lambda: {"ok": True, "code": "snapshot_only"})
        self.assertEqual(self.calls, [])
        self.assertEqual(self.operator_floor.read_floor()[0], 0)

    def test_duplicate_adapter_rejected_before_observation(self):
        def same():
            return self._call(self.a, {"op": "read"})
        with self.assertRaises(ValueError):
            OperatorManagedWitnessReads(self.operator, same, same)
        self.assertEqual(self.operator_floor.read_floor()[0], 0)

    def test_operator_stale_without_authenticated_agreement(self):
        self._advance(self.a, dict(self.base, held=True))
        self._advance(self.b, dict(self.base, pending_ids=["different"]))
        with self.assertRaisesRegex(PermissionError, "disagree"):
            self.bound.observe()
        self.assertEqual(self.operator_floor.read_floor()[0], 0)


if __name__ == "__main__":
    import unittest
    unittest.main()
