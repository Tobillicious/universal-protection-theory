"""Bounded Linux Unix-socket worker mixin for G3 research brokers.

Both the public and controller broker must use this mixin to prevent an
unbounded Python thread per inbound connection. This is process-local load
shedding only, not network-wide DDoS protection or deployment isolation.
"""
import socketserver
import time
import threading


class BoundedThreadingMixIn(socketserver.ThreadingMixIn):
    daemon_threads = True
    block_on_close = False

    def configure_bounds(self, *, max_connections=16, request_timeout=2.0):
        if (type(max_connections) is not int or
                not 1 <= max_connections <= 128 or
                type(request_timeout) not in (int, float) or
                not 0.1 <= request_timeout <= 10.0):
            raise ValueError("invalid bounded-server configuration")
        self.max_connections = max_connections
        self.request_timeout = float(request_timeout)
        self._connection_slots = threading.BoundedSemaphore(max_connections)

    def process_request(self, request, client_address):
        # Acquire BEFORE creating a worker; an attacker cannot force an
        # unbounded number of stalled Python handler threads.
        if not self._connection_slots.acquire(blocking=False):
            self.shutdown_request(request)
            return
        try:
            super().process_request(request, client_address)
        except BaseException:
            self._connection_slots.release()
            raise

    def process_request_thread(self, request, client_address):
        try:
            super().process_request_thread(request, client_address)
        finally:
            self._connection_slots.release()


def read_framed_request(sock, *, max_bytes, total_timeout):
    """Read one newline-terminated envelope within an absolute deadline.

    A malicious client cannot extend this deadline by sending one byte per
    socket timeout. Fail closed for overlong, partial and multi-line input.
    The caller MUST send no effect on None and close the connection.
    """
    deadline = time.monotonic() + total_timeout
    body = bytearray()
    while len(body) <= max_bytes:
        remaining = deadline - time.monotonic()
        if remaining <= 0:
            return None
        sock.settimeout(remaining)
        try:
            block = sock.recv(min(4096, max_bytes + 1 - len(body)))
        except (TimeoutError, OSError):
            return None
        if not block:
            return None
        body.extend(block)
        if b"\n" in block:
            if (len(body) > max_bytes or not body.endswith(b"\n") or
                    body.count(b"\n") != 1):
                return None
            return bytes(body)
    return None
