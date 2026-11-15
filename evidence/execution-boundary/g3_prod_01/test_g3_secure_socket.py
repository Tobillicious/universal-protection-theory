"""Research tests for secure IPC wiring and real separate-UID signed requests."""
import json
import os
from pathlib import Path
import socket
import subprocess
import sys
import threading
import unittest

from g3_monitor import Store
from g3_secure_socket import SignedFencedServer
from test_g3_signed_bridge import SignedBridgeTests


class SecureSocketTests(unittest.TestCase):
    setUp = SignedBridgeTests.setUp
    tearDown = SignedBridgeTests.tearDown
    lease = SignedBridgeTests.lease
    request = SignedBridgeTests.request

    def test_bare_store_cannot_be_served(self):
        bare = Store(str(self.root/'bad.sqlite'),self.out)
        try:
            with self.assertRaises(TypeError):
                SignedFencedServer(str(self.root/'bad.sock'),bare,{65534})
        finally:
            bare.close()

    def test_same_uid_or_root_client_denied_at_configuration(self):
        for uids in ({os.geteuid()}, {0}, set(), {True}):
            with self.subTest(uids=uids):
                with self.assertRaises(ValueError):
                    SignedFencedServer(str(self.root/'bad.sock'),self.writer,uids)

    def test_reject_guest_writable_socket_parent(self):
        bad = self.root/'unsafe-sockets'
        bad.mkdir(mode=0o700)
        os.chmod(bad,0o777)
        try:
            with self.assertRaises(PermissionError):
                SignedFencedServer(str(bad/'signed.sock'),self.writer,{65534})
            self.assertFalse((bad/'signed.sock').exists())
        finally:
            os.chmod(bad,0o700)

    def test_reject_preexisting_socket_path(self):
        existing=self.root/'existing.sock'
        existing.write_text('not-a-socket')
        with self.assertRaises(FileExistsError):
            SignedFencedServer(str(existing),self.writer,{65534})
        self.assertEqual(existing.read_text(),'not-a-socket')

    def test_reject_symlinked_socket_parent(self):
        real=self.root/'safe-parent'
        real.mkdir(mode=0o700)
        link=self.root/'socket-alias'
        link.symlink_to(real,target_is_directory=True)
        with self.assertRaises(OSError):
            SignedFencedServer(str(link/'signed.sock'),self.writer,{65534})
        self.assertFalse((real/'signed.sock').exists())

    def test_separate_uid_socket_signed_and_unsigned_requests(self):
        if sys.platform!='linux' or os.geteuid()!=0:
            self.skipTest('disposable root Linux runner required')
        self.lease()
        sock=str(self.root/'signed.sock')
        server=SignedFencedServer(sock,self.writer,{65534})
        # Test host grants only the guest group access to the socket.
        # The protected HTML directory remains private to the writer UID.
        os.chmod(self.root,0o711)
        os.chown(sock,-1,65534)
        os.chmod(sock,0o660)
        thread=threading.Thread(target=server.serve_forever,daemon=True)
        thread.start()
        child_code=r'''
import json,sys,socket
path=sys.argv[1]
assert __import__('os').geteuid()==65534
data=json.loads(sys.stdin.read())
with socket.socket(socket.AF_UNIX) as client:
    client.settimeout(5)
    client.connect(path)
    client.sendall(json.dumps(data,sort_keys=True,separators=(',',':')).encode()+bytes([10]))
    received=b''
    while not received.endswith(bytes([10])):
        fragment=client.recv(4096)
        if not fragment:break
        received+=fragment
print(received.decode().strip())
'''
        def drop():
            os.setgroups([])
            os.setgid(65534)
            os.setuid(65534)
        def call(payload):
            result=subprocess.run(
                [sys.executable,'-B','-c',child_code,sock],
                input=json.dumps(payload),capture_output=True,text=True,
                preexec_fn=drop,timeout=12)
            self.assertEqual(result.returncode,0,result.stderr)
            return json.loads(result.stdout)
        try:
            signed=self.request()
            unsigned={k:signed[k] for k in ('op','id','html','epoch')}
            self.assertEqual(call(unsigned)['code'],'signed_envelope_required')
            self.assertEqual(self.gate.effect_count(),0)
            self.assertEqual(list(self.out.iterdir()),[])
            self.assertEqual(call(signed)['code'],'committed')
            self.assertEqual(self.gate.effect_count(),1)
            self.assertEqual(len(list(self.out.iterdir())),1)
            self.assertEqual(call(signed)['code'],'mesh_nonce_replay')
            self.assertEqual(len(list(self.out.iterdir())),1)
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=5)
            self.assertFalse(thread.is_alive())


if __name__=='__main__':
    unittest.main()
