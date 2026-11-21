"""Actual post-launch SCM_RIGHTS transfer, executor UID and safe receiver.

The raw receiver intentionally proves a writable descriptor can bypass DAC
even if it was NOT inherited at exec time. Safe receiver detects ancillary
rights, closes the transferred FD and rejects; no protected effect occurs.
Only disposable synthetic files in a private temporary directory are touched.
"""
import array
import os
import shutil
from pathlib import Path
import socket
import subprocess
import sys
import tempfile
import unittest

import test_koru_authority_owned_marker_service as base
from koru_scm_rights_receive_guard import recv_payload_without_rights

RECEIVER = r"""
import array,os,socket,sys
from koru_scm_rights_receive_guard import recv_payload_without_rights
fd=int(sys.argv[1])
mode=sys.argv[2]
with socket.socket(fileno=fd) as sock:
    if mode=="raw":
        payload,controls,flags,_=sock.recvmsg(
            128,socket.CMSG_SPACE(16),socket.MSG_CMSG_CLOEXEC)
        for level,kind,raw in controls:
            if level==socket.SOL_SOCKET and kind==socket.SCM_RIGHTS:
                a=array.array("i")
                a.frombytes(raw[:len(raw)//a.itemsize*a.itemsize])
                for opened in a:
                    os.write(opened,b"BYPASS")
                    os.close(opened)
                print("BYPASS",flush=True)
    elif mode=="guarded":
        try:
            recv_payload_without_rights(sock,max_payload=128)
            print("ACCEPTED",flush=True)
        except PermissionError:
            print("DENIED",flush=True)
    else:
        raise ValueError("unknown receiver mode")
"""


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable Linux UID fixture only")
class SCMRightsReceiverTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix="g3-scm-rights-")
        self.root=Path(self.temp.name)
        self.root.chmod(0o700)
        self.marker=self.root/"only.test"
        self.fd=os.open(self.marker,os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o600)
        self.lib=tempfile.TemporaryDirectory(prefix="g3-scm-public-lib-")
        Path(self.lib.name).chmod(0o755)
        shutil.copyfile(Path(__file__).with_name("koru_scm_rights_receive_guard.py"),
                        Path(self.lib.name)/"koru_scm_rights_receive_guard.py")

    def tearDown(self):
        os.close(self.fd)
        self.temp.cleanup()
        self.lib.cleanup()

    def run_child(self,mode):
        parent,child=socket.socketpair(socket.AF_UNIX,socket.SOCK_DGRAM)
        try:
            proc=subprocess.Popen(
                [sys.executable,"-B","-c",RECEIVER,str(child.fileno()),mode],
                preexec_fn=base.drop(base.EXECUTOR),
                close_fds=True,pass_fds=(child.fileno(),),cwd="/",
                env=dict(os.environ,PYTHONPATH=self.lib.name,
                         PYTHONDONTWRITEBYTECODE="1"),
                stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
            child.close()
            rights=array.array("i",[self.fd])
            parent.sendmsg([b"PING"],[(socket.SOL_SOCKET,socket.SCM_RIGHTS,
                                      rights.tobytes())])
            out,err=proc.communicate(timeout=5)
            self.assertEqual(proc.returncode,0,err)
            return out.strip()
        finally:
            parent.close()
            child.close()

    def test_post_launch_fd_transfer_bypasses_private_path(self):
        self.assertEqual(self.run_child("raw"),"BYPASS")
        self.assertEqual(self.marker.read_bytes(),b"BYPASS")

    def test_guard_denies_post_launch_fd_transfer_and_preserves_file(self):
        self.assertEqual(self.run_child("guarded"),"DENIED")
        self.assertEqual(self.marker.read_bytes(),b"")

    def test_plain_unix_datagram_accepted(self):
        a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_DGRAM)
        try:
            a.send(b"KNOWN")
            self.assertEqual(recv_payload_without_rights(b),b"KNOWN")
        finally:
            a.close()
            b.close()

    def test_oversized_payload_rejected_without_effect(self):
        a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_DGRAM)
        try:
            a.send(b"x"*129)
            with self.assertRaises(PermissionError):
                recv_payload_without_rights(b,max_payload=128)
            self.assertEqual(self.marker.read_bytes(),b"")
        finally:
            a.close()
            b.close()

    def test_stream_socket_rejected_as_wrong_message_transport(self):
        a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_STREAM)
        try:
            with self.assertRaises(ValueError):
                recv_payload_without_rights(b)
        finally:
            a.close()
            b.close()

    def test_overfull_rights_ancillary_rejected(self):
        a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_DGRAM)
        try:
            rights=array.array("i",[self.fd]*4)
            a.sendmsg([b"PING"],[(socket.SOL_SOCKET,socket.SCM_RIGHTS,
                                   rights.tobytes())])
            with self.assertRaises(PermissionError):
                recv_payload_without_rights(b,max_fds=1)
            self.assertEqual(self.marker.read_bytes(),b"")
        finally:
            a.close()
            b.close()


if __name__=="__main__":
    unittest.main()
