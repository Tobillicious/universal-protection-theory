"""Root-provisioned disposable Linux UID separation and ordering fixture.

Three unprivileged UIDs: authority owns SQLite, executor owns marker,
requester only connects to executor; a fourth controller asks for HOLD.
The common flock is root-owned, advisory, and deliberately NOT a proof of
an uncompromisable effect boundary.
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

AUTH_UID = 65533
EXEC_UID = 65532
REQ_UID = 65534
HOLD_UID = 65530
LOCK_GID = 65531
MODULES = (
    "koru_separated_authority_service.py",
    "koru_separated_effect_executor.py",
    "koru_cross_uid_fence.py",
    "koru_authority_admission_journal.py",
    "koru_transactional_hold_witness.py",
    "koru_transaction_scoped_effect.py",
    "koru_durable_effect_intent.py",
)
AUTH_SCRIPT = r"""
import os, select, sys
from koru_separated_authority_service import SeparatedAuthorityService
path, db, lock = sys.argv[1:]
s=SeparatedAuthorityService(
    path, db, lock, executor_uid=65532, controller_uid=65530,
    lock_gid=65531, expected={"generation":11,
        "event_id":"fixture", "authority_ref":"fixture-ref"})
s.timeout=.05
print("READY",flush=True)
try:
    while True:
        ready,_,_=select.select([sys.stdin],[],[],0)
        if ready and sys.stdin.readline().strip()=="stop": break
        s.handle_request()
finally: s.server_close()
"""
EXEC_SCRIPT = r"""
import select,sys
from koru_separated_effect_executor import SeparatedEffectExecutor
path,marker,authority,lock=sys.argv[1:]
s=SeparatedEffectExecutor(
    path,marker,authority,lock,requester_uid=65534,
    authority_uid=65533,lock_gid=65531)
s.timeout=.05
print("READY",flush=True)
try:
    while True:
        ready,_,_=select.select([sys.stdin],[],[],0)
        if ready and sys.stdin.readline().strip()=="stop":break
        s.handle_request()
finally:s.server_close()
"""
CLIENT_SCRIPT = r"""
import json,socket,sys
with socket.socket(socket.AF_UNIX) as s:
    s.settimeout(4)
    s.connect(sys.argv[1])
    s.sendall((sys.argv[2]+"\n").encode())
    data=b""
    while not data.endswith(b"\n"):
        chunk=s.recv(4096)
        if not chunk: break
        data+=chunk
    print(data.decode(),flush=True)
"""
DIRECT_SCRIPT = r"""
import os,sys
fd=os.open(sys.argv[1],os.O_CREAT|os.O_WRONLY|os.O_EXCL,0o600)
os.close(fd)
"""


def identity(uid, gid=None):
    def apply():
        os.setgroups([])
        os.setgid(gid if gid is not None else uid)
        os.setuid(uid)
    return apply


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable privileged Linux CI only")
class SeparatedAuthorityIntegration(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory(prefix="g3-separated-auth-")
        self.root=Path(self.tmp.name)
        self.root.chmod(0o755)
        self.lockdir=self.root/"lock"
        self.lockdir.mkdir(mode=0o700)
        os.chown(self.lockdir,0,LOCK_GID)
        self.lockdir.chmod(0o710)
        self.lock=self.lockdir/"common.lock"
        self.lock.write_bytes(b"")
        os.chown(self.lock,0,LOCK_GID)
        self.lock.chmod(0o660)
        self.authdir=self.root/"authority"
        self.authdir.mkdir(mode=0o700)
        self.authsockdir=self.root/"authority-sock"
        self.authsockdir.mkdir(mode=0o700)
        self.authsockdir.chmod(0o711)
        self.markerdir=self.root/"marker"
        self.markerdir.mkdir(mode=0o700)
        self.execsockdir=self.root/"executor-sock"
        self.execsockdir.mkdir(mode=0o700)
        self.execsockdir.chmod(0o711)
        for directory,uid in ((self.authdir,AUTH_UID),
                              (self.authsockdir,AUTH_UID),
                              (self.markerdir,EXEC_UID),
                              (self.execsockdir,EXEC_UID)):
            os.chown(directory,uid,uid)
        self.db=self.authdir/"authority.sqlite"
        expected=dict(generation=11,held=False,event_id="fixture",
                      authority_ref="fixture-ref")
        witness=TransactionalHoldWitness.provision(str(self.db),expected)
        AuthorityAdmissionJournal.provision(witness)
        os.chown(self.db,AUTH_UID,AUTH_UID)
        self.authsock=str(self.authsockdir/"authority.sock")
        self.execsock=str(self.execsockdir/"executor.sock")
        self.lib=self.root/"lib"
        self.lib.mkdir(mode=0o755)
        for module in MODULES:
            shutil.copyfile(Path(__file__).with_name(module),self.lib/module)
        self.env=dict(os.environ,PYTHONPATH=str(self.lib),
                      PYTHONDONTWRITEBYTECODE="1")
        self.authority=None
        self.executor=None
        self.authority=self.start_process(AUTH_SCRIPT,AUTH_UID,
                                          self.authsock,str(self.db),
                                          str(self.lock))
        self.executor=self.start_process(EXEC_SCRIPT,EXEC_UID,
                                         self.execsock,str(self.markerdir),
                                         self.authsock,str(self.lock))

    def start_process(self,script,uid,*args):
        proc=subprocess.Popen(
            [sys.executable,"-B","-c",script,*args],
            preexec_fn=identity(uid,LOCK_GID),cwd="/",env=self.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        ready,_,_=select.select([proc.stdout],[],[],5)
        if not ready:
            raise AssertionError("no process readiness for uid "+str(uid))
        line=proc.stdout.readline().strip()
        if line!="READY":
            raise AssertionError("failed readiness: "+line+" "+
                                 proc.stderr.read())
        return proc

    def stop_process(self,proc,sock):
        if proc is None:return
        if proc.poll() is None:
            try:
                proc.stdin.write("stop\n")
                proc.stdin.flush()
            except BrokenPipeError:
                pass
        try:
            _,err=proc.communicate(timeout=4)
        except subprocess.TimeoutExpired:
            proc.kill()
            _,err=proc.communicate(timeout=4)
            raise AssertionError("process did not cleanly stop: "+err)
        self.assertEqual(proc.returncode,0,err)
        if os.path.lexists(sock):
            os.unlink(sock)

    def tearDown(self):
        try:
            self.stop_process(self.executor,self.execsock)
            self.stop_process(self.authority,self.authsock)
        finally:
            self.tmp.cleanup()

    def request(self,path,uid,payload,timeout=6):
        proc=subprocess.run(
            [sys.executable,"-B","-c",CLIENT_SCRIPT,
             path,json.dumps(payload)],preexec_fn=identity(uid),
            cwd="/",env=self.env,capture_output=True,text=True,
            timeout=timeout)
        self.assertEqual(proc.returncode,0,proc.stderr)
        return json.loads(proc.stdout)

    def test_requester_cannot_write_either_owner_resource(self):
        for path in (self.markerdir/"forged.marker",self.db):
            proc=subprocess.run(
                [sys.executable,"-B","-c",DIRECT_SCRIPT,str(path)],
                preexec_fn=identity(REQ_UID),cwd="/",env=self.env,
                capture_output=True,text=True,timeout=4)
            self.assertNotEqual(proc.returncode,0)
            self.assertIn("PermissionError",proc.stderr)
        self.assertFalse(list(self.markerdir.iterdir()))

    def test_executor_cannot_read_authority_database(self):
        proc=subprocess.run(
            [sys.executable,"-B","-c","import sys;open(sys.argv[1],'rb').read()",
             str(self.db)],
            preexec_fn=identity(EXEC_UID,LOCK_GID),cwd="/",env=self.env,
            capture_output=True,text=True,timeout=4)
        self.assertNotEqual(proc.returncode,0)
        self.assertIn("PermissionError",proc.stderr)

    def test_signed_no_requester_bypass_to_authority(self):
        result=self.request(self.authsock,REQ_UID,{"op":"prepare"})
        self.assertEqual(result["code"],"peer_or_operation_denied")
        self.assertFalse(list(self.markerdir.iterdir()))

    def test_untrusted_executor_peer_denied(self):
        result=self.request(self.execsock,HOLD_UID,{"op":"fixed_marker"})
        self.assertEqual(result["code"],"peer_denied")
        self.assertFalse(list(self.markerdir.iterdir()))

    def test_valid_effect_is_single_start_and_restart_blocks_replay(self):
        result=self.request(self.execsock,REQ_UID,{"op":"fixed_marker"})
        self.assertEqual(result["code"],"fixture_marker_created")
        self.assertEqual((self.markerdir/"fixed.marker").stat().st_uid,EXEC_UID)
        self.stop_process(self.executor,self.execsock)
        self.executor=None
        self.executor=self.start_process(EXEC_SCRIPT,EXEC_UID,
                                         self.execsock,str(self.markerdir),
                                         self.authsock,str(self.lock))
        result=self.request(self.execsock,REQ_UID,{"op":"fixed_marker"})
        self.assertEqual(result["code"],"authority_denied")
        self.assertEqual(len(list(self.markerdir.iterdir())),1)

    def test_hold_first_denies_effect(self):
        result=self.request(self.authsock,HOLD_UID,{"op":"hold"})
        self.assertEqual(result["code"],"hold_recorded")
        result=self.request(self.execsock,REQ_UID,{"op":"fixed_marker"})
        self.assertEqual(result["code"],"authority_denied")
        self.assertFalse(list(self.markerdir.iterdir()))

    def test_unknown_command_is_rejected(self):
        result=self.request(self.execsock,REQ_UID,{"op":"arbitrary"})
        self.assertEqual(result["code"],"bad_request")
        self.assertFalse(list(self.markerdir.iterdir()))

    def test_authority_disconnected_denies_without_marker(self):
        self.stop_process(self.authority,self.authsock)
        self.authority=None
        result=self.request(self.execsock,REQ_UID,{"op":"fixed_marker"})
        self.assertFalse(result["ok"])
        self.assertFalse(list(self.markerdir.iterdir()))

    def test_hold_waits_while_executor_owns_shared_fence(self):
        # Controlled lock owner (executor UID, not an actual effect). This
        # demonstrates the shared flock ordering, not kernel-level mediation.
        script=r"""
import sys
from koru_cross_uid_fence import ProvisionedCrossUidFence
f=ProvisionedCrossUidFence(sys.argv[1],shared_gid=65531)
with f:
    print("LOCKED",flush=True)
    assert sys.stdin.readline().strip()=="release"
f.close()
"""
        worker=subprocess.Popen(
            [sys.executable,"-B","-c",script,str(self.lock)],
            preexec_fn=identity(EXEC_UID,LOCK_GID),cwd="/",env=self.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        holder=None
        try:
            ready,_,_=select.select([worker.stdout],[],[],5)
            self.assertTrue(ready)
            self.assertEqual(worker.stdout.readline().strip(),"LOCKED")
            holder=subprocess.Popen(
                [sys.executable,"-B","-c",CLIENT_SCRIPT,
                 self.authsock,json.dumps({"op":"hold"})],
                preexec_fn=identity(HOLD_UID),cwd="/",env=self.env,
                stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
            time.sleep(.2)
            self.assertIsNone(holder.poll(),"HOLD completed while fence locked")
            worker.stdin.write("release\n")
            worker.stdin.flush()
            output,error=holder.communicate(timeout=5)
            self.assertEqual(holder.returncode,0,error)
            self.assertEqual(json.loads(output)["code"],"hold_recorded")
        finally:
            if worker.poll() is None:
                try:
                    worker.stdin.write("release\n")
                    worker.stdin.flush()
                except (BrokenPipeError,ValueError):
                    pass
            worker.communicate(timeout=4)
            if holder is not None and holder.poll() is None:
                holder.kill()
                holder.communicate(timeout=4)
        self.assertEqual(
            self.request(self.execsock,REQ_UID,{"op":"fixed_marker"})["code"],
            "authority_denied")


if __name__=="__main__":
    unittest.main()
