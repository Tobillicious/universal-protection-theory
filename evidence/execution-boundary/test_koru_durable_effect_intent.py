"""Disposable durable effect-intent tests including fresh-process SIGKILL.

Successful assertions are bounded to one local SQLite database, with no
external authority and no physical effect atomicity guarantee.
"""
import json
import os
import select
import signal
import subprocess
import sys
import tempfile
from contextlib import closing
import unittest
from pathlib import Path

from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transactional_hold_witness import TransactionalHoldWitness

CHILD = """
import json, pathlib, sys
from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transactional_hold_witness import TransactionalHoldWitness
db, marker = sys.argv[1:3]
store = TransactionalHoldWitness(db)
gate = DurableEffectIntentBoundary(store)
def effect():
    pathlib.Path(marker).write_text("possibly-effected")
    print("EFFECT_STARTED", flush=True)
    sys.stdin.readline()
    return {"ok": True}
out = gate.enact(
    "operation-once",
    {"generation": 3, "event_id": "event", "authority_ref": "ref"},
    lambda: True, effect)
print(json.dumps(out), flush=True)
"""


class DurableIntentTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-durable-intent-")
        self.db = str(Path(self.tmp.name) / "hold.sqlite")
        self.marker = Path(self.tmp.name) / "effect.marker"
        self.original = dict(generation=3, held=False,
                             event_id="event", authority_ref="ref")
        self.expected = {k: self.original[k] for k in
                         ("generation", "event_id", "authority_ref")}
        self.store = TransactionalHoldWitness.provision(self.db, self.original)
        self.gate = DurableEffectIntentBoundary.provision_journal(self.store)
        self.children = []

    def tearDown(self):
        try:
            for p in self.children:
                if p.poll() is None:
                    p.kill()
                p.communicate(timeout=3)
                self.assertTrue(all(f is None or f.closed
                                    for f in (p.stdin, p.stdout, p.stderr)))
        finally:
            self.tmp.cleanup()

    def mark(self):
        self.marker.write_text("finished")
        return {"ok": True, "code": "synthetic"}

    def test_success_is_recorded_and_operation_cannot_repeat(self):
        outcome = self.gate.enact("once", self.expected, lambda: True, self.mark)
        self.assertTrue(outcome["ok"])
        self.assertEqual(self.gate.pending_operations(), [])
        again = self.gate.enact("once", self.expected, lambda: True, self.mark)
        self.assertFalse(again["ok"])
        self.assertEqual(again["code"], "intent_unavailable_or_duplicate")

    def test_effect_failure_leaves_durable_pending_and_blocks_new_operation(self):
        def fails():
            self.marker.write_text("partial")
            raise RuntimeError("effect uncertain")
        result = self.gate.enact("first", self.expected, lambda: True, fails)
        self.assertEqual(result["code"], "outcome_uncertain")
        self.assertEqual(self.gate.pending_operations(), ["first"])
        restarted = DurableEffectIntentBoundary(
            TransactionalHoldWitness(self.db))
        result = restarted.enact("second", self.expected, lambda: True, self.mark)
        self.assertFalse(result["ok"])
        self.assertEqual(result["code"], "authorization_denied")
        self.assertEqual(self.marker.read_text(), "partial")

    def test_kill_after_effect_start_keeps_pending_on_fresh_restart(self):
        p = subprocess.Popen(
            [sys.executable, "-B", "-c", CHILD, self.db, str(self.marker)],
            stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True)
        self.children.append(p)
        ready, _, _ = select.select([p.stdout], [], [], 4)
        self.assertTrue(ready)
        self.assertEqual(p.stdout.readline().strip(), "EFFECT_STARTED")
        self.assertEqual(self.marker.read_text(), "possibly-effected")
        os.kill(p.pid, signal.SIGKILL)
        p.communicate(timeout=4)
        self.assertLess(p.returncode, 0)
        fresh = DurableEffectIntentBoundary(TransactionalHoldWitness(self.db))
        self.assertEqual(fresh.pending_operations(), ["operation-once"])
        attempted = fresh.enact("after-restart", self.expected,
                                lambda: True, self.mark)
        self.assertEqual(attempted["code"], "authorization_denied")
        self.assertEqual(self.marker.read_text(), "possibly-effected")

    def test_committed_hold_denies_effect_without_intent(self):
        self.store.commit_hold()
        result = self.gate.enact("once", self.expected, lambda: True, self.mark)
        self.assertEqual(result["code"], "authorization_denied")
        self.assertEqual(self.gate.pending_operations(), [])
        self.assertFalse(self.marker.exists())

    def test_missing_journal_or_missing_database_does_not_reinitialize(self):
        with closing(self.store._connect()) as db:
            db.execute("DROP TABLE effect_intent")
        result = self.gate.enact("once", self.expected, lambda: True, self.mark)
        self.assertFalse(result["ok"])
        self.assertFalse(self.marker.exists())
        Path(self.db).unlink()
        result = self.gate.enact("next", self.expected, lambda: True, self.mark)
        self.assertFalse(result["ok"])
        self.assertFalse(Path(self.db).exists())

    def test_denied_local_policy_creates_no_intent(self):
        result = self.gate.enact("once", self.expected, lambda: False, self.mark)
        self.assertEqual(result["code"], "authorization_denied")
        self.assertEqual(self.gate.pending_operations(), [])
        self.assertFalse(self.marker.exists())


if __name__ == "__main__":
    unittest.main()
