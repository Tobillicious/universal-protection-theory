"""Fail-closed v4.3 manifest, artifact-lock and tampering regressions."""
import json
import tempfile
import unittest
from pathlib import Path

from v43_release_gate import validate_crate, lock, verify


class ReleaseGateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)

    def test_source_manifest_fails_without_covered_file(self):
        sample = self.root / "src.txt"
        sample.write_text("value")
        record = {"@context": "https://w3id.org/ro/crate/1.1/context",
                  "@graph": [
                      {"@id": "ro-crate-metadata.json", "@type": "CreativeWork",
                       "about": {"@id": "./"}},
                      {"@id": "./", "@type": "Dataset",
                       "hasPart": [{"@id": "src.txt"}]},
                      {"@id": "src.txt", "@type": "File"}]}
        metadata = self.root / "ro-crate-metadata.json"
        metadata.write_text(json.dumps(record))
        self.assertEqual(validate_crate(self.root, metadata), 1)
        sample.unlink()
        with self.assertRaisesRegex(ValueError, "missing/unsafe"):
            validate_crate(self.root, metadata)

    def test_compiled_artifact_lock_and_tamper(self):
        binary = self.root / "module.olean"
        binary.write_bytes(b"compiled-test-only")
        self.assertEqual(lock(self.root), 1)
        self.assertEqual(verify(self.root), 1)
        binary.write_bytes(b"changed")
        with self.assertRaisesRegex(ValueError, "checksum mismatch"):
            verify(self.root)

    def test_no_olean_refuses_release_lock(self):
        (self.root / "source.lean").write_text("by trivial")
        with self.assertRaisesRegex(ValueError, "no compiled"):
            lock(self.root)

    def test_extra_binary_is_detected(self):
        (self.root / "module.olean").write_bytes(b"compiled-test-only")
        lock(self.root)
        (self.root / "new.ilean").write_bytes(b"new")
        with self.assertRaisesRegex(ValueError, "unexpected compiled"):
            verify(self.root)

    def test_symlink_in_artifacts_is_refused(self):
        (self.root / "module.olean").write_bytes(b"compiled-test-only")
        (self.root / "alias.olean").symlink_to("module.olean")
        with self.assertRaisesRegex(ValueError, "symlink"):
            lock(self.root)


if __name__ == "__main__":
    unittest.main()
