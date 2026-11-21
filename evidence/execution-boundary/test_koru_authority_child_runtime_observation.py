"""Observe a live Linux authority child at the G3 research boundary.

This is root-launched disposable fixture evidence, NOT attestation. We check
the child process's actual /proc executable, real/effective UID and copied
security module bytes while it is running. A same-host privileged adversary
can tamper with process observations and this cannot prove loaded code paths.
"""
import hashlib
import os
from pathlib import Path
import sys
import unittest

import test_koru_authority_owned_marker_service as base
from koru_runtime_evidence import digest_regular

CRITICAL_MODULES = (
    "koru_authority_owned_marker_service.py",
    "koru_authority_admission_journal.py",
    "koru_authority_effect_time_fence.py",
    "koru_transactional_hold_witness.py",
    "koru_durable_effect_intent.py",
    "koru_transaction_scoped_effect.py",
    "koru_bounded_server.py",
    "koru_authority_reserved_workers.py",
)


def process_snapshot(pid):
    if type(pid) is not int or pid <= 1:
        raise ValueError("invalid process ID")
    root = Path("/proc") / str(pid)
    # Linux /proc/PID/status exposes Real, Effective, Saved and FS UID.
    status = (root / "status").read_text()
    uid_lines = [line for line in status.splitlines()
                 if line.startswith("Uid:")]
    if len(uid_lines) != 1:
        raise ValueError("missing process identity")
    uids = tuple(int(item) for item in uid_lines[0].split()[1:])
    if len(uids) != 4:
        raise ValueError("invalid process UID fields")
    return {"pid": pid, "uids": uids,
            "executable_sha256": digest_regular(root / "exe")["sha256"],
            "cmdline": (root / "cmdline").read_bytes()}


def compare_child_snapshot(child, expected_uid, expected_executable_sha):
    if child.poll() is not None:
        raise ValueError("authority child terminated before observation")
    observed = process_snapshot(child.pid)
    if observed["uids"] != (expected_uid,) * 4:
        raise ValueError("authority process UID mismatch")
    if observed["executable_sha256"] != expected_executable_sha:
        raise ValueError("authority executable mismatch")
    if b"koru_authority_owned_marker_service" not in observed["cmdline"]:
        raise ValueError("authority service entrypoint absent from command")
    if child.poll() is not None:
        raise ValueError("authority terminated during observation")
    return observed


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "requires disposable privileged Linux /proc fixture")
class AuthorityChildRuntimeObservationTests(unittest.TestCase):
    def setUp(self):
        self.case = base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.case.setUp()

    def tearDown(self):
        self.case.tearDown()

    def test_running_authority_matches_interpreter_uid_and_sources(self):
        f = self.case
        own_sha = digest_regular("/proc/self/exe")["sha256"]
        observed = compare_child_snapshot(f.server, base.AUTH, own_sha)
        self.assertEqual(observed["uids"], (base.AUTH,) * 4)
        for name in CRITICAL_MODULES:
            original = Path(base.__file__).with_name(name)
            copied = f.lib / name
            self.assertTrue(copied.is_file(), name)
            self.assertFalse(copied.is_symlink(), name)
            self.assertEqual(digest_regular(original)["sha256"],
                             digest_regular(copied)["sha256"], name)
        # Once observed, the real authority still honors HOLD.
        self.assertEqual(f.ask(base.CONTROLLER, "hold")["code"],
                         "hold_recorded")
        self.assertEqual(f.ask(base.EXECUTOR, "fixed_marker")["code"],
                         "authority_denied")
        self.assertFalse(list(f.marker.iterdir()))

    def test_wrong_runtime_digest_rejected(self):
        actual = digest_regular("/proc/self/exe")["sha256"]
        wrong = "0" * 64 if actual != "0" * 64 else "f" * 64
        with self.assertRaisesRegex(ValueError, "executable mismatch"):
            compare_child_snapshot(self.case.server, base.AUTH, wrong)

    def test_wrong_process_identity_rejected(self):
        with self.assertRaisesRegex(ValueError, "UID mismatch"):
            compare_child_snapshot(self.case.server, base.EXECUTOR,
                                   digest_regular("/proc/self/exe")["sha256"])


if __name__ == "__main__":
    unittest.main()
