# G3 bounded-workload integration dossier — candidate 0 (research only)

**Status:** stacked draft, **NOT a production release or safety certificate**. Exact integration head to be recorded only after all required CI workflows complete successfully. Never treat a passed ancestor run as verification of this new head.

## Reproducibility and scope

- Repository: `Tobillicious/universal-protection-theory`
- Target branch: `g3/integrated-evidence-manifest-20261117` (stacked on draft #579)
- Base chain: #572 → #573 → #574 → #575 → #576 → #577 → #578 → #579 → this candidate.
- One disposable Linux (Ubuntu 24.04) same-host research fixture; Python 3.13; CI pins `cryptography==46.0.4`.
- **Protected effect:** creation of one zero-byte authority-owned `fixed.marker` in a temporary directory; not arbitrary file, process, network, or physical-world effects.
- **Trusted boundaries:** Linux kernel SO_PEERCRED, UID/GID and Unix DAC, selected Landlock/seccomp/FD-audit startup restrictions, authority-owned directory and SQLite journal. Host root, kernel compromise and controller UID compromise are excluded.
- **Source integrity:** `koru_fixed_workload_contract.py`, `koru_pinned_security_dependencies.py`, `koru_fixed_entrypoint_freeze.py`, and `koru_second_hop_dependency_contract.py` constrain the reviewed sources and local imports. They do not prove the runtime import loader, executable interpreter, shared libraries, environment or full transitive trust closure.

## Protection evidence matrix

| Obligation | Mechanism | Verification entrypoints | Evidence class |
| --- | --- | --- | --- |
| Restrict synthetic effect to authority UID | Authority-owned marker service, private dirfd, kernel DAC | `test_koru_authority_owned_marker_service`; `test_koru_no_inherited_fd_executor` | Linux research tests |
| Only exact, credentialed fixed operation | Unix peer credentials and fixed-schema JSON | `test_koru_authority_malformed_wire`; `test_koru_fixed_workload_contract` | Linux and syntactic tests |
| Serialize HOLD against effect | Shared SQLite BEGIN IMMEDIATE and admission/fence | `test_koru_authority_crossprocess_race`; `test_koru_authority_effect_time_fence` | Cross-process tests |
| Deny uncertain restart/replay | Durable admission/started records; no automatic retry | `test_koru_authority_owned_sigkill`; `test_koru_emergency_hold_persistence` | Crash/restart tests |
| Constrain stalled ordinary requests | Bounded worker slots and monotonic read deadline | `test_koru_authority_reserved_hold_capacity` | Hostile-load Linux tests |
| Keep emergency HOLD ingress distinct | Separate Unix socket listener, root-provisioned setgid directory, controller-GID DAC, SO_PEERCRED | `test_koru_emergency_hold_endpoint`; `test_koru_emergency_hold_persistence` | Dual-listener Linux tests |
| Detect reviewed source drift | Git blob pins, strict local import checks, source freeze | `test_koru_pinned_security_dependencies`; `test_koru_fixed_entrypoint_freeze`; `test_koru_second_hop_dependency_contract` | Deterministic source checks |
| Independently certify authentic subjects and original six X3 duties | Not part of this fixture | No executable authentic subject/effect refinement for this fixture | **Open** |
| Prove universal/physical-world protection | Not supplied by this fixture | No evidence of complete physical event coverage | **Open** |

These tests are listed in `.github/workflows/g3-cross-uid-signed-hold-research.yml`. The CI job is **non-deploying** and root-launched only in a disposable Linux runner. All expected results must be checked for the **actual candidate head**. Tests of other branches do not transfer automatically.

## Required release gates

**R0. Build identity:** record the exact Git SHA, checked source blob hashes, interpreter executable digest, OS image, installed packages and native libraries. **Partially instrumented, not certified.** The stacked A10 branch runs `koru_runtime_evidence.py` in CI against an explicit PR-head checkout and archives source SHA-256s, Python executable digest, selected `_ssl`, `_sqlite3`, and cryptography extension digests, Python version, Linux kernel identifier, and cryptography package version. Full interpreter/native library closure, independently authenticated provenance, and evidence for separately spawned executor/authority processes remain **open**. The artifact is observational and self-reported by the CI runner; it is not hardware-backed attestation.

**R1. Full-suite replay:** all mandatory workflows on the exact candidate SHA must succeed, especially disposable cross-UID signed HOLD integration. **Pending for this candidate.**

**R2. Runtime trust closure:** demonstrate that the exact executed artifact is the reviewed artifact, including dynamic imports, interpreter and native dependencies. **Open.**

**R3. Availability failure model:** test kernel listen backlog pressure, controller-identity abuse, SQLite lock contention, CPU/memory/disk exhaustion, and the safety outcome if HOLD cannot complete. Existing tests cover bounded ordinary-side saturation but not all these adversaries. **Open.**

**R4. Independent authority:** at least one history witness/checkpoint outside a compromised host administrator's rollback domain, plus authenticated reconciliation of conflicts. **Open.**

**R5. No unmediated effects:** explicit syscalls, descriptors, IPC channels, effect routes and host policy under the exact executor configuration, independently tested and reviewed. **Open.**

**R6. Authentic protected subject obligations:** validate all applicable X3/rights/withdrawal evidence against actual subjects and every in-scope real-world effect, not proxy booleans. **Open.**

**R7. Independent reproduction:** independent reviewer repeats build, fault injection, and adversarial tests with pass/fail records bound to the candidate SHA. **Open.**

## CI verification protocol

1. Record exact `git rev-parse HEAD` for the candidate branch and read the actual workflow at this SHA.
2. Check **all six workflow conclusions** at that head; inspect failures and skipped jobs rather than borrowing prior successful checks.
3. Confirm the `G3 cross-UID signed HOLD research` job executed `test_koru_emergency_hold_endpoint` and `test_koru_emergency_hold_persistence`, not just green unrelated jobs.
4. Re-run the previously reported four adversarial source mutations against the current frozen authority/launcher and pin checks.
5. Record artifacts/hashes and independent reviewer decisions. Do not mark a gate complete from passing test names alone.

## Nonclaims

This dossier does **not** assert G3 is universally or physically unconditional, prove God, guarantee high availability under compromised host/control identities, certify realistic consent, or authorize a real-world deployment. It defines a narrow first workload and the remaining obligations so evidence can be independently improved without erasing prior mathematics or weakening protection.
