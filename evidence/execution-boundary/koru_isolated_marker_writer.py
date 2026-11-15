"""Experimental dedicated-UID marker writer endpoint (NOT a production daemon).

Only creates empty SHA-256(event_id) marker files in a pre-provisioned
writer-owned private directory, following independent writer-side policy.
No CLI, default policy, production launcher, arbitrary effect or global agent
configuration is provided. The caller cannot send or replace the policy.

The external caller's signed event has NOT been validated by this module;
a future integration MUST supply an independent authorization policy that
rechecks signature, context, revocation, time, admission, and recovery state
at the enactment boundary. The default constructor denies every operation.
"""
import hashlib
import json
import os
import socket
import socketserver
import stat
import struct
import sys

MAX_REQUEST = 4096


class WriterConfigurationError(ValueError):
    pass


def marker_name(event_id):
    if (type(event_id) is not str or not event_id
            or len(event_id.encode("utf-8")) > 512):
        raise ValueError("invalid event_id")
    return hashlib.sha256(event_id.encode("utf-8")).hexdigest() + ".marker"


class _WriterHandler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            raw = self.request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _pid, uid, _gid = struct.unpack("3i", raw)
        except (OSError, AttributeError, struct.error):
            self._reply({"ok": False, "code": "peer_unverifiable"})
            return
        if uid != self.server.broker_uid:
            self._reply({"ok": False, "code": "peer_denied"})
            return
        payload = self.rfile.readline(MAX_REQUEST + 1)
        if (not payload or len(payload) > MAX_REQUEST
                or not payload.endswith(b"\n")):
            self._reply({"ok": False, "code": "bad_request"})
            return
        try:
            request = json.loads(payload)
        except (UnicodeError, ValueError):
            self._reply({"ok": False, "code": "bad_request"})
            return
        if type(request) is not dict or set(request) != {"op", "event_id"}:
            self._reply({"ok": False, "code": "bad_request"})
            return
        if request["op"] != "create_empty_marker":
            self._reply({"ok": False, "code": "unsupported_operation"})
            return
        try:
            name = marker_name(request["event_id"])
        except (ValueError, UnicodeError):
            self._reply({"ok": False, "code": "invalid_effect_identity"})
            return
        # The independent policy is supplied in-process by the writer's
        # trusted operator, NOT serialized by the broker. Deny on errors.
        try:
            authorized = self.server.authorize(request["event_id"]) is True
        except Exception:
            authorized = False
        if not authorized:
            self._reply({"ok": False, "code": "writer_authorization_denied"})
            return
        # This low-level transport does NOT replace the existing broker's
        # revocation linearization or cross-resource recovery. No production
        # wiring is allowed without fresh independent end-to-end tests.
        self._reply(self.server.write_marker(name))

    def _reply(self, result):
        self.wfile.write((json.dumps(result, sort_keys=True) + "\n").encode())


class IsolatedMarkerWriter(socketserver.UnixStreamServer):
    """Synchronous one-request-per-connection writer for disposable tests."""

    def __init__(self, socket_path, marker_directory, *, broker_uid,
                 authorize=None):
        if sys.platform != "linux" or not hasattr(socket, "SO_PEERCRED"):
            raise WriterConfigurationError("Linux SO_PEERCRED required")
        if type(broker_uid) is not int or broker_uid <= 0:
            raise WriterConfigurationError("non-root broker UID required")
        if os.geteuid() == 0:
            raise WriterConfigurationError("root writer identity forbidden")
        if os.geteuid() == broker_uid:
            raise WriterConfigurationError("writer and broker must use distinct UIDs")
        self.broker_uid = broker_uid
        self.authorize = authorize if callable(authorize) else lambda _id: False
        # Open a held directory FD; verify ownership and mode before listening.
        self.dirfd = os.open(
            marker_directory, os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW |
            os.O_CLOEXEC)
        try:
            info = os.fstat(self.dirfd)
            if (not stat.S_ISDIR(info.st_mode) or info.st_uid != os.geteuid()
                    or (info.st_mode & 0o777) != 0o700):
                raise WriterConfigurationError("writer private directory must be 0700 and owned by writer")
            super().__init__(socket_path, _WriterHandler)
            # Publicly connectable socket; SO_PEERCRED enforces the broker UID.
            # Parent directory provisioning is an operator obligation.
            os.chmod(socket_path, 0o666)
        except BaseException:
            os.close(self.dirfd)
            raise

    def write_marker(self, name):
        # Only the fixed event-derived name is ever opened beneath dirfd.
        try:
            fd = os.open(name, os.O_WRONLY | os.O_CREAT | os.O_EXCL |
                         os.O_NOFOLLOW | os.O_CLOEXEC, 0o600, dir_fd=self.dirfd)
        except FileExistsError:
            return {"ok": False, "code": "marker_exists_needs_reconciliation"}
        except OSError:
            return {"ok": False, "code": "filesystem_failure"}
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
        return {"ok": True, "code": "empty_marker_created"}

    def server_close(self):
        super().server_close()
        os.close(self.dirfd)
