"""Distinct-UID fixed marker executor using a separate authority UID.

Executor can write only its own synthetic marker. It does NOT own or open
the authority database. It holds a root-provisioned flock over the remote
authority 'prepare' roundtrip AND its effect. Authority HOLD takes the same
flock. No arbitrary callbacks, paths or effects are accepted.

Critical research limit: advisory flock possession is not attestable via the
authority RPC. A compromised executor can bypass the shared lock; the only
supported caller is the trusted executor fixture. No general production
guarantee, external host, anti-rollback or real-world protection.
"""
import json
import os
import socket
import socketserver
import stat
import struct

from koru_cross_uid_fence import ProvisionedCrossUidFence
from koru_separated_authority_service import request_authority

MAX_REQUEST = 512


class _Handler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            raw = self.request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _, uid, _ = struct.unpack("3i", raw)
            if uid != self.server.requester_uid:
                return self.reply({"ok": False, "code": "peer_denied"})
            req = self.rfile.readline(MAX_REQUEST + 1)
            if not req.endswith(b"\n") or len(req) > MAX_REQUEST:
                return self.reply({"ok": False, "code": "bad_request"})
            if json.loads(req) != {"op": "fixed_marker"}:
                return self.reply({"ok": False, "code": "bad_request"})
            with self.server.fence:
                reply = request_authority(
                    self.server.authority_socket,
                    {"op": "prepare"},
                    self.server.authority_uid)
                if reply != {"ok": True, "code": "started_recorded_only"}:
                    return self.reply({"ok": False, "code": "authority_denied"})
                return self.reply(self.server.write_fixed_marker())
        except Exception:
            self.reply({"ok": False, "code": "executor_unavailable_or_uncertain"})

    def reply(self, value):
        self.wfile.write((json.dumps(value, sort_keys=True) + "\n").encode())


class SeparatedEffectExecutor(socketserver.UnixStreamServer):
    def __init__(self, socket_path, marker_dir, authority_socket, lock_path,
                 *, requester_uid, authority_uid, lock_gid):
        if (os.geteuid() == 0 or
                type(requester_uid) is not int or
                type(authority_uid) is not int or
                requester_uid <= 0 or authority_uid <= 0 or
                os.geteuid() in (requester_uid, authority_uid) or
                requester_uid == authority_uid):
            raise ValueError("three nonroot principals required")
        self.requester_uid = requester_uid
        self.authority_uid = authority_uid
        self.authority_socket = authority_socket
        self.dirfd = os.open(marker_dir, os.O_RDONLY | os.O_DIRECTORY |
                             os.O_NOFOLLOW | os.O_CLOEXEC)
        self.fence = None
        try:
            st = os.fstat(self.dirfd)
            if (st.st_uid != os.geteuid() or
                    not stat.S_ISDIR(st.st_mode) or
                    stat.S_IMODE(st.st_mode) != 0o700):
                raise PermissionError("marker directory not private")
            self.fence = ProvisionedCrossUidFence(lock_path, shared_gid=lock_gid)
            super().__init__(socket_path, _Handler)
            os.chmod(socket_path, 0o666)
        except BaseException:
            if self.fence is not None:
                self.fence.close()
            os.close(self.dirfd)
            raise

    def write_fixed_marker(self):
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
        return {"ok": True, "code": "fixture_marker_created"}

    def server_close(self):
        try:
            super().server_close()
        finally:
            self.fence.close()
            os.close(self.dirfd)
