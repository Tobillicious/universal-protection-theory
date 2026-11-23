#!/usr/bin/env python3
"""Strict Cryptographic & Custody Audit for G-Mesh Quorum Attestations.

Grounded in `PhysicalBridges/RepairGMeshByzantineQuorum.lean`, `Obend.Consensus.Simplex`
(`github.com/emberian/obend`), Alpos, Cachin & Zanolini (2021, arXiv:2107.11331), and
Ioffe & Malkhi (2026, arXiv:2611.10403, *QUASI: Post-Quantum Quorum Attestation of
Pre-Validated Statements*).

What `--audit-existing` verifies and reports:
1. Reads all `*.quorum-entry.json` files in `evidence/execution-boundary/` (and cross-checks
   `QUORUM-ROSTER.md`);
2. Cryptographically verifies every Ed25519 `(public_key, evidence_digest, signature)` tuple,
   distinguishing:
   - Pinned-roster domain-separated signatures (`UPT-G3-R4-REVIEW-QUORUM-V1\\0` + real `roster_sha256`),
   - Bootstrap domain-separated signatures (`UPT-G3-R4-REVIEW-QUORUM-V1\\0` + `"PENDING_FULL_ROSTER"`),
   - Legacy un-domain-separated raw ASCII digest signatures (`quorum-bootstrap.sh`), and
   - Invalid / corrupted signatures;
3. Audits distinct `(epoch, evidence_digest)` cohorts, duplicate public keys (`Nodup`), and
   agreement with the live working-tree evidence digest;
4. Classifies ephemeral LLM-session / correlated-host Sybil entries versus externally pinned
   human/organizational custodians (`DistinctCustodians : List.Nodup (committee.map custodianOf)`);
5. Checks presence of the `Repair*` non-vacuity and `#upt_tooth` qualification suite in
   `evidence/physical-bridges/PhysicalBridges/`; and
6. Computes `quorum_threshold = n - f` progress toward G-Mesh's target BFT parameters
   `n = 43, f = 14, q = 29` independent custodians (overlap `n - 2f = 15 = f + 1`).
"""

from __future__ import annotations

import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
from typing import Any

from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey

DOMAIN_V1 = b"UPT-G3-R4-REVIEW-QUORUM-V1\x00"
HEX64_RE = re.compile(r"^[0-9a-f]{64}$")
HEX128_RE = re.compile(r"^[0-9a-f]{128}$")

TARGET_N = 43
TARGET_F = 14
TARGET_QUORUM = TARGET_N - TARGET_F  # 29
TARGET_OVERLAP = TARGET_N - 2 * TARGET_F  # 15

LLM_SESSION_PATTERNS = (
    re.compile(r"(?i)^claude-"),
    re.compile(r"(?i)^gemini-"),
    re.compile(r"(?i)^glm-"),
    re.compile(r"(?i)^gpt-"),
    re.compile(r"(?i)^o[134]-"),
    re.compile(r"(?i)^deepseek-"),
    re.compile(r"(?i)^qwen-"),
    re.compile(r"(?i)^beam-opencode-"),
    re.compile(r"(?i)^anonymous-verifier-session"),
    re.compile(r"(?i)-session-"),
    re.compile(r"(?i)-verifier(-\d+)?$"),
    re.compile(r"(?i)-selftest-"),
    re.compile(r"(?i)-builder-"),
)

EXPECTED_CORE_REPAIR_FILES = (
    "RepairQualificationGate.lean",
    "RepairGMeshByzantineQuorum.lean",
)


def quorum_threshold(n: int, f: int) -> int:
    """Canonical BFT quorum threshold `n - f` (`RepairGMeshByzantineQuorum.quorumThreshold`)."""
    if n < 3 * f + 1:
        raise ValueError(f"invalid BFT committee size n={n} for f={f} (requires n >= 3f + 1 = {3 * f + 1})")
    return n - f


def compute_bootstrap_py_digest(bridges_dir: Path) -> tuple[str, int]:
    """Compute SHA-256 digest matching `g_mesh_quorum_bootstrap.py` over `PhysicalBridges/*.lean`."""
    lean_dir = bridges_dir / "PhysicalBridges"
    if not lean_dir.is_dir():
        return "", 0
    h = hashlib.sha256()
    files = sorted(lean_dir.glob("*.lean"))
    for lf in files:
        h.update(lf.name.encode("utf-8"))
        h.update(lf.read_bytes())
    return h.hexdigest(), len(files)


def compute_bootstrap_sh_digest(bridges_dir: Path) -> tuple[str, int]:
    """Compute double-SHA-256 digest matching `quorum-bootstrap.sh` over `evidence/physical-bridges/**/*.lean`."""
    repo_root = bridges_dir.parent.parent
    rel_files = sorted(
        p.relative_to(repo_root) for p in bridges_dir.rglob("*.lean") if p.is_file()
    )
    if not rel_files:
        return "", 0
    lines: list[str] = []
    for rel in rel_files:
        file_sha = hashlib.sha256((repo_root / rel).read_bytes()).hexdigest()
        # `shasum -a 256` formats each line as "<64-hex>  <relative-path>\n"
        lines.append(f"{file_sha}  {rel.as_posix()}\n")
    joined = "".join(lines).encode("utf-8")
    outer = hashlib.sha256(joined).hexdigest()
    return outer, len(rel_files)


def parse_roster_markdown(roster_md: Path) -> list[str]:
    """Extract listed node IDs from `QUORUM-ROSTER.md` markdown table."""
    if not roster_md.is_file():
        return []
    nodes: list[str] = []
    for raw_line in roster_md.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line.startswith("|") or not line.endswith("|"):
            continue
        cells = [c.strip() for c in line.strip("|").split("|")]
        if not cells or cells[0] in ("Node", "#", "---", "---------") or set(cells[0]) <= {"-"}:
            continue
        if len(cells) == 1:
            nodes.append(cells[0])
        elif len(cells) >= 2 and cells[0].isdigit():
            nodes.append(cells[1])
    return nodes


def classify_custody(
    entry: dict[str, Any],
    pinned_custodians: dict[str, str] | None,
) -> tuple[str, str]:
    """Classify an entry's custody domain (`(custody_class, custodian_id)`).

    Without an externally pinned `public_key -> operator_id` custody manifest, keys matching
    ephemeral LLM-session naming or lacking out-of-band operator attestation cannot be counted
    as distinct BFT custodians (`RepairGMeshByzantineQuorum.correlated_operator_sybil_breaks_bft`).
    """
    pub = str(entry.get("public_key", ""))
    node_id = str(entry.get("node_id", ""))
    if pinned_custodians and pub in pinned_custodians:
        return "pinned_human_or_org_custodian", pinned_custodians[pub]
    for pat in LLM_SESSION_PATTERNS:
        if pat.search(node_id):
            return "ephemeral_llm_session_unpinned", "SHARED_LOCAL_HOST_OPERATOR"
    return "unpinned_unverified_claim", f"UNVERIFIED:{node_id}"


def verify_entry_signature(
    entry: dict[str, Any],
    trusted_roster_sha256: str | None = None,
) -> tuple[bool, str, str]:
    """Verify Ed25519 `(public_key, evidence_digest, signature)` tuple.

    Returns `(is_valid, scheme_label, detail)`.
    """
    pub_hex = entry.get("public_key")
    sig_hex = entry.get("signature")
    digest = entry.get("evidence_digest")
    epoch = entry.get("epoch")

    if not isinstance(pub_hex, str) or not HEX64_RE.match(pub_hex):
        return False, "malformed_public_key", "public_key must be 64 lowercase hex chars"
    if not isinstance(sig_hex, str) or not HEX128_RE.match(sig_hex):
        return False, "malformed_signature", "signature must be 128 lowercase hex chars"
    if not isinstance(digest, str) or not HEX64_RE.match(digest):
        return False, "malformed_digest", "evidence_digest must be 64 lowercase hex chars"

    try:
        pub = Ed25519PublicKey.from_public_bytes(bytes.fromhex(pub_hex))
        sig = bytes.fromhex(sig_hex)
    except ValueError as exc:
        return False, "key_decode_error", str(exc)

    candidates: list[tuple[str, bytes, str]] = []
    if trusted_roster_sha256 is not None and isinstance(epoch, int) and epoch >= 1:
        pinned_stmt = DOMAIN_V1 + json.dumps(
            {
                "record_sha256": digest,
                "epoch": epoch,
                "roster_sha256": trusted_roster_sha256,
            },
            sort_keys=True,
            separators=(",", ":"),
        ).encode("utf-8")
        candidates.append((
            "domain_v1_pinned_roster",
            pinned_stmt,
            "Ed25519 valid over UPT-G3-R4-REVIEW-QUORUM-V1 with pinned roster_sha256",
        ))

    eff_epoch = epoch if isinstance(epoch, int) and epoch >= 1 else 1
    pending_stmt = DOMAIN_V1 + json.dumps(
        {
            "record_sha256": digest,
            "epoch": eff_epoch,
            "roster_sha256": "PENDING_FULL_ROSTER",
        },
        sort_keys=True,
        separators=(",", ":"),
    ).encode("utf-8")
    candidates.append((
        "domain_v1_pending_roster",
        pending_stmt,
        f"Ed25519 valid over UPT-G3-R4-REVIEW-QUORUM-V1 (epoch={eff_epoch}, roster=PENDING_FULL_ROSTER)",
    ))

    candidates.append((
        "legacy_raw_ascii_digest",
        digest.encode("utf-8"),
        "Ed25519 valid over raw ASCII hex digest only (no domain separation, epoch, or roster binding)",
    ))

    for label, payload, detail in candidates:
        try:
            pub.verify(sig, payload)
            return True, label, detail
        except InvalidSignature:
            continue

    return False, "invalid_signature", "Ed25519 verification failed against all known G-Mesh signing envelopes"


def inspect_repair_suite(bridges_dir: Path) -> dict[str, Any]:
    """Check presence of `Repair*.lean` non-vacuity and `#upt_tooth` qualification modules."""
    pb_dir = bridges_dir / "PhysicalBridges"
    repair_files = sorted(p.name for p in pb_dir.glob("Repair*.lean")) if pb_dir.is_dir() else []
    tooth_counts: dict[str, int] = {}
    census_counts: dict[str, int] = {}
    for fname in repair_files:
        text = (pb_dir / fname).read_text(encoding="utf-8")
        tooth_counts[fname] = len(re.findall(r"(?m)^\s*#upt_tooth\b", text))
        census_counts[fname] = len(re.findall(r"(?m)^\s*#upt_census\b", text))
    missing_core = [req for req in EXPECTED_CORE_REPAIR_FILES if req not in repair_files]
    return {
        "present": len(missing_core) == 0 and len(repair_files) >= 2,
        "repair_files": repair_files,
        "repair_file_count": len(repair_files),
        "missing_core_files": missing_core,
        "upt_tooth_directives_by_file": tooth_counts,
        "upt_tooth_total": sum(tooth_counts.values()),
        "upt_census_directives_by_file": census_counts,
    }


def load_optional_json_map(path: Path | None, label: str) -> dict[str, str] | None:
    if path is None:
        return None
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict) or not all(
        isinstance(k, str) and isinstance(v, str) for k, v in data.items()
    ):
        raise ValueError(f"{label} must be a JSON object mapping string keys to string values")
    return data


def audit_existing(
    entries_dir: Path,
    bridges_dir: Path,
    *,
    target_n: int = TARGET_N,
    target_f: int = TARGET_F,
    custody_manifest: Path | None = None,
    trusted_roster: Path | None = None,
) -> dict[str, Any]:
    """Execute full cryptographic, custody, epoch-coherence, and Repair*-suite audit."""
    q_thresh = quorum_threshold(target_n, target_f)
    overlap_min = target_n - 2 * target_f

    pinned_custodians = load_optional_json_map(custody_manifest, "custody manifest")
    roster_map = load_optional_json_map(trusted_roster, "trusted roster")
    trusted_roster_sha256: str | None = None
    if roster_map is not None:
        canonical = json.dumps(roster_map, sort_keys=True, separators=(",", ":")).encode("utf-8")
        trusted_roster_sha256 = hashlib.sha256(canonical).hexdigest()

    live_py_digest, live_pb_lean_count = compute_bootstrap_py_digest(bridges_dir)
    live_sh_digest, live_all_lean_count = compute_bootstrap_sh_digest(bridges_dir)

    repo_root = bridges_dir.parent.parent
    root_roster_nodes = parse_roster_markdown(repo_root / "QUORUM-ROSTER.md")
    eb_roster_nodes = parse_roster_markdown(entries_dir / "QUORUM-ROSTER.md")

    entry_files = sorted(entries_dir.glob("*.quorum-entry.json"))
    per_entry_results: list[dict[str, Any]] = []
    pubkey_counter: Counter[str] = Counter()
    node_id_counter: Counter[str] = Counter()
    scheme_counter: Counter[str] = Counter()
    custody_class_counter: Counter[str] = Counter()
    digest_cohorts: dict[str, list[dict[str, Any]]] = defaultdict(list)

    valid_count = 0
    invalid_count = 0

    for fpath in entry_files:
        try:
            raw = json.loads(fpath.read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError) as exc:
            invalid_count += 1
            scheme_counter["malformed_json"] += 1
            per_entry_results.append({
                "file": fpath.name,
                "valid_signature": False,
                "signature_scheme": "malformed_json",
                "detail": str(exc),
            })
            continue

        if not isinstance(raw, dict):
            invalid_count += 1
            scheme_counter["malformed_json_type"] += 1
            per_entry_results.append({
                "file": fpath.name,
                "valid_signature": False,
                "signature_scheme": "malformed_json_type",
                "detail": "top-level JSON value is not an object",
            })
            continue

        node_id = str(raw.get("node_id", ""))
        pub_hex = str(raw.get("public_key", ""))
        digest = str(raw.get("evidence_digest", ""))
        epoch = raw.get("epoch")
        lean_files = raw.get("lean_files")

        ok, scheme, detail = verify_entry_signature(raw, trusted_roster_sha256=trusted_roster_sha256)
        custody_class, custodian_id = classify_custody(raw, pinned_custodians)

        if ok:
            valid_count += 1
        else:
            invalid_count += 1

        scheme_counter[scheme] += 1
        custody_class_counter[custody_class] += 1
        if pub_hex:
            pubkey_counter[pub_hex] += 1
        if node_id:
            node_id_counter[node_id] += 1

        matches_live = digest in {live_py_digest, live_sh_digest} and bool(digest)
        rec = {
            "file": fpath.name,
            "node_id": node_id,
            "epoch": epoch,
            "lean_files": lean_files,
            "public_key_prefix": pub_hex[:16],
            "public_key": pub_hex,
            "evidence_digest": digest,
            "valid_signature": ok,
            "signature_scheme": scheme,
            "detail": detail,
            "custody_class": custody_class,
            "custodian_id": custodian_id,
            "matches_live_working_tree_digest": matches_live,
        }
        per_entry_results.append(rec)
        if ok:
            digest_cohorts[digest].append(rec)

    duplicate_pubkeys = sorted(pk for pk, cnt in pubkey_counter.items() if cnt > 1)
    duplicate_node_ids = sorted(nid for nid, cnt in node_id_counter.items() if cnt > 1)

    cohort_summaries: list[dict[str, Any]] = []
    for dig, members in sorted(digest_cohorts.items(), key=lambda kv: (-len(kv[1]), kv[0])):
        epochs = sorted({m["epoch"] if m["epoch"] is not None else "unversioned" for m in members}, key=str)
        distinct_pks = {m["public_key"] for m in members}
        pinned_ops = {
            m["custodian_id"]
            for m in members
            if m["custody_class"] == "pinned_human_or_org_custodian"
        }
        effective_ops = {m["custodian_id"] for m in members}
        cohort_summaries.append({
            "evidence_digest": dig,
            "epochs_observed": epochs,
            "lean_files_reported": sorted({m["lean_files"] for m in members if m["lean_files"] is not None}),
            "valid_signatures": len(members),
            "distinct_public_keys": len(distinct_pks),
            "pinned_independent_custodians": len(pinned_ops),
            "effective_custody_domains_upper_bound": len(effective_ops),
            "matches_live_tree": dig in {live_py_digest, live_sh_digest},
            "node_ids": [m["node_id"] for m in members],
        })

    max_single_digest_valid_pks = max(
        (c["distinct_public_keys"] for c in cohort_summaries), default=0
    )
    max_single_digest_pinned_custodians = max(
        (c["pinned_independent_custodians"] for c in cohort_summaries), default=0
    )
    live_cohort_pinned_custodians = sum(
        c["pinned_independent_custodians"] for c in cohort_summaries if c["matches_live_tree"]
    )

    repair_status = inspect_repair_suite(bridges_dir)

    all_pinned_custodians = {
        r["custodian_id"]
        for r in per_entry_results
        if r.get("valid_signature") and r.get("custody_class") == "pinned_human_or_org_custodian"
    }

    bft_quorum_met = (
        repair_status["present"]
        and len(duplicate_pubkeys) == 0
        and live_cohort_pinned_custodians >= q_thresh
    )

    return {
        "schema": "upt-gmesh-strict-quorum-audit-v1",
        "target_bft_parameters": {
            "committee_size_n": target_n,
            "fault_tolerance_f": target_f,
            "quorum_threshold_n_minus_f": q_thresh,
            "honest_overlap_floor_n_minus_2f": overlap_min,
            "three_f_plus_one_check": target_n >= 3 * target_f + 1,
        },
        "live_working_tree": {
            "bootstrap_py_physical_bridges_sha256": live_py_digest,
            "physical_bridges_lean_files": live_pb_lean_count,
            "bootstrap_sh_all_lean_double_sha256": live_sh_digest,
            "all_lean_files": live_all_lean_count,
            "repair_nonvacuity_suite": repair_status,
        },
        "roster_markdown_cross_check": {
            "root_quorum_roster_md_count": len(root_roster_nodes),
            "execution_boundary_quorum_roster_md_count": len(eb_roster_nodes),
            "quorum_entry_json_file_count": len(entry_files),
        },
        "cryptographic_summary": {
            "total_entry_files": len(entry_files),
            "valid_ed25519_signatures": valid_count,
            "invalid_ed25519_signatures": invalid_count,
            "distinct_public_keys": len(pubkey_counter),
            "duplicate_public_keys": duplicate_pubkeys,
            "duplicate_node_ids": duplicate_node_ids,
            "signature_schemes": dict(scheme_counter),
            "distinct_evidence_digests": len(cohort_summaries),
            "entries_matching_live_working_tree_digest": sum(
                1 for r in per_entry_results if r.get("matches_live_working_tree_digest")
            ),
        },
        "custody_and_sybil_summary": {
            "custody_manifest_supplied": custody_manifest is not None,
            "classification_counts": dict(custody_class_counter),
            "verified_independent_human_or_org_custodians": len(all_pinned_custodians),
            "llm_session_sybil_entries": custody_class_counter.get(
                "ephemeral_llm_session_unpinned", 0
            ),
            "distinct_custodians_invariant_satisfied": (
                len(all_pinned_custodians) == valid_count and valid_count > 0
            ),
            "sybil_vulnerability_note": (
                f"Root QUORUM-ROSTER.md lists {len(root_roster_nodes)} LLM-session entries "
                f"({custody_class_counter.get('ephemeral_llm_session_unpinned', 0)} JSON session "
                f"files on disk) under unpinned local host custody. By "
                f"RepairGMeshByzantineQuorum.correlated_operator_sybil_breaks_bft, >=15 keys "
                f"controlled by 1 operator exceed f={target_f} on a {target_n}-node roster and "
                f"enable a 1-operator conflicting {q_thresh}-of-{target_n} quorum fork."
            ),
        },
        "quorum_progress": {
            "required_independent_custodians_q": q_thresh,
            "raw_valid_signatures_any_digest": f"{valid_count}/{q_thresh}",
            "largest_single_digest_distinct_keys": f"{max_single_digest_valid_pks}/{q_thresh}",
            "largest_single_digest_independent_custodians": (
                f"{max_single_digest_pinned_custodians}/{q_thresh}"
            ),
            "live_post_repair_digest_independent_custodians": (
                f"{live_cohort_pinned_custodians}/{q_thresh}"
            ),
            "remaining_independent_custodians_needed_for_live_quorum": max(
                0, q_thresh - live_cohort_pinned_custodians
            ),
            "bft_quorum_met": bft_quorum_met,
        },
        "digest_cohorts": cohort_summaries,
        "entries": per_entry_results,
    }


def format_human_report(report: dict[str, Any]) -> str:
    tgt = report["target_bft_parameters"]
    live = report["live_working_tree"]
    repair = live["repair_nonvacuity_suite"]
    crypto = report["cryptographic_summary"]
    custody = report["custody_and_sybil_summary"]
    prog = report["quorum_progress"]
    xchk = report["roster_markdown_cross_check"]

    lines: list[str] = []
    lines.append("=" * 78)
    lines.append("G-MESH STRICT BYZANTINE QUORUM & CUSTODY AUDIT")
    lines.append("=" * 78)
    lines.append(
        f"Target BFT Committee : n = {tgt['committee_size_n']}, f = {tgt['fault_tolerance_f']}, "
        f"quorum q = n - f = {tgt['quorum_threshold_n_minus_f']}, "
        f"overlap >= n - 2f = {tgt['honest_overlap_floor_n_minus_2f']}"
    )
    lines.append(
        f"Roster Cross-Check   : {crypto['total_entry_files']} *.quorum-entry.json files | "
        f"{xchk['root_quorum_roster_md_count']} in root QUORUM-ROSTER.md | "
        f"{xchk['execution_boundary_quorum_roster_md_count']} in execution-boundary/QUORUM-ROSTER.md"
    )
    lines.append("")
    lines.append("1. Ed25519 Cryptographic Verification")
    lines.append("-" * 78)
    lines.append(
        f"  Valid signatures     : {crypto['valid_ed25519_signatures']} / {crypto['total_entry_files']} "
        f"(invalid: {crypto['invalid_ed25519_signatures']})"
    )
    for scheme, count in sorted(crypto["signature_schemes"].items()):
        lines.append(f"    - {scheme}: {count}")
    lines.append(
        f"  Public-key Nodup     : {crypto['distinct_public_keys']} distinct keys "
        f"(duplicates: {len(crypto['duplicate_public_keys'])})"
    )
    lines.append(
        f"  Matches live tree    : {crypto['entries_matching_live_working_tree_digest']} / "
        f"{crypto['total_entry_files']}"
    )
    lines.append("")
    lines.append("2. Epoch & Evidence-Digest Fragmentation (`gmesh_quorum_attestation_unique`)")
    lines.append("-" * 78)
    lines.append(
        f"  Distinct digests     : {crypto['distinct_evidence_digests']} incompatible digest cohorts "
        f"(signatures across distinct digests cannot be summed)"
    )
    for idx, c in enumerate(report["digest_cohorts"], start=1):
        ep_str = ",".join(str(e) for e in c["epochs_observed"])
        lf_str = ",".join(str(x) for x in c["lean_files_reported"]) or "unspecified"
        lines.append(
            f"  [{idx}] digest={c['evidence_digest'][:16]}... | epoch={ep_str} | "
            f"lean_files={lf_str} | valid_sigs={c['valid_signatures']} | "
            f"indep_custodians={c['pinned_independent_custodians']}"
        )
    lines.append("")
    lines.append("3. Sybil / LLM-Session vs Independent Custodian Audit (`DistinctCustodians`)")
    lines.append("-" * 78)
    lines.append(
        f"  Ephemeral LLM-session entries : {custody['llm_session_sybil_entries']} / "
        f"{crypto['total_entry_files']} (correlated single-operator host custody)"
    )
    lines.append(
        f"  Verified independent custodians: {custody['verified_independent_human_or_org_custodians']}"
    )
    lines.append(
        f"  DistinctCustodians satisfied  : {custody['distinct_custodians_invariant_satisfied']}"
    )
    lines.append(f"  Diagnostic: {custody['sybil_vulnerability_note']}")
    lines.append("")
    lines.append("4. `Repair*` Non-Vacuity & `#upt_tooth` Qualification Suite")
    lines.append("-" * 78)
    lines.append(
        f"  Core Repair* suite present : {repair['present']} "
        f"({repair['repair_file_count']} files, {repair['upt_tooth_total']} #upt_tooth gates)"
    )
    for rf in repair["repair_files"]:
        tcnt = repair["upt_tooth_directives_by_file"].get(rf, 0)
        ccnt = repair["upt_census_directives_by_file"].get(rf, 0)
        lines.append(f"    - {rf}: {tcnt} #upt_tooth, {ccnt} #upt_census")
    if repair["missing_core_files"]:
        lines.append(f"    - MISSING: {', '.join(repair['missing_core_files'])}")
    lines.append(
        f"  Live PhysicalBridges SHA256: {live['bootstrap_py_physical_bridges_sha256'][:24]}... "
        f"({live['physical_bridges_lean_files']} files)"
    )
    lines.append("")
    lines.append("5. Progress Toward BFT Quorum (`n = 43, f = 14, q = n - f = 29`)")
    lines.append("-" * 78)
    lines.append(f"  Raw valid sigs (all digests, unpinned)   : {prog['raw_valid_signatures_any_digest']}")
    lines.append(f"  Largest single-digest key cohort         : {prog['largest_single_digest_distinct_keys']}")
    lines.append(
        f"  Verified independent custodians (live)   : "
        f"{prog['live_post_repair_digest_independent_custodians']} "
        f"({prog['remaining_independent_custodians_needed_for_live_quorum']} more needed)"
    )
    lines.append(f"  STRICT BFT QUORUM MET                    : {prog['bft_quorum_met']}")
    lines.append("=" * 78)
    return "\n".join(lines)


def verify_lean_repair_module(bridges_dir: Path) -> tuple[bool, str]:
    """Optionally typecheck `PhysicalBridges/RepairGMeshByzantineQuorum.lean` via `lake env lean`."""
    target = bridges_dir / "PhysicalBridges" / "RepairGMeshByzantineQuorum.lean"
    if not target.is_file():
        return False, f"missing {target}"
    proc = subprocess.run(
        ["lake", "env", "lean", "PhysicalBridges/RepairGMeshByzantineQuorum.lean"],
        cwd=str(bridges_dir),
        capture_output=True,
        text=True,
        timeout=180,
        check=False,
    )
    out = (proc.stdout + proc.stderr).strip()
    return proc.returncode == 0, out


def build_arg_parser() -> argparse.ArgumentParser:
    default_entries = Path(__file__).resolve().parent
    default_bridges = default_entries.parent / "physical-bridges"

    p = argparse.ArgumentParser(
        description=(
            "Cryptographic, epoch-coherence, and independent-custody verifier for G-Mesh "
            "quorum entries (backed by PhysicalBridges/RepairGMeshByzantineQuorum.lean)."
        )
    )
    p.add_argument(
        "--audit-existing",
        action="store_true",
        help=(
            "Audit all *.quorum-entry.json files in evidence/execution-boundary/, "
            "check Repair* non-vacuity modules, and report n - f progress toward n=43, f=14, q=29."
        ),
    )
    p.add_argument(
        "--entries-dir",
        type=Path,
        default=default_entries,
        help="Directory containing *.quorum-entry.json files (default: evidence/execution-boundary).",
    )
    p.add_argument(
        "--bridges-dir",
        type=Path,
        default=default_bridges,
        help="Path to evidence/physical-bridges (default: ../physical-bridges).",
    )
    p.add_argument(
        "--custody-manifest",
        type=Path,
        default=None,
        help="Optional JSON file mapping 64-hex Ed25519 public_key -> independent operator_id.",
    )
    p.add_argument(
        "--trusted-roster",
        type=Path,
        default=None,
        help="Optional pinned 3f+1 JSON roster mapping node_id -> 64-hex Ed25519 public_key.",
    )
    p.add_argument(
        "--committee-size",
        type=int,
        default=TARGET_N,
        help=f"Target BFT committee size n >= 3f + 1 (default: {TARGET_N}).",
    )
    p.add_argument(
        "--fault-tolerance",
        type=int,
        default=TARGET_F,
        help=f"Target Byzantine fault tolerance f (default: {TARGET_F}).",
    )
    p.add_argument(
        "--check-lean-gate",
        action="store_true",
        help="Also run `lake env lean PhysicalBridges/RepairGMeshByzantineQuorum.lean`.",
    )
    p.add_argument(
        "--require-quorum",
        action="store_true",
        help="Exit non-zero (code 2) unless the strict independent-custodian quorum is met.",
    )
    p.add_argument(
        "--json",
        action="store_true",
        help="Emit full machine-readable JSON audit report instead of human-readable table.",
    )
    return p


def main(argv: list[str] | None = None) -> int:
    parser = build_arg_parser()
    args = parser.parse_args(argv)

    if not args.audit_existing and not args.check_lean_gate:
        parser.print_help(sys.stderr)
        return 2

    try:
        report = audit_existing(
            args.entries_dir.resolve(),
            args.bridges_dir.resolve(),
            target_n=args.committee_size,
            target_f=args.fault_tolerance,
            custody_manifest=args.custody_manifest,
            trusted_roster=args.trusted_roster,
        )
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        print(f"[ERROR] {exc}", file=sys.stderr)
        return 1

    if args.check_lean_gate:
        lean_ok, lean_out = verify_lean_repair_module(args.bridges_dir.resolve())
        report["lean_kernel_gate"] = {
            "passed": lean_ok,
            "output": lean_out,
        }
        if not lean_ok:
            if args.json:
                print(json.dumps(report, indent=2, sort_keys=True))
            else:
                print(format_human_report(report))
                print(f"\n[LEAN KERNEL GATE FAILED]\n{lean_out}", file=sys.stderr)
            return 1

    if args.json:
        print(json.dumps(report, indent=2, sort_keys=True))
    else:
        print(format_human_report(report))

    if args.require_quorum and not report["quorum_progress"]["bft_quorum_met"]:
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
