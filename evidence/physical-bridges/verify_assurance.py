#!/usr/bin/env python3
"""Enforce evidence-backed claim promotion; fail closed, no network requests.
NOT a verifier that evidence is substantively authentic or scientifically valid.
"""
import json
import re
from pathlib import Path

ALLOWED = {
    "OPEN", "DECLARED", "FORMALLY_CHECKED", "MEASURED", "INDEPENDENTLY_REPLICATED"
}
PHYSICAL = {"physical", "semantic", "synthetic", "formal"}
PROOFS = {"FORMALLY_CHECKED"}
ROOT = Path(__file__).resolve().parent
ROOT_IMPORTS = set((ROOT / "PhysicalBridges.lean").read_text(encoding="utf-8").splitlines())
EVIDENCE_STATUSES = {"MEASURED", "INDEPENDENTLY_REPLICATED"}
REQUIRED_PHYSICAL = {
    "channel_inventory_actual_completeness",
    "physical_event_residual_calibration",
    "physical_nonzeno_clock",
    "real_escrow_debit_mediation",
    "sensor_error_bound_actual",
    "actual_plant_belief_viability",
    "historical_subject_continuity_actual",
    "physical_instrument_deployed",
    "physical_actuator_admission_atomicity",
    "physical_inflight_queue_coverage",
    "physical_apply_time_epoch_enforcement",
    "physical_durable_epoch_recovery",
    "physical_progress_rank_certified",
    "physical_actual_service_delivery",
    "semantic_full_original_freedoms_realised",
    "physical_authoritative_committed_event_timestamps",
    "physical_max_interstep_service_latency",
    "physical_measured_stall_budget",
    "physical_productive_event_classifier",
    "physical_required_event_completion_certificate",
}

def inspect(data):
    assert data.get("schema_version") == 1, "Unsupported assurance ledger schema"
    entries = data.get("claims")
    assert isinstance(entries, list) and entries, "Claims must be nonempty"
    found = set()
    for c in entries:
        name = c.get("id")
        assert isinstance(name, str) and name and name not in found, "Duplicate/invalid id"
        found.add(name)
        scope, status = c.get("scope"), c.get("status")
        assert scope in PHYSICAL and status in ALLOWED, f"{name}: invalid scope/status"
        assert isinstance(c.get("assumptions"), list), f"{name}: missing assumptions"
        evidence = c.get("evidence")
        assert isinstance(evidence, list), f"{name}: evidence must be a list"
        if status in PROOFS:
            assert isinstance(c.get("module"), str) and c["module"].startswith("PhysicalBridges."), (
                f"{name}: formal proof requires checked module reference"
            )
            assert scope in ("formal", "synthetic"), (
                f"{name}: conditional formal theorem cannot certify physical/semantic fact"
            )
            module = c["module"]
            assert re.fullmatch(r"PhysicalBridges\.[A-Za-z][A-Za-z0-9_]*", module), (
                f"{name}: malformed source module identifier"
            )
            assert f"import {module}" in ROOT_IMPORTS, (
                f"{name}: formal module is not imported into the compiled root"
            )
            source = ROOT / (module.replace(".", "/") + ".lean")
            assert source.is_file(), f"{name}: claimed Lean module file missing"
            body = source.read_text(encoding="utf-8")
            assert "#print axioms" in body and ("theorem " in body or "lemma " in body), (
                f"{name}: claimed module lacks theorem and axiom visibility"
            )
        if status in EVIDENCE_STATUSES:
            assert scope in ("physical", "semantic"), f"{name}: measured status has wrong scope"
            need = 2 if status == "INDEPENDENTLY_REPLICATED" else 1
            assert len(evidence) >= need, f"{name}: evidence must contain {need}+ citations"
            for e in evidence:
                assert isinstance(e, dict) and all(
                    isinstance(e.get(k), str) and e[k].strip()
                    for k in ("uri", "sha256", "reviewer", "method")
                ), f"{name}: evidence lacks provenance metadata"
            for e in evidence:
                assert re.fullmatch(r"[0-9a-fA-F]{64}", e["sha256"]), (
                    f"{name}: evidence digest is not a SHA256 hex string"
                )
                assert e["uri"].startswith("https://"), (
                    f"{name}: evidence URI must be HTTPS"
                )
            if need == 2:
                assert len({e["reviewer"] for e in evidence}) >= 2, (
                    f"{name}: independent corroborators must differ"
                )
        if scope in ("physical", "semantic") and status == "FORMALLY_CHECKED":
            raise AssertionError(f"{name}: model proof promoted to real-world fact")
    assert REQUIRED_PHYSICAL <= found, "Missing critical physical/semantic obligations"
    return len(entries)

def regressions(data):
    def with_claim(name, **updates):
        copy = json.loads(json.dumps(data))
        for c in copy["claims"]:
            if c["id"] == name:
                c.update(updates)
                break
        return copy
    # Negative controls for unsupported promotion.
    for edited in (
        with_claim("physical_nonzeno_clock", status="MEASURED"),
        with_claim("historical_subject_continuity_actual", status="INDEPENDENTLY_REPLICATED"),
        with_claim("channel_inventory_actual_completeness", status="FORMALLY_CHECKED",
                   module="PhysicalBridges.IRChannelInventory"),
        with_claim("lean_symbolic_guard", module="PhysicalBridges.PhantomMissingProof"),
        with_claim("lean_symbolic_guard", module="PhysicalBridges.IRPhysicalGuard/../escape"),
    ):
        try:
            inspect(edited)
        except AssertionError:
            pass
        else:
            raise AssertionError("Promotion without evidence must be rejected")
    bad = with_claim("sensor_error_bound_actual", status="MEASURED",
                     evidence=[{"uri":"example", "sha256":"", "reviewer":"X", "method":"Y"}])
    try:
        inspect(bad)
    except AssertionError:
        pass
    else:
        raise AssertionError("Empty evidence hash should fail")

if __name__ == "__main__":
    path = Path(__file__).with_name("assurance-ledger.json")
    data = json.loads(path.read_text(encoding="utf-8"))
    count = inspect(data)
    regressions(data)
    print(f"PASS: {count} claim records audited; negative promotion controls rejected")
