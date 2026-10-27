#!/usr/bin/env python3
"""Validate physical instrument evidence envelopes; never invent measurements.

This checks provenance and status fields, NOT whether evidence or physical
bounds are scientifically valid. There is currently no validated instrument.
"""
import copy
import json
from pathlib import Path

ROOT = Path(__file__).parent
REQUIRED = {
    "physical_actuator_admission_atomicity",
    "physical_inflight_queue_coverage",
    "physical_apply_time_epoch_enforcement",
    "physical_durable_epoch_recovery",
    "physical_event_residual_calibration",
    "physical_authoritative_committed_event_timestamps",
    "physical_max_interstep_service_latency",
    "physical_actual_service_delivery",
}
STATES = {"UNSPECIFIED", "PROTOTYPE_UNVALIDATED", "REVIEWED_MEASUREMENTS"}
RESULTS = {"OPEN", "FAILED", "LIMITED", "MEASURED"}

def validate(data):
    assert data.get("schema_version") == 1, "unknown evidence version"
    assert data.get("kind") == "physical-instrument-evidence", "wrong evidence kind"
    state = data.get("deployment_status")
    assert state in STATES, "invalid deployment status"
    entries = data.get("claims")
    assert isinstance(entries, list), "claims must be a list"
    ids = set()
    for item in entries:
        name = item.get("id")
        assert isinstance(name, str) and name not in ids, "duplicate/bad claim id"
        ids.add(name)
        status = item.get("status")
        assert status in RESULTS, f"{name}: unsupported result status"
        proof = item.get("evidence")
        assert isinstance(proof, list), f"{name}: missing evidence array"
        if status == "MEASURED":
            assert state != "UNSPECIFIED", f"{name}: no physical device specified"
            assert all(isinstance(data.get(k), str) and data[k].strip()
                       for k in ("instrument_id", "device_revision", "firmware_sha256")), (
                f"{name}: instrument provenance missing")
            assert isinstance(item.get("units"), str) and item["units"].strip(), (
                f"{name}: physical units missing")
            assert isinstance(item.get("operating_range"), str) and item["operating_range"].strip(), (
                f"{name}: physical test range missing")
            assert proof, f"{name}: no supporting evidence"
            for evidence in proof:
                assert isinstance(evidence, dict) and all(
                    isinstance(evidence.get(k), str) and evidence[k].strip()
                    for k in ("uri", "sha256", "reviewer", "method", "date", "uncertainty")
                ), f"{name}: insufficient evidence provenance"
        if state == "REVIEWED_MEASUREMENTS":
            assert proof and status == "MEASURED", (
                f"{name}: reviewed measurement lacks verified evidence metadata")
    assert REQUIRED <= ids, "some critical obligations are missing"
    if state == "UNSPECIFIED":
        assert all(item["status"] == "OPEN" for item in entries), (
            "an unspecified device cannot have an alleged physical test result")
    return len(entries)

def negative_tests(sample):
    claim = sample["claims"][0]
    for altered in (
        {"status": "MEASURED"},
        {"status": "MEASURED", "evidence": [{"uri":"example"}]},
        {"status": "FAILED"},
    ):
        bad = copy.deepcopy(sample)
        bad["claims"][0].update(altered)
        try:
            validate(bad)
        except AssertionError:
            pass
        else:
            raise AssertionError("unsupported state promotion was accepted")

if __name__ == "__main__":
    sample = json.loads((ROOT / "instrument-evidence-template.json").read_text())
    count = validate(sample)
    negative_tests(sample)
    print(f"PASS: {count} physical instrument obligations remain OPEN; "
          "unsupported evidence/status promotions rejected")
