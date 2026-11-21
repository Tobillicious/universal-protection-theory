"""Client-owned signed revision floor: independent retained state contrast.

Inherits the original nine mTLS cases as a regression suite, and adds floor
cases. The local test controls BOTH witness and observer databases: compromise
of both is a deliberately exposed counterexample, not a passed protection.
"""
import os
import shutil
from pathlib import Path

from koru_client_revision_floor import (
    ClientRevisionFloor, request_with_observer_floor)
from test_koru_mtls_revision_witness import MTLSRevisionWitnessTests


class ObserverFloorMTLSTests(MTLSRevisionWitnessTests):
    def setUp(self):
        super().setUp()
        self.floor_path=str(self.root/"observer.db")
        # Explicit fixture trust bootstrap from known original witness,
        # NOT auto-enrollment of a possibly rewound remote response.
        self.floor=ClientRevisionFloor.provision(
            self.floor_path,self.receipt_public,self.witness.read())

    def observed(self,query):
        return request_with_observer_floor(
            self.server.server_address,query,floor=self.floor,
            context=self.client_context,hostname="localhost",
            server_fingerprint=self.server_pin)

    def test_observer_accepts_genesis_and_signed_next_revision(self):
        a=self.observed({"op":"read"})["receipt"]
        self.assertEqual(a["revision"],0)
        b=self.observed(dict(op="advance",revision=a["revision"],
                             digest=a["digest"],
                             snapshot=dict(self.base,held=True)))["receipt"]
        self.assertEqual(b["revision"],1)
        self.assertEqual(self.floor.read_floor()[:2],(1,b["digest"]))
        self.assertEqual(self.observed({"op":"read"})["receipt"],b)

    def test_old_signed_receipt_rejected_if_observer_floor_survives(self):
        backed_up=str(self.root/"initial-witness.db")
        shutil.copyfile(self.witness.path,backed_up)
        a=self.observed({"op":"read"})["receipt"]
        self.observed(dict(op="advance",revision=a["revision"],
                           digest=a["digest"],
                           snapshot=dict(self.base,held=True)))
        self.assertEqual(self.floor.read_floor()[0],1)
        # Fixture privileged attacker restores *server* SQLite, not observer.
        shutil.copyfile(backed_up,self.witness.path)
        with self.assertRaisesRegex(PermissionError,"rollback"):
            self.observed({"op":"read"})
        self.assertEqual(self.floor.read_floor()[0],1)

    def test_same_revision_signed_fork_rejected(self):
        # Test key holder simulates a compromised/Byzantine signer.
        a=self.witness.read()
        from koru_monotonic_revision_witness import _digest
        from koru_signed_remote_hold_witness import _encoded
        fork=dict(a,digest=_digest(dict(self.base,held=True)))
        body={k:v for k,v in fork.items() if k!="signature"}
        fork["signature"]=self.receipt_key.sign(_encoded(body)).hex()
        with self.assertRaisesRegex(PermissionError,"fork"):
            self.floor.accept(fork)

    def test_signed_next_without_matching_predecessor_denied(self):
        a=self.witness.read()
        from koru_signed_remote_hold_witness import _encoded
        forged=dict(a,revision=1,previous_digest="a"*64)
        body={k:v for k,v in forged.items() if k!="signature"}
        forged["signature"]=self.receipt_key.sign(_encoded(body)).hex()
        with self.assertRaisesRegex(PermissionError,"divergent"):
            self.floor.accept(forged)

    def test_signed_revision_gap_denied_until_replay(self):
        a=self.witness.read()
        from koru_signed_remote_hold_witness import _encoded
        jump=dict(a,revision=2,previous_digest=a["digest"])
        body={k:v for k,v in jump.items() if k!="signature"}
        jump["signature"]=self.receipt_key.sign(_encoded(body)).hex()
        with self.assertRaisesRegex(PermissionError,"noncontiguous"):
            self.floor.accept(jump)

    def test_missing_observer_floor_denies_without_reprovision(self):
        os.unlink(self.floor_path)
        with self.assertRaises(Exception):
            self.observed({"op":"read"})
        self.assertFalse(Path(self.floor_path).exists())

    def test_observer_floor_survives_new_adapter_instance(self):
        first=self.observed({"op":"read"})["receipt"]
        self.observed(dict(op="advance",revision=first["revision"],
                           digest=first["digest"],
                           snapshot=dict(self.base,pending_ids=["op"])))
        reconstructed=ClientRevisionFloor(
            self.floor_path,self.receipt_public)
        self.assertEqual(reconstructed.read_floor(),self.floor.read_floor())
        self.assertEqual(reconstructed.accept(self.witness.read()),
                         "already_observed")

    def test_rollback_of_both_stores_is_unresolved_counterexample(self):
        # This is a KNOWN VULNERABILITY witness, not a security guarantee.
        old_server=str(self.root/"old-witness.db")
        old_observer=str(self.root/"old-observer.db")
        shutil.copyfile(self.witness.path,old_server)
        shutil.copyfile(self.floor_path,old_observer)
        initial=self.observed({"op":"read"})["receipt"]
        self.observed(dict(op="advance",revision=initial["revision"],
                           digest=initial["digest"],
                           snapshot=dict(self.base,held=True)))
        shutil.copyfile(old_server,self.witness.path)
        shutil.copyfile(old_observer,self.floor_path)
        # Both reverted: old valid signature is accepted. Not rollback-proof.
        self.assertEqual(self.observed({"op":"read"})["receipt"]["revision"],0)


if __name__=="__main__":
    import unittest
    unittest.main()
