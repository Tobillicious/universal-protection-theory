"""Reserved controller capacity for one authority-owned G3 Unix socket.

Classify a connection by Linux SO_PEERCRED *before* allocating a handler.
Untrusted/executor peers cannot consume the controller's reserved slots.
All slots have the same absolute request deadline in the handler.

Research fixture only: an attacker with the controller UID, overloaded host
CPU, shared DB lock, kernel accept backlog, or privileged compromise can still
delay HOLD. This is not an end-to-end liveness guarantee.
"""
import socket
import socketserver
import struct
import threading


class ReservedAuthorityThreadingMixIn(socketserver.ThreadingMixIn):
    daemon_threads = True
    block_on_close = False
    request_queue_size = 16

    def configure_authority_bounds(self, *, executor_slots=8,
                                   controller_slots=2, request_timeout=1.0):
        if (type(executor_slots) is not int or
                not 1 <= executor_slots <= 64 or
                type(controller_slots) is not int or
                not 1 <= controller_slots <= 16 or
                type(request_timeout) not in (int, float) or
                not 0.1 <= request_timeout <= 10.0):
            raise ValueError("invalid authority worker bounds")
        self.request_timeout = float(request_timeout)
        self._executor_slots = threading.BoundedSemaphore(executor_slots)
        self._controller_slots = threading.BoundedSemaphore(controller_slots)

    def process_request(self, request, client_address):
        # Only kernel-provided credentials grant access to reserved slots.
        try:
            peer = request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _pid, uid, _gid = struct.unpack("3i", peer)
        except (OSError, struct.error):
            self.shutdown_request(request)
            return
        slot = (self._controller_slots if uid == self.controller_uid else
                self._executor_slots)
        if not slot.acquire(blocking=False):
            self.shutdown_request(request)
            return
        try:
            worker = threading.Thread(
                target=self._reserved_worker,
                args=(request, client_address, slot), daemon=True)
            worker.start()
        except BaseException:
            slot.release()
            self.shutdown_request(request)
            raise

    def _reserved_worker(self, request, client_address, slot):
        try:
            self.process_request_thread(request, client_address)
        finally:
            slot.release()
