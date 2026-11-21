"""Conservative, durable effect-intent journal for disposable G3 research.

A pending record is committed BEFORE an effect callback can begin. Any crash
or uncertain completion leaves an unresolved record that blocks all later
effect admission. No automatic retry, release, or reconciliation-by-guess.

A committed "complete" row only describes a callback that returned before
the SQLite commit. SQLite and OS effects are NOT atomically committed.
Local root can restore the DB, and this module does not establish independent
authority, power-loss guarantees or full OS effect confinement.
"""
from contextlib import closing
from koru_transaction_scoped_effect import _exact_unheld
from koru_transactional_hold_witness import TransactionalHoldWitness

_SELECT = "SELECT generation, held, event_id, authority_ref FROM witness"


class DurableEffectIntentBoundary:
    def __init__(self, witness):
        if not isinstance(witness, TransactionalHoldWitness):
            raise TypeError("existing trusted witness adapter required")
        self._witness = witness

    @staticmethod
    def provision_journal(witness):
        """Explicit one-time fixture provision; never initialized during recovery."""
        if not isinstance(witness, TransactionalHoldWitness):
            raise TypeError("witness required")
        with closing(witness._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                # Fail if already present instead of silently repairing lost rows.
                db.execute("""CREATE TABLE effect_intent (
                    operation_id TEXT PRIMARY KEY NOT NULL,
                    status TEXT NOT NULL CHECK(status IN ('pending','complete')),
                    generation INTEGER NOT NULL,
                    event_id TEXT NOT NULL,
                    authority_ref TEXT NOT NULL)""")
                db.execute("COMMIT")
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise
        return DurableEffectIntentBoundary(witness)

    @staticmethod
    def _load_state(db, witness):
        rows = db.execute(_SELECT).fetchall()
        if len(rows) != 1:
            raise ValueError("invalid witness row count")
        return witness._decode(rows[0])

    @staticmethod
    def _pending_count(db):
        # Missing schema or corruption must fail closed, never initialize.
        return db.execute(
            "SELECT count(*) FROM effect_intent WHERE status='pending'"
        ).fetchone()[0]

    def pending_operations(self):
        """Recovery inspection only; never authorizes retry or release."""
        with closing(self._witness._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                rows = db.execute(
                    "SELECT operation_id FROM effect_intent "
                    "WHERE status='pending' ORDER BY operation_id"
                ).fetchall()
                db.execute("COMMIT")
                return [row[0] for row in rows]
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise

    def enact(self, operation_id, expected, local_permits, effect):
        if (type(operation_id) is not str or not
                (1 <= len(operation_id) <= 128) or
                not operation_id.isascii() or
                type(expected) is not dict or
                not callable(local_permits) or not callable(effect)):
            return {"ok": False, "code": "bad_request"}

        # Phase 1: durable reservation. Lock serializes with HOLD and other
        # admissions. An interrupted worker cannot erase this committed row.
        try:
            with closing(self._witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    state = self._load_state(db, self._witness)
                    if (self._pending_count(db) != 0 or
                            not _exact_unheld(state, expected) or
                            local_permits() is not True):
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "authorization_denied"}
                    db.execute(
                        "INSERT INTO effect_intent VALUES (?, 'pending', ?, ?, ?)",
                        (operation_id, expected["generation"],
                         expected["event_id"], expected["authority_ref"]))
                    db.execute("COMMIT")
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except Exception:
            # Duplicate operation_id is never retried, even if complete.
            return {"ok": False, "code": "intent_unavailable_or_duplicate"}

        # Phase 2: recheck after possible intervening HOLD and keep lock held
        # until effect returns. If killed or commit fails, pending remains.
        try:
            with closing(self._witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    state = self._load_state(db, self._witness)
                    rows = db.execute(
                        "SELECT status, generation, event_id, authority_ref "
                        "FROM effect_intent WHERE operation_id=?",
                        (operation_id,)).fetchall()
                    if (len(rows) != 1 or rows[0] !=
                            ("pending", expected["generation"],
                             expected["event_id"], expected["authority_ref"]) or
                            self._pending_count(db) != 1 or
                            not _exact_unheld(state, expected) or
                            local_permits() is not True):
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "pending_review_required"}
                    try:
                        outcome = effect()
                    except BaseException:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "outcome_uncertain"}
                    if type(outcome) is not dict or outcome.get("ok") is not True:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "outcome_uncertain"}
                    db.execute(
                        "UPDATE effect_intent SET status='complete' "
                        "WHERE operation_id=? AND status='pending'",
                        (operation_id,))
                    db.execute("COMMIT")
                    return outcome
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except Exception:
            return {"ok": False, "code": "outcome_uncertain"}
