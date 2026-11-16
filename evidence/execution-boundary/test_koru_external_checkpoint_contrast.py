"""Independent-checkpoint *assumption* tested against local SQLite rollback.

The fixture holds the checkpoint in a separate Python object, outside the
local DB replacement. It is not a deployed external authority. A deliberate
counterexample shows that rolling back BOTH copies defeats this contrast.
"""
import shutil
import tempfile
import unittest
from pathlib import Path

from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_external_checkpoint_contrast import ExternalCheckpointContrast
from koru_transactional_hold_witness import TransactionalHoldWitness


class SeparateCheckpointFixture(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-checkpoint-")
        self.db = str(Path(self.temp.name) / "local.sqlite")
        self.saved = str(Path(self.temp.name) / "snapshot.bak")
        self.state = dict(generation=10, held=False, event_id="event",
                          authority_ref="authority")
        self.expected = {k: self.state[k] for k in
                         ("generation", "event_id", "authority_ref")}
        self.store = TransactionalHoldWitness.provision(self.db, self.state)
        self.gate = DurableEffectIntentBoundary.provision_journal(self.store)
        self.external = self.capture()
        self.contrast = ExternalCheckpointContrast(
            self.store, lambda: dict(self.external))

    def tearDown(self):
        self.temp.cleanup()

    def capture(self):
        value = self.store.read()
        return dict(value, pending_ids=self.gate.pending_operations())

    def pending(self):
        def uncertain():
            raise RuntimeError("deliberate partial effect")
        self.assertEqual(
            self.gate.enact("op-1", self.expected, lambda: True, uncertain)["code"],
            "outcome_uncertain")

    def test_consistent_unheld_snapshot_only_not_effect_grant(self):
        self.assertEqual(self.contrast.preflight(),
                         (True, "consistent_snapshot_only"))

    def test_hold_survives_local_database_restore_in_separate_checkpoint(self):
        shutil.copyfile(self.db, self.saved)
        self.store.commit_hold()
        self.external = self.capture()
        self.assertEqual(self.contrast.preflight(),
                         (False, "hold_or_unresolved_intent"))
        shutil.copyfile(self.saved, self.db)
        self.assertFalse(self.store.read()["held"])
        self.assertEqual(self.contrast.preflight(),
                         (False, "checkpoint_mismatch"))

    def test_pending_intent_survives_local_restore_in_separate_checkpoint(self):
        shutil.copyfile(self.db, self.saved)
        self.pending()
        self.external = self.capture()
        self.assertEqual(self.contrast.preflight(),
                         (False, "hold_or_unresolved_intent"))
        shutil.copyfile(self.saved, self.db)
        self.assertEqual(self.gate.pending_operations(), [])
        self.assertEqual(self.contrast.preflight(),
                         (False, "checkpoint_mismatch"))

    def test_checkpoint_unavailable_fails_closed(self):
        def unavailable():
            raise ConnectionError("fixture network partition")
        contrast = ExternalCheckpointContrast(self.store, unavailable)
        self.assertEqual(contrast.preflight(),
                         (False, "checkpoint_unavailable"))

    def test_mismatched_identity_or_generation_denies(self):
        for updates in (dict(generation=11), dict(event_id="wrong"),
                        dict(authority_ref="wrong")):
            self.external = dict(self.capture(), **updates)
            self.assertEqual(self.contrast.preflight(),
                             (False, "checkpoint_mismatch"))

    def test_missing_journal_never_reprovisions(self):
        from contextlib import closing
        with closing(self.store._connect()) as db:
            db.execute("DROP TABLE effect_intent")
        self.assertEqual(self.contrast.preflight(),
                         (False, "checkpoint_unavailable"))

    def test_malformed_external_checkpoint_denies(self):
        self.external = dict(self.external, pending_ids=["op", "op"])
        self.assertEqual(self.contrast.preflight(),
                         (False, "checkpoint_invalid"))

    def test_preflight_can_become_stale_immediately(self):
        self.assertTrue(self.contrast.preflight()[0])
        self.store.commit_hold()
        self.external = self.capture()
        self.assertFalse(self.contrast.preflight()[0])
        # The first successful check was not, and never becomes, an effect
        # permit. A remote serialization point is still required.

    def test_rollback_of_both_stores_is_unresolved_vulnerability(self):
        old_external = dict(self.external)
        shutil.copyfile(self.db, self.saved)
        self.store.commit_hold()
        self.external = self.capture()
        self.assertFalse(self.contrast.preflight()[0])
        shutil.copyfile(self.saved, self.db)
        # The attacker also rewinds the supposed external authority:
        self.external = old_external
        # This deliberately demonstrates the missing trust assumption.
        self.assertEqual(self.contrast.preflight(),
                         (True, "consistent_snapshot_only"))


if __name__ == "__main__":
    unittest.main()
