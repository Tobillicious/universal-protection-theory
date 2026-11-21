"""Read-only signed-checkpoint comparison for authority admission history.

Contrasts the #547/#548 authority witness + unresolved/started journal with
#546's independently *assumed* signed, nonce-bound checkpoint reader. The
signed checkpoint is mapped onto the existing fields, pending_ids records
all nonterminal operation IDs (including 'started').

This is a conservative comparison, never a permit or an effect-time lock.
It detects rollback ONLY if the external checkpoint remains authentic,
fresh and outside the rollback domain. The same-host fixture does NOT
satisfy that production trust assumption. Nor can this v1 snapshot
differentiate unresolved from started for identical operation IDs;
neither state grants a retry. No automatic reconciliation.
"""
from contextlib import closing

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_external_checkpoint_contrast import _valid_checkpoint


def read_authority_checkpoint(journal):
    """Inspect canonical authority state without provisioning or mutating it."""
    if not isinstance(journal, AuthorityAdmissionJournal):
        raise TypeError("authority admission journal required")
    witness = journal._authority
    with closing(witness._connect()) as db:
        db.execute("BEGIN IMMEDIATE")
        try:
            state = DurableEffectIntentBoundary._load_state(db, witness)
            rows = db.execute(
                "SELECT operation_id, generation, event_id, authority_ref, "
                "state FROM authority_admissions ORDER BY operation_id"
            ).fetchall()
            if (len(rows) > 1 or
                    any(type(op) is not str or len(op) < 1 or len(op) > 128 or
                        not op.isascii() or
                        g != state["generation"] or e != state["event_id"] or
                        a != state["authority_ref"] or
                        phase not in ("unresolved", "started")
                        for op, g, e, a, phase in rows)):
                raise ValueError("invalid or inconsistent admission history")
            snapshot = dict(state, pending_ids=[row[0] for row in rows])
            if not _valid_checkpoint(snapshot):
                raise ValueError("invalid authority checkpoint")
            db.execute("COMMIT")
            return snapshot
        except BaseException:
            if db.in_transaction:
                db.execute("ROLLBACK")
            raise


class AuthorityAdmissionCheckpointContrast:
    """Read-only; a valid comparison is NOT an execution authorization."""

    def __init__(self, journal, trusted_checkpoint_read):
        if (not isinstance(journal, AuthorityAdmissionJournal) or
                not callable(trusted_checkpoint_read)):
            raise TypeError("journal and authenticated checkpoint reader required")
        self._journal = journal
        self._read = trusted_checkpoint_read

    def preflight(self):
        try:
            remote = self._read()
            if not _valid_checkpoint(remote):
                return False, "checkpoint_invalid"
            local = read_authority_checkpoint(self._journal)
            if local != remote:
                return False, "checkpoint_mismatch"
            if remote["held"] or remote["pending_ids"]:
                return False, "held_or_admission_unresolved"
            return True, "consistent_snapshot_only"
        except Exception:
            return False, "checkpoint_unavailable"
