"""Disposable Linux: kernel DAC eliminates executor-owned effect bypass.

Only authority UID owns the fixed marker. Executor and requester UIDs have no
write-capable directory or open descriptor. Authority HOLD and effect are
serialized by its existing DB transaction; neither trusts an advisory flock.
No root compromise, descriptor injection or external rollback is modeled.
"""
import json
import os
import select
import shutil
import socket
import subprocess
import sys
import tempfile
import time
import unittest
from pathlib import Path

from koru_authority_admission_journal import AuthorityAdmissionJournal
from koru_transactional_hold_witness import TransactionalHoldWitness

AUTH = 65533
EXECUTOR = 65532
REQUESTER = 65534
CONTROLLER = 65530
MODULES = (
    "koru_authority_owned_marker_service.py",
    "koru_authority_admission_journal.py",
    "koru_authority_effect_time_fence.py",
    "koru_transactional_hold_witness.py",
    "koru_durable_effect_intent.py",
    "koru_transaction_scoped_effect.py",
    "koru_bounded_server.py",
    "koru_authority_reserved_workers.py",
)
SERVER = r"""
import os,select,sys
from koru_authority_owned_marker_service import AuthorityOwnedMarkerService
sock,db,marker = sys.argv[1:]
service=AuthorityOwnedMarkerService(
    sock,db,marker,executor_uid=65532,controller_uid=65530,
    expected={"generation":13,"event_id":"fixture","authority_ref":"ref"})
service.timeout=.05
print("READY",flush=True)
try:
    while True:
        readable,_,_=select.select([sys.stdin],[],[],0)
        if readable and sys.stdin.readline().strip()=="stop":break
        service.handle_request()
finally:service.server_close()
"""
CLIENT = r"""
import json,socket,sys
with socket.socket(socket.AF_UNIX) as s:
    s.settimeout(3)
    s.connect(sys.argv[1])
    s.sendall((sys.argv[2]+"\n").encode())
    data=b""
    while not data.endswith(b"\n"):
        part=s.recv(4096)
        if not part:break
        data+=part
print(data.decode(),flush=True)
"""
DIRECT = r"""
import os,sys
fd=os.open(sys.argv[1],os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o600)
os.close(fd)
"""


def drop(uid):
    def apply():
        os.setgroups([])
        os.setgid(uid)
        os.setuid(uid)
    return apply


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable privileged Linux-only fixture")
class AuthorityOwnedMarkerTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix="g3-authority-effect-")
        self.root=Path(self.temp.name)
        self.root.chmod(0o755)
        self.authdir=self.root/"authority"
        self.authdir.mkdir(mode=0o700)
        self.marker=self.root/"markers"
        self.marker.mkdir(mode=0o700)
        self.sockdir=self.root/"socket"
        self.sockdir.mkdir(mode=0o700)
        self.sockdir.chmod(0o711)
        for p in (self.authdir,self.marker,self.sockdir):
            os.chown(p,AUTH,AUTH)
        self.db=self.authdir/"authority.sqlite"
        state={"generation":13,"held":False,
               "event_id":"fixture","authority_ref":"ref"}
        witness=TransactionalHoldWitness.provision(str(self.db),state)
        AuthorityAdmissionJournal.provision(witness)
        os.chown(self.db,AUTH,AUTH)
        self.sock=str(self.sockdir/"authority.sock")
        self.lib=self.root/"lib"
        self.lib.mkdir(mode=0o755)
        for name in MODULES:
            shutil.copyfile(Path(__file__).with_name(name),self.lib/name)
        self.env=dict(os.environ,PYTHONPATH=str(self.lib),
                      PYTHONDONTWRITEBYTECODE="1")
        self.server=None
        self.start()

    def start(self):
        self.server=subprocess.Popen(
            [sys.executable,"-B","-c",SERVER,self.sock,str(self.db),
             str(self.marker)],
            preexec_fn=drop(AUTH),cwd="/",env=self.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        readable,_,_=select.select([self.server.stdout],[],[],5)
        if not readable:
            raise AssertionError("authority failed to become ready")
        line=self.server.stdout.readline().strip()
        if line!="READY":
            raise AssertionError("authority startup failure: "+line+
                                 " "+self.server.stderr.read())

    def stop(self):
        if self.server is None:return
        proc=self.server
        self.server=None
        if proc.poll() is None:
            try:
                proc.stdin.write("stop\n")
                proc.stdin.flush()
            except BrokenPipeError:
                pass
        _,err=proc.communicate(timeout=4)
        self.assertEqual(proc.returncode,0,err)
        if os.path.lexists(self.sock):
            os.unlink(self.sock)

    def tearDown(self):
        try:
            self.stop()
        finally:
            self.temp.cleanup()

    def ask(self,uid,op):
        p=subprocess.run(
            [sys.executable,"-B","-c",CLIENT,self.sock,
             json.dumps({"op":op})],
            preexec_fn=drop(uid),cwd="/",env=self.env,
            capture_output=True,text=True,timeout=5)
        self.assertEqual(p.returncode,0,p.stderr)
        return json.loads(p.stdout)

    def test_executor_and_requester_cannot_bypass_authority_via_dac(self):
        for uid in (EXECUTOR, REQUESTER, CONTROLLER):
            for path in (self.marker/"fixed.marker",self.db):
                p=subprocess.run(
                    [sys.executable,"-B","-c",DIRECT,str(path)],
                    preexec_fn=drop(uid),cwd="/",env=self.env,
                    capture_output=True,text=True,timeout=4)
                self.assertNotEqual(p.returncode,0)
                self.assertIn("PermissionError",p.stderr)
        self.assertFalse(list(self.marker.iterdir()))

    def test_authority_mediates_one_fixed_marker(self):
        result=self.ask(EXECUTOR,"fixed_marker")
        self.assertEqual(result["code"],"synthetic_effect_returned")
        marker=self.marker/"fixed.marker"
        self.assertTrue(marker.exists())
        self.assertEqual(marker.stat().st_uid,AUTH)
        self.assertEqual(marker.stat().st_size,0)
        self.assertEqual(self.ask(EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")

    def test_hold_first_blocks_effect(self):
        self.assertEqual(self.ask(CONTROLLER,"hold")["code"],"hold_recorded")
        self.assertEqual(self.ask(EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")
        self.assertFalse(list(self.marker.iterdir()))

    def test_unauthorized_peer_cannot_start_or_hold(self):
        self.assertEqual(self.ask(REQUESTER,"fixed_marker")["code"],
                         "peer_or_operation_denied")
        self.assertEqual(self.ask(EXECUTOR,"hold")["code"],
                         "peer_or_operation_denied")
        self.assertEqual(self.ask(CONTROLLER,"fixed_marker")["code"],
                         "peer_or_operation_denied")
        self.assertFalse(list(self.marker.iterdir()))

    def test_unknown_operation_fails_closed(self):
        self.assertEqual(self.ask(EXECUTOR,"arbitrary_write")["code"],
                         "peer_or_operation_denied")
        self.assertFalse(list(self.marker.iterdir()))

    def test_restart_preserves_started_and_blocks_repeat(self):
        self.assertTrue(self.ask(EXECUTOR,"fixed_marker")["ok"])
        self.stop()
        self.start()
        self.assertEqual(self.ask(EXECUTOR,"fixed_marker")["code"],
                         "authority_denied")
        self.assertEqual(len(list(self.marker.iterdir())),1)

    def test_missing_db_prevents_authority_restart_and_effect(self):
        self.stop()
        self.db.unlink()
        with self.assertRaises(AssertionError):
            self.start()
        failed=self.server
        self.server=None
        failed.communicate(timeout=4)
        self.assertNotEqual(failed.returncode,0)
        self.assertFalse(self.db.exists())
        self.assertFalse(list(self.marker.iterdir()))


if __name__=="__main__":
    unittest.main()
