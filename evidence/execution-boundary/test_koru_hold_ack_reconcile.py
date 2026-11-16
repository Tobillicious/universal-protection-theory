"""HOLD acknowledgment and restart reconciliation using killed guardian.

No production IPC acknowledgment is implemented here: returned method results
are the narrow proof interface. They MUST NOT be exposed as a network API
without authentication and a complete service threat model.
"""
import json
import os
import sys
import unittest

import test_koru_guardian_sigkill as prior
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_root_hold_floor import RootOwnedHoldFloor


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable Linux root fixture only")
class HoldAcknowledgmentRecoveryTests(unittest.TestCase):
    def setUp(self):
        self.fixture=prior.GuardianSigkillRecoveryTests(
            methodName='test_sigkill_after_durable_intent_before_floor_update')
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def with_root(self, callback):
        c=self.fixture.fixture
        lock=ProvisionedCrossUidFence(str(c.case.lock),shared_gid=65531)
        floor=RootOwnedHoldFloor(str(c.root_floor_dir))
        try:
            return callback(floor,lock)
        finally:
            floor.close()
            lock.close()

    def test_killed_after_intent_reports_pending_not_ack_then_reconciles(self):
        c=self.fixture.fixture
        self.fixture.kill_at('after-intent-sync','AFTER_INTENT_SYNC')
        pending=self.with_root(lambda f,l:f.hold_status(l))
        self.assertEqual(pending['code'],'hold_pending_deny')
        self.assertFalse(pending['ok'])
        self.assertEqual(c.case.request()['code'],'writer_authorization_denied')
        repair=self.with_root(lambda f,l:f.reconcile_hold(l))
        self.assertEqual(repair['code'],'hold_reconciled')
        self.assertTrue(repair['ok'])
        final=self.with_root(lambda f,l:f.hold_status(l))
        self.assertEqual(final['code'],'hold_complete')
        self.assertEqual(final['generation'],repair['generation'])
        self.fixture.assert_denied_and_restart()
        # Duplicate reconciliation must not increase generation.
        again=self.with_root(lambda f,l:f.reconcile_hold(l))
        self.assertEqual(again['code'],'hold_already_complete')
        self.assertEqual(again['generation'],repair['generation'])

    def test_killed_after_rename_reports_complete_and_recovers_idempotently(self):
        self.fixture.kill_at('after-floor-rename','AFTER_RENAME_BEFORE_SYNC')
        st=self.with_root(lambda f,l:f.hold_status(l))
        self.assertEqual(st['code'],'hold_complete')
        done=self.with_root(lambda f,l:f.reconcile_hold(l))
        self.assertEqual(done['code'],'hold_already_complete')
        self.fixture.assert_denied_and_restart()

    def test_precommit_termination_is_never_acknowledged_or_reconciled(self):
        self.fixture.kill_at('before-intent','BEFORE_INTENT')
        status=self.with_root(lambda f,l:f.hold_status(l))
        self.assertEqual(status['code'],'hold_not_committed')
        self.assertFalse(status['ok'])
        with self.assertRaises(RuntimeError):
            self.with_root(lambda f,l:f.reconcile_hold(l))
        # This precommit condition DOES NOT prove withdrawn consent.
        self.assertEqual(self.fixture.fixture.case.request()['code'],
                         'empty_marker_created')

    def test_missing_intent_with_held_floor_is_not_acknowledged(self):
        c=self.fixture.fixture
        self.assertEqual(self.with_root(lambda f,l:f.commit_hold(l))['code'],
                         'floor_hold_committed')
        (c.root_floor_dir/'hold-intent').unlink()  # trusted root fault injection
        status=self.with_root(lambda f,l:f.hold_status(l))
        self.assertFalse(status['ok'])
        self.assertEqual(status['code'],'hold_inconsistent_deny')
        with self.assertRaises(RuntimeError):
            self.with_root(lambda f,l:f.commit_hold(l))
        self.assertEqual(c.case.request()['code'],'writer_authorization_denied')


if __name__ == '__main__':
    unittest.main()
