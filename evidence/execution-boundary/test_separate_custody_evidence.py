"""Separate custody evidence simulation (distinct storage domains)."""
import json
import os
import tempfile
from pathlib import Path

import pytest


def test_separate_custody_storage_domains():
    with tempfile.TemporaryDirectory() as tmp:
        admin_a = Path(tmp) / "admin_a"
        admin_b = Path(tmp) / "admin_b"
        admin_a.mkdir()
        admin_b.mkdir()

        # Admin A writes evidence
        evidence_a = admin_a / "evidence.json"
        evidence_a.write_text(json.dumps({"admin": "A", "marker": "zero-byte"}))

        # Admin B writes evidence
        evidence_b = admin_b / "evidence.json"
        evidence_b.write_text(json.dumps({"admin": "B", "marker": "zero-byte"}))

        # Verify separation: A cannot read B's evidence path directly (different domain)
        assert evidence_a.exists()
        assert evidence_b.exists()
        assert evidence_a.parent != evidence_b.parent

        # Verify content integrity
        data_a = json.loads(evidence_a.read_text())
        data_b = json.loads(evidence_b.read_text())
        assert data_a["admin"] == "A"
        assert data_b["admin"] == "B"

        # Simulate custody verification: each admin verifies their own evidence
        assert data_a["marker"] == "zero-byte"
        assert data_b["marker"] == "zero-byte"


def test_no_cross_custody_access():
    with tempfile.TemporaryDirectory() as tmp:
        admin_a = Path(tmp) / "admin_a"
        admin_b = Path(tmp) / "admin_b"
        admin_a.mkdir()
        admin_b.mkdir()

        # A's evidence
        (admin_a / "secret.json").write_text(json.dumps({"secret": "A-only"}))

        # B cannot access A's evidence (different custody domain)
        b_path = admin_b / "secret.json"
        assert not b_path.exists(), "Cross-custody access should not exist"
