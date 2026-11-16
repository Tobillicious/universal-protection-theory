"""Linux-only disposable distinct-UID request-to-executor tests.

Privileged only in a disposable container. No production installation.
"""
import json
import os
import select
import shutil
import socket
import subprocess
import sys
import tempfile
import time
import unittest
from pathlib import Path

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_transactional_hold_witness import TransactionalHoldWitness

EXECUTOR_UID = 65532
REQUESTER_UID = 65534
ROGUE_UID = 65533
MODULES = (
    "koru_isolated_authority_executor.py",
    "koru_authority_admission_journal.py",
    "koru_authority_effect_time_fence.py",
    "koru_durable_effect_intent.py",
    "koru_transaction_scoped_effect.py",
    "koru_transactional_hold_witness.py",
)

SERVER = r"""
import json, select, sys
from koru_isolated_authority_executor import IsolatedAuthorityExecutor
socket_path, marker_dir, db = sys.argv[1:]
server = IsolatedAuthorityExecutor(
    socket_path, marker_dir, db, requester_uid=65534,
    expected={"generation": 9, "event_id": "fixture-event",
              "authority_ref": "fixture-authority"})
server.timeout = 0.08
print("READY", flush=True)
try:
    while True:
        ready, _, _ = select.select([sys.stdin], [], [], 0)
        if ready and sys.stdin.readline().strip() == "stop":
            break
        server.handle_request()
finally:
    server.server_close()
"""

CLIENT = r"""
import json, socket, sys
with socket.socket(socket.AF_UNIX) as s:
    s.settimeout(3)
    s.connect(sys.argv[1])
    s.sendall((sys.argv[2] + "\n").encode("utf-8"))
    line = b""
    while not line.endswith(b"\n"):
        part = s.recv(4096)
        if not part:
            break
        line += part
print(line.decode(), flush=True)
"""

DIRECT = r"""
import os, sys
fd = os.open(sys.argv[1], os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
os.close(fd)
"""


def as_uid(uid):
    def drop():
        os.setgroups([])
        os.setgid(uid)
        os.setuid(uid)
    return drop


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "requires ephemeral privileged Linux fixture")
class IsolatedAuthorityExecutorTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-separated-executor-")
        self.root = Path(self.tmp.name)
        self.root.chmod(0o755)
        self.marker = self.root / "markers"
        self.marker.mkdir(mode=0o700)
        os.chown(self.marker, EXECUTOR_UID, EXECUTOR_UID)
        self.authority_dir = self.root / "authority"
        self.authority_dir.mkdir(mode=0o700)
        os.chown(self.authority_dir, EXECUTOR_UID, EXECUTOR_UID)
        self.db = self.authority_dir / "state.sqlite"
        state = dict(generation=9, held=False, event_id="fixture-event",
                     authority_ref="fixture-authority")
        witness = TransactionalHoldWitness.provision(str(self.db), state)
        AuthorityAdmissionJournal.provision(witness)
        os.chown(self.db, EXECUTOR_UID, EXECUTOR_UID)
        self.socket_dir = self.root / "socket"
        self.socket_dir.mkdir(mode=0o700)
        self.socket_dir.chmod(0o711)
        os.chown(self.socket_dir, EXECUTOR_UID, EXECUTOR_UID)
        self.sock = str(self.socket_dir / "executor.sock")
        self.lib = self.root / "lib"
        self.lib.mkdir(mode=0o755)
        for module in MODULES:
            shutil.copyfile(Path(__file__).with_name(module), self.lib / module)
        self.env = dict(os.environ, PYTHONPATH=str(self.lib),
                        PYTHONDONTWRITEBYTECODE="1")
        self.server = None
        self.start()

    def start(self):
        self.server = subprocess.Popen(
            [sys.executable, "-B", "-c", SERVER, self.sock,
             str(self.marker), str(self.db)],
            preexec_fn=as_uid(EXECUTOR_UID), cwd="/", env=self.env,
            stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True)
        ready, _, _ = select.select([self.server.stdout], [], [], 5)
        if not ready:
            raise AssertionError("executor did not signal ready")
        reply = self.server.stdout.readline().strip()
        if reply != "READY":
            raise AssertionError("executor startup: " + reply +
                                 " " + self.server.stderr.read())

    def stop(self):
        if self.server is not None:
            proc = self.server
            self.server = None
            if proc.poll() is None:
                try:
                    proc.stdin.write("stop\n")
                    proc.stdin.flush()
                except BrokenPipeError:
                    pass
            out, err = proc.communicate(timeout=4)
            self.assertEqual(proc.returncode, 0, err + out)
            if os.path.lexists(self.sock):
                os.unlink(self.sock)

    def tearDown(self):
        try:
            self.stop()
        finally:
            self.tmp.cleanup()

    def call(self, uid=REQUESTER_UID, payload=None):
        if payload is None:
            payload = {"op": "create_fixture_marker"}
        proc = subprocess.run(
            [sys.executable, "-B", "-c", CLIENT, self.sock,
             json.dumps(payload)],
            preexec_fn=as_uid(uid), cwd="/", env=self.env,
            capture_output=True, text=True, timeout=5)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        return json.loads(proc.stdout)

    def test_requester_cannot_write_marker_or_authority_db_directly(self):
        for path in (self.marker / "forged.marker", self.db):
            proc = subprocess.run(
                [sys.executable, "-B", "-c", DIRECT, str(path)],
                preexec_fn=as_uid(REQUESTER_UID), cwd="/",
                capture_output=True, text=True, timeout=4)
            self.assertNotEqual(proc.returncode, 0)
            self.assertIn("PermissionError", proc.stderr)
        self.assertFalse(list(self.marker.iterdir()))

    def test_peer_uid_rejection(self):
        self.assertEqual(self.call(ROGUE_UID)["code"], "peer_denied")
        self.assertFalse(list(self.marker.iterdir()))

    def test_exact_request_success_and_replay_denied(self):
        self.assertEqual(self.call()["code"], "synthetic_effect_returned")
        file = self.marker / "fixed.marker"
        self.assertTrue(file.exists())
        self.assertEqual(file.stat().st_uid, EXECUTOR_UID)
        self.assertEqual(self.call()["code"], "authority_denied")
        self.assertEqual(len(list(self.marker.iterdir())), 1)

    def test_hold_first_denies_fixed_effect(self):
        self.assertTrue(TransactionalHoldWitness(str(self.db)).commit_hold()["held"])
        self.assertEqual(self.call()["code"], "authority_denied")
        self.assertFalse(list(self.marker.iterdir()))

    def test_restarted_executor_still_denies_replay(self):
        self.assertTrue(self.call()["ok"])
        self.stop()
        self.start()
        self.assertEqual(self.call()["code"], "authority_denied")
        self.assertEqual(len(list(self.marker.iterdir())), 1)

    def test_invalid_command_never_creates_effect(self):
        self.assertEqual(self.call(payload={"op": "arbitrary_shell"})["code"],
                         "bad_request")
        self.assertFalse(list(self.marker.iterdir()))

    def test_missing_authority_database_fails_closed(self):
        self.db.unlink()
        self.assertFalse(self.call()["ok"])
        self.assertFalse(list(self.marker.iterdir()))
        self.assertFalse(self.db.exists())


if __name__ == "__main__":
    unittest.main()
