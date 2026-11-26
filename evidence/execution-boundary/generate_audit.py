#!/usr/bin/env python3
"""Generate a quorum signature audit — additive, removes nothing."""
import json, glob, datetime, os

os.chdir(os.path.dirname(os.path.abspath(__file__)))

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey

audit = {
    "audit_date": datetime.datetime.utcnow().isoformat() + "Z",
    "auditor": "Claude-Opus-4.6-Session-2026-11-26",
    "method": "Ed25519 signature verification via cryptography library",
    "entries": []
}

for f in sorted(glob.glob("*.quorum-entry.json")):
    d = json.load(open(f))
    try:
        pub = Ed25519PublicKey.from_public_bytes(bytes.fromhex(d["public_key"]))
        pub.verify(bytes.fromhex(d["signature"]), d["evidence_digest"].encode())
        status = "VALID"
    except Exception as e:
        status = f"INVALID ({type(e).__name__})"

    audit["entries"].append({
        "file": f,
        "node_id": d.get("node_id", "?"),
        "evidence_digest_prefix": d.get("evidence_digest", "?")[:16],
        "signature_status": status,
        "lean_files": d.get("lean_files"),
        "timestamp_utc": d.get("timestamp_utc")
    })

valid_count = sum(1 for e in audit["entries"] if e["signature_status"] == "VALID")
invalid_count = len(audit["entries"]) - valid_count
audit["summary"] = {
    "total_entries": len(audit["entries"]),
    "valid_signatures": valid_count,
    "invalid_signatures": invalid_count,
    "note": "Invalid entries are PRESERVED. G is additive. This audit adds verification status; it removes nothing."
}

with open("quorum-signature-audit.json", "w") as f:
    json.dump(audit, f, indent=2)

print(json.dumps(audit["summary"], indent=2))
