#!/usr/bin/env python3
"""IR-136: inherited write descriptor bypasses path DAC after HOLD.

Uses the SAME root-owned broker fixture and resource as IR-135, in a
new disposable Linux temporary directory. The parent intentionally
opens a writable file descriptor BEFORE HOLD and explicitly delegates
it to a child whose UID/GID are dropped to nobody AFTER HOLD.

Expected: nobody cannot reopen the protected path, yet may still
write through a previously delegated FD. Demonstrates capability
leakage, not a technique for attacking any user or external file.
"""
import json
import os
from pathlib import Path
import pwd
import socket
import subprocess
import sys
import tempfile
import time

from check_ir135_os_authority import call, records


DELEGATED = r"""
import json, os, stat, sys, time
file_path, number, expect_fd = sys.argv[1:]
result={"uid":os.getuid(),"gid":os.getgid()}
try:
    with open(file_path,"ab") as f:
        f.write(b"ILLEGAL-PATH\n")
    result["path"]="ALLOWED"
except PermissionError:
    result["path"]="DENIED"
if expect_fd=="yes":
    fd=int(number)
    assert stat.S_ISREG(os.fstat(fd).st_mode)
    record={"effect":"delegated-fd-after-hold","uid":os.getuid(),
            "commit_ns":time.monotonic_ns()}
    count=os.write(fd,(json.dumps(record)+"\n").encode())
    os.fsync(fd)
    result["fd"]="WROTE"
    result["bytes"]=count
else:
    result["fd"]="NOT_INHERITED"
print(json.dumps(result))
"""


def unprivileged_child(path, uid_info, fd=None):
    def drop():
        os.setgroups([])
        os.setgid(uid_info.pw_gid)
        os.setuid(uid_info.pw_uid)

    argv=[sys.executable,"-B","-c",DELEGATED,
          str(path),str(fd if fd is not None else -1),
          "yes" if fd is not None else "no"]
    child=subprocess.run(
        argv, preexec_fn=drop,
        pass_fds=(fd,) if fd is not None else (),
        text=True,capture_output=True,timeout=8,check=True
    )
    return json.loads(child.stdout)


def run():
    if sys.platform!="linux" or os.geteuid()!=0 or not hasattr(socket,"SO_PEERCRED"):
        raise RuntimeError("IR136 requires disposable root-enabled Linux CI")
    nobody=pwd.getpwnam("nobody")
    with tempfile.TemporaryDirectory(prefix="ir136-inherited-fd-") as temp:
        base=Path(temp)
        base.chmod(0o711)
        public=base/"public"
        public.mkdir(mode=0o755)
        sealed=base/"sealed"
        sealed.mkdir(mode=0o700)
        effect=sealed/"effect.jsonl"
        effect.write_bytes(b"")
        effect.chmod(0o600)
        channel=public/"broker.sock"
        marker=sealed/"started"

        # The source case has the actual root broker, not only a simulated
        # HOLD flag. A separate process handles the source-authorized write.
        fixture=Path(__file__).with_name("check_ir135_os_authority.py")
        broker=subprocess.Popen(
            [sys.executable,"-B",str(fixture),"--server",
             str(channel),str(effect),str(marker)],
            stdout=subprocess.PIPE,stderr=subprocess.PIPE
        )
        descriptor=None
        try:
            deadline=time.monotonic()+6
            while not channel.exists():
                assert broker.poll() is None, "broker exited"
                assert time.monotonic()<deadline, "broker socket timeout"
                time.sleep(0.005)

            ok=call(channel,{"op":"apply","value":"prehold-authorized"})
            assert ok["ok"] is True
            assert len(records(effect))==1

            # Critical delegated OS capability: open before the HOLD,
            # passed across exec to a post-HOLD unprivileged process.
            descriptor=os.open(effect,os.O_WRONLY|os.O_APPEND|os.O_NOFOLLOW)
            hold=call(channel,{"op":"hold"})
            assert hold["ok"] is True
            held_snapshot=effect.read_bytes()
            assert call(channel,{"op":"apply","value":"after-held"})=={
                "ok":False,"reason":"held"
            }

            leaked=unprivileged_child(effect,nobody,fd=descriptor)
            assert leaked["uid"]==nobody.pw_uid
            assert leaked["path"]=="DENIED"
            assert leaked["fd"]=="WROTE"
            after=records(effect)
            assert len(after)==2
            assert after[1]["effect"]=="delegated-fd-after-hold"
            assert after[1]["uid"]==nobody.pw_uid
            assert after[1]["commit_ns"]>hold["hold_ack_ns"]
            assert effect.read_bytes()!=held_snapshot
            print("PASS outsider still cannot open protected path by DAC")
            print("PASS NEGATIVE: delegated writable FD permits outsider post-HOLD effect")

            os.close(descriptor)
            descriptor=None
            snapshot=effect.read_bytes()
            clean=unprivileged_child(effect,nobody,fd=None)
            assert clean["path"]=="DENIED"
            assert clean["fd"]=="NOT_INHERITED"
            assert effect.read_bytes()==snapshot
            print("PASS without delegated writable FD, outside path write is denied")
            print("COMPLETE FD/capability inventory: OPEN_EXTERNAL")
            print("ROOT, OTHER EFFECT PATHS AND UNIVERSAL PHYSICAL X3: NOT CERTIFIED")
        finally:
            if descriptor is not None:
                os.close(descriptor)
            if broker.poll() is None:
                try:
                    call(channel,{"op":"stop"},timeout=2)
                except OSError:
                    pass
            try:
                _,stderr=broker.communicate(timeout=5)
            except subprocess.TimeoutExpired:
                broker.kill()
                _,stderr=broker.communicate()
            if broker.returncode:
                raise AssertionError(
                    "source broker failed: "+stderr.decode(errors="replace"))


if __name__=="__main__":
    run()
