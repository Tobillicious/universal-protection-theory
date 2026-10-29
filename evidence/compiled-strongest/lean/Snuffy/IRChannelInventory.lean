import Snuffy.IRAggregateBudget

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRChannelInventory.lean` at main `740abbb` (sha256 `faec5557b0448cf5e57b17be01e9899ef2e290f6fb282872efaa1aeb6034865c`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-15: exhaustive accounting for a CLOSED, TYPED channel alphabet.
The exhaustive enumeration is a property of this model, not a statement
that actual hardware and its environment have no additional channels.
See negative control for a hidden/unmetered channel.
-/

namespace PhysicalBridges.IRChannelInventory

/-- Distinct physical channels are named, including bypass and latent effects.
Representing a bypass here permits accounting for it; it does not physically
prevent or discover unmodeled bypasses. -/
inductive Channel
  | authorised (weight : Nat)
  | environmental (weight : Nat)
  | latent (weight : Nat)
  | bypass (weight : Nat)
  deriving DecidableEq, Repr

def charge : Channel → Nat
  | .authorised w => w
  | .environmental w => w
  | .latent w => w
  | .bypass w => w

/-- A tempting but unsafe instrument accounting function. -/
def incompleteCharge : Channel → Nat
  | .authorised w => w
  | .environmental w => w
  | .latent _ => 0
  | .bypass _ => 0

structure MeteredState where
  physical : Nat
  accounted : Nat

/-- The model-level mediation rule updates both an independent physical
register and a durable total accounting register for EVERY typed channel. -/
def apply (s : MeteredState) (e : Channel) : MeteredState :=
  {physical := s.physical + charge e, accounted := s.accounted + charge e}

def run (s : MeteredState) (trace : List Channel) : MeteredState :=
  trace.foldl apply s

/-- Equality of baseline-adjusted physical and accounted totals is inductive,
not stipulated at every endpoint. -/
theorem apply_coupled (s : MeteredState) (e : Channel) (base : Nat)
    (h : s.physical = base + s.accounted) :
    (apply s e).physical = base + (apply s e).accounted := by
  simp [apply, h, Nat.add_assoc]

theorem run_coupled :
    ∀ trace (s : MeteredState) (base : Nat),
    s.physical = base + s.accounted →
    (run s trace).physical = base + (run s trace).accounted := by
  intro trace
  induction trace with
  | nil => intro s base h; exact h
  | cons e rest ih =>
    intro s base h
    exact ih (apply s e) base (apply_coupled s e base h)

/-- The independent physical register rises by EXACTLY the full charge sum
for all finite traces over the stated channel alphabet. -/
theorem run_physical_sum :
    ∀ trace (s : MeteredState),
    (run s trace).physical = s.physical + (trace.map charge).sum := by
  intro trace
  induction trace with
  | nil => intro s; rfl
  | cons e rest ih =>
    intro s
    change (run (apply s e) rest).physical =
      s.physical + ((e :: rest).map charge).sum
    rw [ih]
    simp only [apply, List.map_cons, List.sum_cons]
    omega

theorem bounded_all_channel_effects
    (trace : List Channel) (s : MeteredState) (budget threshold : Nat)
    (hTotal : (trace.map charge).sum ≤ budget)
    (hGate : s.physical + budget ≤ threshold) :
    (run s trace).physical ≤ threshold := by
  rw [run_physical_sum]
  omega

/-- The incomplete three-channel ledger can report zero even when a typed
latent or bypass action physically changes the state. -/
theorem incomplete_inventory_counterexample :
    ∃ trace : List Channel,
      (trace.map incompleteCharge).sum = 0 ∧
      0 < (trace.map charge).sum := by
  refine ⟨[.bypass 1], ?_, ?_⟩ <;> decide

/-- Uniform per-event finite charges do not yield a common total envelope
without an enforceable aggregate budget, even with a closed alphabet. -/
theorem no_unconditional_total_budget :
    ∀ b : Nat, ∃ trace : List Channel, b < (trace.map charge).sum := by
  intro b
  refine ⟨[.latent (b + 1)], ?_⟩
  simp [charge]

end PhysicalBridges.IRChannelInventory
