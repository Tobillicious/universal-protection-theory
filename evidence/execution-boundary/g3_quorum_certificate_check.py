"""Offline, non-authorizing quorum certificate checker for G3 review.

An independent trustee supplies a pinned roster OUTSIDE the untrusted certificate.
Never accept a certificate-supplied roster as its own trust anchor.
This tool NEVER creates keys, signatures, nodes, or effects. A valid threshold
certificate means only that registered public keys signed the exact statement;
it does not imply actual independent custody, consent, or physical coverage.
"""
import hashlib
import json
from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey

DOMAIN = b"UPT-G3-R4-REVIEW-QUORUM-V1\x00"


def _keys(pairs):
    result = {}
    for k, v in pairs:
        if k in result:
            raise ValueError("duplicate JSON field")
        result[k] = v
    return result


def verify(payload, *, expected_sha, trusted_roster):
    if not isinstance(payload, bytes) or not 0 < len(payload) < 65536:
        raise ValueError("invalid certificate size")
    data = json.loads(payload, object_pairs_hook=_keys)
    if type(data) is not dict or set(data) != {"schema", "record_sha256", "epoch", "roster", "signatures", "fault_tolerance"}:
        raise ValueError("unexpected certificate schema")
    if data["schema"] != "g3-independent-review-quorum-v1":
        raise ValueError("unsupported version")
    if type(expected_sha) is not str or len(expected_sha) != 64 or any(x not in "0123456789abcdef" for x in expected_sha):
        raise ValueError("independent expected SHA required")
    if data["record_sha256"] != expected_sha:
        raise ValueError("reviewed evidence digest mismatch")
    epoch, f, roster, signatures = (data["epoch"], data["fault_tolerance"],
                                   data["roster"], data["signatures"])
    if type(epoch) is not int or epoch < 1 or type(f) is not int or f < 1:
        raise ValueError("invalid quorum epoch or tolerance")
    if type(roster) is not dict or len(roster) != 3 * f + 1:
        raise ValueError("requires exactly 3f+1 registered identities")
    if type(trusted_roster) is not dict or not trusted_roster or roster != trusted_roster:
        raise ValueError("certificate roster differs from independently pinned roster")
    if type(signatures) is not list:
        raise ValueError("invalid signature collection")
    if len(set(roster.values())) != len(roster):
        raise ValueError("duplicate public keys in roster")
    for ident, key in roster.items():
        if (type(ident) is not str or not 1 <= len(ident) <= 100
                or type(key) is not str or len(key) != 64):
            raise ValueError("invalid roster entry")
        try:
            Ed25519PublicKey.from_public_bytes(bytes.fromhex(key))
        except (ValueError, TypeError) as exc:
            raise ValueError("invalid roster key encoding") from exc
    statement = DOMAIN + json.dumps(
        {"record_sha256": expected_sha, "epoch": epoch,
         "roster_sha256": hashlib.sha256(json.dumps(roster, sort_keys=True, separators=(",", ":")).encode()).hexdigest()},
        sort_keys=True, separators=(",", ":")).encode()
    signed = set()
    for item in signatures:
        if type(item) is not dict or set(item) != {"member", "signature"}:
            raise ValueError("invalid signature entry")
        member, signature = item["member"], item["signature"]
        if type(member) is not str or member not in roster or member in signed:
            raise ValueError("duplicate or unregistered signer")
        if type(signature) is not str or len(signature) != 128:
            raise ValueError("invalid signature length")
        try:
            Ed25519PublicKey.from_public_bytes(bytes.fromhex(roster[member])).verify(bytes.fromhex(signature), statement)
        except (ValueError, InvalidSignature) as exc:
            raise ValueError("signature verification failed") from exc
        signed.add(member)
    sufficient = len(signed) >= 2 * f + 1
    return {
        "schema": "g3-review-quorum-check-v1",
        "valid_signatures": len(signed),
        "required_signatures": 2 * f + 1,
        "cryptographic_threshold_met": sufficient,
        "independent_custody_verified": False,
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
        "universal_G3_proved": False,
        "status": "SIGNATURE_THRESHOLD_MET_REVIEW_REQUIRED" if sufficient else "INSUFFICIENT_SIGNATURES",
    }


def verify_files(*, evidence_path, certificate_path, roster_path,
                 expected_roster_sha256):
    """Trust roots supplied OUTSIDE certificate; no signing or effects."""
    from pathlib import Path
    import stat

    def read_regular(path, max_bytes):
        p = Path(path)
        info = p.lstat()
        if not stat.S_ISREG(info.st_mode) or info.st_size > max_bytes:
            raise ValueError("refuse non-regular or oversized input: " + str(p))
        data = p.read_bytes()
        if len(data) > max_bytes:
            raise ValueError("oversized input: " + str(p))
        return data

    if (type(expected_roster_sha256) is not str
            or len(expected_roster_sha256) != 64
            or any(x not in "0123456789abcdef" for x in expected_roster_sha256)):
        raise ValueError("separately pinned roster SHA256 required")
    evidence = read_regular(evidence_path, 1048576)
    certificate = read_regular(certificate_path, 65535)
    roster_bytes = read_regular(roster_path, 16384)
    roster = json.loads(roster_bytes, object_pairs_hook=_keys)
    if type(roster) is not dict:
        raise ValueError("trusted roster must be an object")
    canonical_roster = json.dumps(roster, sort_keys=True, separators=(",", ":")).encode()
    if hashlib.sha256(canonical_roster).hexdigest() != expected_roster_sha256:
        raise ValueError("independent roster digest mismatch")
    result = verify(certificate, expected_sha=hashlib.sha256(evidence).hexdigest(),
                    trusted_roster=roster)
    result["evidence_sha256"] = hashlib.sha256(evidence).hexdigest()
    result["trusted_roster_sha256"] = expected_roster_sha256
    return result


def main():
    import argparse
    p = argparse.ArgumentParser(
        description="Offline G3 quorum review; never authorizes effects or clears HOLD")
    p.add_argument("--evidence", required=True)
    p.add_argument("--certificate", required=True)
    p.add_argument("--trusted-roster", required=True)
    p.add_argument("--pinned-roster-sha256", required=True,
                   help="SHA256 of canonical JSON roster, obtained out-of-band")
    args = p.parse_args()
    try:
        result = verify_files(
            evidence_path=args.evidence, certificate_path=args.certificate,
            roster_path=args.trusted_roster,
            expected_roster_sha256=args.pinned_roster_sha256)
    except (ValueError, OSError, TypeError, UnicodeError) as exc:
        p.error(str(exc))
    print(json.dumps(result, sort_keys=True, indent=2))
    return 0 if result["cryptographic_threshold_met"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
