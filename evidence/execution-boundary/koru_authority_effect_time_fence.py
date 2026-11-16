"""Authority-ordered synthetic effect boundary for G3 research.

An *authority-side* callback executes while BEGIN IMMEDIATE on the SAME
authority DB serializes HOLD and admission. A prior admission is necessary,
but never sufficient: state is rechecked at effect time. Unresolved intent
is intentionally never cleared automatically even after a successful callback.
Crashes/exceptions therefore cannot automatically authorize another attempt.

IMPORTANT: this is a cooperative, same-host research fixture. An untrusted
writer capable of directly performing effects can BYPASS this Python API.
An OS effect is not atomically committed with SQLite. The authority DB may
be rolled back by host root; no physical/remote protection is established.
"""
from contextlib import closing
from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transaction_scoped_effect import _exact_unheld


class AuthorityEffectTimeFence:
    def __init__(self, journal):
        if not isinstance(journal, AuthorityAdmissionJournal):
            raise TypeError("authority-side admission journal required")
        self._journal = journal

    def execute_synthetic(self, operation_id, expected, local_permits, effect):
        """Execute only under authority DB lock; never retry uncertain work.

        Intended for a trusted authority-owned callback in a disposable test,
        NOT a writer-side permission API. The unresolved record is *retained*
        on every outcome. This conservative version admits at most one
        operation per fixture's entire history.
        """
        if (type(operation_id) is not str or
                not (1 <= len(operation_id) <= 128) or
                not operation_id.isascii() or type(expected) is not dict or
                not callable(local_permits) or not callable(effect)):
            return {"ok": False, "code": "bad_request"}
        authority = self._journal._authority
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
                    try:
                        outcome = effect()
                    except BaseException:
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "outcome_uncertain"}
                    if type(outcome) is not dict or outcome.get("ok") is not True:
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
