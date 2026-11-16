"""Authority-side durable admission journal, research-only.

Unlike snapshot preflight, an admission is a transaction at the authority.
It must be the authority's *own* state database, outside a writer's rollback
domain in any real deployment. No writer receives a permission to execute:
admission only registers unresolved work. Real effects still require remote
effect-time mediation. A HOLD can commit after admission, proving that treating
an admission response as an execution permit would be unsafe.

No server transport, independently provisioned host, authenticated caller,
anti-rollback hardware, or real effect here. Not production-ready.
"""
from contextlib import closing

from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transaction_scoped_effect import _exact_unheld
from koru_transactional_hold_witness import TransactionalHoldWitness


class AuthorityAdmissionJournal:
    def __init__(self, authority_witness):
        if not isinstance(authority_witness, TransactionalHoldWitness):
            raise TypeError("authority witness required")
        self._authority = authority_witness

    @classmethod
    def provision(cls, authority_witness):
        """Explicit one-time creation, never on read/restart."""
        instance = cls(authority_witness)
        with closing(authority_witness._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                db.execute("""CREATE TABLE authority_admissions (
                   operation_id TEXT PRIMARY KEY,
                   generation INTEGER NOT NULL,
                   event_id TEXT NOT NULL,
                   authority_ref TEXT NOT NULL,
                   state TEXT NOT NULL CHECK(state IN ('unresolved','started')))""")
                db.execute("COMMIT")
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise
        return instance

    def admit(self, operation_id, expected):
        """Record unresolved intent BEFORE any operation; never grant effect.

        All callers must treat a recorded admission as an audit record only.
        It is not a capability, token, lease, or permission to execute.
        """
        if (type(operation_id) is not str or
                not (1 <= len(operation_id) <= 128) or
                not operation_id.isascii() or type(expected) is not dict):
            return {"ok": False, "code": "bad_request"}
        try:
            with closing(self._authority._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    state = DurableEffectIntentBoundary._load_state(
                        db, self._authority)
                    rows = db.execute(
                        "SELECT operation_id FROM authority_admissions").fetchall()
                    if not _exact_unheld(state, expected) or rows:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "authority_denied"}
                    db.execute("INSERT INTO authority_admissions VALUES "
                               "(?, ?, ?, ?, 'unresolved')",
                               (operation_id, expected["generation"],
                                expected["event_id"], expected["authority_ref"]))
                    db.execute("COMMIT")
                    return {"ok": True, "code": "intent_recorded_only"}
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except Exception:
            return {"ok": False, "code": "authority_unavailable_or_duplicate"}

    def unresolved(self):
        """Inspection only; missing/corrupt authority state raises."""
        with closing(self._authority._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                DurableEffectIntentBoundary._load_state(db, self._authority)
                rows = db.execute(
                    "SELECT operation_id FROM authority_admissions "
                    "WHERE state IN ('unresolved','started') ORDER BY operation_id").fetchall()
                db.execute("COMMIT")
                return [r[0] for r in rows]
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise

    def hold(self):
        """Same authority DB serializes HOLD with all admission transactions."""
        # Existing commit_hold obtains BEGIN IMMEDIATE on the same DB. HOLD
        # must still be allowed when an unresolved operation is recorded.
        return self._authority.commit_hold()
