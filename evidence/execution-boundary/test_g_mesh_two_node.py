"""Two independently durable, OFFLINE G-Mesh nodes; simulated transport faults.

No real network, hardware, provider or external physical effect. Messages
are explicitly delivered/dropped/reordered by this test; authorizations are
only handshake admissions, NOT permission for actual world enactments.
"""
import tempfile
import threading
import unittest
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from g_mesh_protocol import GMeshProtocolHandler, GMeshState, PROTOCOL, encode_body


class TwoNodeAdversarialSimulation(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="gmesh-nodes-")
        self.root = Path(self.temp.name)
        self.issuer = Ed25519PrivateKey.generate()
        self.controller = Ed25519PrivateKey.generate()
        self.now = [20]
        self.opts = {}
        self.nodes = {}
        for label in ("alpha", "beta"):
            self.opts[label] = dict(
                node_id=label,
                deployment_id="offline-simulation",
                policy_digest="a" * 64,
                issuer_keys={"issuer": self.issuer.public_key()},
                controller_keys={"controller": self.controller.public_key()},
                clock=lambda: self.now[0],
                require_fresh_lease=True, max_lease_seconds=10)
            self.nodes[label] = GMeshProtocolHandler(
                str(self.root / (label + ".sqlite")), **self.opts[label])

    def tearDown(self):
        for node in self.nodes.values():
            node.close()
        self.temp.cleanup()

    def packet(self, target, sequence, *, not_after=100):
        return dict(protocol=PROTOCOL, type="handshake",
                    source_node_id="issuer", target_node_id=target,
                    deployment_id="offline-simulation",
                    event_digest="b" * 64, policy_digest="a" * 64,
                    authority_ref="test-authority", generation=1,
                    sequence=sequence, not_after=not_after,
                    attestation_ref="unverified-simulation-reference")

    def lease(self, target, sequence, *, deadline=25):
        return dict(protocol=PROTOCOL, type="lease",
                    source_node_id="controller", target_node_id=target,
                    deployment_id="offline-simulation",
                    policy_digest="a" * 64, generation=1,
                    sequence=sequence, not_after=deadline)

    def revoke(self, target, sequence, *, generation=2):
        return dict(protocol=PROTOCOL, type="revoke",
                    source_node_id="controller", target_node_id=target,
                    deployment_id="offline-simulation",
                    authority_ref="test-authority", generation=generation,
                    sequence=sequence, reason_code="OFFLINE_TEST_HOLD")

    def deliver_lease(self, target, seq, *, deadline=25):
        event = self.lease(target, seq, deadline=deadline)
        return self.nodes[target].install_authority_lease(
            event, self.controller.sign(encode_body(event)))

    def deliver_request(self, target, seq, *, not_after=100):
        event = self.packet(target, seq, not_after=not_after)
        return self.nodes[target].process_handshake(
            event, self.issuer.sign(encode_body(event)))

    def deliver_hold(self, target, seq):
        event = self.revoke(target, seq)
        return self.nodes[target].handle_revocation_broadcast(
            event, self.controller.sign(encode_body(event)))

    def test_no_lease_means_both_nodes_fail_closed(self):
        for node in self.nodes:
            self.assertEqual(self.deliver_request(node, 1)[1],
                             "FAIL_CLOSED_lease_unavailable")

    def test_partition_drops_renewal_then_local_expiry_fails_closed(self):
        self.assertTrue(self.deliver_lease("alpha", 1)[0])
        self.assertTrue(self.deliver_lease("beta", 1)[0])
        self.assertTrue(self.deliver_request("alpha", 1)[0])
        self.assertTrue(self.deliver_request("beta", 1)[0])

        # Deliver hold to alpha, DROP hold and renewal destined for beta.
        self.assertTrue(self.deliver_hold("alpha", 1)[0])
        self.assertEqual(self.nodes["alpha"].state,
                         GMeshState.REVOKED_HALTED)
        # Important limitation: beta is UNAWARE until local lease expiry.
        self.assertTrue(self.deliver_request("beta", 2)[0])
        self.now[0] = 25
        self.assertEqual(self.deliver_request("beta", 3)[1],
                         "FAIL_CLOSED_lease_unavailable")
        self.assertEqual(self.deliver_request("alpha", 2)[1],
                         "FAIL_CLOSED_local_hold")

    def test_reordered_renewals_and_replay_cannot_extend_expiry(self):
        self.assertTrue(self.deliver_lease("alpha", 3, deadline=29)[0])
        self.assertEqual(self.deliver_lease("alpha", 2, deadline=30)[1],
                         "lease_replay")
        self.assertEqual(self.deliver_lease("alpha", 3, deadline=30)[1],
                         "lease_replay")
        self.now[0] = 29
        self.assertEqual(self.deliver_request("alpha", 1)[1],
                         "FAIL_CLOSED_lease_unavailable")
        # New, strictly higher signed sequence can restore temporary admission
        # only when the local controller has not placed a durable hold.
        self.assertTrue(self.deliver_lease("alpha", 4, deadline=32)[0])
        self.assertTrue(self.deliver_request("alpha", 1)[0])

    def test_signed_target_and_issuer_forgery_fail(self):
        event = self.lease("alpha", 1)
        signed = self.controller.sign(encode_body(event))
        # A valid signature for alpha is invalid for beta's pinned target.
        self.assertEqual(self.nodes["beta"].install_authority_lease(
            event, signed)[1], "invalid_lease_schema")
        wrong = Ed25519PrivateKey.generate()
        self.assertEqual(self.nodes["alpha"].install_authority_lease(
            event, wrong.sign(encode_body(event)))[1],
            "invalid_controller_signature")
        self.assertEqual(self.deliver_request("alpha", 1)[1],
                         "FAIL_CLOSED_lease_unavailable")

    def test_restart_retains_lease_sequence_and_does_not_resurrect_hold(self):
        self.assertTrue(self.deliver_lease("beta", 4)[0])
        self.assertTrue(self.deliver_request("beta", 1)[0])
        self.nodes["beta"].close()
        self.nodes["beta"] = GMeshProtocolHandler(
            str(self.root / "beta.sqlite"), **self.opts["beta"])
        self.assertEqual(self.deliver_lease("beta", 4)[1], "lease_replay")
        # The former lease cannot authorize effects after a new process
        # starts, even though its signed not_after is still in the future.
        self.assertEqual(self.deliver_request("beta", 2)[1],
                         "FAIL_CLOSED_lease_unavailable")
        self.assertTrue(self.deliver_hold("beta", 1)[0])
        self.nodes["beta"].close()
        self.nodes["beta"] = GMeshProtocolHandler(
            str(self.root / "beta.sqlite"), **self.opts["beta"])
        self.assertEqual(self.nodes["beta"].state, GMeshState.REVOKED_HALTED)
        self.assertEqual(self.deliver_lease("beta", 5)[1],
                         "FAIL_CLOSED_local_hold")

    def test_restart_requires_new_controller_lease_even_before_expiry(self):
        self.assertTrue(self.deliver_lease("alpha", 1, deadline=28)[0])
        self.assertTrue(self.deliver_request("alpha", 1)[0])
        # Simulate abrupt writer loss by reopening the durable local state.
        # No physical time has passed, so the old lease remains unexpired.
        self.nodes["alpha"].close()
        self.nodes["alpha"] = GMeshProtocolHandler(
            str(self.root / "alpha.sqlite"), **self.opts["alpha"])
        self.assertEqual(self.deliver_request("alpha", 2)[1],
                         "FAIL_CLOSED_lease_unavailable")
        # A replay cannot re-install pre-restart authority.
        self.assertEqual(self.deliver_lease("alpha", 1, deadline=28)[1],
                         "lease_replay")
        # A fresh signed controller sequence restores bounded authority.
        self.assertTrue(self.deliver_lease("alpha", 2, deadline=28)[0])
        self.assertTrue(self.deliver_request("alpha", 2)[0])

    def test_clock_rollback_cannot_revive_expired_partition_lease(self):
        self.assertTrue(self.deliver_lease("alpha", 1, deadline=24)[0])
        self.now[0] = 24
        self.assertEqual(self.deliver_request("alpha", 1)[1],
                         "FAIL_CLOSED_lease_unavailable")
        self.now[0] = 22
        self.assertEqual(self.deliver_request("alpha", 1)[1],
                         "clock_rollback")
        self.assertEqual(self.deliver_lease("alpha", 2, deadline=26)[1],
                         "clock_rollback")

    def test_overlong_lease_and_invalid_messages_deny(self):
        self.assertEqual(self.deliver_lease("alpha", 1, deadline=500)[1],
                         "lease_expired_or_too_long")
        lease = self.lease("alpha", 2)
        self.assertEqual(self.nodes["alpha"].install_authority_lease(
            dict(lease, unknown="extra"),
            self.controller.sign(encode_body(dict(lease, unknown="extra"))))[1],
            "invalid_lease_schema")


    def test_24_hour_gemini_lease_cannot_authorize_either_node(self):
        # A generated "24h renewed, all green" claim cannot enlarge the
        # independently configured 10-second signed lease horizon.
        for node in ("alpha", "beta"):
            with self.subTest(node=node):
                self.assertEqual(
                    self.deliver_lease(node, 1, deadline=self.now[0] + 86400),
                    (False, "lease_expired_or_too_long"))
                self.assertEqual(
                    self.deliver_request(node, 1),
                    (False, "FAIL_CLOSED_lease_unavailable"))
        # An actual new, correctly signed bounded lease remains necessary.
        self.assertEqual(self.deliver_lease("alpha", 1, deadline=25),
                         (True, "local_lease_installed"))
        self.assertTrue(self.deliver_request("alpha", 1)[0])
        self.assertEqual(self.deliver_request("beta", 1),
                         (False, "FAIL_CLOSED_lease_unavailable"))
        self.now[0] = 25
        self.assertEqual(self.deliver_request("alpha", 2),
                         (False, "FAIL_CLOSED_lease_unavailable"))

    def test_malformed_or_unknown_controller_cannot_install_lease(self):
        lease = self.lease("alpha", 1)
        unknown = dict(lease, source_node_id="self_reported_gmesh_controller")
        self.assertEqual(
            self.nodes["alpha"].install_authority_lease(
                unknown, self.controller.sign(encode_body(unknown))),
            (False, "invalid_controller_signature"))
        self.assertEqual(self.deliver_request("alpha", 1),
                         (False, "FAIL_CLOSED_lease_unavailable"))
        self.assertEqual(self.nodes["alpha"].install_authority_lease(
            lease, b"not a signature"),
            (False, "invalid_controller_signature"))
        self.assertEqual(self.deliver_request("alpha", 1),
                         (False, "FAIL_CLOSED_lease_unavailable"))

    def test_signed_wrong_scope_and_generation_cannot_replace_live_lease(self):
        # A genuine controller signature is NOT sufficient: the exact
        # deployment, policy, target and current generation must also match.
        self.assertTrue(self.deliver_lease("alpha", 1, deadline=26)[0])
        self.assertTrue(self.deliver_request("alpha", 1)[0])

        for mutation, reason in (
            ({"deployment_id": "another-deployment"}, "invalid_lease_schema"),
            ({"policy_digest": "b" * 64}, "invalid_lease_schema"),
            ({"target_node_id": "beta"}, "invalid_lease_schema"),
            ({"generation": 2}, "stale_generation"),
        ):
            with self.subTest(mutation=mutation):
                forged_scope = dict(self.lease("alpha", 2, deadline=29),
                                    **mutation)
                self.assertEqual(
                    self.nodes["alpha"].install_authority_lease(
                        forged_scope,
                        self.controller.sign(encode_body(forged_scope)))[1],
                    reason)

        # The denied packets must not advance the durable valid lease's
        # controller sequence floor or extend its old deadline.
        self.now[0] = 26
        self.assertEqual(
            self.deliver_request("alpha", 2)[1],
            "FAIL_CLOSED_lease_unavailable")
        self.assertTrue(
            self.deliver_lease("alpha", 2, deadline=29)[0])
        self.assertTrue(self.deliver_request("alpha", 2)[0])

    def test_signed_renewal_cannot_clear_local_hold(self):
        self.assertTrue(self.deliver_lease("alpha", 1)[0])
        self.assertTrue(self.deliver_hold("alpha", 1)[0])
        self.assertEqual(
            self.deliver_lease("alpha", 2, deadline=26)[1],
            "FAIL_CLOSED_local_hold")
        self.assertEqual(
            self.deliver_request("alpha", 1)[1],
            "FAIL_CLOSED_local_hold")

    def test_parallel_identical_signed_renewal_commits_exactly_once(self):
        # Same-instance concurrent delivery must not double-accept a signed
        # controller sequence. No network, distributed lock or OS claim.
        lease = self.lease("alpha", 1, deadline=27)
        signature = self.controller.sign(encode_body(lease))
        start = threading.Barrier(8)
        decisions = []
        decision_lock = threading.Lock()

        def deliver():
            start.wait()
            result = self.nodes["alpha"].install_authority_lease(
                lease, signature)
            with decision_lock:
                decisions.append(result)

        threads = [threading.Thread(target=deliver) for _ in range(8)]
        for thread in threads:
            thread.start()
        for thread in threads:
            thread.join(timeout=10)
            self.assertFalse(thread.is_alive(), "lease admission deadlocked")

        self.assertEqual(
            sorted(result[1] for result in decisions),
            ["lease_replay"] * 7 + ["local_lease_installed"])
        self.assertTrue(self.deliver_request("alpha", 1)[0])
        self.now[0] = 27
        self.assertEqual(
            self.deliver_request("alpha", 2)[1],
            "FAIL_CLOSED_lease_unavailable")

if __name__ == "__main__":
    unittest.main()
