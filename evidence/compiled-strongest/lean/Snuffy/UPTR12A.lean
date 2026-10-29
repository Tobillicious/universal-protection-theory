import Snuffy.UPTLawLife
import Snuffy.ControllerFence

/-!
Snuffy R12-A: source-level, proof-carrying decision-to-effect adapter.
REVIEW CANDIDATE, 23 October 2026; not author-adopted.
Imports original UPTLawLife, ControllerFinality, UPTFence through ControllerFence.
Lean 4.35.0 core only; no Mathlib, no `sorry`, no new axioms.

IMPORTANT: A proof-carrying permit is a *model* of a verified receipt. At a real
physical target, proof erasure, wire codecs, cryptography, semantic completeness,
and physical route coverage are separate refinement obligations. This module
must not be cited as certifying an actual hardware boundary.
-/

namespace UPTR12A

/-- An exact, fixed-arity semantic binding. Numbers are immutable identifiers;
    their interpretation and completeness need external evidence. -/
structure Meaning where
  resident : Nat
  criterion : Nat
  feasibleFamily : Nat
  outcomeSemantics : Nat
  policy : Nat
  target : Nat
  effect : Nat
  activation : Nat
  deadlineBasis : Nat
  riskLedger : Nat
  deriving DecidableEq, Repr

/-- The controller's opaque enrolment `scope` has a typed, unambiguous encoding. -/
def words (m : Meaning) : List Nat :=
  [1201, m.resident, m.criterion, m.feasibleFamily, m.outcomeSemantics,
    m.policy, m.target, m.effect, m.activation, m.deadlineBasis, m.riskLedger]

/-- Fixed-width semantic scope cannot alias two distinct model bindings. -/
theorem words_injective {a b : Meaning} (h : words a = words b) : a = b := by
  cases a
  cases b
  simp_all [words]

/-- A mathematical decision certificate with the actual four-stage law proof.
    This is stronger than a flag or signer-generated claim of maximality. -/
structure DecisionCertificate where
  meaning : Meaning
  feasible : Nat → Prop
  aliveExisting : Nat → Nat → Prop
  freeExisting : Nat → Nat → Prop
  aliveNew : Nat → Nat → Prop
  freeNew : Nat → Nat → Prop
  chosen : Nat
  chosen_eq : chosen = meaning.policy
  aligned : UPT.LexAlignedL feasible
    [aliveExisting, freeExisting, aliveNew, freeNew] chosen

/-- A verified controller grant and its exact decision-to-context binding.
    `grant` must be obtained from controller replay/finality, not a wire assertion. -/
structure BoundGrant where
  cert : DecisionCertificate
  enrol : Nat → List Nat
  controller : UPTController.State
  context : UPTController.Context
  scopeBound : context.scope = words cert.meaning
  grant : (UPTController.step enrol controller
    (.authorize context)).2 = .grant context

/-- The enrolled immutable scope at the granted generation is the proven decision. -/
theorem grant_has_decision_scope (g : BoundGrant) :
    g.enrol g.context.generation = words g.cert.meaning := by
  have h := (UPTController.grant_fields g.enrol g.controller g.context g.grant).1
  exact h.symm.trans g.scopeBound

/-- Two genuine same-generation grants cannot rebind to different meanings.
    Relies on immutable enrollment; says nothing about semantic truth of the ID fields. -/
theorem same_generation_cannot_rebind (a b : BoundGrant)
    (sameEnrol : a.enrol = b.enrol)
    (sameGen : a.context.generation = b.context.generation) :
    a.cert.meaning = b.cert.meaning := by
  apply words_injective
  calc
    words a.cert.meaning = a.enrol a.context.generation :=
      (grant_has_decision_scope a).symm
    _ = b.enrol b.context.generation := by rw [sameEnrol, sameGen]
    _ = words b.cert.meaning := grant_has_decision_scope b

/-- Finality is an additional condition beyond the controller's local grant.
    The receipt is tied to a replayed state and a prefix of the finalized operation log. -/
structure FinalizedGrant where
  bound : BoundGrant
  initial : UPTController.State
  receipt : UPTController.Receipt
  finalOps : List UPTController.Op
  receiptContext : receipt.context = bound.context
  receiptIsGrant : receipt.isFloor = false
  sameReplayState : bound.controller =
    UPTController.run bound.enrol initial receipt.past
  replayProof : UPTController.replayOK bound.enrol initial receipt
  finalPrefix : UPTController.Prefix (UPTController.history receipt) finalOps

/-- Its exact source-controller receipt occurs within the finalised operation log. -/
theorem finalized_receipt_is_in_log (g : FinalizedGrant) :
    ∃ suffix, g.finalOps =
      (g.receipt.past ++ [UPTController.namedOp g.receipt]) ++ suffix := by
  obtain ⟨suffix, heq, _⟩ :=
    UPTController.receipt_names_success g.bound.enrol g.initial
      g.receipt g.finalOps g.finalPrefix g.replayProof
  exact ⟨suffix, heq⟩

/-- The final operation named by this receipt is genuinely an authorization,
    never a retirement reply masquerading as a grant. -/
theorem finalized_receipt_is_authorize (g : FinalizedGrant) :
    UPTController.namedOp g.receipt = .authorize g.bound.context := by
  simp [UPTController.namedOp, g.receiptIsGrant, g.receiptContext]

/-- Effect payload and identity are checked at the linearisation point,
    not only when a permit is requested. -/
structure Effect where
  meaning : Meaning
  generation : Nat
  nonce : Nat
  deriving DecidableEq, Repr

structure Target where
  id : Nat
  floor : Nat
  usedNonces : List Nat
  committed : List Effect
  deriving Repr

/-- This abstract target checks a proof-carrying grant *and* exact payload binding.
    A deployed sink must actually implement every conjunct. -/
def Accepts (s : Target) (fg : FinalizedGrant) (e : Effect) : Prop :=
  s.id = fg.bound.cert.meaning.target ∧
  s.floor ≤ fg.bound.context.generation ∧
  e.generation = fg.bound.context.generation ∧
  e.nonce = fg.bound.context.nonce ∧
  e.meaning = fg.bound.cert.meaning ∧
  fg.bound.context.nonce ∉ s.usedNonces

instance (s : Target) (fg : FinalizedGrant) (e : Effect) : Decidable (Accepts s fg e) := by
  unfold Accepts; infer_instance

def applyEffect (s : Target) (fg : FinalizedGrant) (e : Effect) : Target :=
  if Accepts s fg e then
    { s with
      usedNonces := fg.bound.context.nonce :: s.usedNonces
      committed := s.committed ++ [e] }
  else s

/-- No target-log change without satisfying all application-time checks. -/
theorem changed_log_implies_checks (s : Target) (fg : FinalizedGrant) (e : Effect)
    (changed : (applyEffect s fg e).committed ≠ s.committed) : Accepts s fg e := by
  by_cases h : Accepts s fg e
  · exact h
  · have heq : (applyEffect s fg e).committed = s.committed := by
      simp [applyEffect, h]
    exact False.elim (changed heq)

/-- The named end-to-end mathematical bridge: an applied effect identifies the
    SAME resident/criterion/policy/target/payload as the verified aligned decision. -/
theorem applied_effect_has_aligned_decision (s : Target) (fg : FinalizedGrant) (e : Effect)
    (changed : (applyEffect s fg e).committed ≠ s.committed) :
    e.meaning = fg.bound.cert.meaning ∧
    e.meaning.policy = fg.bound.cert.chosen ∧
    UPT.LexAlignedL fg.bound.cert.feasible
      [fg.bound.cert.aliveExisting, fg.bound.cert.freeExisting,
       fg.bound.cert.aliveNew, fg.bound.cert.freeNew] fg.bound.cert.chosen := by
  have h := changed_log_implies_checks s fg e changed
  rcases h with ⟨_, _, _, _, hMeaning, _⟩
  exact ⟨hMeaning, by rw [hMeaning]; exact fg.bound.cert.chosen_eq.symm,
    fg.bound.cert.aligned⟩

/-- Retired-generation effects cannot change the target after floor installation. -/
theorem raised_floor_refuses (s : Target) (fg : FinalizedGrant) (e : Effect)
    (old : fg.bound.context.generation < s.floor) :
    (applyEffect s fg e).committed = s.committed := by
  have no : ¬ Accepts s fg e := by
    intro h
    exact Nat.not_le_of_gt old h.2.1
  simp [applyEffect, no]

/-- An effect for a different policy, subject, target, semantic family, or payload
    cannot be accepted as the certified effect. -/
theorem wrong_effect_refuses (s : Target) (fg : FinalizedGrant) (e : Effect)
    (wrong : e.meaning ≠ fg.bound.cert.meaning) :
    (applyEffect s fg e).committed = s.committed := by
  have no : ¬ Accepts s fg e := by
    intro h
    exact wrong h.2.2.2.2.1
  simp [applyEffect, no]

/-- A nonce already used at the effect target cannot append a second effect. -/
theorem replay_refuses (s : Target) (fg : FinalizedGrant) (e : Effect)
    (used : fg.bound.context.nonce ∈ s.usedNonces) :
    (applyEffect s fg e).committed = s.committed := by
  have no : ¬ Accepts s fg e := by
    intro h
    exact h.2.2.2.2.2 used
  simp [applyEffect, no]

/-- The actual source bridge remains available for target-side held windows.
    It is separate from the decision-to-effect proof and preserves its assumptions. -/
theorem original_fence_theorem_available (s : UPTFence.St) (g : Nat)
    (attempts : List UPTFence.Ev)
    (oldTokens : ∀ h, h ∈ s.minted → h ≤ g)
    (laterTokens : ∀ h, UPTFence.Ev.mint h ∈ attempts → h ≤ g) :
    (UPTFence.run (UPTFence.apply s (.raise (g + 1))) attempts).log = s.log := by
  exact UPTFence.raise_then_nothing_lands s g attempts oldTokens laterTokens

end UPTR12A
