"""Disposable Linux effect executor owned by a distinct UID.

The requester has no write access to the marker directory or authority DB.
Only an expected SO_PEERCRED UID may request the *fixed* synthetic effect;
the executor itself commits admission then uses #548's effect-time fence.

Not a production launcher, independently administered authority, verified
consent, general-purpose effect proxy, anti-rollback mechanism or seccomp
confinement. The process owner and host root can still bypass these checks.
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

MAX_BYTES = 1024


class _Handler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            peer = self.request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _, uid, _ = struct.unpack("3i", peer)
            if uid != self.server.requester_uid:
                self.reply({"ok": False, "code": "peer_denied"})
                return
            raw = self.rfile.readline(MAX_BYTES + 1)
            if not raw.endswith(b"\n") or len(raw) > MAX_BYTES:
                self.reply({"ok": False, "code": "bad_request"})
                return
            payload = json.loads(raw)
            if payload != {"op": "create_fixture_marker"}:
                self.reply({"ok": False, "code": "bad_request"})
                return
            expected = self.server.expected
            recorded = self.server.journal.admit("single-fixture-op", expected)
            if not recorded.get("ok"):
                self.reply({"ok": False, "code": "authority_denied"})
                return
            answer = self.server.fence.execute_synthetic(
                "single-fixture-op", expected, lambda: True,
                self.server.write_fixed_marker)
            self.reply(answer)
        except Exception:
            self.reply({"ok": False, "code": "executor_unavailable_or_uncertain"})

    def reply(self, value):
        self.wfile.write((json.dumps(value, sort_keys=True) + "\n").encode())


class IsolatedAuthorityExecutor(socketserver.UnixStreamServer):
    def __init__(self, socket_path, marker_directory, authority_db,
                 *, requester_uid, expected):
        if (os.name != "posix" or not hasattr(socket, "SO_PEERCRED") or
                type(requester_uid) is not int or requester_uid <= 0 or
                os.geteuid() == 0 or requester_uid == os.geteuid()):
            raise ValueError("distinct nonroot Linux principals required")
        if (type(expected) is not dict or
                set(expected) != {"generation", "event_id", "authority_ref"}):
            raise ValueError("fixed expected identity required")
        self.requester_uid = requester_uid
        self.expected = dict(expected)
        self.dirfd = os.open(
            marker_directory, os.O_RDONLY | os.O_DIRECTORY |
            os.O_NOFOLLOW | os.O_CLOEXEC)
        try:
            st = os.fstat(self.dirfd)
            if (not stat.S_ISDIR(st.st_mode) or st.st_uid != os.geteuid()
                    or stat.S_IMODE(st.st_mode) != 0o700):
                raise PermissionError("marker directory not private to executor")
            authority = TransactionalHoldWitness(authority_db)
            if os.stat(authority_db, follow_symlinks=False).st_uid != os.geteuid():
                raise PermissionError("authority DB not executor-owned")
            self.journal = AuthorityAdmissionJournal(authority)
            self.fence = AuthorityEffectTimeFence(self.journal)
            # Must exist before service can accept any requests.
            self.journal.unresolved()
            super().__init__(socket_path, _Handler)
            os.chmod(socket_path, 0o666)
        except BaseException:
            os.close(self.dirfd)
            raise

    def write_fixed_marker(self):
        try:
            fd = os.open("fixed.marker", os.O_WRONLY | os.O_CREAT |
                         os.O_EXCL | os.O_NOFOLLOW | os.O_CLOEXEC,
                         0o600, dir_fd=self.dirfd)
        except FileExistsError:
            return {"ok": False, "code": "marker_exists"}
        except OSError:
            return {"ok": False, "code": "effect_unavailable"}
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
        return {"ok": True, "code": "fixture_marker_created"}

    def server_close(self):
        try:
            super().server_close()
        finally:
            os.close(self.dirfd)
