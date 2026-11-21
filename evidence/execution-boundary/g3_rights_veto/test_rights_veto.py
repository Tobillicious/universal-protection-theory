"""Deny-only G3 withdrawal journal tests; no production rights are exercised."""
import os
import sqlite3
import tempfile
import unittest
from pathlib import Path
from rights_veto import RightsVetoJournal


class RightsVetoTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-rights-veto-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.path = self.root / "veto.sqlite"
        self.journal = RightsVetoJournal(self.path, initialize=True)
        self.addCleanup(self.journal.close)
        self.kw = dict(record_ref="right-1", subject="subject-1",
                       action="publish", effect_digest="a" * 64)

    def test_absent_withdrawal_is_not_authorization(self):
        outcome = self.journal.inspect(**self.kw, expected_generation=0)
        self.assertEqual(outcome["code"], "no_local_withdrawal_found_not_authorized")
        self.assertFalse(outcome["authorizes_effect"])
        self.assertFalse(outcome["authentic_consent_proved"])

    def test_withdrawal_cannot_be_undone_by_restart(self):
        result = self.journal.record_withdrawal(**self.kw, generation=1)
        self.assertTrue(result["ok"])
        self.assertEqual(self.journal.inspect(**self.kw, expected_generation=1)["code"],
                         "record_withdrawn")
        self.journal.close()
        self.journal = RightsVetoJournal(self.path)
        self.assertEqual(self.journal.inspect(**self.kw, expected_generation=1)["code"],
                         "record_withdrawn")
        self.assertEqual(self.journal._state(), 1)

    def test_stale_and_skipped_generation_are_denied(self):
        self.assertEqual(self.journal.record_withdrawal(**self.kw, generation=3)["code"],
                         "stale_or_skipped_generation")
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        self.assertEqual(self.journal.inspect(**self.kw, expected_generation=0)["code"],
                         "stale_generation")
        self.assertEqual(self.journal.record_withdrawal(**dict(self.kw,record_ref="next"),
                           generation=1)["code"], "stale_or_skipped_generation")

    def test_duplicate_withdrawal_denied(self):
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        self.assertEqual(self.journal.record_withdrawal(**self.kw, generation=2)["code"],
                         "record_already_withdrawn")
        self.assertEqual(self.journal._state(), 1)

    def test_withdrawn_reference_cannot_be_repurposed(self):
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        changed = dict(self.kw, subject="other")
        self.assertEqual(self.journal.inspect(**changed, expected_generation=1)["code"],
                         "record_withdrawn")

    def test_invalid_types_and_digest_denied(self):
        self.assertEqual(self.journal.inspect(**self.kw, expected_generation=True)["code"],
                         "invalid_query")
        self.assertEqual(self.journal.record_withdrawal(
            **dict(self.kw,effect_digest="x"),generation=1)["code"],
            "invalid_withdrawal")

    def test_missing_journal_never_restarts_as_empty(self):
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        self.journal.close()
        self.path.unlink()
        with self.assertRaises(FileNotFoundError):
            RightsVetoJournal(self.path)
        self.assertFalse(self.path.exists())

    def test_explicit_initialization_cannot_reset_history(self):
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        with self.assertRaises(FileExistsError):
            RightsVetoJournal(self.path, initialize=True)
        self.assertEqual(self.journal.inspect(**self.kw, expected_generation=1)["code"],
                         "record_withdrawn")

    def test_existing_empty_sqlite_file_cannot_be_repaired_silently(self):
        path = self.root / "empty.sqlite"
        db = sqlite3.connect(path)
        db.close()
        os.chmod(path, 0o600)
        with self.assertRaises((sqlite3.Error, RuntimeError)):
            RightsVetoJournal(path)
        self.assertTrue(path.exists())

    def test_deleted_withdrawal_row_blocks_restart(self):
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        self.journal.close()
        with sqlite3.connect(self.path) as db:
            db.execute("DELETE FROM withdrawn WHERE record_ref=?", ("right-1",))
        with self.assertRaises(RuntimeError):
            RightsVetoJournal(self.path)

    def test_deleted_withdrawal_row_blocks_live_review(self):
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        self.journal.db.execute("DELETE FROM withdrawn WHERE record_ref=?", ("right-1",))
        response = self.journal.inspect(**self.kw, expected_generation=1)
        self.assertEqual(response["code"], "journal_integrity_unknown")
        self.assertTrue(response["local_veto"])
        self.assertFalse(response["authorizes_effect"])

    def test_duplicate_or_gapped_generation_blocks_review(self):
        self.assertTrue(self.journal.record_withdrawal(**self.kw, generation=1)["ok"])
        self.assertTrue(self.journal.record_withdrawal(
            **dict(self.kw, record_ref="right-2"), generation=2)["ok"])
        self.journal.db.execute(
            "UPDATE withdrawn SET generation=1 WHERE record_ref='right-2'")
        response = self.journal.inspect(**self.kw, expected_generation=2)
        self.assertEqual(response["code"], "journal_integrity_unknown")
        self.assertTrue(response["local_veto"])

    def test_private_directory_required(self):
        outer = self.root / "unsafe"
        outer.mkdir(mode=0o755)
        with self.assertRaises(PermissionError):
            RightsVetoJournal(outer / "state.sqlite")

    def test_symlink_db_rejected(self):
        alias = self.root / "alias.sqlite"
        alias.symlink_to(self.path)
        with self.assertRaises(PermissionError):
            RightsVetoJournal(alias)

    def test_private_database_mode_and_restart(self):
        self.assertEqual(self.path.stat().st_mode & 0o077, 0)
        self.journal.close()
        self.journal = RightsVetoJournal(self.path)
        self.assertEqual(self.journal.inspect(**self.kw, expected_generation=0)["code"],
                         "no_local_withdrawal_found_not_authorized")

    def test_malformed_or_unknown_request_cannot_authorize(self):
        self.assertFalse(self.journal.inspect(
            **dict(self.kw,record_ref="unknown"),expected_generation=0)["authorizes_effect"])
        self.assertTrue(self.journal.inspect(
            **dict(self.kw,action="bad space"),expected_generation=0)["local_veto"])


if __name__ == "__main__":
    unittest.main()
