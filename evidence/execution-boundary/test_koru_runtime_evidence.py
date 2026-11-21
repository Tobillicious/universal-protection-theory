"""Tests of the G3 CI runtime inventory's fail-closed file/receipt rules."""
import hashlib
from pathlib import Path
import tempfile
import unittest

from koru_runtime_evidence import canonical_json, digest_regular, source_inventory


class G3RuntimeReceiptTests(unittest.TestCase):
    def test_exact_file_digest(self):
        with tempfile.TemporaryDirectory() as d:
            path = Path(d) / "module.py"
            path.write_bytes(b"trusted bytes")
            self.assertEqual(digest_regular(path)["sha256"],
                             hashlib.sha256(b"trusted bytes").hexdigest())
            path.write_bytes(b"changed bytes")
            self.assertNotEqual(digest_regular(path)["sha256"],
                                hashlib.sha256(b"trusted bytes").hexdigest())

    def test_symlink_rejected_for_source_inventory(self):
        with tempfile.TemporaryDirectory() as d:
            source = Path(d)
            (source / "dummy.py").write_text("pass")
            (source / "shadow.py").symlink_to(source / "dummy.py")
            with self.assertRaisesRegex(ValueError, "symlink source"):
                source_inventory(source)

    def test_missing_required_source_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "other.py").write_text("pass")
            with self.assertRaisesRegex(ValueError, "missing protected sources"):
                source_inventory(d)

    def test_canonical_receipt_is_stable(self):
        value = {"b": 2, "a": {"z": 1}}
        self.assertEqual(canonical_json(value),
                         b'{"a":{"z":1},"b":2}\n')
        self.assertEqual(canonical_json(value), canonical_json(dict(reversed(
            list(value.items())))))


if __name__ == "__main__":
    unittest.main()
