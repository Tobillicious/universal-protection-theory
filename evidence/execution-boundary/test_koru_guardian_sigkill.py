"""Actual Linux SIGKILL boundaries for root guardian HOLD research.

These tests kill a separate privileged guardian process at controlled barriers.
They do NOT simulate power failure, device-level writeback loss, or attacker root.
Only a committed durable intent makes a completed HOLD irrevocable in this
local-root threat model; pre-commit termination has no committed withdrawal.
"""
import json
import os
import select
import signal
import subprocess
import sys
import unittest

import test_koru_root_hold_floor as base

CHILD = r"""
import os,sys
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_root_hold_floor import RootOwnedHoldFloor
import koru_root_hold_floor as floor_module

lock, directory, phase = sys.argv[1:]
fence = ProvisionedCrossUidFence(lock, shared_gid=65531)
floor = RootOwnedHoldFloor(directory)

def barrier(label):
    print(label, flush=True)
    assert sys.stdin.readline() == 'continue\\n', 'unexpected barrier release'

if phase == 'before-intent':
    original_open = floor_module.os.open
    def intercepted_open(path, *args, **kwargs):
        if path == 'hold-intent':
            barrier('BEFORE_INTENT')
        return original_open(path, *args, **kwargs)
    floor_module.os.open = intercepted_open
elif phase in ('after-intent-sync', 'after-floor-rename'):
    original_sync = floor._sync_directory
    count = [0]
    def intercepted_sync():
        count[0] += 1
        if phase == 'after-intent-sync' and count[0] == 1:
            original_sync()
            barrier('AFTER_INTENT_SYNC')
            return
        if phase == 'after-floor-rename' and count[0] == 2:
            barrier('AFTER_RENAME_BEFORE_SYNC')
        return original_sync()
    floor._sync_directory = intercepted_sync
else:
    raise ValueError('unsupported kill point')
floor.commit_hold(fence)
floor.close()
fence.close()
"""

@unittest.skipUnless(sys.platform == 'linux' and os.geteuid() == 0,
                     'disposable root Linux termination test only')
class GuardianSigkillRecoveryTests(unittest.TestCase):
    def setUp(self):
        self.fixture = base.RootFloorRollbackTests(
            methodName='test_pre_hold_signed_effect_then_old_snapshot_replay_denied')
        self.fixture.setUp()
        self.guardian = None

    def tearDown(self):
        try:
            if self.guardian is not None:
                if self.guardian.poll() is None:
                    self.guardian.kill()
                self.guardian.communicate(timeout=5)
        finally:
            self.fixture.tearDown()

    def kill_at(self, phase, expected):
        c = self.fixture.case
        self.guardian = subprocess.Popen(
            [sys.executable, '-B', '-c', CHILD, str(c.lock),
             str(self.fixture.root_floor_dir), phase],
            cwd='/', env=c.env,
            stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True, bufsize=1)
        ready, _, _ = select.select([self.guardian.stdout], [], [], 6)
        self.assertTrue(ready, 'guardian did not reach injected barrier')
        line = self.guardian.stdout.readline().strip()
        self.assertEqual(line, expected,
                         'guardian failed before barrier: ' +
                         (self.guardian.stderr.read()
                          if self.guardian.poll() is not None else line))
        self.assertIsNone(self.guardian.poll())
        os.kill(self.guardian.pid, signal.SIGKILL)
        self.assertEqual(self.guardian.wait(timeout=5), -signal.SIGKILL)
        # Kernel releases flock held by the forcibly terminated process.
        # The writer's next attempt therefore checks the persisted state.

    def assert_denied_and_restart(self):
        c = self.fixture.case
        self.assertEqual(c.request()['code'], 'writer_authorization_denied')
        c.stop_writer()
        self.fixture.start_anchored_writer()
        self.assertEqual(c.request()['code'], 'writer_authorization_denied')
        self.assertEqual(list(c.marker.iterdir()), [])

    def test_sigkill_after_durable_intent_before_floor_update(self):
        self.kill_at('after-intent-sync', 'AFTER_INTENT_SYNC')
        self.assertTrue((self.fixture.root_floor_dir/'hold-intent').exists())
        self.assertFalse(json.loads(self.fixture.root_floor_file.read_text())['held'])
        self.assert_denied_and_restart()

    def test_sigkill_after_floor_rename_before_directory_sync(self):
        self.kill_at('after-floor-rename', 'AFTER_RENAME_BEFORE_SYNC')
        self.assertTrue((self.fixture.root_floor_dir/'hold-intent').exists())
        self.assert_denied_and_restart()

    def test_sigkill_before_intent_is_precommit_not_committed_hold(self):
        self.kill_at('before-intent', 'BEFORE_INTENT')
        self.assertFalse((self.fixture.root_floor_dir/'hold-intent').exists())
        self.assertFalse(json.loads(self.fixture.root_floor_file.read_text())['held'])
        # This is a named limitation, not a success for revocation:
        # an interrupted request before its durable commit cannot be
        # acknowledged as a completed HOLD. The old permit remains valid.
        self.assertEqual(self.fixture.case.request()['code'],
                         'empty_marker_created')


if __name__ == '__main__':
    unittest.main()
