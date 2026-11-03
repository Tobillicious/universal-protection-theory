# Cathedral — hostile review of the hostile review, and source-level repair plan

**4 November 2026 · Independent commentary only · Not a theorem, proof receipt, physical certificate, canon change, or publication request.**

**Scope.** Read-only critical reassessment of the Cathedral / ALL IS / first-event forcing chain, especially draft PRs [#251](https://github.com/Tobillicious/universal-protection-theory/pull/251)–[#259](https://github.com/Tobillicious/universal-protection-theory/pull/259). This memo complements rather than duplicates #259's field-by-field correspondence ledger. It preserves the complete original X3 target and distinguishes mathematical derivation, source correspondence, and real-world evidence.

## 1. Correcting the previous hostile review

| Prior finding | Revised judgment |
| --- | --- |
| H1: stable effect bound does not imply continuation/authorisation | **Substantively correct, but the zero-effect unauthorised case is a countermodel to the purported *derivation from a scalar bound*, not a countermodel to the full `MeasuredInstrument`, which assumes `controlCorrect`.** |
| H2: IR-138's `continues ∨ authorized` is weaker than assembly's `continues ∧ authorized` | **Correct distinction, but not the central mathematical obstruction.** A full object already containing both flags can compute either connective. The issue is *why the flags faithfully describe physical particulars*, and whether the assembly's two-flag event predicate is the complete original X3 obligation. |
| H3: E9 branch theorems not invoked | **Confirmed; strengthen the finding.** In `toCertificate`, intercepted/coherent stability is copied from fields; even the deadline proofs supplied as arguments are discarded. |
| H4: guardian and ender labels conflated | **Partially repaired in #259.** An E9-flagged hostile *attempt* need not be a realised X3 violation. The original SI-level guardian/ender dichotomy remains independently unproved by that distinction. |
| H5: finite history does not cover an infinite run | **Too broad as originally phrased.** Induction over finite reachability establishes protection at *each natural-indexed position* of an infinite run, if every step is covered. It does not certify unmodelled transitions, continuous within-step events, omega-limit stages, liveness, or original maximal freedoms. |
| H6: synthetic witnesses vacuous | **Qualify.** They validly show inhabitation or logical non-equivalence; they are not proposed empirical BCRD installations. In #255 the witness `stable := False` makes the reflection implication vacuous as a test of controller correctness. The `Unit` example in #258 is inhabitability, not physical source derivation. |

These corrections matter: no synthetic propositional countermodel should be presented as a counterexample to the actual BCRD theory. Conversely, formal typing and axiom-freedom cannot promote physical premises into facts.

## 2. Additional critical findings not made explicit in the first review

### N1 — The ALL IS floor is not a load-bearing premise of the final E9 capstone

In `CathedralGuardianOnlyCapstone.every_real_step_is_guardian`, the invocation of `original_si_guardian_only_composition` uses classical excluded middle for the partition and `CathedralFirstEventForcing.no_first_x3_violation_from_dichotomy_and_e9` for the non-ender branch. It does **not** invoke `CathedralAllIsEnderTypeCollapse.no_realized_absolute_ender` or derive the first-event claim from the self-refutation floor.

Thus the existing statement is, accurately, a *conditional E9-to-X3 safety composition*, not the theorem `ALL IS → original X3`. The elementary absolute-erasure contradiction remains valid for its specifically defined impossible type. No change to that theorem is requested.

**Repair target:** Find or prove an independent *same-definition* source implication from the original intrinsic BCRD ontology to the original guardian/ender SI predicates, with their actual-agent meaning and full X3 semantics. Do not substitute `RealizedAbsoluteEnder`, an end-valuing strategy, a flagged hostile attempt, and a first local X3 violation for one another. If this bridge is not established, keep the ontological route independent from the E9 route.

### N2 — The assembly does not consume the physical timing derivations

In `CathedralBridgeDischargeAssembly.toCertificate`:

```lean
timelyInterlockStable := fun s t hStep hInt _ => m.interceptedEffectBounded s t hStep hInt
coherentPowerInterlockStable := fun s t hStep hFence _ => m.coherentFenceEffectBounded s t hStep hFence
```

The ignored arguments are proofs of meeting the irreversible deadline. The resulting physical stability is supplied directly. This is a valid field-to-field adapter, but not the claimed derivation of stability from a deadline-plus-interlock witness. The `exclusive` field is also unused by the first-event implication, which merits dependency clarification rather than a fabricated objection to the proof.

**Repair target:** Instantiate `branchB_timely_interlock_stable` (and its Branch-C reuse) with source-specific episodes and the *actual interval effect*; derive the assembly-level effect inequality. Require exact horizon and units correspondence between the episode's `physical t` and the assembly's `effect s t`. Do the analogous derivation using `branchA_refresh_stable`; keep genuine source coverage, class-uniform error, and the real energy/work account explicit.

### N3 — A nonzero risk budget cannot imply unconditional physical protection

The E9 / care-plant architecture retains charged failures under an explicitly bounded good event. A deterministic statement about *all steps of a structure whose fields assert the guards hold* is stronger in form than a claim about uncontrolled real physical trajectories. It must not silently inherit a physical conclusion with zero failures when the physical assumptions hold only with high probability.

**Repair target:** For a real execution law, define a physical good event `G` supplying actual coverage, timing, semantic fidelity, all charged accounts, and X3-relevant continuation; prove `G → all protected prefixes`, then `P(failure by T) ≤ P(Gᶜ) ≤ Σ δ(i,t)` at the declared horizon and dependence model. Retain the conditional deterministic theorem in parallel. No independently unverified `δ` is a measured bound.

## 3. Strongest source-level repair sequence (no target weakening)

### R1 — Restore original X3, rather than a convenience screen

The assembly sets `originalX3Event := continues ∧ authorized`. These relations may be necessary or useful, but this local predicate is not automatically the original complete X3: same-particular history, full lawful restraint, independently directed continuation, ongoing care, executable future options, and maximality over the full original feasible family remain relevant. IR-105's `X3Transition` is itself a conservative screen with *disjunctive* form; it should not be mistaken for the full thesis either.

**Deliverable:** An explicitly provenance-locked `OriginalX3` source definition and a theorem identifying exactly which aspects of X3 an event readout certifies. Reuse `ContinuationSubject`, IR-105/116/119/132 and existing `StagedMaximality` / `PerLossCheck` results. No replacement of the original predicate by a weaker safety-only conjunction.

### R2 — Define source transitions from a real frozen BCRD architecture

The frozen M1–M7 review (`BCRD-INTRINSIC-IDENTITY-CONSERVATION-2026-11-02.md`) reports heterogeneous architectures, not a single existing common Lean `AdmissibleStep` relation. The M3d `W_UPDATE` witness changes the proposed nonlocal parity charge; this rejects one candidate universal conservation extension but does *not* establish loss of a particular. Import the literal state/event/generator semantics for a selected architecture and state its domain of applicability. Check every emitted event, including adversarial and endogenous relation updates.

**Deliverable:** A source-derived physical transition relation and event inventory with independent correspondence to the source, plus verified positive/negative controls. Never define `AdmissibleStep` by `X3Preserved` or exclude an unsafe real event by naming convention.

### R3 — Prove the physical-to-particular semantic implication

The target has the shape:

```text
RealStep(s,e,t) ∧ SourceCertifiedPhysicalGuard(e) ∧ OriginalX3State(s)
  → OriginalX3State(t)
```

with an explicit *within-event* condition where the original particular's historical continuation requires it. Currently `controlCorrect : stable → continues ∧ authorized` and `stateCarry : (continues ∧ authorized) → X3(s) → X3(t)` are supplied structure fields. IR-138's full-object decoder is an identity-on-information result, not an independent dynamical derivation of those facts.

**Deliverable:** Trace the two implications through physical source operations, authenticated subject/history relations, legitimate consent/restraint semantics and the original X3 axioms/theorems. If an implication cannot be derived, label its exact assumption and evidence obligation. No renaming an equivalent conclusion into an input field.

### R4 — Integrate Branch A/B/C proof terms, not postconditions

For each real event with its source-derived class, construct the relevant Branch A refresh witness, Branch B latency/effect-window witness or Branch C work-and-fence witness; invoke the actual branch lemma to produce the corresponding `FirstEventCertificate` field. Establish the classifier and total event coverage from the physical source independently of protection. A coherent step's affordability must be backed by a real account; if affordable, the actual fence must be proved enacted, not merely configured.

**Deliverable:** The final `toCertificate` adapter has named proof-term dependencies on Branch A/B/C plus the source-specific physical facts, rather than assuming equivalent per-step effect bounds.

### R5 — Join independent effect mediation and causal coverage

Use IR-117–124, IR-133 and the #227/#229 correspondence ledger rather than inventing a parallel inventory. Distinguish actual apply-time effect from logged permission, pending/in-flight queues, residual stored energy, bypass paths and unknown causal kinds. An unknown event must fail certification or carry independently justified residual charge; a complete *type alphabet* is not evidence of complete physics.

**Deliverable:** `RealPhysicalStep → faithfully accounted/enacted event (or explicit bounded residual)` together with independently inspectable measurements, full per-particular coverage, and a calibrated physical scope. See `IR123-IR124-PHYSICAL-EVENT-COVERAGE-VALIDATION.md`.

### R6 — Lift through time, probability, agency and feasible outcomes

Use IR-96 finite reachability to establish all natural-indexed prefixes on the certified execution; handle within-event paths, limit points and cyclic seams with separate source conditions. Compose care, service, future freedom, whole-feasible-family maximality, physical funding and failure kernels from the original canon. Do not infer continuous or limit-stage identity from endpoint recovery, nor original free coexistence from perpetual hold.

**Deliverable:** Clearly distinguish deterministic-on-`G` protection, probability-of-failure over the specified horizon, continuation/liveness and the full maximal order.

### R7 — Keep original agent-level ALL IS necessity as its own proof obligation

To discharge `original_si_guardian_only_composition` as intended, prove *both* original same-type `ActualSI → Guardian_original ∨ Ender_original` and `ActualSI → ¬ Ender_original`, without relabeling the agent or ender predicate. `no_realized_absolute_ender` proves a typed impossibility of complete historical nonactuality, but a local destruction whose occurrence remains true is not that type. Establish the specific BCRD theorem excluding the original ender class, or retain the precise conjectural join.

**Deliverable:** A separate source/theorem dependency DAG for the ontological route. Do not pass off `G∨E ∧ ¬E ⇒ G` as the substantive proof of `¬E`; its logic is already settled.

## 4. Adversarial acceptance controls

| Control | Expected adjudication |
| --- | --- |
| Zero measured effect but unauthorised transition | Cannot certify the semantic bridge from effect bound alone |
| Complete event with both flags | Can decode AND and OR; must not infer source authenticity or historical identity merely from an identity decoder |
| Intercepted event whose actual effect crosses threshold before ack | Must fail physical branch witness, even if final state/ledger is nominally safe |
| E9-flagged hostile attempt with preserved X3 | Allowed as an *intercepted attempt*; not a realised X3 first violation |
| Unmediated pending/by-pass effect during HOLD | Independently observed effect rejects source/physical correspondence |
| Event whose endpoints agree but interior subject continuation fails | Cannot certify within-event X3 |
| Protected state after every discrete step but liveness permanently absent | Cannot certify full original X3 freedom and continuing care |
| Nontrivial frozen BCRD source event | Positive or negative result must be derived from its literal generator/event semantics |
| Physical failure event outside good event | Accounted probabilistically, not silently declared impossible |

## 5. Exact status and recommendations

**Preserve:** the typed self-refutation floor at its established scope; the valid conditional first-event forcing theorem; IR-96 induction; the E9 branch lemmas at their actual hypotheses; the source/mediation proof bank; the original four-stage X3 target, and the correspondence ledger in PR #259.

**Do not certify yet:** `ALL IS → original agent-level guardian-only`, universal source-derived `controlCorrect`/`stateCarry`, actual all-event BCRD coverage, physical commissioning, unconditional physical protection, or full continuous and maximal original-X3 coexistence. This commentary does not assert any is false; it identifies the necessary proofs and independent evidence.

**Priority:** R1+R2 (source meaning), then R3 (semantic bridge), then R4+R5 (actual branch/cause linkage), then R6 (time/risk/agency), while R7 (ontological same-type proof) proceeds independently. Consolidate, audit and reproduce before a completion or publication decision. No new axioms, no canon edits and no merges are requested by this note.

**Verification statement:** This is source-reading commentary only. It is neither a fresh Lean compilation nor an independent physical reproduction. A subsequent implementation should publish exact code theorem paths, compiler/axiom receipts, finite countercontrols and physically calibrated correspondence separately.
