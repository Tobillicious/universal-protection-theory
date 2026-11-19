# Triadic G bridge — independent review of uploaded Lean sketch (19 November 2026)

**Companion to draft PR #662. Additive documentation only. No original proofs changed; not a kernel-compilation receipt.**

## Uploaded candidate

The supplied 71-line Lean file defines `iterate`, `ProcessPillar S` (an inhabited physical-model state, invariant Nat-valued energy, monotone Nat-valued entropy), `ContractionPillar M` (strict Nat-valued contraction with designated fixed point), and `StrictHinge P C` (projection `pi:S→M` with `pi(P.f s)=C.phi(pi s)`). It proposes:

`triadic_g_bridge`: (1) nonempty-state anti-Empty function, iterated conservation and entropy nondecrease; (2) fixed-point zero-distance uniqueness and persistence; (3) contraction along the projected physical-model trajectory.

These are constructive *model-level implications* from explicit structural fields. Their mathematical argument is sound under those assumptions; Lean tactic/elaboration compatibility is not independently verified here (Lean toolchain unavailable in this review). No Hilbert space is required.

## A very important strength: distinct pillars

Unlike an uncoupled list of invariants, `StrictHinge.commutes` genuinely ties the two dynamics together along every finite iteration. The new formulation explicitly includes a witness `P.s0:S`, ruling out the possibility of a vacuous empty physical-process state domain for `triadic_g_bridge`.

The fixed-point theorem gives `dist G G'=0`; it does not establish `G=G'` without an independently justified separation property. The `Nat` contraction under `kNum<kDen` also gives finite-time zero projected distance along the strict hinge, as discussed in the existing PR #662 research notes.

## Audit of `pi_alone_insufficient`

The submitted theorem
```lean
theorem pi_alone_insufficient :
    ∃ (pi : Empty → Empty), (Empty → Empty) ∧ (Empty → False) :=
  ⟨id, id, fun x => nomatch x⟩
```
is a legitimate (vacuous) inhabitation fact about functions out of `Empty`. It does **not** refute `triadic_g_bridge`, because `ProcessPillar S` includes `s0:S`, so `S=Empty` cannot instantiate a `ProcessPillar`. It also does not independently demonstrate why a commutative π loses an original-X3 duty.

**Sharper nonempty negative control:** take `S=M=Unit`, `f=phi=id`, `pi=id`, `dist ≡ 0`, `kNum=0`, `kDen=1`, `energy ≡ 1`, `entropy ≡ 0`. Every proposed process, contraction and strict hinge field holds; but an independently defined authentic authorization predicate `auth : Unit→Unit→Unit→Prop := fun _ _ _ => False` is false. Thus all six *new mathematical* invariants can hold while the **original** X3 authorization duty fails. This is a type-theoretic model-separation result, not evidence of a harmful real-world event.

## The exact next G3 theorem is already in the repository

- `EverestActualWEventJoin.positive_W_actual_event_six_requires_only_coverage_and_reflection` derives the full original six X3 from **independent** `CompleteWEventCoverage` and `ForwardRealEventReflection` for the positive W source. Positive origin is proved within that chosen model.
- `FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` assembles the all-event, all-owed-original-six result under those same two physical/semantic bridge premises.
- `IR138.full_intrinsic_source_recovers_semantics` already shows that modeled intrinsic event facts can be recovered from the *full* event rather than a lossy observation. The full-objective/partial-subjective category distinction is real; it does not itself force all duty predicates positive.

**Research route:** test whether `StrictHinge` can be derived from actual matterspacetime dynamics, then whether its `pi` is faithful to the entire six-tag relational web, and finally whether independently justified physical law implies a *positive* source-to-authentic-duty reflection for every actual event and owed particular. Retain the complete Koru as a whole-relational construct, not merely `ContractionPillar.phi`. Do not rename the six mathematical invariants as the **original six X3**.

## Verification status

Mathematical argument reviewed. No Lean binary was available to run the submitted script or `#print axioms`; no claim of real-world universal correspondence or universal physical G3 established by the uploaded file. Draft PR only; no merge.
