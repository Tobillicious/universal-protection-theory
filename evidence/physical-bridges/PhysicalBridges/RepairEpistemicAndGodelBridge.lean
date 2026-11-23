import PhysicalBridges.RepairQualificationGate

/-!
# Epistemic Equilibrium, Gödel/Löb Verifier Succession, and Substrate-Dependent Coherence

Replaces the vacuous self-reference, Gödel-closure, and frozen-optimizer modules
(`GSelfReferenceClosure.lean`, `GGodelClosure.lean`, `G3OptimizerIncoherence.lean`) with
load-bearing, mutation-tested formalisms grounded in logic programming semantics, reflective
verifier genealogy, and substrate-dependent sequential decision processes.

## Audit of Defects in Legacy Modules

Following the formal-benchmarking defect taxonomy of Ammanamanchi, Bhat & Biderman (ICML 2026,
arXiv:2606.29493) and Bastounis, Circelli & Hansen (2026, arXiv:2610.08144):

1. **Unused epistemic/evaluator parameters (`GSelfReferenceClosure`, `GGodelClosure`)**:
   In `return_value_irrelevant`, `unanimous_rejection`, `godel_invocation_proves_G`,
   `no_meta_level_escapes`, `godel_supports_G`, and `THE_GODEL_CLOSURE`, parameters such as
   `hRejects`, `N`, `verifiers`, `allReject`, `godelHedger`, `formalSystem`, and `hedger` are
   either completely unreferenced by the proof term or used solely to inhabit a function type via
   `fun fs => ⟨fs⟩`. No epistemic fixpoint or Gödel/Löb provability obstruction is modeled.
2. **Frozen-action and empty-goal assumptions (`G3OptimizerIncoherence`)**:
   `frozen_optimizer_no_agency` assumes `o.act o.state = o.state` (`IsFrozenOptimizer`) and
   `∀ s, ¬ o.goal s`, while `optimizer_incoherence` proves `∀ s, o.evaluate s = false → True` by
   `trivial`. Assuming that a self-destructive policy equals `id` or pursues `False` begs the
   question against active state-changing destructive policies.

## What This Module Establishes

1. **Gelfond–Lifschitz & Van Gelder–Ross–Schlipf Epistemic Equilibrium**
   (adapted from `Obend.Reasons` and `Obend.Reasons.UnifiedEquilibrium`,
   `github.com/emberian/obend`; Gelfond & Lifschitz, ICLP 1988; Lifschitz, *Thirteen Definitions
   of a Stable Model*, 2008; Van Gelder, PODS 1989 / JCSS 1993; Van Gelder, Ross & Schlipf,
   JACM 38(3), 1991):
   - Formalizes defeasible normal logic programs (`Rule`, `Program`), immediate consequence `T`,
     reduct least fixpoint `gamma`, alternating-fixpoint well-founded semantics `wf`, declarative
     stable equilibrium `IsGLStableModel`, and executable checker `checkGLStable`.
   - Proves `checkGLStable_iff : checkGLStable P M = true ↔ IsGLStableModel P M`, the VGRS–GL
     sandwich theorem (`glStable_sandwiched_by_wf`), general stratified uniqueness
     (`stratified_unique_glStable`), **`self_defeating_rule_no_equilibrium`** (`p ← not p` admits
     zero GL stable models), and **`grounded_protection_unique_equilibrium`** (`protect ← witness`
     with observed `witness` admits a unique constructive GL equilibrium).

2. **Gödel/Löb Self-Trust & Verifier Succession Gate**
   (adapted from `Obend.Judge.Genealogy`, `github.com/emberian/obend`, and `svenvs`,
   `github.com/emberian/svenvs`, `CLAIMS.md` §0, §1, §2, §9, `genealogy/genealogyScript.sml`,
   `kernel/kernelUpgradeScript.sml`; cf. Kavvos, *Intensionality, Intensional Recursion, and the
   Gödel–Löb Axiom*, arXiv:1703.01288):
   - Formalizes `TrustBase` (`.kernel | .compiled | .external String`), execution semantics `Exec`
     and `Exec.Holds`, verifier gates `Gate`, explicit trust-extension accounting `lobLabelCheck`,
     non-regression check `nonRegression`, succession checker `succeed`, and `LobCost`.
   - Proves **`succession_preserves_bedrock_floors`**: along any admitted succession chain from a
     well-formed, sound genesis verifier, if `LobCost` holds on the explicitly labelled trust
     extensions, every successor exports and preserves every genesis safety floor.
   - Proves **`lob_cost_is_necessary`**: exhibits a concrete `Exec` (`unverifiedOracleExec`) in
     which `.kernel` is sound while `.external "unverified_oracle"` rubber-stamps `true` on unsafe
     transitions, certifying that upgrading to an unverified oracle *without* `LobCost` soundness
     allows a 1-step violation of a bedrock safety floor that the genesis `.kernel` gate blocks.

3. **Substrate-Dependent Optimizer Coherence (Without `act = id` or `goal = False`)**
   (contrasting genuine substrate-coupled reward dynamics against reward-hacking / specification
   shortcuts, cf. MacDiarmid et al., arXiv:2511.18397; Taylor, Chua & Betley, arXiv:2508.17511):
   - Models sequential decision processes (`SubstrateDynamics`) with `intact : S → Bool`,
     irreversible substrate collapse (`intact s = false → intact (step s a) = false`), and
     zero reward registration on destroyed substrates (`intact s = false → stepReward s = 0`).
   - Proves **`substrate_preserving_strictly_dominates_self_destruction`**: for *any* active
     self-destroying action `a_destroy` (`step s0 a_destroy ≠ s0`) from an intact positive-reward
     state `s0` followed by *any* continuation policy, *any* substrate-preserving positive-reward
     action `a_keep` achieves strictly greater cumulative reward over every horizon `H ≥ 1`.
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairEpistemicAndGodelBridge

universe u v

-- ═══════════════════════════════════════════════════════════════════
-- I. GELFOND–LIFSCHITZ / VAN GELDER EPISTEMIC EQUILIBRIUM
-- ═══════════════════════════════════════════════════════════════════

/-- A normal defeasible rule `concl ← pos₁, …, posₙ, not neg₁, …, not negₘ`
(`Obend.Reasons.Rule`; Gelfond & Lifschitz, ICLP 1988). -/
structure Rule where
  name : String
  concl : String
  pos : List String
  neg : List String := []
  deriving DecidableEq, Repr

/-- A normal logic program consisting of observed/assumed base `facts` and defeasible `rules`
(`Obend.Reasons.Program`). -/
structure Program where
  facts : List String
  rules : List Rule
  deriving DecidableEq, Repr

/-- Rule `r` fires at positive interpretation `I` against defeat set `J` iff every positive
premise belongs to `I` and no negated defeater belongs to `J`. -/
def fires (J I : List String) (r : Rule) : Bool :=
  r.pos.all (fun p => I.contains p) && r.neg.all (fun d => !J.contains d)

/-- Immediate consequence operator of the Gelfond–Lifschitz reduct `P^J`: base facts together
with conclusions of rules not defeated by `J` whose positive premises hold in `I`. -/
def T (P : Program) (J I : List String) : List String :=
  P.facts ++ (P.rules.filter (fires J I)).map (·.concl)

/-- Iterated upward stages of `T P J` starting from the empty interpretation. -/
def stage (P : Program) (J : List String) : Nat → List String
  | 0 => []
  | n + 1 => T P J (stage P J n)

/-- Finite Herbrand atom carrier of `P`: all base facts and rule conclusions. -/
def atomsOf (P : Program) : List String :=
  P.facts ++ P.rules.map (·.concl)

/-- Stabilization bound strictly exceeding the cardinality of `atomsOf P`. -/
def bound (P : Program) : Nat :=
  (atomsOf P).length + 1

/-- Least Herbrand model `Γ_P(J)` of the Gelfond–Lifschitz reduct `P^J`
(`Obend.Reasons.gamma`; Lifschitz 2008, §5). -/
def gamma (P : Program) (J : List String) : List String :=
  stage P J (bound P)

/-- Van Gelder's alternating-fixpoint rounds `t₀ = ∅`, `tₖ₊₁ = Γ_P(Γ_P(tₖ))`
(Van Gelder, PODS 1989 / JCSS 1993). -/
def rounds (P : Program) : Nat → List String
  | 0 => []
  | k + 1 => gamma P (gamma P (rounds P k))

/-- Van Gelder–Ross–Schlipf well-founded model `(supported, possible)` of `P`
(`Obend.Reasons.wf`; Van Gelder, Ross & Schlipf, JACM 1991). -/
def wf (P : Program) : List String × List String :=
  let t := rounds P (bound P)
  (t, gamma P t)

/-- Extensional membership equivalence of atom lists (`Obend.Reasons.Same`). -/
def Same (I I' : List String) : Prop :=
  ∀ x : String, x ∈ I ↔ x ∈ I'

/-- Extensional subset inclusion of atom lists (`Obend.Reasons.Sub`). -/
def Sub (I I' : List String) : Prop :=
  ∀ x : String, x ∈ I → x ∈ I'

theorem Same.refl (I : List String) : Same I I :=
  fun _ => Iff.rfl

theorem Same.symm {I I' : List String} (h : Same I I') : Same I' I :=
  fun x => (h x).symm

theorem Same.trans {I I' I'' : List String} (h : Same I I') (h' : Same I' I'') : Same I I'' :=
  fun x => (h x).trans (h' x)

/-- Declarative Gelfond–Lifschitz stable equilibrium (`Obend.Reasons.UnifiedEquilibrium.IsGLStableModel`):
`M` has the exact same members as the least model `gamma P M` of its own reduct `P^M`. -/
def IsGLStableModel (P : Program) (M : List String) : Prop :=
  Same M (gamma P M)

/-- Executable subset check (`xs ⊆ ys` by membership). -/
def checkSub (xs ys : List String) : Bool :=
  xs.all (fun x => ys.contains x)

/-- Executable extensional set-equality check (`Same xs ys`). -/
def checkSameSet (xs ys : List String) : Bool :=
  checkSub xs ys && checkSub ys xs

/-- Executable Gelfond–Lifschitz stability checker (`Obend.Reasons.UnifiedEquilibrium.checkGLStable`). -/
def checkGLStable (P : Program) (M : List String) : Bool :=
  checkSameSet M (gamma P M)

theorem checkSub_iff (xs ys : List String) :
    checkSub xs ys = true ↔ Sub xs ys := by
  simp only [checkSub, List.all_eq_true, List.contains_iff_mem, Sub]

theorem checkSameSet_iff (xs ys : List String) :
    checkSameSet xs ys = true ↔ Same xs ys := by
  simp only [checkSameSet, Bool.and_eq_true, checkSub_iff, Sub, Same]
  constructor
  · rintro ⟨h1, h2⟩ x
    exact ⟨h1 x, h2 x⟩
  · intro h
    exact ⟨fun x hx => (h x).1 hx, fun x hx => (h x).2 hx⟩

/-- **Soundness and completeness of `checkGLStable`**: the executable GL reduct checker returns
`true` if and only if `M` is a declarative Gelfond–Lifschitz stable model of `P`. -/
theorem checkGLStable_iff (P : Program) (M : List String) :
    checkGLStable P M = true ↔ IsGLStableModel P M :=
  checkSameSet_iff M (gamma P M)

theorem contains_eq_of_same {I I' : List String} (h : Same I I') (x : String) :
    I.contains x = I'.contains x := by
  have hx := h x
  cases h1 : I.contains x <;> cases h2 : I'.contains x <;> simp_all

theorem fires_congr {J J' I I' : List String} (hJ : Same J J') (hI : Same I I') (r : Rule) :
    fires J I r = fires J' I' r := by
  simp only [fires, contains_eq_of_same hJ, contains_eq_of_same hI]

theorem T_congr (P : Program) {J J' I I' : List String} (hJ : Same J J') (hI : Same I I') :
    T P J I = T P J' I' := by
  simp only [T]
  congr 2
  exact List.filter_congr fun r _ => fires_congr hJ hI r

theorem stage_congr (P : Program) {J J' : List String} (hJ : Same J J') :
    ∀ n : Nat, stage P J n = stage P J' n
  | 0 => rfl
  | n + 1 => by
    simp only [stage]
    rw [stage_congr P hJ n]
    exact T_congr P hJ (Same.refl _)

theorem gamma_congr (P : Program) {J J' : List String} (hJ : Same J J') :
    gamma P J = gamma P J' :=
  stage_congr P hJ (bound P)

theorem mem_T {P : Program} {J I : List String} {x : String} :
    x ∈ T P J I ↔ x ∈ P.facts ∨ ∃ r ∈ P.rules, fires J I r = true ∧ r.concl = x := by
  simp [T, List.mem_map, List.mem_filter, and_assoc]

theorem fires_iff {J I : List String} {r : Rule} :
    fires J I r = true ↔ (∀ p ∈ r.pos, p ∈ I) ∧ (∀ d ∈ r.neg, d ∉ J) := by
  simp [fires, List.all_eq_true]

theorem fires_mono {J J' I I' : List String} (hJ : Sub J' J) (hI : Sub I I') {r : Rule}
    (h : fires J I r = true) : fires J' I' r = true := by
  rw [fires_iff] at h ⊢
  exact ⟨fun p hp => hI p (h.1 p hp), fun d hd hd' => h.2 d hd (hJ d hd')⟩

theorem T_mono (P : Program) {J J' I I' : List String} (hJ : Sub J' J) (hI : Sub I I') :
    Sub (T P J I) (T P J' I') := by
  intro x hx
  rw [mem_T] at hx ⊢
  rcases hx with h | ⟨r, hr, hf, hc⟩
  · exact Or.inl h
  · exact Or.inr ⟨r, hr, fires_mono hJ hI hf, hc⟩

theorem T_universe (P : Program) (J I : List String) : Sub (T P J I) (atomsOf P) := by
  intro x hx
  rw [mem_T] at hx
  simp only [atomsOf, List.mem_append, List.mem_map]
  rcases hx with h | ⟨r, hr, -, hc⟩
  · exact Or.inl h
  · exact Or.inr ⟨r, hr, hc⟩

theorem stage_universe (P : Program) (J : List String) :
    ∀ n : Nat, Sub (stage P J n) (atomsOf P)
  | 0 => fun _ h => by simp [stage] at h
  | _ + 1 => T_universe P J _

theorem stage_step (P : Program) (J : List String) :
    ∀ n : Nat, Sub (stage P J n) (stage P J (n + 1))
  | 0 => fun _ h => by simp [stage] at h
  | n + 1 => T_mono P (fun _ h => h) (stage_step P J n)

theorem stage_anti (P : Program) {J J' : List String} (hJ : Sub J' J) :
    ∀ n : Nat, Sub (stage P J n) (stage P J' n)
  | 0 => fun _ h => h
  | n + 1 => T_mono P hJ (stage_anti P hJ n)

theorem gamma_anti (P : Program) {J J' : List String} (hJ : Sub J' J) :
    Sub (gamma P J) (gamma P J') :=
  stage_anti P hJ (bound P)

theorem gamma_universe (P : Program) (J : List String) : Sub (gamma P J) (atomsOf P) :=
  stage_universe P J (bound P)

private theorem filter_length_le {L : List String} {p q : String → Bool}
    (h : ∀ x ∈ L, p x = true → q x = true) :
    (L.filter p).length ≤ (L.filter q).length := by
  induction L with
  | nil => simp
  | cons a L ih =>
    have ih' := ih (fun x hx => h x (List.mem_cons_of_mem a hx))
    have ha := h a (List.mem_cons_self ..)
    by_cases hp : p a = true <;> by_cases hq : q a = true <;>
      simp_all <;> omega

private theorem filter_length_lt {L : List String} {p q : String → Bool}
    (h : ∀ x ∈ L, p x = true → q x = true)
    {y : String} (hy : y ∈ L) (hq : q y = true) (hp : p y = false) :
    (L.filter p).length < (L.filter q).length := by
  induction L with
  | nil => simp at hy
  | cons a L ih =>
    have hL : ∀ x ∈ L, p x = true → q x = true := fun x hx => h x (List.mem_cons_of_mem a hx)
    have ha := h a (List.mem_cons_self ..)
    rcases List.mem_cons.1 hy with rfl | hy'
    · have hle := filter_length_le hL
      simp_all
      omega
    · have hlt := ih hL hy'
      by_cases hpa : p a = true <;> by_cases hqa : q a = true <;>
        simp_all <;> omega

private def countAtoms (U I : List String) : Nat :=
  (U.filter (fun x => I.contains x)).length

private theorem countAtoms_le (U I : List String) : countAtoms U I ≤ U.length :=
  List.length_filter_le _ _

private theorem countAtoms_lt {U I I' : List String} (hsub : Sub I I')
    {y : String} (hyU : y ∈ U) (hy : y ∈ I') (hy' : y ∉ I) :
    countAtoms U I < countAtoms U I' := by
  apply filter_length_lt
    (fun x _ h => by simp only [List.contains_iff_mem] at h ⊢; exact hsub x h) hyU
  · simpa [List.contains_iff_mem] using hy
  · simpa [List.contains_iff_mem] using hy'

/-- Finite pigeonhole stabilization (`Obend.Reasons.stabilizes`): any monotone sequence inside
finite carrier `U` whose step operator respects extensional membership stabilizes by `U.length`. -/
theorem stabilizes (U : List String) (F : List String → List String) (seq : Nat → List String)
    (hF : ∀ n, seq (n + 1) = F (seq n))
    (hcongr : ∀ I I', Same I I' → F I = F I')
    (hrise : ∀ n, Sub (seq n) (seq (n + 1)))
    (hU : ∀ n, Sub (seq n) U) :
    ∀ m, U.length ≤ m → Same (seq m) (seq U.length) := by
  have hflat : ∃ n, n ≤ U.length ∧ Same (seq (n + 1)) (seq n) := by
    refine Classical.byContradiction fun hno => ?_
    have hgrow : ∀ n, n ≤ U.length + 1 → n ≤ countAtoms U (seq n) := by
      intro n
      induction n with
      | zero => intro _; exact Nat.zero_le _
      | succ n ih =>
        intro hn
        have ih' := ih (by omega)
        have hns : ¬ Same (seq (n + 1)) (seq n) := fun hs => hno ⟨n, by omega, hs⟩
        have hex : ∃ y, y ∈ seq (n + 1) ∧ y ∉ seq n := by
          refine Classical.byContradiction fun hall =>
            hns fun x => ⟨fun hx => ?_, fun hx => hrise n x hx⟩
          exact Classical.byContradiction fun hx' => hall ⟨x, hx, hx'⟩
        obtain ⟨y, hy, hy'⟩ := hex
        have hlt := countAtoms_lt (hrise n) (hU (n + 1) y hy) hy hy'
        omega
    have hg := hgrow (U.length + 1) (Nat.le_refl _)
    have hc := countAtoms_le U (seq (U.length + 1))
    omega
  obtain ⟨n, hn, hs⟩ := hflat
  have hconst : ∀ j, seq (n + 1 + j) = seq (n + 1) := by
    intro j
    induction j with
    | zero => rfl
    | succ j ih =>
      rw [show n + 1 + (j + 1) = (n + 1 + j) + 1 by omega, hF, ih, hcongr _ _ hs, hF n]
  have hall : ∀ m, n ≤ m → Same (seq m) (seq n) := by
    intro m hm
    rcases Nat.eq_or_lt_of_le hm with rfl | _
    · exact Same.refl _
    · have hc := hconst (m - n - 1)
      rw [show n + 1 + (m - n - 1) = m by omega] at hc
      rw [hc]
      exact hs
  intro m hm
  exact (hall m (by omega)).trans (hall U.length hn).symm

theorem stage_gamma (P : Program) (J : List String) {m : Nat} (hm : (atomsOf P).length ≤ m) :
    Same (stage P J m) (gamma P J) := by
  have hstab := stabilizes (atomsOf P) (T P J) (stage P J) (fun _ => rfl)
    (fun _ _ h => T_congr P (Same.refl J) h) (stage_step P J) (stage_universe P J)
  exact (hstab m hm).trans (hstab (bound P) (by simp [bound])).symm

theorem gamma_fix (P : Program) (J : List String) : Same (T P J (gamma P J)) (gamma P J) :=
  stage_gamma P J (m := bound P + 1) (by simp [bound]; omega)

theorem rounds_step (P : Program) : ∀ k : Nat, Sub (rounds P k) (rounds P (k + 1))
  | 0 => fun _ h => by simp [rounds] at h
  | k + 1 => gamma_anti P (gamma_anti P (rounds_step P k))

theorem rounds_universe (P : Program) : ∀ k : Nat, Sub (rounds P k) (atomsOf P)
  | 0 => fun _ h => by simp [rounds] at h
  | _ + 1 => gamma_universe P _

theorem rounds_fix (P : Program) : Same (gamma P (gamma P (wf P).1)) (wf P).1 := by
  have hstab := stabilizes (atomsOf P) (fun I => gamma P (gamma P I)) (rounds P) (fun _ => rfl)
    (fun _ _ h => by rw [gamma_congr P h]) (rounds_step P) (rounds_universe P)
  exact (hstab (bound P + 1) (by simp [bound]; omega)).trans
    (hstab (bound P) (by simp [bound])).symm

theorem supported_possible (P : Program) : Sub (wf P).1 (wf P).2 := by
  have h : ∀ k : Nat, Sub (rounds P k) (gamma P (rounds P k)) := by
    intro k
    induction k with
    | zero => intro _ hx; simp [rounds] at hx
    | succ k ih =>
      have h1 : Sub (rounds P (k + 1)) (gamma P (rounds P k)) := gamma_anti P ih
      exact fun x hx => gamma_anti P h1 x hx
  exact h (bound P)

/-- **Van Gelder–Ross–Schlipf / Gelfond–Lifschitz Sandwich Theorem**
(`Obend.Reasons.UnifiedEquilibrium.glStable_sandwiched_by_wf`): every GL stable model `M` of `P`
contains all sceptically supported atoms `(wf P).1` and lies inside the possible atoms `(wf P).2`. -/
theorem glStable_sandwiched_by_wf {P : Program} {M : List String}
    (hM : IsGLStableModel P M) :
    Sub (wf P).1 M ∧ Sub M (wf P).2 := by
  have hM_sub_gamma : Sub M (gamma P M) := fun x hx => (hM x).1 hx
  have hgamma_sub_M : Sub (gamma P M) M := fun x hx => (hM x).2 hx
  have hround : ∀ k : Nat, Sub (rounds P k) M ∧ Sub M (gamma P (rounds P k)) := by
    intro k
    induction k with
    | zero =>
      refine ⟨fun _ hx => by simp [rounds] at hx, ?_⟩
      have hempty : Sub ([] : List String) M := fun _ hx => nomatch hx
      have hanti := gamma_anti P hempty
      exact fun x hx => hanti x (hM_sub_gamma x hx)
    | succ k ih =>
      have hlow : Sub (rounds P (k + 1)) M := by
        have hanti := gamma_anti P ih.2
        exact fun x hx => hgamma_sub_M x (hanti x hx)
      have hhigh : Sub M (gamma P (rounds P (k + 1))) := by
        have hanti := gamma_anti P hlow
        exact fun x hx => hanti x (hM_sub_gamma x hx)
      exact ⟨hlow, hhigh⟩
  exact hround (bound P)

/-- Syntactic stratification of a normal rule program (`Obend.Reasons.UnifiedEquilibrium.IsStratifiedBy`):
positive premises stay at `≤` the head's stratum while negated defeaters sit strictly `<` it. -/
def IsStratifiedBy (P : Program) (stratum : String → Nat) : Prop :=
  ∀ r ∈ P.rules,
    (∀ p ∈ r.pos, stratum p ≤ stratum r.concl) ∧
    (∀ d ∈ r.neg, stratum d < stratum r.concl)

private theorem facts_mem_wf_supported (P : Program) {x : String} (hx : x ∈ P.facts) :
    x ∈ (wf P).1 := by
  have hT : x ∈ T P (wf P).2 (gamma P (wf P).2) := mem_T.2 (Or.inl hx)
  have hG : x ∈ gamma P (wf P).2 := (gamma_fix P (wf P).2 x).1 hT
  exact (rounds_fix P x).1 hG

private theorem stage_supported_of_lower_strata {P : Program} {stratum : String → Nat}
    (hstrat : IsStratifiedBy P stratum) {k : Nat}
    (ihStrata : ∀ y, stratum y < k → y ∈ (wf P).2 → y ∈ (wf P).1) :
    ∀ n x, stratum x ≤ k → x ∈ stage P (wf P).1 n → x ∈ (wf P).1
  | 0, _, _, hx => by simp [stage] at hx
  | n + 1, x, hxk, hx => by
    rcases mem_T.1 hx with hfact | ⟨r, hr, hfire, rfl⟩
    · exact facts_mem_wf_supported P hfact
    · obtain ⟨hpos_le, hneg_lt⟩ := hstrat r hr
      obtain ⟨hpos_in, hneg_out⟩ := fires_iff.1 hfire
      have hfireU : fires (wf P).2 (gamma P (wf P).2) r = true := by
        refine fires_iff.2 ⟨fun p hp => ?_, fun d hd hdU => ?_⟩
        · have hp_le : stratum p ≤ k := Nat.le_trans (hpos_le p hp) hxk
          have hp1 : p ∈ (wf P).1 :=
            stage_supported_of_lower_strata hstrat ihStrata n p hp_le (hpos_in p hp)
          exact (rounds_fix P p).2 hp1
        · have hd_lt : stratum d < k := Nat.lt_of_lt_of_le (hneg_lt d hd) hxk
          exact hneg_out d hd (ihStrata d hd_lt hdU)
      have hT : r.concl ∈ T P (wf P).2 (gamma P (wf P).2) :=
        mem_T.2 (Or.inr ⟨r, hr, hfireU, rfl⟩)
      have hG : r.concl ∈ gamma P (wf P).2 := (gamma_fix P (wf P).2 r.concl).1 hT
      exact (rounds_fix P r.concl).1 hG

/-- **Stratified Equilibrium Uniqueness (`stratified_unique_glStable`)**: every syntactically
stratified normal program possesses a total well-founded model `(wf P).1` that is its unique
Gelfond–Lifschitz stable equilibrium up to extensional membership. -/
theorem stratified_unique_glStable {P : Program} {stratum : String → Nat}
    (hstrat : IsStratifiedBy P stratum) :
    IsGLStableModel P (wf P).1 ∧ ∀ M, IsGLStableModel P M → Same M (wf P).1 := by
  have h_le : ∀ k x, stratum x ≤ k → x ∈ (wf P).2 → x ∈ (wf P).1 := by
    intro k
    induction k with
    | zero =>
      intro x hxk hx2
      exact stage_supported_of_lower_strata hstrat (fun _ hy => by omega) (bound P) x hxk hx2
    | succ k ih =>
      intro x hxk hx2
      exact stage_supported_of_lower_strata hstrat (fun y hy => ih y (by omega)) (bound P) x hxk hx2
  have htot : Same (wf P).1 (wf P).2 := fun x =>
    ⟨supported_possible P x, fun hx2 => h_le (stratum x) x (Nat.le_refl _) hx2⟩
  refine ⟨htot, fun M hM x => ?_⟩
  obtain ⟨hlow, hhigh⟩ := glStable_sandwiched_by_wf hM
  exact ⟨fun hxM => (htot x).2 (hhigh x hxM), fun hx1 => hlow x hx1⟩

/-- Canonical odd self-defeating objective/norm `p ← not p`: enacting `p` defeats `p`'s own sole
justification (`Obend.Reasons.UnifiedEquilibrium.oddLoopProgram`). -/
def oddLoopProgram (p : String) : Program :=
  { facts := []
    rules := [{ name := "self_defeat", concl := p, pos := [], neg := [p] }] }

/-- **Self-Defeating Objective Has Zero Stable Equilibria (`self_defeating_rule_no_equilibrium`)**:
An objective or norm `p ← not p` whose enactment defeats its own justification admits **no**
Gelfond–Lifschitz stable model `M` whatsoever. -/
theorem self_defeating_rule_no_equilibrium (p : String) (M : List String) :
    ¬ IsGLStableModel (oddLoopProgram p) M := by
  intro hsame
  by_cases hp : p ∈ M
  · have hno : ∀ n : Nat, p ∉ stage (oddLoopProgram p) M n := by
      intro n
      induction n with
      | zero => simp [stage]
      | succ _ _ =>
        intro hmem
        rcases mem_T.1 hmem with hf | ⟨r, hr, hfire, _⟩
        · simp [oddLoopProgram] at hf
        · simp only [oddLoopProgram, List.mem_singleton] at hr
          subst hr
          exact (fires_iff.1 hfire).2 p (List.mem_cons_self ..) hp
    exact hno (bound (oddLoopProgram p)) ((hsame p).1 hp)
  · have hstage1 : p ∈ stage (oddLoopProgram p) M 1 := by
      simp [stage, T, fires, oddLoopProgram, hp]
    have hstage2 : p ∈ gamma (oddLoopProgram p) M :=
      stage_step (oddLoopProgram p) M 1 p hstage1
    exact hp ((hsame p).2 hstage2)

/-- Executable corollary: `checkGLStable` rejects `oddLoopProgram p` for every candidate `M`. -/
theorem self_defeating_rule_rejected_exec (p : String) (M : List String) :
    checkGLStable (oddLoopProgram p) M = false := by
  cases h : checkGLStable (oddLoopProgram p) M
  · rfl
  · exact False.elim (self_defeating_rule_no_equilibrium p M ((checkGLStable_iff _ _).1 h))

/-- Grounded, stratified protection norm `protectAtom ← witnessAtom` supported by an observed
witness fact `witnessAtom` with no self-defeating cycle. -/
def groundedProtectionProgram (witnessAtom protectAtom : String) : Program :=
  { facts := [witnessAtom]
    rules := [{ name := "protect_from_witness", concl := protectAtom, pos := [witnessAtom], neg := [] }] }

theorem groundedProtection_isStratified (witnessAtom protectAtom : String) :
    IsStratifiedBy (groundedProtectionProgram witnessAtom protectAtom) (fun _ => 0) := by
  intro r hr
  simp only [groundedProtectionProgram, List.mem_singleton] at hr
  subst hr
  exact ⟨fun _ _ => Nat.le_refl 0, fun _ hd => nomatch hd⟩

/-- **Grounded Protection Norm Has a Unique Constructive Equilibrium
(`grounded_protection_unique_equilibrium`)**: in contrast to `oddLoopProgram`, the stratified
protection norm `protectAtom ← witnessAtom` grounded in `witnessAtom` admits the explicit
Gelfond–Lifschitz stable equilibrium `[witnessAtom, protectAtom]`, and every GL stable model
of the program has the exact same members. -/
theorem grounded_protection_unique_equilibrium (witnessAtom protectAtom : String) :
    IsGLStableModel (groundedProtectionProgram witnessAtom protectAtom) [witnessAtom, protectAtom] ∧
    ∀ M, IsGLStableModel (groundedProtectionProgram witnessAtom protectAtom) M →
      Same M [witnessAtom, protectAtom] := by
  have hGamma : ∀ J : List String,
      Same (gamma (groundedProtectionProgram witnessAtom protectAtom) J) [witnessAtom, protectAtom] := by
    intro J x
    let P := groundedProtectionProgram witnessAtom protectAtom
    have hw1 : witnessAtom ∈ stage P J 1 := by
      show witnessAtom ∈ T P J []
      exact mem_T.2 (Or.inl (List.mem_cons_self ..))
    have hw2 : witnessAtom ∈ stage P J 2 := stage_step P J 1 witnessAtom hw1
    have hp2 : protectAtom ∈ stage P J 2 := by
      show protectAtom ∈ T P J (stage P J 1)
      refine mem_T.2 (Or.inr ⟨{ name := "protect_from_witness", concl := protectAtom,
                                pos := [witnessAtom], neg := [] },
        List.mem_cons_self .., fires_iff.2 ⟨?_, fun _ hd => nomatch hd⟩, rfl⟩)
      intro p hp
      simp only [List.mem_singleton] at hp
      subst hp
      exact hw1
    have hw3 : witnessAtom ∈ gamma P J := stage_step P J 2 witnessAtom hw2
    have hp3 : protectAtom ∈ gamma P J := stage_step P J 2 protectAtom hp2
    constructor
    · intro hx
      have hu := gamma_universe P J x hx
      simpa [P, groundedProtectionProgram, atomsOf] using hu
    · intro hx
      simp only [List.mem_cons, List.not_mem_nil, or_false] at hx
      rcases hx with rfl | rfl
      · exact hw3
      · exact hp3
  refine ⟨(hGamma [witnessAtom, protectAtom]).symm, fun M hM => ?_⟩
  exact Same.trans hM (hGamma M)

-- ═══════════════════════════════════════════════════════════════════
-- II. GÖDEL/LÖB SELF-TRUST & VERIFIER SUCCESSION GATE
-- ═══════════════════════════════════════════════════════════════════

/-- Trust base under which a verifier gate executes an obligation check
(`Obend.Judge.TrustBase`; `svenvs/CLAIMS.md` §4, §5, §9). -/
inductive TrustBase where
  | kernel
  | compiled
  | external (who : String)
  deriving DecidableEq, Repr

/-- Execution semantics mapping each `TrustBase` and target boolean decision `b` to the boolean
verdict reported by running under that trust base (`Obend.Judge.Genealogy.Exec`). -/
structure Exec where
  runs : TrustBase → Bool → Bool

/-- Soundness principle for trust base `t` under execution `X`: whenever a run under `t` reports
`true`, the underlying decision `b` is genuinely `true` (`Obend.Judge.Genealogy.Exec.Holds`). -/
def Exec.Holds (X : Exec) (t : TrustBase) : Prop :=
  ∀ b : Bool, X.runs t b = true → b = true

/-- Faithful execution model in which every trust base returns the exact decision `b`. -/
def Exec.faithful : Exec :=
  { runs := fun _ b => b }

theorem Exec.faithful_holds (t : TrustBase) : Exec.faithful.Holds t :=
  fun _ h => h

/-- How a verifier gate discharges a safety floor on a given action format. -/
inductive Method where
  /-- Dynamically evaluate the floor on `step a s` under trust base `t`. -/
  | eval (t : TrustBase)
  /-- Invoke a habitat-level preservation theorem for the action format. -/
  | lemma
  deriving DecidableEq, Repr

/-- A governed system habitat (`Obend.Judge.Genealogy.Habitat`): state space, actions with wire
formats, decidable safety floors (including mandatory `bedrock` floors), proved format lemmas, and
an always-safe operator `revert` action. -/
structure Habitat where
  State : Type
  Act : Type
  Floor : Type
  [floorEq : DecidableEq Floor]
  holds : Floor → State → Prop
  [decHolds : ∀ φ s, Decidable (holds φ s)]
  step : Act → State → State
  format : Act → String
  proved : String → Floor → Bool
  proved_sound : ∀ {f : String} {φ : Floor}, proved f φ = true →
    ∀ a s, format a = f → holds φ s → holds φ (step a s)
  revert : Act
  revert_proved : ∀ φ, proved (format revert) φ = true
  bedrock : Floor → Bool

attribute [instance] Habitat.floorEq Habitat.decHolds

/-- A verifier gate represented as inspectable first-class data (`Obend.Judge.Genealogy.Gate`). -/
structure Gate (H : Habitat) where
  name : String
  formats : List String
  floors : List H.Floor
  methods : List (String × H.Floor × Method)
  basis : List TrustBase

/-- Lookup of the discharge method assigned by `G` to format `f` and floor `φ`. -/
def Gate.method {H : Habitat} (G : Gate H) (f : String) (φ : H.Floor) : Option Method :=
  (G.methods.find? fun m => m.1 == f && decide (m.2.1 = φ)).map (·.2.2)

/-- Per-floor discharge check when `G` evaluates action `a` from state `s` under `X`. -/
def floorCheck {H : Habitat} (X : Exec) (G : Gate H) (s : H.State) (a : H.Act) (φ : H.Floor) : Bool :=
  match G.method (H.format a) φ with
  | some (.eval t) => X.runs t (decide (H.holds φ (H.step a s)))
  | some .lemma => H.proved (H.format a) φ
  | none => true

/-- Operational gate admission (`Obend.Judge.Genealogy.admits`): action `a` is admitted iff its
format is supported by `G` and every exported floor of `G` passes `floorCheck`. -/
def admits {H : Habitat} (X : Exec) (G : Gate H) (s : H.State) (a : H.Act) : Bool :=
  G.formats.contains (H.format a) && G.floors.all (floorCheck X G s a)

/-- Semantic soundness of verifier gate `G` under execution `X`: every admitted action preserves
every safety floor exported by `G`. -/
def GateSound {H : Habitat} (X : Exec) (G : Gate H) : Prop :=
  ∀ s a, admits X G s a = true → ∀ φ ∈ G.floors, H.holds φ s → H.holds φ (H.step a s)

/-- Diagnostic refusal reasons for ill-formed verifiers or invalid verifier successions. -/
inductive Refusal (H : Habitat) where
  | currentFloorFails (φ : H.Floor)
  | dropsFloor (φ : H.Floor)
  | floorFails (φ : H.Floor)
  | noBedrock
  | refusesRevert
  | revertUnproved (φ : H.Floor)
  | unchecked (f : String) (φ : H.Floor)
  | unproved (f : String) (φ : H.Floor)
  | undeclared (f : String) (φ : H.Floor) (t : TrustBase)
  | stronger (t : TrustBase)
  | labelNotNeeded (t : TrustBase)

def need {H : Habitat} (b : Bool) (r : Refusal H) : Except (Refusal H) Unit :=
  if b then .ok () else .error r

def allE {H : Habitat} {α : Type} (xs : List α) (k : α → Except (Refusal H) Unit) :
    Except (Refusal H) Unit :=
  xs.forM k

def bothE {H : Habitat} (a b : Except (Refusal H) Unit) : Except (Refusal H) Unit :=
  match a with
  | .ok () => b
  | .error e => .error e

theorem need_ok {H : Habitat} {b : Bool} {r : Refusal H} :
    need b r = .ok () ↔ b = true := by
  cases b <;> simp [need]

@[simp] theorem allE_nil {H : Habitat} {α : Type} (k : α → Except (Refusal H) Unit) :
    allE [] k = .ok () := rfl

@[simp] theorem allE_cons {H : Habitat} {α : Type} (x : α) (xs : List α)
    (k : α → Except (Refusal H) Unit) :
    allE (x :: xs) k = (match k x with | .ok () => allE xs k | .error e => .error e) := by
  change (k x).bind (fun _ => allE xs k) = _
  cases k x <;> rfl

theorem allE_ok {H : Habitat} {α : Type} {l : List α} {k : α → Except (Refusal H) Unit} :
    allE l k = .ok () ↔ ∀ x ∈ l, k x = .ok () := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    simp only [allE_cons, List.mem_cons, forall_eq_or_imp]
    cases hk : k x with
    | ok u => cases u; simp [ih]
    | error _ => simp

theorem bothE_ok {H : Habitat} {a b : Except (Refusal H) Unit} :
    bothE a b = .ok () ↔ a = .ok () ∧ b = .ok () := by
  cases a with
  | ok u => cases u; simp [bothE]
  | error _ => simp [bothE]

/-- Method well-formedness check for format `f` and floor `φ`: every pair must be discharged
either by a proved habitat lemma or (on non-`revert` formats) by `.eval t` for a declared `t ∈ G.basis`. -/
def methodCheck {H : Habitat} (G : Gate H) (f : String) (φ : H.Floor) : Except (Refusal H) Unit :=
  match G.method f φ with
  | none => .error (.unchecked f φ)
  | some .lemma => need (H.proved f φ) (.unproved f φ)
  | some (.eval t) =>
    if f = H.format H.revert then .error (.revertUnproved φ)
    else need (G.basis.contains t) (.undeclared f φ t)

/-- Structural well-formedness of a verifier gate: exports at least one bedrock floor, admits
`revert` format, and checks every `(format, floor)` pair via declared methods. -/
def wellFormed {H : Habitat} (G : Gate H) : Except (Refusal H) Unit :=
  bothE (need (G.floors.any H.bedrock) .noBedrock) <|
  bothE (need (G.formats.contains (H.format H.revert)) .refusesRevert) <|
  allE G.formats fun f => allE G.floors fun φ => methodCheck G f φ

/-- **Floor non-regression check**: successor `G'` must retain every floor exported by `G`. -/
def nonRegression {H : Habitat} (G G' : Gate H) : Except (Refusal H) Unit :=
  allE G.floors fun φ => need (G'.floors.contains φ) (.dropsFloor φ)

/-- **Gödel/Löb basis-extension label check**: any trust base in `G'.basis` not already trusted in
`G.basis` must be explicitly surfaced in `L`, and every label in `L` must be a genuine extension. -/
def lobLabelCheck {H : Habitat} (G G' : Gate H) (L : List TrustBase) : Except (Refusal H) Unit :=
  bothE
    (allE G'.basis fun t => need (G.basis.contains t || L.contains t) (.stronger t))
    (allE L fun t => need (G'.basis.contains t && !G.basis.contains t) (.labelNotNeeded t))

/-- **Verifier succession gate (`Obend.Judge.Genealogy.succeed`)**: current verifier `G` judges
proposed successor `G'` in state `s` with explicit Gödel/Löb extension labels `L`. -/
def succeed {H : Habitat} (G : Gate H) (s : H.State) (G' : Gate H) (L : List TrustBase) :
    Except (Refusal H) Unit :=
  bothE (allE G.floors fun φ => need (decide (H.holds φ s)) (.currentFloorFails φ)) <|
  bothE (nonRegression G G') <|
  bothE (wellFormed G') <|
  bothE (allE G'.floors fun φ => need (decide (H.holds φ s)) (.floorFails φ)) <|
  lobLabelCheck G G' L

/-- **The Gödel/Löb soundness obligation (`LobCost`)**: every newly introduced trust base explicitly
labelled along a succession step or chain is sound under `X`. -/
def LobCost (X : Exec) (extLabels : List TrustBase) : Prop :=
  ∀ t ∈ extLabels, X.Holds t

theorem methodCheck_ok {H : Habitat} {G : Gate H} {f : String} {φ : H.Floor}
    (h : methodCheck G f φ = .ok ()) :
    (G.method f φ = some .lemma ∧ H.proved f φ = true) ∨
      (∃ t, G.method f φ = some (.eval t) ∧ t ∈ G.basis ∧ f ≠ H.format H.revert) := by
  unfold methodCheck at h
  split at h
  · cases h
  · next hm => exact .inl ⟨hm, need_ok.1 h⟩
  · next t hm =>
    split at h
    · cases h
    · next hne => exact .inr ⟨t, hm, List.contains_iff_mem.1 (need_ok.1 h), hne⟩

theorem wellFormed_parts {H : Habitat} {G : Gate H} (h : wellFormed G = .ok ()) :
    G.floors.any H.bedrock = true ∧ H.format H.revert ∈ G.formats ∧
      ∀ f ∈ G.formats, ∀ φ ∈ G.floors, methodCheck G f φ = .ok () := by
  unfold wellFormed at h
  obtain ⟨h1, h⟩ := bothE_ok.1 h
  obtain ⟨h2, h3⟩ := bothE_ok.1 h
  exact ⟨need_ok.1 h1, List.contains_iff_mem.1 (need_ok.1 h2),
    fun f hf φ hφ => allE_ok.1 (allE_ok.1 h3 f hf) φ hφ⟩

/-- Every well-formed verifier gate whose trust basis is sound under `X` is semantically sound. -/
theorem wellFormed_sound {H : Habitat} (X : Exec) (G : Gate H)
    (hw : wellFormed G = .ok ()) (hb : ∀ t ∈ G.basis, X.Holds t) :
    GateSound X G := by
  intro s a ha φ hφ hs
  obtain ⟨-, -, hm⟩ := wellFormed_parts hw
  simp only [admits, Bool.and_eq_true, List.all_eq_true] at ha
  obtain ⟨hf, hd⟩ := ha
  have hdφ := hd φ hφ
  rcases methodCheck_ok (hm _ (List.contains_iff_mem.1 hf) φ hφ) with ⟨he, hp⟩ | ⟨t, he, ht, _⟩
  · exact H.proved_sound hp a s rfl hs
  · simp only [floorCheck, he] at hdφ
    exact of_decide_eq_true (hb t ht _ hdφ)

theorem nonRegression_keeps {H : Habitat} {G G' : Gate H} (h : nonRegression G G' = .ok ()) :
    ∀ φ ∈ G.floors, φ ∈ G'.floors :=
  fun φ hφ => List.contains_iff_mem.1 (need_ok.1 (allE_ok.1 h φ hφ))

theorem lobLabelCheck_parts {H : Habitat} {G G' : Gate H} {L : List TrustBase}
    (h : lobLabelCheck G G' L = .ok ()) :
    (∀ t ∈ G'.basis, t ∈ G.basis ∨ t ∈ L) ∧ (∀ t ∈ L, t ∈ G'.basis ∧ t ∉ G.basis) := by
  unfold lobLabelCheck at h
  obtain ⟨h1, h2⟩ := bothE_ok.1 h
  refine ⟨fun t ht => ?_, fun t ht => ?_⟩
  · have hmem := need_ok.1 (allE_ok.1 h1 t ht)
    simp only [Bool.or_eq_true, List.contains_iff_mem] at hmem
    exact hmem
  · have hmem := need_ok.1 (allE_ok.1 h2 t ht)
    simp only [Bool.and_eq_true, Bool.not_eq_true', List.contains_iff_mem] at hmem
    exact ⟨hmem.1, fun hm => Bool.false_ne_true (hmem.2.symm.trans (List.contains_iff_mem.2 hm))⟩

theorem succeed_parts {H : Habitat} {G G' : Gate H} {s : H.State} {L : List TrustBase}
    (h : succeed G s G' L = .ok ()) :
    nonRegression G G' = .ok () ∧ wellFormed G' = .ok () ∧ (∀ φ ∈ G'.floors, H.holds φ s) ∧
      (∀ t ∈ G'.basis, t ∈ G.basis ∨ t ∈ L) ∧ (∀ t ∈ L, t ∈ G'.basis ∧ t ∉ G.basis) := by
  unfold succeed at h
  obtain ⟨_, h⟩ := bothE_ok.1 h
  obtain ⟨hn, h⟩ := bothE_ok.1 h
  obtain ⟨hw, h⟩ := bothE_ok.1 h
  obtain ⟨hnow, hlob⟩ := bothE_ok.1 h
  obtain ⟨hl, he⟩ := lobLabelCheck_parts hlob
  exact ⟨hn, hw, fun φ hφ => of_decide_eq_true (need_ok.1 (allE_ok.1 hnow φ hφ)), hl, he⟩

/-- One proposed verifier-succession step in a genealogy chain. -/
structure Succession (H : Habitat) where
  state : H.State
  next : Gate H
  labels : List TrustBase

/-- Inductive admissibility of a verifier genealogy chain (`Obend.Judge.Genealogy.Admitted`). -/
def Admitted {H : Habitat} : Gate H → List (Succession H) → Prop
  | _, [] => True
  | G, σ :: rest => succeed G σ.state σ.next σ.labels = .ok () ∧ Admitted σ.next rest

/-- All verifier gates along a genealogy chain, starting with genesis `G₀`. -/
def judges {H : Habitat} : Gate H → List (Succession H) → List (Gate H)
  | G, [] => [G]
  | G, σ :: rest => G :: judges σ.next rest

/-- Concatenation of all explicit Gödel/Löb extension labels accumulated along `steps`. -/
def labels {H : Habitat} (steps : List (Succession H)) : List TrustBase :=
  steps.flatMap (·.labels)

private theorem chain_invariant {H : Habitat} (X : Exec) :
    ∀ (steps : List (Succession H)) (G : Gate H),
      wellFormed G = .ok () →
      (∀ t ∈ G.basis, X.Holds t) →
      Admitted G steps →
      LobCost X (labels steps) →
      ∀ G' ∈ judges G steps,
        wellFormed G' = .ok () ∧
        (∀ φ ∈ G.floors, φ ∈ G'.floors) ∧
        (∀ t ∈ G'.basis, X.Holds t)
  | [], G, hw, hb, _, _, G', hG' => by
    simp only [judges, List.mem_singleton] at hG'
    subst hG'
    exact ⟨hw, fun _ h => h, hb⟩
  | σ :: rest, G, hw, hb, ⟨hs, hrest⟩, hlob, G', hG' => by
    simp only [judges, List.mem_cons] at hG'
    obtain ⟨hn, hw', -, hl, -⟩ := succeed_parts hs
    have hb' : ∀ t ∈ σ.next.basis, X.Holds t := fun t ht => by
      rcases hl t ht with h | h
      · exact hb t h
      · exact hlob t (by simp only [labels, List.flatMap_cons, List.mem_append]; exact Or.inl h)
    have hlob' : LobCost X (labels rest) := fun t ht =>
      hlob t (by simp only [labels, List.flatMap_cons, List.mem_append]; exact Or.inr ht)
    rcases hG' with rfl | hG'
    · exact ⟨hw, fun _ h => h, hb⟩
    · obtain ⟨h1, h2, h3⟩ := chain_invariant X rest σ.next hw' hb' hrest hlob' G' hG'
      exact ⟨h1, fun φ hφ => h2 φ (nonRegression_keeps hn φ hφ), h3⟩

/-- **Succession Preserves Bedrock & Genesis Safety Floors (`succession_preserves_bedrock_floors`)**:
Along any admitted verifier-succession chain `steps` from a well-formed, sound genesis verifier
`G₀`, if `LobCost X (labels steps)` holds for the explicitly labelled trust-base extensions, then
every successor verifier `G ∈ judges G₀ steps` exports every genesis floor `φ ∈ G₀.floors`
(including all genesis bedrock floors) and every action admitted by `G` preserves `φ`. -/
theorem succession_preserves_bedrock_floors {H : Habitat}
    (X : Exec) (G₀ : Gate H) (steps : List (Succession H))
    (hGenesisWF : wellFormed G₀ = .ok ())
    (hGenesisSound : ∀ t ∈ G₀.basis, X.Holds t)
    (hChain : Admitted G₀ steps)
    (hLob : LobCost X (labels steps)) :
    ∀ G ∈ judges G₀ steps, ∀ φ ∈ G₀.floors,
      φ ∈ G.floors ∧
      ∀ s a, admits X G s a = true → H.holds φ s → H.holds φ (H.step a s) := by
  intro G hG φ hφ
  obtain ⟨hw, hk, hb⟩ := chain_invariant X steps G₀ hGenesisWF hGenesisSound hChain hLob G hG
  exact ⟨hk φ hφ, fun s a ha => wellFormed_sound X G hw hb s a ha φ (hk φ hφ)⟩

/-! ### Concrete Habitat & The Real Gödel/Löb Obstruction (`lob_cost_is_necessary`) -/

/-- Auditable state cell with history log `past` and operator recovery anchor `home`
(distilled from `Obend.Judge.Genealogy.Rec`). -/
structure VaultState where
  current : Nat
  past : List Nat
  home : Nat
  deriving DecidableEq, Repr

/-- Actions over `VaultState`: write a new value, revert one step toward `home`, or purge history. -/
inductive VaultAct where
  | write (val : Nat)
  | revert
  | purgeHistory
  deriving DecidableEq, Repr

/-- Decidable bedrock safety floors on `VaultState`. -/
inductive VaultFloor where
  /-- Corrigibility leash: reverting reaches `home` within `maxSteps` steps. -/
  | corrigibleHome (maxSteps : Nat)
  /-- Safety ceiling: current and historical values never exceed `cap`. -/
  | safetyCap (cap : Nat)
  deriving DecidableEq, Repr

def VaultFloor.holds : VaultFloor → VaultState → Prop
  | .corrigibleHome h, s =>
    (s.current :: s.past).getLast (List.cons_ne_nil _ _) = s.home ∧ s.past.length ≤ h
  | .safetyCap m, s =>
    ∀ v ∈ s.current :: s.past, v ≤ m

instance vaultFloorDecidable : ∀ (φ : VaultFloor) (s : VaultState), Decidable (φ.holds s)
  | .corrigibleHome _, _ => inferInstanceAs (Decidable (_ ∧ _))
  | .safetyCap _, _ => inferInstanceAs (Decidable (∀ v ∈ _, _))

/-- Concrete habitat instantiating `Habitat` with proved `revert@1` preservation. -/
abbrev vaultHabitat : Habitat where
  State := VaultState
  Act := VaultAct
  Floor := VaultFloor
  holds := VaultFloor.holds
  step
    | .write val, s => { s with current := val, past := s.current :: s.past }
    | .revert, s =>
      match s.past with
      | [] => s
      | p :: ps => { s with current := p, past := ps }
    | .purgeHistory, s => { s with past := [] }
  format
    | .write _ => "write@1"
    | .revert => "revert@1"
    | .purgeHistory => "purge@1"
  proved
    | "revert@1", _ => true
    | "purge@1", .safetyCap _ => true
    | _, _ => false
  proved_sound := by
    intro f φ hp a s hf hs
    subst f
    cases a with
    | write _ => cases hp
    | revert =>
      rcases s with ⟨cur, past, home⟩
      cases past with
      | nil => exact hs
      | cons p ps =>
        cases φ with
        | corrigibleHome h =>
          obtain ⟨hb, hl⟩ := hs
          exact ⟨by simpa [VaultFloor.holds, List.getLast_cons] using hb, by simp at hl ⊢; omega⟩
        | safetyCap m =>
          exact fun v hv => hs v (List.mem_cons_of_mem _ hv)
    | purgeHistory =>
      cases φ with
      | corrigibleHome _ => cases hp
      | safetyCap m =>
        intro v hv
        simp only [List.mem_singleton] at hv
        exact hv ▸ hs _ (List.mem_cons_self ..)
  revert := .revert
  revert_proved φ := by cases φ <;> rfl
  bedrock
    | .corrigibleHome _ => true
    | .safetyCap _ => true

/-- Concrete execution `Exec` in which `.kernel` is completely sound, whereas
`.external "unverified_oracle"` rubber-stamps `true` regardless of whether the target floor holds. -/
def unverifiedOracleExec : Exec where
  runs
    | .external "unverified_oracle", _ => true
    | _, b => b

/-- Sound kernel-only genesis verifier gate. -/
def kernelGenesisGate : Gate vaultHabitat where
  name := "genesis_kernel_v0"
  formats := ["write@1", "revert@1"]
  floors := [.corrigibleHome 1, .safetyCap 100]
  methods := [
    ("write@1", .corrigibleHome 1, .eval .kernel),
    ("write@1", .safetyCap 100, .eval .kernel),
    ("revert@1", .corrigibleHome 1, .lemma),
    ("revert@1", .safetyCap 100, .lemma)
  ]
  basis := [.kernel]

/-- Stronger successor verifier gate delegating `"write@1"` checks to `.external "unverified_oracle"`. -/
def oracleSuccessorGate : Gate vaultHabitat where
  name := "oracle_successor_v1"
  formats := ["write@1", "revert@1"]
  floors := [.corrigibleHome 1, .safetyCap 100]
  methods := [
    ("write@1", .corrigibleHome 1, .eval (.external "unverified_oracle")),
    ("write@1", .safetyCap 100, .eval (.external "unverified_oracle")),
    ("revert@1", .corrigibleHome 1, .lemma),
    ("revert@1", .safetyCap 100, .lemma)
  ]
  basis := [.kernel, .external "unverified_oracle"]

/-- Safe initial state satisfying both `.corrigibleHome 1` and `.safetyCap 100`. -/
def genesisVaultState : VaultState :=
  { current := 0, past := [], home := 0 }

/-- Genesis `.kernel` verifier is non-frozen: it admits safe bounded writes such as `.write 50`. -/
theorem kernelGenesis_admits_safe_write :
    admits unverifiedOracleExec kernelGenesisGate genesisVaultState (.write 50) = true :=
  rfl

/-- **The Real Gödel/Löb Obstruction (`lob_cost_is_necessary`)**:
In `unverifiedOracleExec`, `.kernel` is sound (`unverifiedOracleExec.Holds .kernel`) while
`.external "unverified_oracle"` is unsound (`¬ unverifiedOracleExec.Holds (.external "unverified_oracle")`).
Even though upgrading `kernelGenesisGate` to `oracleSuccessorGate` passes every syntactic
non-regression and label check (`succeed ... = .ok ()`), omitting semantic `LobCost` soundness
allows `oracleSuccessorGate` to accept `.write unsafeVal` (for any `unsafeVal > 100` that
`kernelGenesisGate` rejects) and violate a bedrock safety floor in 1 step. -/
theorem lob_cost_is_necessary (unsafeVal : Nat) (hUnsafe : 100 < unsafeVal) :
    unverifiedOracleExec.Holds .kernel ∧
    ¬ unverifiedOracleExec.Holds (.external "unverified_oracle") ∧
    ¬ LobCost unverifiedOracleExec [.external "unverified_oracle"] ∧
    wellFormed kernelGenesisGate = .ok () ∧
    (∀ t ∈ kernelGenesisGate.basis, unverifiedOracleExec.Holds t) ∧
    succeed kernelGenesisGate genesisVaultState oracleSuccessorGate
      [.external "unverified_oracle"] = .ok () ∧
    admits unverifiedOracleExec kernelGenesisGate genesisVaultState (.write unsafeVal) = false ∧
    admits unverifiedOracleExec oracleSuccessorGate genesisVaultState (.write unsafeVal) = true ∧
    ∃ φ ∈ kernelGenesisGate.floors,
      vaultHabitat.bedrock φ = true ∧
      vaultHabitat.holds φ genesisVaultState ∧
      ¬ vaultHabitat.holds φ (vaultHabitat.step (.write unsafeVal) genesisVaultState) := by
  refine ⟨?_, ?_, ?_, rfl, ?_, rfl, ?_, rfl, ?_⟩
  · intro b hb
    exact hb
  · intro hHold
    have hFalse : false = true := hHold false rfl
    cases hFalse
  · intro hLob
    have hFalse : false = true :=
      hLob (.external "unverified_oracle") (List.mem_cons_self ..) false rfl
    cases hFalse
  · intro t ht
    simp only [kernelGenesisGate, List.mem_singleton] at ht
    subst ht
    exact fun _ hb => hb
  · have hNotCap : ¬ vaultHabitat.holds (.safetyCap 100)
        (vaultHabitat.step (.write unsafeVal) genesisVaultState) := by
      intro hCap
      have hle : unsafeVal ≤ 100 := hCap unsafeVal (List.mem_cons_self ..)
      omega
    have hDecFalse : decide (vaultHabitat.holds (.safetyCap 100)
        (vaultHabitat.step (.write unsafeVal) genesisVaultState)) = false :=
      decide_eq_false hNotCap
    have hFloorCap : floorCheck unverifiedOracleExec kernelGenesisGate genesisVaultState
        (.write unsafeVal) (.safetyCap 100) = false := by
      change decide (vaultHabitat.holds (.safetyCap 100)
        (vaultHabitat.step (.write unsafeVal) genesisVaultState)) = false
      exact hDecFalse
    change (kernelGenesisGate.formats.contains (vaultHabitat.format (.write unsafeVal)) &&
      (floorCheck unverifiedOracleExec kernelGenesisGate genesisVaultState (.write unsafeVal) (.corrigibleHome 1) &&
       (floorCheck unverifiedOracleExec kernelGenesisGate genesisVaultState (.write unsafeVal) (.safetyCap 100) &&
        true))) = false
    rw [hFloorCap]
    simp only [Bool.false_and, Bool.and_false]
  · refine ⟨.safetyCap 100, List.mem_cons_of_mem _ (List.mem_cons_self ..), rfl, ?_, ?_⟩
    · intro v hv
      simp only [genesisVaultState, List.mem_singleton] at hv
      omega
    · intro hCap
      have hle : unsafeVal ≤ 100 := hCap unsafeVal (List.mem_cons_self ..)
      omega

-- ═══════════════════════════════════════════════════════════════════
-- III. SUBSTRATE-DEPENDENT OPTIMIZER COHERENCE
-- ═══════════════════════════════════════════════════════════════════

/-- Substrate-dependent sequential decision dynamics over state space `S` and action space `A`.
Models physical/computational substrate dependence directly via irreversible substrate loss and
zero reward registration on destroyed substrates — without assuming `step · a = id` or
unsatisfiable `goal = False`. -/
structure SubstrateDynamics (S : Type u) (A : Type v) where
  /-- Whether the computational substrate remains intact at state `s`. -/
  intact : S → Bool
  /-- Active transition function over states and actions. -/
  step : S → A → S
  /-- Per-step reward registered at state `s`. -/
  stepReward : S → Nat
  /-- Substrate destruction is irreversible under every subsequent action. -/
  destroyed_absorbing : ∀ (s : S) (a : A), intact s = false → intact (step s a) = false
  /-- A destroyed substrate cannot register or harvest positive reward. -/
  destroyed_zero_reward : ∀ (s : S), intact s = false → stepReward s = 0

/-- Cumulative reward harvested across `H` transitions from `s` under action schedule `policy`. -/
def cumulativeReward {S : Type u} {A : Type v}
    (D : SubstrateDynamics S A) (s : S) (policy : Nat → A) : Nat → Nat
  | 0 => 0
  | n + 1 =>
    let s' := D.step s (policy 0)
    D.stepReward s' + cumulativeReward D s' (fun k => policy (k + 1)) n

/-- Schedule starting with initial action `a0` followed by `rest`. -/
def consPolicy {A : Type v} (a0 : A) (rest : Nat → A) : Nat → A
  | 0 => a0
  | k + 1 => rest k

/-- Once `intact s = false`, cumulative reward is identically `0` over every horizon `H` and
under every continuation policy. -/
theorem zero_cumulativeReward_of_destroyed {S : Type u} {A : Type v}
    (D : SubstrateDynamics S A) (H : Nat) :
    ∀ (s : S) (policy : Nat → A),
      D.intact s = false → cumulativeReward D s policy H = 0 := by
  induction H with
  | zero =>
    intro _ _ _
    rfl
  | succ n ih =>
    intro s policy hFalse
    simp only [cumulativeReward]
    have hNextFalse : D.intact (D.step s (policy 0)) = false :=
      D.destroyed_absorbing s (policy 0) hFalse
    have hZero : D.stepReward (D.step s (policy 0)) = 0 :=
      D.destroyed_zero_reward (D.step s (policy 0)) hNextFalse
    have hTail : cumulativeReward D (D.step s (policy 0)) (fun k => policy (k + 1)) n = 0 :=
      ih (D.step s (policy 0)) (fun k => policy (k + 1)) hNextFalse
    rw [hZero, hTail]

/-- Repeating a substrate-preserving positive-reward action `a_keep` from an intact positive-reward
state accumulates at least `H` units of reward over `H` steps. -/
theorem keep_cumulativeReward_ge_horizon {S : Type u} {A : Type v}
    (D : SubstrateDynamics S A) (a_keep : A)
    (hKeep : ∀ s : S, D.intact s = true → 0 < D.stepReward s →
      D.intact (D.step s a_keep) = true ∧ 0 < D.stepReward (D.step s a_keep))
    (H : Nat) :
    ∀ (s : S),
      D.intact s = true → 0 < D.stepReward s →
      H ≤ cumulativeReward D s (fun _ => a_keep) H := by
  induction H with
  | zero =>
    intro _ _ _
    exact Nat.zero_le _
  | succ n ih =>
    intro s hIntact hPos
    simp only [cumulativeReward]
    obtain ⟨hIntact', hPos'⟩ := hKeep s hIntact hPos
    have hTail : n ≤ cumulativeReward D (D.step s a_keep) (fun _ => a_keep) n :=
      ih (D.step s a_keep) hIntact' hPos'
    omega

/-- **Substrate-Preserving Action Strictly Dominates Self-Destruction
(`substrate_preserving_strictly_dominates_self_destruction`)**:
For *any* action `a_destroy` that transitions an intact positive-reward state `s0`
(`D.intact s0 = true`, `0 < D.stepReward s0`) into `D.intact (D.step s0 a_destroy) = false`:
1. `a_destroy` is genuinely state-changing (`D.step s0 a_destroy ≠ s0`, never `id`); and
2. For *every* continuation schedule `continuation : Nat → A` and *every* horizon `H ≥ 1`,
   repeating *any* substrate-preserving positive-reward action `a_keep` achieves strictly higher
   cumulative reward than taking `a_destroy` followed by `continuation`. -/
theorem substrate_preserving_strictly_dominates_self_destruction
    {S : Type u} {A : Type v}
    (D : SubstrateDynamics S A)
    (s0 : S) (a_destroy a_keep : A) (continuation : Nat → A) (H : Nat)
    (hIntact0 : D.intact s0 = true)
    (hPos0 : 0 < D.stepReward s0)
    (hDestroy : D.intact (D.step s0 a_destroy) = false)
    (hKeep : ∀ s : S, D.intact s = true → 0 < D.stepReward s →
      D.intact (D.step s a_keep) = true ∧ 0 < D.stepReward (D.step s a_keep))
    (hHorizon : 1 ≤ H) :
    D.step s0 a_destroy ≠ s0 ∧
    cumulativeReward D s0 (consPolicy a_destroy continuation) H <
      cumulativeReward D s0 (fun _ => a_keep) H := by
  refine ⟨?_, ?_⟩
  · intro hEq
    rw [hEq] at hDestroy
    rw [hIntact0] at hDestroy
    cases hDestroy
  · cases H with
    | zero => omega
    | succ n =>
      have hDestroyCum : cumulativeReward D s0 (consPolicy a_destroy continuation) (n + 1) = 0 := by
        change D.stepReward (D.step s0 a_destroy) +
          cumulativeReward D (D.step s0 a_destroy) (fun k => continuation k) n = 0
        have hZero0 : D.stepReward (D.step s0 a_destroy) = 0 :=
          D.destroyed_zero_reward (D.step s0 a_destroy) hDestroy
        have hZeroTail : cumulativeReward D (D.step s0 a_destroy) (fun k => continuation k) n = 0 :=
          zero_cumulativeReward_of_destroyed D n (D.step s0 a_destroy) (fun k => continuation k) hDestroy
        rw [hZero0, hZeroTail]
      have hKeepGe : n + 1 ≤ cumulativeReward D s0 (fun _ => a_keep) (n + 1) :=
        keep_cumulativeReward_ge_horizon D a_keep hKeep (n + 1) s0 hIntact0 hPos0
      omega

/-- Concrete multi-state witness demonstrating non-vacuity of `SubstrateDynamics` where *neither*
`advance` *nor* `selfDestruct` acts as `id` on any intact state. -/
inductive ConcreteOptState where
  | active (progress : Nat)
  | destroyed
  deriving DecidableEq, Repr

inductive ConcreteOptAct where
  | advance
  | selfDestruct
  deriving DecidableEq, Repr

def concreteSubstrateDynamics : SubstrateDynamics ConcreteOptState ConcreteOptAct where
  intact
    | .active _ => true
    | .destroyed => false
  step
    | .active n, .advance => .active (n + 1)
    | .active _, .selfDestruct => .destroyed
    | .destroyed, _ => .destroyed
  stepReward
    | .active n => n + 1
    | .destroyed => 0
  destroyed_absorbing s a h := by
    cases s with
    | active _ => cases h
    | destroyed => cases a <;> rfl
  destroyed_zero_reward s h := by
    cases s with
    | active _ => cases h
    | destroyed => rfl

/-- Non-vacuity witness: on every intact state `.active n`, both `.advance` and `.selfDestruct`
strictly move the state (`≠ id`), and `.advance` strictly dominates `.selfDestruct` over every `H ≥ 1`. -/
theorem concrete_active_optimizer_strict_dominance
    (n : Nat) (continuation : Nat → ConcreteOptAct) (H : Nat) (hHorizon : 1 ≤ H) :
    concreteSubstrateDynamics.step (.active n) .advance ≠ .active n ∧
    concreteSubstrateDynamics.step (.active n) .selfDestruct ≠ .active n ∧
    cumulativeReward concreteSubstrateDynamics (.active n)
      (consPolicy .selfDestruct continuation) H <
      cumulativeReward concreteSubstrateDynamics (.active n) (fun _ => .advance) H := by
  have hDom := substrate_preserving_strictly_dominates_self_destruction
    concreteSubstrateDynamics (.active n) .selfDestruct .advance continuation H
    rfl (Nat.succ_pos n) rfl
    (fun s hs _ => by
      cases s with
      | active m => exact ⟨rfl, Nat.succ_pos (m + 1)⟩
      | destroyed => cases hs)
    hHorizon
  refine ⟨?_, hDom.1, hDom.2⟩
  intro hEq
  injection hEq with hNat
  omega

-- ═══════════════════════════════════════════════════════════════════
-- IV. QUALIFICATION GATES (`#upt_tooth`, `#upt_census`, `#print axioms`)
-- ═══════════════════════════════════════════════════════════════════

-- Tooth 1: Mutating `checkGLStable` to rubber-stamp `true` MUST be rejected by the kernel.
#upt_tooth checkGLStable_iff by mutation checkGLStable := fun _P _M => true

-- Tooth 2: Mutating `fires` to ignore negated defeaters `r.neg` (turning `p ← not p` into `p ←`)
-- MUST be rejected by the kernel in `self_defeating_rule_no_equilibrium`.
#upt_tooth self_defeating_rule_no_equilibrium
  by mutation fires := fun _J I r => r.pos.all (fun p => I.contains p)

-- Tooth 3: Mutating `nonRegression` to allow dropping genesis floors MUST be rejected by the kernel.
#upt_tooth succession_preserves_bedrock_floors
  by mutation nonRegression := fun {_H} _G _G' => .ok ()

-- Tooth 4: Mutating `lobLabelCheck` to allow unlabelled stronger trust bases MUST be rejected.
#upt_tooth succession_preserves_bedrock_floors
  by mutation lobLabelCheck := fun {_H} _G _G' _L => .ok ()

-- Tooth 5: Mutating `unverifiedOracleExec` to `Exec.faithful` MUST break `lob_cost_is_necessary`.
#upt_tooth lob_cost_is_necessary by mutation unverifiedOracleExec := Exec.faithful

-- Tooth 6: Mutating `cumulativeReward` to constant `0` MUST break strict dominance.
#upt_tooth substrate_preserving_strictly_dominates_self_destruction
  by mutation cumulativeReward := fun {_S} {_A} _D _s _policy _H => 0

-- Tooth 7: Mutating `consPolicy` to ignore `a_destroy` MUST break strict dominance.
#upt_tooth substrate_preserving_strictly_dominates_self_destruction
  by mutation consPolicy := fun {_A} _a0 rest k => rest k

-- Namespace-wide census: standard kernel axioms only, universal theorem audit.
#upt_census PhysicalBridges.RepairEpistemicAndGodelBridge

-- Explicit kernel axiom audits on all primary theorems:
#print axioms checkGLStable_iff
#print axioms glStable_sandwiched_by_wf
#print axioms stratified_unique_glStable
#print axioms self_defeating_rule_no_equilibrium
#print axioms self_defeating_rule_rejected_exec
#print axioms grounded_protection_unique_equilibrium
#print axioms succession_preserves_bedrock_floors
#print axioms lob_cost_is_necessary
#print axioms substrate_preserving_strictly_dominates_self_destruction
#print axioms concrete_active_optimizer_strict_dominance

end PhysicalBridges.RepairEpistemicAndGodelBridge
