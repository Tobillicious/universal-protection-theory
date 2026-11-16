"""R5 fixed-client post-authentication kernel fence, non-deploying Linux test.

The old negative-control branch intentionally allows alternate connections.
The new fixed-client mode MUST deny new socket() AND connect() after one
valid connection exists, without preventing send/recv on that connection.
"""
import errno
import os
import platform
import subprocess
import sys
import unittest

from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE

PROBE = r"""
import errno, socket, sys
# Start one permitted communication channel in a disposable child.
a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_STREAM)
_deny_fd_receive_syscalls(deny_new_connections=True)
try:
    socket.socket(socket.AF_UNIX,socket.SOCK_STREAM)
except OSError as error:
    if error.errno != errno.EPERM:
        raise
else:
    raise AssertionError("new socket allowed after fixed-client confinement")
# On Linux connect() of an already-open socket must independently be denied.
# Construct a socket BEFORE the filter for the connect syscall probe.
a.sendall(b"ALIVE")
if b.recv(5)!=b"ALIVE":
    raise AssertionError("existing transport broken")
print("POST_CONNECT_SOCKET_DENIED",flush=True)
"""

CONNECT_PROBE = r"""
import errno, socket
s=socket.socket(socket.AF_UNIX,socket.SOCK_STREAM)
_deny_fd_receive_syscalls(deny_new_connections=True)
try:
    s.connect("/tmp/g3-fake-authority-never-created")
except OSError as error:
    if error.errno != errno.EPERM:
        raise AssertionError("connect did not return kernel EPERM") from error
else:
    raise AssertionError("connect allowed post confinement")
print("POST_CONNECT_CONNECT_DENIED",flush=True)
"""

ABSTRACT_CONNECT_PROBE = r"""
import errno, socket
# Create socket before confinement to exercise connect() itself.
s=socket.socket(socket.AF_UNIX,socket.SOCK_STREAM)
_deny_fd_receive_syscalls(deny_new_connections=True)
try:
    s.connect(b"\x00g3-r5-abstract-alternate")
except OSError as error:
    if error.errno != errno.EPERM:
        raise AssertionError("abstract AF_UNIX connect not kernel denied") from error
else:
    raise AssertionError("abstract AF_UNIX connect permitted post-confinement")
print("POST_CONNECT_ABSTRACT_DENIED",flush=True)
"""

@unittest.skipUnless(sys.platform=="linux" and
                     platform.machine().lower() in ("x86_64","aarch64","arm64"),
                     "Linux fixed-client seccomp research only")
class FixedAuthorityConnectionFenceTests(unittest.TestCase):
    def _probe(self, source, expected):
        p=subprocess.run(
            [sys.executable,"-B","-c",SECCOMP_CHILD_CODE+"\n"+source],
            cwd="/",env={"PATH":"/usr/local/bin:/usr/bin:/bin",
                         "PYTHONDONTWRITEBYTECODE":"1"},
            capture_output=True,text=True,timeout=12,check=False)
        self.assertEqual(p.returncode,0,p.stderr)
        self.assertEqual(p.stdout.strip(),expected)

    def test_socket_creation_denied_after_connected_handoff(self):
        self._probe(PROBE,"POST_CONNECT_SOCKET_DENIED")

    def test_connect_denied_even_on_preexisting_socket(self):
        self._probe(CONNECT_PROBE,"POST_CONNECT_CONNECT_DENIED")

    def test_abstract_unix_connect_denied_after_handoff(self):
        self._probe(ABSTRACT_CONNECT_PROBE,"POST_CONNECT_ABSTRACT_DENIED")

if __name__=="__main__":
    unittest.main()
