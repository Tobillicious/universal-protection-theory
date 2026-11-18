"""Signed evidence from distinct administrators (simulated)."""
import json
import asyncio
import logging
from typing import List
from pathlib import Path
import tempfile

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
import pytest

logger = logging.getLogger("SignedEvidenceSeparateAdmins")
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")


class AdminNode:
    def __init__(self, admin_id: str, admin_uid: int):
        self.admin_id = admin_id
        self.admin_uid = admin_uid
        self.private_key = Ed25519PrivateKey.generate()
        self.public_key = self.private_key.public_key()

    def sign_evidence(self, evidence: dict) -> bytes:
        payload = json.dumps(evidence, sort_keys=True).encode()
        return self.private_key.sign(payload)

    def verify_evidence(self, evidence: dict, signature: bytes, public_key) -> bool:
        payload = json.dumps(evidence, sort_keys=True).encode()
        try:
            public_key.verify(signature, payload)
            return True
        except Exception:
            return False


def test_signed_evidence_from_distinct_admins():
    admin_a = AdminNode("admin-a", 1001)
    admin_b = AdminNode("admin-b", 1002)

    evidence_a = {"admin": "admin-a", "marker": "zero-byte", "epoch": 1}
    evidence_b = {"admin": "admin-b", "marker": "zero-byte", "epoch": 1}

    sig_a = admin_a.sign_evidence(evidence_a)
    sig_b = admin_b.sign_evidence(evidence_b)

    # Each admin verifies their own evidence
    assert admin_a.verify_evidence(evidence_a, sig_a, admin_a.public_key)
    assert admin_b.verify_evidence(evidence_b, sig_b, admin_b.public_key)

    # Cross-verification: A cannot verify B's evidence with A's key
    assert not admin_a.verify_evidence(evidence_b, sig_b, admin_a.public_key)
    assert not admin_b.verify_evidence(evidence_a, sig_a, admin_b.public_key)

    # Distinct administrators
    assert admin_a.admin_uid != admin_b.admin_uid


def test_evidence_tampering_detected():
    admin = AdminNode("admin-x", 2001)
    evidence = {"admin": "admin-x", "marker": "zero-byte", "epoch": 1}
    sig = admin.sign_evidence(evidence)

    # Tamper with evidence
    tampered = dict(evidence)
    tampered["epoch"] = 2
    assert not admin.verify_evidence(tampered, sig, admin.public_key)


if __name__ == "__main__":
    import pytest
    pytest.main([__file__, "-q"])
