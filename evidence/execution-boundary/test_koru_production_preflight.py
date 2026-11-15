"""Unprivileged negative controls: configuration preflight only."""
import os
from pathlib import Path
import tempfile
import unittest

from koru_production_preflight import (
    PrincipalPlan, PreflightError, _private_dir, check_production_plan,
)


class ProductionPreflightTests(unittest.TestCase):
    def test_distinct_nonroot_identities(self):
        PrincipalPlan(1001, 1002, 1003, 1004).validate()
        for plan in (PrincipalPlan(0, 1002, 1003, 1004),
                     PrincipalPlan(1001, 1001, 1003, 1004),
                     PrincipalPlan(True, 1002, 1003, 1004),
                     PrincipalPlan(-1, 1002, 1003, 1004)):
            with self.subTest(plan=plan), self.assertRaises(PreflightError):
                plan.validate()

    def test_missing_paths_fail_closed(self):
        with self.assertRaises(PreflightError):
            check_production_plan(
                PrincipalPlan(1001, 1002, 1003, 1004),
                marker_directory="/definitely-absent-g3-marker-dir",
                database_directory="/definitely-absent-g3-db-dir")

    def test_shared_identity_denied_before_filesystem(self):
        with self.assertRaises(PreflightError):
            check_production_plan(
                PrincipalPlan(1001, 1002, 1003, 1003),
                marker_directory="/tmp", database_directory="/tmp")

    def test_relative_path_denied(self):
        with self.assertRaises(PreflightError):
            check_production_plan(
                PrincipalPlan(1001, 1002, 1003, 1004),
                marker_directory="relative", database_directory="/tmp")

    def test_symlink_and_open_permissions_denied(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            leaf = base / "leaf"
            leaf.mkdir(mode=0o700)
            (base / "link").symlink_to(leaf, target_is_directory=True)
            with self.assertRaises(PreflightError):
                _private_dir(str(base / "link"), os.geteuid(), label="marker")
            leaf.chmod(0o777)
            with self.assertRaises(PreflightError):
                _private_dir(str(leaf), os.geteuid(), label="marker")

    def test_private_leaf_under_safe_parents(self):
        with tempfile.TemporaryDirectory() as tmp:
            leaf = Path(tmp) / "leaf"
            leaf.mkdir(mode=0o700)
            # /tmp is deliberately prohibited as a mutable ancestor.
            unsafe_parent = any(
                os.stat(str(parent)).st_mode & 0o022
                for parent in leaf.parents if str(parent) != "/")
            if unsafe_parent:
                with self.assertRaises(PreflightError):
                    _private_dir(str(leaf), os.geteuid(), label="marker")
            else:
                self.assertEqual(
                    _private_dir(str(leaf), os.geteuid(), label="marker"), leaf)


if __name__ == "__main__":
    unittest.main()
