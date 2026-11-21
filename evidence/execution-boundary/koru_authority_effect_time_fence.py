"""Authority-ordered, once-started synthetic effects for G3 research.

Authority-side DB writes a durable 'started' marker BEFORE effect callback.
A restart cannot re-invoke the same operation. The second transaction rechecks
HOLD then holds the same SQLite lock through the callback: HOLD-first denies,
effect-first forces HOLD to wait for callback completion.

A crash after 'started' may mean NOTHING happened or an external effect was
partially completed. Both remain blocked pending independently controlled
reconciliation; there is no automated retry or reset.

Research ONLY: a cooperating same-host callback, not an OS confinement layer,
external remote authority, anti-rollback storage or physical protection proof.
"""
from contextlib import closing
from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transaction_scoped_effect import _exact_unheld


class AuthorityEffectTimeFence:
    def __init__(self, journal):
        if not isinstance(journal, AuthorityAdmissionJournal):
            raise TypeError("authority journal required")
        self._journal = journal

    def execute_synthetic(self, operation_id, expected, local_permits, effect):
        if (type(operation_id) is not str or
                not (1 <= len(operation_id) <= 128) or
                not operation_id.isascii() or type(expected) is not dict or
                not callable(local_permits) or not callable(effect)):
            return {"ok": False, "code": "bad_request"}
        authority = self._journal._authority

        # Phase 1: exactly one caller transitions unresolved -> started and
        # commits BEFORE any effect. Subsequent calls cannot execute.
        try:
            with closing(authority._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    state = DurableEffectIntentBoundary._load_state(db, authority)
                    rows = db.execute(
                        "SELECT operation_id, generation, event_id, "
                        "authority_ref, state FROM authority_admissions"
                    ).fetchall()
                    if (len(rows) != 1 or rows[0] !=
                            (operation_id, expected["generation"],
                             expected["event_id"], expected["authority_ref"],
                             "unresolved") or
                            not _exact_unheld(state, expected) or
                            local_permits() is not True):
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "effect_denied"}
                    db.execute(
                        "UPDATE authority_admissions SET state='started' "
                        "WHERE operation_id=? AND state='unresolved'",
                        (operation_id,))
                    db.execute("COMMIT")
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except Exception:
            return {"ok": False, "code": "authority_unavailable_or_uncertain"}

        # Phase 2: HOLD may have landed since phase 1; recheck under SAME
        # authority lock and keep it held through the actual callback.
        # 'started' is permanent even on denial / crash / successful callback.
        try:
            with closing(authority._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    state = DurableEffectIntentBoundary._load_state(db, authority)
                    rows = db.execute(
                        "SELECT operation_id, generation, event_id, "
                        "authority_ref, state FROM authority_admissions"
                    ).fetchall()
                    if (len(rows) != 1 or rows[0] !=
                            (operation_id, expected["generation"],
                             expected["event_id"], expected["authority_ref"],
                             "started") or
                            not _exact_unheld(state, expected) or
                            local_permits() is not True):
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "effect_denied_after_start"}
                    try:
                        result = effect()
                    except BaseException:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "outcome_uncertain"}
                    if type(result) is not dict or result.get("ok") is not True:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "outcome_uncertain"}
                    db.execute("COMMIT")
                    return {"ok": True, "code": "synthetic_effect_returned"}
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except Exception:
            return {"ok": False, "code": "authority_unavailable_or_uncertain"}
