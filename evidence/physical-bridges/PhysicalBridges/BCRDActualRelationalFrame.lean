import PhysicalBridges.FrozenBCRDEvents

/-!
# PR A — The independent BCRD relational frame

Objective (GPT brief, 2026-11-04): establish what the *actual frozen source*
preserves during an event, WITHOUT defining preservation into the transition
or into the relations.

**Boundary discipline.** No definition in this file mentions X3, guardianship,
consent, agency or safety. This file establishes

* a source-faithful relational transition (`Transport`, `step`, `ActualStep`),
  anchored against the frozen operator `evolve ρ = W ρ Wᵀ`;
* an independently-justified before/after covariance theorem
  (`relational_covariance`); and
* an explicit **obstruction** where covariance fails
  (`register_relation_not_covariant`, with a named witness).

It does **not** establish original-X3 continuity (that is PR B), nor
first-violation necessity (PR C). It makes **no** claim of universal
covariance: every result is scoped to this one finite frozen source event
(the M-sector `2↔3` swap on `Fin 6`).

The operator-algebra automorphism `Φ(A)=WAWᵀ` (trace / product / adjoint /
invertibility) is a *separate* representational result, now formalised in the
companion module `PhysicalBridges.BCRDOperatorAlgebra` — earned in this
mathlib-free lane via the per-entry lemma `evolve_entry` (conjugation by the
permutation matrix `W` just permutes indices), so no `ring` is required. That
algebraic covariance must not be conflated with the still-open X3 correspondence
this PR frames.
-/
namespace PhysicalBridges.BCRDActualRelationalFrame

open FrozenBCRDEvents

/-! ## 1. The common physical frame

Nothing in this section refers to the event, to any relation, or to X3. -/

/-- A physical configuration: the value carried at each of the six source
positions `|L0⟩,|L1⟩,|M0⟩,|M1⟩,|R0⟩,|R1⟩` (the order fixed by the frozen
source, `FrozenBCRDEvents` line 76). Independently specified. -/
abbrev SourceState := Index → Int

/-- The event token for the single frozen M-sector event. -/
inductive SourceEvent
  | mSectorSwap

/-- `Transport` is the event's ACTUAL mapping of physical positions. It is not
invented: the frozen generator `evolve ρ = W ρ Wᵀ` sends basis position `|k⟩`
to `|perm k⟩`, and `permutation` is exactly that position map (source table
`[0,1,3,2,4,5]`, i.e. the `2↔3 = M0↔M1` swap). Grounded against the operator
in `evolve_realises_event` / `transport_tracks_operator` below. -/
def Transport : Index → Index := permutation

/-- The generator's action on a configuration: the value now standing at
position `i` is the one the generator transported there, i.e. the value that
was at `Transport i`. (Because `Transport` is an involution this is also the
forward push of amplitude `k ↦ Transport k`.) -/
def step (s : SourceState) : SourceState := fun i => s (Transport i)

/-- `ActualStep s e t`: `t` is the post-event configuration the generator
actually produces from `s`. Note this says `t = step s` — `t` is the source's
real output, NOT a relabelling of `s`'s relations. -/
def ActualStep (s : SourceState) (_e : SourceEvent) (t : SourceState) : Prop :=
  t = step s

/-! ## 2. Relations read off the physical frame -/

/-- Qutrit-site index: `L=0, M=1, R=2`. A fixed external-frame (state-independent)
datum. -/
def site (i : Index) : Nat := i.val / 2

/-- Register index `0/1`. A fixed external-frame (state-independent) datum. -/
def register (i : Index) : Nat := i.val % 2

/-- Static qutrit-site equivalence (fixed frame). -/
@[reducible] def SameSite (x y : Index) : Prop := site x = site y

/-- Static register equivalence (fixed pre-event frame). -/
@[reducible] def SameRegister (x y : Index) : Prop := register x = register y

/-- The genuine, STATE-DEPENDENT relation, read off the pre-event state `s`:
positions `x` and `y` carry the same value. -/
@[reducible] def RelationBefore (s : SourceState) (x y : Index) : Prop := s x = s y

/-- The genuine, STATE-DEPENDENT relation, read off the post-event state `t`.
Defined the SAME way as `RelationBefore` (same-value), read off `t`. It is NOT
the pushforward of `RelationBefore`; the link between them is a *theorem*
(`relational_covariance`), not a definition. -/
@[reducible] def RelationAfter (t : SourceState) (x y : Index) : Prop := t x = t y

/-! ## 3. Grounding the transport in the frozen operator

The "full source operator representation" test: the transport is the real
operator action, not a convenient relabelling. -/

/-- The frozen operator `evolve ρ = W ρ Wᵀ` carries the before-state density
`|M0⟩⟨M0|` to the after-state density `|M1⟩⟨M1|` — entrywise, checked against the
exact integer source tables. NOTE: this is the `W` relation-bit-swap **stage** of
the M3d process, not the whole compound process (which continues `C_LM → U_MR →
C_LM` to a complex L-sector superposition; see `BCRDSourceCoverage` and PR B
#285). So this "event" is the W-stage, and a position-valued history over `evolve`
is not a faithful history of the full M3d process. -/
theorem evolve_realises_event :
    ∀ i j : Index, evolve densityBefore i j = densityAfter i j := by decide

/-- …and the position map `Transport` tracks that operator action on the
M-sector: `M0 (2) ↦ M1 (3)` and back. -/
theorem transport_tracks_operator :
    Transport 2 = 3 ∧ Transport 3 = 2 := by decide

/-- `Transport` is an involution: `perm ∘ perm = id`. This is the structural
fact the genuine covariance proof rests on (it is a property of the actual
generator, established by exhaustive check over the six positions). -/
theorem transport_involutive : ∀ x : Index, Transport (Transport x) = x := by decide

/-! ## 4. The three separated tests -/

/-- **Test 1 — qutrit-site relation: PRESERVED.** The static site equivalence
is covariant under transport. (Finite check over all position pairs.) -/
theorem site_relation_covariant :
    ∀ x y : Index, SameSite x y ↔ SameSite (Transport x) (Transport y) := by decide

/-- **Test 2 — fixed pre-event register relation: NOT PRESERVED.** This is the
reported obstruction, and the re-grounded #284 register-change negative
control. The static register equivalence is NOT covariant under transport. -/
theorem register_relation_not_covariant :
    ¬ (∀ x y : Index, SameRegister x y ↔ SameRegister (Transport x) (Transport y)) := by
  decide

/-- The explicit discriminating witness for the obstruction. Positions `2` (M0,
register 0) and `4` (R0, register 0) share a register; their transports `3`
(M1, register 1) and `4` (R0, register 0) do not. A deliberately-built
failed-covariance witness — the theorem discriminates between physical
possibilities rather than succeeding by construction. -/
theorem register_failure_witness :
    SameRegister 2 4 ∧ ¬ SameRegister (Transport 2) (Transport 4) := by decide

/-- **Test 3 — genuine before/after relational covariance: DERIVED.**

`RelationAfter` is read from the independently-produced post-event state `t`;
the relation is defined the same way before and after (same-value). Covariance
is a THEOREM about the actual generator action, resting on
`transport_involutive` — not a pushforward by fiat. Quantified over ALL states,
so it is proved structurally, not by a finite check. -/
theorem relational_covariance
    (s t : SourceState) (e : SourceEvent) (h : ActualStep s e t) :
    ∀ x y : Index, RelationBefore s x y ↔ RelationAfter t (Transport x) (Transport y) := by
  intro x y
  subst h
  simp only [RelationBefore, RelationAfter, step, transport_involutive]

/-! ## 5. Discriminators — the covariance is neither vacuous nor static -/

/-- The covariance is **not vacuous**: there is a state exhibiting both a genuine
**distinct** related pair (`x ≠ y`, same value) and an unrelated pair — so the
relation is neither constant-True nor constant-False, and the positive case is not
merely the trivial reflexive one. (Strengthened in the hostile-review hardening pass.) -/
theorem covariance_nonvacuous :
    ∃ (s : SourceState) (x y x' y' : Index),
      x ≠ y ∧ RelationBefore s x y ∧ ¬ RelationBefore s x' y' := by
  exact ⟨(fun i => if i.val ≤ 1 then (0 : Int) else 1), 0, 1, 0, 2,
    by decide, by decide, by decide⟩

/-- The genuine insight GPT asked for, made into a theorem: the same-value
relation is **not invariant as a static object** (compare before/after at the
SAME positions, without transport — it changes), yet it IS covariant (with
transport) by `relational_covariance`. Witness: value `1` at M1 (position 3),
`0` elsewhere; positions `2` (M0) and `4` (R0). Before: both `0` → related.
After `step`: position `2` reads the value transported from `3` (namely `1`),
position `4` reads from `4` (namely `0`) → no longer related. -/
theorem relation_moves_but_is_covariant :
    ∃ (s : SourceState) (x y : Index),
      RelationBefore s x y ∧ ¬ RelationAfter (step s) x y := by
  exact ⟨(fun i => if i = 3 then 1 else 0), 2, 4, by decide, by decide⟩

/-! ## 6. Boundary marker

PR A succeeds here: a source-faithful relational transition
(`ActualStep`, grounded by `evolve_realises_event`), an independently-justified
covariance (`relational_covariance`, over all states, resting on the actual
generator's involution), the positive control (`site_relation_covariant`), and
the explicit obstruction with a named witness
(`register_relation_not_covariant`, `register_failure_witness`).

What this does NOT do, by design:
* it does not derive the six OriginalX3 components (PR B);
* it does not establish `ActualStep ∧ Owed ⟹ OriginalX3` (PR C);
* it does not claim universal covariance beyond this frozen event;
* operator-algebra covariance `Φ(A)=WAWᵀ` is in `BCRDOperatorAlgebra`; it is
  representational, not any X3 component.
-/

end PhysicalBridges.BCRDActualRelationalFrame
