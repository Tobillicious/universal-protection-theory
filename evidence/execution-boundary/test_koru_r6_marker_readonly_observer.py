"""R6 separate-process observations over the EXISTING authority-owned marker tests.

A separate Linux process observes the filesystem, but the CI root account
still controls both authority and observer. No external custody attested.
"""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from koru_r6_marker_readonly_observer import observe
import test_koru_authority_owned_marker_service as base

OBSERVER = Path(__file__).with_name("koru_r6_marker_readonly_observer.py")


class MarkerObserverPureTests(unittest.TestCase):
    def test_empty_scope_is_observed(self):
        with tempfile.TemporaryDirectory() as d:
            self.assertEqual(observe(d, expected_uid=os.geteuid()),
                             {"exists": False})

    def test_unexpected_file_denied(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "unexpected").touch()
            with self.assertRaisesRegex(ValueError, "unexpected"):
                observe(d, expected_uid=os.geteuid())

    def test_symlink_marker_denied(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "fixed.marker").symlink_to("/dev/null")
            with self.assertRaisesRegex(ValueError, "properties"):
                observe(d, expected_uid=os.geteuid())

    def test_nonzero_content_denied(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "fixed.marker").write_bytes(b"x")
            with self.assertRaisesRegex(ValueError, "properties"):
                observe(d, expected_uid=os.geteuid())

    def test_directory_symlink_denied(self):
        with tempfile.TemporaryDirectory() as d:
            target = Path(d) / "real"
            target.mkdir()
            alias = Path(d) / "alias"
            alias.symlink_to(target, target_is_directory=True)
            with self.assertRaises(OSError):
                observe(alias, expected_uid=os.geteuid())


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable root-launched Linux authority fixture only")
class ExternalProcessMarkerObservations(unittest.TestCase):
    def setUp(self):
        self.fixture = base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def read(self):
        proc = subprocess.run(
            [sys.executable, "-B", str(OBSERVER),
             "--marker-dir", str(self.fixture.marker),
             "--expected-uid", str(base.AUTH)],
            cwd="/", env={"PATH": "/usr/local/bin:/usr/bin:/bin",
                          "PYTHONDONTWRITEBYTECODE": "1"},
            capture_output=True, text=True, timeout=6, check=False)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        record = json.loads(proc.stdout)
        self.assertNotEqual(record["observer_pid"], os.getpid())
        self.assertNotEqual(record["observer_pid"], self.fixture.server.pid)
        return record["observation"]

    def retain(self, name, receipt):
        folder = os.environ.get("G3_R6_OBSERVATIONS_DIR")
        if folder:
            directory = Path(folder)
            if not directory.is_dir() or directory.is_symlink():
                raise ValueError("trusted evidence output directory missing")
            path = directory / (name + ".json")
            with path.open("x", encoding="utf8") as file:
                json.dump(receipt, file, sort_keys=True, indent=2)
                file.write("\n")

    def test_positive_once_only_and_repeated_denial(self):
        initial = self.read()
        self.assertEqual(initial, {"exists": False})
        first = self.fixture.ask(base.EXECUTOR, "fixed_marker")
        self.assertEqual(first["code"], "synthetic_effect_returned")
        after = self.read()
        self.assertTrue(after["exists"])
        denied = self.fixture.ask(base.EXECUTOR, "fixed_marker")
        self.assertEqual(denied["code"], "authority_denied")
        final = self.read()
        self.assertEqual(after, final, "repeated request mutated marker")
        self.retain("once-only", {
            "scope": "disposable Linux marker; same-admin separate-process observer",
            "initial": initial, "after": after, "after_repeat_denial": final,
            "authority_outcomes": [first["code"], denied["code"]],
            "independent_administration": False,
            "authentic_subject_reflections_proved": False,
        })

    def test_hold_first_keeps_marker_absent(self):
        initial = self.read()
        self.assertEqual(initial, {"exists": False})
        held = self.fixture.ask(base.CONTROLLER, "hold")
        self.assertEqual(held["code"], "hold_recorded")
        after_hold = self.read()
        self.assertEqual(after_hold, {"exists": False})
        denied = self.fixture.ask(base.EXECUTOR, "fixed_marker")
        self.assertEqual(denied["code"], "authority_denied")
        final = self.read()
        self.assertEqual(final, {"exists": False})
        self.retain("hold-first", {
            "scope": "disposable Linux marker; same-admin separate-process observer",
            "initial": initial, "after_hold": after_hold, "after_denial": final,
            "authority_outcomes": [held["code"], denied["code"]],
            "independent_administration": False,
            "authentic_subject_reflections_proved": False,
        })


if __name__ == "__main__":
    unittest.main()
