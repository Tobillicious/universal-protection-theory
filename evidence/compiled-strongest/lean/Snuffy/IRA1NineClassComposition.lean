import Snuffy.IRA1CommissionEscrow
import Snuffy.IRA1Retirement

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRA1NineClassComposition.lean` at main `740abbb` (sha256 `f15568866e185e9372143dbef496f94d1481e0f50ea296ab972964e7cb5af68c`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-92 — a single source-level A1 register composition across all
nine ORIGINAL archived transition classes T1.1 through T3.3.

Original source map 24 Oct A1-REGISTER:
 T1.1 permission-mask page grant          IR84
 T1.2 DMA authorized window                IR83
 T1.3 context switch privilege ceiling     IR83
 T2.1 packet authenticated sequence        IR85
 T2.2 causal field transit                 IR86
 T2.3 durable journal & receipt            IR87 + IR88 JOIN
 T3.1 commissioning initial/ongoing escrow IR89
 T3.2 descendant authority non-escalation  IR90 (+ IR84 mask)
 T3.3 controller retirement/handoff        IR91

This is ONE inductive SOURCE-STATE theorem, and NOT a proof that
all actual physical effects have one of these nine representations.
The original A1 was a register with open per-row PLANT installation.
Some classes are combined into one source event (e.g., packet commit
checks T2.1 and T2.2 before T2.3 journaling). The asynchronous
physical correspondence and historical X3 same-particular service
and autonomy remain explicitly OPEN.

The modeled retired controller rejects ALL later source events;
this is a controller-finality statement, not permission to end the
protected history. Continuing custody must exist elsewhere.
-/

namespace PhysicalBridges.IRA1NineClassComposition

structure CommissionState where
  escrow : Nat
  initialCost : Nat
  recurringCost : Nat
  horizon : Nat
  approved : Bool
deriving Repr

def CommissionSafe (c : CommissionState) : Prop :=
  c.approved = true →
    c.initialCost + c.horizon * c.recurringCost ≤ c.escrow

def authorizeCommission (c : CommissionState) : CommissionState :=
  let pass := IRA1CommissionEscrow.commissionPermit c.escrow c.initialCost c.recurringCost c.horizon
  { c with approved := pass }

theorem authorize_commission_preserves_finite_window
    (c : CommissionState) :
    CommissionSafe (authorizeCommission c) := by
  intro hApproved
  have hPermit :
      IRA1CommissionEscrow.commissionPermit
        c.escrow c.initialCost c.recurringCost c.horizon = true := by
    simpa [authorizeCommission] using hApproved
  have hBudget : c.initialCost + c.horizon * c.recurringCost ≤ c.escrow :=
    decide_eq_true_eq.mp
      (by simpa [IRA1CommissionEscrow.commissionPermit] using hPermit)
  simpa [CommissionSafe,authorizeCommission] using hBudget

structure World where
  host : IRA1PageCapability.PageState
  field : IRA1PacketJournalJoin.JointState
  delegates : IRA1Delegation.DelegationState
  commission : CommissionState
  retirement : IRA1Retirement.ControllerState

/-- Link T3.2 descendant ROOT authority with original T1.1
admitted global page permission mask. Without this join,
source-level parent delegation could exceed global mask. -/
def RootWithinMask (s : World) : Prop :=
  ∀ cap, cap ∈ s.delegates.authority →
    s.host.permittedMask cap = true

structure GlobalSafe
    (ceiling : Nat) (authCheck : IRA1PacketIngress.Packet → Bool)
    (s : World) : Prop where
  host : IRA1PageCapability.safe ceiling s.host
  field : IRA1PacketJournalJoin.JointSafe authCheck s.field
  delegation : IRA1Delegation.ValidDelegations s.delegates
  retirement : IRA1Retirement.ReleaseSafe s.retirement
  commission : CommissionSafe s.commission
  rootMask : RootWithinMask s

inductive Event
  | host (e : IRA1PageCapability.PageEvent)
  | packet (p : IRA1PacketIngress.Packet)
           (t : IRA1CausalField.Transit)
  | journalReboot
  | authorizeCommission
  | delegate (child : List Nat)
  | retire (e : IRA1Retirement.Event)

/-- Full source install is fail-closed after modeled controller
retirement. Actual protected subjects need an independently
installed handoff; model absorption is only device finality. -/
def step
    (window ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (env : IRA1CausalField.LinkBounds)
    (s : World) (e : Event) : World :=
  if s.retirement.custodyReleased then s
  else
    match e with
    | .host h =>
        let newHost := IRA1PageCapability.execute window ceiling s.host h
        { s with host := newHost }
    | .packet p transit =>
        let newField := IRA1PacketJournalJoin.commitIngress authCheck env s.field p transit
        { s with field := newField }
    | .journalReboot =>
        { s with field := IRA1PacketJournalJoin.reboot s.field }
    | .authorizeCommission =>
        { s with commission := authorizeCommission s.commission }
    | .delegate child =>
        { s with delegates := IRA1Delegation.delegate s.delegates child }
    | .retire e =>
        { s with retirement := IRA1Retirement.step s.retirement e }

theorem post_release_source_world_is_absorbing
    (window ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (env : IRA1CausalField.LinkBounds)
    (s : World) (e : Event)
    (hReleased : s.retirement.custodyReleased = true) :
    step window ceiling authCheck env s e = s := by
  simp [step,hReleased]

/-- Every individual SOURCE event is proved to preserve all six
cross-module source invariants. This is NOT an assumption named
'a1WellFormedImpliesWellFormed': the proof calls each exact
previously compiled module theorem. -/
theorem step_preserves_all_a1_source_invariants
    (window ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (env : IRA1CausalField.LinkBounds)
    (s : World) (e : Event)
    (hSafe : GlobalSafe ceiling authCheck s) :
    GlobalSafe ceiling authCheck
      (step window ceiling authCheck env s e) := by
  by_cases hReleased : s.retirement.custodyReleased = true
  · simpa [post_release_source_world_is_absorbing
      window ceiling authCheck env s e hReleased] using hSafe
  · have hLocked : s.retirement.custodyReleased = false := by
      cases hs : s.retirement.custodyReleased <;> simp_all
    cases e with
    | host hostEvent =>
        have hHost :=
          IRA1PageCapability.execute_preserves_safe
            window ceiling s.host hostEvent hSafe.host
        have hRoot :
            ∀ cap, cap ∈ s.delegates.authority →
              (IRA1PageCapability.execute
                window ceiling s.host hostEvent).permittedMask cap = true := by
          intro cap hCap
          have hm := IRA1PageCapability.execute_preserves_mask
            window ceiling s.host hostEvent
          rw [hm]
          exact hSafe.rootMask cap hCap
        simpa [step,hLocked,GlobalSafe,RootWithinMask] using
          (show GlobalSafe ceiling authCheck
            {s with host := IRA1PageCapability.execute window ceiling s.host hostEvent} from
            ⟨hHost,hSafe.field,hSafe.delegation,hSafe.retirement,
              hSafe.commission,hRoot⟩)
    | packet packet transit =>
        have hf :=
          IRA1PacketJournalJoin.commit_ingress_preserves_joint_safety
            authCheck env s.field packet transit hSafe.field
        simpa [step,hLocked] using
          (show GlobalSafe ceiling authCheck
            {s with field := IRA1PacketJournalJoin.commitIngress authCheck env s.field packet transit} from
            ⟨hSafe.host,hf,hSafe.delegation,hSafe.retirement,
              hSafe.commission,hSafe.rootMask⟩)
    | journalReboot =>
        have hf :=
          IRA1PacketJournalJoin.reboot_preserves_joint_safety
            authCheck s.field hSafe.field
        simpa [step,hLocked] using
          (show GlobalSafe ceiling authCheck
            {s with field := IRA1PacketJournalJoin.reboot s.field} from
            ⟨hSafe.host,hf,hSafe.delegation,hSafe.retirement,
              hSafe.commission,hSafe.rootMask⟩)
    | authorizeCommission =>
        have hc :=
          authorize_commission_preserves_finite_window s.commission
        simpa [step,hLocked] using
          (show GlobalSafe ceiling authCheck
            {s with commission := authorizeCommission s.commission} from
            ⟨hSafe.host,hSafe.field,hSafe.delegation,hSafe.retirement,
              hc,hSafe.rootMask⟩)
    | delegate child =>
        have hd :=
          IRA1Delegation.delegate_preserves_nonescalation
            s.delegates child hSafe.delegation
        have hm :
            ∀ cap, cap ∈
              (IRA1Delegation.delegate
                s.delegates child).authority →
              s.host.permittedMask cap = true := by
          intro cap hCap
          have hRoot := IRA1Delegation.delegation_preserves_parent_authority
            s.delegates child
          rw [hRoot] at hCap
          exact hSafe.rootMask cap hCap
        simpa [step,hLocked,GlobalSafe,RootWithinMask] using
          (show GlobalSafe ceiling authCheck
            {s with delegates := IRA1Delegation.delegate s.delegates child} from
            ⟨hSafe.host,hSafe.field,hd,hSafe.retirement,
              hSafe.commission,hm⟩)
    | retire retirementEvent =>
        have hr :=
          IRA1Retirement.one_lifecycle_step_preserves_release_safety
            s.retirement retirementEvent hSafe.retirement
        simpa [step,hLocked] using
          (show GlobalSafe ceiling authCheck
            {s with retirement := IRA1Retirement.step s.retirement retirementEvent} from
            ⟨hSafe.host,hSafe.field,hSafe.delegation,hr,
              hSafe.commission,hSafe.rootMask⟩)

def run
    (window ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (env : IRA1CausalField.LinkBounds)
    (s : World) (events : List Event) : World :=
  events.foldl (step window ceiling authCheck env) s

/-- All nine admitted SOURCE cases compose over ARBITRARY FINITE
original A1-class event histories, not just a small example.
Physical source-to-effect completeness and long-horizon continual
historical subject existence are distinct missing theorems. -/
theorem arbitrary_finite_nine_class_source_trace_is_safe
    (window ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (env : IRA1CausalField.LinkBounds)
    (s : World) (events : List Event)
    (h : GlobalSafe ceiling authCheck s) :
    GlobalSafe ceiling authCheck
      (run window ceiling authCheck env s events) := by
  induction events generalizing s with
  | nil => exact h
  | cons ev rest ih =>
      change GlobalSafe ceiling authCheck
        (run window ceiling authCheck env
          (step window ceiling authCheck env s ev) rest)
      exact ih (step window ceiling authCheck env s ev)
        (step_preserves_all_a1_source_invariants
          window ceiling authCheck env s ev h)

/-- A fully retired controller SOURCE installation rejects any
subsequent event from the same installation, including packet,
page, commissioning and delegation operations. This does NOT stop
external physical processes outside this modeled controller. -/
theorem already_released_world_freezes_every_a1_event
    (window ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (env : IRA1CausalField.LinkBounds)
    (s : World) (events : List Event)
    (h : s.retirement.custodyReleased = true) :
    run window ceiling authCheck env s events = s := by
  induction events generalizing s with
  | nil => rfl
  | cons ev rest ih =>
      change run window ceiling authCheck env
        (step window ceiling authCheck env s ev) rest = s
      rw [post_release_source_world_is_absorbing
        window ceiling authCheck env s ev h]
      exact ih s h


end PhysicalBridges.IRA1NineClassComposition
