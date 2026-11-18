#!/usr/bin/env python3
"""Non-authorizing G-Mesh local monitor.

The historical daemon logged 'SECURE' without examining any evidence, and
hashed timestamp text as if it were a signed lease. Neither is valid
monitoring. No externally authenticated lease/inventory is connected here.
Fail closed: never emit PASS, SECURE, or a fabricated lease receipt.
"""
import datetime
import json
import time


def audit_cycle(*, now=None):
    observed_at = now or datetime.datetime.now(datetime.timezone.utc).isoformat()
    return {
        "schema": "gmesh-monitor-v1",
        "observed_at": observed_at,
        "status": "UNVERIFIED_NO_INDEPENDENT_EVIDENCE",
        "scope": "local monitor; no signed lease or physical effect evidence",
        "independent_quorum_verified": False,
        "authentic_original_six_verified": False,
        "all_actual_effects_covered": False,
        "universal_physical_protection_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
    }


def main():
    while True:
        try:
            print(json.dumps(audit_cycle(), sort_keys=True), flush=True)
        except Exception as exc:
            print(json.dumps({"status": "AUDIT_ERROR",
                              "error_type": type(exc).__name__,
                              "authorizes_effect": False,
                              "may_clear_hold": False}), flush=True)
        time.sleep(60)


if __name__ == "__main__":
    main()
