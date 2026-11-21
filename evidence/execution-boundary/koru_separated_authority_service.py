"""Cross-UID authority *research* endpoint: prepare-start and HOLD.

Authority owns its own SQLite DB. Executor must acquire a root-provisioned
common flock, then request 'prepare' and keep the SAME lock held throughout
a synthetic effect. HOLD acquires that same flock before committing.

The socket is deliberately threaded: if HOLD arrives first and waits for
executor's flock, preparation must still be serviced rather than deadlock.

This is a same-host, cooperating-principal prototype: not unforgeable lock
ownership, independent administration, rollback resistance or production.
"""
import json
import os
import socket
import socketserver
import struct

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_transaction_scoped_effect import _exact_unheld
from koru_transactional_hold_witness import TransactionalHoldWitness

MAX_REQUEST = 512
OP_ID = "single-fixture-op"


class _Handler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            peer = self.request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _, uid, _ = struct.unpack("3i", peer)
            request = self.rfile.readline(MAX_REQUEST + 1)
            if not request.endswith(b"\n") or len(request) > MAX_REQUEST:
                return self.reply({"ok": False, "code": "bad_request"})
            payload = json.loads(request)
            if payload == {"op": "prepare"} and uid == self.server.executor_uid:
                return self.reply(self.server.prepare())
            if payload == {"op": "hold"} and uid == self.server.controller_uid:
                # Keep the same lock held across the durable HOLD update.
                with self.server.fence:
                    held = self.server.journal.hold()
                return self.reply({"ok": bool(held["held"]), "code": "hold_recorded"})
            return self.reply({"ok": False, "code": "peer_or_operation_denied"})
        except Exception:
            self.reply({"ok": False, "code": "authority_unavailable_or_uncertain"})

    def reply(self, result):
        self.wfile.write((json.dumps(result, sort_keys=True) + "\n").encode())


class SeparatedAuthorityService(socketserver.ThreadingUnixStreamServer):
    daemon_threads = True
    block_on_close = True

    def __init__(self, path, db_path, lock_path, *, executor_uid,
                 controller_uid, lock_gid, expected):
        if (os.geteuid() == 0 or type(executor_uid) is not int or
                type(controller_uid) is not int or
                executor_uid <= 0 or controller_uid <= 0 or
                os.geteuid() in (executor_uid, controller_uid) or
                executor_uid == controller_uid or
                type(expected) is not dict or
                set(expected) != {"generation", "event_id", "authority_ref"}):
            raise ValueError("separated non-root authority and clients required")
        self.executor_uid = executor_uid
        self.controller_uid = controller_uid
        self.expected = dict(expected)
        self.journal = AuthorityAdmissionJournal(
            TransactionalHoldWitness(db_path))
        self.journal.unresolved()
        self.fence = ProvisionedCrossUidFence(lock_path, shared_gid=lock_gid)
        try:
            super().__init__(path, _Handler)
            os.chmod(path, 0o666)
        except BaseException:
            self.fence.close()
            raise

    def prepare(self):
        # The executor is obliged to own the external shared fence.
        # This service cannot itself prove peer flock ownership. The
        # unresolved gap is explicitly tested/documented.
        expected = self.expected
        r = self.journal.admit(OP_ID, expected)
        if not r.get("ok"):
            return {"ok": False, "code": "authority_denied"}
        witness = self.journal._authority
        from contextlib import closing
        try:
            with closing(witness._connect()) as db:
                db.execute("BEGIN IMMEDIATE")
                try:
                    state = DurableEffectIntentBoundary._load_state(db, witness)
                    rows = db.execute(
                        "SELECT operation_id, generation, event_id, "
                        "authority_ref, state FROM authority_admissions").fetchall()
                    if (len(rows) != 1 or rows[0] !=
                            (OP_ID, expected["generation"], expected["event_id"],
                             expected["authority_ref"], "unresolved") or
                            not _exact_unheld(state, expected)):
                        db.execute("ROLLBACK")
                        return {"ok": False, "code": "authority_denied"}
                    db.execute(
                        "UPDATE authority_admissions SET state='started' "
                        "WHERE operation_id=?", (OP_ID,))
                    db.execute("COMMIT")
                    return {"ok": True, "code": "started_recorded_only"}
                except BaseException:
                    if db.in_transaction:
                        db.execute("ROLLBACK")
                    raise
        except Exception:
            return {"ok": False, "code": "authority_unavailable_or_uncertain"}

    def server_close(self):
        try:
            super().server_close()
        finally:
            self.fence.close()


def request_authority(path, payload, expected_uid):
    """One request; caller must handle missing/incorrect reply as denial."""
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
        sock.settimeout(3)
        sock.connect(path)
        raw = sock.getsockopt(socket.SOL_SOCKET, socket.SO_PEERCRED,
                              struct.calcsize("3i"))
        _, uid, _ = struct.unpack("3i", raw)
        if uid != expected_uid:
            raise PermissionError("authority peer identity mismatch")
        sock.sendall((json.dumps(payload) + "\n").encode("ascii"))
        data = bytearray()
        while not data.endswith(b"\n"):
            chunk = sock.recv(1024)
            if not chunk or len(data) + len(chunk) > 2048:
                raise ValueError("incomplete authority response")
            data.extend(chunk)
        response = json.loads(data)
        if (type(response) is not dict or
                set(response) != {"ok", "code"} or
                type(response["ok"]) is not bool or
                type(response["code"]) is not str):
            raise ValueError("bad authority response")
        return response
