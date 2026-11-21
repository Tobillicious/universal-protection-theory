"""Authority rollback vs separately retained nonce-signed snapshot.

Same-host cryptographic test fixture ONLY: the signing key and checkpoint
remain under the test's control; no off-host immutability is established.
Positive comparisons are explicitly non-authorizing.
"""
import os
import shutil
import socket
import tempfile
import threading
import unittest
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_authority_checkpoint_contrast import (
    AuthorityAdmissionCheckpointContrast, read_authority_checkpoint)
from koru_nonce_signed_checkpoint import SignedCheckpointReader, serve_checkpoint_once
from koru_transactional_hold_witness import TransactionalHoldWitness


class AuthorityCheckpointContrastTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-admission-checkpoint-")
        root = Path(self.tmp.name)
        self.db = str(root / "authority.sqlite")
        self.old = str(root / "rollback.sqlite")
        self.initial = dict(generation=17, held=False,
                            event_id="fixture", authority_ref="authority")
        self.expected = {k: self.initial[k] for k in
                         ("generation", "event_id", "authority_ref")}
        self.journal = AuthorityAdmissionJournal.provision(
            TransactionalHoldWitness.provision(self.db, self.initial))
        self.key = Ed25519PrivateKey.generate()
        self.external = read_authority_checkpoint(self.journal)
        self.threads = []

    def tearDown(self):
        for t in self.threads:
            t.join(timeout=3)
            self.assertFalse(t.is_alive(), "checkpoint witness thread leak")
        self.tmp.cleanup()

    def signed_reader(self, *, absent=False):
        if absent:
            def missing():
                raise ConnectionError("unreachable fixture checkpoint")
            return missing
        client, server = socket.socketpair(socket.AF_UNIX)
        client.settimeout(2)
        server.settimeout(2)
        snapshot = dict(self.external, pending_ids=list(self.external["pending_ids"]))
        error = []
        def worker():
            try:
                with server:
                    serve_checkpoint_once(
                        server, private_key=self.key, checkpoint=snapshot,
                        permitted_uid=os.getuid())
            except Exception as exc:
                error.append(exc)
        thread = threading.Thread(target=worker)
        thread.start()
        self.threads.append(thread)
        reader = SignedCheckpointReader(
            lambda: client, self.key.public_key(),
            expected_server_uid=os.getuid())
        return reader.read

    def check(self):
        return AuthorityAdmissionCheckpointContrast(
            self.journal, self.signed_reader()).preflight()

    def test_clean_snapshot_only_not_effect_permit(self):
        self.assertEqual(self.check(), (True, "consistent_snapshot_only"))

    def test_unresolved_admission_rejects_restored_old_db(self):
        shutil.copyfile(self.db, self.old)
        self.assertTrue(self.journal.admit("single", self.expected)["ok"])
        self.external = read_authority_checkpoint(self.journal)
        self.assertEqual(self.check(), (False, "held_or_admission_unresolved"))
        shutil.copyfile(self.old, self.db)
        self.assertEqual(self.check(), (False, "checkpoint_mismatch"))

    def test_started_admission_rejects_restored_old_db(self):
        shutil.copyfile(self.db, self.old)
        self.assertTrue(self.journal.admit("single", self.expected)["ok"])
        from contextlib import closing
        with closing(self.journal._authority._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            db.execute("UPDATE authority_admissions SET state='started' "
                       "WHERE operation_id='single'")
            db.execute("COMMIT")
        self.external = read_authority_checkpoint(self.journal)
        self.assertEqual(self.check(), (False, "held_or_admission_unresolved"))
        shutil.copyfile(self.old, self.db)
        self.assertEqual(self.check(), (False, "checkpoint_mismatch"))

    def test_hold_cannot_disappear_on_local_rollback(self):
        shutil.copyfile(self.db, self.old)
        self.assertTrue(self.journal.hold()["held"])
        self.external = read_authority_checkpoint(self.journal)
        self.assertEqual(self.check(), (False, "held_or_admission_unresolved"))
        shutil.copyfile(self.old, self.db)
        self.assertEqual(self.check(), (False, "checkpoint_mismatch"))

    def test_unavailable_checkpoint_denies(self):
        contrast = AuthorityAdmissionCheckpointContrast(
            self.journal, self.signed_reader(absent=True))
        self.assertEqual(contrast.preflight(), (False, "checkpoint_unavailable"))

    def test_missing_or_corrupt_admission_table_denies(self):
        from contextlib import closing
        with closing(self.journal._authority._connect()) as db:
            db.execute("DROP TABLE authority_admissions")
        self.assertEqual(self.check(), (False, "checkpoint_unavailable"))

    def test_both_histories_rewound_is_known_counterexample(self):
        old_checkpoint = dict(self.external, pending_ids=[])
        shutil.copyfile(self.db, self.old)
        self.assertTrue(self.journal.hold()["held"])
        self.external = read_authority_checkpoint(self.journal)
        self.assertEqual(self.check(), (False, "held_or_admission_unresolved"))
        # The same-host attacker rewinds the purported independent history.
        shutil.copyfile(self.old, self.db)
        self.external = old_checkpoint
        self.assertEqual(self.check(), (True, "consistent_snapshot_only"))
        # Passing this test PROVES the local-only approach is insufficient.

    def test_started_vs_unresolved_cannot_be_distinguished_by_v1_snapshot(self):
        self.assertTrue(self.journal.admit("single", self.expected)["ok"])
        self.external = read_authority_checkpoint(self.journal)
        from contextlib import closing
        with closing(self.journal._authority._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            db.execute("UPDATE authority_admissions SET state='started' "
                       "WHERE operation_id='single'")
            db.execute("COMMIT")
        # Same pending IDs; the comparison must never authorize either state.
        self.assertEqual(self.check(), (False, "held_or_admission_unresolved"))


if __name__ == "__main__":
    unittest.main()
