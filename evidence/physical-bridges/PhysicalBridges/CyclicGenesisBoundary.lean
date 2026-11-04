import PhysicalBridges.CyclicGenesisInterior

/-!
# Cyclic genesis — II. The boundary is genesis, not reversal

Second stone. The heat-death boundary (arrow-maximum `M`) is crossed by **genesis**: a
*forward*, *orientation-preserving*, *causal-order-advancing* map to the next epoch's
beginning — never a reversal, never a loop, never a mirror. Per the spec's three distinct
conditions (Tenzing #291), each is proved separately, and a mirror crossing is exhibited as a
rejected positive control.

State `(epoch, localRank, orientation)`; global causal rank `epoch·(M+1) + localRank`. Within an
epoch `localRank` rises to the terminus `M`; genesis `(e, M, o) → (e+1, 0, o)` resets the
entropy-like `localRank` **yet advances the global causal rank** and **carries orientation
forward**. Continuation ("no final protected stage") comes from *chaining* epochs — a
sufficient, not necessary, route (cf. `CathedralSummitPremiseNecessity`) — never from interior
recurrence.

Scope (spec §9): model-internal; no cosmology claim; no canon; no release.
-/
namespace PhysicalBridges.CyclicGenesisBoundary

/-- Interior state: epoch, local (entropy-like) rank, and an orientation (handedness). -/
abbrev St := Nat × Nat × Bool

@[simp] def epoch (s : St) : Nat := s.1
@[simp] def localRank (s : St) : Nat := s.2.1
@[simp] def orient (s : St) : Bool := s.2.2

variable (M : Nat)

/-- Global causal order (Tenzing #291: a distinct condition). Strictly advanced by every
permitted event, including the epoch crossing. -/
@[simp] def globalCausal (s : St) : Nat := epoch s * (M + 1) + localRank s

/-- The terminus = heat death = the arrow-maximum within an epoch. -/
@[simp] def isTerminus (s : St) : Prop := localRank s = M

/-- Within-epoch forward step: the entropy-like rank rises by one, below the terminus. -/
@[simp] def localStep (s t : St) : Prop := localRank s < M ∧ t = (epoch s, localRank s + 1, orient s)

/-- **Genesis**: the boundary crossing. From the terminus to the next epoch's beginning —
orientation preserved. -/
@[simp] def genesis (s t : St) : Prop := localRank s = M ∧ t = (epoch s + 1, 0, orient s)

/-- A **mirror** crossing — identical except it flips orientation. The rejected control. -/
@[simp] def mirror (s t : St) : Prop := localRank s = M ∧ t = (epoch s + 1, 0, !orient s)

/-- A permitted event: an interior step or a genesis crossing. -/
@[simp] def step (s t : St) : Prop := localStep M s t ∨ genesis M s t

/-! ## Condition 1 — causal direction (every event advances the global order) -/

/-- Every permitted event strictly advances the global causal rank — interior steps and the
genesis crossing alike. -/
theorem step_advances_causal : ∀ s t : St, step M s t → globalCausal M s < globalCausal M t := by
  rintro s t (⟨hlt, rfl⟩ | ⟨hterm, rfl⟩)
  · simp only [globalCausal, epoch, localRank] at hlt ⊢; omega
  · simp only [globalCausal, epoch, localRank] at hterm ⊢
    have hexp : (s.1 + 1) * (M + 1) = s.1 * (M + 1) + (M + 1) := by
      rw [Nat.add_mul, Nat.one_mul]
    omega

/-- **`genesis_advances_causal_order`**: the crossing is a *forward successor*, not a loop — it
strictly advances the global causal rank even though it resets the entropy-like `localRank`. -/
theorem genesis_advances_causal_order (s t : St) (h : genesis M s t) :
    globalCausal M s < globalCausal M t :=
  step_advances_causal M s t (Or.inr h)

/-- **`genesis_is_forward`**: genesis never lands causally earlier — it is provably not a
`terminus → earlier` map. (Immediate from the strict advance.) -/
theorem genesis_is_forward (s t : St) (h : genesis M s t) :
    ¬ globalCausal M t ≤ globalCausal M s := by
  have := genesis_advances_causal_order M s t h; omega

/-! ## Condition 2 — spatial handedness (orientation preserved; mirror rejected) -/

/-- **`genesis_preserves_handedness`**: the crossing keeps the chosen orientation. -/
theorem genesis_preserves_handedness (s t : St) (h : genesis M s t) : orient t = orient s := by
  obtain ⟨_, rfl⟩ := h; rfl

/-- POSITIVE CONTROL — **`mirror_flips_handedness`**: a mirror crossing *reverses* orientation. -/
theorem mirror_flips_handedness (s t : St) (h : mirror M s t) : orient t = !orient s := by
  obtain ⟨_, rfl⟩ := h; rfl

/-- …so genesis and mirror are **distinguishable**: they can never agree on the same successor.
The handedness guardrail discriminates — a mirror is not read as a genesis. -/
theorem genesis_ne_mirror (s t : St) (hg : genesis M s t) (hm : mirror M s t) : False := by
  have h1 := genesis_preserves_handedness M s t hg
  have h2 := mirror_flips_handedness M s t hm
  rw [h1] at h2
  cases orient s <;> simp_all

/-! ## Condition 3 — nothing lost; continuation by chaining -/

/-- **`nothing_lost_forward`**: the carried invariant (here the orientation/handedness) survives
the crossing unchanged — conservation realized as forward-carry, not undoing. -/
theorem nothing_lost_forward (s t : St) (h : genesis M s t) : orient t = orient s :=
  genesis_preserves_handedness M s t h

/-- **`continuation_by_chaining`**: no final protected stage. For any orientation `o` and any
causal horizon `N`, there is a later state (at the beginning of a sufficiently distant epoch)
with the same orientation. Secured by *chaining* epochs — the global causal rank grows without
bound — **not** by interior recurrence. A sufficient, not necessary, route to continuation
(cf. `CathedralSummitPremiseNecessity`: cyclicity is sufficient-not-necessary). -/
theorem continuation_by_chaining (o : Bool) :
    ∀ N : Nat, ∃ s : St, N ≤ globalCausal M s ∧ orient s = o := by
  intro N
  refine ⟨(N, 0, o), ?_, rfl⟩
  simp only [globalCausal, epoch, localRank]
  have : N ≤ N * (M + 1) := Nat.le_mul_of_pos_right N (by omega)
  omega

/-! ## Tie to stone I — the genesis cosmos is a lawful interior (no backward time) -/

/-- The chained-genesis cosmos *is* a lawful `Interior` (stone I): its rank is the global causal
order, strictly advanced by every event. Hence `no_backward_time` applies to it — the whole
cyclic structure contains no interior rewind. -/
def chainedCosmos : CyclicGenesisInterior.Interior where
  Position := St
  step := step M
  rank := globalCausal M
  lawful := step_advances_causal M

/-- The cyclic cosmos has no interior backward step — genesis and all — by stone I. -/
theorem cosmos_has_no_backward_time (a b : St) :
    step M a b → ¬ step M b a :=
  CyclicGenesisInterior.no_backward_time (chainedCosmos M) a b

end PhysicalBridges.CyclicGenesisBoundary
