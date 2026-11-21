"""Adversarial drift probes for direct G3 security dependency provenance.

All mutations are in memory or disposable temporary directories.
No protected effect is executed by this suite.
"""
import ast
import tempfile
import unittest
from pathlib import Path

from koru_pinned_security_dependencies import (
    ROOT, PINNED, DIRECT_IMPORTS, git_blob_sha,
    verify_checkout, verify_dependency_sources,
)


class PinnedSecurityDependencyTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.dependencies = {name: (ROOT / name).read_bytes() for name in PINNED}
        cls.entrypoints = {
            name: (ROOT / name).read_text() for name in DIRECT_IMPORTS
        }

    def test_real_checkout_accepts_pinned_imports(self):
        self.assertTrue(verify_checkout())

    def test_fingerprints_match_reviewed_git_blobs(self):
        for name, digest in PINNED.items():
            with self.subTest(name=name):
                self.assertEqual(git_blob_sha(self.dependencies[name]), digest)

    def test_each_changed_security_dependency_denied(self):
        for name in PINNED:
            with self.subTest(name=name):
                changed = dict(self.dependencies)
                changed[name] += b"\n# unreviewed implementation drift\n"
                with self.assertRaisesRegex(ValueError, "security dependency drift"):
                    verify_dependency_sources(changed, self.entrypoints)

    def test_added_side_effect_to_dependency_denied(self):
        changed = dict(self.dependencies)
        name = "koru_executor_fd_startup_audit.py"
        tree = ast.parse(changed[name])
        tree.body.append(ast.parse("print('unreviewed')").body[0])
        changed[name] = ast.unparse(ast.fix_missing_locations(tree)).encode()
        with self.assertRaisesRegex(ValueError, "security dependency drift"):
            verify_dependency_sources(changed, self.entrypoints)

    def test_missing_dependency_denied(self):
        changed = dict(self.dependencies)
        changed.pop("koru_seccomp_fd_receive_fence.py")
        with self.assertRaisesRegex(ValueError, "dependency file set changed"):
            verify_dependency_sources(changed, self.entrypoints)

    def test_added_unreviewed_local_import_denied(self):
        entrypoints = dict(self.entrypoints)
        name = "koru_no_inherited_fd_executor.py"
        tree = ast.parse(entrypoints[name])
        tree.body.insert(0, ast.ImportFrom(
            module="koru_unreviewed_fence",
            names=[ast.alias(name="SAFE", asname=None)], level=0))
        entrypoints[name] = ast.unparse(ast.fix_missing_locations(tree))
        with self.assertRaisesRegex(ValueError, "security dependency import drift"):
            verify_dependency_sources(self.dependencies, entrypoints)

    def test_swapped_security_import_denied(self):
        entrypoints = dict(self.entrypoints)
        name = "koru_no_inherited_fd_executor.py"
        tree = ast.parse(entrypoints[name])
        for node in ast.walk(tree):
            if isinstance(node, ast.ImportFrom) and node.module == "koru_landlock_write_fence":
                node.module = "koru_unreviewed_landlock"
                break
        entrypoints[name] = ast.unparse(tree)
        with self.assertRaisesRegex(ValueError, "security dependency import drift"):
            verify_dependency_sources(self.dependencies, entrypoints)

    def test_alias_for_security_import_denied(self):
        entrypoints = dict(self.entrypoints)
        name = "koru_authority_owned_marker_service.py"
        tree = ast.parse(entrypoints[name])
        for node in ast.walk(tree):
            if isinstance(node, ast.ImportFrom) and node.module == "koru_authority_effect_time_fence":
                node.names[0].asname = "DifferentFence"
                break
        entrypoints[name] = ast.unparse(tree)
        with self.assertRaisesRegex(ValueError, "local import shape changed"):
            verify_dependency_sources(self.dependencies, entrypoints)

    def test_extra_entrypoint_denied(self):
        changed = dict(self.entrypoints)
        changed["other_entrypoint.py"] = ""
        with self.assertRaisesRegex(ValueError, "entrypoint file set changed"):
            verify_dependency_sources(self.dependencies, changed)

    def test_symlink_to_security_dependency_denied(self):
        with tempfile.TemporaryDirectory() as td:
            root = Path(td)
            for name in set(PINNED) | set(DIRECT_IMPORTS):
                target = ROOT / name
                if name == "koru_landlock_write_fence.py":
                    (root / name).symlink_to(target)
                else:
                    (root / name).write_bytes(target.read_bytes())
            with self.assertRaisesRegex(ValueError, "symlink forbidden"):
                verify_checkout(root)


if __name__ == "__main__":
    unittest.main()
