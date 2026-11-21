"""Controlled HOLD-versus-effect interleavings on disposable SQLite fixture.

Tests cooperative transaction serialization, NOT independent authority or
actual protected OS side effects.
"""
import threading
import time
import tempfile
from pathlib import Path
import unittest

from koru_transactional_hold_witness import TransactionalHoldWitness
from koru_transaction_scoped_effect import TransactionScopedEffectBoundary


class TransactionScopedEffectTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-effect-order-")
        self.initial = {"generation": 6, "held": False,
                        "event_id": "fixture", "authority_ref": "reference"}
        self.expected = {k: self.initial[k] for k in
                         ("generation", "event_id", "authority_ref")}
        self.store = TransactionalHoldWitness.provision(
            str(Path(self.tmp.name) / "state.db"), self.initial)
        self.boundary = TransactionScopedEffectBoundary(self.store)
        self.effects = []

    def tearDown(self):
        self.tmp.cleanup()

    def effect(self):
        self.effects.append("effect")
        return {"ok": True, "code": "synthetic_effect"}

    def test_pre_hold_effect_is_serialized_before_later_hold(self):
        entered = threading.Event()
        finish = threading.Event()
        results = {}

        def effect():
            entered.set()
            self.assertTrue(finish.wait(3))
            return self.effect()

        def writer():
            results["effect"] = self.boundary.enact(
                self.expected, lambda: True, effect)

        def guardian():
            results["hold"] = self.store.commit_hold()

        t = threading.Thread(target=writer)
        t.start()
        self.assertTrue(entered.wait(3))
        hold_thread = threading.Thread(target=guardian)
        hold_thread.start()
        # HOLD cannot complete before protected operation releases DB write lock.
        self.assertTrue(hold_thread.is_alive())
        self.assertFalse(self.store.path.endswith("none"))
        finish.set()
        t.join(4)
        hold_thread.join(4)
        self.assertFalse(t.is_alive())
        self.assertFalse(hold_thread.is_alive())
        self.assertTrue(results["effect"]["ok"])
        self.assertTrue(results["hold"]["held"])
        self.assertEqual(self.effects, ["effect"])

    def test_hold_first_denies_stale_effect(self):
        self.store.commit_hold()
        result = self.boundary.enact(self.expected, lambda: True, self.effect)
        self.assertEqual(result["code"], "authorization_denied")
        self.assertEqual(self.effects, [])

    def test_old_signed_read_cannot_override_new_hold(self):
        cached = self.store.read()
        self.assertFalse(cached["held"])
        self.store.commit_hold()
        # Simulated stale signed witness result is not consulted as authority.
        result = self.boundary.enact(self.expected, lambda: True, self.effect)
        self.assertFalse(result["ok"])
        self.assertEqual(self.effects, [])

    def test_local_rejection_denies_even_when_witness_unheld(self):
        result = self.boundary.enact(self.expected, lambda: False, self.effect)
        self.assertEqual(result["code"], "authorization_denied")
        self.assertEqual(self.effects, [])

    def test_effect_exception_is_uncertain_never_retried(self):
        def broken():
            self.effects.append("attempt")
            raise RuntimeError("injected effect error")
        result = self.boundary.enact(self.expected, lambda: True, broken)
        self.assertEqual(result["code"], "outcome_uncertain")
        self.assertEqual(self.effects, ["attempt"])

    def test_unavailable_witness_fails_closed(self):
        Path(self.store.path).unlink()
        result = self.boundary.enact(self.expected, lambda: True, self.effect)
        self.assertFalse(result["ok"])
        self.assertEqual(result["code"], "witness_unavailable")
        self.assertEqual(self.effects, [])

    def test_wrong_generation_or_identity_denied(self):
        for bad in (dict(self.expected, generation=7),
                    dict(self.expected, authority_ref="substitute")):
            result = self.boundary.enact(bad, lambda: True, self.effect)
            self.assertEqual(result["code"], "authorization_denied")
        self.assertEqual(self.effects, [])


if __name__ == "__main__":
    unittest.main()
