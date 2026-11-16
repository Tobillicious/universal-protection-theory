"""Dedicated emergency HOLD listener for the disposable G3 authority fixture.

Shares the primary authority journal and thus the SAME SQLite authority,
rather than creating an independent, conflicting HOLD truth. A separate
Unix socket/accept backlog prevents ordinary-socket clients from consuming
the emergency listener's queue. The emergency listener *never* runs effects.

Research limitations: the emergency socket is mode 0666 in this fixture and
kernel peer-credential authentication occurs only after accept. A hostile
process can still overload its own backlog; deployers need a protected socket
directory/ACL and independently reserved OS resources. Shared authority
process, CPU, SQLite locks, disk and root are not isolated.
"""
import json
import os
import socket
import socketserver
import struct

from koru_bounded_server import read_framed_request
from koru_authority_reserved_workers import ReservedAuthorityThreadingMixIn

_MAX_EMERGENCY_REQUEST = 512


class _EmergencyHandler(socketserver.BaseRequestHandler):
    def handle(self):
        try:
            raw = self.request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _pid, uid, _gid = struct.unpack("3i", raw)
            if uid != self.server.controller_uid:
                return
            data = read_framed_request(
                self.request, max_bytes=_MAX_EMERGENCY_REQUEST,
                total_timeout=self.server.request_timeout)
            if data is None:
                return self.reply({"ok": False, "code": "bad_request"})
            request = json.loads(data)
            if request != {"op": "hold"}:
                return self.reply({"ok": False, "code": "peer_or_operation_denied"})
            result = self.server.journal.hold()
            return self.reply({"ok": result["held"] is True,
                               "code": "hold_recorded"})
        except Exception:
            try:
                self.reply({"ok": False,
                            "code": "authority_unavailable_or_uncertain"})
            except OSError:
                pass

    def reply(self, value):
        self.request.sendall(
            (json.dumps(value, sort_keys=True) + "\n").encode())


class EmergencyHoldServer(ReservedAuthorityThreadingMixIn,
                          socketserver.UnixStreamServer):
    """One controller-only endpoint, sharing the primary authority journal."""

    def __init__(self, socket_path, *, controller_uid, journal,
                 controller_slots=2, request_timeout=1.0):
        if (type(controller_uid) is not int or controller_uid <= 0 or
                journal is None or
                not callable(getattr(journal, "hold", None))):
            raise ValueError("trusted controller and shared HOLD journal required")
        self.controller_uid = controller_uid
        self.journal = journal
        # Unauthorized peers get only a single bounded ordinary worker.
        self.configure_authority_bounds(
            executor_slots=1, controller_slots=controller_slots,
            request_timeout=request_timeout)
        super().__init__(socket_path, _EmergencyHandler)
        try:
            # Fixture-only. Real deployment needs a protected ingress ACL
            # that does not let arbitrary users fill the control backlog.
            os.chmod(socket_path, 0o666)
        except BaseException:
            self.server_close()
            raise
