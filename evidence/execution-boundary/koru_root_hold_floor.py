"""Root-owned local authorization floor for a *bounded Linux research fixture*.

A compromised controller UID cannot overwrite this root-owned floor. A trusted
root guardian advances it under the SAME cross-UID fence; the writer verifies
it every time within the fence, alongside the controller snapshot and signature.

This protects only against controller-UID/backup snapshot replay. Host-root,
root-floor rollback, fs tampering by privileged actors, and multi-host failures
remain outside this trust model. This is NOT a production root daemon, not a
consent source, and does not grant any permission.
"""
import json
import os
import stat

MAX_FLOOR_BYTES = 4096


def _validate_floor(value):
    if (type(value) is not dict or
            set(value) != {"generation", "held", "event_id", "authority_ref"} or
            type(value["generation"]) is not int or value["generation"] < 1 or
            type(value["held"]) is not bool or
            type(value["event_id"]) is not str or not value["event_id"] or
            type(value["authority_ref"]) is not str or not value["authority_ref"]):
        raise ValueError("invalid protected floor")
    return value


class RootOwnedHoldFloor:
    """Pre-provisioned root-owned directory 0755 and floor inode 0644.

    The trusted root operator provisions before dropping privileges. Neither
    controller nor writer may create/replace this file or parent directory.
    """

    def __init__(self, directory, *, filename="hold-floor.json"):
        if (type(directory) is not str or not os.path.isabs(directory) or
                os.path.normpath(directory) != directory or
                filename != "hold-floor.json"):
            raise ValueError("canonical floor directory required")
        self.directory = directory
        self._pid = os.getpid()
        self.dirfd = os.open(directory, os.O_PATH | os.O_DIRECTORY |
                             os.O_NOFOLLOW | os.O_CLOEXEC)
        try:
            info = os.fstat(self.dirfd)
            if (not stat.S_ISDIR(info.st_mode) or info.st_uid != 0 or
                    info.st_gid != 0 or stat.S_IMODE(info.st_mode) != 0o755):
                raise PermissionError("root floor directory untrusted")
        except BaseException:
            os.close(self.dirfd)
            raise

    def read(self):
        if os.getpid() != self._pid:
            raise RuntimeError("reopen floor after fork")
        fd = os.open("hold-floor.json", os.O_RDONLY | os.O_NOFOLLOW |
                     os.O_CLOEXEC, dir_fd=self.dirfd)
        try:
            info = os.fstat(fd)
            if (not stat.S_ISREG(info.st_mode) or info.st_nlink != 1 or
                    info.st_uid != 0 or info.st_gid != 0 or
                    stat.S_IMODE(info.st_mode) != 0o644 or
                    info.st_size > MAX_FLOOR_BYTES):
                raise PermissionError("root floor inode untrusted")
            raw = os.read(fd, MAX_FLOOR_BYTES + 1)
            if len(raw) > MAX_FLOOR_BYTES:
                raise ValueError("oversized root floor")
            return _validate_floor(json.loads(raw))
        finally:
            os.close(fd)

    def _hold_intent_present(self):
        """Treat ANY existing intent inode as a deny condition.

        Incomplete/corrupt intent must never be interpreted as permission.
        EACCES and other unexpected errors propagate to fail-closed caller.
        """
        try:
            os.stat("hold-intent", dir_fd=self.dirfd, follow_symlinks=False)
            return True
        except FileNotFoundError:
            return False

    def permits(self, event, controller_snapshot):
        """Called only while the shared effect fence is held by the enactor."""
        try:
            floor = self.read()
            current = controller_snapshot.read()
            return (type(event) is dict and not self._hold_intent_present() and
                    not floor["held"] and
                    current["halted"] is False and
                    floor["generation"] == current["generation"] ==
                    event.get("generation") and
                    floor["event_id"] == current["event_id"] ==
                    event.get("event_id") and
                    floor["authority_ref"] == current["authority_ref"] ==
                    event.get("authority_ref"))
        except (OSError, ValueError, TypeError, RuntimeError, KeyError):
            return False

    def hold_status(self, fence):
        """Read-only reconciliation status under the same effect fence.

        Never call an incomplete or inconsistent state acknowledged.
        """
        with fence:
            floor = self.read()
            intent = self._hold_intent_present()
            if intent and floor["held"]:
                return {"ok": True, "code": "hold_complete",
                        "generation": floor["generation"]}
            if intent:
                return {"ok": False, "code": "hold_pending_deny"}
            if floor["held"]:
                return {"ok": False, "code": "hold_inconsistent_deny"}
            return {"ok": False, "code": "hold_not_committed"}

    def _finish_held_floor(self, floor):
        """Must be called with a durable intent and the common fence held."""
        nxt = dict(floor, held=True, generation=floor["generation"] + 1)
        payload = json.dumps(nxt, sort_keys=True, separators=(",", ":")).encode()
        name = ".floor-" + os.urandom(16).hex()
        fd = None
        try:
            fd = os.open(name, os.O_WRONLY | os.O_CREAT | os.O_EXCL |
                         os.O_NOFOLLOW | os.O_CLOEXEC, 0o600,
                         dir_fd=self.dirfd)
            os.fchmod(fd, 0o644)
            view = memoryview(payload)
            while view:
                n = os.write(fd, view)
                if n <= 0:
                    raise OSError("zero-length floor write")
                view = view[n:]
            os.fsync(fd)
            os.close(fd)
            fd = None
            os.rename(name, "hold-floor.json",
                      src_dir_fd=self.dirfd, dst_dir_fd=self.dirfd)
            self._sync_directory()
        except BaseException:
            if fd is not None:
                os.close(fd)
            try:
                os.unlink(name, dir_fd=self.dirfd)
            except FileNotFoundError:
                pass
            raise
        return nxt["generation"]

    def _sync_existing_intent(self):
        """Root-owned existing intent, fully synchronized before recovery."""
        fd = os.open("hold-intent", os.O_RDONLY | os.O_NOFOLLOW |
                     os.O_CLOEXEC, dir_fd=self.dirfd)
        try:
            st = os.fstat(fd)
            if (not stat.S_ISREG(st.st_mode) or st.st_uid != 0 or
                    st.st_gid != 0 or st.st_nlink != 1 or
                    stat.S_IMODE(st.st_mode) != 0o644 or st.st_size > 128):
                raise PermissionError("untrusted HOLD intent")
            os.fsync(fd)
        finally:
            os.close(fd)
        self._sync_directory()

    def reconcile_hold(self, fence):
        """Trusted root restart repair, never clears intent or grants rights.

        If intent was created but the guardian died before floor replacement,
        synchronize it and complete the floor transition under the shared lock.
        """
        if os.geteuid() != 0:
            raise PermissionError("root guardian identity required")
        with fence:
            floor = self.read()
            if not self._hold_intent_present():
                raise RuntimeError("no HOLD intent: cannot invent withdrawal")
            self._sync_existing_intent()
            if floor["held"]:
                return {"ok": True, "code": "hold_already_complete",
                        "generation": floor["generation"]}
            generation = self._finish_held_floor(floor)
            return {"ok": True, "code": "hold_reconciled",
                    "generation": generation}

    def commit_hold(self, fence):
        """Root guardian: only ACK after intent and floor are durable.

        Intent presence causes immediate denial; an unfinished transition must
        be recovered with reconcile_hold, never treated as completed.
        """
        if os.geteuid() != 0:
            raise PermissionError("root guardian identity required")
        with fence:
            floor = self.read()
            if floor["held"]:
                if not self._hold_intent_present():
                    raise RuntimeError("inconsistent HOLD floor: no intent")
                self._sync_existing_intent()
                return {"ok": True, "code": "floor_already_held"}
            if self._hold_intent_present():
                raise RuntimeError("pending HOLD: use explicit reconciliation")
            intent_fd = os.open("hold-intent", os.O_WRONLY | os.O_CREAT |
                                os.O_EXCL | os.O_NOFOLLOW | os.O_CLOEXEC,
                                0o644, dir_fd=self.dirfd)
            try:
                os.fchmod(intent_fd, 0o644)
                intent = memoryview(b"hold-pending-v1\\n")
                while intent:
                    n = os.write(intent_fd, intent)
                    if n <= 0:
                        raise OSError("zero-length intent write")
                    intent = intent[n:]
                os.fsync(intent_fd)
            finally:
                os.close(intent_fd)
            self._sync_directory()
            generation = self._finish_held_floor(floor)
            return {"ok": True, "code": "floor_hold_committed",
                    "generation": generation}

    def _sync_directory(self):
        sync = os.open(self.directory, os.O_RDONLY | os.O_DIRECTORY |
                       os.O_NOFOLLOW | os.O_CLOEXEC)
        try:
            os.fsync(sync)
        finally:
            os.close(sync)

    def close(self):
        os.close(self.dirfd)
