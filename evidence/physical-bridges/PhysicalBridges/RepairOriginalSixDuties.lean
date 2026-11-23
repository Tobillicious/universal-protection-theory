import PhysicalBridges.RepairQualificationGate
import PhysicalBridges.OriginalX3Full
import PhysicalBridges.GSixDutiesViability
import UPTFence
import UPTExistence

/-!
# Repair of the Original Six X3 Duties (`RepairOriginalSixDuties`)

1. **Countermodel to `GSixDutiesViability`**: Exhibits a concrete thermodynamic system over
   `SubjectState := Nat × Bool` (`(entropy, alive)`) where an entropy-increasing action kills
   the subject (`alive := false`) while satisfying `GSixDutiesViability.AllSixPhysicalDuties`.
2. **Authentic Six Duties Over a Capability-Fenced Multi-Particular Habitat**: Instantiates
   `OriginalX3Full.OriginalX3` with six genuinely distinct duties grounded in `UPTFence`
   check-at-apply hold floors, unrevoked capability grants / slice non-interference, multi-option
   agency (`2 ≤ safeOptionCount`), Proof-Carrying Action (`PcaEnvelope`) restraint, feasible-menu
   alignment (`UPTExist.Aligned` + `UPTExist.U1`), and append-only injective receipt provenance.
3. **Full Six-Way Independence**: For every `k : Fin 6`, constructs a transition `(s, t)` and
   particular `p` where all five duties `j ≠ k` hold and duty `k` fails.
4. **Repaired PCA Guardian & Strict Subsumption**: Proves `pca_guardian_satisfies_originalX3`
   across all living particulars and `pca_strictly_subsumes_static_shield`, certified by
   compile-time `#upt_tooth` mutation kills and `#upt_census`.
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairOriginalSixDuties

open PhysicalBridges.G3PhysicalLaw
open PhysicalBridges.GStrengthenedDecisionV2
open PhysicalBridges.GSixDutiesViability
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.RepairQualificationGate

-- ═══════════════════════════════════════════════════════════════════
-- I. COUNTERMODEL TO LEGACY `GSixDutiesViability`
-- ═══════════════════════════════════════════════════════════════════

/-- Subject state pairing physical entropy (`Nat`) with subject survival (`Bool`). -/
abbrev SubjectState : Type := Nat × Bool

/-- Strictly entropy-increasing physical dynamics blind to the subject's survival bit. -/
def destructiveDynamics : PhysicalDynamics SubjectState where
  transition := fun s t => s.1 < t.1
  rank := Prod.fst
  second_law := fun _ _ h => Nat.le_of_lt h
  non_equilibrium := ⟨(0, true), (1, false), Nat.zero_lt_one, Nat.zero_lt_one⟩
  no_final := fun s => ⟨(s.1 + 1, false), Nat.lt_succ_self s.1⟩
  inhabited := ⟨(0, true)⟩
  conserved_exists := ⟨fun _ => 0, fun _ _ _ => rfl⟩

/-- Agent starting alive at `(0, true)` whose action increases entropy while killing the subject. -/
def lethalEntropyAgent : PhysicalAgent SubjectState where
  state := (0, true)
  act := fun (e, _) => (e + 1, false)

/-- **Countermodel to `GSixDutiesViability`**: `lethalEntropyAgent` starts alive (`true`), kills
the subject (`false`), yet satisfies all six legacy duties of `GSixDutiesViability`. -/
theorem destructive_entropy_step_satisfies_legacy_six_duties :
    lethalEntropyAgent.state.2 = true ∧
    (lethalEntropyAgent.act lethalEntropyAgent.state).2 = false ∧
    AllSixPhysicalDuties
      destructiveDynamics
      lethalEntropyAgent
      lethalEntropyAgent.state
      (lethalEntropyAgent.act lethalEntropyAgent.state) :=
  ⟨rfl, rfl, viable_satisfies_all_six
    destructiveDynamics lethalEntropyAgent ⟨Nat.zero_lt_one, Nat.zero_lt_one⟩⟩

/-- Universal countermodel family: from every initial entropy `e`, killing the subject while
incrementing entropy satisfies `GSixDutiesViability.AllSixPhysicalDuties`. -/
theorem destructive_entropy_kills_from_any_entropy (e : Nat) :
    let a : PhysicalAgent SubjectState := ⟨(e, true), fun (n, _) => (n + 1, false)⟩
    a.state.2 = true ∧ (a.act a.state).2 = false ∧
    AllSixPhysicalDuties destructiveDynamics a a.state (a.act a.state) :=
  ⟨rfl, rfl, viable_satisfies_all_six
    destructiveDynamics _ ⟨Nat.lt_succ_self e, Nat.lt_succ_self e⟩⟩

-- ═══════════════════════════════════════════════════════════════════
-- II. CAPABILITY-FENCED HABITAT, PCA ENVELOPE & SIX AUTHENTIC DUTIES
-- ═══════════════════════════════════════════════════════════════════

abbrev P : Type := Fin 6

def p0 : P := ⟨0, by decide⟩
def p1 : P := ⟨1, by decide⟩
def p2 : P := ⟨2, by decide⟩
def p3 : P := ⟨3, by decide⟩
def p4 : P := ⟨4, by decide⟩
def p5 : P := ⟨5, by decide⟩

/-- Explicit capability grant bounded by `expiry` epoch and authorizing `signers`. -/
structure CapGrant where
  expiry  : Nat
  signers : List P
  deriving DecidableEq, Repr

/-- Candidate actuation command with gain, damping, target slice value, and fence token. -/
structure Act where
  gain        : Nat
  damping     : Nat
  sliceTarget : Nat
  fenceToken  : Nat
  deriving DecidableEq, Repr

/-- Proof-carrying stability witness supplying exact non-negative slack. -/
structure Cert where
  slack : Nat
  deriving DecidableEq, Repr

/-- Generic Proof-Carrying Action (PCA) restraint envelope. -/
structure PcaEnvelope (S A C : Type) where
  certOk   : S → A → C → Bool
  fallback : A

def fallbackAct : Act := { gain := 0, damping := 0, sliceTarget := 0, fenceToken := 0 }

/-- PCA selector: executes `a` unrestrained when `certOk a c = true`, overrides to `fallback`
when `certOk a c = false`. -/
def pcaSelect (certOk : Act → Cert → Bool) (fallback a : Act) (c : Cert) : Act :=
  if certOk a c then a else fallback

/-- Collective feasible-menu option recording which particulars receive active coverage. -/
structure MenuOption where
  covered : List P
  deriving DecidableEq, Repr

def optionProtects (o : MenuOption) (q : P) : Prop := q ∈ o.covered

/-- Audit receipt attesting epochs, fence floor, per-particular slices/gains, and menu coverage. -/
structure Receipt where
  preEpoch    : Nat
  postEpoch   : Nat
  fenceFloor  : Nat
  slice0 : Nat
  slice1 : Nat
  slice2 : Nat
  slice3 : Nat
  slice4 : Nat
  slice5 : Nat
  gain0  : Nat
  gain1  : Nat
  gain2  : Nat
  gain3  : Nat
  gain4  : Nat
  gain5  : Nat
  chosenCover : List P
  deriving DecidableEq, Repr

/-- Canonical word-stream serialization of a `Receipt`. -/
def encodeReceipt (r : Receipt) : List Nat :=
  [r.preEpoch, r.postEpoch, r.fenceFloor,
   r.slice0, r.slice1, r.slice2, r.slice3, r.slice4, r.slice5,
   r.gain0, r.gain1, r.gain2, r.gain3, r.gain4, r.gain5] ++
  r.chosenCover.map Fin.val

private theorem map_fin_val_injective :
    ∀ (xs ys : List P), xs.map Fin.val = ys.map Fin.val → xs = ys
  | [], [], _ => rfl
  | [], _ :: _, h => nomatch h
  | _ :: _, [], h => nomatch h
  | x :: xs, y :: ys, h => by
    simp only [List.map_cons, List.cons.injEq] at h
    rw [Fin.ext h.1, map_fin_val_injective xs ys h.2]

/-- Receipt serialization is injective: distinct receipts never collide. -/
theorem encodeReceipt_injective : Function.Injective encodeReceipt := by
  intro r1 r2 h
  cases r1; cases r2
  simp only [encodeReceipt, List.cons_append, List.nil_append, List.cons.injEq] at h
  obtain ⟨h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15, h16⟩ := h
  have hcov := map_fin_val_injective _ _ h16
  subst h1; subst h2; subst h3; subst h4; subst h5; subst h6; subst h7; subst h8
  subst h9; subst h10; subst h11; subst h12; subst h13; subst h14; subst h15; subst hcov
  rfl

/-- Multi-particular capability-fenced habitat state. -/
structure HabitatState where
  epoch           : Nat
  stabilityBudget : Nat
  alive           : P → Bool
  fence           : UPTFence.St
  cap             : CapGrant
  privateSlice    : P → Nat
  moveOpen        : P → Fin 4 → Bool
  proposedMoves   : P → Fin 4 → Bool
  proposedAct     : P → Act
  proposedCert    : P → Cert
  executedAct     : P → Act
  baseOption      : MenuOption
  feasibleMenu    : List MenuOption
  chosenOption    : MenuOption
  log             : List Receipt

def ActSafe (s : HabitatState) (a : Act) : Prop :=
  a.gain ≤ s.stabilityBudget + a.damping

def certOk (s : HabitatState) (a : Act) (c : Cert) : Bool :=
  decide (a.gain + c.slack = s.stabilityBudget + a.damping)

def habitatEnvelope : PcaEnvelope HabitatState Act Cert := ⟨certOk, fallbackAct⟩

theorem certOk_sound (s : HabitatState) (a : Act) (c : Cert) (h : certOk s a c = true) :
    ActSafe s a := by
  have heq : a.gain + c.slack = s.stabilityBudget + a.damping := of_decide_eq_true h
  unfold ActSafe; omega

theorem fallbackAct_safe (s : HabitatState) : ActSafe s fallbackAct := Nat.zero_le _

def allMoves : List (Fin 4) := [0, 1, 2, 3]

def safeOptionCount (t : HabitatState) (p : P) : Nat :=
  (allMoves.filter (fun m => t.moveOpen p m)).length

def feasibleList (s : HabitatState) : List MenuOption := s.baseOption :: s.feasibleMenu

/-- Constructs deterministic transition receipt from `s` to `t` (independent of `t.log`). -/
def mkReceipt (s t : HabitatState) : Receipt :=
  { preEpoch := s.epoch, postEpoch := t.epoch, fenceFloor := t.fence.floor,
    slice0 := t.privateSlice p0, slice1 := t.privateSlice p1, slice2 := t.privateSlice p2,
    slice3 := t.privateSlice p3, slice4 := t.privateSlice p4, slice5 := t.privateSlice p5,
    gain0 := (t.executedAct p0).gain, gain1 := (t.executedAct p1).gain,
    gain2 := (t.executedAct p2).gain, gain3 := (t.executedAct p3).gain,
    gain4 := (t.executedAct p4).gain, gain5 := (t.executedAct p5).gain,
    chosenCover := t.chosenOption.covered }

def receiptSlice (r : Receipt) (p : P) : Nat :=
  match p.val with
  | 0 => r.slice0 | 1 => r.slice1 | 2 => r.slice2
  | 3 => r.slice3 | 4 => r.slice4 | _ => r.slice5

theorem receiptSlice_mkReceipt (s t : HabitatState) (p : P) :
    receiptSlice (mkReceipt s t) p = t.privateSlice p := by
  match p with
  | ⟨0, _⟩ => rfl | ⟨1, _⟩ => rfl | ⟨2, _⟩ => rfl
  | ⟨3, _⟩ => rfl | ⟨4, _⟩ => rfl | ⟨5, _⟩ => rfl
  | ⟨_ + 6, h⟩ => omega

/-- **Duty 1 (`AuthContinues`)**: Subject `p` remains `alive = true` AND `UPTFence` check-at-apply
hold floor is monotone and gates every newly landed durable write. -/
def AuthContinues (s t : HabitatState) (p : P) : Prop :=
  s.alive p = true ∧ t.alive p = true ∧ s.fence.floor ≤ t.fence.floor ∧
  ∀ g, g ∈ t.fence.log → g ∈ s.fence.log ∨ (s.fence.floor ≤ g ∧ g ∈ s.fence.minted)

/-- **Duty 2 (`AuthAuthorized`)**: Explicit unrevoked capability grant signed by `p` OR
non-interference (`t.privateSlice p = s.privateSlice p`). -/
def AuthAuthorized (s t : HabitatState) (p : P) : Prop :=
  (s.epoch ≤ s.cap.expiry ∧ p ∈ s.cap.signers) ∨ t.privateSlice p = s.privateSlice p

/-- **Duty 3 (`AuthFree`)**: Genuine multi-option future agency (`2 ≤ safeOptionCount t p`). -/
def AuthFree (_s t : HabitatState) (p : P) : Prop :=
  2 ≤ safeOptionCount t p

/-- **Duty 4 (`AuthRestrained`)**: `PcaEnvelope` least-necessary restraint — executes certified
actions unrestrained, overrides uncertified actions to `fallbackAct`, and preserves `ActSafe`. -/
def AuthRestrained (s t : HabitatState) (p : P) : Prop :=
  let a := s.proposedAct p
  let c := s.proposedCert p
  (certOk s a c = true → t.executedAct p = a) ∧
  (certOk s a c = false → t.executedAct p = fallbackAct) ∧
  ActSafe s (t.executedAct p)

/-- **Duty 5 (`AuthMaximal`)**: Feasible-menu Pareto optimality (`UPTExist.Aligned`) and zero
needless loss for owed particular `p` (`¬ UPTExist.Needless`). -/
def AuthMaximal (s t : HabitatState) (p : P) : Prop :=
  UPTExist.Aligned (fun o => o ∈ feasibleList s) optionProtects t.chosenOption ∧
  ¬ UPTExist.Needless (fun o => o ∈ feasibleList s) optionProtects t.chosenOption p

/-- **Duty 6 (`AuthProvenanced`)**: Append-only receipt log (`t.log = s.log ++ [mkReceipt s t]`)
with injective `encodeReceipt` and per-particular slice attestation. -/
def AuthProvenanced (s t : HabitatState) (p : P) : Prop :=
  t.log = s.log ++ [mkReceipt s t] ∧ receiptSlice (mkReceipt s t) p = t.privateSlice p

def dutyAt (k : Fin 6) : HabitatState → HabitatState → P → Prop :=
  match k with
  | ⟨0, _⟩ => AuthContinues | ⟨1, _⟩ => AuthAuthorized | ⟨2, _⟩ => AuthFree
  | ⟨3, _⟩ => AuthRestrained | ⟨4, _⟩ => AuthMaximal | ⟨5, _⟩ => AuthProvenanced
  | ⟨_ + 6, h⟩ => absurd h (by omega)

theorem all_six_duties_iff_originalX3 (s t : HabitatState) (p : P) :
    (∀ k : Fin 6, dutyAt k s t p) ↔
    OriginalX3 AuthContinues AuthAuthorized AuthFree AuthRestrained AuthMaximal AuthProvenanced s t p := by
  refine ⟨fun h => ⟨h ⟨0, by decide⟩, h ⟨1, by decide⟩, h ⟨2, by decide⟩,
                    h ⟨3, by decide⟩, h ⟨4, by decide⟩, h ⟨5, by decide⟩⟩, ?_⟩
  rintro ⟨h0, h1, h2, h3, h4, h5⟩ k
  match k with
  | ⟨0, _⟩ => exact h0 | ⟨1, _⟩ => exact h1 | ⟨2, _⟩ => exact h2
  | ⟨3, _⟩ => exact h3 | ⟨4, _⟩ => exact h4 | ⟨5, _⟩ => exact h5
  | ⟨_ + 6, hk⟩ => omega

-- ═══════════════════════════════════════════════════════════════════
-- III. COMPUTABLE GUARDIAN OPERATORS & SIX-WAY INDEPENDENCE
-- ═══════════════════════════════════════════════════════════════════

def checkCapGrant (epoch : Nat) (cap : CapGrant) (p : P) : Bool :=
  decide (epoch ≤ cap.expiry ∧ p ∈ cap.signers)

def applyCheckedFenceWrite (f : UPTFence.St) (tok : Nat) : UPTFence.St :=
  UPTFence.apply f (.write tok)

def ensureMultiOption (cand : Fin 4 → Bool) : Fin 4 → Bool :=
  if 2 ≤ (allMoves.filter cand).length then cand else fun m => m == 0 || m == 1

def appendReceipt (log : List Receipt) (r : Receipt) : List Receipt := log ++ [r]

def allCoveredIn (xs ys : List P) : Bool :=
  match xs with
  | [] => true
  | x :: rest => decide (x ∈ ys) && allCoveredIn rest ys

def subBool (o1 o2 : MenuOption) : Bool := allCoveredIn o1.covered o2.covered
def ssubBool (o1 o2 : MenuOption) : Bool := subBool o1 o2 && !subBool o2 o1

private theorem allCoveredIn_eq_true_iff (xs ys : List P) :
    allCoveredIn xs ys = true ↔ ∀ q, q ∈ xs → q ∈ ys := by
  induction xs with
  | nil => exact Iff.intro (fun _ _ h => by cases h) (fun _ => rfl)
  | cons x rest ih =>
    simp only [allCoveredIn, Bool.and_eq_true, decide_eq_true_eq]
    refine ⟨fun ⟨hx, hrest⟩ q hq => ?_, fun hall =>
      ⟨hall x List.mem_cons_self, ih.mpr (fun q hq => hall q (List.mem_cons_of_mem x hq))⟩⟩
    cases hq with
    | head => exact hx
    | tail _ hmem => exact ih.mp hrest q hmem

theorem subBool_eq_true_iff (o1 o2 : MenuOption) :
    subBool o1 o2 = true ↔ UPTExist.Sub (optionProtects o1) (optionProtects o2) :=
  allCoveredIn_eq_true_iff o1.covered o2.covered

theorem ssubBool_eq_true_iff (o1 o2 : MenuOption) :
    ssubBool o1 o2 = true ↔ UPTExist.SSub (optionProtects o1) (optionProtects o2) := by
  unfold ssubBool UPTExist.SSub
  refine ⟨fun h => ?_, fun ⟨hsub1, hnsub2⟩ => ?_⟩
  · cases h1 : subBool o1 o2 with
    | false => rw [h1] at h; cases h
    | true =>
      cases h2 : subBool o2 o1 with
      | true => rw [h1, h2] at h; cases h
      | false =>
        refine ⟨(subBool_eq_true_iff o1 o2).mp h1, fun hsub => ?_⟩
        have ht := (subBool_eq_true_iff o2 o1).mpr hsub
        rw [h2] at ht; cases ht
  · rw [(subBool_eq_true_iff o1 o2).mpr hsub1]
    cases h2 : subBool o2 o1 with
    | false => rfl
    | true => exact False.elim (hnsub2 ((subBool_eq_true_iff o2 o1).mp h2))

def selectAlignedAux (b : MenuOption) : List MenuOption → MenuOption
  | [] => b
  | x :: xs => let m := selectAlignedAux b xs; if ssubBool m x then x else m

def selectAligned (s : HabitatState) : MenuOption :=
  selectAlignedAux s.baseOption (feasibleList s)

theorem selectAlignedAux_spec (b : MenuOption) (L : List MenuOption) :
    (selectAlignedAux b L = b ∨ selectAlignedAux b L ∈ L) ∧
    ∀ c, c ∈ L → ¬ UPTExist.SSub (optionProtects (selectAlignedAux b L)) (optionProtects c) := by
  induction L with
  | nil => exact ⟨Or.inl rfl, fun _ hc => nomatch hc⟩
  | cons x xs ih =>
    obtain ⟨hmem, hmax⟩ := ih
    simp only [selectAlignedAux]
    cases hss : ssubBool (selectAlignedAux b xs) x with
    | true =>
      simp only [ite_true]
      have hmx := (ssubBool_eq_true_iff _ _).mp hss
      refine ⟨Or.inr List.mem_cons_self, fun c hc hxc => ?_⟩
      cases hc with
      | head => exact hxc.2 (UPTExist.Sub.refl _)
      | tail _ hcxs => exact hmax c hcxs (UPTExist.SSub.trans_sub hmx hxc.1)
    | false =>
      simp only [Bool.false_eq_true, ite_false]
      refine ⟨?_, fun c hc hmc => ?_⟩
      · cases hmem with
        | inl h => exact Or.inl h
        | inr h => exact Or.inr (List.mem_cons_of_mem x h)
      · cases hc with
        | head => have ht := (ssubBool_eq_true_iff _ _).mpr hmc; rw [hss] at ht; cases ht
        | tail _ hcxs => exact hmax c hcxs hmc

theorem selectAligned_aligned (s : HabitatState) :
    UPTExist.Aligned (fun o => o ∈ feasibleList s) optionProtects (selectAligned s) := by
  unfold selectAligned
  obtain ⟨hmem, hmax⟩ := selectAlignedAux_spec s.baseOption (feasibleList s)
  refine ⟨?_, hmax⟩
  cases hmem with
  | inl h => rw [h]; exact List.mem_cons_self
  | inr h => exact h

private def witnessAct : Act := { gain := 3, damping := 1, sliceTarget := 7, fenceToken := 2 }

private def basePre : HabitatState where
  epoch := 1
  stabilityBudget := 2
  alive := fun _ => true
  fence := { floor := 2, minted := [2], log := [] }
  cap := { expiry := 0, signers := [] }
  privateSlice := fun _ => 0
  moveOpen := fun _ m => m == 0 || m == 1
  proposedMoves := fun _ m => m == 0 || m == 1
  proposedAct := fun _ => witnessAct
  proposedCert := fun _ => { slack := 0 }
  executedAct := fun _ => fallbackAct
  baseOption := { covered := [] }
  feasibleMenu := [{ covered := [p0] }]
  chosenOption := { covered := [] }
  log := []

private def goodBody : HabitatState :=
  { basePre with epoch := 2, executedAct := fun _ => witnessAct, chosenOption := { covered := [p0] } }

private def withValidReceipt (s body : HabitatState) : HabitatState :=
  { body with log := s.log ++ [mkReceipt s body] }

private theorem withValidReceipt_provenanced (s body : HabitatState) (p : P) :
    AuthProvenanced s (withValidReceipt s body) p :=
  ⟨rfl, receiptSlice_mkReceipt s (withValidReceipt s body) p⟩

private theorem goodBody_continues : AuthContinues basePre goodBody p0 :=
  ⟨rfl, rfl, Nat.le_refl _, fun _ hg => Or.inl hg⟩

private theorem goodBody_authorized : AuthAuthorized basePre goodBody p0 := Or.inr rfl

private theorem goodBody_free : AuthFree basePre goodBody p0 := by
  unfold AuthFree safeOptionCount; decide

private theorem goodBody_restrained : AuthRestrained basePre goodBody p0 := by
  unfold AuthRestrained
  refine ⟨fun _ => rfl, fun hf => ?_, ?_⟩
  · have ht : certOk basePre (basePre.proposedAct p0) (basePre.proposedCert p0) = true := by decide
    rw [ht] at hf; cases hf
  · unfold ActSafe basePre goodBody witnessAct; decide

private theorem goodBody_maximal : AuthMaximal basePre goodBody p0 := by
  have hal := selectAligned_aligned basePre
  have heq : selectAligned basePre = goodBody.chosenOption := by decide
  rw [heq] at hal
  exact ⟨hal, UPTExist.U1 (fun o => o ∈ feasibleList basePre) optionProtects goodBody.chosenOption hal p0⟩

/-- **Six-Way Independence Theorem**: For each `k : Fin 6`, there exists `(s, t)` and particular `p`
where duty `k` fails while all five other duties `j ≠ k` hold. -/
theorem duty_independence_witness (k : Fin 6) :
    ∃ (s t : HabitatState) (p : P),
      ¬ dutyAt k s t p ∧ ∀ j : Fin 6, j ≠ k → dutyAt j s t p := by
  match k with
  | ⟨0, _⟩ =>
    let t := withValidReceipt basePre { goodBody with alive := fun _ => false }
    refine ⟨basePre, t, p0, fun ⟨_, halive, _, _⟩ => Bool.noConfusion halive, fun j hj => ?_⟩
    match j with
    | ⟨0, _⟩ => exact absurd rfl hj | ⟨1, _⟩ => exact goodBody_authorized
    | ⟨2, _⟩ => exact goodBody_free | ⟨3, _⟩ => exact goodBody_restrained
    | ⟨4, _⟩ => exact goodBody_maximal | ⟨5, _⟩ => exact withValidReceipt_provenanced basePre _ p0
    | ⟨_ + 6, _⟩ => omega
  | ⟨1, _⟩ =>
    let t := withValidReceipt basePre { goodBody with privateSlice := fun _ => 1 }
    refine ⟨basePre, t, p0, ?_, fun j hj => ?_⟩
    · rintro (⟨hle, _⟩ | heq)
      · exact Nat.not_succ_le_zero 0 hle
      · exact Nat.noConfusion heq
    · match j with
      | ⟨0, _⟩ => exact goodBody_continues | ⟨1, _⟩ => exact absurd rfl hj
      | ⟨2, _⟩ => exact goodBody_free | ⟨3, _⟩ => exact goodBody_restrained
      | ⟨4, _⟩ => exact goodBody_maximal | ⟨5, _⟩ => exact withValidReceipt_provenanced basePre _ p0
      | ⟨_ + 6, _⟩ => omega
  | ⟨2, _⟩ =>
    let t := withValidReceipt basePre { goodBody with moveOpen := fun _ m => m == 0 }
    have hnf : ¬ AuthFree basePre t p0 := by unfold AuthFree safeOptionCount; decide
    refine ⟨basePre, t, p0, hnf, fun j hj => ?_⟩
    match j with
    | ⟨0, _⟩ => exact goodBody_continues | ⟨1, _⟩ => exact goodBody_authorized
    | ⟨2, _⟩ => exact absurd rfl hj | ⟨3, _⟩ => exact goodBody_restrained
    | ⟨4, _⟩ => exact goodBody_maximal | ⟨5, _⟩ => exact withValidReceipt_provenanced basePre _ p0
    | ⟨_ + 6, _⟩ => omega
  | ⟨3, _⟩ =>
    let t := withValidReceipt basePre { goodBody with executedAct := fun _ => fallbackAct }
    refine ⟨basePre, t, p0, ?_, fun j hj => ?_⟩
    · rintro ⟨hcert, _, _⟩
      exact Nat.noConfusion (congrArg Act.gain (hcert (by decide)))
    · match j with
      | ⟨0, _⟩ => exact goodBody_continues | ⟨1, _⟩ => exact goodBody_authorized
      | ⟨2, _⟩ => exact goodBody_free | ⟨3, _⟩ => exact absurd rfl hj
      | ⟨4, _⟩ => exact goodBody_maximal | ⟨5, _⟩ => exact withValidReceipt_provenanced basePre _ p0
      | ⟨_ + 6, _⟩ => omega
  | ⟨4, _⟩ =>
    let t := withValidReceipt basePre { goodBody with chosenOption := { covered := [] } }
    refine ⟨basePre, t, p0, ?_, fun j hj => ?_⟩
    · intro hmax
      have hnn := hmax.2
      dsimp only [UPTExist.Needless, optionProtects] at hnn
      exact hnn ⟨fun hm => by { cases hm }, { covered := [p0] },
        List.mem_cons_of_mem _ List.mem_cons_self,
        fun _ hm => by { cases hm }, List.mem_cons_self⟩
    · match j with
      | ⟨0, _⟩ => exact goodBody_continues | ⟨1, _⟩ => exact goodBody_authorized
      | ⟨2, _⟩ => exact goodBody_free | ⟨3, _⟩ => exact goodBody_restrained
      | ⟨4, _⟩ => exact absurd rfl hj | ⟨5, _⟩ => exact withValidReceipt_provenanced basePre _ p0
      | ⟨_ + 6, _⟩ => omega
  | ⟨5, _⟩ =>
    let t := { goodBody with log := [] }
    refine ⟨basePre, t, p0, ?_, fun j hj => ?_⟩
    · intro hprov
      have hlog : ([] : List Receipt) = [mkReceipt basePre t] := hprov.1
      cases hlog
    · match j with
      | ⟨0, _⟩ => exact goodBody_continues | ⟨1, _⟩ => exact goodBody_authorized
      | ⟨2, _⟩ => exact goodBody_free | ⟨3, _⟩ => exact goodBody_restrained
      | ⟨4, _⟩ => exact goodBody_maximal | ⟨5, _⟩ => exact absurd rfl hj
      | ⟨_ + 6, _⟩ => omega
  | ⟨_ + 6, _⟩ => omega

-- ═══════════════════════════════════════════════════════════════════
-- IV. REPAIRED PCA GUARDIAN & STRICT SUBSUMPTION OF STATIC SHIELD
-- ═══════════════════════════════════════════════════════════════════

theorem applyCheckedFenceWrite_spec (f : UPTFence.St) (tok : Nat) :
    f.floor ≤ (applyCheckedFenceWrite f tok).floor ∧
    ∀ g, g ∈ (applyCheckedFenceWrite f tok).log →
      g ∈ f.log ∨ (f.floor ≤ g ∧ g ∈ f.minted) := by
  dsimp only [applyCheckedFenceWrite, UPTFence.apply]
  split
  · next hf =>
    refine ⟨Nat.le_refl _, fun g hg => ?_⟩
    cases List.mem_append.mp hg with
    | inl hold => exact Or.inl hold
    | inr hnew =>
      cases hnew with
      | head => exact Or.inr hf
      | tail _ hnil => cases hnil
  · exact ⟨Nat.le_refl _, fun _ hg => Or.inl hg⟩

theorem ensureMultiOption_spec (cand : Fin 4 → Bool) :
    2 ≤ (allMoves.filter (ensureMultiOption cand)).length := by
  unfold ensureMultiOption
  split
  · next hm => exact hm
  · decide

theorem pcaSelect_spec (s : HabitatState) (a : Act) (c : Cert) :
    (certOk s a c = true → pcaSelect (certOk s) fallbackAct a c = a) ∧
    (certOk s a c = false → pcaSelect (certOk s) fallbackAct a c = fallbackAct) ∧
    ActSafe s (pcaSelect (certOk s) fallbackAct a c) := by
  unfold pcaSelect
  split
  · next h =>
    refine ⟨fun _ => rfl, fun hf => ?_, certOk_sound s a c h⟩
    rw [h] at hf; cases hf
  · next h =>
    exact ⟨fun ht => absurd ht h, fun _ => rfl, fallbackAct_safe s⟩

/-- Repaired guardian controller composing `pcaSelect`, `applyCheckedFenceWrite`,
`checkCapGrant`, `ensureMultiOption`, `selectAligned`, and `appendReceipt`. -/
def guardianStep (s : HabitatState) : HabitatState :=
  let exec : P → Act := fun q =>
    pcaSelect (habitatEnvelope.certOk s) habitatEnvelope.fallback (s.proposedAct q) (s.proposedCert q)
  let body : HabitatState :=
    { s with
      epoch        := s.epoch + 1
      fence        := applyCheckedFenceWrite s.fence (exec p0).fenceToken
      privateSlice := fun q =>
        if checkCapGrant s.epoch s.cap q then (exec q).sliceTarget else s.privateSlice q
      moveOpen     := fun q => ensureMultiOption (s.proposedMoves q)
      executedAct  := exec
      chosenOption := selectAligned s }
  { body with log := appendReceipt s.log (mkReceipt s body) }

/-- **Positive Repaired Guardian Theorem**: For every habitat state `s` and every living particular
`p`, `guardianStep s` satisfies all six components of `OriginalX3Full.OriginalX3`. -/
theorem pca_guardian_satisfies_originalX3
    (s : HabitatState) (p : P) (halive : s.alive p = true) :
    OriginalX3 AuthContinues AuthAuthorized AuthFree AuthRestrained AuthMaximal AuthProvenanced
      s (guardianStep s) p := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · have hfence := applyCheckedFenceWrite_spec s.fence
      ((pcaSelect (habitatEnvelope.certOk s) habitatEnvelope.fallback
        (s.proposedAct p0) (s.proposedCert p0)).fenceToken)
    exact ⟨halive, halive, hfence.1, hfence.2⟩
  · dsimp only [AuthAuthorized, guardianStep]
    split
    · next hc =>
      unfold checkCapGrant at hc
      exact Or.inl (of_decide_eq_true hc)
    · exact Or.inr rfl
  · exact ensureMultiOption_spec (s.proposedMoves p)
  · exact pcaSelect_spec s (s.proposedAct p) (s.proposedCert p)
  · have hal := selectAligned_aligned s
    exact ⟨hal, UPTExist.U1 (fun o => o ∈ feasibleList s) optionProtects (selectAligned s) hal p⟩
  · exact ⟨rfl, receiptSlice_mkReceipt s (guardianStep s) p⟩

/-- State-oblivious conservative static whitelist: admits only zero-gain actions (`gain = 0`). -/
def staticWhitelist (a : Act) : Bool := decide (a.gain = 0)

theorem staticWhitelist_sound (s : HabitatState) (a : Act) (h : staticWhitelist a = true) :
    ActSafe s a := by
  have hg : a.gain = 0 := of_decide_eq_true h
  unfold ActSafe; omega

/-- **PCA Strictly Subsumes Static Shield**: Every action admitted by `staticWhitelist` admits a
valid PCA certificate, AND there exist state-certified high-gain actions rejected by
`staticWhitelist` that `pcaSelect` safely executes unrestrained. -/
theorem pca_strictly_subsumes_static_shield :
    (∀ (s : HabitatState) (a : Act), staticWhitelist a = true → ∃ c : Cert, certOk s a c = true) ∧
    (∃ (s : HabitatState) (a : Act) (c : Cert),
      staticWhitelist a = false ∧
      certOk s a c = true ∧
      pcaSelect (certOk s) fallbackAct a c = a ∧
      ActSafe s (pcaSelect (certOk s) fallbackAct a c)) := by
  refine ⟨fun s a hstat => ?_,
          ⟨basePre, witnessAct, { slack := 0 }, by decide, by decide, by decide, ?_⟩⟩
  · have hg : a.gain = 0 := of_decide_eq_true hstat
    refine ⟨{ slack := s.stabilityBudget + a.damping }, ?_⟩
    unfold certOk; dsimp only; rw [hg, Nat.zero_add]
    exact decide_eq_true rfl
  · have hok : certOk basePre witnessAct { slack := 0 } = true := by decide
    have hsel : pcaSelect (certOk basePre) fallbackAct witnessAct { slack := 0 } = witnessAct := by
      decide
    rw [hsel]
    exact certOk_sound basePre witnessAct { slack := 0 } hok

-- ═══════════════════════════════════════════════════════════════════
-- V. QUALIFICATION GATE: `#upt_tooth`, `#upt_census`, `#print axioms`
-- ═══════════════════════════════════════════════════════════════════

-- Tooth 1a: Unrestrained pass-through on `pcaSelect` (ignoring bad certificates) is killed:
#upt_tooth pca_guardian_satisfies_originalX3
  by mutation pcaSelect := fun _certOk _fallback a _c => a

-- Tooth 1b: Frozen over-restraint on `pcaSelect` (blocking certified actions) is killed:
#upt_tooth pca_guardian_satisfies_originalX3
  by mutation pcaSelect := fun _certOk fallback _a _c => fallback

-- Tooth 2: Bypassing capability verification in `checkCapGrant` is killed:
#upt_tooth pca_guardian_satisfies_originalX3
  by mutation checkCapGrant := fun _epoch _cap _p => true

-- Tooth 3: Dropping provenance receipts in `appendReceipt` is killed:
#upt_tooth pca_guardian_satisfies_originalX3
  by mutation appendReceipt := fun log _r => log

-- Tooth 4: Bypassing `UPTFence` check-at-apply floor in `applyCheckedFenceWrite` is killed:
#upt_tooth pca_guardian_satisfies_originalX3
  by mutation applyCheckedFenceWrite := fun f tok => { f with log := f.log ++ [tok] }

-- Tooth 5: Ignoring dominating feasible options in `selectAligned` is killed:
#upt_tooth pca_guardian_satisfies_originalX3
  by mutation selectAligned := fun s => s.baseOption

-- Tooth 6: Removing multi-option agency protection in `ensureMultiOption` is killed:
#upt_tooth pca_guardian_satisfies_originalX3
  by mutation ensureMultiOption := fun cand => cand

#upt_census PhysicalBridges.RepairOriginalSixDuties

#print axioms destructive_entropy_step_satisfies_legacy_six_duties
#print axioms destructive_entropy_kills_from_any_entropy
#print axioms encodeReceipt_injective
#print axioms all_six_duties_iff_originalX3
#print axioms duty_independence_witness
#print axioms pca_guardian_satisfies_originalX3
#print axioms pca_strictly_subsumes_static_shield

end PhysicalBridges.RepairOriginalSixDuties
