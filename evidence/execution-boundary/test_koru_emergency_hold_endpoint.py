"""Disposable Linux dual-socket HOLD regression, including ordinary ingress floods.

The two sockets live in the SAME unprivileged authority process and share
one SQLite journal. No real-world effect or external system is modified.
"""
import concurrent.futures
import json
import os
import select
import shutil
import socket
import subprocess
import sys
import time
import unittest

import test_koru_authority_owned_marker_service as base

DUAL_SERVER = r"""
import select,sys,threading
from koru_authority_owned_marker_service import AuthorityOwnedMarkerService
from koru_emergency_hold_endpoint import EmergencyHoldServer
primary,emergency,db,marker=sys.argv[1:]
authority=AuthorityOwnedMarkerService(
    primary,db,marker,executor_uid=65532,controller_uid=65530,
    expected={"generation":13,"event_id":"fixture","authority_ref":"ref"})
controller=EmergencyHoldServer(
    emergency,controller_uid=65530,journal=authority.journal)
threads=[
    threading.Thread(target=authority.serve_forever,
                     kwargs={"poll_interval":0.02},daemon=True),
    threading.Thread(target=controller.serve_forever,
                     kwargs={"poll_interval":0.02},daemon=True)
]
for t in threads:t.start()
print("READY",flush=True)
try:
    for line in sys.stdin:
        if line.strip()=="stop":
            break
finally:
    for server in (controller,authority):server.shutdown()
    for server in (controller,authority):server.server_close()
    for t in threads:t.join(timeout=3)
"""


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable Linux separate-UID fixture only")
class EmergencyHoldSocketTests(unittest.TestCase):
    def setUp(self):
        self.f = base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.f.setUp()
        self.f.stop()
        shutil.copyfile(
            os.path.join(os.path.dirname(base.__file__),
                         "koru_emergency_hold_endpoint.py"),
            self.f.lib / "koru_emergency_hold_endpoint.py")
        control_dir = self.f.sockdir / "emergency"
        control_dir.mkdir(mode=0o700)
        os.chown(control_dir, base.AUTH, base.CONTROLLER)
        control_dir.chmod(0o2710)
        self.emergency = str(control_dir / "emergency.sock")
        self.f.server = subprocess.Popen(
            [sys.executable,"-B","-c",DUAL_SERVER,
             self.f.sock,self.emergency,str(self.f.db),str(self.f.marker)],
            preexec_fn=base.drop(base.AUTH),cwd="/",env=self.f.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        ready,_,_=select.select([self.f.server.stdout],[],[],5)
        self.assertTrue(ready,"dual authority startup timed out")
        self.assertEqual(self.f.server.stdout.readline().strip(),"READY")
        self.clients=[]

    def tearDown(self):
        for s in self.clients:
            s.close()
        self.f.tearDown()

    def ask(self,uid,path,operation):
        p=subprocess.run(
            [sys.executable,"-B","-c",base.CLIENT,path,
             json.dumps({"op":operation})],
            preexec_fn=base.drop(uid),cwd="/",env=self.f.env,
            capture_output=True,text=True,timeout=5)
        self.assertEqual(p.returncode,0,p.stderr)
        return json.loads(p.stdout)

    def test_emergency_socket_never_executes_effect(self):
        denied=self.ask(base.CONTROLLER,self.emergency,"fixed_marker")
        self.assertEqual(denied["code"],"peer_or_operation_denied")
        self.assertFalse(list(self.f.marker.iterdir()))
        self.assertEqual(self.ask(base.CONTROLLER,self.emergency,"hold")["code"],
                         "hold_recorded")
        self.assertEqual(self.ask(base.EXECUTOR,self.f.sock,"fixed_marker")["code"],
                         "authority_denied")
        self.assertFalse(list(self.f.marker.iterdir()))

    def test_ordinary_executor_cannot_issue_emergency_hold(self):
        # The emergency handler checks SO_PEERCRED before parsing JSON.
        p=subprocess.run(
            [sys.executable,"-B","-c",base.CLIENT,self.emergency,
             json.dumps({"op":"hold"})],
            preexec_fn=base.drop(base.EXECUTOR),cwd="/",env=self.f.env,
            capture_output=True,text=True,timeout=5)
        self.assertNotEqual(p.returncode, 0)
        self.assertIn("PermissionError", p.stderr)
        self.assertFalse(base.TransactionalHoldWitness(str(self.f.db)).read()["held"])
        self.assertFalse(list(self.f.marker.iterdir()))

    def test_socket_acl_is_controller_group_only(self):
        import stat
        st = os.stat(self.emergency)
        self.assertEqual(st.st_gid, base.CONTROLLER)
        self.assertEqual(stat.S_IMODE(st.st_mode), 0o660)
        parent = os.stat(os.path.dirname(self.emergency))
        self.assertEqual(stat.S_IMODE(parent.st_mode), 0o2710)

    def test_ordinary_socket_burst_does_not_block_control_listener(self):
        # Burst attempts against the ordinary backlog while keeping some
        # incomplete connections open. This is not a host-global DoS proof.
        def stall(_):
            s=socket.socket(socket.AF_UNIX,socket.SOCK_STREAM)
            s.settimeout(.5)
            try:
                s.connect(self.f.sock)
                s.sendall(b'{"op":')
                return s
            except OSError:
                s.close()
                return None
        with concurrent.futures.ThreadPoolExecutor(max_workers=24) as pool:
            attempted=list(pool.map(stall,range(120)))
        self.clients.extend(s for s in attempted if s is not None)
        self.assertGreater(len(self.clients),0)
        start=time.monotonic()
        response=self.ask(base.CONTROLLER,self.emergency,"hold")
        elapsed=time.monotonic()-start
        self.assertEqual(response["code"],"hold_recorded")
        self.assertLess(elapsed,2.0)
        self.assertTrue(base.TransactionalHoldWitness(str(self.f.db)).read()["held"])
        self.assertFalse(list(self.f.marker.iterdir()))
        for s in self.clients:s.close()
        self.clients.clear()
        time.sleep(1.1)
        self.assertEqual(self.f.ask(base.EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")


if __name__=="__main__":
    unittest.main()
