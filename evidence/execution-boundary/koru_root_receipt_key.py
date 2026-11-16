"""Strict root-owned Ed25519 HOLD receipt key loader, Linux research only.

Read preprovisioned raw 32-byte Ed25519 seed from a pinned, private, root-owned
directory. Never generate keys here, write key material, expose it to a broker,
or replace effect-time HOLD authorization with signature verification.
"""
import os
import stat

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey


def load_root_receipt_key(path):
    """Fail closed on untrusted path, ownership, inode, mode, or key length.

    This protects against non-root DAC attackers in the tested Linux fixture.
    It does not protect against host root, memory exfiltration, backups,
    tracing, storage rollback, or a malicious guardian process.
    """
    if os.name != "posix" or not hasattr(os, "O_NOFOLLOW"):
        raise PermissionError("Linux-style O_NOFOLLOW required")
    if os.geteuid() != 0:
        raise PermissionError("trusted root issuer required")
    if (type(path) is not str or not os.path.isabs(path) or
            os.path.normpath(path) != path or
            os.path.basename(path) in ("", ".", "..")):
        raise ValueError("absolute canonical key path required")
    parent, leaf = os.path.split(path)
    dfd = os.open(parent, os.O_RDONLY | os.O_DIRECTORY |
                  os.O_NOFOLLOW | os.O_CLOEXEC)
    try:
        ds = os.fstat(dfd)
        live = os.stat(parent, follow_symlinks=False)
        for item in (ds, live):
            if (not stat.S_ISDIR(item.st_mode) or
                    item.st_uid != 0 or item.st_gid != 0 or
                    stat.S_IMODE(item.st_mode) != 0o700):
                raise PermissionError("key directory is not private root-owned")
        if (ds.st_dev, ds.st_ino) != (live.st_dev, live.st_ino):
            raise PermissionError("key directory replaced")
        fd = os.open(leaf, os.O_RDONLY | os.O_NOFOLLOW |
                     os.O_NONBLOCK | os.O_CLOEXEC, dir_fd=dfd)
        try:
            fs = os.fstat(fd)
            ps = os.stat(leaf, dir_fd=dfd, follow_symlinks=False)
            for item in (fs, ps):
                if (not stat.S_ISREG(item.st_mode) or item.st_nlink != 1 or
                        item.st_uid != 0 or item.st_gid != 0 or
                        stat.S_IMODE(item.st_mode) != 0o600 or
                        item.st_size != 32):
                    raise PermissionError("invalid private key inode")
            if (fs.st_dev, fs.st_ino) != (ps.st_dev, ps.st_ino):
                raise PermissionError("private key pathname replaced")
            raw = os.read(fd, 33)
            if len(raw) != 32 or os.read(fd, 1):
                raise PermissionError("invalid private key size")
            if (os.fstat(fd).st_dev, os.fstat(fd).st_ino) != (fs.st_dev, fs.st_ino):
                raise PermissionError("key fd changed")
            return Ed25519PrivateKey.from_private_bytes(raw)
        finally:
            os.close(fd)
    finally:
        os.close(dfd)
