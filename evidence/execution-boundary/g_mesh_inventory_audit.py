"""Read-only G-Mesh node receipt auditor. No node provisioning or effect permits.

A pinned roster and distinct signed observations can substantiate a bounded
claim about receipt ownership and freshness. They do NOT prove a running host,
quorum consensus, zero latency, physical protection, or independent custody.
"""
import argparse
import json
import re
import sys

from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey

DIGEST = re.compile(r"[0-9a-f]{64}\Z")
HEXKEY = re.compile(r"[0-9a-f]{64}\Z")
HEX_SIGNATURE = re.compile(r"[0-9a-f]{128}\Z")
DOMAIN = b"UPT-G-MESH-NODE-OBSERVATION-V1\x00"
RECEIPT_FIELDS = {"node_id", "deployment_id", "policy_digest",
                  "observed_at", "nonce", "source_commit", "engine_digest", "status"}


def _canonical(body):
    return DOMAIN + json.dumps(body, sort_keys=True, separators=(",", ":"),
                               ensure_ascii=True, allow_nan=False).encode("ascii")


def audit(roster, observations, *, now, max_age=300):
    """Return fail-closed evidence summary; no network calls or state mutation."""
    errors = []
    if type(now) is not int or now <= 0 or type(max_age) is not int or not 1 <= max_age <= 3600:
        raise ValueError("trusted now and bounded max_age required")
    if type(roster) is not dict or set(roster) != {"deployment_id", "policy_digest", "nodes"}:
        raise ValueError("invalid roster schema")
    deployment, policy = roster["deployment_id"], roster["policy_digest"]
    if (type(deployment) is not str or not deployment or
            type(policy) is not str or not DIGEST.fullmatch(policy)):
        raise ValueError("invalid pinned deployment or policy")
    nodes = roster["nodes"]
    if type(nodes) is not list or not nodes:
        raise ValueError("nonempty explicit roster required")
    keys = {}
    for node in nodes:
        if type(node) is not dict or set(node) != {"node_id", "public_key_hex"}:
            raise ValueError("invalid roster entry")
        name, raw = node["node_id"], node["public_key_hex"]
        if (type(name) is not str or not name or len(name) > 160 or name in keys or
                type(raw) is not str or not HEXKEY.fullmatch(raw)):
            raise ValueError("duplicate or invalid roster identity")
        keys[name] = Ed25519PublicKey.from_public_bytes(bytes.fromhex(raw))
    if (type(observations) is not dict or
            set(observations) != {"deployment_id", "policy_digest", "receipts"} or
            observations["deployment_id"] != deployment or observations["policy_digest"] != policy or
            type(observations["receipts"]) is not list):
        raise ValueError("invalid or mismatched observation set")
    seen = set()
    for entry in observations["receipts"]:
        if type(entry) is not dict or set(entry) != {"body", "signature_hex"}:
            errors.append("invalid receipt envelope")
            continue
        body, sig = entry["body"], entry["signature_hex"]
        if type(body) is not dict or set(body) != RECEIPT_FIELDS:
            errors.append("invalid receipt body")
            continue
        node_id = body["node_id"]
        if node_id not in keys or node_id in seen:
            errors.append("unknown or duplicate receipt identity")
            continue
        seen.add(node_id)
        if (body["deployment_id"] != deployment or body["policy_digest"] != policy or
                body["status"] != "ready" or
                type(body["observed_at"]) is not int or
                not now - max_age <= body["observed_at"] <= now or
                type(body["nonce"]) is not str or not 16 <= len(body["nonce"]) <= 160 or
                type(body["source_commit"]) is not str or
                re.fullmatch(r"[0-9a-f]{40}", body["source_commit"]) is None or
                type(body["engine_digest"]) is not str or
                not DIGEST.fullmatch(body["engine_digest"]) or
                type(sig) is not str or HEX_SIGNATURE.fullmatch(sig) is None):
            errors.append("invalid, stale or mismatched receipt: " + node_id)
            continue
        try:
            keys[node_id].verify(bytes.fromhex(sig), _canonical(body))
        except (InvalidSignature, ValueError, UnicodeError):
            errors.append("invalid signature: " + node_id)
    missing = sorted(set(keys) - seen)
    if missing:
        errors.append("missing node receipts: " + ", ".join(missing))
    return {"ok": not errors, "roster_count": len(keys),
            "receipt_count": len(observations["receipts"]), "errors": errors,
            "certifies_live_nodes": False, "authorizes_effects": False,
            "independent_custody_verified": False}


def main():
    p = argparse.ArgumentParser(description="Offline signed-receipt check; no live-node claims")
    p.add_argument("--roster", required=True)
    p.add_argument("--observations", required=True)
    p.add_argument("--at", type=int, required=True, help="independently obtained trusted Unix time")
    p.add_argument("--max-age", type=int, default=300)
    args = p.parse_args()
    try:
        with open(args.roster, encoding="utf-8") as f:
            roster = json.load(f)
        with open(args.observations, encoding="utf-8") as f:
            observations = json.load(f)
        outcome = audit(roster, observations, now=args.at, max_age=args.max_age)
    except (OSError, ValueError, TypeError, UnicodeError) as error:
        outcome = {"ok": False, "errors": [str(error)]}
    print(json.dumps(outcome, indent=2, sort_keys=True))
    return 0 if outcome["ok"] else 1


if __name__ == "__main__":
    sys.exit(main())
