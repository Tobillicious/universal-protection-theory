"""Real filesystem boundary tests; no network and no other devices touched."""
import json
import tempfile
import unittest
from pathlib import Path
from local_guard import Denied, LocalFileGate


class GateTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.base = Path(self.tmp.name)
        self.root = self.base / "protected"
        self.root.mkdir()
        self.audit = self.base / "audit.jsonl"
        self.gate = LocalFileGate(self.root, self.audit)

    def tearDown(self):
        self.gate.close()
        self.tmp.cleanup()

    def test_deny_by_default(self):
        with self.assertRaises(Denied):
            self.gate.create("hello", b"hello")
        self.assertFalse((self.root / "hello").exists())

    def test_grant_then_revoke(self):
        self.gate.allow("create", "new")
        self.gate.revoke("create", "new")
        with self.assertRaises(Denied):
            self.gate.create("new", b"x")
        self.assertFalse((self.root / "new").exists())

    def test_allow_scoped_create_and_read(self):
        self.gate.allow("create", "file")
        self.gate.create("file", b"hello")
        self.gate.allow("read", "file")
        self.assertEqual(self.gate.read("file"), b"hello")
        with self.assertRaises(FileExistsError):
            self.gate.create("file", b"overwrite")
        self.assertEqual((self.root / "file").read_bytes(), b"hello")

    def test_traversal_and_symlink_blocked(self):
        for name in ("../outside", "/etc/passwd", "a/b", ".", "..", "a\\b"):
            with self.assertRaises(Denied):
                self.gate.read(name)
        outside = self.base / "outside"
        outside.write_bytes(b"private")
        (self.root / "link").symlink_to(outside)
        self.gate.allow("read", "link")
        with self.assertRaises(OSError):
            self.gate.read("link")

    def test_hold_is_irreversible_in_process(self):
        self.gate.allow("create", "file")
        self.gate.hold()
        with self.assertRaises(Denied):
            self.gate.create("file", b"x")
        with self.assertRaises(Denied):
            self.gate.allow("create", "file")

    def test_audit_log(self):
        with self.assertRaises(Denied):
            self.gate.read("secret")
        self.gate.allow("create", "ok")
        self.gate.create("ok", b"a")
        entries = [json.loads(line) for line in self.audit.read_text().splitlines()]
        self.assertEqual([e["result"] for e in entries], ["DENIED", "ALLOWED", "ALLOWED"])

    def test_audit_outside_root(self):
        with self.assertRaises(ValueError):
            LocalFileGate(self.root, self.root / "bad-audit")


if __name__ == "__main__":
    unittest.main()
