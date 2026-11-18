"""Offline G-Mesh partition *simulation*, not a live network experiment."""
import argparse
import json


def simulate(*, nodes, drop_ratio):
    if (type(nodes) is not list or not nodes
            or any(type(x) is not str or not x for x in nodes)
            or len(set(nodes)) != len(nodes)):
        raise ValueError("nonempty distinct synthetic node identities required")
    if type(drop_ratio) not in (int, float) or not 0 <= drop_ratio <= 1:
        raise ValueError("packet drop ratio must be in [0,1]")
    return {
        "schema": "gmesh-partition-simulation-v1",
        "simulation_only": True,
        "nodes_declared": len(nodes),
        "configured_drop_ratio": drop_ratio,
        "live_traffic_observed": False,
        "independent_peer_signatures_verified": False,
        "real_network_partition_injected": False,
        "real_failover_verified": False,
        "all_actual_effects_covered": False,
        "universal_physical_protection_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
        "status": "SYNTHETIC_PARAMETERS_ONLY_NOT_A_LIVE_STRESS_TEST",
    }


def main(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("--partition", action="store_true")
    parser.add_argument("--nodes", required=True)
    parser.add_argument("--drop-ratio", type=float, default=0.75)
    parser.add_argument("--verify-healing", action="store_true")
    args = parser.parse_args(argv)
    try:
        report = simulate(nodes=args.nodes.split(","), drop_ratio=args.drop_ratio)
    except ValueError as exc:
        parser.error(str(exc))
    print(json.dumps(report, sort_keys=True))
    # Requesting verified physical healing must never pass a print-only model.
    if args.verify_healing:
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
