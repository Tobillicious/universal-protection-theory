"""Agent 3: coordinated application rollback against surviving operator custody.

All stores are local disposable SQLite fixtures; this is a *contrast test*,
not proof of real administrative separation. The operator-held floor is
intentionally NOT restored. No history-only result authorizes an effect.
"""
import shutil
from pathlib import Path

from koru_operator_checkpoint_recovery import recover_with_operator_checkpoint
from test_koru_operator_checkpoint_mtls import OperatorMTLSTests


class SurvivingOperatorRollbackTests(OperatorMTLSTests):
    def _backup_application_history(self):
        backups = []
        for name, path in (
                ("primary", self.a.path),
                ("secondary", self.b.path),
                ("observer", self.floor.path),
                ("anchor", self.anchor.path)):
            saved = str(Path(self.temp.name) / ("pre-hold-" + name + ".sqlite"))
            shutil.copyfile(path, saved)
            backups.append((saved, path))
        return backups

    def _restore_application_history(self, backups):
        for saved, path in backups:
            shutil.copyfile(saved, path)

    def _recovery(self):
        primary, secondary = self.reads()
        return recover_with_operator_checkpoint(
            anchored=self.anchored,
            primary_read=primary,
            secondary_read=secondary,
            operator_read=self.remote,
            operator_public_key=self.custodian.public_key)

    def test_all_four_application_stores_rollback_external_floor_survives(self):
        saved = self._backup_application_history()
        # HOLD commits at both witness journals and retained anchor.
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        # Previously supported partial reconciliation completes.
        self.assertEqual(self._recovery()["revision"], 1)
        self.assertEqual(self.floor.read_floor()[0], 1)
        self.assertEqual(self.custody_floor.read_floor()[0], 1)
        self._restore_application_history(saved)

        self.assertEqual(self.a.read()["revision"], 0)
        self.assertEqual(self.b.read()["revision"], 0)
        self.assertEqual(self.anchor.read_floor()[0], 0)
        self.assertEqual(self.floor.read_floor()[0], 0)
        # Operator read remains valid and one revision AHEAD of application.
        self.assertEqual(self.remote("e" * 64)["revision"], 1)
        with self.assertRaisesRegex(PermissionError, "differs"):
            self._recovery()
        self.assertEqual(self.floor.read_floor()[0], 0)
        self.assertEqual(self.custody_floor.read_floor()[0], 1)

    def test_operator_floor_never_rewinds_on_old_dual_signed_receipts(self):
        old_a, old_b = self.a.read(), self.b.read()
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        with self.assertRaisesRegex(PermissionError, "rollback"):
            self.custodian.observe_pair(old_a, old_b)
        self.assertEqual(self.remote("f" * 64)["revision"], 1)

    def test_missing_operator_floor_fails_closed_during_remote_read(self):
        import os
        os.unlink(self.custody_floor.path)
        with self.assertRaises(PermissionError):
            self._recovery()
        self.assertFalse(os.path.exists(self.custody_floor.path))


if __name__ == "__main__":
    import unittest
    unittest.main()
