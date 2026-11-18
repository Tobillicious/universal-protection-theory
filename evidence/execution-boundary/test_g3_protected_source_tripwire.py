"""Hostile tests for the G3 reviewed-source tripwire; never execute effects."""
import tempfile
from pathlib import Path
import unittest
from g3_protected_source_tripwire import PINNED, ROOT, audit


class ProtectedSourceTripwireTests(unittest.TestCase):
    def test_reviewed_checkout_matches_all_pins(self):
        self.assertEqual(audit(ROOT), [])

    def test_modified_authority_or_hold_is_detected(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            for name in PINNED:
                destination = root / name
                destination.parent.mkdir(parents=True, exist_ok=True)
                destination.write_bytes((ROOT / name).read_bytes())
            self.assertEqual(audit(root), [])
            authority = root / "evidence/execution-boundary/koru_broker.py"
            authority.write_bytes(authority.read_bytes() + b"\n# unreviewed change\n")
            self.assertIn("protected_source_drift:evidence/execution-boundary/koru_broker.py", audit(root))
            authority.write_bytes((ROOT / "evidence/execution-boundary/koru_broker.py").read_bytes())
            hold = root / "evidence/execution-boundary/koru_transactional_hold_witness.py"
            hold.unlink()
            self.assertIn(
                "missing_or_symlinked:evidence/execution-boundary/koru_transactional_hold_witness.py",
                audit(root),
            )

    def test_symlinked_source_rejected(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            for name in PINNED:
                target = root / name
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes((ROOT / name).read_bytes())
            p = root / "evidence/execution-boundary/koru_no_inherited_fd_executor.py"
            p.unlink()
            p.symlink_to(ROOT / "evidence/execution-boundary/koru_no_inherited_fd_executor.py")
            self.assertIn("missing_or_symlinked:evidence/execution-boundary/koru_no_inherited_fd_executor.py", audit(root))


if __name__ == "__main__":
    unittest.main()
