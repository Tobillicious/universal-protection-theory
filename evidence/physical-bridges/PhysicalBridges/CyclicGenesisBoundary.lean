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

/-! ## Condition 3a — what the crossing carries, and what it does NOT

(Honesty refinement, Tenzing #292 post-merge review: do not let "nothing lost" be read as
"everything of a particular is conserved." Genesis carries *handedness*; it does **not** carry
the entropy-like component — that resets. Full conservation of a particular is the open B.4
provenance obligation, never implied here.) -/

/-- **`handedness_carried_forward`** (formerly over-named `nothing_lost_forward`): the
orientation / handedness — **one** invariant — survives the crossing unchanged. -/
theorem handedness_carried_forward (s t : St) (h : genesis M s t) : orient t = orient s :=
  genesis_preserves_handedness M s t h

/-- Genesis provably **resets** the entropy-like `localRank` (`M → 0`). -/
theorem genesis_resets_localRank (s t : St) (h : genesis M s t) :
    localRank t = 0 ∧ localRank s = M := by
  obtain ⟨hterm, rfl⟩ := h
  exact ⟨rfl, hterm⟩

/-- **The honest distinction, as a theorem.** Carrying handedness is NOT conserving everything:
there is a genesis crossing that preserves orientation yet does **not** preserve the entropy-like
component. So `handedness_carried_forward` must never be read as full conservation of a
particular (that is B.4 provenance, still open). -/
theorem handedness_carry_is_not_full_conservation :
    ∃ (m : Nat) (s t : St),
      genesis m s t ∧ orient t = orient s ∧ localRank t ≠ localRank s := by
  exact ⟨1, (0, 1, true), (1, 0, true), ⟨rfl, rfl⟩, rfl, by decide⟩

/-! ## Condition 3b — continuation, as reachable forward journeys

(Strengthening, Tenzing #292: prove forward continuation is *reachable* from **every** valid
starting state — a forward path — not merely that arbitrarily-late states exist.) -/

/-- Reachability: the reflexive–transitive closure of `step`. Forward journeys only — by
`cosmos_has_no_backward_time`, none of its steps is a rewind. -/
inductive Reaches (m : Nat) : St → St → Prop
  | refl (s : St) : Reaches m s s
  | step {s t u : St} : step m s t → Reaches m t u → Reaches m s u

/-- Reachability composes. -/
theorem reach_trans {m : Nat} {a b c : St}
    (h1 : Reaches m a b) (h2 : Reaches m b c) : Reaches m a c := by
  induction h1 with
  | refl => exact h2
  | step hst _ ih => exact Reaches.step hst (ih h2)

/-- From any state below (or at) the terminus, the terminus of the same epoch is reachable by
within-epoch steps. -/
theorem reach_to_terminus :
    ∀ (d e l : Nat) (o : Bool), l + d = M → Reaches M (e, l, o) (e, M, o) := by
  intro d
  induction d with
  | zero =>
      intro e l o h
      have : l = M := by omega
      subst this; exact Reaches.refl _
  | succ d ih =>
      intro e l o h
      have hlt : l < M := by omega
      have hstep : step M (e, l, o) (e, l + 1, o) := Or.inl ⟨hlt, rfl⟩
      exact Reaches.step hstep (ih e (l + 1) o (by omega))

/-- From any valid state, the **next epoch's beginning** is reachable: climb to the terminus,
then cross by genesis. -/
theorem reach_next_epoch (e l : Nat) (o : Bool) (hl : l ≤ M) :
    Reaches M (e, l, o) (e + 1, 0, o) := by
  refine reach_trans (reach_to_terminus M (M - l) e l o (by omega)) ?_
  exact Reaches.step (Or.inr ⟨rfl, rfl⟩) (Reaches.refl _)

/-- Any later epoch's beginning is reachable from the start of an epoch. -/
theorem reach_future_epoch (o : Bool) : ∀ (k e : Nat), Reaches M (e, 0, o) (e + k, 0, o) := by
  intro k
  induction k with
  | zero => intro e; exact Reaches.refl _
  | succ k ih =>
      intro e
      refine reach_trans (reach_next_epoch M e 0 o (Nat.zero_le _)) ?_
      have := ih (e + 1)
      simpa [Nat.add_right_comm, Nat.add_assoc] using this

/-- **`reachable_forward_continuation`** (the stronger continuation): from **every** valid
starting state `(e, l, o)` (with `l ≤ M`) and every causal horizon `N`, a protected later state
is **reachable** by a forward journey — same orientation, global causal rank at least `N`. No
final protected stage, secured by reachable chaining; never by interior recurrence. -/
theorem reachable_forward_continuation (e l : Nat) (o : Bool) (hl : l ≤ M) :
    ∀ N : Nat, ∃ t : St, Reaches M (e, l, o) t ∧ N ≤ globalCausal M t ∧ orient t = o := by
  intro N
  refine ⟨(e + 1 + N, 0, o), ?_, ?_, rfl⟩
  · exact reach_trans (reach_next_epoch M e l o hl) (reach_future_epoch M o N (e + 1))
  · simp only [globalCausal, epoch, localRank]
    have h1 : N ≤ e + 1 + N := by omega
    have h2 : e + 1 + N ≤ (e + 1 + N) * (M + 1) := Nat.le_mul_of_pos_right _ (by omega)
    omega

/-- **`continuation_by_chaining`** (existence form, retained): for any orientation and horizon a
later protected state exists. Now a corollary of the reachable form. -/
theorem continuation_by_chaining (o : Bool) :
    ∀ N : Nat, ∃ s : St, N ≤ globalCausal M s ∧ orient s = o := by
  intro N
  obtain ⟨t, _, hge, ho⟩ := reachable_forward_continuation M 0 0 o (Nat.zero_le _) N
  exact ⟨t, hge, ho⟩

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
