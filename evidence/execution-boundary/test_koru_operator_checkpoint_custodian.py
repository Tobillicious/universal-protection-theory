"""Custodian cannot sign caller-proposed rollback; history-only regressions."""
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_client_revision_floor import ClientRevisionFloor
from koru_operator_checkpoint_custodian import OperatorCheckpointCustodian
from koru_operator_checkpoint_recovery import recover_with_operator_checkpoint
from test_koru_anchor_partial_recovery import OneStepRecoveryTests


class OperatorCustodyTests(OneStepRecoveryTests):
    def setUp(self):
        super().setUp()
        self.operator_key = Ed25519PrivateKey.generate()
        self.custody_floor = ClientRevisionFloor.provision(
            str(__import__("pathlib").Path(self.temp.name) / "independent-fixture.sqlite"),
            self.ka.public_key(), self.a.read())
        self.custodian = OperatorCheckpointCustodian(
            self.operator_key, self.custody_floor,
            self.ka.public_key(), self.kb.public_key())

    def reads(self):
        return (
            lambda: dict(ok=True, code="snapshot_only", receipt=self.a.read()),
            lambda: dict(ok=True, code="snapshot_only", receipt=self.b.read()))

    def reconcile(self):
        primary, secondary = self.reads()
        return recover_with_operator_checkpoint(
            anchored=self.anchored, primary_read=primary, secondary_read=secondary,
            operator_read=self.custodian.respond,
            operator_public_key=self.custodian.public_key)

    def test_custodian_signs_own_history_not_caller_checkpoint(self):
        self.create_partial_commit()
        before = self.custodian.respond("a" * 64)
        self.assertEqual(before["revision"], 0)
        with self.assertRaisesRegex(PermissionError, "differs"):
            self.reconcile()
        self.assertEqual(self.floor.read_floor()[0], 0)
        self.assertEqual(self.custody_floor.read_floor()[0], 0)

    def test_agreed_hold_observed_then_recovery_succeeds(self):
        self.create_partial_commit()
        self.assertEqual(self.custodian.observe_pair(self.a.read(), self.b.read())["revision"], 1)
        result = self.reconcile()
        self.assertEqual(result["revision"], 1)
        self.assertIs(result["authorizes_effect"], False)
        self.assertEqual(self.floor.read_floor(), self.anchor.read_floor())

    def test_rollback_witness_pair_cannot_lower_operator_floor(self):
        original_a, original_b = self.a.read(), self.b.read()
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        with self.assertRaisesRegex(PermissionError, "rollback"):
            self.custodian.observe_pair(original_a, original_b)
        self.assertEqual(self.custody_floor.read_floor()[0], 1)

    def test_operator_refuses_divergent_signed_pair(self):
        self.create_partial_commit()
        outdated = self.b.read()
        self.advance_both(dict(self.base, held=True, pending_ids=["extra"]))
        with self.assertRaisesRegex(PermissionError, "disagree"):
            self.custodian.observe_pair(self.a.read(), outdated)
        self.assertEqual(self.custody_floor.read_floor()[0], 0)

    def test_missing_operator_floor_cannot_be_reprovisioned(self):
        import os
        self.create_partial_commit()
        os.unlink(self.custody_floor.path)
        with self.assertRaises(Exception):
            self.custodian.respond("c" * 64)
        with self.assertRaises(Exception):
            self.reconcile()
        self.assertEqual(self.floor.read_floor()[0], 0)

    def test_unknown_operator_key_is_rejected(self):
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        primary, secondary = self.reads()
        with self.assertRaises(PermissionError):
            recover_with_operator_checkpoint(
                anchored=self.anchored, primary_read=primary,
                secondary_read=secondary, operator_read=self.custodian.respond,
                operator_public_key=Ed25519PrivateKey.generate().public_key())
        self.assertEqual(self.floor.read_floor()[0], 0)


if __name__ == "__main__":
    import unittest
    unittest.main()
