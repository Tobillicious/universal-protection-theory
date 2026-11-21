"""Persistent witness adapter adversarial regression, disposable SQLite only.

The snapshot-restore test is a vulnerability demonstration, not a successful
anti-rollback guarantee. This is not a real independently administered store.
"""
import json
import os
import shutil
import sqlite3
from unittest.mock import patch
import socket
import subprocess
import sys
import tempfile
import threading
import unittest
from pathlib import Path

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_independent_hold_anchor_gate import IndependentlyAnchoredHoldGate
from koru_signed_remote_hold_witness import SignedWitnessReader
from koru_transactional_hold_witness import TransactionalHoldWitness

CHILD = """
import socket, sys
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_transactional_hold_witness import TransactionalHoldWitness
from koru_signed_remote_hold_witness import serve_witness_once
db = TransactionalHoldWitness(sys.argv[1])
if sys.argv[2] == 'hold':
    print(db.commit_hold()['generation'])
else:
    sock = socket.socket(fileno=int(sys.argv[3]))
    sock.settimeout(2)
    key = Ed25519PrivateKey.from_private_bytes(bytes.fromhex(sys.argv[4]))
    try:
        serve_witness_once(sock, private_key=key, state=db.read(),
                           permitted_uid=int(sys.argv[5]))
    finally:
        sock.close()
"""


class UnheldFloor:
    def __init__(self, state):
        self.state = dict(state)
    def read(self):
        return dict(self.state)
    def permits(self, event, _snapshot):
        return not self.state["held"] and event == self.state


class TransactionalWitnessTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-sqlite-witness-")
        self.path = str(Path(self.tmp.name) / "witness.sqlite3")
        self.before = {"generation": 4, "held": False,
                       "event_id": "fixture-event", "authority_ref": "fixture-auth"}
        self.store = TransactionalHoldWitness.provision(self.path, self.before)
        self.key = Ed25519PrivateKey.generate()
        self.secret = self.key.private_bytes(
            serialization.Encoding.Raw,
            serialization.PrivateFormat.Raw,
            serialization.NoEncryption()).hex()

    def tearDown(self):
        self.tmp.cleanup()

    def child(self, action, fd=None):
        return subprocess.run(
            [sys.executable, "-B", "-c", CHILD, self.path, action,
             str(-1 if fd is None else fd), self.secret, str(os.getuid())],
            pass_fds=() if fd is None else (fd,),
            capture_output=True, text=True, timeout=5)

    def query_child(self):
        a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
        a.settimeout(1)
        b.settimeout(2)
        child = subprocess.Popen(
            [sys.executable, "-B", "-c", CHILD, self.path, "serve",
             str(b.fileno()), self.secret, str(os.getuid())],
            pass_fds=(b.fileno(),), text=True,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        b.close()
        try:
            reader = SignedWitnessReader(
                lambda: a, self.key.public_key(),
                expected_server_uid=os.getuid())
            allowed = IndependentlyAnchoredHoldGate(
                UnheldFloor(self.before), reader).permits(self.before, None)
            out, err = child.communicate(timeout=4)
            self.assertEqual(child.returncode, 0, (out, err))
            return allowed
        finally:
            a.close()
            if child.poll() is None:
                child.kill()
                child.communicate()

    def test_persists_completed_hold_across_fresh_interpreter(self):
        result = self.child("hold")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.strip(), "5")
        self.assertEqual(self.store.read()["held"], True)
        self.assertEqual(self.store.read()["generation"], 5)

    def test_all_sqlite_connections_closed_on_read_commit_and_error(self):
        opened = []
        class TrackedConnection(sqlite3.Connection):
            def __init__(self, *args, **kwargs):
                super().__init__(*args, **kwargs)
                self.closed_by_caller = False
                opened.append(self)
            def close(self):
                self.closed_by_caller = True
                return super().close()

        original = sqlite3.connect
        def instrument(*args, **kwargs):
            return original(*args, factory=TrackedConnection, **kwargs)

        with patch("koru_transactional_hold_witness.sqlite3.connect",
                   side_effect=instrument):
            self.assertEqual(self.store.read()["generation"], 4)
            self.assertTrue(self.store.commit_hold()["held"])
            self.assertTrue(self.store.read()["held"])
            # A corrupt row exercises the exception and rollback path.
            db = original(self.path)
            try:
                db.execute("UPDATE witness SET event_id='' WHERE id=1")
                db.commit()
            finally:
                db.close()
            with self.assertRaises(ValueError):
                self.store.read()

        self.assertGreaterEqual(len(opened), 4)
        self.assertTrue(all(db.closed_by_caller for db in opened),
                        "every successful and failed transaction must close")

    def test_duplicate_hold_is_idempotent(self):
        self.assertEqual(self.store.commit_hold()["generation"], 5)
        self.assertEqual(self.store.commit_hold()["generation"], 5)
        self.assertTrue(self.store.read()["held"])

    def test_missing_db_does_not_recreate_unheld_state(self):
        os.unlink(self.path)
        with self.assertRaises(Exception):
            self.store.read()
        with self.assertRaises(Exception):
            self.store.commit_hold()
        self.assertFalse(os.path.exists(self.path))

    def test_signed_fresh_reader_receives_persistent_hold_after_restart(self):
        self.assertTrue(self.query_child())
        self.assertEqual(self.child("hold").returncode, 0)
        self.assertFalse(self.query_child())

    def test_full_local_db_restore_is_still_vulnerable(self):
        backup = Path(self.tmp.name) / "snapshot.backup"
        shutil.copyfile(self.path, backup)
        self.store.commit_hold()
        self.assertTrue(self.store.read()["held"])
        shutil.copyfile(backup, self.path)
        # Witness: local host/root storage rollback revives unheld state.
        self.assertFalse(self.store.read()["held"])
        self.assertEqual(self.store.read()["generation"], 4)
        self.assertTrue(self.query_child())

    def test_invalid_schema_refuses_to_reinitialize(self):
        os.unlink(self.path)
        Path(self.path).write_bytes(b"not a sqlite database")
        with self.assertRaises(Exception):
            self.store.read()


if __name__ == "__main__":
    unittest.main()
