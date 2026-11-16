"""Authority-ordered synthetic HOLD and effect operations (research only).

The #563 remote witness read-before-effect has a known TOCTOU counterexample.
This fixture removes a *competing* remote-HOLD commit path from the tested
contract: a HOLD is acknowledged ONLY after the SAME authority journal that
serializes the synthetic effect commits it. Witness replication, if any,
happens AFTER durable authority HOLD and cannot turn failure into unheld.

All callers MUST submit HOLD through this trusted authority boundary;
remote replica writes cannot independently define authoritative HOLD.
Network transport authentication, off-host admin, anti-rollback storage,
process confinement, physical effect ownership and cross-host availability
are NOT supplied here. This is NOT safe deployment authorization.
"""
from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_authority_effect_time_fence import AuthorityEffectTimeFence


class AuthorityOrderedHoldEffect:
    """Single cooperating effect-owner serialization domain."""

    def __init__(self, journal):
        if not isinstance(journal, AuthorityAdmissionJournal):
            raise TypeError("provisioned authority journal required")
        self.journal = journal
        self.fence = AuthorityEffectTimeFence(journal)

    def submit_hold(self, *, publish=None):
        """Commit irreversible authority HOLD before any replica notification.

        publish is merely a best-effort *notification* to existing witness
        replicas, never the authoritative HOLD or effect permission.
        A publication exception must not undo the already committed HOLD.
        """
        if publish is not None and not callable(publish):
            return {"ok": False, "code": "bad_request"}
        try:
            state = self.journal.hold()
            if (type(state) is not dict or state.get("held") is not True):
                return {"ok": False, "code": "hold_commit_uncertain"}
        except Exception:
            return {"ok": False, "code": "hold_commit_uncertain"}
        try:
            if publish is not None:
                publish(dict(state))
        except Exception:
            return {"ok": True, "code": "hold_committed_publication_uncertain"}
        return {"ok": True, "code": "hold_committed_authority"}

    def admit(self, operation_id, expected):
        """Durable admission record, explicitly NOT effect permission."""
        return self.journal.admit(operation_id, expected)

    def enact_synthetic(self, operation_id, expected, local_permits, effect):
        """Reuses authority's once-started, hold-serialized callback boundary."""
        return self.fence.execute_synthetic(
            operation_id, expected, local_permits, effect)
