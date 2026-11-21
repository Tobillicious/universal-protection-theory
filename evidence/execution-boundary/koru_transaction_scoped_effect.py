"""Transaction-scoped synthetic effect ordering against HOLD, research only.

No production adapter, external authority, or real effect. A single local
SQLite database serializes cooperating clients *only if* all HOLD writers and
effect enactors use this transaction protocol. This cannot prevent privileged
file rollback, host-root bypass or external unmediated effects.

Never treat a signed stale read or an ordinary lease as a transaction fence.
"""
from contextlib import closing

from koru_transactional_hold_witness import TransactionalHoldWitness


def _exact_unheld(state, expected):
    return (type(expected) is dict and
            set(expected) == {"generation", "event_id", "authority_ref"} and
            type(expected["generation"]) is int and
            type(expected["event_id"]) is str and
            type(expected["authority_ref"]) is str and
            state["held"] is False and all(state[k] == expected[k]
                                             for k in expected))


class TransactionScopedEffectBoundary:
    """Cooperating synthetic operation held under the same DB write lock as HOLD."""

    def __init__(self, witness):
        if not isinstance(witness, TransactionalHoldWitness):
            raise TypeError("existing transactional witness required")
        self._witness = witness

    def enact(self, expected, local_permits, effect):
        """Return denial or one effect result; do not retry uncertain effects.

        The protected operation is invoked *before releasing* the lock.
        local_permits MUST perform all original event, permit, identity and
        revocation checks, under their own appropriate shared effect fence.
        The caller must ensure lock ordering is consistent across components.
        """
        if (not callable(local_permits) or not callable(effect) or
                type(expected) is not dict):
            return {"ok": False, "code": "bad_request"}
        try:
            with closing(self._witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    rows = db.execute(
                        "SELECT generation, held, event_id, authority_ref "
                        "FROM witness").fetchall()
                    if len(rows) != 1:
                        raise ValueError("invalid witness state")
                    state = self._witness._decode(rows[0])
                    allowed = (_exact_unheld(state, expected) and
                               local_permits() is True)
                    if not allowed:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "authorization_denied"}
                    try:
                        outcome = effect()
                    except BaseException:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "outcome_uncertain"}
                    db.execute("COMMIT")
                    if type(outcome) is not dict or type(outcome.get("ok")) is not bool:
                        return {"ok": False, "code": "outcome_uncertain"}
                    return outcome
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except Exception:
            return {"ok": False, "code": "witness_unavailable"}
