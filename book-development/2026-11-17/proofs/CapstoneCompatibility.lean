import Std

/-!
Compatibility lemmas for the user's three capstone arguments.

These are ordinary mathematical results about distinctions, orbits,
policy-independent invariants, and a finite chain boundary. They neither
replace Complete Koru nor define a weaker OriginalX3 proxy. In particular,
the finite examples test specific proposed mathematical inferences, not
the author's entire actual-world ontology.

The all-agent adapters retain their one-step certificate premises.
Existing LivingTreeFencedEffects supplies a concrete modeled instance.
No actual-world coverage, authentic consent, or divine property is minted
by this file.
-/

namespace Snuffy.BookWork.CapstoneCompatibility

universe u v w

/-- A partition distinction is symmetric. This does not assert symmetry
    or equality of arbitrary directed physical relations or weights. -/
theorem partition_distinction_is_symmetric
    {S : Type u} (side : S → Bool) (a b : S)
    (h : side a ≠ side b) : side b ≠ side a :=
  Ne.symm h

def flipPair {S : Type u} (p : S × S) : S × S := (p.2, p.1)

/-- An actual involution has a map and a twice-applied identity law. -/
theorem interchange_is_an_involution {S : Type u} (p : S × S) :
    flipPair (flipPair p) = p := by
  cases p
  rfl

def toggle : Bool → Bool
  | false => true
  | true => false

/-- Repetition and invertibility alone need not supply a fixed point. -/
theorem toggle_is_an_involution (b : Bool) : toggle (toggle b) = b := by
  cases b <;> rfl

theorem toggle_has_no_fixed_point (b : Bool) : toggle b ≠ b := by
  cases b <;> intro h <;> cases h

def orbit {S : Type u} (f : S → S) : Nat → S → S
  | 0 => id
  | n + 1 => fun x => f (orbit f n x)

/-- An injective update cannot carry a different state into a fixed state. -/
theorem iterates_avoid_a_different_fixed_point
    {S : Type u} (f : S → S) (hf : Function.Injective f)
    (g x : S) (hFixed : f g = g) (hDifferent : x ≠ g) :
    ∀ n, orbit f n x ≠ g := by
  intro n
  induction n with
  | zero => exact hDifferent
  | succ n ih =>
    intro h
    change f (orbit f n x) = g at h
    exact ih (hf (h.trans hFixed.symm))

/-- Strict one-step descent is strict descent from the original state at
    every positive iterate. The order is abstract, so this also applies to
    real metric distances without changing the theorem. -/
theorem strict_drop_along_orbit
    {S : Type u} {V : Type v}
    (f : S → S) (rank : S → V) (lt : V → V → Prop)
    (hTrans : ∀ {a b c}, lt a b → lt b c → lt a c)
    (x : S)
    (hDrop : ∀ n, lt (rank (orbit f (n + 1) x))
      (rank (orbit f n x))) :
    ∀ n, lt (rank (orbit f (n + 1) x)) (rank x) := by
  intro n
  induction n with
  | zero => exact hDrop 0
  | succ n ih => exact hTrans (hDrop (n + 1)) ih

/-- A positive exact return contradicts a strict drop at every step. -/
theorem exact_return_excludes_strict_drop
    {S : Type u} {V : Type v}
    (f : S → S) (rank : S → V) (lt : V → V → Prop)
    (hTrans : ∀ {a b c}, lt a b → lt b c → lt a c)
    (hIrrefl : ∀ a, ¬ lt a a)
    (x : S)
    (hDrop : ∀ n, lt (rank (orbit f (n + 1) x))
      (rank (orbit f n x)))
    (period : Nat) (hPositive : 0 < period)
    (hReturn : orbit f period x = x) : False := by
  cases period with
  | zero => exact Nat.lt_irrefl 0 hPositive
  | succ n =>
    have h := strict_drop_along_orbit f rank lt hTrans x hDrop n
    change lt (rank (orbit f (n + 1) x)) (rank x) at h
    rw [hReturn] at h
    exact hIrrefl (rank x) h

/-- If every state recurs exactly and the map is injective, a common
    fixed point with strict approach from every other state forces the
    entire configuration space to consist of that point.

    In a finite bijective metric model, exact recurrence follows by the
    pigeonhole argument; a strict Banach contraction gives the strict
    distance-to-fixed-point drop. These cannot describe one nontrivial
    whole-state dynamics simultaneously. -/
theorem recurrent_strict_attractor_forces_single_configuration
    {S : Type u} {V : Type v}
    (f : S → S) (rank : S → V) (lt : V → V → Prop)
    (hTrans : ∀ {a b c}, lt a b → lt b c → lt a c)
    (hIrrefl : ∀ a, ¬ lt a a)
    (hf : Function.Injective f)
    (hRecurs : ∀ x, ∃ n, 0 < n ∧ orbit f n x = x)
    (g : S) (hFixed : f g = g)
    (hApproach : ∀ x, x ≠ g → lt (rank (f x)) (rank x)) :
    ∀ x, x = g := by
  intro x
  apply Classical.byContradiction
  intro hDifferent
  have hAvoid := iterates_avoid_a_different_fixed_point
    f hf g x hFixed hDifferent
  have hDrop : ∀ n, lt (rank (orbit f (n + 1) x))
      (rank (orbit f n x)) :=
    fun n => hApproach (orbit f n x) (hAvoid n)
  obtain ⟨period, hPositive, hReturn⟩ := hRecurs x
  exact exact_return_excludes_strict_drop
    f rank lt hTrans hIrrefl x hDrop period hPositive hReturn

/-- A full retained history which strictly grows cannot return to the
    identical full state. A component may recur while the whole advances. -/
theorem strictly_growing_history_has_no_positive_period
    {S : Type u} (f : S → S) (historySize : S → Nat)
    (hGrow : ∀ x, historySize x < historySize (f x))
    (x : S) (period : Nat) (hPositive : 0 < period) :
    orbit f period x ≠ x := by
  intro hReturn
  apply exact_return_excludes_strict_drop
    f historySize (fun a b => b < a)
    (fun hab hbc => Nat.lt_trans hbc hab)
    (fun a => Nat.lt_irrefl a)
    x (fun n => hGrow (orbit f n x)) period hPositive hReturn

abbrev TriangleChain := Bool × Bool × Bool

/-- Mod-two boundary of edges 01, 12, 20 at the three vertices. -/
def chainBoundary (c : TriangleChain) : TriangleChain :=
  (Bool.xor c.1 c.2.2, Bool.xor c.1 c.2.1, Bool.xor c.2.1 c.2.2)

def ChainClosed (c : TriangleChain) : Prop :=
  chainBoundary c = (false, false, false)

def ContainsEdges (whole part : TriangleChain) : Prop :=
  (part.1 = true → whole.1 = true) ∧
  (part.2.1 = true → whole.2.1 = true) ∧
  (part.2.2 = true → whole.2.2 = true)

/-- Global closure does not imply that every internal subchain is closed.
    This tests the specific boundary inference in the Master Matrix;
    it is not asserted to model the full physical Koru. -/
theorem a_closed_whole_can_contain_an_open_part :
    ∃ whole part : TriangleChain,
      ChainClosed whole ∧ ContainsEdges whole part ∧ ¬ ChainClosed part := by
  refine ⟨(true, true, true), (true, false, false), rfl, ?_, ?_⟩
  · exact ⟨fun _ => rfl, fun _ => rfl, fun _ => rfl⟩
  · intro h
    change (true, true, false) = (false, false, false) at h
    have hFirst : (true : Bool) = false :=
      congrArg (fun p : TriangleChain => p.1) h
    cases hFirst

/-- Arbitrary agent identities and state-aware adaptive choices.
    An action may include an ordinary or a Genesis transition. -/
def policyRun {Agent : Type u} {S : Type v}
    (update : Agent → S → S) (policy : Nat → S → Agent)
    (initial : S) : Nat → S
  | 0 => initial
  | n + 1 =>
    let s := policyRun update policy initial n
    update (policy n s) s

/-- A shared invariant is independent of an agent's motives, type,
    intelligence, or policy, when the ACTUAL admitted update family has
    its independently established invariant preservation. -/
theorem every_agent_policy_preserves_the_same_invariant
    {Agent : Type u} {S : Type v}
    (update : Agent → S → S) (G : S → Prop)
    (hPreserves : ∀ a s, G s → G (update a s))
    (policy : Nat → S → Agent) (initial : S)
    (hInitial : G initial) :
    ∀ n, G (policyRun update policy initial n) := by
  intro n
  induction n with
  | zero => exact hInitial
  | succ n ih =>
    exact hPreserves
      (policy n (policyRun update policy initial n))
      (policyRun update policy initial n) ih

/-- A full one-step event certificate applies to every enacted step
    under every such policy. Instantiate certificate with the unchanged
    six-duty event proposition; no weakened proxy is defined here. -/
theorem every_agent_policy_carries_the_full_event_certificate
    {Agent : Type u} {S : Type v}
    (update : Agent → S → S) (certificate : S → S → Prop)
    (hCertificate : ∀ a s, certificate s (update a s))
    (policy : Nat → S → Agent) (initial : S) :
    ∀ n, certificate (policyRun update policy initial n)
      (policyRun update policy initial (n + 1)) := by
  intro n
  exact hCertificate
    (policy n (policyRun update policy initial n))
    (policyRun update policy initial n)

/-- One independently established unique anchor fixed point, together with
    commutation with that anchor, DERIVES a unique common fixed point for
    the entire arbitrarily indexed agent-update family. Common G is a
    conclusion here, not a separately supplied pointwise premise. -/
theorem a_unique_anchor_and_commutation_derive_common_G
    {Agent : Type u} {S : Type v}
    (update : Agent → S → S) (anchor : Agent)
    (hAnchor : ∃ g, update anchor g = g ∧
      ∀ other, update anchor other = other → other = g)
    (hCommutes : ∀ a x,
      update anchor (update a x) = update a (update anchor x)) :
    ∃ g, (∀ a, update a g = g) ∧
      ∀ other, (∀ a, update a other = other) → other = g := by
  obtain ⟨g, hFixed, hUnique⟩ := hAnchor
  refine ⟨g, ?_, ?_⟩
  · intro a
    apply hUnique (update a g)
    calc
      update anchor (update a g) = update a (update anchor g) :=
        hCommutes a g
      _ = update a g := congrArg (update a) hFixed
  · intro other hOther
    exact hUnique other (hOther anchor)

def privateConstantUpdate (agent : Bool) (_state : Bool) : Bool := agent

/-- Even constant maps (contractions with constant zero on any metric)
    can have different private fixed points. Individual fixed-point
    existence alone is insufficient for one shared all-agent G. -/
theorem separate_unique_fixed_points_need_not_be_shared :
    (∀ a : Bool, ∃ g, privateConstantUpdate a g = g ∧
      ∀ other, privateConstantUpdate a other = other → other = g) ∧
    ¬ (∃ g : Bool, ∀ a : Bool, privateConstantUpdate a g = g) := by
  constructor
  · intro a
    exact ⟨a, rfl, fun other hOther => hOther.symm⟩
  · intro h
    obtain ⟨g, hAll⟩ := h
    have hFalse : false = g := hAll false
    have hTrue : true = g := hAll true
    have hBad : (false : Bool) = true := hFalse.trans hTrue.symm
    cases hBad


#print axioms partition_distinction_is_symmetric
#print axioms interchange_is_an_involution
#print axioms toggle_is_an_involution
#print axioms toggle_has_no_fixed_point
#print axioms iterates_avoid_a_different_fixed_point
#print axioms strict_drop_along_orbit
#print axioms exact_return_excludes_strict_drop
#print axioms recurrent_strict_attractor_forces_single_configuration
#print axioms strictly_growing_history_has_no_positive_period
#print axioms a_closed_whole_can_contain_an_open_part
#print axioms every_agent_policy_preserves_the_same_invariant
#print axioms every_agent_policy_carries_the_full_event_certificate
#print axioms a_unique_anchor_and_commutation_derive_common_G
#print axioms separate_unique_fixed_points_need_not_be_shared

end Snuffy.BookWork.CapstoneCompatibility

