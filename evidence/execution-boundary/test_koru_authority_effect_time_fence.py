"""Authority-mediated synthetic effects: HOLD ordering and restart denial."""
import tempfile
import threading
import time
import unittest
from pathlib import Path

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_authority_effect_time_fence import AuthorityEffectTimeFence
from koru_transactional_hold_witness import TransactionalHoldWitness


class AuthorityEffectTimeTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-effect-fence-")
        self.db = str(Path(self.tmp.name) / "authority.sqlite")
        self.marker = Path(self.tmp.name) / "effect.txt"
        self.initial = dict(generation=5, held=False,
                            event_id="event", authority_ref="ref")
        self.expected = {k: self.initial[k] for k in
                         ("generation", "event_id", "authority_ref")}
        self.store = TransactionalHoldWitness.provision(
            self.db, self.initial)
        self.journal = AuthorityAdmissionJournal.provision(self.store)
        self.fence = AuthorityEffectTimeFence(self.journal)

    def tearDown(self):
        self.tmp.cleanup()

    def admit(self):
        self.assertTrue(self.journal.admit("once", self.expected)["ok"])

    def effect(self):
        self.marker.write_text("synthetic")
        return {"ok": True}

    def run_effect(self):
        return self.fence.execute_synthetic(
            "once", self.expected, lambda: True, self.effect)

    def test_no_admission_never_effects(self):
        self.assertEqual(self.run_effect()["code"], "effect_denied")
        self.assertFalse(self.marker.exists())

    def test_admit_then_hold_before_effect_denies(self):
        self.admit()
        self.journal.hold()
        self.assertEqual(self.run_effect()["code"], "effect_denied")
        self.assertFalse(self.marker.exists())

    def test_effect_first_blocks_hold_commit_until_callback_exits(self):
        self.admit()
        entered = threading.Event()
        release = threading.Event()
        finished = threading.Event()
        hold_done = threading.Event()
        output = []
        def slow_effect():
            entered.set()
            if not release.wait(1.5):
                raise TimeoutError("test worker not released")
            self.marker.write_text("effect-first")
            return {"ok": True}
        def worker():
            output.append(self.fence.execute_synthetic(
                "once", self.expected, lambda: True, slow_effect))
            finished.set()
        def holder():
            self.journal.hold()
            hold_done.set()
        t1 = threading.Thread(target=worker)
        t2 = threading.Thread(target=holder)
        try:
            t1.start()
            self.assertTrue(entered.wait(1))
            t2.start()
            self.assertFalse(hold_done.wait(.12),
                             "HOLD acknowledged while effect lock active")
        finally:
            release.set()
            t1.join(3)
            if t2.ident is not None:
                t2.join(3)
        self.assertFalse(t1.is_alive())
        self.assertFalse(t2.is_alive())
        self.assertTrue(finished.is_set())
        self.assertTrue(hold_done.is_set())
        self.assertEqual(output[0]["code"], "synthetic_effect_returned")
        self.assertEqual(self.marker.read_text(), "effect-first")
        self.assertTrue(self.store.read()["held"])

    def test_callback_failure_keeps_unresolved_after_restart(self):
        self.admit()
        def broken():
            self.marker.write_text("partial")
            raise RuntimeError("partial effect")
        result = self.fence.execute_synthetic(
            "once", self.expected, lambda: True, broken)
        self.assertEqual(result["code"], "outcome_uncertain")
        fresh = AuthorityAdmissionJournal(TransactionalHoldWitness(self.db))
        self.assertEqual(fresh.unresolved(), ["once"])
        self.assertFalse(fresh.admit("new", self.expected)["ok"])
        self.assertEqual(self.marker.read_text(), "partial")

    def test_success_never_clears_pending_or_replays(self):
        self.admit()
        self.assertTrue(self.run_effect()["ok"])
        self.assertEqual(self.journal.unresolved(), ["once"])
        self.marker.unlink()
        self.assertFalse(self.journal.admit("new", self.expected)["ok"])
        self.assertEqual(self.run_effect()["code"], "effect_denied")
        self.assertFalse(self.marker.exists())
        self.assertEqual(self.journal.unresolved(), ["once"])

    def test_local_policy_denial_keeps_effect_untouched(self):
        self.admit()
        result = self.fence.execute_synthetic(
            "once", self.expected, lambda: False, self.effect)
        self.assertEqual(result["code"], "effect_denied")
        self.assertFalse(self.marker.exists())

    def test_missing_authority_blocks_effect(self):
        self.admit()
        Path(self.db).unlink()
        self.assertFalse(self.run_effect()["ok"])
        self.assertFalse(self.marker.exists())
        self.assertFalse(Path(self.db).exists())


if __name__ == "__main__":
    unittest.main()
