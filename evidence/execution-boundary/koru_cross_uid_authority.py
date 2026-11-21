"""Controller-owned, writer-read-only authorization snapshot for G3 research.

Must be used with ProvisionedCrossUidFence by BOTH roles. This module does
not prove authentic consent or provide production revocation/rollback security.
Controller is trusted and may update its own state. Writer NEVER writes state.
"""
import json
import os
import stat
from pathlib import Path

MAX_BYTES = 4096


def _checked_dir(path, controller_uid, shared_gid):
    if (not isinstance(path, str) or not os.path.isabs(path) or
            os.path.normpath(path) != path or
            type(controller_uid) is not int or controller_uid <= 0 or
            type(shared_gid) is not int or shared_gid <= 0):
        raise ValueError("canonical path and distinct non-root control identity required")
    fd = os.open(path, os.O_PATH | os.O_DIRECTORY | os.O_NOFOLLOW | os.O_CLOEXEC)
    try:
        st = os.fstat(fd)
        if (not stat.S_ISDIR(st.st_mode) or st.st_uid != controller_uid or
                st.st_gid != shared_gid or stat.S_IMODE(st.st_mode) != 0o710):
            raise PermissionError("authorization directory ownership/mode mismatch")
    except BaseException:
        os.close(fd)
        raise
    return fd


def _validate(data):
    if (type(data) is not dict or set(data) !=
            {"generation", "halted", "event_id", "authority_ref"} or
            type(data["generation"]) is not int or data["generation"] < 1 or
            type(data["halted"]) is not bool or
            type(data["event_id"]) is not str or not data["event_id"] or
            type(data["authority_ref"]) is not str or not data["authority_ref"]):
        raise ValueError("invalid trusted authorization snapshot")
    return data


class ControllerOwnedSnapshot:
    def __init__(self, directory, *, controller_uid, shared_gid, filename="authority.json"):
        if filename != "authority.json":
            raise ValueError("fixed trusted snapshot filename required")
        self.directory = directory
        self.controller_uid = controller_uid
        self.shared_gid = shared_gid
        self.dirfd = _checked_dir(directory, controller_uid, shared_gid)
        self._pid = os.getpid()

    def read(self):
        """Caller MUST hold the common cross-UID fence until effect commits."""
        if os.getpid() != self._pid:
            raise RuntimeError("snapshot must be reopened after fork")
        fd = os.open("authority.json", os.O_RDONLY | os.O_NOFOLLOW | os.O_CLOEXEC,
                     dir_fd=self.dirfd)
        try:
            st = os.fstat(fd)
            if (not stat.S_ISREG(st.st_mode) or st.st_nlink != 1 or
                    st.st_uid != self.controller_uid or
                    st.st_gid != self.shared_gid or
                    stat.S_IMODE(st.st_mode) != 0o640 or st.st_size > MAX_BYTES):
                raise PermissionError("authorization snapshot inode untrusted")
            with os.fdopen(fd, "rb", closefd=False) as stream:
                raw = stream.read(MAX_BYTES + 1)
            if len(raw) > MAX_BYTES:
                raise ValueError("oversized authorization snapshot")
            return _validate(json.loads(raw))
        finally:
            os.close(fd)

    def permits(self, event):
        try:
            s = self.read()
            return (type(event) is dict and
                    event.get("event_id") == s["event_id"] and
                    event.get("authority_ref") == s["authority_ref"] and
                    event.get("generation") == s["generation"] and
                    s["halted"] is False)
        except (OSError, ValueError, TypeError, KeyError, RuntimeError):
            return False

    def hold(self, fence):
        """Trusted controller-only transition, durable before releasing fence.

        Initialization is deliberate external provisioning; never initialize
        missing or damaged state as permissive during a restart.
        """
        if os.geteuid() != self.controller_uid:
            raise PermissionError("only controller UID can place HOLD")
        with fence:
            state = self.read()
            if state["halted"]:
                return {"ok": True, "code": "already_held"}
            next_state = dict(state, halted=True, generation=state["generation"] + 1)
            blob = json.dumps(next_state, sort_keys=True, separators=(",", ":")).encode()
            fd = None
            name = None
            try:
                # Random temp in controller-owned directory; writer group has
                # traversal only and cannot replace it.
                name = ".authority-" + os.urandom(16).hex()
                fd = os.open(name, os.O_WRONLY | os.O_CREAT | os.O_EXCL |
                             os.O_NOFOLLOW | os.O_CLOEXEC, 0o600, dir_fd=self.dirfd)
                os.fchown(fd, self.controller_uid, self.shared_gid)
                os.fchmod(fd, 0o640)
                os.write(fd, blob)
                os.fsync(fd)
                os.close(fd)
                fd = None
                os.rename(name, "authority.json", src_dir_fd=self.dirfd,
                          dst_dir_fd=self.dirfd)
                syncfd = os.open(self.directory, os.O_RDONLY | os.O_DIRECTORY |
                                 os.O_NOFOLLOW | os.O_CLOEXEC)
                try:
                    os.fsync(syncfd)
                finally:
                    os.close(syncfd)
            except BaseException:
                if fd is not None:
                    os.close(fd)
                if name:
                    try: os.unlink(name, dir_fd=self.dirfd)
                    except FileNotFoundError: pass
                raise
            return {"ok": True, "code": "hold_recorded", "generation": next_state["generation"]}

    def close(self):
        os.close(self.dirfd)
