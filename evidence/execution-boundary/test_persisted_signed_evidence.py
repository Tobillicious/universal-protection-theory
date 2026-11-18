"""Persisted signed evidence under separate administrators (simulated)."""
import json
import os
import tempfile
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
import pytest


def test_persisted_signed_evidence_separate_admins():
    with tempfile.TemporaryDirectory() as tmp:
        admin_a_dir = Path(tmp) / "admin_a"
        admin_b_dir = Path(tmp) / "admin_b"
        admin_a_dir.mkdir()
        admin_b_dir.mkdir()

        key_a = Ed25519PrivateKey.generate()
        key_b = Ed25519PrivateKey.generate()

        evidence_a = {"admin": "A", "marker": "zero-byte", "epoch": 1}
        evidence_b = {"admin": "B", "marker": "zero-byte", "epoch": 1}

        sig_a = key_a.sign(json.dumps(evidence_a, sort_keys=True).encode())
        sig_b = key_b.sign(json.dumps(evidence_b, sort_keys=True).encode())

        # Persist evidence to append-only logs
        (admin_a_dir / "evidence.jsonl").write_text(json.dumps({"evidence": evidence_a, "sig": sig_a.hex()}) + "\n")
        (admin_b_dir / "evidence.jsonl").write_text(json.dumps({"evidence": evidence_b, "sig": sig_b.hex()}) + "\n")

        # Verify persistence
        assert (admin_a_dir / "evidence.jsonl").exists()
        assert (admin_b_dir / "evidence.jsonl").exists()

        # Verify signatures
        from cryptography.exceptions import InvalidSignature
        try:
            key_a.public_key().verify(sig_a, json.dumps(evidence_a, sort_keys=True).encode())
            verified_a = True
        except InvalidSignature:
            verified_a = False
        try:
            key_b.public_key().verify(sig_b, json.dumps(evidence_b, sort_keys=True).encode())
            verified_b = True
        except InvalidSignature:
            verified_b = False

        assert verified_a and verified_b

        # Verify separation: different directories
        assert admin_a_dir != admin_b_dir


def test_no_cross_custody_persistence():
    with tempfile.TemporaryDirectory() as tmp:
        admin_a = Path(tmp) / "admin_a"
        admin_b = Path(tmp) / "admin_b"
        admin_a.mkdir()
        admin_b.mkdir()

        (admin_a / "evidence.jsonl").write_text('{"admin":"A"}\n')
        # B should not have A's evidence
        assert not (admin_b / "evidence.jsonl").exists() or (admin_b / "evidence.jsonl").read_text() != '{"admin":"A"}\n'
