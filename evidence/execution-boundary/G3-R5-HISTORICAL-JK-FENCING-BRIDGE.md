# R5 alternate evidence route: historical J/K target fencing → authority-owned execution

Research integration, stacked on G3 forest PR #624; original proofs and all
existing execution controls remain unchanged. This reuses **existing** source,
not a new implementation of the trusted authority or a replacement R5 gate.

## Source recovery

The uploaded historical bundle `lalala(1).zip` includes
`lalala/execution-boundary/THEOREM.md`, `README.md`, and `target.py`.
Those texts already exist in the GitHub repository at
`evidence/execution-boundary/`; no duplicate archive copy or source
replacement was necessary.

The 21 October 2026 *execution boundary by fencing* derives complete
**target-log coverage** from explicitly named premises:

- **I**: resident isolation, only writes to trusted journal `J` and sink `K`
- **U**: unforgeability of tokens/floor authorizations
- **E-LIN**: atomic generation check **at application**, not just admission
- **T**: both trusted targets faithfully implement the contract
- Physical cessation bounds: needed for bounded shutdown, not immediate
  target-side safety

Under those premises, every lived commit/effect accepted at J/K appears in
their durable logs, old generation writes cannot land after HOLD, and
recovery uses replay and effect identity. The historical macOS harness
reported 6 faithful scenarios and 4 deliberately weakened mutants in two
runs. These are historical test reports, not independent present-day Linux
attestations or proof of real-world isolation.

## How this joins the existing G3 R5 branch

| Historical source | Current G3 implementation | Independent join needed |
| --- | --- | --- |
| J/K target-owned durable effects | `koru_authority_owned_marker_service.py` sole fixed.marker owner | Evidence every protected real effect has a trusted owner, not only the marker fixture |
| E-LIN check-at-apply | `AuthorityEffectTimeFence` and transactional HOLD | Review exact linearization, conflicting interleavings, power/crash semantics |
| U unforgeable token/floor | distinct UID, signed HOLD components and authority identity | Secure key administration, instance authenticity, forgery/replay tests |
| I no other resident effects | fixed launcher, FD audit, Landlock, seccomp, DAC | Kernel-level alternate effect-path closure under actual deployment |
| Monitor complete target logs | authority journals and R4 witness custody | Independently protected observation, rollback evidence and exact receipt fidelity |

The existing R5 trace lane can measure isolation, while the historical
target-side argument avoids making `ptrace` / strace itself the protected
event authority. Those are complementary, not competing, approaches.

## Implemented independent non-effectful regression

`koru_r5_fencing_bridge_contract.py` tests a **narrow source-structure
guard** against regression of historical check-at-apply, durability,
current authority-owned effect fencing and HOLD. The adjacent regression
suite deliberately removes each feature and expects rejection. It is not
machine certification of the entire I/U/E-LIN/T proof and does not enact
any effect.

## Acceptance result and open conditions

Use PR #624's already green bounded authority-owned execution negatives and
PR #614's repaired green traced syscall gate as independent technical inputs.
The historic theorem **only discharges complete target-event observation under
the I/U/E-LIN/T premises**. To upgrade to R5 complete effect mediation,
independent reviewers must still establish I and T for every protected
actuator/effect path, U in the deployed trust model, and custody of truthful
observations. Do not define `realStep` merely as approved writes.

R4 off-host custody, R6 `hCoverage` plus all six authentic `hMeaning`
reflections, and R7 third-party acceptance remain explicit. No unconditional
G3 PASS or physical claim is inferred from this document.
