"""Append-only evidence storage under separate administrators (simulated)."""
import json
import os
import tempfile
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
import pytest


def test_append_only_evidence_storage():
    with tempfile.TemporaryDirectory() as tmp:
        admin_a = Path(tmp) / "admin_a"
        admin_b = Path(tmp) / "admin_b"
        admin_a.mkdir()
        admin_b.mkdir()

        key_a = Ed25519PrivateKey.generate()
        key_b = Ed25519PrivateKey.generate()

        # Append-only log (O_APPEND)
        log_a = admin_a / "evidence.log"
        log_b = admin_b / "evidence.log"

        fd_a = os.open(log_a, os.O_WRONLY | os.O_CREAT | os.O_APPEND, 0o644)
        fd_b = os.open(log_b, os.O_WRONLY | os.O_CREAT | os.O_APPEND, 0o644)

        evidence_a = {"admin": "A", "marker": "zero-byte", "epoch": 1}
        evidence_b = {"admin": "B", "marker": "zero-byte", "epoch": 1}

        sig_a = key_a.sign(json.dumps(evidence_a, sort_keys=True).encode())
        sig_b = key_b.sign(json.dumps(evidence_b, sort_keys=True).encode())

        os.write(fd_a, (json.dumps({"evidence": evidence_a, "sig": sig_a.hex()}) + "\n").encode())
        os.write(fd_b, (json.dumps({"evidence": evidence_b, "sig": sig_b.hex()}) + "\n").encode())
        os.close(fd_a)
        os.close(fd_b)

        # Verify append-only: second write appends, not overwrites
        fd_a2 = os.open(log_a, os.O_WRONLY | os.O_APPEND)
        os.write(fd_a2, b'{"append":"test"}\n')
        os.close(fd_a2)

        lines_a = log_a.read_text().strip().split("\n")
        assert len(lines_a) == 2, "Append-only should preserve prior entries"

        # Verify separation
        assert admin_a != admin_b
        assert log_a.parent != log_b.parent


def test_no_cross_custody_append():
    with tempfile.TemporaryDirectory() as tmp:
        admin_a = Path(tmp) / "admin_a"
        admin_b = Path(tmp) / "admin_b"
        admin_a.mkdir()
        admin_b.mkdir()

        log_a = admin_a / "evidence.log"
        log_b = admin_b / "evidence.log"

        # A writes to A
        fd_a = os.open(log_a, os.O_WRONLY | os.O_CREAT | os.O_APPEND, 0o644)
        os.write(fd_a, b'{"admin":"A"}\n')
        os.close(fd_a)

        # B's log should not contain A's data
        if log_b.exists():
            assert '{"admin":"A"}' not in log_b.read_text()
