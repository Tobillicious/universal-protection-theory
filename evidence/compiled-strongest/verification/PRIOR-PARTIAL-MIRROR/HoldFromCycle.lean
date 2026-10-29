import Snuffy.Bridge
import Snuffy.HoldCommonAction
import Snuffy.IR113ObservationClassSelection

/-!
# Hold safety derived from the holding cycle (Lemma H join)

The hostile referee of 29 October 2026 observed that `HoldCommonAction`'s hold-safety
hypothesis was not instantiated from the canon's holding cycle. This module makes the
join.

The world's perturbations during a hold form a class `Pert`, uniform over every hidden
state in the observation class: each keeps a continuing particular within the decoding
radius `t` of its record (the class-uniform bound that `Bridge.qsl_within_radius` and
`Bridge.headroom_within_radius` supply, and that E9's per-site threshold makes uniform
over adversaries). A hold step is any perturbation in `Pert` followed by nearest-codeword
decoding and funded repair to precision `εf ≤ ε`.

* `hsafe_of_holding_cycle` — every hold step keeps every viable state viable
  (`Bridge.nearest_decodes`);
* `hold_common_action_of_cycle` — hence the hold is a common viable action at every
  observation class (`HoldCommonAction`), for IR-113's own criterion
  (`classViable_iff_IR113`);
* `one_policy_from_holding_cycle` — and one observation-only policy keeps viability
  along every finite trace (`PhysicalBridges.IR113.common_actions_give_finite_trace_viability`).
-/

namespace Snuffy.HoldFromCycle

open Snuffy.Bridge

variable {X : Type*} [MetricSpace X] {Part : Type*}

/-- Viability: every particular in the scope continues at resolution `ε`. -/
def Viable (rec : Part → X) (ε : ℝ) (S : Set Part) (a : Part → X) : Prop :=
  ∀ x ∈ S, Continues rec ε a x

/-- A hold step: some perturbation of the class, then decode and repair. -/
def HoldStep (dec : X → X) (εf : ℝ) (S : Set Part)
    (Pert : Set ((Part → X) → Part → X)) (a b : Part → X) : Prop :=
  ∃ p ∈ Pert, ∀ x ∈ S, dist (b x) (dec (p a x)) ≤ εf

theorem hsafe_of_holding_cycle {rec : Part → X} {ε εf t dmin : ℝ} {Code : Set X}
    (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (hεf : εf ≤ ε) {S : Set Part} (Pert : Set ((Part → X) → Part → X))
    (hgrow : ∀ p ∈ Pert, ∀ a x, x ∈ S → Continues rec ε a x → dist (p a x) (rec x) ≤ t) :
    ∀ a, Viable rec ε S a → ∀ b, HoldStep dec εf S Pert a b → Viable rec ε S b := by
  rintro a ha b ⟨p, hp, hb⟩ x hx
  have hd : dec (p a x) = rec x :=
    nearest_decodes hsep ht hdecC hnear (hrec x) (hgrow p hp a x hx (ha x hx))
  have h := hb x hx
  rw [hd] at h
  exact h.trans hεf

/-- `HoldCommonAction`'s criterion is IR-113's, verbatim. -/
theorem classViable_iff_IR113 {S A O : Type*} (observe : S → O) (step : S → A → S → Prop)
    (viable : S → Prop) (o : O) (a : A) :
    HoldCommonAction.ClassViableAction observe step viable o a ↔
      PhysicalBridges.IR113.ClassViableAction observe step viable o a := Iff.rfl

/-- The action step: the hold acts as a hold step; other actions as given. -/
def ActStep {A : Type*} (hold : A) (dec : X → X) (εf : ℝ) (S : Set Part)
    (Pert : Set ((Part → X) → Part → X)) (other : (Part → X) → A → (Part → X) → Prop) :
    (Part → X) → A → (Part → X) → Prop :=
  fun a act b => (act = hold ∧ HoldStep dec εf S Pert a b) ∨ (act ≠ hold ∧ other a act b)

theorem hold_common_action_of_cycle {O A : Type*} (observe : (Part → X) → O) (hold : A)
    {rec : Part → X} {ε εf t dmin : ℝ} {Code : Set X}
    (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (hεf : εf ≤ ε) {S : Set Part} (Pert : Set ((Part → X) → Part → X))
    (hgrow : ∀ p ∈ Pert, ∀ a x, x ∈ S → Continues rec ε a x → dist (p a x) (rec x) ≤ t)
    (other : (Part → X) → A → (Part → X) → Prop) :
    ∀ o, ∃ act, PhysicalBridges.IR113.ClassViableAction observe
      (ActStep hold dec εf S Pert other) (Viable rec ε S) o act := by
  intro o
  refine ⟨hold, fun a _ ha b hstep => ?_⟩
  rcases hstep with ⟨-, hh⟩ | ⟨hne, -⟩
  · exact hsafe_of_holding_cycle hrec hsep ht hdecC hnear hεf Pert hgrow a ha b hh
  · exact absurd rfl hne

/-- **One observation-only policy keeps viability along every finite trace**, derived
from the holding cycle through IR-113. -/
theorem one_policy_from_holding_cycle {O A : Type*} (observe : (Part → X) → O) (hold : A)
    {rec : Part → X} {ε εf t dmin : ℝ} {Code : Set X}
    (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (hεf : εf ≤ ε) {S : Set Part} (Pert : Set ((Part → X) → Part → X))
    (hgrow : ∀ p ∈ Pert, ∀ a x, x ∈ S → Continues rec ε a x → dist (p a x) (rec x) ≤ t)
    (other : (Part → X) → A → (Part → X) → Prop) :
    ∃ policy : O → A, ∀ {initial final : Part → X},
      PhysicalBridges.IR109.PolicyReach (ActStep hold dec εf S Pert other) policy observe
        initial final →
      Viable rec ε S initial → Viable rec ε S final :=
  PhysicalBridges.IR113.common_actions_give_finite_trace_viability observe
    (ActStep hold dec εf S Pert other) (Viable rec ε S)
    (hold_common_action_of_cycle observe hold hrec hsep ht hdecC hnear hεf Pert hgrow other)

end Snuffy.HoldFromCycle
