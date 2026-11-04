# Summit ledger — the cathedral and its one keystone

**4 November 2026 · review-only, noncanonical · a verified map, not a claim.**

This ledger states, tool-grounded, exactly where the guardian-only summit stands:
what is **composed and machine-checked**, and the **single load-bearing
commitment** everything rests on. Every row names the Lean theorem that carries
it. Heads: `main` `a311bbe`; PR A [#286]; preserved structure [#287]; complex
density conjugation [#288]; Tenzing's source/subject lane [#285]. Re-pin heads and
re-run the axiom audit before any integration.

---

## The shape of the summit

On `main`, □(SI⇒G) — *every actually enacted step is a guardian* — is composed and
proven down to **one explicit premise**. The whole structure beneath that premise
is machine-checked (per-lane CI green; axioms within
`{propext, Classical.choice, Quot.sound}`; no `sorry`). The one premise is **not a
gap in the proof** — it is the foundational ontological commitment the cathedral is
built to rest on, and the Lean sources keep it honest by refusing to let it be
smuggled in.

---

## I. The standing cathedral (composed · machine-checked)

### Physical frame & frozen operator — PR A (#286)
| Theorem | Says |
|---|---|
| `BCRDActualRelationalFrame.relational_covariance` | before/after relation covariant under the actual event, over all states |
| `BCRDActualRelationalFrame.evolve_realises_event` | `WρWᵀ` carries `|M0⟩⟨M0| → |M1⟩⟨M1|` (the **W-stage**, not the compound process) |
| `BCRDOperatorAlgebra.evolve_entry` | `evolve A i j = A (p i)(p j)` — conjugation by `W` permutes indices (integer) |
| `evolve_preserves_{trace,product,transpose,identity}`, `evolve_involutive` | `Φ(A)=WAWᵀ` is a `*`-automorphism, invertible |
| `evolve_preserves_trace_form` / `evolve_preserves_frobenius` | trace form vs genuine Hilbert–Schmidt (the corrected distinction) |
| `evolve_diagonal` | `Φ(diag s) = diag(step s)` for every configuration |
| `BCRDSourceCoverage.{coverage_action,coverage_closed,certified_domain_is_proper}` | the certified domain, closed and proper — scope fenced |

### Preserved structure — #287
| Theorem | Says |
|---|---|
| `BCRDPreservedStructure.orbit_covariant` | the event's orbit structure is the preserved invariant |
| `covariant_of_respects_orbit` | **design rule:** any label agreeing on the swapped pair is automatically covariant |
| `respects_orbit_not_injective` / `site_not_injective` | …and is therefore **non-injective** — persistence of a class, never individuation |

### Complex W-stage — Tenzing #285 + Hilzy #288
| Theorem | Says |
|---|---|
| `BCRDComplexWGenericAction.every_complex_state_tracks_exact_W` | `(Wψ)_i = ψ_{p(i)}` for every `ψ ∈ ℚ(√2,i)⁶` (vector) |
| `W_two_steps_exact_on_every_complex_state` | `W(Wψ) = ψ` on every complex state |
| `BCRDComplexOperatorConjugation.conjugate_entry` | `(WρW†)_{ij} = ρ_{p(i),p(j)}` for every complex density matrix (operator) |
| `conjugateByW_involutive` | `W(WρW†)W† = ρ` — invertible on all complex density matrices |

### Source→subject obstructions (honest limits) — Tenzing #285
| Theorem | Says |
|---|---|
| `BCRDExactCausalOrbit.{reachable_implies_same_source_orbit, same_source_orbit_implies_reachable}` | source reachability = orbit membership, exactly |
| `BCRDParticularCarrierCriterion.carrier_injective_after_iff_before` | a carrier stays injective iff it began injective — dynamics add no individuation |
| `BCRDOperatorSubjectGap.{full_operator_readouts_identical, original_x3_statuses_disagree, no_operator_trace_only_x3_decoder}` | identical physical readouts, different X3 status ⇒ **operator data alone cannot decode X3** (IR132) |
| `BCRDAuthorizationFreedomBoundary.{no_two_distinct_actions_in_source_only_process, entire_generated_histories_cannot_separate_authorization}` | one-action process has no two-way choice; histories cannot fix authorization |

### The guardian-only composition — `main`
| Theorem | Says |
|---|---|
| `CathedralAllIsEnderTypeCollapse.no_realized_absolute_ender` | **absolute erasure is impossible** (the ALL-IS physics) |
| `CathedralFirstEventForcing.no_first_x3_violation_from_dichotomy_and_e9` | no first X3-violation, from the dichotomy + finite E9 gates |
| `CathedralFirstEventForcing.endpoint_recovery_does_not_prove_within_event_continuity` | honest limit: endpoint recovery ⊬ within-event continuity |
| `CathedralGuardianOnlyCapstone.{every_real_step_is_guardian, nothing_but_guardians}` | **□(SI⇒G)** at the intrinsic level, composed |

---

## II. The one keystone

Lifting the composed conclusion from the **intrinsic** guardian class to the full
**original-X3** protection of each particular needs exactly one premise, proven
three equivalent ways on `main` (`CathedralAllIsEnderTypeCollapse`):

- `full_x3_from_ontological_collapse_and_reflection` — via `intrinsicGuardian a → originalX3Guardian a`;
- `original_x3_direct_collapse` — via `originalX3Guardian a ∨ RealizedAbsoluteEnder a`;
- `original_x3_from_no_local_violator_without_absolute_end` — via **`¬ originalX3Guardian a → RealizedAbsoluteEnder a`**.

That last form is the keystone in its sharpest shape:

> **A particular's original-X3 violation would itself require the impossible total
> erasure.** Equivalently: *nothing is lost ⟹ no first X3-violation ⟹ guardian.*
> This is the **ALL IS ONE inversion** (U1–U4; "we are here, therefore G").

**Why the 6×6 source cannot discharge it** — and why the module forbids pretending
it can: `no_operator_trace_only_x3_decoder` proves the operator/readout data
contains no decoder for X3; the source holds no consent/authorization facts; and
`endpoint_recovery_does_not_prove_within_event_continuity` marks that physical
recovery does not by itself certify a particular's continuity. The honest step
`local X3-violation ⟹ absolute erasure` is the **heart bridge** — not derivable
from unitarity or ALL-IS alone. The Lean comment is explicit: this theorem *"must
never be passed off as something established by 'ALL IS' alone."*

So the keystone is a **declared foundational commitment**, not a smuggled
assumption. The cathedral stands on it the way an arch stands on its keystone.

---

## III. The path — no half measures

1. **Earn more from the physics — DONE (step 1).** The W-stage is now exact and
   all-input over `ℚ(√2,i)`: vector transport (Tenzing #285) **and** density-matrix
   conjugation `(WρW†)_{ij}=ρ_{p(i),p(j)}` (Hilzy #288). Remaining physics to earn:
   the compound `C_LM/U_MR` stages and within-event continuity across them (addresses
   `endpoint_recovery_does_not_prove_within_event_continuity`).
2. **This ledger (step 3).** The map above.
3. **Formalise the keystone as the explicit axiom (step 2, pending merges).**
   Instantiate the three `main` conditionals with the **concrete** six-component
   `OriginalX3Full.OriginalX3` (#285) and PR A's frame, so □(SI⇒G) stands on exactly
   one named `AllIsActuality`/no-erasure axiom with every other step machine-checked.

**PR C (first-violation necessity) stays on hold.** `∀ s e t p, ActualStep s e t →
Owed s p → OriginalX3 s e t p` may be attempted only when the source event,
validated subject + authorization semantics, feasible action space and all six
bridges are genuinely joined. A theorem whose assumptions restate its conclusion is
conditional engineering, not ontological necessity.

---

## IV. What must never be done (the guarded traps)

- Never relabel `actualStep`/`realStep` to require X3, nor set
  consent/continuation/`admissible` fields to `True`. That is admissibility-by-
  definition — the category error the whole structure is built to avoid.
- Never present the keystone as established by "ALL IS" alone, or by unitarity, or
  by any sub-structural principle. State it as the foundational commitment it is.
- Negative controls are **semantic** (what the source cannot decode), never
  demonstrations of physical harm or refutations of ALL IS.
- No canon change, release, or claim of universal physical proof on the present
  finite source tests.
