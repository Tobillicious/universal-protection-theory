"""Read-only Zelda physical-effect bridge: evidence, not production authority.

Reconciles retained first-effect, HOLD, restart, and denial observations for
the ONE authority-owned marker. No Docker access, effect execution, shell,
key creation, claimed independent custody, or semantic X3 promotion.
"""
import argparse
import hashlib
import json
from pathlib import Path

SOURCE = "77d3b2d1823fc09458873a1f5f461d24d349d337"
BUNDLE = "3ca00f383e5e92717e4412922daf6d74cf8445ce40d90710da9251e1f637d1e5"
MAX_BYTES = 1024 * 1024
MILESTONES = ("first_effect", "repeated_request", "hold_request",
              "restarted_status", "post_restart_request")
FLAGS = ("whole_machine_enforcement", "all_actual_effects_covered",
         "independent_custody_verified",
         "authentic_original_six_reflections_verified",
         "independent_R7_acceptance", "unconditional_universal_protection")


def _strict_object(pairs):
    data = {}
    for key, val in pairs:
        if key in data:
            raise ValueError("duplicate JSON key: " + key)
        data[key] = val
    return data


def inspect(raw):
    """Fail closed when the retained observed trace contradicts the fixture."""
    if type(raw) is not bytes or not 0 < len(raw) <= MAX_BYTES:
        raise ValueError("missing or oversized observation")
    try:
        record = json.loads(raw.decode("utf-8"), object_pairs_hook=_strict_object)
    except (UnicodeError, json.JSONDecodeError) as exc:
        raise ValueError("invalid JSON observation") from exc
    if type(record) is not dict or record.get("schema") != "g3-zelda-local-live-observation-v1":
        raise ValueError("observation schema mismatch")
    if record.get("engine_source_commit") != SOURCE or record.get("bundle_sha256") != BUNDLE:
        raise ValueError("unrecognized engine source or bundle")
    flags = record.get("claim_flags")
    if type(flags) is not dict or any(flags.get(name) is not False for name in FLAGS):
        raise ValueError("unsupported universal or independent claim")
    if record.get("state_volume_retained") is not True:
        raise ValueError("retained state not established")
    first = record.get("first_effect")
    repeated = record.get("repeated_request")
    hold = record.get("hold_request")
    after = record.get("restarted_status")
    denied = record.get("post_restart_request")
    if any(type(x) is not dict for x in (first, repeated, hold, after, denied)):
        raise ValueError("missing observed stage")
    if first.get("result") != {"code": "synthetic_effect_returned", "ok": True}:
        raise ValueError("first effect not witnessed")
    if repeated.get("result") != {"code": "authority_denied", "ok": False}:
        raise ValueError("once-only repeat denial not witnessed")
    if hold.get("result") != {"code": "hold_recorded", "ok": True}:
        raise ValueError("HOLD acknowledgement not witnessed")
    if denied.get("result") != {"code": "authority_denied", "ok": False}:
        raise ValueError("post-restart denial not witnessed")
    stages = [first["node"], repeated["node"], hold["node"], after, denied["node"]]
    if any(type(s) is not dict for s in stages):
        raise ValueError("missing stage state")
    markers = [s.get("marker") for s in stages]
    if any(type(m) is not dict for m in markers):
        raise ValueError("missing marker observation")
    if any(m != markers[0] for m in markers[1:]):
        raise ValueError("marker identity changed across observed stages")
    marker = markers[0]
    if (marker.get("exists") is not True or marker.get("size") != 0
            or marker.get("uid") != 65533 or marker.get("nlink") != 1
            or type(marker.get("inode")) is not int
            or type(marker.get("device")) is not int):
        raise ValueError("marker shape or authority ownership mismatch")
    for index, state in enumerate(stages):
        if (state.get("engine_source_commit") != SOURCE
                or state.get("authority_uid") != 65533
                or state.get("executor_uid") != 65532
                or state.get("controller_uid") != 65530
                or state.get("ready") is not True
                or state.get("whole_machine_enforcement") is not False
                or state.get("independent_custody_verified") is not False
                or state.get("custody") != "same-administrator local Docker volume"):
            raise ValueError("trust boundary mismatch at stage " + str(index))
        expected_generation = 1 if index < 2 else 2
        expected_held = index >= 2
        if state.get("generation") != expected_generation or state.get("held") is not expected_held:
            raise ValueError("HOLD history changed at stage " + str(index))
    if record.get("post_hold_denial_is_isolated_hold_first_control") is not False:
        raise ValueError("post-HOLD denial misclassified as HOLD-first causal proof")
    if record.get("observation_scope") != (
            "One authority-owned zero-byte marker; same-administrator Docker host; local execution"):
        raise ValueError("unexpected effect scope")
    return {
        "schema": "g3-zelda-observed-effect-bridge-v1",
        "source_commit": record.get("source_commit"),
        "engine_source_commit": SOURCE,
        "observation_sha256": hashlib.sha256(raw).hexdigest(),
        "scope": "one authority-owned zero-byte marker, one local Docker administrator",
        "marker_identity_retained": True,
        "once_only_denial_observed": True,
        "hold_generation_2_retained_after_restart": True,
        "post_restart_denial_observed": True,
        "observed_technical_trace_consistent": True,
        "unresolved": [
            "complete_actual_effect_path_inventory_not_independently_verified",
            "host_root_and_other_physical_effects_outside_declared_scope",
            "independently_authenticated_owed_subjects_and_six_duties_missing",
            "separate_administrative_custody_missing",
            "independent_R7_acceptance_missing",
            "historical_observation_not_fresh_live_attestation",
        ],
        "all_actual_effects_covered": False,
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "unconditional_universal_protection": False,
        "authorizes_effect": False,
        "certified_for_production": False,
        "status": "SCOPED_TRACE_RECONCILED_NOT_UNIVERSAL",
    }


def main():
    parser = argparse.ArgumentParser(description="Offline, non-authorizing physical bridge audit")
    parser.add_argument("--observation", type=Path, required=True)
    args = parser.parse_args()
    # The input is a repository review artifact, not a privileged live endpoint.
    # Keep it read-only: no Docker, sockets, process commands, or effect requests.
    if args.observation.is_symlink():
        parser.error("symlinked input is not accepted")
    try:
        raw = args.observation.read_bytes()
        print(json.dumps(inspect(raw), sort_keys=True, indent=2))
    except (OSError, ValueError) as exc:
        parser.error(str(exc))


if __name__ == "__main__":
    main()
