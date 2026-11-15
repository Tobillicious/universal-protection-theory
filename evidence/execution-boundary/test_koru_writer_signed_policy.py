"""Independent signed-writer policy negative controls, no privileged service."""
import unittest

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_ed25519_permit import issue_ed25519
from koru_writer_signed_policy import SignedWriterPolicy
from test_koru_shadow import fixtures


class SignedWriterPolicyTests(unittest.TestCase):
    def setUp(self):
        self.event, _trust = fixtures()
        self.private_key = Ed25519PrivateKey.generate()
        self.permit = issue_ed25519(
            self.private_key, issuer="trusted-fixture-issuer",
            event=self.event, expires_at=200)
        self.calls = []

        def live_check(event, permit, now):
            self.calls.append(now)
            return True

        self.policy = SignedWriterPolicy(
            public_key=self.private_key.public_key(),
            issuer="trusted-fixture-issuer", clock=lambda: 20,
            current_state_check=live_check)

    def test_signed_event_and_current_state_required(self):
        self.assertTrue(self.policy(self.event, self.permit))
        self.assertEqual(self.calls, [20])

    def test_modified_event_and_forged_signature_denied(self):
        tampered = dict(self.event, event_id=self.event["event_id"] + "-forged")
        self.assertFalse(self.policy(tampered, self.permit))
        forged = dict(self.permit, signature="0" * 128)
        self.assertFalse(self.policy(self.event, forged))
        self.assertEqual(self.calls, [])

    def test_expired_permit_and_unavailable_clock_fail_closed(self):
        expired = SignedWriterPolicy(
            public_key=self.private_key.public_key(),
            issuer="trusted-fixture-issuer", clock=lambda: 200,
            current_state_check=lambda *_: True)
        self.assertFalse(expired(self.event, self.permit))
        unavailable = SignedWriterPolicy(
            public_key=self.private_key.public_key(),
            issuer="trusted-fixture-issuer",
            clock=lambda: (_ for _ in ()).throw(OSError("clock failed")),
            current_state_check=lambda *_: True)
        self.assertFalse(unavailable(self.event, self.permit))

    def test_revocation_or_state_failure_denied(self):
        denied = SignedWriterPolicy(
            public_key=self.private_key.public_key(),
            issuer="trusted-fixture-issuer", clock=lambda: 20,
            current_state_check=lambda *_: False)
        self.assertFalse(denied(self.event, self.permit))
        broken = SignedWriterPolicy(
            public_key=self.private_key.public_key(),
            issuer="trusted-fixture-issuer", clock=lambda: 20,
            current_state_check=lambda *_: (_ for _ in ()).throw(OSError("ledger down")))
        self.assertFalse(broken(self.event, self.permit))

    def test_no_state_checker_configuration_denied(self):
        with self.assertRaises(ValueError):
            SignedWriterPolicy(
                public_key=self.private_key.public_key(),
                issuer="trusted-fixture-issuer", clock=lambda: 20,
                current_state_check=None)


if __name__ == "__main__":
    unittest.main()
