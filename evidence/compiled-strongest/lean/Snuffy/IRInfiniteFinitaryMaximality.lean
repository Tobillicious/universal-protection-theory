import Snuffy.IRFiniteProfileObstruction

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRInfiniteFinitaryMaximality.lean` at main `740abbb` (sha256 `48e61c7d13a2930e6a8cbc78d97d4dc337eea6c6c2e5bec1f2944e22ad5befaf`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-66: a genuinely INFINITE feasible-family maximality theorem, using
the ORIGINAL Snuffy.Book.UPTExistence.Aligned / LexAlignedL order and full feasible
family (not a finite-profile quotient or filtered safety menu).

The structural class here is countably indexed retention particulars
with finite-obstruction feasibility. For this class, finite forbidden
patterns give directed/chain-union closure and a greedy maximal option.

This is a mathematical *class theorem*, not proof that all physically
feasible UPT outcomes have finite-obstruction character, that all
minds are indexed by Nat, or that all original X3 priority stages
can be represented by one inclusion key.
-/

namespace PhysicalBridges.IRInfiniteFinitaryMaximality

/-- An infinite family of options s : Nat → Prop is constrained only by
explicit finite forbidden patterns. Every outcome is considered;
there is no finite enumeration, finite quotient or safety-menu cut. -/
def Feasible (forbidden : List Nat → Prop) (s : Nat → Prop) : Prop :=
  ∀ pattern : List Nat, forbidden pattern →
    ¬ (∀ k, k ∈ pattern → s k)

/-- Finitary constraints are hereditary: retaining fewer particulars
cannot introduce a forbidden finite pattern. -/
theorem feasible_downward (forbidden : List Nat → Prop)
    (larger smaller : Nat → Prop)
    (hLarge : Feasible forbidden larger)
    (hSub : Snuffy.Book.UPTExistence.Sub smaller larger) :
    Feasible forbidden smaller := by
  intro pattern hForbid hAll
  exact (hLarge pattern hForbid)
    (by intro k hk; exact hSub k (hAll k hk))

/-- An existential union over a FAMILY of retention sets. -/
def familyUnion (family : (Nat → Prop) → Prop) (k : Nat) : Prop :=
  ∃ s, family s ∧ s k

def IsChain (family : (Nat → Prop) → Prop) : Prop :=
  ∀ s t, family s → family t →
    Snuffy.Book.UPTExistence.Sub s t ∨ Snuffy.Book.UPTExistence.Sub t s

/-- Every finite list whose elements lie in the union of a nonempty
chain is entirely contained in ONE chain member. -/
theorem finite_chain_capture
    (family : (Nat → Prop) → Prop)
    (hChain : IsChain family)
    (hNonempty : ∃ s, family s) :
    ∀ (xs : List Nat),
      (∀ k, k ∈ xs → familyUnion family k) →
      ∃ s, family s ∧ ∀ k, k ∈ xs → s k := by
  intro xs
  induction xs with
  | nil =>
      intro _
      obtain ⟨s, hs⟩ := hNonempty
      exact ⟨s, hs, by intro k hk; cases hk⟩
  | cons x xs ih =>
      intro hAll
      obtain ⟨a, ha, hax⟩ :=
        hAll x List.mem_cons_self
      obtain ⟨b, hb, hbx⟩ :=
        ih (by
          intro k hk
          exact hAll k (List.mem_cons_of_mem x hk))
      rcases hChain a b ha hb with hab | hba
      · refine ⟨b, hb, ?_⟩
        intro k hk
        rcases List.mem_cons.mp hk with heq | hRest
        · subst k
          exact hab x hax
        · exact hbx k hRest
      · refine ⟨a, ha, ?_⟩
        intro k hk
        rcases List.mem_cons.mp hk with heq | hRest
        · subst k
          exact hax
        · exact hba k (hbx k hRest)

/-- DERIVED chain-upper-bound closure from finite forbidden patterns.
The union is feasible against the SAME full feasible predicate.
This is not a Zorn assumption hidden in a theorem hypothesis. -/
theorem chain_union_feasible
    (forbidden : List Nat → Prop)
    (family : (Nat → Prop) → Prop)
    (hChain : IsChain family)
    (hNonempty : ∃ s, family s)
    (hEach : ∀ s, family s → Feasible forbidden s) :
    Feasible forbidden (familyUnion family) := by
  intro pattern hForbidden hAll
  obtain ⟨s, hs, hContained⟩ :=
    finite_chain_capture family hChain hNonempty
      pattern (by intro k hk; exact hAll k hk)
  exact (hEach s hs pattern hForbidden) hContained

/-- Exact derived chain-upper-bound property in the ORIGINAL full
outcome space: the union itself is a feasible upper bound. -/
theorem derived_chain_upper_bound
    (forbidden : List Nat → Prop)
    (family : (Nat → Prop) → Prop)
    (hChain : IsChain family)
    (hNonempty : ∃ s, family s)
    (hEach : ∀ s, family s → Feasible forbidden s) :
    ∃ upper : Nat → Prop,
      Feasible forbidden upper ∧
      ∀ s, family s → Snuffy.Book.UPTExistence.Sub s upper := by
  refine ⟨familyUnion family,
    chain_union_feasible forbidden family hChain hNonempty hEach, ?_⟩
  intro s hs k hk
  exact ⟨s, hs, hk⟩

/-- This candidate uses an exact feasibility decision (possibly
noncomputable), not a claimed deployable oracle. -/
noncomputable def greedyStep
    (forbidden : List Nat → Prop) (s : Nat → Prop) (next : Nat) :
    Nat → Prop := by
  classical
  exact if Feasible forbidden (fun k => s k ∨ k = next) then
    (fun k => s k ∨ k = next)
  else s

theorem greedyStep_preserves_feasible
    (forbidden : List Nat → Prop) (s : Nat → Prop) (next : Nat)
    (h : Feasible forbidden s) :
    Feasible forbidden (greedyStep forbidden s next) := by
  classical
  by_cases hCandidate : Feasible forbidden (fun k => s k ∨ k = next)
  · simpa [greedyStep, hCandidate] using hCandidate
  · simpa [greedyStep, hCandidate] using h

theorem greedyStep_extends
    (forbidden : List Nat → Prop) (s : Nat → Prop) (next : Nat) :
    Snuffy.Book.UPTExistence.Sub s (greedyStep forbidden s next) := by
  classical
  intro k hk
  by_cases hCandidate : Feasible forbidden (fun k => s k ∨ k = next)
  · simpa [greedyStep, hCandidate] using (Or.inl hk : s k ∨ k = next)
  · simpa [greedyStep, hCandidate] using hk

theorem greedyStep_adds_if_feasible
    (forbidden : List Nat → Prop) (s : Nat → Prop) (next : Nat)
    (h : Feasible forbidden (fun k => s k ∨ k = next)) :
    greedyStep forbidden s next next := by
  classical
  simp [greedyStep, h]

/-- The greedy countable exhaustion tests EVERY particular once and
never discards an earlier retained particular. -/
noncomputable def stage (forbidden : List Nat → Prop) :
    Nat → (Nat → Prop)
  | 0 => fun _ => False
  | n + 1 => greedyStep forbidden (stage forbidden n) n

theorem stage_increasing
    (forbidden : List Nat → Prop) (n : Nat) :
    Snuffy.Book.UPTExistence.Sub (stage forbidden n) (stage forbidden (n + 1)) := by
  simpa only [stage] using
    greedyStep_extends forbidden (stage forbidden n) n

theorem stage_monotone
    (forbidden : List Nat → Prop) :
    ∀ n m, n ≤ m →
      Snuffy.Book.UPTExistence.Sub (stage forbidden n) (stage forbidden m) := by
  intro n m
  induction m with
  | zero =>
      intro h
      have hn : n = 0 := by omega
      subst n
      exact Snuffy.Book.UPTExistence.Sub.refl _
  | succ m ih =>
      intro h
      by_cases heq : n = m + 1
      · subst n
        exact Snuffy.Book.UPTExistence.Sub.refl _
      · have hm : n ≤ m := by omega
        exact Snuffy.Book.UPTExistence.Sub.trans
          (ih hm) (stage_increasing forbidden m)

theorem stage_feasible
    (forbidden : List Nat → Prop)
    (hEmpty : Feasible forbidden (fun _ => False)) :
    ∀ n, Feasible forbidden (stage forbidden n) := by
  intro n
  induction n with
  | zero => exact hEmpty
  | succ n ih =>
      change Feasible forbidden
        (greedyStep forbidden (stage forbidden n) n)
      exact greedyStep_preserves_feasible
        forbidden (stage forbidden n) n ih

/-- Unlike a finite-profile construction, this limit can retain
infinitely many particulars and is itself one *actual option* in the
full, unrestricted outcome type Nat → Prop. -/
def limit (forbidden : List Nat → Prop) (k : Nat) : Prop :=
  ∃ n, stage forbidden n k

/-- A finite forbidden pattern present in the limit would already be
present in a single stage. -/
theorem finite_stage_capture
    (forbidden : List Nat → Prop) :
    ∀ (xs : List Nat),
      (∀ k, k ∈ xs → limit forbidden k) →
      ∃ n, ∀ k, k ∈ xs → stage forbidden n k := by
  intro xs
  induction xs with
  | nil =>
      intro _
      exact ⟨0, by intro k hk; cases hk⟩
  | cons x xs ih =>
      intro hAll
      obtain ⟨nx, hx⟩ := hAll x List.mem_cons_self
      obtain ⟨ny, hy⟩ := ih (by
        intro k hk
        exact hAll k (List.mem_cons_of_mem x hk))
      refine ⟨max nx ny, ?_⟩
      intro k hk
      rcases List.mem_cons.mp hk with heq | hRest
      · subst k
        exact stage_monotone forbidden nx (max nx ny)
          (Nat.le_max_left _ _) x hx
      · exact stage_monotone forbidden ny (max nx ny)
          (Nat.le_max_right _ _) k (hy k hRest)

theorem limit_feasible
    (forbidden : List Nat → Prop)
    (hEmpty : Feasible forbidden (fun _ => False)) :
    Feasible forbidden (limit forbidden) := by
  intro pattern hForbid hAll
  obtain ⟨n, hn⟩ :=
    finite_stage_capture forbidden pattern
      (by intro k hk; exact hAll k hk)
  exact (stage_feasible forbidden hEmpty n
    pattern hForbid) hn

/-- Any feasible improvement that contains a missing particular k
makes it possible to add k at greedy stage k. The same original
feasibility predicate is used at each step and in the conclusion. -/
theorem cannot_feasibly_add_missing_particular
    (forbidden : List Nat → Prop)
    (k : Nat)
    (hCandidate :
      Feasible forbidden (fun j => limit forbidden j ∨ j = k)) :
    limit forbidden k := by
  have hSubset :
      Snuffy.Book.UPTExistence.Sub
        (fun j => stage forbidden k j ∨ j = k)
        (fun j => limit forbidden j ∨ j = k) := by
    intro j hj
    rcases hj with hs | heq
    · exact Or.inl ⟨k, hs⟩
    · exact Or.inr heq
  have hStageCandidate :=
    feasible_downward forbidden
      (fun j => limit forbidden j ∨ j = k)
      (fun j => stage forbidden k j ∨ j = k)
      hCandidate hSubset
  have hAdds := greedyStep_adds_if_feasible
    forbidden (stage forbidden k) k hStageCandidate
  exact ⟨k + 1, by simpa only [stage] using hAdds⟩

/-- The central result. For the ENTIRE potentially uncountable family
of feasible subsets of Nat, derive a globally maximal feasible option
in the ORIGINAL unmodified Snuffy.Book.UPTExistence.Aligned relation. Not a maximal
choice from a finite menu, finite-profile quotient or narrowed space. -/
theorem infinite_full_feasible_aligned_exists
    (forbidden : List Nat → Prop)
    (hEmpty : Feasible forbidden (fun _ => False)) :
    Snuffy.Book.UPTExistence.Aligned (Feasible forbidden)
      (fun s k => s k) (limit forbidden) := by
  refine ⟨limit_feasible forbidden hEmpty, ?_⟩
  intro other hOther hBetter
  have hBack : Snuffy.Book.UPTExistence.Sub other (limit forbidden) := by
    intro k hk
    by_cases hIn : limit forbidden k
    · exact hIn
    · have hCand :
          Feasible forbidden (fun j => limit forbidden j ∨ j = k) := by
        apply feasible_downward forbidden other
          (fun j => limit forbidden j ∨ j = k) hOther
        intro j hj
        rcases hj with hAlready | heq
        · exact hBetter.1 j hAlready
        · subst j
          exact hk
      exact False.elim (hIn
        (cannot_feasibly_add_missing_particular forbidden k hCand))
  exact hBetter.2 hBack

/-- The source's ORIGINAL lexicographic relation is used in the
one-priority-stage case. This does NOT assert all X3 priority stages. -/
theorem infinite_one_stage_lex_aligned_exists
    (forbidden : List Nat → Prop)
    (hEmpty : Feasible forbidden (fun _ => False)) :
    Snuffy.Book.UPTExistence.LexAlignedL (Feasible forbidden)
      ([fun (s : Nat → Prop) (k : Nat) => s k])
      (limit forbidden) := by
  have h := infinite_full_feasible_aligned_exists forbidden hEmpty
  refine ⟨h.1, ?_⟩
  intro other hOther hBetter
  change
    Snuffy.Book.UPTExistence.SSub (limit forbidden) other ∨
    (Snuffy.Book.UPTExistence.Equiv (limit forbidden) other ∧ False) at hBetter
  rcases hBetter with hStrict | ⟨_, hImpossible⟩
  · exact h.2 other hOther hStrict
  · exact hImpossible

/-- Structural limitation: if EVERY original finite-prefix outcome
is allowed under finite-obstruction feasibility, then the unbounded
full-retention limit is ALSO feasible. Thus the original
only-finite-prefix countermodel is not secretly covered by IR-66. -/
theorem all_prefixes_feasible_forces_full_retention
    (forbidden : List Nat → Prop)
    (hPrefixes : ∀ n, Feasible forbidden (Snuffy.Book.UPTExistence.chainKey n)) :
    Feasible forbidden (fun _ : Nat => True) := by
  intro pattern hForbidden _
  let n := IRFiniteProfileObstruction.aboveEvery pattern
  have hFits : ∀ k, k ∈ pattern → Snuffy.Book.UPTExistence.chainKey n k := by
    intro k hk
    exact Nat.le_of_lt
      (IRFiniteProfileObstruction.aboveEvery_gt_mem pattern k hk)
  exact (hPrefixes n pattern hForbidden) hFits

theorem original_chain_not_finitary_closed :
    ¬ ∃ forbidden : List Nat → Prop,
      (∀ n, Feasible forbidden (Snuffy.Book.UPTExistence.chainKey n)) ∧
      ¬ Feasible forbidden (fun _ : Nat => True) := by
  rintro ⟨forbidden, hPrefixes, hOmitFull⟩
  exact hOmitFull
    (all_prefixes_feasible_forces_full_retention forbidden hPrefixes)

/-- Nonvacuous infinite example: the two named particulars 0 and 1
cannot jointly be retained, but there is no finite upper bound on
other particulars. The full feasible outcome family is still used. -/
def incompatiblePair (pattern : List Nat) : Prop :=
  pattern = [0, 1]

theorem pair_empty_feasible :
    Feasible incompatiblePair (fun _ => False) := by
  intro pattern hPattern hAll
  change pattern = [0, 1] at hPattern
  subst pattern
  exact hAll 0 (by decide)

theorem pair_full_retention_infeasible :
    ¬ Feasible incompatiblePair (fun _ => True) := by
  intro hFull
  exact (hFull [0, 1] rfl) (by intro _ _; trivial)

/-- Every particular beyond the one incompatible pair belongs to the
maximal greedy retention set, giving a truly infinite positive instance
which is NOT just a top/full-retention feasible world. -/
theorem pair_all_unconflicted_retained
    (k : Nat) (hk : 2 ≤ k) :
    limit incompatiblePair k := by
  apply cannot_feasibly_add_missing_particular incompatiblePair k
  intro pattern hPattern hAll
  change pattern = [0, 1] at hPattern
  subst pattern
  have h0 : limit incompatiblePair 0 := by
    rcases hAll 0 (by decide) with h | heq
    · exact h
    · omega
  have h1 : limit incompatiblePair 1 := by
    rcases hAll 1 (by decide) with h | heq
    · exact h
    · omega
  have hLimit := limit_feasible incompatiblePair pair_empty_feasible
  exact (hLimit [0, 1] rfl) (by
    intro j hj
    have hj01 : j = 0 ∨ j = 1 := by
      simpa using hj
    rcases hj01 with heq | heq
    · subst j
      exact h0
    · subst j
      exact h1)

/-- A feasible maximal result has to leave at least one member of the
incompatible pair unretained: feasibility is real, not tautological. -/
theorem pair_cannot_keep_both :
    ¬ (limit incompatiblePair 0 ∧ limit incompatiblePair 1) := by
  intro hBoth
  have hLimit := limit_feasible incompatiblePair pair_empty_feasible
  exact (hLimit [0, 1] rfl) (by
    intro j hj
    have hj01 : j = 0 ∨ j = 1 := by
      simpa using hj
    rcases hj01 with heq | heq
    · subst j
      exact hBoth.1
    · subst j
      exact hBoth.2)

theorem nontrivial_infinite_full_feasible_instance :
    Snuffy.Book.UPTExistence.Aligned (Feasible incompatiblePair)
      (fun s k => s k) (limit incompatiblePair) ∧
    (∀ k, 2 ≤ k → limit incompatiblePair k) ∧
    ¬ (limit incompatiblePair 0 ∧ limit incompatiblePair 1) := by
  exact ⟨infinite_full_feasible_aligned_exists
      incompatiblePair pair_empty_feasible,
    pair_all_unconflicted_retained,
    pair_cannot_keep_both⟩



end PhysicalBridges.IRInfiniteFinitaryMaximality
