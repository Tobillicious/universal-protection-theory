"""Failure injection for root-owned HOLD intent, under synthetic Linux UIDs.

Crash *simulation* with injected EIO at deterministic persistence boundaries.
This does not simulate power loss, actual kernel writeback or storage faults.
"""
import errno
import os
import subprocess
import sys
import unittest
from unittest.mock import patch

import test_koru_root_hold_floor as base


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable privileged Linux fixture only")
class DurableHoldIntentFailureTests(unittest.TestCase):
    def setUp(self):
        self.case = base.RootFloorRollbackTests(
            methodName="test_pre_hold_signed_effect_then_old_snapshot_replay_denied")
        self.case.setUp()

    def tearDown(self):
        self.case.tearDown()

    def assert_denied_after_restart(self):
        c = self.case.case
        self.assertEqual(c.request()["code"], "writer_authorization_denied")
        c.stop_writer()
        self.case.start_anchored_writer()
        self.assertEqual(c.request()["code"], "writer_authorization_denied")
        self.assertFalse(list(c.marker.iterdir()))

    def test_interrupted_floor_rename_keeps_durable_intent_and_denies(self):
        c = self.case
        with patch("koru_root_hold_floor.os.rename",
                   side_effect=OSError(errno.EIO, "injected rename fault")):
            with self.assertRaises(OSError):
                c.trusted_root_hold()
        self.assertTrue((c.root_floor_dir / "hold-intent").exists())
        # Floor still carries old permission; independent intent must deny.
        self.assertFalse(__import__("json").loads(c.root_floor_file.read_text())["held"])
        self.assert_denied_after_restart()

    def test_floor_data_fsync_failure_still_denies(self):
        self._inject_fsync_failure(index=3)

    def test_after_rename_directory_fsync_failure_still_denies(self):
        self._inject_fsync_failure(index=4)

    def _inject_fsync_failure(self, *, index):
        c = self.case
        real = os.fsync
        count = [0]

        def injected(fd):
            count[0] += 1
            if count[0] == index:
                raise OSError(errno.EIO, "injected fsync fault")
            return real(fd)

        with patch("koru_root_hold_floor.os.fsync", side_effect=injected):
            with self.assertRaises(OSError):
                c.trusted_root_hold()
        self.assertGreaterEqual(count[0], index)
        self.assertTrue((c.root_floor_dir / "hold-intent").exists())
        self.assert_denied_after_restart()

    def test_replayed_old_floor_with_durable_intent_denies(self):
        c = self.case
        old_floor = c.root_floor_file.read_bytes()
        self.assertEqual(c.trusted_root_hold()["code"], "floor_hold_committed")
        # Host root can replay floor bytes, but not simultaneously erase the
        # trusted independent intent in this narrow adversary scenario.
        c.root_floor_file.write_bytes(old_floor)
        self.assert_denied_after_restart()

    def test_controller_writer_broker_cannot_remove_intent(self):
        c = self.case
        self.assertEqual(c.trusted_root_hold()["code"], "floor_hold_committed")
        intent = str(c.root_floor_dir / "hold-intent")
        for uid in (base.base.CONTROLLER, base.base.WRITER, base.base.BROKER):
            cmd = subprocess.run(
                [sys.executable, "-B", "-c",
                 "import os,sys;os.unlink(sys.argv[1])", intent],
                preexec_fn=base.base.drop_to(uid), cwd="/",
                env=c.case.env, capture_output=True, text=True, timeout=5)
            self.assertNotEqual(cmd.returncode, 0)
            self.assertIn("PermissionError", cmd.stderr)
        self.assert_denied_after_restart()


if __name__ == "__main__":
    unittest.main()
