"""R4 race regressions: operator checkpoint signed before concurrent history growth.

Reuse the existing operator recovery fixture; no new recovery implementation,
HOLD authority, effect path, or security-check relaxation. Research only.
"""
import unittest

from test_koru_operator_checkpoint_recovery import OperatorCheckpointRecoveryTests


class OperatorCheckpointInterleavingTests(unittest.TestCase):
    def setUp(self):
        # Reuse established independent-key and journal test fixture without
        # inheriting (and needlessly rerunning) all of its test methods.
        self.fixture = OperatorCheckpointRecoveryTests(
            methodName="test_operator_challenge_signed_recovery")
        self.fixture.setUp()
        self.fixture.create_partial_commit()

    def tearDown(self):
        self.fixture.tearDown()

    def test_history_advances_after_operator_signs_before_local_reconcile(self):
        f = self.fixture
        def signed_then_advance(nonce):
            signed_at_old_floor = f.checkpoint(nonce)
            # Separate valid history update occurs after attestation and
            # before the recovering caller reads its two witnesses.
            f.advance_both(dict(f.base, held=True, pending_ids=["later"]))
            self.assertEqual(f.anchor.accept(f.a.read()), "observed_next")
            return signed_at_old_floor

        with self.assertRaises(PermissionError):
            f.reconcile(checkpoint=signed_then_advance)
        # A two-revision gap is never silently repaired or converted to
        # permission for any effect.
        self.assertEqual(f.floor.read_floor()[0], 0)
        self.assertEqual(f.anchor.read_floor()[0], 2)

    def test_witnesses_advance_after_operator_signs_anchor_still_old(self):
        f = self.fixture
        def signed_then_witness_advance(nonce):
            signed_at_old_floor = f.checkpoint(nonce)
            f.advance_both(dict(f.base, held=True, pending_ids=["later"]))
            return signed_at_old_floor

        with self.assertRaises(PermissionError):
            f.reconcile(checkpoint=signed_then_witness_advance)
        self.assertEqual(f.floor.read_floor()[0], 0)
        self.assertEqual(f.anchor.read_floor()[0], 1)


if __name__ == "__main__":
    unittest.main()
