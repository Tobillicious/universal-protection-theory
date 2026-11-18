"""Negative controls for offline G-Mesh receipt auditing."""
import copy
import unittest

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from g_mesh_inventory_audit import DOMAIN, _canonical, audit


class GMeshInventoryTests(unittest.TestCase):
    def setUp(self):
        self.key = Ed25519PrivateKey.generate()
        pub = self.key.public_key().public_bytes(
            encoding=serialization.Encoding.Raw,
            format=serialization.PublicFormat.Raw).hex()
        self.roster = {"deployment_id": "zelda-research", "policy_digest": "a" * 64,
                       "nodes": [{"node_id": "zelda", "public_key_hex": pub}]}
        self.body = {"node_id": "zelda", "deployment_id": "zelda-research",
                     "policy_digest": "a" * 64, "observed_at": 1000,
                     "nonce": "independent-nonce-0001", "source_commit": "b" * 40,
                     "engine_digest": "c" * 64, "status": "ready"}
        self.observations = {"deployment_id": "zelda-research", "policy_digest": "a" * 64,
                             "receipts": [self.signed(self.body)]}

    def signed(self, body):
        return {"body": body, "signature_hex": self.key.sign(_canonical(body)).hex()}

    def check(self, observations=None, roster=None, now=1010):
        return audit(roster or self.roster, observations or self.observations, now=now)

    def test_valid_signature_is_not_live_attestation(self):
        result = self.check()
        self.assertTrue(result["ok"])
        self.assertFalse(result["certifies_live_nodes"])
        self.assertFalse(result["authorizes_effects"])

    def test_missing_receipt_fails(self):
        self.observations["receipts"] = []
        self.assertFalse(self.check()["ok"])

    def test_forged_signature_fails(self):
        self.observations["receipts"][0]["signature_hex"] = "00" * 64
        self.assertFalse(self.check()["ok"])

    def test_stale_receipt_fails(self):
        self.assertFalse(self.check(now=1400)["ok"])

    def test_wrong_deployment_fails(self):
        self.observations["deployment_id"] = "other"
        with self.assertRaises(ValueError):
            self.check()

    def test_wrong_scope_fails_even_when_signed(self):
        changed = dict(self.body, policy_digest="d" * 64)
        self.observations["receipts"][0] = self.signed(changed)
        self.assertFalse(self.check()["ok"])

    def test_extra_fields_fail(self):
        changed = dict(self.body, quorum=True)
        self.observations["receipts"][0] = self.signed(changed)
        self.assertFalse(self.check()["ok"])

    def test_duplicate_nodes_fail(self):
        self.roster["nodes"].append(copy.deepcopy(self.roster["nodes"][0]))
        with self.assertRaises(ValueError):
            self.check()

    def test_duplicate_receipt_fails(self):
        self.observations["receipts"].append(copy.deepcopy(self.observations["receipts"][0]))
        self.assertFalse(self.check()["ok"])

    def test_future_receipt_fails(self):
        self.body["observed_at"] = 1200
        self.observations["receipts"][0] = self.signed(self.body)
        self.assertFalse(self.check()["ok"])


if __name__ == "__main__":
    unittest.main()
