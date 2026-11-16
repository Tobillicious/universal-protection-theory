"""G3-A08: independent regressions for HOLD restart persistence and DAC floods.

Disposable cross-UID Linux fixture. No production workload or trusted
signing credentials. The emergency socket and ordinary service share one DB.
"""
import json
import os
from pathlib import Path
import select
import socket
import subprocess
import sys
import time
import unittest

import test_koru_authority_owned_marker_service as base
import test_koru_emergency_hold_endpoint as prior


UNTRUSTED_BURST = r"""
import socket,sys
path=sys.argv[1]
denied=0
succeeded=0
for _ in range(120):
    with socket.socket(socket.AF_UNIX,socket.SOCK_STREAM) as s:
        s.settimeout(.3)
        try:
            s.connect(path)
        except (PermissionError,OSError):
            denied+=1
        else:
            succeeded+=1
print(f"{denied} {succeeded}",flush=True)
"""


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable Linux fixture with distinct real UIDs")
class EmergencyHoldPersistenceTests(unittest.TestCase):
    def setUp(self):
        self.case = prior.EmergencyHoldSocketTests(
            methodName="test_socket_acl_is_controller_group_only")
        self.case.setUp()

    def tearDown(self):
        self.case.tearDown()

    def _controller_hold(self):
        return self.case.ask(base.CONTROLLER, self.case.emergency, "hold")

    def _restart_dual_authority(self):
        f = self.case.f
        f.stop()
        path = Path(self.case.emergency)
        if path.exists():
            path.unlink()
        f.server = subprocess.Popen(
            [sys.executable, "-B", "-c", prior.DUAL_SERVER,
             f.sock, self.case.emergency, str(f.db), str(f.marker)],
            preexec_fn=base.drop(base.AUTH), cwd="/", env=f.env,
            stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True)
        ready, _, _ = select.select([f.server.stdout], [], [], 5)
        self.assertTrue(ready, "restarted dual authority not ready")
        self.assertEqual(f.server.stdout.readline().strip(), "READY")

    def test_emergency_hold_persists_across_dual_listener_restart(self):
        f = self.case.f
        self.assertFalse(base.TransactionalHoldWitness(str(f.db)).read()["held"])
        self.assertEqual(self._controller_hold()["code"], "hold_recorded")
        self.assertTrue(base.TransactionalHoldWitness(str(f.db)).read()["held"])
        self._restart_dual_authority()
        self.assertTrue(base.TransactionalHoldWitness(str(f.db)).read()["held"])
        response = f.ask(base.EXECUTOR, "fixed_marker")
        self.assertEqual(response["code"], "authority_denied")
        self.assertFalse(list(f.marker.iterdir()))

    def test_untrusted_socket_burst_rejected_before_accept(self):
        f = self.case.f
        started = time.monotonic()
        proc = subprocess.run(
            [sys.executable, "-B", "-c", UNTRUSTED_BURST,
             self.case.emergency],
            preexec_fn=base.drop(base.EXECUTOR), env=f.env, cwd="/",
            capture_output=True, text=True, timeout=10)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        counts = tuple(int(n) for n in proc.stdout.split())
        self.assertEqual(counts, (120, 0),
                         "unprivileged executor reached control socket")
        self.assertLess(time.monotonic() - started, 10.0)
        self.assertFalse(base.TransactionalHoldWitness(str(f.db)).read()["held"])
        self.assertFalse(list(f.marker.iterdir()))
        started = time.monotonic()
        self.assertEqual(self._controller_hold()["code"], "hold_recorded")
        self.assertLess(time.monotonic() - started, 2.0)
        self.assertTrue(base.TransactionalHoldWitness(str(f.db)).read()["held"])


if __name__ == "__main__":
    unittest.main()
