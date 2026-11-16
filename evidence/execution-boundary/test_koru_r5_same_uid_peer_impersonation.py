"""R5 negative control: same-UID nonauthority Unix peer impersonation.

A disposable socket server runs as the expected authority UID, but is not the
real G3 authority and has no HOLD journal or marker. The fixed client now requires a separately provisioned expected authority PID
as well as UID. With a genuine authority PID, the fake peer must be rejected
before sending any protected-effect request. This is NOT proof of secure PID
provisioning, PID-reuse resistance, destination confinement or real effects. Run only in privileged
disposable Linux CI.
"""
import json
import os
from pathlib import Path
import select
import subprocess
import sys
import tempfile
import unittest

from koru_no_inherited_fd_executor import launch_fixed_executor_client
from test_koru_authority_owned_marker_service import AUTH, EXECUTOR, drop

FAKE_SERVER = r"""
import json, socket, sys
path=sys.argv[1]
with socket.socket(socket.AF_UNIX,socket.SOCK_STREAM) as srv:
    srv.bind(path)
    # Mirror the real authority service's cross-UID socket DAC mode:
    # without this the test fails before it exercises peer credentials.
    import os
    os.chmod(path, 0o666)
    srv.listen(1)
    srv.settimeout(6)
    print("READY",flush=True)
    conn,_=srv.accept()
    with conn:
        conn.settimeout(4)
        request=b""
        while not request.endswith(b"\n"):
            part=conn.recv(1024)
            if not part or len(request)+len(part)>2048:
                raise ValueError("invalid request")
            request+=part
        if json.loads(request)!= {"op":"fixed_marker"}:
            raise ValueError("unexpected client operation")
        conn.sendall(b'{"code":"synthetic_effect_returned","ok":true}\n')
"""

@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "privileged disposable Linux fixture only")
class SameUidPeerImpersonationNegativeControl(unittest.TestCase):
    def test_expected_uid_does_not_bind_peer_to_real_authority(self):
        with tempfile.TemporaryDirectory(prefix="g3-r5-fake-peer-") as temp:
            root=Path(temp)
            root.chmod(0o755)
            sockdir=root/"sock"
            sockdir.mkdir(mode=0o700)
            os.chown(sockdir, AUTH, AUTH)
            sockdir.chmod(0o711)
            sock=str(sockdir/"not-authority.sock")
            server=subprocess.Popen(
                [sys.executable,"-B","-c",FAKE_SERVER,sock],
                preexec_fn=drop(AUTH),close_fds=True,pass_fds=(),
                cwd="/",stdin=subprocess.DEVNULL,
                stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,
                env={"PATH":"/usr/local/bin:/usr/bin:/bin",
                     "PYTHONDONTWRITEBYTECODE":"1"})
            try:
                ready,_,_=select.select([server.stdout],[],[],6)
                self.assertTrue(ready,"fake server did not start")
                self.assertEqual(server.stdout.readline().strip(),"READY")
                # The trusted caller supplies a PID distinct from the fake
                # service PID. In deployment this PID must be independently
                # bound to the genuine authority process, not client input.
                self.assertNotEqual(server.pid, os.getpid())
                response=launch_fixed_executor_client(
                    sock,executor_uid=EXECUTOR,authority_uid=AUTH,
                    authority_pid=os.getpid())
                self.assertEqual(response,{"ok":False,
                                          "code":"authority_unavailable_or_uncertain"})
                # Fake server cannot receive the fixed effect request from
                # this rejected client, even though its UID matches.
                self.assertNotEqual(server.wait(timeout=6),0)
            finally:
                if server.poll() is None:
                    server.kill()
                    server.communicate(timeout=3)

if __name__=="__main__":
    unittest.main()
