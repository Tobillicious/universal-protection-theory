"""Safe recovery of anchored observer partial writes: synthetic tests only."""
import os
import shutil
import tempfile
import unittest
from pathlib import Path
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_monotonic_revision_witness import MonotonicRevisionWitness
from koru_client_revision_floor import ClientRevisionFloor
from koru_two_witness_agreement import TwoWitnessAgreement
from koru_retained_third_anchor import AnchoredTwoWitnessAgreement
from koru_anchor_partial_recovery import (
    recover_anchor_first_partial_commit, recover_from_two_authenticated_reads)


class OneStepRecoveryTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-partial-recovery-")
        root = Path(self.temp.name)
        self.ka = Ed25519PrivateKey.generate()
        self.kb = Ed25519PrivateKey.generate()
        self.base = dict(generation=3,held=False,event_id="fixture",
                         authority_ref="fixed",pending_ids=[])
        self.a = MonotonicRevisionWitness.provision(
            str(root/"a.sqlite"), self.ka, self.base)
        self.b = MonotonicRevisionWitness.provision(
            str(root/"b.sqlite"), self.kb, self.base)
        self.floor = ClientRevisionFloor.provision(
            str(root/"client.sqlite"), self.ka.public_key(), self.a.read())
        self.anchor = ClientRevisionFloor.provision(
            str(root/"anchor.sqlite"), self.ka.public_key(), self.a.read())
        self.anchored = AnchoredTwoWitnessAgreement(
            TwoWitnessAgreement(self.floor, self.kb.public_key()), self.anchor)

    def tearDown(self):
        self.temp.cleanup()

    def advance_both(self, state):
        for witness in (self.a,self.b):
            current = witness.read()
            outcome = witness.advance(
                state,expected_revision=current["revision"],
                expected_digest=current["digest"])
            self.assertTrue(outcome["ok"])

    def create_partial_commit(self):
        self.advance_both(dict(self.base,held=True))
        # The durable anchor has successfully committed but the second
        # (client observation) fsync/transaction did not happen.
        self.assertEqual(self.anchor.accept(self.a.read()),"observed_next")
        self.assertEqual(self.anchor.read_floor()[0],1)
        self.assertEqual(self.floor.read_floor()[0],0)

    def recover(self):
        return recover_anchor_first_partial_commit(
            self.anchored,self.a.read(),self.b.read())

    def test_one_step_contiguous_repair_and_normal_observation(self):
        self.create_partial_commit()
        self.assertEqual(self.recover()["revision"],1)
        self.assertEqual(self.floor.read_floor(),self.anchor.read_floor())
        self.assertEqual(self.anchored.accept_pair(
            self.a.read(),self.b.read())["revision"],1)

    def test_normal_observation_denies_before_explicit_repair(self):
        self.create_partial_commit()
        with self.assertRaisesRegex(PermissionError,"anchor disagree"):
            self.anchored.accept_pair(self.a.read(),self.b.read())
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_repair_denied_when_not_needed(self):
        with self.assertRaisesRegex(PermissionError,"not exactly one"):
            self.recover()

    def test_repair_denied_on_forged_second_signature(self):
        self.create_partial_commit()
        rogue=dict(self.b.read(),revision=99)
        with self.assertRaises(PermissionError):
            recover_anchor_first_partial_commit(
                self.anchored,self.a.read(),rogue)
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_repair_denied_if_other_witness_lags(self):
        first_a=self.a.read()
        first_b=self.b.read()
        self.create_partial_commit()
        with self.assertRaisesRegex(PermissionError,"disagree"):
            recover_anchor_first_partial_commit(
                self.anchored,self.a.read(),first_b)
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_repair_denied_on_rolled_back_primary_journal(self):
        old_a=self.a.read()
        self.create_partial_commit()
        with self.assertRaisesRegex(PermissionError,"disagree"):
            recover_anchor_first_partial_commit(
                self.anchored,old_a,self.b.read())
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_repair_denied_on_rolled_back_retained_anchor(self):
        self.create_partial_commit()
        old_floor=self.floor.read_floor()
        # In this case anchor rollback makes the stores equal, not ahead.
        # Recovery must not silently accept it.
        self.assertEqual(self.anchor.path.endswith("anchor.sqlite"),True)
        shutil.copyfile(self.floor.path,self.anchor.path)
        with self.assertRaisesRegex(PermissionError,"do not match surviving anchor"):
            self.recover()
        self.assertEqual(self.floor.read_floor(),old_floor)

    def test_repair_denied_if_client_floor_missing(self):
        self.create_partial_commit()
        os.unlink(self.floor.path)
        with self.assertRaises(Exception):
            self.recover()
        self.assertFalse(os.path.exists(self.floor.path))

    def test_repair_denied_with_noncontiguous_two_revision_gap(self):
        self.create_partial_commit()
        # A further legitimate state becomes durable at both witnesses and
        # anchor, but not observer. A single-step recovery is insufficient.
        state=dict(self.base,held=True,pending_ids=["op"])
        self.advance_both(state)
        self.anchor.accept(self.a.read())
        with self.assertRaisesRegex(PermissionError,"not exactly one"):
            self.recover()
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_auth_read_adapter_success_reconciles(self):
        self.create_partial_commit()
        def primary():
            return dict(ok=True,code="snapshot_only",receipt=self.a.read())
        def secondary():
            return dict(ok=True,code="snapshot_only",receipt=self.b.read())
        result=recover_from_two_authenticated_reads(
            primary,secondary,anchored=self.anchored)
        self.assertEqual(result["revision"],1)

    def test_auth_read_adapter_uncertain_denies(self):
        self.create_partial_commit()
        def primary():
            return dict(ok=True,code="snapshot_only",receipt=self.a.read())
        def uncertain():
            return dict(ok=False,code="witness_unavailable_or_uncertain")
        with self.assertRaisesRegex(PermissionError,"missing or uncertain"):
            recover_from_two_authenticated_reads(
                primary,uncertain,anchored=self.anchored)
        self.assertEqual(self.floor.read_floor()[0],0)


if __name__=="__main__":
    unittest.main()
