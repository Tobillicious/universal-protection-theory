"""Authority-owned, fixed synthetic effect endpoint for disposable Linux tests.

Unlike the executor-owned marker in #550, the authority process owns BOTH the
admission/HOLD state and the fixed marker directory. The executor/requester
UIDs have no DAC permission to create or modify a marker. The only effect
entrypoint is the authority's fixed-schema peer-authenticated Unix socket.

The authority checks HOLD under BEGIN IMMEDIATE for the actual file write,
using #548's one-way started journal. There is no advisory-lock dependency in
the effect path. This narrows the fixture to ONE fixed synthetic marker.

NOT a multi-host trust anchor, mandatory confinement of arbitrary effects,
compromised-authority/root resistance, rollback protection, consent proof, or
atomic commit across SQLite and filesystem. No general production launcher.
"""
import json
import os
import socket
import socketserver
import stat
import struct

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_authority_effect_time_fence import AuthorityEffectTimeFence
from koru_transactional_hold_witness import TransactionalHoldWitness
from koru_bounded_server import read_framed_request
from koru_authority_reserved_workers import ReservedAuthorityThreadingMixIn

MAX_REQUEST = 512
OPERATION = "single-authority-marker"


class _Handler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            raw = self.request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _pid, uid, _gid = struct.unpack("3i", raw)
            data = read_framed_request(
                self.request, max_bytes=MAX_REQUEST,
                total_timeout=self.server.request_timeout)
            if data is None:
                return self.reply({"ok": False, "code": "bad_request"})
            request = json.loads(data)
            if request == {"op": "fixed_marker"} and uid == self.server.executor_uid:
                recorded = self.server.journal.admit(OPERATION, self.server.expected)
                if recorded != {"ok": True, "code": "intent_recorded_only"}:
                    return self.reply({"ok": False, "code": "authority_denied"})
                result = self.server.fence.execute_synthetic(
                    OPERATION, self.server.expected, lambda: True,
                    self.server.write_fixed_marker)
                return self.reply(result)
            if request == {"op": "hold"} and uid == self.server.controller_uid:
                held = self.server.journal.hold()
                return self.reply({"ok": held["held"] is True,
                                   "code": "hold_recorded"})
            return self.reply({"ok": False, "code": "peer_or_operation_denied"})
        except Exception:
            self.reply({"ok": False, "code": "authority_unavailable_or_uncertain"})

    def reply(self, value):
        self.wfile.write((json.dumps(value, sort_keys=True) + "\n").encode())


class AuthorityOwnedMarkerService(ReservedAuthorityThreadingMixIn,
                                  socketserver.UnixStreamServer):
    daemon_threads = True
    block_on_close = True

    def __init__(self, socket_path, authority_db, marker_directory, *,
                 executor_uid, controller_uid, expected,
                 executor_slots=8, controller_slots=2, request_timeout=1.0):
        if (os.geteuid() == 0 or type(executor_uid) is not int or
                type(controller_uid) is not int or
                executor_uid <= 0 or controller_uid <= 0 or
                os.geteuid() in (executor_uid, controller_uid) or
                executor_uid == controller_uid or
                type(expected) is not dict or
                set(expected) != {"generation", "event_id", "authority_ref"}):
            raise ValueError("distinct unprivileged service principals required")
        self.executor_uid = executor_uid
        self.controller_uid = controller_uid
        self.configure_authority_bounds(
            executor_slots=executor_slots, controller_slots=controller_slots,
            request_timeout=request_timeout)
        self.expected = dict(expected)
        self.dirfd = os.open(
            marker_directory, os.O_RDONLY | os.O_DIRECTORY |
            os.O_NOFOLLOW | os.O_CLOEXEC)
        try:
            st = os.fstat(self.dirfd)
            if (not stat.S_ISDIR(st.st_mode) or
                    st.st_uid != os.geteuid() or
                    stat.S_IMODE(st.st_mode) != 0o700):
                raise PermissionError("authority marker directory must be private")
            dbstat = os.stat(authority_db, follow_symlinks=False)
            if (not stat.S_ISREG(dbstat.st_mode) or
                    dbstat.st_uid != os.geteuid() or
                    stat.S_IMODE(dbstat.st_mode) & 0o077):
                raise PermissionError("private authority DB required")
            self.journal = AuthorityAdmissionJournal(
                TransactionalHoldWitness(authority_db))
            self.journal.unresolved()  # never auto-reprovision on restart
            self.fence = AuthorityEffectTimeFence(self.journal)
            super().__init__(socket_path, _Handler)
            os.chmod(socket_path, 0o666)
        except BaseException:
            os.close(self.dirfd)
            raise

    def write_fixed_marker(self):
        # No path, content or callback originates from the network request.
        try:
            fd = os.open("fixed.marker", os.O_WRONLY | os.O_CREAT |
                         os.O_EXCL | os.O_NOFOLLOW | os.O_CLOEXEC,
                         0o600, dir_fd=self.dirfd)
        except OSError:
            return {"ok": False, "code": "marker_exists_or_unavailable"}
        try:
            os.fsync(fd)
        except OSError:
            return {"ok": False, "code": "outcome_uncertain"}
        finally:
            os.close(fd)
        try:
            os.fsync(self.dirfd)
        except OSError:
            return {"ok": False, "code": "outcome_uncertain"}
        return {"ok": True, "code": "fixed_marker_created"}

    def server_close(self):
        try:
            super().server_close()
        finally:
            os.close(self.dirfd)
