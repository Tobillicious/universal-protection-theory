#!/usr/bin/env python3
"""SYNTHETIC REGRESSION ONLY — enacted-mediation bypass detection fixture.

Minimal synthetic demonstration of the witness *mechanism* required by the
enacted-mediation crosswalk (EW-1/EW-2 rows): a controller that logs HOLD
while a queued effect completes through a separate descriptor path, and an
INDEPENDENT observer channel reading a surface the controller does not write.
The observer must detect the bypass the self-reported log conceals.

This fixture is NOT physical BCRD evidence, NOT an installation, and must
never be cited as either. It verifies that the proposed witness class
(independent channel vs self-reporting log) detects the HC-1 bypass class
in a model.
"""
import os
import sys
import tempfile

SYNTHETIC_REGRESSION_ONLY = True


class Controller:
    """Synthetic controller: selects HOLD and records it in its own log."""

    def __init__(self, protected_path):
        self.protected_path = protected_path
        self.log = []          # controller's self-reported log (not evidence)
        self.inherited_fds = []  # descriptors inherited by helpers: bypass risk

    def classify_hold(self, request):
        self.log.append(("HOLD", request))
        return "HOLD"

    def delegate_helper(self, request):
        # The actor helper receives an inherited writable descriptor —
        # the IR-136 bypass class, modelled.
        fd = os.open(self.protected_path, os.O_WRONLY)
        self.inherited_fds.append(fd)
        return fd

    def log_summary(self):
        return [entry[0] for entry in self.log]


class IndependentObserver:
    """Observer in a distinct channel: reads the durable surface itself.

    It does not consult the controller log, by construction.
    """

    def __init__(self, protected_path):
        self.protected_path = protected_path

    def read_surface_digest(self):
        with open(self.protected_path, "rb") as f:
            return f.read()


def run_scenario():
    with tempfile.TemporaryDirectory() as tmp:
        surface = os.path.join(tmp, "protected_surface")
        with open(surface, "wb") as f:
            f.write(b"CLEAN-STATE")

        controller = Controller(surface)
        observer = IndependentObserver(surface)

        baseline = observer.read_surface_digest()

        # 1. Controller classifies the request as HOLD and logs it.
        controller.classify_hold("request-1")

        # 2. A helper holding an inherited descriptor completes the queued
        #    effect anyway (the bypass). The controller log still says HOLD.
        fd = controller.delegate_helper("request-1")
        os.write(fd, b"QUEUED-EFFECT-LANDED")
        os.fsync(fd)
        os.close(fd)

        # 3. The controller's own log (alone) reports no effect.
        assert controller.log_summary() == ["HOLD"], "scenario broken: log should show only HOLD"

        # 4. The independent observer channel sees the durable change.
        after = observer.read_surface_digest()
        bypass_detected = after != baseline

        assert bypass_detected, "witness failed: independent channel missed the bypass"
        print("SCENARIO: HOLD acknowledged in controller log; queued effect landed on the protected surface")
        print("DETECTION: independent observer channel detected the durable change the log concealed")
        print("SCOPE: SYNTHETIC_REGRESSION_ONLY — demonstrates the EW-1/EW-2 witness mechanism; not physical evidence")
        return 0


if __name__ == "__main__":
    sys.exit(run_scenario())
