"""Independent after-the-fact E-LIN journal sanity checker for v4.3 research.

The legacy target.py demo checks generations in its live process but does
NOT replay the authenticated floor on restart; this checker is NOT an
in-process release fence and cannot guarantee immediate containment.
"""
import hashlib
import hmac
import json


def _digest(key, role, record):
    body = {k: v for k, v in record.items() if k != "lmac"}
    msg = "line|" + role + "|" + json.dumps(body, sort_keys=True)
    return hmac.new(key, msg.encode(), hashlib.sha256).hexdigest()


def audit(records, key, role, *, initial_floor=1):
    if (type(records) is not list or type(key) is not bytes or
            len(key) < 16 or role not in ("journal", "sink")):
        raise ValueError("invalid trusted journal inspection input")
    errors = []
    floor = initial_floor
    last_t = None
    next_seq = 0
    observed_ids = set()
    for i, rec in enumerate(records):
        if type(rec) is not dict or type(rec.get("lmac")) is not str:
            errors.append((i, "malformed_or_unsigned"))
            continue
        if not hmac.compare_digest(rec["lmac"], _digest(key, role, rec)):
            errors.append((i, "invalid_line_mac"))
            continue
        t = rec.get("t")
        if type(t) not in (float, int):
            errors.append((i, "invalid_timestamp"))
        elif last_t is not None and t < last_t:
            errors.append((i, "timestamp_rollback"))
        if type(t) in (float, int):
            last_t = t
        if rec.get("op") == "floor":
            value = rec.get("g")
            if type(value) is not int or value < floor:
                errors.append((i, "floor_rollback"))
            else:
                floor = value
        elif rec.get("op") == "write":
            gen = rec.get("gen")
            observed_floor = rec.get("floor_at_apply")
            if (type(gen) is not int or type(observed_floor) is not int or
                    gen < floor or observed_floor != floor):
                errors.append((i, "stale_or_mismatched_generation"))
            if role == "journal":
                if type(rec.get("seq")) is not int or rec["seq"] != next_seq:
                    errors.append((i, "sequence_replay_or_gap"))
                else:
                    next_seq += 1
            elif rec.get("id") in observed_ids:
                errors.append((i, "replayed_effect_id"))
            else:
                observed_ids.add(rec.get("id"))
        else:
            errors.append((i, "unknown_operation"))
    return {"valid": len(errors) == 0, "errors": errors, "final_floor": floor}
