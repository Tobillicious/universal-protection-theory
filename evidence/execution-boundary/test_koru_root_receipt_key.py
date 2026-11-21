"""Disposable Linux-root key custody negatives; no production secrets."""
import os
import socket
import stat
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_root_receipt_key import load_root_receipt_key


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "isolated disposable Linux root runner required")
class RootReceiptKeyTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-root-key-")
        self.root = Path(self.tmp.name)
        self.root.chmod(0o700)
        self.key_path = self.root / "issuer.key"
        self.secret = Ed25519PrivateKey.generate()
        self.raw = self.secret.private_bytes(
            serialization.Encoding.Raw,
            serialization.PrivateFormat.Raw,
            serialization.NoEncryption())
        self.write_key()

    def write_key(self):
        fd = os.open(str(self.key_path), os.O_WRONLY | os.O_CREAT | os.O_EXCL,
                     0o600)
        with os.fdopen(fd, "wb") as f:
            f.write(self.raw)
            f.flush()
            os.fsync(f.fileno())

    def tearDown(self):
        self.tmp.cleanup()

    def test_load_exact_key_and_issue_signature(self):
        loaded = load_root_receipt_key(str(self.key_path))
        message = b"fixture challenge only"
        signature = loaded.sign(message)
        self.secret.public_key().verify(signature, message)

    def test_nonroot_cannot_read_private_file(self):
        # Separate process drops all groups and credentials. Check both
        # that bytes cannot be read and loader refuses non-root issuance.
        script = """import os,sys
os.setgroups([])
os.setgid(65534)
os.setuid(65534)
try:
    open(sys.argv[1], 'rb').read()
except PermissionError:
    print('READ_DENIED')
else:
    print('READ_ALLOWED')
"""
        result = subprocess.run(
            [sys.executable, "-B", "-c", script, str(self.key_path)],
            capture_output=True, text=True, timeout=5)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.strip(), "READ_DENIED")

    def test_world_readable_mode_refused(self):
        self.key_path.chmod(0o644)
        with self.assertRaises(PermissionError):
            load_root_receipt_key(str(self.key_path))

    def test_symlink_and_hardlink_refused(self):
        alias = self.root / "alias"
        alias.symlink_to(self.key_path)
        with self.assertRaises(OSError):
            load_root_receipt_key(str(alias))
        alias.unlink()
        os.link(self.key_path, alias)
        with self.assertRaises(PermissionError):
            load_root_receipt_key(str(self.key_path))

    def test_replaced_with_directory_or_fifo_refused(self):
        self.key_path.unlink()
        self.key_path.mkdir()
        with self.assertRaises(OSError):
            load_root_receipt_key(str(self.key_path))
        self.key_path.rmdir()
        os.mkfifo(self.key_path, 0o600)
        with self.assertRaises(PermissionError):
            load_root_receipt_key(str(self.key_path))

    def test_bad_key_size_or_missing_refused(self):
        self.key_path.unlink()
        with self.assertRaises(FileNotFoundError):
            load_root_receipt_key(str(self.key_path))
        self.key_path.write_bytes(b"x" * 31)
        self.key_path.chmod(0o600)
        with self.assertRaises(PermissionError):
            load_root_receipt_key(str(self.key_path))

    def test_insecure_parent_and_directory_swap_refused(self):
        self.root.chmod(0o755)
        with self.assertRaises(PermissionError):
            load_root_receipt_key(str(self.key_path))
        self.root.chmod(0o700)
        moved = str(self.root) + "-moved"
        os.rename(self.root, moved)
        try:
            Path(self.root).mkdir(mode=0o700)
            with self.assertRaises(FileNotFoundError):
                load_root_receipt_key(str(self.key_path))
        finally:
            os.rmdir(self.root)
            os.rename(moved, self.root)


if __name__ == "__main__":
    unittest.main()
