"""Race and failure contrast: authority-owned HOLD vs synthetic effect."""
import tempfile
import threading
import unittest
from pathlib import Path

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_transactional_hold_witness import TransactionalHoldWitness
from koru_authority_ordered_hold_effect import AuthorityOrderedHoldEffect


class OrderedHoldEffectTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory(prefix="g3-ordered-effect-")
        self.path=str(Path(self.tmp.name)/"authority.sqlite")
        self.marker=Path(self.tmp.name)/"effect.txt"
        self.initial=dict(generation=5,held=False,
                          event_id="event",authority_ref="ref")
        self.expected={key:self.initial[key]
                       for key in ("generation","event_id","authority_ref")}
        self.witness=TransactionalHoldWitness.provision(self.path,self.initial)
        self.journal=AuthorityAdmissionJournal.provision(self.witness)
        self.system=AuthorityOrderedHoldEffect(self.journal)

    def tearDown(self):
        self.tmp.cleanup()

    def admit(self):
        self.assertEqual(self.system.admit("once",self.expected)["code"],
                         "intent_recorded_only")

    def effect(self):
        self.marker.write_text("synthetic")
        return {"ok":True}

    def enact(self,policy=None,effect=None):
        return self.system.enact_synthetic(
            "once",self.expected,
            (lambda:True) if policy is None else policy,
            self.effect if effect is None else effect)

    def test_hold_acknowledged_before_effect_denies(self):
        self.admit()
        self.assertEqual(self.system.submit_hold()["code"],
                         "hold_committed_authority")
        self.assertEqual(self.enact()["code"],"effect_denied")
        self.assertFalse(self.marker.exists())

    def test_replica_notification_failure_cannot_undo_authority_hold(self):
        self.admit()
        def lost(_state):
            raise ConnectionError("remote replica unreachable")
        out=self.system.submit_hold(publish=lost)
        self.assertEqual(out["code"],"hold_committed_publication_uncertain")
        self.assertTrue(self.witness.read()["held"])
        self.assertFalse(self.enact()["ok"])
        self.assertFalse(self.marker.exists())

    def test_notification_observes_committed_hold(self):
        recorded=[]
        def published(state):
            observed=self.witness.read()
            self.assertTrue(observed["held"])
            self.assertEqual(observed,state)
            recorded.append(state)
        out=self.system.submit_hold(publish=published)
        self.assertEqual(out["code"],"hold_committed_authority")
        self.assertEqual(len(recorded),1)

    def test_durable_hold_refuses_after_restart(self):
        self.admit()
        self.assertTrue(self.system.submit_hold()["ok"])
        fresh=AuthorityOrderedHoldEffect(
            AuthorityAdmissionJournal(TransactionalHoldWitness(self.path)))
        self.assertEqual(fresh.enact_synthetic(
            "once",self.expected,lambda:True,self.effect)["code"],
            "effect_denied")
        self.assertFalse(self.marker.exists())

    def test_missing_authority_cannot_fallback_to_remote_replica(self):
        self.admit()
        Path(self.path).unlink()
        out=self.system.submit_hold()
        self.assertFalse(out["ok"])
        self.assertFalse(self.enact()["ok"])
        self.assertFalse(self.marker.exists())
        self.assertFalse(Path(self.path).exists())

    def test_effect_first_hold_cannot_be_acknowledged_mid_callback(self):
        self.admit()
        entered=threading.Event()
        release=threading.Event()
        hold_attempt=threading.Event()
        hold_done=threading.Event()
        effect_out=[]
        hold_out=[]
        def callback():
            entered.set()
            if not release.wait(2):
                raise TimeoutError("callback not released")
            self.marker.write_text("effect-first")
            return {"ok":True}
        def run_effect():
            effect_out.append(self.enact(effect=callback))
        def run_hold():
            hold_attempt.set()
            hold_out.append(self.system.submit_hold())
            hold_done.set()
        t1=threading.Thread(target=run_effect)
        t2=threading.Thread(target=run_hold)
        try:
            t1.start()
            self.assertTrue(entered.wait(1))
            t2.start()
            self.assertTrue(hold_attempt.wait(1))
            self.assertFalse(hold_done.wait(.12),
                             "HOLD falsely acknowledged while effect active")
        finally:
            release.set()
            t1.join(3)
            if t2.ident is not None:
                t2.join(3)
        self.assertFalse(t1.is_alive())
        self.assertFalse(t2.is_alive())
        self.assertEqual(effect_out[0]["code"],"synthetic_effect_returned")
        self.assertTrue(hold_done.is_set())
        self.assertTrue(hold_out[0]["ok"])
        self.assertTrue(self.witness.read()["held"])

    def test_final_policy_to_effect_gap_now_ordered_for_authority_hold(self):
        self.admit()
        hold_launched=threading.Event()
        hold_done=threading.Event()
        hold_out=[]
        calls=[0]
        workers=[]
        def hold_worker():
            hold_launched.set()
            hold_out.append(self.system.submit_hold())
            hold_done.set()
        def policy():
            calls[0]+=1
            if calls[0]==2:
                t=threading.Thread(target=hold_worker)
                workers.append(t)
                t.start()
                self.assertTrue(hold_launched.wait(1))
                self.assertFalse(hold_done.wait(.12),
                                 "HOLD committed during phase-2 authority lock")
            return True
        try:
            result=self.enact(policy=policy)
        finally:
            for worker in workers:
                worker.join(3)
        self.assertEqual(calls[0],2)
        self.assertEqual(result["code"],"synthetic_effect_returned")
        self.assertEqual(self.marker.read_text(),"synthetic")
        self.assertTrue(hold_done.is_set())
        self.assertEqual(hold_out[0]["code"],"hold_committed_authority")
        self.assertTrue(self.witness.read()["held"])
        # Effect-first ordering is legitimate: HOLD cannot be reported
        # committed until after callback returns.

    def test_callback_failure_does_not_make_started_operation_retryable(self):
        self.admit()
        def broken():
            self.marker.write_text("partial")
            raise RuntimeError("synthetic partial effect")
        self.assertEqual(self.enact(effect=broken)["code"],"outcome_uncertain")
        self.marker.unlink()
        self.assertFalse(self.enact()["ok"])
        self.assertFalse(self.marker.exists())

    def test_invalid_notification_rejected_without_hold(self):
        self.assertEqual(self.system.submit_hold(publish=object())["code"],
                         "bad_request")
        self.assertFalse(self.witness.read()["held"])


if __name__=="__main__":
    unittest.main()
