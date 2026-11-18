"""Guard against promoting simulation or locally checked HOLD to universal G3.

These tests are purely offline; they never contact Zelda or deploy.
"""
import json
import os
from pathlib import Path
import subprocess
import sys
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(Path(__file__).resolve().parent))

from gmesh.daemon import audit_cycle
from gmesh.simulate import simulate, main as simulate_main
from gmesh.verify import verify_node
from koru_gmesh_research_key import load_research_key
from g_mesh_client import GMeshClient
from g_mesh_server import GMeshServer

KEY = "a1" * 32


class MeshTruthGates(unittest.TestCase):
    def test_no_default_or_malformed_research_auth_key(self):
        with patch.dict(os.environ, {}, clear=True):
            with self.assertRaisesRegex(ValueError, "missing/invalid"):
                load_research_key()
            with self.assertRaisesRegex(ValueError, "missing/invalid"):
                GMeshClient("n", "127.0.0.1", 9001)
            with self.assertRaisesRegex(ValueError, "missing/invalid"):
                GMeshServer("n", "127.0.0.1", 9001)
        with patch.dict(os.environ, {"UPT_GMESH_RESEARCH_HMAC_KEY_HEX": KEY}):
            self.assertEqual(load_research_key(), bytes.fromhex(KEY))
        with self.assertRaises(ValueError):
            load_research_key("00" * 32)

    def test_symmetric_transport_mac_is_not_a_quorum_vote(self):
        with patch.dict(os.environ, {"UPT_GMESH_RESEARCH_HMAC_KEY_HEX": KEY}):
            sender = GMeshClient("n", "127.0.0.1", 9001)
            receiver = GMeshServer("n", "127.0.0.1", 9001)
        payload = {"node_id": "research-node", "epoch": 1}
        signature = sender._sign_payload(payload)
        self.assertTrue(receiver._verify_signature(payload, signature))
        self.assertFalse(receiver._verify_signature({"epoch": 2}, signature))
        self.assertFalse(receiver._verify_signature(payload, "00" * 32))

    def test_daemon_never_fabricates_secure_lease(self):
        report = audit_cycle(now="reviewed-test-time")
        self.assertEqual(report["status"], "UNVERIFIED_NO_INDEPENDENT_EVIDENCE")
        self.assertFalse(report["authorizes_effect"])
        self.assertFalse(report["universal_physical_protection_proved"])
        self.assertFalse(report["may_clear_hold"])
        self.assertNotIn("lease_hash", report)

    def test_simulator_is_not_live_partition_or_healing(self):
        report = simulate(nodes=["a", "b", "c"], drop_ratio=0.4)
        self.assertTrue(report["simulation_only"])
        self.assertFalse(report["real_network_partition_injected"])
        self.assertFalse(report["real_failover_verified"])
        self.assertFalse(report["universal_physical_protection_proved"])
        self.assertEqual(simulate_main(
            ["--nodes", "a,b,c", "--verify-healing"]), 2)
        with self.assertRaises(ValueError):
            simulate(nodes=["a", "a"], drop_ratio=0.4)

    def test_local_source_check_does_not_promote_held_to_universal(self):
        class Run:
            def __init__(self):
                self.calls = []
            def __call__(self, argv, **kwargs):
                self.calls.append(argv)
                payload = ({"source_fingerprints_verified": True}
                           if argv[1] == "check"
                           else {"ready": True, "held": True, "generation": 2})
                return subprocess.CompletedProcess(argv, 0,
                                                   stdout=json.dumps(payload), stderr="")
        fake = Run()
        result = verify_node(node_id="synthetic-review", root=ROOT, run=fake)
        self.assertTrue(result["local_hold_observed"])
        self.assertFalse(result["universal_physical_protection_proved"])
        self.assertFalse(result["authorizes_effect"])
        self.assertEqual([argv[1] for argv in fake.calls], ["check", "status"])
        with self.assertRaisesRegex(ValueError, "strict universal"):
            verify_node(node_id="synthetic-review", strict=True, root=ROOT, run=Run())

    def test_missing_hold_or_source_integrity_rejected(self):
        def bad(argv, **kwargs):
            payload = ({"source_fingerprints_verified": False}
                       if argv[1] == "check"
                       else {"ready": True, "held": False, "generation": 2})
            return subprocess.CompletedProcess(argv, 0,
                                               stdout=json.dumps(payload), stderr="")
        with self.assertRaisesRegex(ValueError, "source integrity"):
            verify_node(node_id="n", root=ROOT, run=bad)
        def bad_hold(argv, **kwargs):
            payload = ({"source_fingerprints_verified": True}
                       if argv[1] == "check"
                       else {"ready": True, "held": False, "generation": 2})
            return subprocess.CompletedProcess(argv, 0,
                                               stdout=json.dumps(payload), stderr="")
        with self.assertRaisesRegex(ValueError, "ready/held"):
            verify_node(node_id="n", root=ROOT, run=bad_hold)


if __name__ == "__main__":
    unittest.main()
