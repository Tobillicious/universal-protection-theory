"""Cross-thread Unix socket checkpoint authentication, research fixture only."""
import os
import socket
import tempfile
import threading
import unittest
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_external_checkpoint_contrast import ExternalCheckpointContrast
from koru_nonce_signed_checkpoint import (
    DOMAIN, SignedCheckpointReader, serve_checkpoint_once)
from koru_signed_remote_hold_witness import _encoded
from koru_local_hold_ack_socket import _read_frame, _send_frame
from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transactional_hold_witness import TransactionalHoldWitness


class SignedCheckpointTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-signed-check-")
        state = dict(generation=7, held=False,
                     event_id="event", authority_ref="ref")
        self.store = TransactionalHoldWitness.provision(
            str(Path(self.tmp.name) / "state.sqlite"), state)
        self.gate = DurableEffectIntentBoundary.provision_journal(self.store)
        self.checkpoint = dict(state, pending_ids=[])
        self.key = Ed25519PrivateKey.generate()
        self.threads = []

    def tearDown(self):
        for thread in self.threads:
            thread.join(timeout=3)
            self.assertFalse(thread.is_alive(), "leaked witness thread")
        self.tmp.cleanup()

    def reader(self, mode="valid", *, expected_uid=None):
        client, server = socket.socketpair(socket.AF_UNIX)
        client.settimeout(2)
        server.settimeout(2)
        error = []
        def serve():
            try:
                with server:
                    if mode == "valid":
                        serve_checkpoint_once(
                            server, private_key=self.key,
                            checkpoint=self.checkpoint, permitted_uid=os.getuid())
                    else:
                        request = _read_frame(server)
                        body = dict(self.checkpoint, domain=DOMAIN,
                                    nonce=request["nonce"])
                        if mode == "stale":
                            body["nonce"] = "0" * 64 if body["nonce"] != "0" * 64 else "f" * 64
                        if mode == "altered":
                            signature = self.key.sign(_encoded(body)).hex()
                            body["generation"] = 44
                        else:
                            signature = self.key.sign(_encoded(body)).hex()
                        if mode == "forged":
                            signature = Ed25519PrivateKey.generate().sign(
                                _encoded(body)).hex()
                        _send_frame(server, dict(body, signature=signature))
            except Exception as exc:
                error.append(exc)
        thread = threading.Thread(target=serve, daemon=True)
        thread.start()
        self.threads.append(thread)
        return SignedCheckpointReader(
            lambda: client, self.key.public_key(),
            expected_server_uid=os.getuid() if expected_uid is None
            else expected_uid)

    def test_fresh_signed_checkpoint_matches_read_only_contrast(self):
        reader = self.reader()
        result = ExternalCheckpointContrast(self.store, reader.read).preflight()
        self.assertEqual(result, (True, "consistent_snapshot_only"))

    def test_signed_held_checkpoint_denies_even_if_local_is_old(self):
        self.checkpoint = dict(self.checkpoint, generation=8, held=True)
        reader = self.reader()
        self.assertEqual(
            ExternalCheckpointContrast(self.store, reader.read).preflight(),
            (False, "checkpoint_mismatch"))

    def test_signed_pending_checkpoint_denies_local_rollback(self):
        self.checkpoint = dict(self.checkpoint, pending_ids=["op"])
        reader = self.reader()
        self.assertEqual(
            ExternalCheckpointContrast(self.store, reader.read).preflight(),
            (False, "checkpoint_mismatch"))

    def test_stale_signed_response_nonce_rejected(self):
        reader = self.reader("stale")
        with self.assertRaises(ValueError):
            reader.read()

    def test_forged_signature_rejected(self):
        reader = self.reader("forged")
        with self.assertRaises(PermissionError):
            reader.read()

    def test_signed_body_tampering_rejected(self):
        reader = self.reader("altered")
        with self.assertRaises(PermissionError):
            reader.read()

    def test_server_uid_mismatch_denied(self):
        reader = self.reader(expected_uid=os.getuid() + 1)
        with self.assertRaises(PermissionError):
            reader.read()

    def test_absent_checkpoint_server_denies_contrast(self):
        def absent():
            raise ConnectionError("checkpoint server unavailable")
        self.assertEqual(
            ExternalCheckpointContrast(self.store, absent).preflight(),
            (False, "checkpoint_unavailable"))

    def test_valid_signed_response_is_still_not_effect_authorization(self):
        self.assertEqual(self.reader().read(), self.checkpoint)
        self.store.commit_hold()
        # The formerly valid signed snapshot is immediately stale. #545
        # requires a *new* read before consistency; even that read is NOT a
        # remote linearizable effect grant.
        self.assertTrue(self.store.read()["held"])


if __name__ == "__main__":
    unittest.main()
