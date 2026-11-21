"""All-of-two G3 history observer tests, intentionally non-enforcing."""
import shutil
import tempfile
import unittest
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_monotonic_revision_witness import MonotonicRevisionWitness
from koru_client_revision_floor import ClientRevisionFloor
from koru_two_witness_agreement import (
    TwoWitnessAgreement, observe_two_mtls_witnesses)


class TwoWitnessAgreementTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-two-witness-")
        self.root = Path(self.temp.name)
        self.base = dict(generation=4, held=False, event_id="fixture",
                         authority_ref="ref", pending_ids=[])
        self.key_a = Ed25519PrivateKey.generate()
        self.key_b = Ed25519PrivateKey.generate()
        self.a = MonotonicRevisionWitness.provision(
            str(self.root/"a.sqlite"), self.key_a, self.base)
        self.b = MonotonicRevisionWitness.provision(
            str(self.root/"b.sqlite"), self.key_b, self.base)
        self.floor = ClientRevisionFloor.provision(
            str(self.root/"observer.sqlite"), self.key_a.public_key(),
            self.a.read())
        self.guard = TwoWitnessAgreement(self.floor,self.key_b.public_key())

    def tearDown(self):
        self.temp.cleanup()

    def advance(self, witness, snapshot):
        head = witness.read()
        return witness.advance(
            snapshot, expected_revision=head["revision"],
            expected_digest=head["digest"])["receipt"]

    def agree(self):
        return self.guard.accept_pair(self.a.read(),self.b.read())

    def test_agreed_genesis_signed_by_distinct_keys(self):
        result = self.agree()
        self.assertEqual(result["revision"],0)
        self.assertEqual(result["floor_result"],"already_observed")

    def test_agreed_new_hold_advances_observer_floor(self):
        state=dict(self.base,held=True)
        self.advance(self.a,state)
        self.advance(self.b,state)
        self.assertEqual(self.agree()["floor_result"],"observed_next")
        self.assertEqual(self.floor.read_floor()[0],1)

    def test_secondary_lag_denied_without_floor_update(self):
        self.advance(self.a,dict(self.base,held=True))
        with self.assertRaisesRegex(PermissionError,"disagree"):
            self.agree()
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_divergent_validly_signed_states_denied(self):
        self.advance(self.a,dict(self.base,held=True))
        self.advance(self.b,dict(self.base,pending_ids=["op"]))
        with self.assertRaisesRegex(PermissionError,"disagree"):
            self.agree()
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_forged_secondary_signature_denied(self):
        tampered=dict(self.b.read(),revision=9)
        with self.assertRaises(PermissionError):
            self.guard.accept_pair(self.a.read(),tampered)
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_repeated_primary_key_not_two_signers(self):
        with self.assertRaisesRegex(ValueError,"distinct"):
            TwoWitnessAgreement(self.floor,self.key_a.public_key())

    def test_swapped_signers_denied(self):
        with self.assertRaises(PermissionError):
            self.guard.accept_pair(self.b.read(),self.a.read())

    def test_missing_witness_response_denied(self):
        def missing():
            raise ConnectionError("witness B unavailable")
        with self.assertRaises(ConnectionError):
            observe_two_mtls_witnesses(
                lambda:{"ok":True,"code":"snapshot_only",
                        "receipt":self.a.read()},missing,agreement=self.guard)
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_uncertain_positive_not_accepted(self):
        first=lambda:{"ok":True,"code":"snapshot_only",
                      "receipt":self.a.read()}
        second=lambda:{"ok":False,"code":"uncertain"}
        with self.assertRaisesRegex(PermissionError,"missing or uncertain"):
            observe_two_mtls_witnesses(first,second,agreement=self.guard)
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_both_witnesses_rollback_observer_survives(self):
        old_a=str(self.root/"old-a.sqlite")
        old_b=str(self.root/"old-b.sqlite")
        shutil.copyfile(self.a.path,old_a)
        shutil.copyfile(self.b.path,old_b)
        state=dict(self.base,held=True)
        self.advance(self.a,state)
        self.advance(self.b,state)
        self.agree()
        shutil.copyfile(old_a,self.a.path)
        shutil.copyfile(old_b,self.b.path)
        with self.assertRaisesRegex(PermissionError,"rollback"):
            self.agree()
        self.assertEqual(self.floor.read_floor()[0],1)

    def test_all_three_stores_rollback_is_known_counterexample(self):
        old_a=str(self.root/"old-a.sqlite")
        old_b=str(self.root/"old-b.sqlite")
        old_floor=str(self.root/"old-floor.sqlite")
        shutil.copyfile(self.a.path,old_a)
        shutil.copyfile(self.b.path,old_b)
        shutil.copyfile(self.floor.path,old_floor)
        state=dict(self.base,held=True)
        self.advance(self.a,state)
        self.advance(self.b,state)
        self.agree()
        for original,target in ((old_a,self.a.path),(old_b,self.b.path),
                                (old_floor,self.floor.path)):
            shutil.copyfile(original,target)
        # Known same-host rollback weakness: all three now agree on old state.
        self.assertEqual(self.agree()["revision"],0)

    def test_malformed_pair_does_not_advance_floor(self):
        with self.assertRaises(ValueError):
            self.guard.accept_pair({},self.b.read())
        self.assertEqual(self.floor.read_floor()[0],0)


if __name__ == "__main__":
    unittest.main()
