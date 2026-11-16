"""Authenticated *record-only* reconciliation for uncertain G3 effects.

The verifier checks reviewer-signed statements and stores a single immutable
review record linked to an existing pending intent. A review NEVER changes
intent status, does NOT release HOLD, and cannot authorize future effects.

Research fixture only. Private review keys are generated in tests, not
provisioned here. A signed statement is NOT proof that the observation is
true, independent, complete, or fresh. SQLite remains locally rollbackable.
"""
import hashlib
import json
from contextlib import closing

from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from koru_transactional_hold_witness import TransactionalHoldWitness

DOMAIN = "koru-g3-effect-review-v1"
BODY = frozenset(("domain", "operation_id", "generation", "event_id",
                  "authority_ref", "finding", "evidence_sha256",
                  "review_id"))
FINDINGS = frozenset(("observed_complete", "observed_partial",
                      "not_observed", "indeterminate"))


def _valid(body):
    return (type(body) is dict and set(body) == BODY and
            body["domain"] == DOMAIN and
            type(body["operation_id"]) is str and
            1 <= len(body["operation_id"]) <= 128 and
            body["operation_id"].isascii() and
            type(body["generation"]) is int and body["generation"] >= 1 and
            type(body["event_id"]) is str and 0 < len(body["event_id"]) <= 512
            and body["event_id"].isascii() and
            type(body["authority_ref"]) is str and
            0 < len(body["authority_ref"]) <= 512 and
            body["authority_ref"].isascii() and
            type(body["finding"]) is str and body["finding"] in FINDINGS and
            type(body["review_id"]) is str and
            1 <= len(body["review_id"]) <= 128 and body["review_id"].isascii() and
            type(body["evidence_sha256"]) is str and
            len(body["evidence_sha256"]) == 64 and
            all(c in "0123456789abcdef" for c in body["evidence_sha256"]))


def _canonical(body):
    return json.dumps(body, sort_keys=True, separators=(",", ":"),
                      ensure_ascii=True, allow_nan=False).encode("ascii")


class SignedReconciliationRecorder:
    def __init__(self, witness, pinned_reviewer_key):
        if (not isinstance(witness, TransactionalHoldWitness) or
                not isinstance(pinned_reviewer_key, Ed25519PublicKey)):
            raise TypeError("existing witness and pinned reviewer key required")
        self._witness = witness
        self._key = pinned_reviewer_key

    @staticmethod
    def provision_review_table(witness):
        """Explicit fixture-time schema provision. No auto-create on recovery."""
        if not isinstance(witness, TransactionalHoldWitness):
            raise TypeError("existing witness required")
        with closing(witness._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                db.execute("""CREATE TABLE effect_review (
                    operation_id TEXT PRIMARY KEY,
                    review_id TEXT NOT NULL UNIQUE,
                    finding TEXT NOT NULL,
                    evidence_sha256 TEXT NOT NULL,
                    signed_body TEXT NOT NULL,
                    signature TEXT NOT NULL)""")
                db.execute("COMMIT")
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise

    def record(self, envelope):
        """Persist verified review without touching the pending state.

        Failures and duplicate review submissions always deny. Even
        'observed_complete' NEVER clears the pending fence.
        """
        try:
            if (type(envelope) is not dict or
                    set(envelope) != BODY | {"signature"}):
                return False
            body = {k: envelope[k] for k in BODY}
            if not _valid(body):
                return False
            signature = envelope["signature"]
            if (type(signature) is not str or len(signature) != 128 or
                    any(c not in "0123456789abcdef" for c in signature)):
                return False
            self._key.verify(bytes.fromhex(signature), _canonical(body))
            with closing(self._witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    rows = db.execute(
                        "SELECT status, generation, event_id, authority_ref "
                        "FROM effect_intent WHERE operation_id=?",
                        (body["operation_id"],)).fetchall()
                    if (len(rows) != 1 or rows[0] !=
                            ("pending", body["generation"],
                             body["event_id"], body["authority_ref"])):
                        db.execute("ROLLBACK")
                        return False
                    # Require witness schema and unaltered row to exist even
                    # when held. A review cannot loosen a HOLD.
                    from koru_durable_effect_intent import DurableEffectIntentBoundary
                    DurableEffectIntentBoundary._load_state(db, self._witness)
                    db.execute(
                        "INSERT INTO effect_review VALUES (?,?,?,?,?,?)",
                        (body["operation_id"], body["review_id"],
                         body["finding"], body["evidence_sha256"],
                         _canonical(body).decode("ascii"), signature))
                    db.execute("COMMIT")
                    return True
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except (InvalidSignature, OSError, ValueError, TypeError,
                RuntimeError, KeyError, AttributeError, Exception):
            return False

    def reviewed(self, operation_id):
        """Read-only inventory; reports assertions, not proven outcomes."""
        with closing(self._witness._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                result = db.execute(
                    "SELECT review_id, finding, evidence_sha256 FROM "
                    "effect_review WHERE operation_id=?", (operation_id,)).fetchone()
                db.execute("COMMIT")
                return result
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise
