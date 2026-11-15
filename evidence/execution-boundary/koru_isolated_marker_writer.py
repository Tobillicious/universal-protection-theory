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


def validate_writer_request(request, *, signed_policy=None, fixture_authorize=None):
    """Fail-closed request validation. Never executes an effect."""
    if type(request) is not dict:
        return {"ok": False, "code": "bad_request"}
    op = request.get("op")
    if op == "create_signed_marker":
        if set(request) != {"op", "event", "permit"}:
            return {"ok": False, "code": "bad_request"}
        event, permit = request["event"], request["permit"]
        if type(event) is not dict or type(permit) is not dict:
            return {"ok": False, "code": "bad_request"}
        try:
            name = marker_name(event.get("event_id"))
        except (ValueError, UnicodeError):
            return {"ok": False, "code": "invalid_effect_identity"}
        if signed_policy is None:
            return {"ok": False, "code": "writer_authorization_denied"}
        try:
            accepted = signed_policy(event, permit) is True
        except Exception:
            accepted = False
        if not accepted:
            return {"ok": False, "code": "writer_authorization_denied"}
        return {"ok": True, "marker_name": name}
    if op == "create_empty_marker":
        if set(request) != {"op", "event_id"}:
            return {"ok": False, "code": "bad_request"}
        try:
            name = marker_name(request["event_id"])
        except (ValueError, UnicodeError):
            return {"ok": False, "code": "invalid_effect_identity"}
        if signed_policy is not None or fixture_authorize is None:
            return {"ok": False, "code": "writer_authorization_denied"}
        try:
            accepted = fixture_authorize(request["event_id"]) is True
        except Exception:
            accepted = False
        if not accepted:
            return {"ok": False, "code": "writer_authorization_denied"}
        return {"ok": True, "marker_name": name}
    return {"ok": False, "code": "unsupported_operation"}


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
        if type(request) is dict and request.get("op") == "create_signed_marker":
            if (set(request) != {"op", "event", "permit"}
                    or type(request["event"]) is not dict
                    or type(request["permit"]) is not dict):
                self._reply({"ok": False, "code": "bad_request"})
                return
            try:
                name = marker_name(request["event"].get("event_id"))
            except (ValueError, UnicodeError):
                self._reply({"ok": False, "code": "invalid_effect_identity"})
                return
            # The enactor, not this handler, must hold the trusted
            # cross-process fence during BOTH fresh authorization and effect.
            if self.server.signed_enactor is None:
                self._reply({"ok": False, "code": "writer_authorization_denied"})
                return
            self._reply(self.server.signed_enactor.enact(
                request["event"], request["permit"],
                lambda: self.server.write_marker(name)))
            return
        verdict = validate_writer_request(request,
            signed_policy=self.server.signed_enactor,
            fixture_authorize=self.server.authorize)
        if not verdict["ok"]:
            self._reply(verdict)
            return
        self._reply(self.server.write_marker(verdict["marker_name"]))

    def _reply(self, result):
        self.wfile.write((json.dumps(result, sort_keys=True) + "\n").encode())


class IsolatedMarkerWriter(socketserver.UnixStreamServer):
    """Synchronous one-request-per-connection writer for disposable tests."""

    def __init__(self, socket_path, marker_directory, *, broker_uid,
                 authorize=None, signed_enactor=None):
        if sys.platform != "linux" or not hasattr(socket, "SO_PEERCRED"):
            raise WriterConfigurationError("Linux SO_PEERCRED required")
        if type(broker_uid) is not int or broker_uid <= 0:
            raise WriterConfigurationError("non-root broker UID required")
        if os.geteuid() == 0:
            raise WriterConfigurationError("root writer identity forbidden")
        if os.geteuid() == broker_uid:
            raise WriterConfigurationError("writer and broker must use distinct UIDs")
        self.broker_uid = broker_uid
        if signed_enactor is not None and not callable(getattr(signed_enactor, "enact", None)):
            raise WriterConfigurationError("signed enactor required")
        if authorize is not None and signed_enactor is not None:
            raise WriterConfigurationError("cannot combine fixture and signed enactment")
        self.authorize = authorize if callable(authorize) else None
        self.signed_enactor = signed_enactor
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
