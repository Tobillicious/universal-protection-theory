"""Disposable privileged Linux cross-UID revision witness regression.

Different UIDs own: revision witness (65533), authorized client (65534),
untrusted peer (65532). Tests kernel DAC against the database and key,
peer credential denial, concurrent stale CAS and lost acknowledgment restart.

No independent host or root compromise protection is claimed.
"""
import json
import os
import select
import signal
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_monotonic_revision_witness import MonotonicRevisionWitness, _digest

AUTH = 65533
CLIENT = 65534
ROGUE = 65532
MODULES = ("koru_cross_uid_revision_witness.py",
           "koru_monotonic_revision_witness.py",
           "koru_external_checkpoint_contrast.py",
           "koru_signed_remote_hold_witness.py",
           "koru_local_hold_ack_socket.py",
           "koru_signed_hold_receipt.py",
           "koru_durable_effect_intent.py",
           "koru_transactional_hold_witness.py",
           "koru_transaction_scoped_effect.py")
SERVER = r"""
import os,select,signal,sys
from koru_cross_uid_revision_witness import CrossUidRevisionWitness
sock,db,key,mode=sys.argv[1:]
s=CrossUidRevisionWitness(sock,db,key,client_uid=65534)
if mode=="after_commit_kill":
    original=s.witness.advance
    def advance_then_kill(*args,**kw):
        outcome=original(*args,**kw)
        if outcome.get("ok"):
            os.kill(os.getpid(), signal.SIGKILL)
        return outcome
    s.witness.advance=advance_then_kill
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
import json,sys
from cryptography.hazmat.primitives import serialization
from koru_cross_uid_revision_witness import request_witness
sock,pub,query=sys.argv[1:]
with open(pub,"rb") as f:
    public=serialization.load_pem_public_key(f.read())
try:
    print(json.dumps(request_witness(
        sock,json.loads(query),expected_uid=65533,public_key=public)),
        flush=True)
except Exception as exc:
    print(json.dumps({"ok":False,"code":"client_failed_closed",
                      "error":type(exc).__name__}),flush=True)
"""


def as_uid(uid):
    def drop():
        os.setgroups([])
        os.setgid(uid)
        os.setuid(uid)
    return drop


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable privileged Linux only")
class CrossUidRevisionWitnessTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix="g3-revision-uid-")
        self.root=Path(self.temp.name)
        self.root.chmod(0o755)
        self.private_dir=self.root/"private"
        self.private_dir.mkdir(mode=0o700)
        self.socket_dir=self.root/"socket"
        self.socket_dir.mkdir(mode=0o711)
        self.public_dir=self.root/"public"
        self.public_dir.mkdir(mode=0o755)
        for p in (self.private_dir,self.socket_dir):
            os.chown(p,AUTH,AUTH)
        self.db=str(self.private_dir/"history.sqlite")
        self.keypath=str(self.private_dir/"signing.pem")
        self.pub=str(self.public_dir/"verify.pem")
        self.sock=str(self.socket_dir/"witness.sock")
        self.base=dict(generation=4,held=False,
                       event_id="fixture",authority_ref="ref",
                       pending_ids=[])
        self.key=Ed25519PrivateKey.generate()
        self.witness=MonotonicRevisionWitness.provision(
            self.db,self.key,self.base)
        Path(self.keypath).write_bytes(
            self.key.private_bytes(
                encoding=serialization.Encoding.PEM,
                format=serialization.PrivateFormat.PKCS8,
                encryption_algorithm=serialization.NoEncryption()))
        Path(self.pub).write_bytes(
            self.key.public_key().public_bytes(
                encoding=serialization.Encoding.PEM,
                format=serialization.PublicFormat.SubjectPublicKeyInfo))
        os.chmod(self.keypath,0o600)
        os.chown(self.keypath,AUTH,AUTH)
        os.chown(self.db,AUTH,AUTH)
        self.lib=self.root/"lib"
        self.lib.mkdir(mode=0o755)
        for module in MODULES:
            shutil.copyfile(Path(__file__).with_name(module),
                            self.lib/module)
        self.env=dict(os.environ,PYTHONPATH=str(self.lib),
                      PYTHONDONTWRITEBYTECODE="1")
        self.proc=None
        self.start()

    def start(self,mode="normal"):
        self.proc=subprocess.Popen(
            [sys.executable,"-B","-c",SERVER,self.sock,
             self.db,self.keypath,mode],
            preexec_fn=as_uid(AUTH),cwd="/",env=self.env,
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,text=True)
        ready,_,_=select.select([self.proc.stdout],[],[],5)
        if not ready:
            raise AssertionError("witness not ready")
        line=self.proc.stdout.readline().strip()
        if line!="READY":
            _,err=self.proc.communicate(timeout=3)
            raise AssertionError("witness start failed "+line+" "+err)

    def stop(self):
        if self.proc is None:return
        p=self.proc
        self.proc=None
        if p.poll() is None:
            try:
                p.stdin.write("stop\n")
                p.stdin.flush()
            except BrokenPipeError:
                pass
        _,err=p.communicate(timeout=4)
        self.assertEqual(p.returncode,0,err)
        if os.path.lexists(self.sock):
            os.unlink(self.sock)

    def tearDown(self):
        try:
            self.stop()
        finally:
            self.temp.cleanup()

    def ask(self,uid,query):
        proc=subprocess.run(
            [sys.executable,"-B","-c",CLIENT_SCRIPT,self.sock,self.pub,
             json.dumps(query)],preexec_fn=as_uid(uid),cwd="/",
            env=self.env,capture_output=True,text=True,timeout=5)
        self.assertEqual(proc.returncode,0,proc.stderr)
        value=json.loads(proc.stdout)
        if (value.get("code")=="witness_unavailable_or_uncertain"
                and self.proc is not None):
            ready,_,_=select.select([self.proc.stderr],[],[],0.2)
            if ready:
                print("WITNESS_DIAG:",self.proc.stderr.readline(),
                      file=sys.stderr,flush=True)
        return value

    def read(self):
        return self.ask(CLIENT,{"op":"read"})

    def advance(self,snapshot,receipt):
        return self.ask(CLIENT,dict(op="advance",snapshot=snapshot,
                                    revision=receipt["revision"],
                                    digest=receipt["digest"]))

    def test_client_cannot_read_or_modify_witness_key_and_db(self):
        for uid in (CLIENT,ROGUE):
            for path in (self.db,self.keypath):
                p=subprocess.run(
                    [sys.executable,"-B","-c",
                     "import sys;open(sys.argv[1],'rb').read()",
                     path],preexec_fn=as_uid(uid),cwd="/",
                    env=self.env,capture_output=True,text=True,timeout=4)
                self.assertNotEqual(p.returncode,0)
                self.assertIn("PermissionError",p.stderr)

    def test_pinned_peer_identity_rejects_other_uid(self):
        outcome=self.ask(ROGUE,{"op":"read"})
        self.assertFalse(outcome["ok"])
        self.assertEqual(outcome["code"],"peer_denied")

    def test_read_is_signed_and_non_authorizing(self):
        outcome=self.read()
        self.assertTrue(outcome["ok"])
        self.assertEqual(outcome["code"],"snapshot_only")
        self.assertEqual(outcome["receipt"]["revision"],0)

    def test_ordered_commit_and_restart(self):
        initial=self.read()["receipt"]
        held=dict(self.base,held=True)
        committed=self.advance(held,initial)
        self.assertEqual(committed["code"],"revision_committed")
        self.assertEqual(committed["receipt"]["revision"],1)
        self.stop()
        self.start()
        self.assertEqual(self.read()["receipt"]["revision"],1)
        self.assertEqual(self.advance(self.base,initial)["code"],"stale_revision")

    def test_stale_replay_does_not_increment_revision(self):
        initial=self.read()["receipt"]
        self.assertTrue(self.advance(dict(self.base,held=True),initial)["ok"])
        self.assertEqual(
            self.advance(dict(self.base,pending_ids=["op"]),initial)["code"],
            "stale_revision")
        self.assertEqual(self.read()["receipt"]["revision"],1)

    def test_missing_state_denies_on_restart(self):
        self.stop()
        Path(self.db).unlink()
        with self.assertRaises(AssertionError):
            self.start()
        failed=self.proc
        self.proc=None
        self.assertNotEqual(failed.returncode,0)
        self.assertFalse(Path(self.db).exists())

    def test_lost_ack_committed_revision_recovered_by_read(self):
        self.stop()
        self.start("after_commit_kill")
        initial=self.read()["receipt"]
        new=dict(self.base,held=True)
        outcome=self.advance(new,initial)
        self.assertEqual(outcome["code"],"client_failed_closed")
        p=self.proc
        self.assertEqual(p.wait(timeout=4),-signal.SIGKILL)
        p.communicate(timeout=3)
        self.proc=None
        os.unlink(self.sock)
        self.start()
        latest=self.read()["receipt"]
        self.assertEqual(latest["revision"],1)
        self.assertEqual(latest["digest"],_digest(new))
        self.assertEqual(self.advance(new,initial)["code"],"stale_revision")

    def test_remote_client_cannot_clear_committed_hold(self):
        initial=self.read()["receipt"]
        held=dict(self.base,held=True)
        self.assertTrue(self.advance(held,initial)["ok"])
        latest=self.read()["receipt"]
        denied=self.advance(self.base,latest)
        self.assertEqual(denied["code"],"protection_regression_denied")
        self.assertEqual(self.read()["receipt"],latest)

    def test_remote_client_cannot_erase_unresolved_admission(self):
        initial=self.read()["receipt"]
        pending=dict(self.base,pending_ids=["op"])
        self.assertTrue(self.advance(pending,initial)["ok"])
        latest=self.read()["receipt"]
        denied=self.advance(self.base,latest)
        self.assertEqual(denied["code"],"protection_regression_denied")
        self.assertEqual(self.read()["receipt"],latest)

    def test_unavailable_service_denies(self):
        self.stop()
        p=subprocess.run(
            [sys.executable,"-B","-c",CLIENT_SCRIPT,self.sock,self.pub,
             json.dumps({"op":"read"})],preexec_fn=as_uid(CLIENT),
            cwd="/",env=self.env,capture_output=True,text=True,timeout=4)
        self.assertEqual(p.returncode,0,p.stderr)
        self.assertEqual(json.loads(p.stdout)["code"],"client_failed_closed")


if __name__=="__main__":
    unittest.main()
