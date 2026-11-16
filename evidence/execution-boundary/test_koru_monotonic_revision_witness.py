"""CAS revision history and signature verification under rollback contrasts.

The test owns BOTH SQLite databases and the key, intentionally proving that
a same-host privileged adversary can rewind the 'monotonic' witness itself.
"""
import shutil
import tempfile
import unittest
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_monotonic_revision_witness import (
    MonotonicRevisionWitness, verify_receipt,
    check_snapshot_against_receipt)


class RevisionWitnessTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-monotonic-")
        self.db = str(Path(self.temp.name) / "witness.sqlite")
        self.old = str(Path(self.temp.name) / "old.sqlite")
        self.key = Ed25519PrivateKey.generate()
        self.base = dict(generation=4, held=False,
                         event_id="fixture", authority_ref="ref",
                         pending_ids=[])
        self.witness = MonotonicRevisionWitness.provision(
            self.db, self.key, self.base)
        self.initial = self.witness.read()

    def tearDown(self):
        self.temp.cleanup()

    def advance(self, snapshot):
        current = self.witness.read()
        return self.witness.advance(
            snapshot, expected_revision=current["revision"],
            expected_digest=current["digest"])

    def test_initial_signed_revision_not_effect_permit(self):
        self.assertEqual(self.initial["revision"], 0)
        self.assertEqual(
            check_snapshot_against_receipt(
                self.base, self.initial, self.key.public_key()),
            (True, "consistent_snapshot_only"))

    def test_monotonic_hold_advances_and_old_snapshot_denied(self):
        held = dict(self.base, held=True)
        response = self.advance(held)
        self.assertTrue(response["ok"])
        receipt = response["receipt"]
        self.assertEqual(receipt["revision"], 1)
        verify_receipt(receipt, self.key.public_key(), minimum_revision=1)
        self.assertEqual(check_snapshot_against_receipt(
            self.base, receipt, self.key.public_key()),
            (False, "snapshot_mismatch"))

    def test_pending_admission_requires_new_revision(self):
        pending = dict(self.base, pending_ids=["op"])
        self.assertTrue(self.advance(pending)["ok"])
        self.assertEqual(check_snapshot_against_receipt(
            self.base, self.witness.read(), self.key.public_key()),
            (False, "snapshot_mismatch"))

    def test_stale_or_duplicate_cas_rejected(self):
        held = dict(self.base, held=True)
        self.assertTrue(self.advance(held)["ok"])
        self.assertEqual(self.witness.advance(
            self.base, expected_revision=0,
            expected_digest=self.initial["digest"])["code"],
            "stale_revision")
        self.assertEqual(self.advance(held)["code"], "unchanged_snapshot")

    def test_concurrent_cas_only_one_wins(self):
        held = dict(self.base, held=True)
        pending = dict(self.base, pending_ids=["op"])
        def contender(snapshot):
            return self.witness.advance(
                snapshot, expected_revision=0,
                expected_digest=self.initial["digest"])
        with ThreadPoolExecutor(max_workers=2) as pool:
            outcomes = list(pool.map(contender, (held, pending)))
        self.assertEqual(sum(x["ok"] for x in outcomes), 1)
        self.assertEqual(self.witness.read()["revision"], 1)

    def test_forged_receipt_rejected(self):
        modified = dict(self.initial, revision=42)
        self.assertEqual(
            check_snapshot_against_receipt(
                self.base, modified, self.key.public_key()),
            (False, "receipt_invalid_or_unavailable"))

    def test_minimum_revision_rejects_old_valid_receipt(self):
        held = dict(self.base, held=True)
        self.assertTrue(self.advance(held)["ok"])
        self.assertEqual(
            check_snapshot_against_receipt(
                self.base, self.initial, self.key.public_key(),
                minimum_revision=1),
            (False, "receipt_invalid_or_unavailable"))

    def test_missing_witness_never_reprovisions(self):
        Path(self.db).unlink()
        with self.assertRaises(Exception):
            self.witness.read()
        self.assertFalse(Path(self.db).exists())

    def test_discontinuous_history_fails_closed(self):
        import sqlite3
        from contextlib import closing
        held = dict(self.base, held=True)
        self.assertTrue(self.advance(held)["ok"])
        with closing(sqlite3.connect(self.db)) as conn:
            conn.execute("UPDATE history SET previous_digest=? "
                         "WHERE revision=1", ("f" * 64,))
            conn.commit()
        with self.assertRaises(ValueError):
            self.witness.read()

    def test_local_authority_rollback_detected_if_witness_retained(self):
        held = dict(self.base, held=True)
        self.assertTrue(self.advance(held)["ok"])
        receipt = self.witness.read()
        self.assertEqual(
            check_snapshot_against_receipt(
                self.base, receipt, self.key.public_key()),
            (False, "snapshot_mismatch"))

    def test_rollback_of_witness_itself_is_unresolved_counterexample(self):
        shutil.copyfile(self.db, self.old)
        held = dict(self.base, held=True)
        self.assertTrue(self.advance(held)["ok"])
        self.assertEqual(self.witness.read()["revision"], 1)
        shutil.copyfile(self.old, self.db)
        restored = self.witness.read()
        self.assertEqual(restored["revision"], 0)
        self.assertEqual(check_snapshot_against_receipt(
            self.base, restored, self.key.public_key()),
            (True, "consistent_snapshot_only"))
        # An independently held minimum revision would detect this, but
        # such an anchor is NOT provided by a same-host SQLite fixture.

    def test_held_floor_cannot_be_cleared_by_new_revision(self):
        held = dict(self.base, held=True)
        self.assertTrue(self.advance(held)["ok"])
        before = self.witness.read()
        reset = self.advance(self.base)
        self.assertEqual(reset["code"], "protection_regression_denied")
        self.assertEqual(self.witness.read(), before)

    def test_unresolved_admission_cannot_be_erased_by_new_revision(self):
        pending = dict(self.base, pending_ids=["op-1"])
        self.assertTrue(self.advance(pending)["ok"])
        before = self.witness.read()
        self.assertEqual(
            self.advance(self.base)["code"], "protection_regression_denied")
        self.assertEqual(self.witness.read(), before)

    def test_identity_and_generation_changes_require_new_protocol(self):
        for key, value in (("generation", 5),
                           ("event_id", "other"),
                           ("authority_ref", "other")):
            changed = dict(self.base, **{key: value})
            self.assertEqual(
                self.advance(changed)["code"], "protection_regression_denied")
        self.assertEqual(self.witness.read()["revision"], 0)

    def test_cumulative_obligations_can_only_expand(self):
        first = dict(self.base, pending_ids=["op-1"])
        second = dict(self.base, pending_ids=["op-1", "op-2"])
        self.assertTrue(self.advance(first)["ok"])
        self.assertTrue(self.advance(second)["ok"])
        self.assertEqual(self.witness.read()["revision"], 2)
        self.assertEqual(
            self.advance(first)["code"], "protection_regression_denied")

    def test_mutated_snapshot_content_is_detected_at_read(self):
        import sqlite3
        from contextlib import closing
        with closing(sqlite3.connect(self.db)) as conn:
            conn.execute("UPDATE history SET snapshot_json=? WHERE revision=0",
                         ('{"held":false}',))
            conn.commit()
        with self.assertRaises(ValueError):
            self.witness.read()

    def test_valid_hash_chain_with_regressed_state_is_rejected(self):
        import sqlite3
        from contextlib import closing
        from koru_monotonic_revision_witness import _digest
        held = dict(self.base, held=True)
        self.assertTrue(self.advance(held)["ok"])
        with closing(sqlite3.connect(self.db)) as conn:
            conn.execute("INSERT INTO history VALUES (?, ?, ?, ?)",
                         (2, _digest(self.base), _digest(held),
                          __import__("json").dumps(self.base, sort_keys=True,
                            separators=(",", ":"), ensure_ascii=True)))
            conn.commit()
        with self.assertRaises(ValueError):
            self.witness.read()

    def test_missing_receipt_denied(self):
        self.assertEqual(check_snapshot_against_receipt(
            self.base, None, self.key.public_key()),
            (False, "receipt_invalid_or_unavailable"))


if __name__ == "__main__":
    unittest.main()
