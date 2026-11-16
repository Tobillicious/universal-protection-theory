"""Demonstrate complete local rollback and effect-time independent witness denial.

Uses earlier root-owned fixture. Attack restores controller snapshot AND
root-owned floor, removes HOLD intent with attacker root. The baseline
unanchored writer predicate would then authorize a pre-HOLD event.
Independent anchor is a MOCK held outside rollback domain, not durable storage.
"""
import json
import os
import sys
import unittest

import test_koru_root_hold_floor as base
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_cross_uid_authority import ControllerOwnedSnapshot
from koru_root_hold_floor import RootOwnedHoldFloor
from koru_independent_hold_anchor_gate import IndependentlyAnchoredHoldGate


class Anchor:
    def __init__(self, state):
        self.state = state
    def read(self):
        if isinstance(self.state, Exception):
            raise self.state
        return self.state


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "isolated disposable privileged Linux fixture only")
class FullRollbackWitnessTests(unittest.TestCase):
    def setUp(self):
        self.fixture = base.RootFloorRollbackTests(
            methodName="test_pre_hold_signed_effect_then_old_snapshot_replay_denied")
        self.fixture.setUp()
        c = self.fixture.case
        self.original_controller = c.state.read_bytes()
        self.original_floor = self.fixture.root_floor_file.read_bytes()
        self.event = dict(c.event)
        self.anchor = Anchor(json.loads(self.original_floor))
        self.fence = ProvisionedCrossUidFence(
            str(c.lock), shared_gid=base.base.LOCK_GROUP)
        self.floor = RootOwnedHoldFloor(str(self.fixture.root_floor_dir))
        self.snapshot = ControllerOwnedSnapshot(
            str(c.control), controller_uid=base.base.CONTROLLER,
            shared_gid=base.base.LOCK_GROUP)

    def tearDown(self):
        self.snapshot.close()
        self.floor.close()
        self.fence.close()
        self.fixture.tearDown()

    def check(self, gate=None):
        with self.fence:
            return (gate or self.floor).permits(self.event, self.snapshot)

    def test_matching_independent_anchor_allows_initial_fixture(self):
        gate = IndependentlyAnchoredHoldGate(self.floor, self.anchor)
        self.assertTrue(self.check())
        self.assertTrue(self.check(gate))

    def test_complete_local_root_rollback_witness_and_anchor_denial(self):
        self.assertEqual(self.fixture.trusted_root_hold()["code"],
                         "floor_hold_committed")
        self.anchor.state = json.loads(self.fixture.root_floor_file.read_bytes())
        self.assertTrue(self.anchor.state["held"])
        # Simulated attacker now has root control over ALL local HOLD markers,
        # unlike previous tests that left an independent intent inode intact.
        self.fixture.root_floor_file.write_bytes(self.original_floor)
        self.fixture.root_floor_file.chmod(0o644)
        (self.fixture.root_floor_dir / "hold-intent").unlink()
        self.fixture.case.state.write_bytes(self.original_controller)
        self.assertTrue(
            self.check(),
            "witness: complete local rollback restores unanchored permission")
        gate = IndependentlyAnchoredHoldGate(self.floor, self.anchor)
        self.assertFalse(
            self.check(gate),
            "independent held witness must deny despite restored local bytes")

    def test_witness_unavailable_corrupt_or_stale_generation_denies(self):
        gate = IndependentlyAnchoredHoldGate(self.floor, self.anchor)
        self.anchor.state = OSError("independent anchor unavailable")
        self.assertFalse(self.check(gate))
        self.anchor.state = {"held": False}
        self.assertFalse(self.check(gate))
        self.anchor.state = dict(json.loads(self.original_floor),
                                 generation=self.event["generation"] + 1)
        self.assertFalse(self.check(gate))

    def test_missing_witness_or_mismatched_identity_denies(self):
        with self.assertRaises(ValueError):
            IndependentlyAnchoredHoldGate(self.floor, None)
        gate = IndependentlyAnchoredHoldGate(self.floor, self.anchor)
        self.anchor.state = dict(json.loads(self.original_floor),
                                 authority_ref="substituted")
        self.assertFalse(self.check(gate))


if __name__ == "__main__":
    unittest.main()
