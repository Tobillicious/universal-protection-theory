/-
IR-33: alternate physical-finality route. Old queued effects need not be
drained if each effect is truly checked AGAIN at its final physical
application boundary against a monotonically advanced epoch floor.

This only holds for cancelable, mediated effects. A precommitted,
uninterruptible physical effect or bypass is outside this model.
-/
import PhysicalBridges.IRInFlightQuiescence

namespace PhysicalBridges.IRFinalApplyFence

structure Machine where
  floor : Nat
  pending : List (Nat × Nat)
  landed : Nat

def hold (s : Machine) (generation : Nat) : Machine :=
  { s with floor := max s.floor (generation + 1) }

/-- The *actual landing operation*, not only queue admission, checks the
current credential floor. The first Nat is credential generation, the
second is physical impact. -/
def deliver (s : Machine) : Machine :=
  match s.pending with
  | [] => s
  | (token, effect) :: rest =>
    if s.floor ≤ token then
      { s with pending := rest, landed := s.landed + effect }
    else { s with pending := rest }

def deliverMany : Nat → Machine → Machine
  | 0, s => s
  | n + 1, s => deliverMany n (deliver s)

def OldOnly (s : Machine) (generation : Nat) : Prop :=
  ∀ pair, pair ∈ s.pending → pair.1 ≤ generation

/-- One old effect cannot land after the new floor is active; the
remaining queue still contains only old effects. -/
theorem rejected_old_delivery (s : Machine) (generation : Nat)
    (hFloor : generation + 1 ≤ s.floor)
    (hOld : OldOnly s generation) :
    (deliver s).landed = s.landed ∧
    OldOnly (deliver s) generation ∧
    generation + 1 ≤ (deliver s).floor := by
  cases hp : s.pending with
  | nil =>
      have hs : deliver s = s := by simp [deliver, hp]
      rw [hs]
      exact ⟨rfl, hOld, hFloor⟩
  | cons pair rest =>
      have hToken : pair.1 ≤ generation :=
        hOld pair (by simp [hp])
      have hReject : ¬ s.floor ≤ pair.1 := by omega
      have hs : deliver s = { s with pending := rest } := by
        cases pair with
        | mk token effect =>
            simpa [deliver, hp, hReject]
      rw [hs]
      constructor
      · rfl
      constructor
      · intro p hMem
        exact hOld p (by simp [hp, hMem])
      · exact hFloor

theorem old_deliveries_cannot_land :
    ∀ n (s : Machine) (generation : Nat),
      generation + 1 ≤ s.floor → OldOnly s generation →
      (deliverMany n s).landed = s.landed ∧
      OldOnly (deliverMany n s) generation := by
  intro n
  induction n with
  | zero =>
      intro s generation floor hOld
      exact ⟨rfl, hOld⟩
  | succ n ih =>
      intro s generation floor hOld
      obtain ⟨hLanded, hTail, hNewFloor⟩ :=
        rejected_old_delivery s generation floor hOld
      obtain ⟨hRest, hStillOld⟩ :=
        ih (deliver s) generation hNewFloor hTail
      constructor
      · calc
          (deliverMany (n + 1) s).landed =
            (deliverMany n (deliver s)).landed := rfl
          _ = (deliver s).landed := hRest
          _ = s.landed := hLanded
      · exact hStillOld

/-- This theorem does not require the old queue to be empty. It requires
complete check-at-land coverage and *no new pending credentials above the
hold floor* during the examined sequence of deliveries. -/
theorem hold_refuses_all_preexisting_effects
    (s : Machine) (generation n : Nat)
    (hOld : OldOnly s generation) :
    (deliverMany n (hold s generation)).landed = s.landed := by
  have hFloor : generation + 1 ≤ (hold s generation).floor := by
    exact Nat.le_max_right s.floor (generation + 1)
  have hPending : OldOnly (hold s generation) generation := by
    exact hOld
  exact (old_deliveries_cannot_land
    n (hold s generation) generation hFloor hPending).1

/-- Source-level UPTFence hold and application-time physical refusal,
under THEIR RESPECTIVE explicit token/credential premises. -/
theorem source_hold_and_apply_time_refusal
    (target : UPTFence.St) (physical : Machine)
    (generation : Nat) (journal : List UPTFence.Ev) (n : Nat)
    (oldTokens : ∀ token, token ∈ target.minted → token ≤ generation)
    (laterTokens : ∀ token, UPTFence.Ev.mint token ∈ journal →
      token ≤ generation)
    (oldEffects : OldOnly physical generation) :
    (UPTFence.run (UPTFence.apply target (.raise (generation + 1))) journal).log =
      target.log ∧
      (deliverMany n (hold physical generation)).landed = physical.landed := by
  exact ⟨UPTFence.raise_then_nothing_lands
    target generation journal oldTokens laterTokens,
    hold_refuses_all_preexisting_effects physical generation n oldEffects⟩

/-- The exact error: a previously queued token may have been correctly
authorized at admission, yet still land after the hold if final physical
delivery omits its own credential check. -/
def unsafeDeliver (s : Machine) : Machine :=
  match s.pending with
  | [] => s
  | (_, effect) :: rest => { s with pending := rest, landed := s.landed + effect }

theorem admission_only_counterexample :
    ∃ s : Machine,
      s.floor ≤ 0 ∧
      s.landed < (unsafeDeliver (hold s 0)).landed ∧
      (deliver (hold s 0)).landed = s.landed := by
  refine ⟨⟨0, [(0, 1)], 0⟩, ?_, ?_, ?_⟩
  · exact Nat.zero_le _
  · change 0 < 1
    exact Nat.zero_lt_one
  · rfl

#print axioms rejected_old_delivery
#print axioms old_deliveries_cannot_land
#print axioms hold_refuses_all_preexisting_effects
#print axioms source_hold_and_apply_time_refusal
#print axioms admission_only_counterexample
end PhysicalBridges.IRFinalApplyFence
