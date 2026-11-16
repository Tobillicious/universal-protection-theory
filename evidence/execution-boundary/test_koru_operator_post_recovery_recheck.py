"""Agent 3: signed operator history must remain consistent through recovery.

These are deterministic same-host race tests. They show detection of a
checkpoint advance DURING recovery, not distributed atomicity or a proof
that no operator advancement can follow the second observation.
"""
from unittest import mock
from koru_operator_checkpoint_recovery import recover_with_operator_checkpoint
from test_koru_operator_checkpoint_custodian import OperatorCustodyTests


class PostRecoveryCustodyRecheckTests(OperatorCustodyTests):
    def _run(self, operator_read=None):
        primary, secondary = self.reads()
        return recover_with_operator_checkpoint(
            anchored=self.anchored, primary_read=primary,
            secondary_read=secondary,
            operator_read=self.custodian.respond if operator_read is None else operator_read,
            operator_public_key=self.custodian.public_key)

    def test_unchanged_operator_floor_rechecked_with_distinct_nonce(self):
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        seen = []
        def read(nonce):
            seen.append(nonce)
            return self.custodian.respond(nonce)
        outcome = self._run(operator_read=read)
        self.assertEqual(outcome["revision"], 1)
        self.assertIs(outcome["authorizes_effect"], False)
        self.assertEqual(len(seen), 2)
        self.assertNotEqual(seen[0], seen[1])

    def test_operator_advancement_during_observer_repair_denies_success(self):
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        original = self.floor.accept
        def raced_accept(receipt):
            # Both witnesses move legitimately to revision two after
            # their revision-one snapshots were fetched for recovery.
            state = dict(self.base, held=True, pending_ids=["still-unresolved"])
            self.advance_both(state)
            self.custodian.observe_pair(self.a.read(), self.b.read())
            return original(receipt)
        with mock.patch.object(self.floor, "accept", side_effect=raced_accept):
            with self.assertRaisesRegex(PermissionError, "differs"):
                self._run()
        # The observer is monotone and can have advanced to the older
        # valid revision. Refusal must NOT lower it or the operator.
        self.assertEqual(self.floor.read_floor()[0], 1)
        self.assertEqual(self.custody_floor.read_floor()[0], 2)
        self.assertEqual(self.anchor.read_floor()[0], 1)

    def test_operator_outage_after_observer_repair_fails_closed(self):
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        calls = []
        def operator_read(nonce):
            calls.append(nonce)
            if len(calls) == 2:
                raise ConnectionError("operator unavailable at recheck")
            return self.custodian.respond(nonce)
        with self.assertRaises(ConnectionError):
            self._run(operator_read=operator_read)
        self.assertEqual(len(calls), 2)
        self.assertEqual(self.floor.read_floor()[0], 1)
        self.assertEqual(self.custody_floor.read_floor()[0], 1)


if __name__ == "__main__":
    import unittest
    unittest.main()
