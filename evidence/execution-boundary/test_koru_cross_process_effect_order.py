"""True separate-interpreter HOLD/effect interleaving regression.

Research-only disposable local SQLite and marker files; no live effects.
The SIGKILL case intentionally demonstrates that a partially performed OS
effect can outlive the database transaction. It is NOT a durability guarantee.
"""
import json
import os
import select
import signal
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

from koru_transactional_hold_witness import TransactionalHoldWitness

CHILD = """
import json, pathlib, sys
from koru_transactional_hold_witness import TransactionalHoldWitness
from koru_transaction_scoped_effect import TransactionScopedEffectBoundary
path, action, marker = sys.argv[1:4]
store = TransactionalHoldWitness(path)
if action == "hold":
    state = store.commit_hold()
    print(json.dumps(state), flush=True)
elif action == "effect":
    expected = {"generation": 8, "event_id": "fixture", "authority_ref": "authority"}
    def effect():
        pathlib.Path(marker).write_text("effect-started")
        print("INSIDE_EFFECT", flush=True)
        reply = sys.stdin.readline()
        if reply != "release\\n":
            raise RuntimeError("interrupted before release")
        pathlib.Path(marker).write_text("effect-complete")
        return {"ok": True, "code": "synthetic"}
    result = TransactionScopedEffectBoundary(store).enact(
        expected, lambda: True, effect)
    print(json.dumps(result), flush=True)
"""


class CrossProcessOrderingTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-real-process-order-")
        self.db = str(Path(self.tmp.name) / "state.sqlite")
        self.marker = str(Path(self.tmp.name) / "effect.marker")
        self.initial = {"generation": 8, "held": False,
                        "event_id": "fixture", "authority_ref": "authority"}
        self.store = TransactionalHoldWitness.provision(self.db, self.initial)
        self.children = []

    def tearDown(self):
        try:
            for p in self.children:
                if p.poll() is None:
                    p.kill()
                # wait() does not close Popen PIPE handles. Always collect and
                # close them, including on SIGKILL and already-exited children.
                p.communicate(timeout=3)
                for pipe in (p.stdin, p.stdout, p.stderr):
                    if pipe is not None:
                        self.assertTrue(pipe.closed,
                                        "subprocess pipe leaked after teardown")
        finally:
            self.tmp.cleanup()

    def start(self, mode):
        p = subprocess.Popen(
            [sys.executable, "-B", "-c", CHILD, self.db, mode, self.marker],
            stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True, bufsize=1)
        self.children.append(p)
        return p

    def output_line(self, proc, timeout=4):
        ready, _, _ = select.select([proc.stdout], [], [], timeout)
        self.assertTrue(ready, "child did not produce bounded handshake")
        line = proc.stdout.readline().strip()
        self.assertTrue(line, "empty child handshake")
        return line

    def finish(self, proc):
        out, err = proc.communicate(timeout=5)
        self.assertEqual(proc.returncode, 0, err)
        return out

    def test_effect_first_prevents_cross_process_hold_commit_until_release(self):
        writer = self.start("effect")
        self.assertEqual(self.output_line(writer), "INSIDE_EFFECT")
        holder = self.start("hold")
        # If HOLD completed, stdout would become readable. A bounded poll is
        # used only as an interleaving assertion, not as proof of starvation
        # freedom or complete scheduling coverage.
        ready, _, _ = select.select([holder.stdout], [], [], 0.15)
        self.assertFalse(ready, "HOLD committed during effect")
        self.assertIsNone(holder.poll())
        writer.stdin.write("release\n")
        writer.stdin.flush()
        result = json.loads(self.output_line(writer))
        self.assertTrue(result["ok"])
        held = json.loads(self.output_line(holder))
        self.assertTrue(held["held"])
        self.assertEqual(held["generation"], 9)
        self.finish(writer)
        self.finish(holder)
        self.assertEqual(Path(self.marker).read_text(), "effect-complete")

    def test_cross_process_hold_first_denies_effect_without_writing(self):
        holder = self.start("hold")
        self.assertTrue(json.loads(self.output_line(holder))["held"])
        self.finish(holder)
        writer = self.start("effect")
        result = json.loads(self.output_line(writer))
        self.assertEqual(result["code"], "authorization_denied")
        self.finish(writer)
        self.assertFalse(Path(self.marker).exists())

    def test_sigkill_releases_lock_but_partial_effect_remains_uncertain(self):
        writer = self.start("effect")
        self.assertEqual(self.output_line(writer), "INSIDE_EFFECT")
        self.assertEqual(Path(self.marker).read_text(), "effect-started")
        os.kill(writer.pid, signal.SIGKILL)
        writer.communicate(timeout=4)
        self.assertLess(writer.returncode, 0, "SIGKILL must terminate writer")
        self.assertTrue(all(pipe.closed for pipe in
                            (writer.stdin, writer.stdout, writer.stderr)))
        holder = self.start("hold")
        held = json.loads(self.output_line(holder))
        self.assertTrue(held["held"])
        self.finish(holder)
        # Mandatory negative: DB transaction cannot undo an OS write already
        # performed before SIGKILL.
        self.assertEqual(Path(self.marker).read_text(), "effect-started")
        self.assertTrue(self.store.read()["held"])

    def test_unavailable_store_prevents_cross_process_effect(self):
        Path(self.db).unlink()
        writer = self.start("effect")
        result = json.loads(self.output_line(writer))
        self.assertEqual(result["code"], "witness_unavailable")
        self.finish(writer)
        self.assertFalse(Path(self.marker).exists())


if __name__ == "__main__":
    unittest.main()
