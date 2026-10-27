/-
IR-59: Durable revocation under arbitrary post-hold queue injections.

IR-34 excludes new dispatch while protecting old queued effects. This
module removes that restriction for the *revoked-generation* guarantee:
new or even forged/resent old-generation queue entries can arrive after
the committed hold; the final landing check must still reject them.

revokedLanded is a ghost audit counter over the same source-level
IRDurableEpoch.deliver operation; it is NOT an independently measured
physical quantity. Fresh-generation effects may continue landing.
-/ 
import PhysicalBridges.IRDurableEpoch

namespace PhysicalBridges.IRPostHoldInjection

structure Audited where
  core : IRDurableEpoch.Persisted
  revokedLanded : Nat

/-- Diagnostic amount an ACTUAL guarded delivery would land from
the revoked cohort (token <= g). It is zero above the durable floor. -/
def revokedImpact (g : Nat) (s : IRDurableEpoch.Persisted) : Nat :=
  match s.live.pending with
  | [] => 0
  | (token, impact) :: _ =>
      if s.live.floor ≤ token then
        if token ≤ g then impact else 0
      else 0

/-- Intentionally UNRESTRICTED queue injection. Admission is not trusted
for the revoked-token result: the final landing check is decisive. -/
def inject (s : Audited) (token impact : Nat) : Audited :=
  { s with core :=
      { s.core with live :=
          { s.core.live with
            pending := s.core.live.pending ++ [(token, impact)] } } }

inductive Cmd
  | hold (generation : Nat)
  | restart
  | inject (token impact : Nat)
  | deliver

/-- Source-level durable hold, source-level restart, source-level guarded
deliver, plus an unconstrained new enqueue operation. -/
def step (g : Nat) (s : Audited) : Cmd → Audited
  | .hold next =>
      { s with core := IRDurableEpoch.commitHold s.core next }
  | .restart =>
      { s with core := IRDurableEpoch.restart s.core }
  | .inject token impact => inject s token impact
  | .deliver =>
      { core := IRDurableEpoch.deliver s.core,
        revokedLanded := s.revokedLanded + revokedImpact g s.core }

def run (g : Nat) (s : Audited) (cmds : List Cmd) : Audited :=
  cmds.foldl (step g) s

/-- Unlike IR-34's Protected predicate, there is NO OldOnly queue
assumption: any new entries, with arbitrary credentials, are allowed. -/
def Protected (s : Audited) (g : Nat) : Prop :=
  g + 1 ≤ s.core.durableFloor ∧ g + 1 ≤ s.core.live.floor

theorem no_revoked_impact_under_floor
    (s : IRDurableEpoch.Persisted) (g : Nat)
    (hFloor : g + 1 ≤ s.live.floor) :
    revokedImpact g s = 0 := by
  cases hp : s.live.pending with
  | nil => simp [revokedImpact, hp]
  | cons pair rest =>
      obtain ⟨token, impact⟩ := pair
      by_cases hApply : s.live.floor ≤ token
      · have hNotOld : ¬ token ≤ g := by omega
        simp [revokedImpact, hp, hApply, hNotOld]
      · simp [revokedImpact, hp, hApply]

/-- The source-level delivery never changes the enforcement floor. -/
theorem source_deliver_preserves_floor
    (s : IRDurableEpoch.Persisted) :
    (IRDurableEpoch.deliver s).live.floor = s.live.floor := by
  cases hp : s.live.pending with
  | nil =>
      simp [IRDurableEpoch.deliver, IRFinalApplyFence.deliver, hp]
  | cons pair rest =>
      obtain ⟨token, impact⟩ := pair
      by_cases hApply : s.live.floor ≤ token
      · simp [IRDurableEpoch.deliver, IRFinalApplyFence.deliver, hp, hApply]
      · simp [IRDurableEpoch.deliver, IRFinalApplyFence.deliver, hp, hApply]


/-- Fresh-generation component of a source-level guarded delivery.
Together with revokedImpact, this accounts for the *actual modeled*
landed-register increment, not just the ghost audit register. -/
def freshImpact (g : Nat) (s : IRDurableEpoch.Persisted) : Nat :=
  match s.live.pending with
  | [] => 0
  | (token, impact) :: _ =>
      if s.live.floor ≤ token then
        if g < token then impact else 0
      else 0

theorem source_delivery_exact_cohort_partition
    (s : IRDurableEpoch.Persisted) (g : Nat) :
    (IRDurableEpoch.deliver s).live.landed =
      s.live.landed + revokedImpact g s + freshImpact g s := by
  cases hp : s.live.pending with
  | nil =>
      simp [IRDurableEpoch.deliver, IRFinalApplyFence.deliver,
        revokedImpact, freshImpact, hp]
  | cons pair rest =>
      obtain ⟨token, impact⟩ := pair
      by_cases hApply : s.live.floor ≤ token
      · by_cases hOld : token ≤ g
        · have hNotFresh : ¬ g < token := by omega
          simp [IRDurableEpoch.deliver, IRFinalApplyFence.deliver,
            revokedImpact, freshImpact, hp, hApply, hOld, hNotFresh]
        · have hFresh : g < token := by omega
          simp [IRDurableEpoch.deliver, IRFinalApplyFence.deliver,
            revokedImpact, freshImpact, hp, hApply, hOld, hFresh]
      · simp [IRDurableEpoch.deliver, IRFinalApplyFence.deliver,
          revokedImpact, freshImpact, hp, hApply]

/-- The physical register *in the inherited synthetic actuator model*
can rise after a hold only through a fresh-generation token.
The proof connects the ghost-accounting predicate to the real
IRFinalApplyFence.deliver register update exactly. -/
theorem protected_source_delivery_is_fresh_only
    (s : IRDurableEpoch.Persisted) (g : Nat)
    (hFloor : g + 1 ≤ s.live.floor) :
    (IRDurableEpoch.deliver s).live.landed =
      s.live.landed + freshImpact g s := by
  rw [source_delivery_exact_cohort_partition]
  rw [no_revoked_impact_under_floor s g hFloor]
  simp

/-- Every protocol command preserves durable revocation, including an
arbitrary new queue injection. No renewed old-generation effect lands. -/
theorem protected_step
    (s : Audited) (g : Nat) (cmd : Cmd)
    (h : Protected s g) :
    Protected (step g s cmd) g ∧
    (step g s cmd).revokedLanded = s.revokedLanded := by
  obtain ⟨hDurable, hLive⟩ := h
  cases cmd with
  | hold next =>
      constructor
      · change
          g + 1 ≤ max s.core.durableFloor (next + 1) ∧
          g + 1 ≤ max s.core.live.floor (next + 1)
        exact ⟨Nat.le_trans hDurable (Nat.le_max_left _ _),
               Nat.le_trans hLive (Nat.le_max_left _ _)⟩
      · rfl
  | restart =>
      constructor
      · change
          g + 1 ≤ s.core.durableFloor ∧
          g + 1 ≤ s.core.durableFloor
        exact ⟨hDurable, hDurable⟩
      · rfl
  | inject token impact =>
      exact ⟨⟨hDurable, hLive⟩, rfl⟩
  | deliver =>
      constructor
      · change
          g + 1 ≤ s.core.durableFloor ∧
          g + 1 ≤ (IRDurableEpoch.deliver s.core).live.floor
        exact ⟨hDurable, by
          rw [source_deliver_preserves_floor]
          exact hLive⟩
      · change s.revokedLanded + revokedImpact g s.core =
          s.revokedLanded
        rw [no_revoked_impact_under_floor s.core g hLive]
        omega

/-- Arbitrary finite interleavings: later holds, restarts, injections
(old OR new credentials), deliveries. No dispatch-free precondition. -/
theorem revoked_effects_excluded_under_arbitrary_injection :
    ∀ (cmds : List Cmd) (s : Audited) (g : Nat),
      Protected s g →
      Protected (run g s cmds) g ∧
      (run g s cmds).revokedLanded = s.revokedLanded := by
  intro cmds
  induction cmds with
  | nil =>
      intro s g h
      exact ⟨h, rfl⟩
  | cons cmd rest ih =>
      intro s g h
      obtain ⟨hNext, hCount⟩ := protected_step s g cmd h
      obtain ⟨hFinal, hRest⟩ := ih (step g s cmd) g hNext
      refine ⟨hFinal, ?_⟩
      calc
        (run g s (cmd :: rest)).revokedLanded =
          (run g (step g s cmd) rest).revokedLanded := rfl
        _ = (step g s cmd).revokedLanded := hRest
        _ = s.revokedLanded := hCount

theorem committed_hold_rejects_revoked_under_any_injections
    (s : Audited) (g : Nat) (cmds : List Cmd) :
    (run g (step g s (.hold g)) cmds).revokedLanded =
      s.revokedLanded := by
  have hProtected : Protected (step g s (.hold g)) g := by
    constructor
    · change g + 1 ≤ max s.core.durableFloor (g + 1)
      exact Nat.le_max_right _ _
    · change g + 1 ≤ max s.core.live.floor (g + 1)
      exact Nat.le_max_right _ _
  have h := (revoked_effects_excluded_under_arbitrary_injection
    cmds (step g s (.hold g)) g hProtected).2
  calc
    (run g (step g s (.hold g)) cmds).revokedLanded =
      (step g s (.hold g)).revokedLanded := h
    _ = s.revokedLanded := rfl

/-- Non-vacuity: a post-hold fresh-generation command CAN land while
revoked-generation landed impact remains zero. -/
theorem fresh_generation_can_still_land :
    ∃ s : Audited,
      (run 0 (step 0 s (.hold 0)) [.inject 1 1, .deliver]).core.live.landed =
        s.core.live.landed + 1 ∧
      (run 0 (step 0 s (.hold 0)) [.inject 1 1, .deliver]).revokedLanded =
        s.revokedLanded := by
  refine ⟨
    { core := { durableFloor := 0,
                live := { floor := 0, pending := [], landed := 0 } },
      revokedLanded := 0 }, ?_⟩
  decide

/-- Volatile-only revocation is not sufficient: after restart an old
credential can land on the source-level actuator. -/
def volatileOnlyHold (s : Audited) (g : Nat) : Audited :=
  { s with core :=
      { s.core with live := IRFinalApplyFence.hold s.core.live g } }

theorem volatile_only_hold_allows_revoked_after_restart :
    ∃ s : Audited,
      (run 0 (volatileOnlyHold s 0) [.restart, .deliver]).revokedLanded >
        s.revokedLanded := by
  refine ⟨
    { core := { durableFloor := 0,
                live := { floor := 0, pending := [(0, 1)], landed := 0 } },
      revokedLanded := 0 }, ?_⟩
  decide

#print axioms no_revoked_impact_under_floor
#print axioms source_deliver_preserves_floor
#print axioms source_delivery_exact_cohort_partition
#print axioms protected_source_delivery_is_fresh_only
#print axioms protected_step
#print axioms revoked_effects_excluded_under_arbitrary_injection
#print axioms committed_hold_rejects_revoked_under_any_injections
#print axioms fresh_generation_can_still_land
#print axioms volatile_only_hold_allows_revoked_after_restart

end PhysicalBridges.IRPostHoldInjection
