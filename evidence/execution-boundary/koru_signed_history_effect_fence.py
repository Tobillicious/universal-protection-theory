"""Synthetic authority effect fence conditioned on two signed history reads.

Reuses #5xx AuthorityEffectTimeFence, #562 retained anchor and existing
pinned-mTLS request adapters. The signed receipts are historical evidence,
NOT effect permits. Require the digest of an explicitly unheld, known
protection snapshot and an exact authority identity match at BOTH authority
fence phases. Normal authority-side HOLD is serialized against effect under
its own SQLite transaction; witness-side HOLD is NOT ordered by that lock.

The protocol cannot prevent a remotely committed HOLD between a successful
witness read and the synthetic callback. Full cross-host effect-time
linearizability requires an independently administered, shared transaction
authority / consensus ordering or direct enforcement at the effect owner.
Do NOT deploy this research adapter as a production effect authorization.
"""
from koru_authority_effect_time_fence import AuthorityEffectTimeFence
from koru_monotonic_revision_witness import _digest, verify_receipt
from koru_retained_third_anchor import AnchoredTwoWitnessAgreement
from koru_two_witness_agreement import _BODY_FIELDS


class SignedHistorySyntheticEffectFence:
    def __init__(self, authority_fence, anchored):
        if (not isinstance(authority_fence, AuthorityEffectTimeFence) or
                not isinstance(anchored, AnchoredTwoWitnessAgreement)):
            raise TypeError("existing authority fence and anchored agreement required")
        self.authority_fence = authority_fence
        self.anchored = anchored

    def execute_synthetic(self, operation_id, expected, unheld_snapshot,
                          primary_read, secondary_read, local_permits, effect):
        """Both-phase signed observation, then original local policy.

        Every call to local_permits() made by the authority fence performs a
        new pair of authenticated witness reads; the adapter refuses missing
        or uncertain replies and NEVER supplies a success on exception.
        """
        if (type(expected) is not dict or
                set(expected) != {"generation","event_id","authority_ref"} or
                type(unheld_snapshot) is not dict or
                set(unheld_snapshot) != {"generation","held","event_id",
                                          "authority_ref","pending_ids"} or
                unheld_snapshot.get("held") is not False or
                any(unheld_snapshot.get(k) != expected.get(k)
                    for k in expected) or
                not callable(primary_read) or not callable(secondary_read) or
                primary_read is secondary_read or
                not callable(local_permits) or not callable(effect)):
            return {"ok": False, "code": "bad_request"}
        try:
            expected_digest = _digest(unheld_snapshot)
        except (ValueError, TypeError):
            return {"ok": False, "code": "bad_request"}

        def signed_and_local():
            try:
                p = primary_read()
                s = secondary_read()
                if (type(p) is not dict or type(s) is not dict or
                        p.get("ok") is not True or s.get("ok") is not True or
                        p.get("code") != "snapshot_only" or
                        s.get("code") != "snapshot_only"):
                    return False
                pair_a = verify_receipt(
                    p["receipt"],self.anchored.agreement.floor.public_key)
                pair_b = verify_receipt(
                    s["receipt"],
                    self.anchored.agreement.secondary_public_key)
                if any(pair_a[k] != pair_b[k] for k in _BODY_FIELDS):
                    return False
                if pair_a["digest"] != expected_digest:
                    return False
                result = self.anchored.accept_pair(p["receipt"],s["receipt"])
                if result["code"] != "two_witness_anchored_history_only":
                    return False
                return local_permits() is True
            except Exception:
                return False

        return self.authority_fence.execute_synthetic(
            operation_id,expected,signed_and_local,effect)
