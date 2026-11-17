"""Negative controls for the historical two-target / G3 R5 source join."""
import unittest
from koru_r5_fencing_bridge_contract import ROOT, check_bridge_source, verify_checkout

class FencingBridgeContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.historical = (ROOT / "target.py").read_text()
        cls.current = (ROOT / "koru_authority_owned_marker_service.py").read_text()

    def test_existing_sources_retain_checked_structure(self):
        self.assertTrue(verify_checkout())

    def test_removed_apply_time_recheck_rejected(self):
        changed = self.historical.replace("r = admit(m) or apply(m)", "r = apply(m)")
        self.assertNotEqual(changed, self.historical)
        with self.assertRaisesRegex(ValueError, "check-at-apply"):
            check_bridge_source(changed, self.current)

    def test_removed_historical_durable_sync_rejected(self):
        changed = self.historical.replace("fullsync(fh)", "fh.flush()")
        self.assertNotEqual(changed, self.historical)
        with self.assertRaisesRegex(ValueError, "durability"):
            check_bridge_source(changed, self.current)

    def test_removed_authority_hold_gate_rejected(self):
        changed = self.current.replace("self.server.journal.hold()", "{'held': True}")
        self.assertNotEqual(changed, self.current)
        with self.assertRaisesRegex(ValueError, "effect/HOLD"):
            check_bridge_source(self.historical, changed)

    def test_removed_authority_effect_fence_rejected(self):
        changed = self.current.replace("self.server.fence.execute_synthetic(", "self.server.fence.not_fenced(")
        self.assertNotEqual(changed, self.current)
        with self.assertRaisesRegex(ValueError, "effect/HOLD"):
            check_bridge_source(self.historical, changed)

    def test_removed_effect_durability_rejected(self):
        changed = self.current.replace("os.fsync(self.dirfd)", "pass")
        self.assertNotEqual(changed, self.current)
        with self.assertRaisesRegex(ValueError, "effect/HOLD"):
            check_bridge_source(self.historical, changed)

if __name__ == "__main__":
    unittest.main()
