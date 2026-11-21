"""Root-owned AF_UNIX listener pathname integrity for isolated G3 research.

A pinned listener socket inode is checked against its pathname immediately
before serving a HOLD receipt. A replacement, removal, symlink, or directory
substitution is rejected. This does NOT authenticate the caller, key custody,
or prove that privileged root cannot modify the host.
"""
import os
import stat


class PinnedSocketEndpoint:
    def __init__(self, path, *, owner_uid=0, owner_gid=0,
                 socket_mode=0o660, directory_mode=0o755):
        if (type(path) is not str or not os.path.isabs(path) or
                os.path.normpath(path) != path or
                type(owner_uid) is not int or owner_uid < 0 or
                type(owner_gid) is not int or owner_gid < 0 or
                type(socket_mode) is not int or
                type(directory_mode) is not int):
            raise ValueError("invalid endpoint provenance policy")
        self.path = path
        self.owner = (owner_uid, owner_gid)
        self.socket_mode = socket_mode
        self.directory_mode = directory_mode
        parent = os.path.dirname(path)
        self.dirfd = os.open(parent, os.O_PATH | os.O_DIRECTORY |
                            os.O_NOFOLLOW | os.O_CLOEXEC)
        try:
            self.dir_identity = self._check_directory()
            self.socket_identity = self._check_socket()
        except BaseException:
            os.close(self.dirfd)
            raise

    def _check_directory(self):
        fd_stat = os.fstat(self.dirfd)
        path_stat = os.stat(os.path.dirname(self.path),
                            follow_symlinks=False)
        for item in (fd_stat, path_stat):
            if (not stat.S_ISDIR(item.st_mode) or
                    (item.st_uid, item.st_gid) != self.owner or
                    stat.S_IMODE(item.st_mode) != self.directory_mode):
                raise PermissionError("untrusted socket parent")
        if (fd_stat.st_dev, fd_stat.st_ino) != (path_stat.st_dev, path_stat.st_ino):
            raise PermissionError("socket parent replaced")
        return fd_stat.st_dev, fd_stat.st_ino

    def _check_socket(self):
        item = os.stat(os.path.basename(self.path), dir_fd=self.dirfd,
                       follow_symlinks=False)
        if (not stat.S_ISSOCK(item.st_mode) or item.st_nlink != 1 or
                (item.st_uid, item.st_gid) != self.owner or
                stat.S_IMODE(item.st_mode) != self.socket_mode):
            raise PermissionError("untrusted socket endpoint")
        return item.st_dev, item.st_ino

    def verify(self):
        if self.dirfd is None:
            raise RuntimeError("endpoint pin is closed")
        if self._check_directory() != self.dir_identity:
            raise PermissionError("socket parent identity changed")
        if self._check_socket() != self.socket_identity:
            raise PermissionError("socket inode replaced")

    def close(self):
        if self.dirfd is not None:
            os.close(self.dirfd)
            self.dirfd = None
