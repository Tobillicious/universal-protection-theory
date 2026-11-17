"""Disposable restart and corruption checks for legacy generation-fenced target.

Linux fixture substitutes os.fsync for macOS F_FULLFSYNC. It does not
exercise sandbox-exec or prove privileged rollback resistance.
"""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time
import unittest

from common import mac, rpc, token

HERE = Path(__file__).resolve().parent
TARGET = HERE / "target.py"
SHIM = """
import os,runpy,sys
sys.path.insert(0, sys.argv[1])
import common
def test_only_fullsync(fh):
    fh.flush()
    os.fsync(fh.fileno())
common.fullsync = test_only_fullsync
script,run,role = sys.argv[2:]
sys.argv = [script,run,role]
runpy.run_path(script,run_name="__main__")
"""


@unittest.skipUnless(sys.platform == "linux", "Linux disposable fsync fixture")
class AuthenticatedTargetRestartTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="v43-target-restart-")
        self.addCleanup(self.temp.cleanup)
        self.run = Path(self.temp.name)
        self.key = os.urandom(32)
        (self.run / "key.bin").write_bytes(self.key)
        (self.run / "key.bin").chmod(0o600)
        self.processes = []
        self.addCleanup(self.stop_all)

    def stop_all(self):
        for process in self.processes:
            if process.poll() is None:
                process.terminate()
            try:
                process.communicate(timeout=4)
            except subprocess.TimeoutExpired:
                process.kill()
                process.communicate(timeout=4)

    def start(self, role):
        proc = subprocess.Popen(
            [sys.executable, "-B", "-c", SHIM, str(HERE),
             str(TARGET), str(self.run), role],
            cwd=str(HERE), stdin=subprocess.DEVNULL,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            text=True)
        self.processes.append(proc)
        sock = str(self.run / (role + ".sock"))
        deadline = time.monotonic() + 5
        while time.monotonic() < deadline and proc.poll() is None:
            try:
                response = rpc(sock, {"op": "read"}, timeout=0.3)
                if response.get("ok") is True:
                    return proc
            except (OSError, ValueError):
                pass
            time.sleep(.02)
        proc.wait(timeout=3)
        raise AssertionError("target did not start: " + proc.stderr.read()[-700:])

    def stop(self, proc):
        proc.terminate()
        proc.communicate(timeout=5)

    def test_generation_floor_and_rows_survive_restart(self):
        original = self.start("journal")
        path = str(self.run / "journal.sock")
        initial = {"op": "write", "rid": "r1", "gen": 1,
                   "token": token(self.key, "r1", 1),
                   "seq": 0, "x": 7}
        self.assertTrue(rpc(path, initial)["ok"])
        self.assertTrue(rpc(path, {
            "op": "floor", "g": 3, "auth": mac(self.key, "floor|3")})["ok"])
        self.stop(original)

        newer = self.start("journal")
        response = rpc(path, {"op": "read"})
        self.assertEqual(response["floor"], 3)
        self.assertEqual(len(response["rows"]), 1)
        stale = dict(initial, seq=1)
        self.assertEqual(rpc(path, stale)["why"], "fenced")
        valid = dict(initial, gen=3, seq=1,
                     token=token(self.key, "r1", 3))
        self.assertTrue(rpc(path, valid)["ok"])
        self.assertEqual(len(rpc(path, {"op": "read"})["rows"]), 2)
        self.stop(newer)

    def test_sink_effect_id_remains_idempotent_across_restart(self):
        original = self.start("sink")
        path = str(self.run / "sink.sock")
        write = {"op": "write", "rid": "r1", "gen": 1,
                 "token": token(self.key, "r1", 1),
                 "id": 7, "value": 42}
        self.assertTrue(rpc(path, write)["ok"])
        self.stop(original)

        newer = self.start("sink")
        duplicated = rpc(path, write)
        self.assertTrue(duplicated["ok"])
        self.assertTrue(duplicated["dup"])
        self.assertEqual(rpc(path, {"op": "read"})["rows"], [[7, 42]])
        self.stop(newer)

    def test_corrupt_persisted_mac_prevents_restart(self):
        running = self.start("journal")
        path = str(self.run / "journal.sock")
        self.assertTrue(rpc(path, {"op": "floor", "g": 4,
                                   "auth": mac(self.key, "floor|4")})["ok"])
        self.stop(running)
        logfile = self.run / "journal.log"
        rows = logfile.read_text().splitlines()
        record = json.loads(rows[0])
        record["g"] = 1
        rows[0] = json.dumps(record, sort_keys=True)
        logfile.write_text("\n".join(rows) + "\n")
        failed = subprocess.Popen(
            [sys.executable, "-B", "-c", SHIM, str(HERE),
             str(TARGET), str(self.run), "journal"],
            cwd=str(HERE), stdin=subprocess.DEVNULL,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        self.processes.append(failed)
        _, stderr = failed.communicate(timeout=5)
        self.assertNotEqual(failed.returncode, 0)
        self.assertIn("untrusted or temporally inconsistent journal", stderr)


if __name__ == "__main__":
    unittest.main()
