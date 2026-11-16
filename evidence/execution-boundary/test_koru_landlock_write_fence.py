"""Linux Landlock adversarial research: read remains available, writes deny.

Each filtered probe is a disposable process. Existing open write descriptors
are tested explicitly as an unresolved limitation. The authority service
remains the only owner of the synthetic marker.
"""
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

import test_koru_authority_owned_marker_service as base
from koru_landlock_write_fence import LANDLOCK_CHILD_CODE
from koru_no_inherited_fd_executor import launch_fixed_executor_client

PROBE=r"""
import errno,os,sys
operation,path=sys.argv[1:3]
_install_write_deny_landlock()
try:
    if operation=="read":
        with open(path,"rb") as stream:
            assert stream.read()==b"preserved"
    elif operation=="create":
        with open(path,"wb") as stream:
            stream.write(b"bad")
    elif operation=="unlink":
        os.unlink(path)
    elif operation=="rename":
        os.rename(path,path+".moved")
    elif operation=="truncate":
        os.truncate(path,0)
    elif operation=="mkdir":
        os.mkdir(path)
    elif operation=="preopened":
        os.write(int(path),b"leaked")
    else:
        raise ValueError(operation)
except OSError as error:
    if error.errno in (errno.EACCES,errno.EPERM):
        print("DENIED",flush=True)
    else:
        raise
else:
    print("ALLOWED",flush=True)
"""

@unittest.skipUnless(sys.platform=="linux","Landlock Linux only")
class LandlockWriteFenceTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix="g3-landlock-")
        self.root=Path(self.temp.name)
        self.target=self.root/"sample"
        self.target.write_bytes(b"preserved")

    def tearDown(self):
        self.temp.cleanup()

    def probe(self,operation,target=None,*,preopened_fd=None):
        cmd=[sys.executable,"-B","-c",LANDLOCK_CHILD_CODE+"\n"+PROBE,
             operation,str(target if target is not None else self.target)]
        if preopened_fd is not None:
            cmd[-1]=str(preopened_fd)
        p=subprocess.run(cmd,pass_fds=(preopened_fd,) if preopened_fd is not None else (),
                         cwd="/",capture_output=True,text=True,timeout=5)
        self.assertEqual(p.returncode,0,p.stderr)
        return p.stdout.strip()

    def test_normal_read_allowed(self):
        self.assertEqual(self.probe("read"),"ALLOWED")

    def test_write_to_existing_file_denied(self):
        self.assertEqual(self.probe("create"),"DENIED")
        self.assertEqual(self.target.read_bytes(),b"preserved")

    def test_unlink_denied(self):
        self.assertEqual(self.probe("unlink"),"DENIED")
        self.assertTrue(self.target.exists())

    def test_rename_denied(self):
        self.assertEqual(self.probe("rename"),"DENIED")
        self.assertTrue(self.target.exists())
        self.assertFalse((self.root/"sample.moved").exists())

    def test_truncate_denied_when_abi_supports_it(self):
        # Fail-closed scope: ABI v1/v2 cannot mediate TRUNCATE.
        # This test documents the ABI-dependent behavior explicitly.
        from subprocess import run
        version=run([sys.executable,"-B","-c",LANDLOCK_CHILD_CODE+
                     "\nprint(_install_write_deny_landlock())"],
                    capture_output=True,text=True,timeout=5)
        self.assertEqual(version.returncode,0,version.stderr)
        if int(version.stdout.strip())<3:
            self.skipTest("Landlock ABI < 3 cannot mediate TRUNCATE")
        self.assertEqual(self.probe("truncate"),"DENIED")
        self.assertEqual(self.target.read_bytes(),b"preserved")

    def test_mkdir_denied(self):
        self.assertEqual(self.probe("mkdir",self.root/"newdir"),"DENIED")
        self.assertFalse((self.root/"newdir").exists())

    def test_preopened_write_fd_is_known_counterexample(self):
        fd=os.open(self.target,os.O_WRONLY|os.O_APPEND)
        try:
            self.assertEqual(self.probe("preopened",preopened_fd=fd),"ALLOWED")
            self.assertEqual(self.target.read_bytes(),b"preservedleaked")
        finally:
            os.close(fd)

@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable Linux UID fixture only")
class LandlockAuthorityTests(unittest.TestCase):
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
    def test_landlock_and_seccomp_preserve_authority_effect(self):
        self.assertEqual(self.launch()["code"],"synthetic_effect_returned")
        self.assertTrue((self.fixture.marker/"fixed.marker").exists())
        self.assertEqual(self.launch()["code"],"authority_denied")
    def test_landlock_and_seccomp_respect_hold(self):
        self.assertEqual(self.fixture.ask(base.CONTROLLER,"hold")["code"],
                         "hold_recorded")
        self.assertEqual(self.launch()["code"],"authority_denied")
        self.assertFalse((self.fixture.marker/"fixed.marker").exists())

if __name__=="__main__":
    unittest.main()
