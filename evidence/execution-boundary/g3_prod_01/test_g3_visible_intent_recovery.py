"""G3: visible-but-unreconciled INTENT must block unrelated effects.

These tests exercise the crash window where a final pathname may exist but
the journal did not reach COMMITTED. They do not simulate a real power cut.
"""
import hashlib
import tempfile
import unittest
from pathlib import Path
from g3_monitor import Store


class VisibleIntentRecoveryTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-visible-intent-")
        self.root = Path(self.tmp.name)
        self.output = self.root / "out"
        self.output.mkdir(mode=0o700)
        self.store = Store(str(self.root / "writer.sqlite"), self.output)
        self.epoch = self.store.arm()["epoch"]

    def tearDown(self):
        self.store.close()
        self.tmp.cleanup()

    def effect(self, name, html="safe"):
        return {"op": "write", "id": name, "html": html,
                "epoch": self.epoch}

    def test_visible_intent_blocks_unrelated_new_publication(self):
        self.assertEqual(self.store.write(self.effect("first"))["code"],
                         "committed")
        # Model the fsync/journal uncertainty window after an output exists.
        self.store.db.execute(
            "UPDATE effect SET state='INTENT' WHERE id='first'")
        self.assertEqual(len(list(self.output.glob("*.html"))), 1)
        snapshot = {p.name: p.read_bytes() for p in self.output.iterdir()}
        inventory = self.store.inventory()
        self.assertTrue(inventory["ok"])
        self.assertIn("first", inventory["pending"])
        self.assertEqual(inventory["committed"], 0)
        self.assertEqual(
            self.store.write(self.effect("second"))["code"],
            "unresolved_previous_effect")
        self.assertEqual(self.store.db.execute(
            "SELECT COUNT(*) FROM effect").fetchone()[0], 1)
        self.assertEqual({p.name: p.read_bytes()
                          for p in self.output.iterdir()}, snapshot)

    def test_same_identity_can_reconcile_only_while_authorized(self):
        self.assertEqual(self.store.write(self.effect("first"))["code"],
                         "committed")
        self.store.db.execute(
            "UPDATE effect SET state='INTENT' WHERE id='first'")
        self.assertEqual(
            self.store.write(self.effect("first"))["code"], "committed")
        self.assertEqual(self.store.inventory()["pending"], [])
        self.assertEqual(self.store.inventory()["committed"], 1)
        self.assertEqual(len(list(self.output.glob("*.html"))), 1)

    def test_hold_disallows_reconciling_visible_intent(self):
        self.assertEqual(self.store.write(self.effect("first"))["code"],
                         "committed")
        self.store.db.execute(
            "UPDATE effect SET state='INTENT' WHERE id='first'")
        self.store.hold()
        self.assertEqual(
            self.store.write(self.effect("first"))["code"],
            "stale_or_halted")
        self.assertEqual(self.store.db.execute(
            "SELECT state FROM effect WHERE id='first'").fetchone(),
            ("INTENT",))
        self.assertIn("first", self.store.inventory()["pending"])

    def test_unknown_journal_state_fails_closed(self):
        self.assertEqual(self.store.write(self.effect("first"))["code"],
                         "committed")
        self.store.db.execute(
            "UPDATE effect SET state='UNRECOGNIZED' WHERE id='first'")
        self.assertEqual(self.store.inventory()["code"], "integrity_failure")
        self.assertEqual(self.store.write(self.effect("second"))["code"],
                         "integrity_failure")


if __name__ == "__main__":
    unittest.main()
