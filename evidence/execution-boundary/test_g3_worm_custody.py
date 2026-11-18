"""Hostile bounded G3 WORM handoff regressions; synthetic evidence only."""
import hashlib
import json
import tempfile
import unittest
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from g3_r6_same_event_evidence_audit import SIX
from koru_operator_checkpoint_recovery import DOMAIN, _encode
from g3_worm_custody import assemble, inspect, local_write_once

HEAD = "a" * 40
NONCE = "b" * 64

class WormCustodyTests(unittest.TestCase):
    def setUp(self):
        self.signer = Ed25519PrivateKey.generate()
        self.floor = (2, "c" * 64, "d" * 64)
        body = dict(domain=DOMAIN, nonce=NONCE, revision=self.floor[0],
                    digest=self.floor[1], previous_digest=self.floor[2])
        self.response = dict(body, signature=self.signer.sign(_encode(body)).hex())
        self.packet = {"schema": "g3-r6-zelda-observed-events-v1",
            "source_commit": HEAD, "scope": "synthetic fixed marker",
            "declared_paths": ["marker"],
            "events": [{"event_id": "e1", "effect_path": "marker",
                "before_sha256": "0" * 64, "after_sha256": "1" * 64,
                "observer_ref": "observer", "actor_ref": "actor"}],
            "owed_by_event": {"e1": ["subject"]},
            "duties_by_event": {"e1": {"subject": {
                d: {"status": "supported", "evidence_ref": "e1-subject-" + d}
                for d in SIX}}}}
        self.inventory = {"schema": "g3-r5-physical-inventory-v1",
            "source_commit": HEAD, "scope": "synthetic fixed marker",
            "observed_event_ids": ["e1"], "effect_paths": ["marker"],
            "examined_bypass_classes": [],
            "unexamined_bypass_classes": ["privileged_host_admin"],
            "observer_ref": "synthetic"}

    def inputs(self):
        return dict(event_bytes=json.dumps(self.packet).encode(),
                    inventory_bytes=json.dumps(self.inventory).encode(),
                    expected_commit=HEAD, operator_response=self.response,
                    challenge_nonce=NONCE, expected_floor=self.floor,
                    operator_public_key=self.signer.public_key())

    def test_valid_scoped_bundle_remains_on_hold(self):
        args = self.inputs()
        raw = assemble(**args)
        verification = inspect(bundle_bytes=raw,
            **{k: v for k, v in args.items() if k != "operator_response"})
        self.assertTrue(verification["operator_signature_verified"])
        self.assertFalse(verification["universal_G3_proved"])
        self.assertFalse(verification["independent_custody_verified"])
        self.assertTrue(verification["unresolved"])

    def test_inventory_substitution_detected(self):
        args = self.inputs()
        raw = assemble(**args)
        altered = dict(self.inventory, unexamined_bypass_classes=["network_sockets"])
        args["inventory_bytes"] = json.dumps(altered).encode()
        with self.assertRaises(ValueError):
            inspect(bundle_bytes=raw,
                **{k: v for k, v in args.items() if k != "operator_response"})

    def test_event_substitution_detected(self):
        args = self.inputs()
        raw = assemble(**args)
        args["event_bytes"] += b" "
        with self.assertRaises(ValueError):
            inspect(bundle_bytes=raw,
                **{k: v for k, v in args.items() if k != "operator_response"})

    def test_stale_floor_and_nonce_denied(self):
        args = self.inputs()
        with self.assertRaises(PermissionError):
            assemble(**dict(args, expected_floor=(1, "c"*64, "d"*64)))
        with self.assertRaises(PermissionError):
            assemble(**dict(args, challenge_nonce="e"*64))

    def test_forged_operator_signature_denied(self):
        args = self.inputs()
        args["operator_response"] = dict(self.response, signature="00"*64)
        with self.assertRaises(PermissionError):
            assemble(**args)

    def test_claim_escalation_and_duplicate_json_denied(self):
        args = self.inputs()
        raw = assemble(**args)
        check = {k: v for k, v in args.items() if k != "operator_response"}
        tampered = json.loads(raw)
        tampered["universal_G3_proved"] = True
        with self.assertRaises(ValueError):
            inspect(bundle_bytes=json.dumps(tampered).encode(), **check)
        with self.assertRaises(ValueError):
            inspect(bundle_bytes=raw[:-1] + b', "scope": "fake"}', **check)

    def test_local_exclusive_write_and_tamper_detection(self):
        args = self.inputs()
        raw = assemble(**args)
        check = {k: v for k, v in args.items() if k != "operator_response"}
        with tempfile.TemporaryDirectory() as directory:
            name = local_write_once(directory, raw)
            with self.assertRaises(FileExistsError):
                local_write_once(directory, raw)
            target = Path(directory) / name
            target.write_bytes(b"tampered")
            with self.assertRaises(ValueError):
                inspect(bundle_bytes=target.read_bytes(), **check)

    def test_directory_symlink_and_unsafe_permissions_denied(self):
        raw = assemble(**self.inputs())
        with tempfile.TemporaryDirectory() as directory:
            p = Path(directory)
            (p / "real").mkdir()
            (p / "link").symlink_to(p / "real", target_is_directory=True)
            with self.assertRaises(OSError):
                local_write_once(str(p / "link"), raw)
            (p / "real").chmod(0o777)
            with self.assertRaises(ValueError):
                local_write_once(str(p / "real"), raw)

if __name__ == "__main__":
    unittest.main()
