"""Pinned dual-mTLS receipt checking inside the existing synthetic effect fence.

Research tests intentionally use local loopback and cooperating callbacks.
No OS effect mediation, remote HOLD atomicity, or independent host is proved.
"""
from pathlib import Path
from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_authority_effect_time_fence import AuthorityEffectTimeFence
from koru_transactional_hold_witness import TransactionalHoldWitness
from koru_retained_third_anchor import AnchoredTwoWitnessAgreement
from koru_signed_history_effect_fence import SignedHistorySyntheticEffectFence
from test_koru_dual_mtls_endpoints import TwoLiveMTLSEndpointTests


class SignedHistoryEffectFenceTests(TwoLiveMTLSEndpointTests):
    def setUp(self):
        super().setUp()
        self.expected = {k:self.base[k] for k in
                         ("generation","event_id","authority_ref")}
        state={k:self.base[k] for k in
               ("generation","held","event_id","authority_ref")}
        self.authority = TransactionalHoldWitness.provision(
            str(self.root/"effect-authority.sqlite"),state)
        self.journal = AuthorityAdmissionJournal.provision(self.authority)
        self.guard = AnchoredTwoWitnessAgreement(
            self.agreement,
            __import__("koru_client_revision_floor",
                       fromlist=["ClientRevisionFloor"]).ClientRevisionFloor.provision(
                str(self.root/"third-anchor.sqlite"),
                self.a["public"],self.a["witness"].read()))
        self.effect_fence=SignedHistorySyntheticEffectFence(
            AuthorityEffectTimeFence(self.journal),self.guard)
        self.marker=Path(self.root/"synthetic-effect.txt")

    def _read_a(self):
        return self._call(self.a,{"op":"read"})

    def _read_b(self):
        return self._call(self.b,{"op":"read"})

    def enact(self,*,permitted=None,first=None,second=None,effect=None):
        return self.effect_fence.execute_synthetic(
            "one",self.expected,dict(self.base),
            self._read_a if first is None else first,
            self._read_b if second is None else second,
            (lambda:True) if permitted is None else permitted,
            self.write_effect if effect is None else effect)

    def write_effect(self):
        self.marker.write_text("synthetic")
        return {"ok":True}

    def admit(self):
        self.assertEqual(self.journal.admit("one",self.expected)["code"],
                         "intent_recorded_only")

    def test_signed_two_witness_unheld_snapshot_allows_synthetic_effect(self):
        self.admit()
        result=self.enact()
        self.assertEqual(result["code"],"synthetic_effect_returned")
        self.assertEqual(self.marker.read_text(),"synthetic")
        self.assertFalse(self.enact()["ok"])

    def test_no_authority_admission_denies_even_with_matching_witnesses(self):
        self.assertEqual(self.enact()["code"],"effect_denied")
        self.assertFalse(self.marker.exists())

    def test_both_witnesses_held_deny_despite_signed_consensus(self):
        self.admit()
        held=dict(self.base,held=True)
        self._advance(self.a,held)
        self._advance(self.b,held)
        self.assertEqual(self.enact()["code"],"effect_denied")
        self.assertFalse(self.marker.exists())

    def test_one_witness_hold_denies_divergent_receipts(self):
        self.admit()
        self._advance(self.a,dict(self.base,held=True))
        self.assertEqual(self.enact()["code"],"effect_denied")
        self.assertFalse(self.marker.exists())

    def test_remote_hold_after_first_check_denied_at_effect_time(self):
        self.admit()
        calls=[0]
        def local_policy():
            calls[0]+=1
            if calls[0]==1:
                held=dict(self.base,held=True)
                self._advance(self.a,held)
                self._advance(self.b,held)
            return True
        # Both witnesses HOLD after phase-1 checks but before phase-2.
        self.assertEqual(
            self.enact(permitted=local_policy)["code"],
            "effect_denied_after_start")
        self.assertEqual(calls[0],1)
        self.assertFalse(self.marker.exists())
        self.assertFalse(self.enact()["ok"])

    def test_missing_second_witness_denies_before_effect(self):
        self.admit()
        def unavailable():
            raise ConnectionError("simulated witness outage")
        self.assertEqual(self.enact(second=unavailable)["code"],
                         "effect_denied")
        self.assertFalse(self.marker.exists())

    def test_local_policy_denial_cannot_be_overridden_by_signatures(self):
        self.admit()
        self.assertEqual(self.enact(permitted=lambda:False)["code"],
                         "effect_denied")
        self.assertFalse(self.marker.exists())

    def test_rolled_back_or_missing_retained_anchor_denies(self):
        self.admit()
        Path(self.guard.anchor.path).unlink()
        self.assertEqual(self.enact()["code"],"effect_denied")
        self.assertFalse(self.marker.exists())

    def test_effect_callback_failure_is_uncertain_and_not_replayed(self):
        self.admit()
        def partial_effect():
            self.marker.write_text("partial")
            raise RuntimeError("incomplete write")
        self.assertEqual(self.enact(effect=partial_effect)["code"],
                         "outcome_uncertain")
        self.assertEqual(self.marker.read_text(),"partial")
        self.marker.unlink()
        self.assertFalse(self.enact()["ok"])
        self.assertFalse(self.marker.exists())


    def test_remote_hold_after_final_read_is_known_race_counterexample(self):
        # Deliberate failing guarantee, recorded as a PASSING counterexample:
        # phase-2 reads both unheld witnesses; before the effect callback,
        # a remote witness HOLD commits without acquiring the local authority
        # SQLite lock. This adapter alone cannot prevent the callback.
        self.admit()
        calls=[0]
        def vulnerable_window():
            calls[0]+=1
            if calls[0]==2:
                held=dict(self.base,held=True)
                self._advance(self.a,held)
                self._advance(self.b,held)
            return True
        result=self.enact(permitted=vulnerable_window)
        self.assertEqual(result["code"],"synthetic_effect_returned")
        self.assertTrue(self.marker.exists())
        self.assertTrue(self.a["witness"].read()["revision"]==1)
        # Do NOT consider this passed test proof of remote HOLD exclusion.

if __name__=="__main__":
    import unittest
    unittest.main()
