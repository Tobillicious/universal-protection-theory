import PhysicalBridges.Koru

/-!
# Cyclic genesis — I. The interior, the arrow, and no backward time

First stone of the `SUMMIT-CYCLIC-GENESIS-SPEC` (noncanonical, research lane). This module
builds the **subjective / interior** layer and proves, **within this causal model**, that an
interior subject cannot reverse — and that the **objective** whole-bijection does not change
that. The `Objective` layer is reused from `PhysicalBridges.Koru` (`Reindex` = a whole-at-once
bijection, the maths-layer reversibility, pre-time).

**Scope (spec §9, binding).** `rank` is a *modelled* causal/entropy order (a strict monotone by
construction); `no_backward_time` is rigorous **within this model**, NOT a claim about real
microphysics (the Second Law is statistical) and NOT a refutation of GR closed-timelike-curve
spacetimes. No cosmology claim; no canon; no release.
-/
namespace PhysicalBridges.CyclicGenesisInterior

open PhysicalBridges.Koru (Reindex)

/-- **Subjective / interior time.** Positions in a causal order, with the model's Second Law:
every forward `step` strictly advances a `rank` (the causal/entropy order). This is a type
*distinct* from the objective whole; no coercion turns one into the other. -/
structure Interior where
  Position : Type
  step : Position → Position → Prop
  rank : Position → Nat
  /-- The model's Second Law / causal direction: a forward step strictly advances the rank. -/
  lawful : ∀ a b, step a b → rank a < rank b

variable (I : Interior)

/-- No interior self-return: a state never steps to itself. -/
theorem no_self_return (a : I.Position) : ¬ I.step a a := by
  intro h
  exact (Nat.lt_irrefl (I.rank a)) (I.lawful a a h)

/-- **No backward time (model-internal).** No forward step has a reverse — a reverse step would
*retreat* the causal rank, contradicting the model's Second Law. The trivial-paradox-as-guard,
as a proof: the interior rewind cannot even be stated consistently. Scoped to the model (§9);
not a universal physical impossibility. -/
theorem no_backward_time (a b : I.Position) : I.step a b → ¬ I.step b a := by
  intro hab hba
  have h1 := I.lawful a b hab
  have h2 := I.lawful b a hba
  omega

/-- No interior 2-cycle: two distinct positions are never mutually reachable in one step. -/
theorem no_two_cycle (a b : I.Position) : ¬ (I.step a b ∧ I.step b a) := by
  rintro ⟨hab, hba⟩
  exact no_backward_time I a b hab hba

/-! ## Positive control — the guardrail provably rejects a machine -/

/-- **POSITIVE CONTROL.** A two-state world with steps *both ways* between its states (a literal
little time machine) admits **no** lawful rank: lawfulness would force `rank true < rank false`
and `rank false < rank true` at once. So a machine-world **cannot** be a lawful `Interior` — the
guardrail discriminates, it does not merely reassure. -/
theorem machine_world_rejected :
    ¬ ∃ rank : Bool → Nat, ∀ a b : Bool, a ≠ b → rank a < rank b := by
  rintro ⟨rank, h⟩
  have h1 := h true false (by decide)
  have h2 := h false true (by decide)
  omega

/-! ## Objective reversibility does not descend (the category seal) -/

/-- A concrete lawful interior: the natural-number successor history, rank = index. -/
def natInterior : Interior where
  Position := Nat
  step := fun a b => b = a + 1
  rank := fun n => n
  lawful := by
    intro a b hab
    subst hab
    omega

/-- **The category seal.** For *any* global bijection `σ` of the whole (a `Koru.Reindex` — the
objective-layer inverse, however much it "reverses" the labelling), the interior still has **no
backward step**. The witness `σ` is *inert in the proof*: the objective reversibility cannot
touch the interior's Second Law. That inertness is the seal — reversible-as-a-whole ⊬
reversible-from-inside. -/
theorem objective_reversibility_does_not_descend (σ : Reindex Nat) :
    ∀ a b : Nat, natInterior.step a b → ¬ natInterior.step b a := by
  intro a b hab
  exact no_backward_time natInterior a b hab

end PhysicalBridges.CyclicGenesisInterior
