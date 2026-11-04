/-!
# Cyclic genesis — I. The interior, the arrow, and no backward time

First stone of the `SUMMIT-CYCLIC-GENESIS-SPEC` (noncanonical, research lane). This module
builds the **subjective / interior** layer, and exhibits a separate, genuinely
bijective objective shift on the integers with a forward-equivariant embedding of the natural
interior. The objective inverse exists at every integer, while the interior's rank-ordered
allowed steps have no reverse. In particular, the objective predecessor of the interior
origin lies outside that interior. This is an explicit COUNTEREXAMPLE to any assertion that a
whole-space inverse must be an allowed interior rewind, not a proof that the real universe
has the model's objective or subjective dynamics.

**Scope (spec §9, binding).** `rank` is a *modelled* causal/entropy order (a strict monotone by
construction); `no_backward_time` is rigorous **within this model**, NOT a claim about real
microphysics (the Second Law is statistical) and NOT a refutation of GR closed-timelike-curve
spacetimes. No cosmology claim; no canon; no release.
-/
namespace PhysicalBridges.CyclicGenesisInterior

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

/-- Predecessor UNIQUENESS for Nat successor. This does NOT establish
predecessor EXISTENCE at zero or whole-space bijectivity. In particular
Nat successor is not surjective and should never be described as
objective/global reversibility. -/
theorem natInterior_past_recoverable (a b c : Nat) :
    natInterior.step a c → natInterior.step b c → a = b := by
  intro hac hbc
  have e1 : c = a + 1 := hac
  have e2 : c = b + 1 := hbc
  omega

/-- An actual two-sided objective model: integer shift. Unlike
Nat successor, it has a predecessor and successor at EVERY integer.
These are mathematical labels, not an asserted cosmological law. -/
def objectiveForward (z : Int) : Int := z + 1

def objectiveBackward (z : Int) : Int := z - 1

theorem objective_shift_has_two_sided_inverse (z : Int) :
    objectiveBackward (objectiveForward z) = z ∧
      objectiveForward (objectiveBackward z) = z := by
  dsimp [objectiveBackward, objectiveForward]
  omega

/-- Surjectivity is proved, not inferred merely from injectivity. -/
theorem objective_shift_is_surjective :
    ∀ z : Int, ∃ before : Int, objectiveForward before = z := by
  intro z
  refine ⟨objectiveBackward z, ?_⟩
  exact (objective_shift_has_two_sided_inverse z).2

/-- The interior Nat is a proper forward-oriented sector of the
objective Int model. Its embedding is explicitly defined; it is
not a spectator parameter or a claim of actual consciousness. -/
def embedInterior (n : Nat) : Int := (n : Int)

/-- The interior forward update AGREES with the objective bijection
after embedding. The two layers are linked by an earned equation. -/
theorem forward_interior_agrees_with_objective (n : Nat) :
    embedInterior (n + 1) = objectiveForward (embedInterior n) := by
  simp [embedInterior, objectiveForward]

/-- The inverse objective shift at the embedded interior origin
is -1: no Nat interior predecessor represents it. Hence a
full objective inverse need not be an allowed interior rewind. -/
theorem objective_inverse_escapes_interior_at_origin :
    ¬ ∃ n : Nat,
      embedInterior n = objectiveBackward (embedInterior 0) := by
  rintro ⟨n, h⟩
  dsimp [embedInterior, objectiveBackward] at h
  omega

/-- Non-vacuity: there is an actual positive interior step. -/
theorem interior_has_a_forward_step :
    natInterior.step (0 : Nat) (1 : Nat) := by
  decide

/-- CATEGORY-SEAL MODEL (not a theorem about cosmological reality):
1. the objective integer evolution has a GENUINE two-sided inverse;
2. every modeled interior forward successor agrees with that map;
3. no interior allowed step can be undone by another allowed step;
4. the objective inverse at the interior origin lies outside the
   represented interior, providing an explicit interface obstruction.

This replaces the earlier misleading equation 'injective = reversible'.
It does NOT prove a real universe's objective structure is bijective,
or that no experiencing subject can ever travel to an earlier time. -/
theorem objective_reversibility_does_not_descend :
    (∀ z : Int,
      objectiveBackward (objectiveForward z) = z ∧
      objectiveForward (objectiveBackward z) = z) ∧
    (∀ n : Nat,
      embedInterior (n + 1) = objectiveForward (embedInterior n)) ∧
    (∀ a b : Nat, natInterior.step a b → ¬ natInterior.step b a) ∧
    (¬ ∃ n : Nat,
      embedInterior n = objectiveBackward (embedInterior 0)) := by
  exact ⟨objective_shift_has_two_sided_inverse,
    forward_interior_agrees_with_objective,
    fun a b => no_backward_time natInterior a b,
    objective_inverse_escapes_interior_at_origin⟩

#print axioms objective_shift_has_two_sided_inverse
#print axioms objective_shift_is_surjective
#print axioms forward_interior_agrees_with_objective
#print axioms objective_inverse_escapes_interior_at_origin
#print axioms objective_reversibility_does_not_descend

end PhysicalBridges.CyclicGenesisInterior
