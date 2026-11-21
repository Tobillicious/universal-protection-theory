"""Durable deny-only rights-veto journal for offline G3 research.

Never a consent source or an effect-granting reference monitor. Only a
separately authenticated trusted controller may call record_withdrawal.
No IPC interface is provided. Filesystem/host compromise remains out of scope.
"""
import os
import sqlite3
import stat
import threading
from pathlib import Path

HEX = frozenset("0123456789abcdef")


def _key(x):
    return type(x) is str and 1 <= len(x) <= 160 and x.isascii() and all(
        33 <= ord(c) <= 126 for c in x)


def _digest(x):
    return type(x) is str and len(x) == 64 and all(c in HEX for c in x)


class RightsVetoJournal:
    def __init__(self, db_path, *, initialize=False):
        # Initialization is an explicit provisioning operation. A missing or
        # corrupt journal on restart MUST NOT silently become an empty ledger.
        if type(initialize) is not bool:
            raise TypeError("initialize must be boolean")
        path = Path(db_path)
        parent = path.parent.resolve(strict=True)
        pst = parent.stat()
        if (not stat.S_ISDIR(pst.st_mode) or pst.st_uid != os.geteuid()
                or pst.st_mode & 0o077):
            raise PermissionError("journal directory must be private to controller")
        if path.is_symlink():
            raise PermissionError("symlink journal denied")
        existed = path.exists()
        if initialize and existed:
            raise FileExistsError("refuse reinitialization of existing veto journal")
        if not initialize and not existed:
            raise FileNotFoundError("existing veto journal required for restart")
        if existed:
            st = path.stat()
            if not stat.S_ISREG(st.st_mode) or st.st_nlink != 1 or st.st_uid != os.geteuid() or st.st_mode & 0o077:
                raise PermissionError("journal file must be private")
        if initialize:
            # URI mode=rwc is deliberately allowed only for explicit creation.
            database = "file:" + str(path.resolve()) + "?mode=rwc"
        else:
            database = "file:" + str(path.resolve()) + "?mode=rw"
        self.db = sqlite3.connect(database, uri=True, isolation_level=None,
                                  check_same_thread=False, timeout=5)
        self.lock = threading.RLock()
        if initialize:
            os.chmod(path, 0o600)
        try:
            self.db.execute("PRAGMA journal_mode=WAL")
            self.db.execute("PRAGMA synchronous=FULL")
            if initialize:
                self.db.executescript("""
                CREATE TABLE IF NOT EXISTS control (
                    id INTEGER PRIMARY KEY CHECK(id=1),
                    generation INTEGER NOT NULL,
                    halted INTEGER NOT NULL
                );
                INSERT OR IGNORE INTO control VALUES (1,0,1);
                CREATE TABLE IF NOT EXISTS withdrawn (
                    record_ref TEXT PRIMARY KEY,
                    subject TEXT NOT NULL,
                    action TEXT NOT NULL,
                    effect_digest TEXT NOT NULL,
                    generation INTEGER NOT NULL
                );
                """)
            # Opening the journal never automatically resumes any action.
            with self.lock:
                self.db.execute("BEGIN IMMEDIATE")
                try:
                    row = self.db.execute(
                        "UPDATE control SET halted=1 WHERE id=1")
                    if row.rowcount != 1:
                        raise RuntimeError("missing veto control row")
                    state = self.db.execute(
                        "SELECT generation FROM control WHERE id=1").fetchone()
                    if state is None or type(state[0]) is not int or state[0] < 0:
                        raise RuntimeError("veto control generation invalid")
                    self.db.execute("COMMIT")
                except BaseException:
                    self.db.execute("ROLLBACK")
                    raise
        except BaseException:
            self.db.close()
            raise

    def _state(self):
        row = self.db.execute("SELECT generation,halted FROM control WHERE id=1").fetchone()
        if row is None or type(row[0]) is not int or row[1] != 1:
            raise RuntimeError("veto control integrity failure")
        return row[0]

    def record_withdrawal(self, *, record_ref, subject, action,
                          effect_digest, generation):
        """Trusted controller API: durable, irreversible within this database.

        The generation must advance exactly by one; no unsigned application
        request or self-asserted consent has a route to this API.
        """
        if (not all(_key(x) for x in (record_ref, subject, action))
                or not _digest(effect_digest)
                or type(generation) is not int or generation < 1 or generation >= 2**63):
            return {"ok": False, "code": "invalid_withdrawal"}
        with self.lock:
            try:
                self.db.execute("BEGIN IMMEDIATE")
                current = self._state()
                if generation != current + 1:
                    self.db.execute("ROLLBACK")
                    return {"ok": False, "code": "stale_or_skipped_generation"}
                row = self.db.execute("SELECT 1 FROM withdrawn WHERE record_ref=?",
                                      (record_ref,)).fetchone()
                if row:
                    self.db.execute("ROLLBACK")
                    return {"ok": False, "code": "record_already_withdrawn"}
                self.db.execute("INSERT INTO withdrawn VALUES (?,?,?,?,?)",
                                (record_ref, subject, action, effect_digest, generation))
                self.db.execute("UPDATE control SET generation=? WHERE id=1", (generation,))
                self.db.execute("COMMIT")
                return {"ok": True, "code": "withdrawal_recorded", "generation": generation}
            except BaseException:
                if self.db.in_transaction:
                    self.db.execute("ROLLBACK")
                raise

    def inspect(self, *, record_ref, subject, action, effect_digest,
                expected_generation):
        """Never authorize: return only whether a *local* denial is recorded.

        Unknown records and stale snapshots are denied, not granted.
        An absent withdrawal is NOT evidence of authentic consent.
        """
        base = {"authorizes_effect": False, "authentic_consent_proved": False,
                "original_six_x3_proved": False}
        if (not all(_key(x) for x in (record_ref, subject, action))
                or not _digest(effect_digest)
                or type(expected_generation) is not int or expected_generation < 0):
            return dict(base, code="invalid_query", local_veto=True)
        with self.lock:
            try:
                self.db.execute("BEGIN")
                current = self._state()
                row = self.db.execute(
                    "SELECT subject,action,effect_digest FROM withdrawn WHERE record_ref=?",
                    (record_ref,)).fetchone()
                self.db.execute("COMMIT")
            except (sqlite3.Error, RuntimeError):
                if self.db.in_transaction:
                    self.db.execute("ROLLBACK")
                return dict(base, code="journal_integrity_unknown", local_veto=True)
        if expected_generation != current:
            return dict(base, code="stale_generation", local_veto=True)
        if row is not None:
            return dict(base, code="record_withdrawn", local_veto=True)
        return dict(base, code="no_local_withdrawal_found_not_authorized",
                    local_veto=False)

    def close(self):
        with self.lock:
            self.db.close()
