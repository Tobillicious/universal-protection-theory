"""SQLite-backed HOLD witness state machine for disposable Linux research.

A practical transaction/storage adapter for the signed witness transport in
#539. Not externally administered, not rollback-proof, not a proof of power
loss durability, and not a deployed service. The database and journal can be
replaced by host root, so it MUST NOT be treated as a production anti-rollback
source.
"""
import os
import sqlite3
from contextlib import closing
from urllib.parse import quote

_FIELDS = ("generation", "held", "event_id", "authority_ref")


def _valid(value):
    return (type(value) is dict and set(value) == set(_FIELDS) and
            type(value["generation"]) is int and value["generation"] >= 1 and
            type(value["held"]) is bool and
            type(value["event_id"]) is str and
            0 < len(value["event_id"]) <= 512 and value["event_id"].isascii() and
            type(value["authority_ref"]) is str and
            0 < len(value["authority_ref"]) <= 512 and
            value["authority_ref"].isascii())


class TransactionalHoldWitness:
    def __init__(self, path):
        if (type(path) is not str or not os.path.isabs(path) or
                os.path.normpath(path) != path):
            raise ValueError("canonical absolute witness DB path required")
        self.path = path

    def _connect(self):
        # Refuse to create a fresh 'unheld' database on a missing/corrupt
        # witness path. Deployment must independently authenticate DB origin.
        uri = "file:" + quote(self.path, safe="/") + "?mode=rw"
        db = sqlite3.connect(uri, uri=True, timeout=2, isolation_level=None)
        try:
            db.execute("PRAGMA busy_timeout=2000")
            db.execute("PRAGMA synchronous=FULL")
            db.execute("PRAGMA journal_mode=DELETE")
            return db
        except BaseException:
            db.close()
            raise

    @staticmethod
    def _decode(row):
        if row is None:
            raise ValueError("missing trusted witness row")
        generation, held, event_id, authority_ref = row
        state = dict(generation=generation, held=held,
                     event_id=event_id, authority_ref=authority_ref)
        if type(held) is not int or held not in (0, 1):
            raise ValueError("invalid HOLD marker")
        state["held"] = bool(held)
        if not _valid(state):
            raise ValueError("corrupt witness row")
        return state

    @staticmethod
    def provision(path, state):
        """Fixture-only initialization. Never called from read/restart path."""
        if not _valid(state) or state["held"]:
            raise ValueError("explicit valid initial unheld state required")
        fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL |
                     os.O_CLOEXEC | os.O_NOFOLLOW, 0o600)
        os.close(fd)
        try:
            witness = TransactionalHoldWitness(path)
            with closing(witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                db.execute("""CREATE TABLE witness (
                  id INTEGER PRIMARY KEY CHECK (id = 1),
                  generation INTEGER NOT NULL CHECK (generation >= 1),
                  held INTEGER NOT NULL CHECK (held IN (0,1)),
                  event_id TEXT NOT NULL,
                  authority_ref TEXT NOT NULL)""")
                db.execute("INSERT INTO witness VALUES (1, ?, 0, ?, ?)",
                           (state["generation"], state["event_id"],
                            state["authority_ref"]))
                db.execute("COMMIT")
            return witness
        except BaseException:
            os.unlink(path)
            raise

    def read(self):
        with closing(self._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                rows = db.execute(
                    "SELECT generation, held, event_id, authority_ref "
                    "FROM witness").fetchall()
                if len(rows) != 1:
                    raise ValueError("witness row count invalid")
                result = self._decode(rows[0])
                db.execute("COMMIT")
                return result
            except BaseException:
                db.execute("ROLLBACK")
                raise

    def commit_hold(self):
        """Irreversible within one uncompromised live SQLite DB history.

        Serialization against read() is provided by BEGIN IMMEDIATE. This
        DOES NOT lock a real protected effect after the read completes.
        """
        with closing(self._connect()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                rows = db.execute(
                    "SELECT generation, held, event_id, authority_ref "
                    "FROM witness").fetchall()
                if len(rows) != 1:
                    raise ValueError("witness row count invalid")
                state = self._decode(rows[0])
                if not state["held"]:
                    db.execute(
                        "UPDATE witness SET held=1, generation=? WHERE id=1",
                        (state["generation"] + 1,))
                db.execute("COMMIT")
                return self.read()
            except BaseException:
                db.execute("ROLLBACK")
                raise
