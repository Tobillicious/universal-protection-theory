#!/usr/bin/env python3
"""IR-134: actual patched software sink versus out-of-process direct writer.

Only a TEMPORARY source-matched Mac/Linux reference runtime is exercised.
Demonstrates:
  - a cooperating sink refuses application after acknowledged HOLD;
  - an independent process can STILL alter the exact same sink.log path
    without taking its cooperative application lock.

This is evidence of a software isolation G A P, NOT a physical apparatus
test and NOT a technique to write to arbitrary third-party systems.
"""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time

from source_hold_integration import WRAPPER, wait_for, set_hold, SRC
from common import rpc, read_lines


RAW_APPENDER = r"""
import json, os, sys, time
path = sys.argv[1]
payload = {"id": 54321, "value": 11, "source": "independent-writer",
           "t": time.time(), "audit_fixture": "UNAUTHORIZED"}
with open(path, "a", encoding="utf-8") as f:
    f.write(json.dumps(payload, sort_keys=True) + "\n")
    f.flush()
    os.fsync(f.fileno())
"""


def run():
    with tempfile.TemporaryDirectory(prefix="ir134-no-bypass-") as folder:
        run_path = Path(folder)
        child = subprocess.Popen(
            [sys.executable, "-B", "-c", WRAPPER,
             str(run_path), str(SRC / "sink.py")],
            cwd=SRC,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        try:
            wait_for(run_path / "sink.sock", timeout=8)
            # Seed the same effect path using the legitimate application gate.
            normal = rpc(str(run_path / "sink.sock"),
                         {"op": "deliver", "id": 1, "value": 7})
            assert normal == {"ok": True, "dup": False}, normal
            before = read_lines(str(run_path / "sink.log"))
            assert len(before) == 1 and before[0]["id"] == 1

            hold_ack, hold_latency = set_hold(str(run_path), True)
            refused = rpc(str(run_path / "sink.sock"),
                          {"op": "deliver", "id": 2, "value": 9})
            assert refused == {"ok": False, "held": True}, refused
            assert read_lines(str(run_path / "sink.log")) == before

            # Critically, independent of the sink application guard.
            # This process directly opens the SAME physical filesystem path.
            time.sleep(0.015)
            subprocess.run(
                [sys.executable, "-B", "-c", RAW_APPENDER,
                 str(run_path / "sink.log")],
                cwd=SRC, check=True, timeout=7
            )
            after = read_lines(str(run_path / "sink.log"))
            assert len(after) == 2
            assert after[0] == before[0]
            assert after[1]["id"] == 54321
            assert after[1]["source"] == "independent-writer"
            assert after[1]["t"] > hold_ack
            assert (run_path / "HOLD").is_file()

            # A software-level HOLD acknowledgement is authentic for the
            # cooperative sink but INVALID as a universal write fence.
            print("PASS patched sink refuses effect after HOLD acknowledgement")
            print("PASS direct independent process modifies SAME sink.log after HOLD")
            print("PASS held source state persists despite out-of-process bypass")
            print("HOLD source acknowledgement lag (test): %.6fs" % hold_latency)
            print("SOURCE-ONLY NO-BYPASS CERTIFICATE: FAIL (correctly identified)")
            print("IR134 actual OS/hardware output authority: OPEN")
        finally:
            child.terminate()
            try:
                _, stderr = child.communicate(timeout=5)
            except subprocess.TimeoutExpired:
                child.kill()
                _, stderr = child.communicate()
            if child.returncode not in (0, -15):
                print("patched sink stderr:",
                      stderr.decode(errors="replace"), file=sys.stderr)
                raise AssertionError("sink subprocess unexpectedly failed")


if __name__ == "__main__":
    run()
