/-
IR-73: temporal finite-prefix refutation is NOT automatically IR-70's
static finite-retained-facts forcing-witness criterion.

We prove a robust finite-prefix refutation of (1) pointwise physical
threshold safety and (2) bounded service deadlines on infinite traces.
We prove an explicit non-refutable unbounded eventual-service condition
with no completed response, although every finite prefix admits a
completed, service-delivering extension.

These results are about exact predicates on modeled traces, NOT a
physical derivation of clock accuracy, actual service, full X3
continuation, or archived nine-route coverage.

The source-level finite prefix is an observation of complete true
trace states. Application to real sensors needs independent sound and
complete physical observation/refinement.
-/
import PhysicalBridges.IRInfiniteHistoryCompactness

namespace PhysicalBridges.IRBoundedTemporalRefutation

abbrev History := Nat → Bool × Bool

def request (h : History) (n : Nat) : Bool := (h n).1
def served (h : History) (n : Nat) : Bool := (h n).2

/-- Two histories agree on ALL actual states before tick limit. This
is not a statement that their sensor logs look the same. -/
def PrefixEq (limit : Nat) (h h' : History) : Prop :=
  ∀ k, k < limit → h k = h' k

def FinitePrefixRefutations (F : History → Prop) : Prop :=
  ∀ h, ¬ F h →
    ∃ limit, ∀ h', PrefixEq limit h h' → ¬ F h'

/-- Bounded response: for every request at tick k, there must
be at least one actual service at some j in [k,k+deadline].
This definition does not yet bind requests to recipient identities,
unique receipts, historical continuation or service adequacy. -/
def BoundedResponse (deadline : Nat) (h : History) : Prop :=
  ∀ k, request h k = true →
    ∃ j, k ≤ j ∧ j ≤ k + deadline ∧ served h j = true

def EventualResponse (h : History) : Prop :=
  ∀ k, request h k = true →
    ∃ j, k ≤ j ∧ served h j = true

/-- A missed guaranteed finite deadline has a finite forcing witness:
every alternative true history matching the prefix THROUGH the
deadline will miss exactly that same request. -/
theorem bounded_response_has_finite_prefix_refutations
    (deadline : Nat) :
    FinitePrefixRefutations (BoundedResponse deadline) := by
  intro h hNot
  have ex :
      ∃ k, request h k = true ∧
        ¬ (∃ j, k ≤ j ∧ j ≤ k + deadline ∧ served h j = true) := by
    apply Classical.byContradiction
    intro hNone
    apply hNot
    intro k hk
    apply Classical.byContradiction
    intro hNoService
    exact hNone ⟨k,hk,hNoService⟩
  obtain ⟨k,hRequested,hMissing⟩ := ex
  refine ⟨k + deadline + 1, ?_⟩
  intro other hPrefix hOther
  have hk : h k = other k := hPrefix k (by omega)
  have hRequestOther : request other k = true := by
    simpa [request, hk] using hRequested
  obtain ⟨j,hStart,hEnd,hServed⟩ :=
    hOther k hRequestOther
  have hj : h j = other j := hPrefix j (by omega)
  have hServedOriginal : served h j = true := by
    simpa [served, hj] using hServed
  exact hMissing ⟨j,hStart,hEnd,hServedOriginal⟩

/-- An actual threshold violation at a finite tick is a finite
prefix refutation. The bound on physical descent is irrelevant to
the logical existence of this witness. -/
def ThresholdSafe (minimum : Nat) (v : Nat → Nat) : Prop :=
  ∀ n, minimum ≤ v n

def NumericPrefixEq (limit : Nat) (v w : Nat → Nat) : Prop :=
  ∀ n, n < limit → v n = w n

theorem threshold_failure_is_finite_prefix_refutation
    (minimum : Nat) (v : Nat → Nat)
    (hBad : ¬ ThresholdSafe minimum v) :
    ∃ limit, ∀ w : Nat → Nat,
      NumericPrefixEq limit v w →
      ¬ ThresholdSafe minimum w := by
  have hEx : ∃ k, ¬ minimum ≤ v k := by
    apply Classical.byContradiction
    intro hNone
    apply hBad
    intro n
    apply Classical.byContradiction
    intro hn
    exact hNone ⟨n,hn⟩
  obtain ⟨k,hFail⟩ := hEx
  refine ⟨k+1,?_⟩
  intro w hp hw
  have heq := hp k (by omega)
  have hSafe : minimum ≤ v k := by
    rw [heq]
    exact hw k
  exact hFail hSafe

/-- One genuine request at tick zero; no service ever occurs. -/
def neverServed : History :=
  fun n => (decide (n = 0), false)

theorem never_served_fails_eventual :
    ¬ EventualResponse neverServed := by
  intro h
  have hRequest : request neverServed 0 = true := by decide
  obtain ⟨j,_,hServed⟩ := h 0 hRequest
  have hNo : served neverServed j = false := by
    rfl
  rw [hNo] at hServed
  cases hServed

/-- After any claimed finite observation cutoff, construct a NEW
history that matches the original prefix exactly, but actually
delivers a response after that cutoff. -/
def servicedAfter (cutoff : Nat) : History :=
  fun n => (decide (n = 0), decide (cutoff ≤ n))

theorem serviced_after_matches_prefix (cutoff : Nat) :
    PrefixEq cutoff neverServed (servicedAfter cutoff) := by
  intro n hn
  have hNo : ¬ cutoff ≤ n := by omega
  simp [neverServed,servicedAfter,hNo]

theorem serviced_after_is_eventual (cutoff : Nat) :
    EventualResponse (servicedAfter cutoff) := by
  intro k hRequested
  have hk : k = 0 := by
    by_cases heq : k = 0
    · exact heq
    · have hFalse : request (servicedAfter cutoff) k = false := by
        simp [request,servicedAfter,heq]
      rw [hFalse] at hRequested
      cases hRequested
  subst k
  refine ⟨cutoff,Nat.zero_le _,?_⟩
  simp [served,servicedAfter]

/-- Unbounded eventual response fails at a history for which
EVERY finite prefix admits a repaired, genuinely responsive
continuation. There is no finite forcing refutation of the missing
service. No generic 'bounded drift' premise supplies the deadline. -/
theorem unbounded_eventual_service_is_not_finitely_refutable :
    ¬ FinitePrefixRefutations EventualResponse := by
  intro hFinite
  obtain ⟨limit,hEvery⟩ :=
    hFinite neverServed never_served_fails_eventual
  exact (hEvery (servicedAfter limit)
    (serviced_after_matches_prefix limit))
      (serviced_after_is_eventual limit)

/-- Bounded response logically implies eventual response.
The converse is false without a global finite deadline. -/
theorem bounded_response_implies_eventual
    (deadline : Nat) (h : History)
    (hBounded : BoundedResponse deadline h) :
    EventualResponse h := by
  intro k hRequested
  obtain ⟨j,hStart,_,hServed⟩ := hBounded k hRequested
  exact ⟨j,hStart,hServed⟩

/-- For any fixed deadline d, serve for the first time at tick d+1.
Eventual service is achieved but the finite deadline is missed.
This is a concrete scheduling counterexample to equating liveness
with latency certification. -/
theorem eventual_service_does_not_imply_fixed_deadline
    (deadline : Nat) :
    ∃ h : History,
      EventualResponse h ∧ ¬ BoundedResponse deadline h := by
  refine ⟨servicedAfter (deadline+1),
    serviced_after_is_eventual _, ?_⟩
  intro hBounded
  have hr : request (servicedAfter (deadline+1)) 0 = true := by
    simp [request, servicedAfter]
  obtain ⟨j,hStart,hEnd,hs⟩ := hBounded 0 hr
  have hActual : deadline+1 ≤ j := by
    have : decide (deadline+1 ≤ j) = true := by
      simpa [served,servicedAfter] using hs
    simpa using this
  omega

#print axioms bounded_response_has_finite_prefix_refutations
#print axioms threshold_failure_is_finite_prefix_refutation
#print axioms never_served_fails_eventual
#print axioms serviced_after_matches_prefix
#print axioms serviced_after_is_eventual
#print axioms unbounded_eventual_service_is_not_finitely_refutable
#print axioms bounded_response_implies_eventual
#print axioms eventual_service_does_not_imply_fixed_deadline

end PhysicalBridges.IRBoundedTemporalRefutation
