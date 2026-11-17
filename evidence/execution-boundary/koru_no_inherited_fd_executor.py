"""Research-only fixed executor launcher that closes inherited descriptors.

A DAC-private marker directory is insufficient if a trusted process hands
an untrusted client a previously opened WRITEABLE FILE descriptor. This
launcher has no pass_fds interface; the child gets only its stdio pipes,
a fixed-scheme authority-socket request, and no inherited parent FDs. A single connected authority socket is
created by the dropped-UID child and audited before kernel confinement.

A privileged parent, injected ptrace, SCM_RIGHTS descriptor transfer after
launch, or arbitrary external effects defeat this small same-host fixture.
Do NOT treat this as OS-wide mandatory confinement or production launcher.
"""
import json
import os
import subprocess
import sys
from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE
from koru_landlock_write_fence import LANDLOCK_CHILD_CODE
from koru_executor_fd_startup_audit import FD_AUDIT_CHILD_CODE

_CHILD = r"""
import json,socket,struct,sys
from pathlib import Path
sockpath, trusted_uid, trusted_pid = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
_assert_no_ambient_fds()
_install_write_deny_landlock()
# Connect as the dropped EXECUTOR identity before confining new IPC.
# No protected-effect request, subprocess, or user callback occurs until
# after peer verification and the kernel socket/connect deny fence.
with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.settimeout(3)
    sock.connect(sockpath)
    peer=sock.getsockopt(socket.SOL_SOCKET,socket.SO_PEERCRED,
                         struct.calcsize("3i"))
    pid,uid,_=struct.unpack("3i",peer)
    if uid != trusted_uid or pid != trusted_pid:
        raise PermissionError("authority process identity mismatch")
    # Audit the sole newly connected descriptor; startup audit above already
    # rejected all ambient descriptors. Do not proceed with an extra live FD.
    active=[]
    for entry in __import__("os").listdir("/proc/self/fd"):
        if not entry.isdecimal():
            raise RuntimeError("invalid fd inventory")
        value=int(entry)
        if value<=2:
            continue
        try:
            __import__("os").fstat(value)
        except OSError as error:
            if error.errno==9:
                continue
            raise
        active.append(value)
    if active != [sock.fileno()]:
        raise PermissionError("unexpected live descriptor at authority handoff")
    _deny_fd_receive_syscalls(deny_new_connections=True)
    sock.sendall(b'{"op":"fixed_marker"}\n')
    raw=bytearray()
    while not raw.endswith(b"\n"):
        piece=sock.recv(1024)
        if not piece or len(raw)+len(piece)>2048:
            raise ValueError("incomplete authority reply")
        raw.extend(piece)
response=json.loads(raw)
if (type(response) is not dict or set(response)!={"ok","code"} or
        type(response["ok"]) is not bool or type(response["code"]) is not str):
    raise ValueError("bad authority response")
print(json.dumps(response,sort_keys=True),flush=True)
"""


def launch_fixed_executor_client(socket_path, *, executor_uid, authority_uid,
                                 authority_pid=None, timeout=6):
    """Fixed operation only; close all inherited FDs before identity drop.

    Trusted launcher MUST independently provision socket, UIDs and an observed
    live authority PID. This narrows same-UID impersonation only; PID reuse,
    compromised provisioner and arbitrary AF_UNIX connect remain outside scope.
    No arbitrary command, user-supplied callback, inherited file descriptor
    list, shell expansion, or fallback to direct writes is supported.
    """
    if (type(socket_path) is not str or not os.path.isabs(socket_path) or
            type(executor_uid) is not int or executor_uid <= 0 or
            type(authority_uid) is not int or authority_uid <= 0 or
            executor_uid == authority_uid or
            type(authority_pid) is not int or authority_pid <= 1):
        raise ValueError("canonical authority socket and distinct UIDs required")
    def drop_to_executor():
        os.setgroups([])
        os.setgid(executor_uid)
        os.setuid(executor_uid)
    # -S: no `site` import, so no .pth code runs before the kernel fence.
    # -I: ignore PYTHON* environment and user site. The child needs stdlib only.
    # HOME: without it, `import ctypes` resolves the user through NSS and
    # contacts nscd/userdb BEFORE the fence (measured: 2 AF_UNIX connects).
    proc=subprocess.run(
        [sys.executable,"-B","-I","-S","-c",FD_AUDIT_CHILD_CODE+"\n"+LANDLOCK_CHILD_CODE+"\n"+SECCOMP_CHILD_CODE+"\n"+_CHILD,
         socket_path,str(authority_uid),str(authority_pid)],
        preexec_fn=drop_to_executor,close_fds=True,pass_fds=(),
        stdin=subprocess.DEVNULL,capture_output=True,text=True,
        env={"PATH":"/usr/local/bin:/usr/bin:/bin",
             "PYTHONDONTWRITEBYTECODE":"1",
             "HOME":"/nonexistent"},
        cwd="/",timeout=timeout,check=False)
    if proc.returncode!=0:
        return {"ok":False,"code":"authority_unavailable_or_uncertain"}
    try:
        result=json.loads(proc.stdout)
        if (type(result) is not dict or set(result)!={"ok","code"} or
                type(result["ok"]) is not bool or
                type(result["code"]) is not str):
            raise ValueError("bad result")
        return result
    except (ValueError,TypeError):
        return {"ok":False,"code":"authority_unavailable_or_uncertain"}
