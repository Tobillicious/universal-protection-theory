"""Read-only, separate-process observation of the bounded G3 fixed.marker fixture.

Not independently administered: process and authority are under one disposable
CI host administrator. No physical subject/consent assertions or effect grants.
"""
import argparse
import json
import os
from pathlib import Path
import stat


def observe(directory, *, expected_uid):
    if (not isinstance(directory, (str, Path))
            or not Path(directory).is_absolute()
            or type(expected_uid) is not int or expected_uid < 0):
        raise ValueError("absolute marker directory and pinned UID required")
    flags = os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW | os.O_CLOEXEC
    fd = os.open(directory, flags)
    try:
        names = os.listdir(fd)
        if names == []:
            return {"exists": False}
        if names != ["fixed.marker"]:
            raise ValueError("unexpected marker-directory contents")
        info = os.stat("fixed.marker", dir_fd=fd, follow_symlinks=False)
        if (not stat.S_ISREG(info.st_mode) or info.st_uid != expected_uid
                or info.st_size != 0 or info.st_nlink != 1):
            raise ValueError("marker identity or inode properties invalid")
        return {"exists": True, "device": info.st_dev, "inode": info.st_ino,
                "uid": info.st_uid, "size": info.st_size, "nlink": info.st_nlink}
    finally:
        os.close(fd)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--marker-dir", required=True)
    parser.add_argument("--expected-uid", required=True, type=int)
    args = parser.parse_args()
    result = observe(args.marker_dir, expected_uid=args.expected_uid)
    print(json.dumps({"observer_pid": os.getpid(), "observation": result},
                     sort_keys=True))


if __name__ == "__main__":
    main()
