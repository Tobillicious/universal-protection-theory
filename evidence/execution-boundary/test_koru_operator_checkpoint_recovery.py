"""Agent 3 operator-custody checkpoint gating: disposable test identities only."""
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_operator_checkpoint_recovery import (
    DOMAIN, _encode, recover_with_operator_checkpoint)
from test_koru_anchor_partial_recovery import OneStepRecoveryTests


class OperatorCheckpointRecoveryTests(OneStepRecoveryTests):
    def setUp(self):
        super().setUp()
        self.operator_key = Ed25519PrivateKey.generate()
        self.operator_public_key = self.operator_key.public_key()

    def primary(self):
        return {"ok": True, "code": "snapshot_only", "receipt": self.a.read()}

    def secondary(self):
        return {"ok": True, "code": "snapshot_only", "receipt": self.b.read()}

    def checkpoint(self, nonce):
        rev, digest, predecessor = self.anchor.read_floor()
        body = dict(domain=DOMAIN, nonce=nonce, revision=rev,
                    digest=digest, previous_digest=predecessor)
        return dict(body, signature=self.operator_key.sign(_encode(body)).hex())

    def reconcile(self, checkpoint=None, key=None):
        return recover_with_operator_checkpoint(
            anchored=self.anchored,
            primary_read=self.primary,
            secondary_read=self.secondary,
            operator_read=checkpoint or self.checkpoint,
            operator_public_key=key or self.operator_public_key)

    def test_operator_challenge_signed_recovery(self):
        self.create_partial_commit()
        result = self.reconcile()
        self.assertEqual(result["revision"], 1)
        self.assertIs(result["authorizes_effect"], False)
        self.assertEqual(self.floor.read_floor(), self.anchor.read_floor())

    def test_operator_unavailable_denies_without_changing_floor(self):
        self.create_partial_commit()
        def outage(nonce):
            raise ConnectionError("remote operator offline")
        with self.assertRaises(ConnectionError):
            self.reconcile(checkpoint=outage)
        self.assertEqual(self.floor.read_floor()[0], 0)

    def test_replayed_old_nonce_denied(self):
        self.create_partial_commit()
        old = self.checkpoint("0" * 64)
        with self.assertRaisesRegex(PermissionError, "invalid operator"):
            self.reconcile(checkpoint=lambda nonce: old)
        self.assertEqual(self.floor.read_floor()[0], 0)

    def test_forged_operator_signature_denied(self):
        self.create_partial_commit()
        rogue = Ed25519PrivateKey.generate()
        def forged(nonce):
            packet = self.checkpoint(nonce)
            body = {key: packet[key] for key in (
                "domain", "nonce", "revision", "digest", "previous_digest")}
            packet["signature"] = rogue.sign(_encode(body)).hex()
            return packet
        with self.assertRaisesRegex(PermissionError, "signature"):
            self.reconcile(checkpoint=forged)
        self.assertEqual(self.floor.read_floor()[0], 0)

    def test_operator_checkpoint_rollback_denied(self):
        self.create_partial_commit()
        def stale(nonce):
            body = dict(domain=DOMAIN, nonce=nonce, revision=0,
                        digest=self.floor.read_floor()[1],
                        previous_digest=self.floor.read_floor()[2])
            return dict(body, signature=self.operator_key.sign(_encode(body)).hex())
        with self.assertRaisesRegex(PermissionError, "differs"):
            self.reconcile(checkpoint=stale)
        self.assertEqual(self.floor.read_floor()[0], 0)

    def test_witness_signer_cannot_replace_operator(self):
        self.create_partial_commit()
        with self.assertRaisesRegex(ValueError, "separate pinned operator"):
            self.reconcile(key=self.ka.public_key())
        self.assertEqual(self.floor.read_floor()[0], 0)

    def test_remote_checkpoint_not_an_effect_permit(self):
        self.create_partial_commit()
        result = self.reconcile()
        self.assertEqual(result["code"], "operator_checkpoint_history_reconciled_only")
        self.assertFalse(result["authorizes_effect"])


if __name__ == "__main__":
    import unittest
    unittest.main()
