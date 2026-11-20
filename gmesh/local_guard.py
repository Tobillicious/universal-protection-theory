"""Opt-in, local-only file-action gate for a restricted AI worker.

An agent must receive this object rather than unrestricted filesystem APIs.
This is NOT a process/kernel sandbox; an agent with direct OS access can bypass it.
Use an OS sandbox or dedicated UID to constrain such an agent.
"""
import json
import os
import stat
import threading
import time
from pathlib import Path


class Denied(PermissionError):
    pass


class LocalFileGate:
    def __init__(self, root, audit_file):
        self.root = Path(root).resolve(strict=True)
        if not self.root.is_dir():
            raise ValueError("root must be an existing directory")
        self.audit_file = Path(audit_file).resolve()
        if self.audit_file == self.root or self.root in self.audit_file.parents:
            raise ValueError("audit must be outside the protected directory")
        self._root_fd = os.open(self.root, os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW)
        self._allowed = set()
        self._locked = False
        self._lock = threading.RLock()
        self._audit_fd = os.open(self.audit_file, os.O_WRONLY | os.O_CREAT | os.O_APPEND | os.O_NOFOLLOW, 0o600)

    def close(self):
        with self._lock:
            for name in ("_root_fd", "_audit_fd"):
                fd = getattr(self, name, None)
                if fd is not None:
                    os.close(fd)
                    setattr(self, name, None)

    def __enter__(self):
        return self

    def __exit__(self, *_):
        self.close()

    @staticmethod
    def _valid_name(name):
        return (isinstance(name, str) and name not in ("", ".", "..")
                and "/" not in name and "\\" not in name and "\x00" not in name)

    def _record(self, operation, name, result):
        # The append-only mode is a convenience, NOT tamper-proof WORM storage.
        data = json.dumps({"ts_ns": time.time_ns(), "operation": operation,
                           "name": name if isinstance(name, str) else None,
                           "result": result}, sort_keys=True).encode() + b"\n"
        os.write(self._audit_fd, data)
        os.fsync(self._audit_fd)

    def allow(self, operation, name):
        if operation not in ("read", "create") or not self._valid_name(name):
            raise ValueError("invalid scoped permission")
        with self._lock:
            if self._locked:
                raise Denied("gate is held")
            self._allowed.add((operation, name))
            self._record("grant:" + operation, name, "ALLOWED")

    def revoke(self, operation, name):
        with self._lock:
            self._allowed.discard((operation, name))
            self._record("revoke:" + str(operation), name, "REVOKED")

    def hold(self):
        with self._lock:
            self._locked = True
            self._allowed.clear()
            self._record("hold", None, "HELD")

    def _check(self, operation, name):
        if not self._valid_name(name) or self._locked or (operation, name) not in self._allowed:
            self._record(operation, name, "DENIED")
            raise Denied("operation not authorized")

    def read(self, name, maximum=1024 * 1024):
        with self._lock:
            self._check("read", name)
            if not isinstance(maximum, int) or maximum < 0 or maximum > 1024 * 1024:
                raise ValueError("maximum must be 0..1048576")
            try:
                fd = os.open(name, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK,
                             dir_fd=self._root_fd)
                try:
                    if not stat.S_ISREG(os.fstat(fd).st_mode):
                        raise Denied("not a regular file")
                    data = os.read(fd, maximum + 1)
                    if len(data) > maximum:
                        raise Denied("file exceeds read limit")
                    self._record("read", name, "ALLOWED")
                    return data
                finally:
                    os.close(fd)
            except (OSError, Denied):
                self._record("read", name, "DENIED_OR_FAILED")
                raise

    def create(self, name, data):
        with self._lock:
            self._check("create", name)
            if not isinstance(data, bytes) or len(data) > 1024 * 1024:
                raise ValueError("data must be bytes <= 1 MiB")
            try:
                # Exclusive create prevents overwriting files or following symlinks.
                fd = os.open(name, os.O_WRONLY | os.O_CREAT | os.O_EXCL | os.O_NOFOLLOW,
                             0o600, dir_fd=self._root_fd)
                try:
                    with os.fdopen(fd, "wb", closefd=False) as file:
                        file.write(data)
                        file.flush()
                        os.fsync(fd)
                finally:
                    os.close(fd)
                os.fsync(self._root_fd)
                self._record("create", name, "ALLOWED")
            except OSError:
                self._record("create", name, "DENIED_OR_FAILED")
                raise
