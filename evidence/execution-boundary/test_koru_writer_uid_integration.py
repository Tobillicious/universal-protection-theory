"""Disposable Linux DAC integration test: three genuinely distinct UIDs.

SECURITY LIMIT: fixture policy accepts one hardcoded test event, NOT a signed
permit. This proves peer-UID / directory mediation, not signed G3 enactment.
Run only inside an ephemeral privileged CI worker; no service installation.
"""
import hashlib
import json
import os
import shutil
from pathlib import Path
import socket
import subprocess
import sys
import tempfile
import time
import unittest

WRITER_UID = 65532
BROKER_UID = 65533
GUEST_UID = 65534
EVENT_ID = "fixture-only"

SERVER_SCRIPT = """
import os
import sys
from koru_isolated_marker_writer import IsolatedMarkerWriter
server = IsolatedMarkerWriter(
    sys.argv[1], sys.argv[2], broker_uid=int(sys.argv[3]),
    authorize=lambda event_id: event_id == "fixture-only")
print("READY", flush=True)
try:
    server.serve_forever(poll_interval=0.05)
finally:
    server.server_close()
"""

CLIENT_SCRIPT = """
import json, os, socket, sys
path, op, event_id = sys.argv[1:]
with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.settimeout(3)
    sock.connect(path)
    sock.sendall((json.dumps({"op": op, "event_id": event_id}) + "\\n").encode())
    data = b""
    while not data.endswith(b"\\n"):
        part = sock.recv(4096)
        if not part: break
        data += part
print(data.decode())
"""

DIRECT_WRITE_SCRIPT = """
import os, sys
os.open(sys.argv[1], os.O_CREAT | os.O_WRONLY | os.O_EXCL, 0o600)
"""


def drop_to(uid):
    def apply():
        os.setgroups([])
        os.setgid(uid)
        os.setuid(uid)
    return apply


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "ephemeral Linux root CI only")
class IsolatedWriterPrincipalIntegration(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-writer-uid-")
        self.base = Path(self.tmp.name)
        # Entrypoint pathname accessible to other UIDs; marker dir is not.
        self.base.chmod(0o711)
        os.chown(self.base, WRITER_UID, WRITER_UID)
        self.marker_dir = self.base / "markers"
        self.marker_dir.mkdir(mode=0o700)
        os.chown(self.marker_dir, WRITER_UID, WRITER_UID)
        self.sock = str(self.base / "writer.sock")
        # CI checkout parent directories are intentionally inaccessible to
        # dropped UIDs. Stage only the module in this disposable fixture.
        staged_module = self.base / "koru_isolated_marker_writer.py"
        shutil.copyfile(Path(__file__).with_name("koru_isolated_marker_writer.py"), staged_module)
        staged_module.chmod(0o644)
        env = dict(os.environ, PYTHONDONTWRITEBYTECODE="1",
                   PYTHONPATH=str(self.base))
        self.server = subprocess.Popen(
            [sys.executable, "-B", "-c", SERVER_SCRIPT, self.sock,
             str(self.marker_dir), str(BROKER_UID)],
            env=env, cwd="/", preexec_fn=drop_to(WRITER_UID),
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        deadline = time.monotonic() + 5
        while time.monotonic() < deadline:
            if self.server.poll() is not None:
                break
            if os.path.exists(self.sock) and (os.stat(self.sock).st_mode & 0o777) == 0o666:
                break
            time.sleep(0.025)
        if self.server.poll() is not None or not os.path.exists(self.sock):
            error = self.server.stderr.read() if self.server.poll() is not None else "timeout"
            self.tearDown()
            raise AssertionError(f"writer failed to start: {error}")

    def tearDown(self):
        if getattr(self, "server", None):
            self.server.terminate()
            try:
                self.server.communicate(timeout=3)
            except subprocess.TimeoutExpired:
                self.server.kill()
                self.server.communicate(timeout=3)
            self.server = None
        if getattr(self, "tmp", None):
            self.tmp.cleanup()
            self.tmp = None

    def request(self, uid, op="create_empty_marker", event_id=EVENT_ID):
        proc = subprocess.run(
            [sys.executable, "-B", "-c", CLIENT_SCRIPT,
             self.sock, op, event_id],
            preexec_fn=drop_to(uid), cwd="/", env=os.environ.copy(),
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
            timeout=5)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        return json.loads(proc.stdout)

    def test_independent_writer_and_broker_identities(self):
        marker = self.marker_dir / (
            hashlib.sha256(EVENT_ID.encode()).hexdigest() + ".marker")
        # Other UIDs cannot directly access writer-owned directory.
        for uid in (BROKER_UID, GUEST_UID):
            direct = subprocess.run(
                [sys.executable, "-B", "-c", DIRECT_WRITE_SCRIPT,
                 str(self.marker_dir / "forged.marker")],
                preexec_fn=drop_to(uid), cwd="/", capture_output=True,
                text=True, timeout=5)
            self.assertNotEqual(direct.returncode, 0)
            self.assertIn("PermissionError", direct.stderr)
        # Even a correctly formatted request from a non-broker UID is denied.
        self.assertEqual(self.request(GUEST_UID)["code"], "peer_denied")
        self.assertFalse(marker.exists())
        # Broker UID is necessary but insufficient: test fixture policy also
        # denies every other event identity.
        self.assertEqual(self.request(BROKER_UID, event_id="unapproved")["code"],
                         "writer_authorization_denied")
        self.assertFalse(marker.exists())
        self.assertEqual(self.request(BROKER_UID)["code"], "empty_marker_created")
        self.assertTrue(marker.is_file())
        self.assertEqual(marker.stat().st_size, 0)
        self.assertEqual(marker.stat().st_uid, WRITER_UID)
        self.assertEqual(self.request(BROKER_UID)["code"],
                         "marker_exists_needs_reconciliation")
        self.assertEqual(len(list(self.marker_dir.iterdir())), 1)


if __name__ == "__main__":
    unittest.main()
