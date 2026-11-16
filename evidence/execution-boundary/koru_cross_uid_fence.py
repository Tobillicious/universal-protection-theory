"""Root-provisioned common-inode flock for cooperating distinct-UID G3 workers.

Research boundary only. The lock is advisory: it does not grant authority,
authenticate the controller or make a live revocation snapshot accessible to
the writer. Both roles must still use a verified durable state protocol.
The lock inode and its parent are owned by trusted root, not either principal.
"""
import fcntl
import os
import stat
import threading


class ProvisionedCrossUidFence:
    """Pre-existing root-owned lock inode, shared via a dedicated lock-only GID.

    Required: parent dir root:GID mode 0710 (traversal only);
    file root:GID mode 0660, single regular inode, no symlinks.
    The group is exclusively for trusted cooperating writer/controller roles.
    It MUST NOT include untrusted brokers. Caller supplies expected GID.
    """

    def __init__(self, path, *, shared_gid):
        if (type(path) is not str or not os.path.isabs(path) or
                type(shared_gid) is not int or shared_gid <= 0):
            raise ValueError("absolute lock path and positive shared GID required")
        if os.path.normpath(path) != path:
            raise ValueError("noncanonical lock path forbidden")
        self.path = path
        self.gid = shared_gid
        self._pid = os.getpid()
        self._mutex = threading.RLock()
        self._depth = 0
        self._closed = False
        self._fd = None
        parent = os.path.dirname(path)
        dirfd = os.open(parent, os.O_PATH | os.O_DIRECTORY |
                        os.O_NOFOLLOW | os.O_CLOEXEC)
        try:
            ds = os.fstat(dirfd)
            if (not stat.S_ISDIR(ds.st_mode) or ds.st_uid != 0 or
                    ds.st_gid != shared_gid or stat.S_IMODE(ds.st_mode) != 0o710):
                raise PermissionError("untrusted shared fence directory")
            fd = os.open(os.path.basename(path),
                         os.O_RDWR | os.O_NOFOLLOW | os.O_CLOEXEC, dir_fd=dirfd)
            try:
                self._check_inode(fd)
            except BaseException:
                os.close(fd)
                raise
            self._fd = fd
        finally:
            os.close(dirfd)

    def _check_inode(self, fd):
        opened = os.fstat(fd)
        path_stat = os.stat(self.path, follow_symlinks=False)
        if (not stat.S_ISREG(opened.st_mode) or opened.st_nlink != 1 or
                opened.st_uid != 0 or opened.st_gid != self.gid or
                stat.S_IMODE(opened.st_mode) != 0o660 or
                (opened.st_dev, opened.st_ino) !=
                (path_stat.st_dev, path_stat.st_ino) or
                not stat.S_ISREG(path_stat.st_mode) or path_stat.st_nlink != 1 or
                path_stat.st_uid != 0 or path_stat.st_gid != self.gid or
                stat.S_IMODE(path_stat.st_mode) != 0o660):
            raise PermissionError("shared fence inode binding lost")

    def __enter__(self):
        self._mutex.acquire()
        try:
            if self._closed or os.getpid() != self._pid:
                raise RuntimeError("closed or inherited fence is forbidden")
            if self._depth == 0:
                # Reject replacement before acquiring and again AFTER
                # acquiring the lock to prevent waiting on a stale inode.
                self._check_inode(self._fd)
                fcntl.flock(self._fd, fcntl.LOCK_EX)
                try:
                    self._check_inode(self._fd)
                except BaseException:
                    fcntl.flock(self._fd, fcntl.LOCK_UN)
                    raise
            self._depth += 1
            return self
        except BaseException:
            self._mutex.release()
            raise

    def __exit__(self, *_):
        try:
            self._depth -= 1
            if self._depth == 0:
                fcntl.flock(self._fd, fcntl.LOCK_UN)
        finally:
            self._mutex.release()

    def acquire(self):
        return self.__enter__()

    def release(self):
        return self.__exit__()

    def close(self):
        with self._mutex:
            if self._depth:
                raise RuntimeError("cannot close held fence")
            if not self._closed:
                self._closed = True
                os.close(self._fd)
