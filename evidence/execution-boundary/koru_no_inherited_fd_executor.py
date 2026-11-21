"""Research-only fixed executor launcher that closes inherited descriptors.

A DAC-private marker directory is insufficient if a trusted process hands
an untrusted client a previously opened WRITEABLE FILE descriptor. This
launcher has no pass_fds interface; the child gets only its stdio pipes,
a fixed-scheme authority-socket request, and no inherited parent FDs.

A privileged parent, injected ptrace, SCM_RIGHTS descriptor transfer after
launch, or arbitrary external effects defeat this small same-host fixture.
Do NOT treat this as OS-wide mandatory confinement or production launcher.
"""
import json
import os
import subprocess
import sys

_CHILD = r"""
import json,socket,struct,sys
from pathlib import Path
sockpath, trusted_uid = sys.argv[1], int(sys.argv[2])
with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.settimeout(3)
    sock.connect(sockpath)
    peer=sock.getsockopt(socket.SOL_SOCKET,socket.SO_PEERCRED,
                         struct.calcsize("3i"))
    _,uid,_=struct.unpack("3i",peer)
    if uid != trusted_uid:
        raise PermissionError("authority UID mismatch")
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
                                 timeout=6):
    """Fixed operation only; close all inherited FDs before identity drop.

    Caller must independently provision the authority socket and UIDs.
    No arbitrary command, user-supplied callback, inherited file descriptor
    list, shell expansion, or fallback to direct writes is supported.
    """
    if (type(socket_path) is not str or not os.path.isabs(socket_path) or
            type(executor_uid) is not int or executor_uid <= 0 or
            type(authority_uid) is not int or authority_uid <= 0 or
            executor_uid == authority_uid):
        raise ValueError("canonical authority socket and distinct UIDs required")
    def drop_to_executor():
        os.setgroups([])
        os.setgid(executor_uid)
        os.setuid(executor_uid)
    proc=subprocess.run(
        [sys.executable,"-B","-c",_CHILD,socket_path,str(authority_uid)],
        preexec_fn=drop_to_executor,close_fds=True,pass_fds=(),
        stdin=subprocess.DEVNULL,capture_output=True,text=True,
        env={"PATH":"/usr/local/bin:/usr/bin:/bin",
             "PYTHONDONTWRITEBYTECODE":"1"},
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
