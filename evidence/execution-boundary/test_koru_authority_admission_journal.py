"""Research-only authority admission tests; NO real effect is authorized."""
import multiprocessing
import os
import tempfile
import unittest
from pathlib import Path

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_transactional_hold_witness import TransactionalHoldWitness


def _child_admit(db, result):
    journal = AuthorityAdmissionJournal(TransactionalHoldWitness(db))
    result.put(journal.admit("first", dict(
        generation=5, event_id="event", authority_ref="authority")))


class AuthorityAdmissionTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-authority-admit-")
        self.db = str(Path(self.tmp.name) / "authority.sqlite")
        self.state = dict(generation=5, held=False,
                          event_id="event", authority_ref="authority")
        self.expected = {k: self.state[k] for k in
                         ("generation", "event_id", "authority_ref")}
        witness = TransactionalHoldWitness.provision(self.db, self.state)
        self.journal = AuthorityAdmissionJournal.provision(witness)

    def tearDown(self):
        self.tmp.cleanup()

    def test_admission_is_unresolved_record_not_effect_grant(self):
        result = self.journal.admit("one", self.expected)
        self.assertEqual(result, {"ok": True, "code": "intent_recorded_only"})
        self.assertEqual(self.journal.unresolved(), ["one"])
        self.assertNotIn("permit", result)
        self.assertNotIn("token", result)

    def test_restart_cannot_admit_while_prior_intent_unresolved(self):
        self.assertTrue(self.journal.admit("first", self.expected)["ok"])
        restarted = AuthorityAdmissionJournal(
            TransactionalHoldWitness(self.db))
        self.assertEqual(restarted.unresolved(), ["first"])
        self.assertEqual(restarted.admit("second", self.expected)["code"],
                         "authority_denied")

    def test_hold_first_refuses_future_admission(self):
        self.journal.hold()
        self.assertEqual(self.journal.admit("first", self.expected)["code"],
                         "authority_denied")
        self.assertEqual(self.journal.unresolved(), [])

    def test_hold_after_admission_commits_and_record_remains(self):
        self.assertTrue(self.journal.admit("first", self.expected)["ok"])
        self.assertTrue(self.journal.hold()["held"])
        self.assertEqual(self.journal.unresolved(), ["first"])
        self.assertEqual(self.journal.admit("second", self.expected)["code"],
                         "authority_denied")
        # Negative safety result: admission first cannot be used as
        # authorization to perform an unmediated effect after HOLD.

    def test_duplicate_identity_never_reuses_admission(self):
        self.assertTrue(self.journal.admit("first", self.expected)["ok"])
        self.assertFalse(self.journal.admit("first", self.expected)["ok"])
        self.assertEqual(self.journal.unresolved(), ["first"])

    def test_authority_unavailable_denies_and_never_regenerates(self):
        Path(self.db).unlink()
        result = self.journal.admit("first", self.expected)
        self.assertFalse(result["ok"])
        self.assertFalse(Path(self.db).exists())

    def test_cross_process_admission_and_hold_same_authority(self):
        queue = multiprocessing.Queue()
        proc = multiprocessing.Process(target=_child_admit,
                                       args=(self.db, queue))
        proc.start()
        proc.join(timeout=4)
        if proc.is_alive():
            proc.kill()
            proc.join(timeout=2)
        self.assertEqual(proc.exitcode, 0)
        try:
            self.assertTrue(queue.get(timeout=2)["ok"])
        finally:
            queue.close()
            queue.join_thread()
        self.assertEqual(self.journal.unresolved(), ["first"])
        self.assertTrue(self.journal.hold()["held"])
        self.assertEqual(self.journal.unresolved(), ["first"])

    def test_bad_expected_generation_and_identity_rejected(self):
        for altered in (dict(generation=6), dict(event_id="else"),
                        dict(authority_ref="else")):
            result = self.journal.admit("first",
                                        dict(self.expected, **altered))
            self.assertEqual(result["code"], "authority_denied")
        self.assertEqual(self.journal.unresolved(), [])

    def test_missing_admission_table_fails_closed(self):
        from contextlib import closing
        with closing(self.journal._authority._connect()) as db:
            db.execute("DROP TABLE authority_admissions")
        self.assertFalse(self.journal.admit("first", self.expected)["ok"])
        with self.assertRaises(Exception):
            self.journal.unresolved()


if __name__ == "__main__":
    unittest.main()
