"""R5 research only: preconnected FD can survive a no-new-connect seccomp fence.

This intentionally violates the *existing* fixed launcher's zero-inherited-FD
contract and therefore must NEVER be wired into that launcher as-is.
No authentic authority identification, no marker write, no HOLD claim.
"""
import errno
import json
import platform
import socket
import subprocess
import sys
import unittest

CHILD = r"""
import ctypes, errno, json, platform, socket, sys
from ctypes import Structure, c_ushort, c_ubyte, c_uint
sock=socket.socket(fileno=int(sys.argv[1]))
class Filter(Structure):
    _fields_=[('code',c_ushort),('jt',c_ubyte),('jf',c_ubyte),('k',c_uint)]
class Program(Structure):
    _fields_=[('len',c_ushort),('filter',ctypes.POINTER(Filter))]
arch=platform.machine().lower()
if arch=='x86_64':
    audit, blocked=0xc000003e,(41,42,53)
elif arch in ('aarch64','arm64'):
    audit, blocked=0xc00000b7,(198,203,199)
else:
    raise RuntimeError('unsupported Linux ABI')
inst=[(0x20,0,0,4),(0x15,1,0,audit),(0x06,0,0,0x80000000),(0x20,0,0,0)]
if arch=='x86_64':
    inst += [(0x54,0,0,0x40000000),(0x15,1,0,0),
             (0x06,0,0,0x00050000|errno.EPERM),(0x20,0,0,0)]
for nr in blocked:
    inst += [(0x15,0,1,nr),(0x06,0,0,0x00050000|errno.EPERM)]
inst.append((0x06,0,0,0x7fff0000))
arr=(Filter*len(inst))(*[Filter(*item) for item in inst])
prog=Program(len(inst),arr)
libc=ctypes.CDLL(None,use_errno=True)
if libc.prctl(38,1,0,0,0): raise OSError(ctypes.get_errno(),'no_new_privs')
if libc.prctl(22,2,ctypes.byref(prog)): raise OSError(ctypes.get_errno(),'seccomp')
seen={}
try: socket.socket(socket.AF_UNIX,socket.SOCK_STREAM)
except OSError as exc: seen['socket']=exc.errno
try: socket.socketpair()
except OSError as exc: seen['socketpair']=exc.errno
try: sock.connect('/tmp/not-an-authority')
except OSError as exc: seen['connect']=exc.errno
seen['received']=sock.recv(4).decode('ascii')
sock.sendall(b'PONG')
sock.close()
print(json.dumps(seen),flush=True)
"""

@unittest.skipUnless(
    sys.platform == 'linux' and platform.machine().lower() in ('x86_64','aarch64','arm64'),
    'Linux x86_64/aarch64 research fixture only')
class PreconnectedR5Feasibility(unittest.TestCase):
    def test_new_connect_denied_existing_stream_survives(self):
        parent, child = socket.socketpair()
        try:
            proc = subprocess.Popen(
                [sys.executable, '-B', '-c', CHILD, str(child.fileno())],
                close_fds=True, pass_fds=(child.fileno(),),
                stdin=subprocess.DEVNULL,
                stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            child.close()
            parent.settimeout(5)
            parent.sendall(b'PING')
            self.assertEqual(parent.recv(4), b'PONG')
            output, error = proc.communicate(timeout=5)
            self.assertEqual(proc.returncode, 0, error)
            seen = json.loads(output)
            self.assertEqual(seen['received'], 'PING')
            for operation in ('socket','socketpair','connect'):
                self.assertEqual(seen[operation], errno.EPERM, seen)
        finally:
            parent.close()
            child.close()

if __name__ == '__main__':
    unittest.main()
