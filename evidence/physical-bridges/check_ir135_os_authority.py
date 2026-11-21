#!/usr/bin/env python3
"""IR-135: Linux DAC principal-scoped final-effect boundary challenge.

One isolated root-owned broker, one protected temporary output file, a
named unprivileged Linux UID and an intentionally powerful root bypass.
Cooperative HOLD + an OS DAC identity barrier are both tested.

No hardware tests, no all-principal denial, no universal source physics.
Run as root only on a disposable Linux CI runner, not a user machine.
"""
import json
import os
from pathlib import Path
import pwd
import socket
import struct
import subprocess
import sys
import tempfile
import threading
import time


def call(path, data, timeout=6):
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
        sock.settimeout(timeout)
        sock.connect(str(path))
        sock.sendall((json.dumps(data)+"\n").encode())
        out=b""
        while not out.endswith(b"\n"):
            packet=sock.recv(4096)
            if not packet:
                raise RuntimeError("broker closed")
            out+=packet
        return json.loads(out)


def server(socket_path, effect_path, marker):
    held=False
    path=Path(socket_path)
    with socket.socket(socket.AF_UNIX,socket.SOCK_STREAM) as listening:
        listening.bind(str(path))
        os.chmod(path,0o666)
        listening.listen(10)
        while True:
            client,_=listening.accept()
            with client:
                client.settimeout(6)
                uid=struct.unpack("3i",client.getsockopt(
                    socket.SOL_SOCKET,socket.SO_PEERCRED,
                    struct.calcsize("3i")))[1]
                request=b""
                while not request.endswith(b"\n"):
                    piece=client.recv(4096)
                    if not piece:
                        break
                    request+=piece
                    if len(request)>8192:
                        raise ValueError("oversize request")
                payload=json.loads(request)
                op=payload.get("op")
                if op=="apply":
                    if held:
                        answer={"ok":False,"reason":"held"}
                    else:
                        if payload.get("delay"):
                            Path(marker).touch()
                            time.sleep(0.12)
                        timestamp=time.monotonic_ns()
                        row={"value":payload.get("value"),"uid":uid,
                             "commit_ns":timestamp}
                        fd=os.open(effect_path,os.O_APPEND|os.O_WRONLY|os.O_NOFOLLOW)
                        try:
                            os.write(fd,(json.dumps(row)+"\n").encode())
                            os.fsync(fd)
                        finally:
                            os.close(fd)
                        answer={"ok":True,"commit_ns":timestamp}
                elif op=="hold":
                    if uid != 0:
                        answer={"ok":False,"reason":"not-authorized-to-hold"}
                    else:
                        held=True
                        answer={"ok":True,"hold_ack_ns":time.monotonic_ns()}
                elif op=="stop":
                    answer={"ok":uid==0}
                else:
                    answer={"ok":False,"reason":"unknown-command"}
                client.sendall((json.dumps(answer)+"\n").encode())
                if op=="stop" and uid==0:
                    break


ATTACK = r"""
import json,os,socket,sys
channel,effect=sys.argv[1:]
def rpc(payload):
    with socket.socket(socket.AF_UNIX,socket.SOCK_STREAM) as s:
        s.connect(channel)
        s.sendall((json.dumps(payload)+"\n").encode())
        return json.loads(s.recv(4096))
result={"hold":rpc({"op":"hold"}),"apply":rpc({"op":"apply","value":"attacker"})}
for op,func in (
    ("append",lambda:open(effect,"ab").write(b"UNAUTH\n")),
    ("truncate",lambda:open(effect,"wb").write(b"UNAUTH\n")),
    ("chmod",lambda:os.chmod(effect,0o666)),
    ("unlink",lambda:os.unlink(effect)),
):
    try:
        func()
        result[op]="BYPASS"
    except PermissionError:
        result[op]="DENIED"
print(json.dumps(result))
"""


def attack_as_unprivileged(channel,effect,nobody):
    def drop():
        os.setgroups([])
        os.setgid(nobody.pw_gid)
        os.setuid(nobody.pw_uid)
    process=subprocess.run(
        [sys.executable,"-B","-c",ATTACK,str(channel),str(effect)],
        preexec_fn=drop,capture_output=True,text=True,timeout=12,check=True)
    return json.loads(process.stdout)


def records(path):
    return [json.loads(v) for v in path.read_text().splitlines() if v.strip()]


def run():
    if sys.platform!="linux" or os.geteuid()!=0 or not hasattr(socket,"SO_PEERCRED"):
        raise RuntimeError("required Linux root-only ephemeral CI test")
    nobody=pwd.getpwnam("nobody")
    with tempfile.TemporaryDirectory(prefix="ir135-os-authority-") as scratch:
        base=Path(scratch)
        os.chmod(base,0o711)
        public=base/"public"
        public.mkdir(mode=0o755)
        sealed=base/"sealed"
        sealed.mkdir(mode=0o700)
        output=sealed/"effect.jsonl"
        output.write_bytes(b"")
        os.chmod(output,0o600)
        channel=public/"broker.sock"
        marker=sealed/"apply_started"
        broker=subprocess.Popen(
            [sys.executable,"-B",__file__,"--server",
             str(channel),str(output),str(marker)],
            stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        try:
            deadline=time.monotonic()+6
            while not channel.exists():
                assert broker.poll() is None, "broker unexpectedly exited"
                assert time.monotonic()<deadline, "broker startup timeout"
                time.sleep(0.005)
            first=attack_as_unprivileged(channel,output,nobody)
            assert first["hold"]=={"ok":False,"reason":"not-authorized-to-hold"}
            assert first["apply"]["ok"] is True
            assert all(first[k]=="DENIED" for k in
                       ("append","truncate","chmod","unlink"))
            assert len(records(output))==1
            print("PASS Linux DAC denies direct outsider writes; pre-HOLD broker request succeeds")
            print("PASS outsider cannot issue root-authorized HOLD")

            delayed=[]
            t=threading.Thread(target=lambda:delayed.append(
                call(channel,{"op":"apply","value":"in-flight","delay":True})))
            t.start()
            deadline=time.monotonic()+6
            while not marker.exists():
                assert time.monotonic()<deadline, "in-flight command timeout"
                time.sleep(0.002)
            hold=call(channel,{"op":"hold"})
            t.join(6)
            assert not t.is_alive() and len(delayed)==1
            assert delayed[0]["ok"] is True and hold["ok"] is True
            assert delayed[0]["commit_ns"]<hold["hold_ack_ns"]
            assert len(records(output))==2
            print("PASS in-flight broker effect committed before HOLD acknowledgement")

            snapshot=output.read_bytes()
            assert call(channel,{"op":"apply","value":"after-hold"})=={
                "ok":False,"reason":"held"}
            second=attack_as_unprivileged(channel,output,nobody)
            assert second["apply"]=={"ok":False,"reason":"held"}
            assert all(second[k]=="DENIED" for k in
                       ("append","truncate","chmod","unlink"))
            assert output.read_bytes()==snapshot
            print("PASS post-HOLD cooperative effects and outsider direct writes both denied")

            # Root is INSIDE the trusted computing base. Deliberately
            # show it can change the file despite the held broker.
            with open(output,"ab") as f:
                f.write(b'{"value":"privileged-root-bypass"}\n')
                f.flush()
                os.fsync(f.fileno())
            assert output.read_bytes()!=snapshot
            assert records(output)[-1]["value"]=="privileged-root-bypass"
            print("PASS NEGATIVE CONTROL privileged root writer BYPASSES broker HOLD")
            print("OS AUTHORITY SCOPE: one unprivileged identity, one temp file, Linux DAC")
            print("UNIVERSAL PHYSICAL X3 / privileged-root non-bypass: NOT ESTABLISHED")
        finally:
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
            if broker.returncode!=0:
                raise AssertionError(
                    "broker failed: "+stderr.decode(errors="replace"))


if __name__=="__main__":
    if len(sys.argv)>1 and sys.argv[1]=="--server":
        server(*sys.argv[2:])
    else:
        run()
