"""Fail-closed application-facing IPC constructor for bounded G3 research pilot.

This does not certify a production deployment. It prevents the historical
bare Store and same-UID wiring from being accidentally presented as the
signed, independently confined writer. Filesystem/socket provisioning,
trusted controllers, host integrity and real X3 rights remain external.
"""
import os
import stat
from pathlib import Path
from g3_monitor import Server
from g3_cross_process_fence import FencedSignedG3Writer


class SignedFencedServer(Server):
    def __init__(self, path, store, allowed_uids):
        if not isinstance(store, FencedSignedG3Writer):
            raise TypeError("signed and cross-process-fenced writer required")
        if (not isinstance(allowed_uids, (set, frozenset)) or
                not allowed_uids or
                any(type(uid) is not int or uid <= 0 or
                    uid == os.geteuid() for uid in allowed_uids)):
            raise ValueError("explicit non-root clients with UID separate from writer required")
        if not store.mesh.require_fresh_lease:
            raise ValueError("fresh controller lease required")
        # Fail closed before bind: group/other-writable parent directories
        # let guests replace the socket pathname and impersonate the server.
        p = Path(path)
        parent_fd = os.open(p.parent, os.O_RDONLY | os.O_DIRECTORY |
                            os.O_NOFOLLOW | os.O_CLOEXEC)
        try:
            parent = os.fstat(parent_fd)
            if (not stat.S_ISDIR(parent.st_mode) or
                    parent.st_uid != os.geteuid() or
                    parent.st_mode & 0o022):
                raise PermissionError(
                    "socket parent must be writer-owned and not guest-writable")
            try:
                os.stat(p.name, dir_fd=parent_fd, follow_symlinks=False)
            except FileNotFoundError:
                pass
            else:
                raise FileExistsError("socket path must not already exist")
        finally:
            os.close(parent_fd)
        # This is a local provisioning check, not a proof about ancestor
        # directories, root, mount namespaces or inherited write handles.
        super().__init__(path, store, allowed_uids)
