"""Separate retained anchor survival and coordinated rollback counterexamples."""
import shutil
import tempfile
import unittest
from pathlib import Path
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_monotonic_revision_witness import MonotonicRevisionWitness
from koru_client_revision_floor import ClientRevisionFloor
from koru_two_witness_agreement import TwoWitnessAgreement
from koru_retained_third_anchor import AnchoredTwoWitnessAgreement


class RetainedAnchorTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix="g3-retained-anchor-")
        self.root=Path(self.temp.name)
        self.base=dict(generation=3, held=False,event_id="fixture",
                       authority_ref="fixed",pending_ids=[])
        self.ka=Ed25519PrivateKey.generate()
        self.kb=Ed25519PrivateKey.generate()
        self.a=MonotonicRevisionWitness.provision(
            str(self.root/"witness-a.sqlite"),self.ka,self.base)
        self.b=MonotonicRevisionWitness.provision(
            str(self.root/"witness-b.sqlite"),self.kb,self.base)
        self.floor=ClientRevisionFloor.provision(
            str(self.root/"observer.sqlite"),self.ka.public_key(),self.a.read())
        self.anchor=ClientRevisionFloor.provision(
            str(self.root/"anchor.sqlite"),self.ka.public_key(),self.a.read())
        self.guard=AnchoredTwoWitnessAgreement(
            TwoWitnessAgreement(self.floor,self.kb.public_key()),self.anchor)

    def tearDown(self):
        self.temp.cleanup()

    def advance_both(self,state):
        for witness in (self.a,self.b):
            old=witness.read()
            new=witness.advance(state,expected_revision=old["revision"],
                                expected_digest=old["digest"])
            self.assertTrue(new["ok"])

    def observe(self):
        return self.guard.accept_pair(self.a.read(),self.b.read())

    def backup(self,*paths):
        pairs=[]
        for i,path in enumerate(paths):
            old=str(self.root/("backup-"+str(i)+".sqlite"))
            shutil.copyfile(path,old)
            pairs.append((old,path))
        return pairs

    def restore(self,pairs):
        for old,path in pairs:
            shutil.copyfile(old,path)

    def test_agreed_genesis_retains_equal_anchor(self):
        self.assertEqual(self.observe()["revision"],0)
        self.assertEqual(self.anchor.read_floor(),self.floor.read_floor())

    def test_agreed_hold_advances_both_retained_floors(self):
        self.advance_both(dict(self.base,held=True))
        self.assertEqual(self.observe()["revision"],1)
        self.assertEqual(self.anchor.read_floor(),self.floor.read_floor())

    def test_rollback_three_prior_stores_anchor_survives_denies(self):
        old=self.backup(self.a.path,self.b.path,self.floor.path)
        self.advance_both(dict(self.base,held=True))
        self.observe()
        self.restore(old)
        with self.assertRaisesRegex(PermissionError,"anchor disagree"):
            self.observe()
        self.assertEqual(self.anchor.read_floor()[0],1)

    def test_rollback_only_anchor_denies(self):
        old=self.backup(self.anchor.path)
        self.advance_both(dict(self.base,held=True))
        self.observe()
        self.restore(old)
        with self.assertRaisesRegex(PermissionError,"anchor disagree"):
            self.observe()

    def test_conflicting_witnesses_leave_both_floors_unchanged(self):
        start=self.a.read()
        self.a.advance(dict(self.base,held=True),
                       expected_revision=start["revision"],
                       expected_digest=start["digest"])
        with self.assertRaisesRegex(PermissionError,"disagree"):
            self.observe()
        self.assertEqual(self.anchor.read_floor()[0],0)
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_second_store_commit_failure_denies_future_observations(self):
        self.advance_both(dict(self.base,held=True))
        original=self.floor.accept
        def deny(_receipt):
            raise OSError("simulated observer fsync failure")
        self.floor.accept=deny
        try:
            with self.assertRaises(OSError):
                self.observe()
        finally:
            self.floor.accept=original
        self.assertEqual(self.anchor.read_floor()[0],1)
        self.assertEqual(self.floor.read_floor()[0],0)
        with self.assertRaisesRegex(PermissionError,"anchor disagree"):
            self.observe()

    def test_all_four_stores_rollback_remains_counterexample(self):
        old=self.backup(
            self.a.path,self.b.path,self.floor.path,self.anchor.path)
        self.advance_both(dict(self.base,held=True))
        self.observe()
        self.restore(old)
        # A known limitation of SAME-HOST rollback of ALL ordinary files.
        self.assertEqual(self.observe()["revision"],0)

    def test_swapped_secondary_key_denied(self):
        with self.assertRaises((ValueError,PermissionError)):
            self.guard.accept_pair(self.a.read(),self.a.read())

    def test_distinct_anchor_path_required(self):
        with self.assertRaisesRegex(ValueError,"separate anchor"):
            AnchoredTwoWitnessAgreement(
                TwoWitnessAgreement(self.floor,self.kb.public_key()),
                self.floor)


if __name__ == "__main__":
    unittest.main()
