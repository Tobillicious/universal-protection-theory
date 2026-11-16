"""Client-retained signed revision floor; disposable G3 research ONLY.

Separate from the witness journal: accepting an old but valid signature after
witness rollback is forbidden when the observer's durable floor survives.
No trust bootstrap by remote read: the floor must be provisioned explicitly
from a trusted signed receipt. No silent recreation if it goes missing.

The local client's SQLite file is NOT hardware-backed, admin-independent or
anti-rollback. If both copies are rolled back, this does NOT detect it.
Successful observation means recorded history, NEVER permission for an effect.
"""
import os
import sqlite3
from contextlib import closing
from urllib.parse import quote

from koru_monotonic_revision_witness import verify_receipt

class ClientRevisionFloor:
    def __init__(self, path, public_key):
        if (type(path) is not str or not os.path.isabs(path) or
                os.path.normpath(path) != path):
            raise ValueError("canonical absolute floor path required")
        self.path = path
        self.public_key = public_key

    def _db(self):
        db = sqlite3.connect("file:" + quote(self.path, safe="/") +
                             "?mode=rw", uri=True, isolation_level=None,
                             timeout=3)
        try:
            db.execute("PRAGMA synchronous=FULL")
            db.execute("PRAGMA journal_mode=DELETE")
            db.execute("PRAGMA busy_timeout=2500")
            return db
        except BaseException:
            db.close()
            raise

    @classmethod
    def provision(cls, path, public_key, trusted_receipt):
        verified = verify_receipt(trusted_receipt, public_key)
        floor = cls(path, public_key)
        fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL |
                     os.O_NOFOLLOW | os.O_CLOEXEC, 0o600)
        os.close(fd)
        try:
            with closing(floor._db()) as db:
                db.execute("BEGIN IMMEDIATE")
                db.execute("""CREATE TABLE floor (
                    singleton INTEGER PRIMARY KEY CHECK(singleton=1),
                    revision INTEGER NOT NULL CHECK(revision>=0),
                    digest TEXT NOT NULL,
                    predecessor TEXT NOT NULL)""")
                db.execute("INSERT INTO floor VALUES (1, ?, ?, ?)",
                           (verified["revision"], verified["digest"],
                            verified["previous_digest"]))
                db.execute("COMMIT")
            return floor
        except BaseException:
            os.unlink(path)
            raise

    def _load(self, db):
        rows = db.execute(
            "SELECT singleton,revision,digest,predecessor FROM floor").fetchall()
        if len(rows) != 1 or rows[0][0] != 1:
            raise ValueError("missing/corrupt observer floor")
        _, revision, digest, predecessor = rows[0]
        # Use the same validated signed-receipt syntax and key, not
        # arbitrary string comparisons; unsigned data is never trusted.
        if (type(revision) is not int or revision < 0 or
                type(digest) is not str or len(digest) != 64 or
                type(predecessor) is not str or len(predecessor) != 64 or
                any(c not in "0123456789abcdef" for c in digest+predecessor)):
            raise ValueError("malformed observer floor")
        return revision, digest, predecessor

    def read_floor(self):
        with closing(self._db()) as db:
            return self._load(db)

    def accept(self, signed_receipt):
        """Commit observation before returning; disallow gaps and forks.

        A signed latest state from an ahead-of-us server does not prove every
        intermediate state transition. A gap requires an explicit replay
        protocol, not trust-by-assertion.
        """
        body = verify_receipt(signed_receipt, self.public_key)
        with closing(self._db()) as db:
            db.execute("BEGIN IMMEDIATE")
            try:
                old_rev, old_digest, old_pred = self._load(db)
                new_rev = body["revision"]
                if new_rev < old_rev:
                    raise PermissionError("remote signed rollback below observer floor")
                if new_rev == old_rev:
                    if (body["digest"] != old_digest or
                            body["previous_digest"] != old_pred):
                        raise PermissionError("conflicting signed revision fork")
                    db.execute("COMMIT")
                    return "already_observed"
                if (new_rev != old_rev+1 or
                        body["previous_digest"] != old_digest):
                    raise PermissionError("noncontiguous or divergent signed history")
                db.execute("UPDATE floor SET revision=?, digest=?, predecessor=? "
                           "WHERE singleton=1",
                           (new_rev, body["digest"], body["previous_digest"]))
                db.execute("COMMIT")
                return "observed_next"
            except BaseException:
                if db.in_transaction:
                    db.execute("ROLLBACK")
                raise


def request_with_observer_floor(address, query, *, floor, context, hostname,
                                server_fingerprint):
    """Authenticated TLS + pinned receipt + independent client observation."""
    from koru_mtls_revision_witness import request_mtls_witness
    if not isinstance(floor, ClientRevisionFloor):
        raise TypeError("explicit provisioned client floor required")
    response = request_mtls_witness(
        address, query, context=context, hostname=hostname,
        server_fingerprint=server_fingerprint, public_key=floor.public_key)
    if response["ok"]:
        floor.accept(response["receipt"])
    return response
