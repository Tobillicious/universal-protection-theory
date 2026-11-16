"""Adversarial alternate pathname effects through fixed-child seccomp.

Prove that an unfiltered child can write an ordinary writable test path,
then assert that the filtered child gets kernel EPERM for the same path.
The test deliberately does not assert global mandatory mediation; preopened
writable descriptors, write syscalls and other processes remain viable paths.
"""
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile
import unittest

import test_koru_authority_owned_marker_service as base
from koru_no_inherited_fd_executor import launch_fixed_executor_client
from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE

PROBE = r"""
import ctypes,errno,os,sys
operation,target=sys.argv[1:3]
if len(sys.argv)>3 and sys.argv[3]=="filtered":
    _deny_fd_receive_syscalls()
try:
    if operation=="create":
        with open(target,"wb") as stream:
            stream.write(b"unsafe")
    elif operation=="unlink":
        os.unlink(target)
    elif operation=="rename":
        os.rename(target,target+".renamed")
    elif operation=="read":
        with open(target,"rb") as stream:
            stream.read(1)
    elif operation=="x32":
        libc=ctypes.CDLL(None,use_errno=True)
        result=libc.syscall(ctypes.c_long(0x40000000 | 39))
        if result==-1 and ctypes.get_errno()==errno.EPERM:
            print("X32_DENIED",flush=True)
            sys.exit(0)
        raise AssertionError("x32 number not denied: "+str(result)+
                             " errno "+str(ctypes.get_errno()))
    else:
        raise ValueError("unsupported probe")
except OSError as error:
    if error.errno==errno.EPERM:
        print("EPERM",flush=True)
    else:
        raise
else:
    print("ALLOWED",flush=True)
"""


@unittest.skipUnless(sys.platform=="linux","Linux seccomp research only")
class PathEffectFenceTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix="g3-alternate-path-")
        self.root=Path(self.temp.name)

    def tearDown(self):
        self.temp.cleanup()

    def probe(self,operation,target,filtered=True):
        code=(SECCOMP_CHILD_CODE+"\n" if filtered else "")+PROBE
        command=[sys.executable,"-B","-c",code,operation,str(target)]
        if filtered:
            command.append("filtered")
        proc=subprocess.run(command,cwd="/",capture_output=True,
                            text=True,timeout=6)
        self.assertEqual(proc.returncode,0,proc.stderr)
        return proc.stdout.strip()

    def test_unfiltered_executor_can_write_unmediated_path(self):
        target=self.root/"unmediated"
        self.assertEqual(self.probe("create",target,False),"ALLOWED")
        self.assertEqual(target.read_bytes(),b"unsafe")

    def test_seccomp_denies_direct_create_despite_writable_directory(self):
        target=self.root/"must-not-exist"
        self.assertEqual(self.probe("create",target),"EPERM")
        self.assertFalse(target.exists())

    def test_seccomp_denies_direct_unlink(self):
        target=self.root/"retained"
        target.write_bytes(b"protected")
        self.assertEqual(self.probe("unlink",target),"EPERM")
        self.assertEqual(target.read_bytes(),b"protected")

    def test_seccomp_denies_direct_rename(self):
        target=self.root/"retained"
        target.write_bytes(b"protected")
        self.assertEqual(self.probe("rename",target),"EPERM")
        self.assertEqual(target.read_bytes(),b"protected")
        self.assertFalse((self.root/"retained.renamed").exists())

    def test_strict_filter_also_denies_read_open(self):
        target=self.root/"readable"
        target.write_bytes(b"okay")
        self.assertEqual(self.probe("read",target),"EPERM")
        self.assertEqual(target.read_bytes(),b"okay")

    @unittest.skipUnless(platform.machine().lower()=="x86_64",
                         "x32 syscall namespace exists on x86_64 only")
    def test_x32_syscall_number_refused(self):
        self.assertEqual(self.probe("x32",self.root/"unused"),"X32_DENIED")


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable Linux cross-UID fixture only")
class PathFenceAuthorityTests(unittest.TestCase):
    def setUp(self):
        self.fixture=base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def launch(self):
        return launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=base.AUTH,
            authority_pid=self.fixture.server.pid)

    def test_stricter_filtered_executor_still_uses_authority(self):
        self.assertEqual(self.launch()["code"],"synthetic_effect_returned")
        self.assertTrue((self.fixture.marker/"fixed.marker").exists())
        self.assertEqual(self.launch()["code"],"authority_denied")

    def test_stricter_filtered_executor_respects_hold(self):
        self.assertEqual(self.fixture.ask(base.CONTROLLER,"hold")["code"],
                         "hold_recorded")
        self.assertEqual(self.launch()["code"],"authority_denied")
        self.assertFalse((self.fixture.marker/"fixed.marker").exists())


if __name__=="__main__":
    unittest.main()
