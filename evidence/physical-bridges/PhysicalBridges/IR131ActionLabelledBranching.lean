import PhysicalBridges.IR96DisturbanceSimulation

/-!
IR-131 — Non-stalling deterministic equivariance versus genuinely
open, action-labelled branching.

An injective generator-equivariant embedding DOES preserve
"φ(x) ≠ x" at an embedded subject state and retains distinct
finite deterministic orbit points. It does NOT create a choice:
a deterministic two-cycle moves forever but has just one
permitted next action from each state.

For actual source-model branching, the process must carry an
ACTION-LABELLED transition relation and an authorization predicate.
A fully faithful, injective embedding preserving both permitted
actions and the corresponding successor edges then preserves
two DISTINCT old authorized options (and their distinct results),
and transports any finite authorized source execution into the
target. This is a genuine *possibility / capability* result.

Availability is not physical execution. There is no theorem
that an unfair or non-running environment eventually performs a
selected action. Scheduler fairness, reaction windows, real
semantic consent, newly arising states and physical execution
refinement remain separate obligations. Maximal X3 unchanged.
-/
namespace PhysicalBridges.IR131

universe u v w
variable {X : Type u} {Y : Type v} {A : Type w}

/-- Deterministic motion of old generator survives embedding.
A strict speed lower bound is NOT required for nonfixedness:
injection and equivariance already give this very local result. -/
theorem injective_equivariance_preserves_nonfixed_motion
    (phi : X → X) (psi : Y → Y)
    (e : X → Y)
    (hInjective : Function.Injective e)
    (hEquivariant : ∀ x, e (phi x) = psi (e x))
    (x : X) (hMoving : phi x ≠ x) :
    psi (e x) ≠ e x := by
  intro hStopped
  apply hMoving
  apply hInjective
  calc
    e (phi x) = psi (e x) := hEquivariant x
    _ = e x := hStopped

/-- Labeled choices, not merely a deterministic generator.
All named options must be genuinely authorized in the specified
source semantics. That source authorization still needs actual
subject-consent evidence for X3. -/
structure Process (X : Type u) (A : Type w) where
  step : X → A → X → Prop
  authorised : X → A → Prop

def MayAct (p : Process X A) (x : X) (a : A) (x' : X) : Prop :=
  p.authorised x a ∧ p.step x a x'

/-- Two distinct authorized choices, reaching two distinct future
states, provides a minimally nontrivial branching capacity.
This criterion can itself be too weak for full maximal X3. -/
def TwoWayChoice (p : Process X A) (x : X) : Prop :=
  ∃ a b x1 x2,
    a ≠ b ∧ x1 ≠ x2 ∧
    MayAct p x a x1 ∧ MayAct p x b x2

/-- True non-stalling (existence of a permitted nonidentity step).
It does NOT imply two-way choice or fair eventual service. -/
def CanMove (p : Process X A) (x : X) : Prop :=
  ∃ a x', MayAct p x a x' ∧ x' ≠ x

/-- Authorisation- and successor-preserving map. Unlike IR-128's
deterministic generator morphism, this covers the two-way
action-labelled future capability relation. -/
structure ChoiceEmbedding
    (p : Process X A) (q : Process Y A) where
  map : X → Y
  injective : Function.Injective map
  preservesAuthorisation : ∀ x a,
    p.authorised x a → q.authorised (map x) a
  preservesTransition : ∀ x a x',
    p.step x a x' → q.step (map x) a (map x')

/-- Each old permitted choice is retained by the successor process
at its image, and reaches the corresponding embedded successor. -/
theorem every_old_action_remains_possible
    (p : Process X A) (q : Process Y A)
    (e : ChoiceEmbedding p q)
    (x x' : X) (a : A)
    (hAction : MayAct p x a x') :
    MayAct q (e.map x) a (e.map x') := by
  exact ⟨e.preservesAuthorisation x a hAction.1,
    e.preservesTransition x a x' hAction.2⟩

/-- Branching really survives: two different old authorized
alternatives remain different authorized alternatives, with
distinct possible outcomes, under injective faithful embedding. -/
theorem two_way_branching_preserved
    (p : Process X A) (q : Process Y A)
    (e : ChoiceEmbedding p q)
    (x : X) (hChoice : TwoWayChoice p x) :
    TwoWayChoice q (e.map x) := by
  obtain ⟨a, b, x1, x2, hab, hDistinct, hA, hB⟩ := hChoice
  refine ⟨a, b, e.map x1, e.map x2, hab, ?_, ?_, ?_⟩
  · intro hMerge
    exact hDistinct (e.injective hMerge)
  · exact every_old_action_remains_possible p q e x x1 a hA
  · exact every_old_action_remains_possible p q e x x2 b hB

/-- Injection and transition preservation also retain a
non-self-loop where one existed. The result is ONE possible
nontrivial step, not guaranteed future actual service. -/
theorem nonstalling_possible_move_preserved
    (p : Process X A) (q : Process Y A)
    (e : ChoiceEmbedding p q)
    (x : X) (hMoving : CanMove p x) :
    CanMove q (e.map x) := by
  obtain ⟨a, x', hStep, hDifferent⟩ := hMoving
  refine ⟨a, e.map x', ?_, ?_⟩
  · exact every_old_action_remains_possible p q e x x' a hStep
  · intro hEq
    exact hDifferent (e.injective hEq)

/-- Authorized unlabelled graph of possible executions. This
relation describes possibility; it is not a scheduler or an
assurance that the action actually gets executed. -/
def PossibleStep (p : Process X A) (x x' : X) : Prop :=
  ∃ a, MayAct p x a x'

/-- Complete forward refinement of every FINITE possible path.
This is exactly what a structural preserving process morphism
can establish without importing execution fairness. -/
theorem finite_possible_paths_remain_possible
    (p : Process X A) (q : Process Y A)
    (e : ChoiceEmbedding p q)
    {x x' : X}
    (hTrace : IR96.Reach (PossibleStep p) x x') :
    IR96.Reach (PossibleStep q) (e.map x) (e.map x') := by
  induction hTrace with
  | refl =>
      exact IR96.Reach.refl _
  | tail earlier edge ih =>
      obtain ⟨a, hAct⟩ := edge
      exact IR96.Reach.tail ih
        ⟨a, every_old_action_remains_possible p q e _ _ a hAct⟩

/-- Every reachable old point retaining two-way agency implies
its embedded image retains agency. This does NOT extend to
target-only newly reachable points without their own certificate. -/
theorem all_old_reachable_branches_remain_at_their_images
    (p : Process X A) (q : Process Y A)
    (e : ChoiceEmbedding p q)
    (start : X)
    (hSourceAgency : ∀ x,
      IR96.Reach (PossibleStep p) start x →
      TwoWayChoice p x) :
    ∀ x,
      IR96.Reach (PossibleStep p) start x →
      TwoWayChoice q (e.map x) := by
  intro x hx
  exact two_way_branching_preserved p q e x
    (hSourceAgency x hx)

/-- Exact counterexample: a deterministic two-state oscillator
has perpetual NONFIXED movement but just one permitted action.
It can be a 'museum exhibit' in the sense of no autonomous
choice despite motion. -/
def oscillation : Process Bool Unit :=
  { step := fun x _ y => y = !x
    authorised := fun _ _ => True }

theorem oscillation_can_move_from_every_state :
    ∀ x : Bool, CanMove oscillation x := by
  intro x
  refine ⟨(), !x, ⟨trivial, rfl⟩, ?_⟩
  cases x <;> decide

theorem deterministic_oscillation_has_no_two_way_choice :
    ∀ x : Bool, ¬ TwoWayChoice oscillation x := by
  intro x
  rintro ⟨a, b, x1, x2, hab, _, _, _⟩
  cases a
  cases b
  exact hab rfl

/-- Authenticated action choice itself is not a scheduling theorem.
Even if source and target have choices, the empty observed trace
is still a permissible finite history of zero executed steps. -/
theorem available_choices_do_not_force_a_step
    (p : Process X A) (x : X) :
    IR96.Reach (PossibleStep p) x x :=
  IR96.Reach.refl x

end PhysicalBridges.IR131
