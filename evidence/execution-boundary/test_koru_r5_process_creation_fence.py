"""G3 R5 process/exec denial inside the fixed one-request executor seccomp.

Disposable Linux subprocesses only. All tested post-filter process transitions
must fail with kernel EPERM. The existing authority/HOLD suite separately
checks ordinary fixed request and emergency HOLD behavior.
"""
import platform
import subprocess
import sys
import unittest

from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE

PROBE = r"""
import ctypes, errno, os, sys
_deny_fd_receive_syscalls()
operation=sys.argv[1]
if operation == "fork":
    try:
        pid=os.fork()
    except OSError as err:
        if err.errno != errno.EPERM:
            raise
    else:
        if pid == 0:
            os._exit(3)
        os.waitpid(pid, 0)
        raise AssertionError("fork unexpectedly succeeded")
elif operation == "execve":
    try:
        os.execve("/bin/true", ["/bin/true"], {})
    except OSError as err:
        if err.errno != errno.EPERM:
            raise
    else:
        raise AssertionError("execve unexpectedly returned")
elif operation == "clone3":
    libc=ctypes.CDLL(None, use_errno=True)
    result=libc.syscall(ctypes.c_long(435), ctypes.c_void_p(0),
                        ctypes.c_size_t(0))
    if result != -1 or ctypes.get_errno() != errno.EPERM:
        raise AssertionError("clone3 not denied: "+str(ctypes.get_errno()))
else:
    raise ValueError("unknown test")
print("PROCESS_DENIED", flush=True)
"""

@unittest.skipUnless(sys.platform == "linux" and
                     platform.machine().lower() in ("x86_64", "aarch64", "arm64"),
                     "Linux x86_64/ARM64 seccomp research only")
class R5ProcessFenceTests(unittest.TestCase):
    def probe(self, operation):
        out = subprocess.run([sys.executable, "-B", "-c",
                              SECCOMP_CHILD_CODE + "\n" + PROBE, operation],
                             text=True, capture_output=True, cwd="/",
                             timeout=6, check=False,
                             env={"PATH": "/usr/bin:/bin",
                                  "PYTHONDONTWRITEBYTECODE": "1"})
        self.assertEqual(out.returncode, 0, out.stderr)
        self.assertEqual(out.stdout.strip(), "PROCESS_DENIED")

    def test_fork_denied_in_fixed_child(self):
        self.probe("fork")

    def test_execve_denied_in_fixed_child(self):
        self.probe("execve")

    def test_clone3_denied_in_fixed_child(self):
        self.probe("clone3")

if __name__ == "__main__":
    unittest.main()
