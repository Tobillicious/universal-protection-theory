"""Linux privileged OS-boundary negative control, synthetic effects ONLY.

Run under root in an isolated CI worker. Never execute against production
paths. The root-owned broker and unprivileged child MUST have distinct UIDs.
"""
import hashlib
import json
import os
import pathlib
import pwd
import subprocess
import sys
import tempfile
import threading
import unittest

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_broker import SyntheticBroker, send_request
from koru_ed25519_permit import issue_ed25519
from koru_protected_fs_sink import ProtectedFilesystemSink
from koru_synthetic_effect_gate import SyntheticEffectGate
from test_koru_shadow import fixtures


_CHILD = r'''
import json, os, socket, sys
def send_request(path, op, event, permit, now):
    payload = json.dumps({"op":op,"event":event,"permit":permit},
                         separators=(",", ":")).encode() + b"\n"
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
        s.settimeout(5)
        s.connect(path)
        s.sendall(payload)
        buf = bytearray()
        while not buf.endswith(b"\n"):
            piece = s.recv(4096)
            if not piece or len(buf) + len(piece) > 32768:
                raise ValueError("invalid broker response")
            buf.extend(piece)
    return json.loads(buf)
req = json.loads(sys.stdin.read())
db = req["db"]
denied = False
try:
    fd = os.open(db, os.O_RDWR)
    os.close(fd)
except PermissionError:
    denied = True
r1 = send_request(req["sock"], "admit", req["event"], req["permit"], 10)
r2 = send_request(req["sock"], "dispatch", req["event"], req["permit"], 20)
marker = send_request(req["sock"], "effect_marker", req["event"], req["permit"], 20)
marker_repeat = send_request(req["sock"], "effect_marker", req["event"], req["permit"], 20)
forbidden = send_request(req["sock"], "hold", req["event"], req["permit"], 20)
repeat = send_request(req["sock"], "dispatch", req["event"], req["permit"], 0)
expired = send_request(req["sock"], "effect_marker", req["event"], req["expired"], 0)
# Explicit attempted client-side timestamp override must be rejected.
payload = json.dumps({"op": "effect_marker", "event": req["event"],
                      "permit": req["expired"], "now": 0}).encode() + b"\n"
with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
    s.settimeout(5)
    s.connect(req["sock"])
    s.sendall(payload)
    spoofed = json.loads(s.recv(4096))
print(json.dumps({"db_denied": denied, "admit": r1["code"],
                  "dispatch": r2["code"], "hold": forbidden["code"],
                  "repeat": repeat["code"], "expired": expired["code"],
                  "marker": marker["code"], "marker_repeat": marker_repeat["code"],
                  "spoofed_time": spoofed["code"]}))
'''


class TestLinuxOSPrincipalBoundary(unittest.TestCase):
    def test_distinct_uid_cannot_write_effect_store(self):
        if sys.platform != "linux" or os.geteuid() != 0:
            self.fail("This security test REQUIRES Linux root and a distinct unprivileged UID")
        guest = pwd.getpwnam("nobody")
        if guest.pw_uid == 0:
            self.fail("unsafe guest identity")
        with tempfile.TemporaryDirectory(prefix="koru-os-") as folder:
            os.chmod(folder, 0o755)
            private = pathlib.Path(folder) / "trusted"
            private.mkdir(mode=0o700)
            db = str(private / "events.db")
            effect_dir = private / "actual-marker-effects"
            effect_dir.mkdir(mode=0o700)
            socket_path = str(pathlib.Path(folder) / "broker.sock")
            event, trust = fixtures()
            signing_key = Ed25519PrivateKey.generate()
            permit = issue_ed25519(signing_key, issuer="offline-test-issuer",
                                   event=event, expires_at=100)
            gate = SyntheticEffectGate(
                db, contexts=trust["contexts"], signatures=trust["signatures"],
                witnesses=trust["witnesses"], authorities=trust["authorities"],
                provenances=trust["provenances"], context_ref="ctx-one",
                generation=3, ed25519_public_key=signing_key.public_key(),
                permit_issuer="offline-test-issuer")
            expired_permit = issue_ed25519(
                signing_key, issuer="offline-test-issuer",
                event=event, expires_at=15)
            sink = ProtectedFilesystemSink(gate, str(effect_dir))
            broker = SyntheticBroker(socket_path, gate,
                                     allowed_client_uids={guest.pw_uid},
                                     clock=lambda: 20, effect_sink=sink)
            thread = threading.Thread(target=broker.serve_forever, daemon=True)
            thread.start()
            try:
                # Under the test account, DB directory traversal must be
                # denied even though the specific IPC socket is reachable.
                def drop():
                    os.setgroups([])
                    os.setgid(guest.pw_gid)
                    os.setuid(guest.pw_uid)
                request = dict(db=db, sock=socket_path, event=event,
                               permit=permit, expired=expired_permit)
                proc = subprocess.run(
                    [sys.executable, "-B", "-c", _CHILD],
                    input=json.dumps(request), text=True,
                    capture_output=True, timeout=15, check=False,
                    preexec_fn=drop, cwd=folder,
                    env={})
                self.assertEqual(proc.returncode, 0, proc.stderr)
                result = json.loads(proc.stdout)
                self.assertTrue(result["db_denied"], result)
                self.assertEqual(result["admit"], "durable_synthetic_record")
                self.assertEqual(result["dispatch"], "effect_route_required")
                self.assertEqual(result["hold"], "unsupported_operation")
                self.assertEqual(result["repeat"], "effect_route_required")
                self.assertEqual(result["marker"], "filesystem_marker_applied")
                self.assertEqual(result["marker_repeat"], "marker_already_applied")
                marker_path = effect_dir / (hashlib.sha256(
                    event["event_id"].encode()).hexdigest() + ".marker")
                self.assertTrue(marker_path.is_file())
                self.assertEqual(marker_path.stat().st_size, 0)
                self.assertEqual(len(list(effect_dir.iterdir())), 1)
                self.assertEqual(result["expired"], "invalid_permit_at_effect")
                self.assertEqual(result["spoofed_time"], "bad_request")
                self.assertEqual(gate.effect_count(), 1)
                # The same valid signed event must not execute twice.
                # Even a valid event/permit is refused if caller's Linux UID
                # is not allowlisted. This root test process isn't trusted.
                # The broker may reject the SO_PEERCRED peer and close the
                # stream before the client's sendall completes. Linux can
                # report EPIPE/ECONNRESET instead of delivering peer_denied.
                # Both are rejection, but neither may execute an effect.
                try:
                    wrong_peer = send_request(
                        socket_path, "dispatch", event, permit, 0)
                except (BrokenPipeError, ConnectionResetError):
                    wrong_peer = None
                if wrong_peer is not None:
                    self.assertEqual(wrong_peer["code"], "peer_denied")
                self.assertEqual(gate.effect_count(), 1)
            finally:
                broker.shutdown()
                broker.server_close()
                thread.join(timeout=5)
                sink.close()
                gate.close()


if __name__ == "__main__":
    unittest.main()
