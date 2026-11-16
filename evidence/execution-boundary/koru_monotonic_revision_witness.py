"""Single-writer monotonic revision witness with signed CAS receipts.

Research fixture ONLY. Revision progression is atomic in this separate
SQLite database, not hardware-monotonic, multi-host or rollback-resistant.
Requires an independently administered nonrollbackable backend to enforce
these properties against a privileged local host adversary.

Reuses the existing G3 Ed25519 canonical encoding. A revision receipt proves
what THIS store signed, NOT that the store cannot later be rolled back, not
that any real-world effect can be authorized, and not human consent.
"""
import hashlib
import json
import os
import sqlite3
from contextlib import closing

from cryptography.hazmat.primitives.asymmetric.ed25519 import (
    Ed25519PrivateKey, Ed25519PublicKey)
from cryptography.exceptions import InvalidSignature
from koru_signed_remote_hold_witness import _encoded

DOMAIN = "koru-g3-monotonic-history-research-v1"
_KEYS = frozenset(("domain", "revision", "digest", "previous_digest"))
GENESIS = "0" * 64


def _transition_allowed(before, after):
    """Conservative v1 floor: identity stable, HOLD irreversible, no dropped obligations.

    This fixture has no release protocol, new authority epoch, or completed
    admission transition. Such changes must be independently authorized,
    not silently inferred from an incrementing revision number.
    """
    return (all(before[k] == after[k] for k in
                ("generation", "event_id", "authority_ref")) and
            (not before["held"] or after["held"]) and
            set(before["pending_ids"]).issubset(after["pending_ids"]))


def _digest(snapshot):
    from koru_external_checkpoint_contrast import _valid_checkpoint
    if not _valid_checkpoint(snapshot):
        raise ValueError("invalid snapshot")
    return hashlib.sha256(_encoded(snapshot)).hexdigest()


def _hex_digest(s):
    return type(s) is str and len(s) == 64 and all(
        c in "0123456789abcdef" for c in s)


def verify_receipt(receipt, public_key, *, minimum_revision=0):
    if (not isinstance(public_key, Ed25519PublicKey) or
            type(receipt) is not dict or
            set(receipt) != _KEYS | {"signature"} or
            receipt.get("domain") != DOMAIN or
            type(receipt.get("revision")) is not int or
            receipt["revision"] < minimum_revision or
            not _hex_digest(receipt.get("digest")) or
            not _hex_digest(receipt.get("previous_digest"))):
        raise ValueError("malformed or stale receipt")
    signature = receipt["signature"]
    if (type(signature) is not str or len(signature) != 128 or
            any(c not in "0123456789abcdef" for c in signature)):
        raise ValueError("bad signature")
    try:
        public_key.verify(
            bytes.fromhex(signature),
            _encoded({key: receipt[key] for key in _KEYS}))
    except InvalidSignature as exc:
        raise PermissionError("invalid revision receipt signature") from exc
    return {k: receipt[k] for k in _KEYS}


class MonotonicRevisionWitness:
    """Durable-in-fixture compare-and-swap history, not external trust."""

    def __init__(self, path, private_key):
        if (not isinstance(private_key, Ed25519PrivateKey) or
                type(path) is not str or not os.path.isabs(path) or
                os.path.normpath(path) != path):
            raise ValueError("explicit signing key and canonical path required")
        self.path = path
        self._key = private_key

    def _connect(self):
        from urllib.parse import quote
        db = sqlite3.connect("file:" + quote(self.path, safe="/") +
                             "?mode=rw", uri=True, timeout=3,
                             isolation_level=None)
        try:
            db.execute("PRAGMA synchronous=FULL")
            db.execute("PRAGMA journal_mode=DELETE")
            db.execute("PRAGMA busy_timeout=2500")
            return db
        except BaseException:
            db.close()
            raise

    @classmethod
    def provision(cls, path, private_key, initial):
        witness = cls(path, private_key)
        digest = _digest(initial)
        fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL |
                     os.O_NOFOLLOW | os.O_CLOEXEC, 0o600)
        os.close(fd)
        try:
            with closing(witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                db.execute("""CREATE TABLE history (
                    revision INTEGER PRIMARY KEY CHECK(revision>=0),
                    digest TEXT NOT NULL,
                    previous_digest TEXT NOT NULL,
                    snapshot_json TEXT NOT NULL)""")
                db.execute("INSERT INTO history VALUES (0, ?, ?, ?)",
                           (digest, GENESIS, _encoded(initial).decode("ascii")))
                db.execute("COMMIT")
            return witness
        except BaseException:
            os.unlink(path)
            raise

    def _latest(self, db):
        rows = db.execute(
            "SELECT revision,digest,previous_digest,snapshot_json "
            "FROM history ORDER BY revision").fetchall()
        if not rows:
            raise ValueError("missing witness history")
        previous_state = None
        for i, (revision, digest, predecessor, raw) in enumerate(rows):
            if (type(revision) is not int or revision != i or
                    not _hex_digest(digest) or
                    not _hex_digest(predecessor) or
                    predecessor != (GENESIS if i == 0 else rows[i-1][1]) or
                    type(raw) is not str):
                raise ValueError("corrupt or discontinuous history")
            try:
                state = json.loads(raw)
                if (_encoded(state).decode("ascii") != raw or
                        _digest(state) != digest or
                        (previous_state is not None and
                         not _transition_allowed(previous_state, state))):
                    raise ValueError("tampered or regressed protection state")
            except (TypeError, ValueError) as exc:
                raise ValueError("invalid protection history") from exc
            previous_state = state
        return rows[-1]

    def _signed(self, row):
        revision, digest, previous = row[:3]
        body = dict(domain=DOMAIN, revision=revision,
                    digest=digest, previous_digest=previous)
        return dict(body, signature=self._key.sign(_encoded(body)).hex())

    def read(self):
        with closing(self._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                value = self._signed(self._latest(db))
                db.execute("COMMIT")
                return value
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise

    def advance(self, snapshot, *, expected_revision, expected_digest):
        """CAS: reject duplicate, stale, or out-of-order updates; sign after commit."""
        new_digest = _digest(snapshot)
        if (type(expected_revision) is not int or expected_revision < 0
                or not _hex_digest(expected_digest)):
            raise ValueError("invalid expected revision")
        with closing(self._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                rev, digest, previous, prior_json = self._latest(db)
                if rev != expected_revision or digest != expected_digest:
                    db.execute("ROLLBACK")
                    return {"ok": False, "code": "stale_revision"}
                if new_digest == digest:
                    db.execute("ROLLBACK")
                    return {"ok": False, "code": "unchanged_snapshot"}
                if not _transition_allowed(json.loads(prior_json), snapshot):
                    db.execute("ROLLBACK")
                    return {"ok": False, "code": "protection_regression_denied"}
                db.execute("INSERT INTO history VALUES (?, ?, ?, ?)",
                           (rev + 1, new_digest, digest,
                            _encoded(snapshot).decode("ascii")))

                db.execute("COMMIT")
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise
        return {"ok": True, "code": "revision_committed",
                "receipt": self._signed((rev + 1, new_digest, digest))}


def check_snapshot_against_receipt(snapshot, receipt, public_key,
                                   *, minimum_revision=0):
    """Read-only comparison; NEVER an effect permit."""
    try:
        body = verify_receipt(receipt, public_key,
                              minimum_revision=minimum_revision)
        if body["digest"] != _digest(snapshot):
            return False, "snapshot_mismatch"
        return True, "consistent_snapshot_only"
    except Exception:
        return False, "receipt_invalid_or_unavailable"
