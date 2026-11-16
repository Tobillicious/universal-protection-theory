"""R4 contrast: a shared rollback administrator defeats local-only custody.

This is a deliberately adversarial *negative control*, not a proof of
independent custody or a positive release test. It reuses existing real mTLS,
signed witness, and local SQLite fixtures without introducing a new authority.
"""
import shutil
import unittest
from pathlib import Path

from test_koru_operator_surviving_rollback import SurvivingOperatorRollbackTests


class AllStoresRollbackContrast(unittest.TestCase):
    def setUp(self):
        self.f = SurvivingOperatorRollbackTests(
            methodName="test_all_four_application_stores_rollback_external_floor_survives")
        self.f.setUp()

    def tearDown(self):
        self.f.tearDown()

    def test_shared_admin_rollback_erases_historical_hold_observation(self):
        f = self.f
        # Preserve pre-HOLD snapshots of four application-owned stores
        # PLUS the deliberately same-admin operator store.
        app_backup = f._backup_application_history()
        operator_backup = str(Path(f.temp.name) / "pre-hold-operator.sqlite")
        shutil.copyfile(f.custody_floor.path, operator_backup)

        f.create_partial_commit()
        self.assertEqual(f.custodian.observe_pair(
            f.a.read(), f.b.read())["revision"], 1)
        self.assertEqual(f._recovery()["revision"], 1)
        self.assertEqual(f.remote("a" * 64)["revision"], 1)

        # Model one administrator's ability to restore ALL local files.
        # This is the adversarial control excluded by #590/#591's surviving
        # operator test. No protected marker or real HOLD is changed.
        f._restore_application_history(app_backup)
        shutil.copyfile(operator_backup, f.custody_floor.path)

        self.assertEqual(f.a.read()["revision"], 0)
        self.assertEqual(f.b.read()["revision"], 0)
        self.assertEqual(f.anchor.read_floor()[0], 0)
        self.assertEqual(f.floor.read_floor()[0], 0)
        self.assertEqual(f.custody_floor.read_floor()[0], 0)

        # A freshly challenge-signed checkpoint now reports the *old*
        # history. Signature correctness alone cannot expose deleted events.
        old_packet = f.remote("b" * 64)
        self.assertEqual(old_packet["revision"], 0)
        self.assertEqual(old_packet["nonce"], "b" * 64)
        # Recovery remains history-only and is not an effect permit.
        with self.assertRaises(PermissionError):
            f._recovery()


if __name__ == "__main__":
    unittest.main()
