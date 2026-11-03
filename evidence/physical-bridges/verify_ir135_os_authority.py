#!/usr/bin/env python3
"""IR-135 scope/promotion gate, NOT external hardware verification."""
import copy
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
LEDGER = ROOT / "ir135-os-authority-ledger.json"
LEAN = ROOT / "PhysicalBridges" / "IR135PrincipalAuthorityBoundary.lean"
PROBE = ROOT / "check_ir135_os_authority.py"
REQUIRED = {
    "schema_version": 1,
    "lean_theorem": "PhysicalBridges.IR135.all_finite_principal_scoped_held_traces",
    "source_status": "CONDITIONAL_FINITE_ACTOR_TRACES",
    "test_scope": "DISPOSABLE_LINUX_DAC_BROKER_ONE_FILE_ONE_UNPRIVILEGED_UID",
    "physically_independent_installation": "OPEN_EXTERNAL",
    "complete_physical_x3": "OPEN",
}
OBSERVATIONS = {
    "before_hold": "UNPRIVILEGED_MAY_REQUEST_BROKER_APPLY_DIRECT_FILE_DENIED",
    "hold_linearization": "BROKER_COMMIT_PRECEDES_HOLD_ACK",
    "after_hold": "BROKER_DENIES_AND_UNPRIVILEGED_DIRECT_FILE_WRITES_DENIED",
    "trusted_root": "ROOT_BYPASS_POSSIBLE_DEMONSTRATED",
}
LEAN_ANCHORS = (
    "PrincipalEffectAuthority", "untrustedSourceUnchanged",
    "untrustedEffectUnchanged", "trustedStepRefined",
    "trustedEffectAccounted", "held_actual_principal_step_bound",
    "all_finite_principal_scoped_held_traces",
    "untrusted_denial_does_not_restrict_trusted_bypass",
)
PROBE_ANCHORS = (
    "SO_PEERCRED", "os.setuid", "os.setgid", "os.O_NOFOLLOW",
    "os.fsync", "privileged-root-bypass", "hold_ack_ns",
)

def verify(data, lean, probe):
    for field, expected in REQUIRED.items():
        if data.get(field) != expected:
            raise ValueError("unsupported promotion or changed scope: " + field)
    if data.get("observations") != OBSERVATIONS:
        raise ValueError("missing trusted-root bypass / changed observation")
    limits = data.get("scope_bounds")
    if not isinstance(limits, dict):
        raise ValueError("missing boundaries")
    for name in ("admitted_unprivileged_principal", "trusted_authority",
                 "effect_resource", "hold_guarantee", "environment"):
        if not isinstance(limits.get(name), str) or not limits[name]:
            raise ValueError("missing bounded resource/actor: " + name)
    open_items = data.get("unclosed")
    if not isinstance(open_items, list) or len(open_items) < 6 or not all(
        isinstance(s, str) and s for s in open_items
    ):
        raise ValueError("external proof obligations silently removed")
    for anchor in LEAN_ANCHORS:
        if anchor not in lean:
            raise ValueError("missing Lean proof/countermodel: " + anchor)
    for anchor in PROBE_ANCHORS:
        if anchor not in probe:
            raise ValueError("OS identity probe missing: " + anchor)
    return len(open_items)

def adversarial_checks(data, lean, probe):
    def must_fail(modified, label, l=lean, p=probe):
        try:
            verify(modified, l, p)
        except ValueError:
            return
        raise AssertionError("scope gate FAIL-OPEN: " + label)
    for field, value, label in (
        ("complete_physical_x3", "PROVED", "universal X3"),
        ("physically_independent_installation", "VERIFIED", "physical installation"),
        ("test_scope", "ALL_PHYSICAL_ACTORS", "universal actor promotion"),
        ("source_status", "PHYSICALLY_PROVED", "conditional proof promotion"),
    ):
        v = copy.deepcopy(data)
        v[field] = value
        must_fail(v, label)
    v = copy.deepcopy(data)
    del v["observations"]["trusted_root"]
    must_fail(v, "hidden privileged bypass")
    v = copy.deepcopy(data)
    del v["scope_bounds"]["trusted_authority"]
    must_fail(v, "unbounded privileged trusted set")
    v = copy.deepcopy(data)
    v["unclosed"] = []
    must_fail(v, "deleted external requirements")
    must_fail(data, "Lean counterexample removed",
              l=lean.replace("untrusted_denial_does_not_restrict_trusted_bypass", "deleted"))
    must_fail(data, "root bypass probe removed",
              p=probe.replace("privileged-root-bypass", "deleted"))

def main():
    data = json.loads(LEDGER.read_text())
    count = verify(data, LEAN.read_text(), PROBE.read_text())
    adversarial_checks(data, LEAN.read_text(), PROBE.read_text())
    print("IR135 limited OS-DAC certificate: one UID / temp file / Linux fixture")
    print("ROOT-EQUIVALENT ACTORS STILL BYPASS HOLD: explicitly witnessed")
    print("Full physical UPT/X3 and independent installation: OPEN")
    print("Unclosed external conditions:", count)
    print("Nine false-promotion and missing-premise negative controls: PASS")

if __name__ == "__main__":
    main()
