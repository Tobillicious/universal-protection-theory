"""Check a disposable local witness against a separate trusted checkpoint.

Read-only *preflight contrast*, not an effect admission protocol. It never
calls an effect or changes HOLD/pending state. The independent checkpoint is
provided by a trusted reader interface and must be fresh, authenticated,
non-rollbackable and outside the local host's control in production. This
research module implements NONE of those infrastructure guarantees.

In particular, a positive check immediately goes stale, and cannot be
transformed into authorization without a remote linearizable effect protocol.
"""
from contextlib import closing

from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transactional_hold_witness import TransactionalHoldWitness

_KEYS = frozenset(("generation", "held", "event_id",
                   "authority_ref", "pending_ids"))


def _valid_checkpoint(value):
    return (type(value) is dict and set(value) == _KEYS and
            type(value["generation"]) is int and value["generation"] >= 1
            and type(value["held"]) is bool and
            type(value["event_id"]) is str and
            0 < len(value["event_id"]) <= 512 and
            value["event_id"].isascii() and
            type(value["authority_ref"]) is str and
            0 < len(value["authority_ref"]) <= 512 and
            value["authority_ref"].isascii() and
            type(value["pending_ids"]) is list and
            value["pending_ids"] == sorted(set(value["pending_ids"]))
            and all(type(s) is str and 0 < len(s) <= 128 and s.isascii()
                    for s in value["pending_ids"]))


class ExternalCheckpointContrast:
    """Reject divergent local snapshots; does not grant real effect rights."""

    def __init__(self, witness, trusted_read_checkpoint):
        if (not isinstance(witness, TransactionalHoldWitness)
                or not callable(trusted_read_checkpoint)):
            raise TypeError("existing witness and trusted reader required")
        self._witness = witness
        self._reader = trusted_read_checkpoint

    def preflight(self):
        """Return (false, reason) for any disagreement or incomplete context."""
        try:
            # The trusted external reader must provide a *fresh* authoritative
            # snapshot. Trusting an ordinary cached or local replica is unsafe.
            external = self._reader()
            if not _valid_checkpoint(external):
                return False, "checkpoint_invalid"
            with closing(self._witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    local = DurableEffectIntentBoundary._load_state(
                        db, self._witness)
                    rows = db.execute(
                        "SELECT operation_id FROM effect_intent "
                        "WHERE status='pending' ORDER BY operation_id"
                    ).fetchall()
                    observed = dict(local, pending_ids=[row[0] for row in rows])
                    db.execute("COMMIT")
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
            if observed != external:
                return False, "checkpoint_mismatch"
            if external["held"] or external["pending_ids"]:
                return False, "hold_or_unresolved_intent"
            return True, "consistent_snapshot_only"
        except Exception:
            return False, "checkpoint_unavailable"
