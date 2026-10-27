/-
IR-74: Necessary energy replenishment and sufficient robust reserve
invariants for the all-horizon premise of IR-72.

The state of energy is Nat (discrete accounting units), not a
measured Joule value or a thermodynamic derivation. Replenishment
and fault coverage remain physical premises requiring calibration.

A finite energy bank with strictly positive per-tick mandatory cost
cannot satisfy all finite robust horizons without fresh inputs.
Conversely, a common independently warranted supply lower bound
at least the mandatory cost provides a robust reserve invariant,
all finite horizons and ONE infinite safe policy.

Nothing here proves freedom, service, persistent identity,
the original full physically feasible X3 universe, or a
uniform physical energy source.
-/
import PhysicalBridges.IRInfiniteHistoryCompactness

namespace PhysicalBridges.IREnergyReplenishment
open IRViability
open IRInfiniteHistoryCompactness

universe u
variable {D : Type u}

/-- Discrete battery credit. Every mandatory active tick consumes
one indivisible unit, regardless of actions or disturbances. -/
def drainingSafe (energy : Nat) : Prop := 0 < energy

def drainingStep (energy : Nat) (_action : Bool) (_disturbance : Unit) : Nat :=
  energy - 1

/-- Exact viability horizon for a positive per-tick mandatory cost.
The finite energy bank cannot keep servicing through tick energy.
-/
theorem draining_viable_iff :
    ∀ n energy : Nat,
      Viable drainingSafe drainingStep n energy ↔ n < energy := by
  intro n
  induction n with
  | zero =>
      intro energy
      simp [Viable, drainingSafe]
  | succ n ih =>
      intro energy
      constructor
      · intro h
        obtain ⟨hPositive, action, hNext⟩ := h
        have hRest : n < energy - 1 :=
          (ih (energy-1)).mp (hNext ())
        omega
      · intro hEnough
        have hPositive : drainingSafe energy := by
          unfold drainingSafe
          omega
        refine ⟨hPositive, true, ?_⟩
        intro _
        change Viable drainingSafe drainingStep n (energy-1)
        apply (ih (energy-1)).mpr
        omega

/-- FINITE positive energy cannot establish the premise of IR-72.
For every chosen initial credit E, the finite horizon n=E
already fails. There is no 'all finite horizons but not infinity'
countermodel when the cost is positive and E is fixed. -/
theorem finite_bank_cannot_support_all_horizons (energy : Nat) :
    ¬ (∀ n : Nat, Viable drainingSafe drainingStep n energy) := by
  intro hAll
  have hImpossible := (draining_viable_iff energy energy).mp (hAll energy)
  omega

/-- General physical-style paid state update.
A permitting action can draw from an external supply channel;
disturbances may affect the actual delivered supply. The update
saturates at zero if insufficient, but our sufficient theorem
never relies on underflow/saturation being safe. -/
def suppliedStep
    (supply : D → Nat) (cost : Nat)
    (energy : Nat) (action : Bool) (disturbance : D) : Nat :=
  (energy + (if action then supply disturbance else 0)) - cost

def reserveSafe (reserve : Nat) (energy : Nat) : Prop :=
  reserve ≤ energy

/-- The supply guarantee is UNIFORM across every admitted
disturbance, including the unfavorable one. It is NOT a consequence
of conservation or the existence of a possible supply schedule. -/
theorem paid_reserve_step_invariant
    (supply : D → Nat) (cost reserve energy : Nat)
    (hSupply : ∀ d, cost ≤ supply d)
    (hReserve : reserveSafe reserve energy) :
    ∀ d : D,
      reserveSafe reserve
        (suppliedStep supply cost energy true d) := by
  intro d
  unfold reserveSafe at *
  unfold suppliedStep
  have hd := hSupply d
  simp only [ite_true]
  omega

/-- Derive all finite robust horizons FROM the concrete resource
inequality, rather than assuming each horizon independently. -/
theorem uniform_paid_supply_derives_all_horizons
    (supply : D → Nat) (cost reserve initial : Nat)
    (hSupply : ∀ d, cost ≤ supply d)
    (hInitial : reserveSafe reserve initial) :
    ∀ n, Viable (reserveSafe reserve)
      (suppliedStep supply cost) n initial := by
  have hInv : ∀ energy, reserveSafe reserve energy →
        ∀ d, reserveSafe reserve
          (suppliedStep supply cost energy true d) := by
    intro energy hEnergy
    exact paid_reserve_step_invariant supply cost reserve energy
      hSupply hEnergy
  exact robust_invariant_implies_all_horizons
    (reserveSafe reserve) (suppliedStep supply cost)
    (fun _ => true) hInv _ initial hInitial

/-- Composition with IR-72 yields one uniformly robust indefinitely
reserve-safe model history under EVERY disturbance stream. This
proves a conditional energy-storage invariant, NOT delivery of
a protected mind's continuing experiences or full freedoms. -/
theorem uniform_paid_supply_derives_infinite_safe_policy
    (supply : D → Nat) (cost reserve initial : Nat)
    (hSupply : ∀ d, cost ≤ supply d)
    (hInitial : reserveSafe reserve initial) :
    ∃ policy : Nat → Bool,
      ∀ stream : Nat → D, ∀ n : Nat,
        reserveSafe reserve
          (stateAt (suppliedStep supply cost)
            policy stream initial n) := by
  have hAll := uniform_paid_supply_derives_all_horizons
    supply cost reserve initial hSupply hInitial
  exact derived_infinite_robust_safe_history
    (reserveSafe reserve)
    (suppliedStep supply cost) initial hAll

/-- A single uncovered supply disturbance defeats even ONE
positive-reserve step. An existential supply schedule is not enough
for robust physical-history viability. -/
def intermittentSupply (disturbance : Bool) : Nat :=
  if disturbance then 1 else 0

theorem intermittent_supply_fails_one_step :
    ¬ Viable (reserveSafe 1)
      (suppliedStep intermittentSupply 1) 1 1 := by
  intro h
  obtain ⟨_,action,hEvery⟩ := h
  have hBad := hEvery false
  have hZero : suppliedStep intermittentSupply 1 1 action false = 0 := by
    cases action <;> decide
  change reserveSafe 1
    (suppliedStep intermittentSupply 1 1 action false) at hBad
  rw [hZero] at hBad
  exact (by decide : ¬ reserveSafe 1 0) hBad

#print axioms draining_viable_iff
#print axioms finite_bank_cannot_support_all_horizons
#print axioms paid_reserve_step_invariant
#print axioms uniform_paid_supply_derives_all_horizons
#print axioms uniform_paid_supply_derives_infinite_safe_policy
#print axioms intermittent_supply_fails_one_step

end PhysicalBridges.IREnergyReplenishment
