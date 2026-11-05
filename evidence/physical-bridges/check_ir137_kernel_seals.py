#!/usr/bin/env python3
"""IR-137: kernel memfd seals versus inherited writable FD and old mmap.

On a disposable Linux runner, use ONE anonymous in-memory file, a
pre-HOLD delegated writable descriptor, and the strong F_SEAL_WRITE
kernel rule. After seal installation, EVEN ROOT and the unprivileged
holder of an inherited descriptor cannot change the file via write,
pwrite, ftruncate or a new writable shared mapping.

NEGATIVE controls:
- F_SEAL_WRITE cannot be set while an old writable MAP_SHARED exists;
- F_SEAL_FUTURE_WRITE still permits old shared mappings to change data;
- sealing object A cannot stop a privileged actor substituting object B.

None of these checks are a complete actuator/HOLD system or BCRD physics.
"""
import errno
import fcntl
import hashlib
import json
import mmap
import os
import pwd
import subprocess
import sys

CHILD = r"""
import errno, json, mmap, os, sys
fd=int(sys.argv[1])
out={"uid":os.geteuid()}
for name, f in (
    ("write",lambda:os.write(fd,b"X")),
    ("pwrite",lambda:os.pwrite(fd,b"Y",0)),
    ("truncate",lambda:os.ftruncate(fd,0)),
    ("shared_write_map",lambda:mmap.mmap(
        fd,1,flags=mmap.MAP_SHARED,prot=mmap.PROT_READ|mmap.PROT_WRITE)),
):
    try:
        value=f()
        if name=="shared_write_map":
            value.close()
        out[name]="ALLOWED"
    except OSError as error:
        out[name]=f"DENIED_{error.errno}"
print(json.dumps(out,sort_keys=True))
"""

PREFLIGHT = r"""
import json,os,sys
fd=int(sys.argv[1])
result=os.write(fd,b"!")
print(json.dumps({"uid":os.geteuid(),"wrote":result}))
"""


def as_child(fd,program,person=None):
    args=[sys.executable,"-B","-c",program,str(fd)]
    def drop():
        os.setgroups([])
        os.setgid(person.pw_gid)
        os.setuid(person.pw_uid)
    res=subprocess.run(
        args, pass_fds=(fd,),
        preexec_fn=drop if person is not None else None,
        timeout=8,check=True,capture_output=True,text=True
    )
    return json.loads(res.stdout)


def sha(fd):
    size=os.fstat(fd).st_size
    return hashlib.sha256(os.pread(fd,size,0)).hexdigest()


def expect_oserror(action, accepted):
    try:
        action()
    except OSError as exc:
        assert exc.errno in accepted,(exc.errno,accepted)
        return exc.errno
    raise AssertionError("kernel unexpectedly permitted forbidden operation")


def run():
    if sys.platform!="linux" or not hasattr(os,"memfd_create") or os.geteuid()!=0:
        raise RuntimeError("requires root-enabled disposable Linux runner")
    nobody=pwd.getpwnam("nobody")
    flags=os.MFD_ALLOW_SEALING | getattr(os,"MFD_CLOEXEC",0)
    strong=(
        fcntl.F_SEAL_WRITE|fcntl.F_SEAL_SHRINK|
        fcntl.F_SEAL_GROW|fcntl.F_SEAL_SEAL
    )
    fd=os.memfd_create("ir137-protected-object",flags)
    try:
        os.write(fd,b"committed-before-hold")
        inherited=os.dup(fd)
        try:
            # First verify the same unprivileged principal REALLY can
            # write through the inherited descriptor BEFORE sealing.
            os.lseek(inherited,0,os.SEEK_END)
            pre=as_child(inherited,PREFLIGHT,nobody)
            assert pre["uid"]==nobody.pw_uid and pre["wrote"]==1
            before_sha=sha(fd)

            # Kernel seal commit (our narrow test's HOLD boundary).
            fcntl.fcntl(fd,fcntl.F_ADD_SEALS,strong)
            assert fcntl.fcntl(fd,fcntl.F_GET_SEALS)&strong==strong
            after_sha=sha(fd)
            assert before_sha==after_sha

            for name,user in (("privileged-root",None),
                              ("preopened-fd-unprivileged",nobody)):
                result=as_child(inherited,CHILD,user)
                if user is not None:
                    assert result["uid"]==nobody.pw_uid
                else:
                    assert result["uid"]==0
                for op in ("write","pwrite","truncate","shared_write_map"):
                    assert result[op]==f"DENIED_{errno.EPERM}",(name,result)
                assert sha(fd)==after_sha
                print(f"PASS {name} cannot mutate strongly sealed original object")
            print("PASS sealed-object digest invariant:",after_sha)
        finally:
            os.close(inherited)

        # Lower-tier SEAL_FUTURE_WRITE does NOT revoke existing mappings.
        weak=os.memfd_create("ir137-weak-seal",flags)
        try:
            os.ftruncate(weak,4096)
            mapping=mmap.mmap(
                weak,4096,flags=mmap.MAP_SHARED,
                prot=mmap.PROT_READ|mmap.PROT_WRITE
            )
            try:
                expect_oserror(
                    lambda:fcntl.fcntl(weak,fcntl.F_ADD_SEALS,fcntl.F_SEAL_WRITE),
                    {errno.EBUSY}
                )
                fcntl.fcntl(weak,fcntl.F_ADD_SEALS,getattr(fcntl,'F_SEAL_FUTURE_WRITE',0x0010))
                expect_oserror(lambda:os.pwrite(weak,b"X",0),{errno.EPERM})
                mapping[:4]=b"EDIT"
                assert os.pread(weak,4,0)==b"EDIT"
                print("PASS NEGATIVE: FUTURE_WRITE allows preexisting shared writable mmap")
                print("PASS strong WRITE seal correctly refuses active shared mapping")
            finally:
                mapping.close()
            fcntl.fcntl(weak,fcntl.F_ADD_SEALS,strong)
            assert fcntl.fcntl(weak,fcntl.F_GET_SEALS)&strong==strong
            print("PASS after unmapping strong write seal is installable")
        finally:
            os.close(weak)

        # Physical alias identity is NOT fixed by sealing the original.
        other=os.memfd_create("ir137-substitution-target",flags)
        try:
            os.write(other,b"new-output-object")
            assert sha(other)!=sha(fd)
            assert sha(fd)==after_sha
            print("PASS NEGATIVE: privileged actor can create different output object")
            print("OPEN: external effect path must stay bound to authenticated sealed identity")
        finally:
            os.close(other)
        print("OS SCOPE: one volatile memfd; not a persistent file, device or physical output")
        print("COMPLETE PHYSICAL NO-BYPASS / original X3: NOT CERTIFIED")
    finally:
        os.close(fd)


if __name__=="__main__":
    run()
