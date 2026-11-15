"""Offline *inventory only*: never certifies G3 or authorizes any effect."""
import argparse
import hashlib
import json
import re
from pathlib import Path

REQUIRED = frozenset((
    "signed_effect_boundary", "separate_uid_bypass", "emergency_revocation",
    "restart_lease_fence", "crash_recovery", "resource_exhaustion",
    "rights_consent_review", "original_six_x3_correspondence",
    "independent_security_review", "rollback_recovery_review",
))
HEX64 = re.compile(r"[0-9a-f]{64}\Z")


def inspect(packet, root):
    """Check manifest shape, exact commit labels, file identity, and digests.

    The manifest, its reviewer labels and hashes are submitted by the caller;
    a positive result is NOT evidence of actual independent review.
    """
    errors = []
    if type(packet) is not dict or set(packet) != {"schema", "source_commit", "evidence"}:
        return verdict(["packet_schema"])
    if packet["schema"] != "g3-evidence-inventory-v1":
        errors.append("schema_version")
    commit = packet["source_commit"]
    if type(commit) is not str or not HEX64.fullmatch(commit):
        errors.append("source_commit_invalid")
    evidence = packet["evidence"]
    if type(evidence) is not dict or set(evidence) != REQUIRED:
        return verdict(errors + ["missing_or_extra_evidence_keys"])
    root = Path(root).resolve(strict=True)
    if not root.is_dir():
        return verdict(errors + ["root_not_directory"])
    seen = set()
    for key in sorted(REQUIRED):
        item = evidence[key]
        if type(item) is not dict or set(item) != {
            "path", "sha256", "reviewer", "reviewed_commit"
        }:
            errors.append(key + ":schema")
            continue
        rel, checksum = item["path"], item["sha256"]
        if (type(rel) is not str or not rel or "\\" in rel or
                Path(rel).is_absolute() or ".." in Path(rel).parts or rel in seen):
            errors.append(key + ":unsafe_path")
            continue
        seen.add(rel)
        if type(checksum) is not str or not HEX64.fullmatch(checksum):
            errors.append(key + ":bad_digest")
            continue
        if (type(item["reviewer"]) is not str or not item["reviewer"].strip() or
                item["reviewed_commit"] != commit):
            errors.append(key + ":unreviewed_or_stale")
            continue
        file = root / rel
        if file.is_symlink() or not file.is_file() or not file.resolve().is_relative_to(root):
            errors.append(key + ":missing_or_unsafe_file")
            continue
        h = hashlib.sha256()
        with file.open("rb") as stream:
            while block := stream.read(65536):
                h.update(block)
        if h.hexdigest() != checksum:
            errors.append(key + ":content_mismatch")
    return verdict(errors)


def verdict(errors):
    return {
        "ready_for_independent_review": not errors,
        "errors": errors,
        "certified_for_production": False,
        "universal_physical_protection_proved": False,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("packet", type=Path)
    parser.add_argument("evidence_root", type=Path)
    args = parser.parse_args()
    try:
        result = inspect(json.loads(args.packet.read_text(encoding="utf-8")), args.evidence_root)
    except (OSError, TypeError, ValueError):
        result = verdict(["invalid_or_missing_input"])
    print(json.dumps(result, sort_keys=True))
    return 0 if result["ready_for_independent_review"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
