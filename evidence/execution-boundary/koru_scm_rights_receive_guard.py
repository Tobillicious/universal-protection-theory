"""Strict one-message Unix socket receiver: reject all ancillary capabilities.

The receiver uses recvmsg() rather than silently ignoring SCM_RIGHTS. If any
ancillary data or truncation occurs, it closes every delivered file descriptor
before denying the request. The caller must use ONLY this receiver on its
specific socket and must not expose other receive paths. A compromised parent,
another socket, or ptrace is outside this research-only interface.

One recvmsg call is deliberately limited to datagram/seqpacket message
boundaries; DO NOT use for arbitrary byte-stream framing.
"""
import array
import os
import socket


def recv_payload_without_rights(sock, *, max_payload=512, max_fds=16):
    """Receive one atomic Unix datagram/seqpacket, or raise PermissionError.

    Caller is responsible for authenticating the peer and interpreting only
    an explicitly allowed payload schema. This is NOT a generic transport.
    """
    if (not isinstance(sock,socket.socket) or
            sock.family != socket.AF_UNIX or
            sock.type & 0xf not in (socket.SOCK_DGRAM,socket.SOCK_SEQPACKET) or
            type(max_payload) is not int or not 0<max_payload<=4096 or
            type(max_fds) is not int or not 0<max_fds<=64):
        raise ValueError("bounded Unix datagram/seqpacket socket required")
    capacity=socket.CMSG_SPACE(max_fds*array.array("i").itemsize)
    data, ancillaries, flags, _addr=sock.recvmsg(
        max_payload+1,capacity,getattr(socket,"MSG_CMSG_CLOEXEC",0))
    # ALWAYS dispose rights BEFORE examining credentials/payload. Malformed
    # SCM_RIGHTS payloads must never leak valid kernel-installed descriptors.
    for level, kind, payload in ancillaries:
        if level==socket.SOL_SOCKET and kind==socket.SCM_RIGHTS:
            fd_size=array.array("i").itemsize
            received=array.array("i")
            received.frombytes(payload[:len(payload)//fd_size*fd_size])
            for fd in received:
                try:
                    os.close(fd)
                except OSError:
                    pass
    if (ancillaries or flags & (socket.MSG_TRUNC|socket.MSG_CTRUNC) or
            not data or len(data)>max_payload):
        raise PermissionError("ancillary capability or malformed message denied")
    return data
