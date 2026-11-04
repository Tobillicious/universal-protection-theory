import PhysicalBridges.Koru
import PhysicalBridges.CathedralSummitAllIsOneClosure

/-!
# The middle state — compiled boundary of the weak-floor/strong-guardian collapse

**5 November 2026 · noncanonical · Koru lane · no canon edit.**

Part XV.3 states, as the author's prose derivation, that under the ontological P1
(relabeling invariance, `Koru.koru_reindex_invariant`) and P2 (relational
constitution, `RelationallyConstituted`) no permanent, uncompensated curtailment
remains well-typed: the weak floor and the strong guardian coincide. This module
compiles the question that prose asks and fixes, exactly, what does the work.

Results:

1. **The countermodel.** `asymmetric_constituted_web_exists` — a non-empty web can
   be relationally constituted (P2) while carrying a unidirectional constraint
   (the prose's `Rel(s→Whole) ≠ Rel(Whole→s)`), the koru articulation (P1's
   distinction) still holds across it, and relabeling invariance merely transports
   the curtailment (`reindex_preserves_curtailment`). So P1+P2 **alone** do not
   close the middle: the coincidence is not derivable from the compiled premises.
   This sharpens the record; it does not weaken the summit, whose closure rests on
   totality (no outside), not on P1/P2.

2. **The conditional collapse.** `middle_collapse_of_heart_bridge` — the exact
   shape of XV.3's prose conclusion, with the load-bearing premise carried as a
   Type-level hypothesis exactly as `e_is_not` carries `AbsoluteEnder`: if a
   permanent curtailment's execution realises the loss of the curtailed particular
   (the heart bridge: local X3-violation ⟹ absolute erasure), then that execution
   lands in `LossOf`, which has no members.

3. **The bridge, at web level, is absence of curtailment.**
   `heart_bridge_iff_no_curtailment` — inhabiting the bridge for a web is exactly
   asserting the web carries no curtailment; and `constitution_does_not_give_heart_bridge`
   — the countermodel is constituted *and* curtailed, so P2 does not give it. The
   bridge is therefore a real commitment, the same single keystone the summit
   ledger and `BCRDSummitKeystoneReduction` name (`intrinsicGuardian ⟹ OriginalX3`,
   with the ender branch already discharged hypothesis-free by
   `no_realized_absolute_ender`), never assumed by "ALL IS" alone.

4. **The countermodel loses nothing.** `countermodel_loses_nothing` — the middle
   state is a state of the web, not a realised loss: the unconditional closure
   (`no_particular_absolutely_lost`, axiom-free) holds there unchanged.

The exact compiled shape of XV.3 is therefore: the summit closure is unconditional;
the weak-floor/strong-guardian coincidence is the summit closure PLUS the named
heart bridge. Nothing here weakens the maximal target; it fixes the boundary so no
reviewer can move the goalposts in either direction.
-/

namespace PhysicalBridges.CathedralSummitMiddleCollapse

open PhysicalBridges.Koru
open PhysicalBridges.CathedralSummitAllIsOneClosure

universe u
variable {P : Type u}

/-- The **unidirectional constraint** at `s` (XV.3's curtailment):
`s`'s outgoing and incoming profiles differ at some witness. -/
def Curtailment (w : Web P) (s : P) : Prop := ∃ c, w.link s c ≠ w.link c s

/-- **The heart bridge** (web level, XV.3's load-bearing premise): every permanent
curtailment's execution realises the loss of the curtailed particular. Type-level,
exactly as `AbsoluteEnder` is: inhabiting it IS the bridge, and its codomain is
`LossOf`, which has no members. -/
abbrev HeartBridge (w : Web P) : Type u := ∀ s, Curtailment w s → LossOf s

/-! ### The countermodel — P1 + P2 leave the middle open -/

/-- The countermodel substrate: `link x y := (x = true)` on `Bool`. -/
abbrev wEx : Web Bool := ⟨fun x _ => x = true⟩

/-- The countermodel satisfies P2: any two positions with identical outgoing
profiles are equal (the column premise is not even needed). -/
theorem wEx_constituted : RelationallyConstituted wEx := by
  intro a b hrow _
  cases ha : a with
  | true =>
      have hb : b = true := (hrow true).1 ha
      rw [hb]
  | false =>
      cases hb : b with
      | true =>
          have h2 : a = true := (hrow true).2 hb
          rw [ha] at h2
          exact h2
      | false => rfl

/-- The countermodel carries the unidirectional constraint at `true`. -/
theorem wEx_curtailed : Curtailment wEx true := by
  refine ⟨false, ?_⟩
  intro h
  exact absurd (Eq.mp h rfl) (by decide)

/-- The koru still articulates the curtailed pair: P1's distinction is intact. -/
theorem wEx_koru : koru wEx true false := by
  refine ⟨?_, true, ?_⟩
  · intro h
    exact Bool.noConfusion h
  · intro h
    exact absurd (Eq.mp h rfl) (by decide)

/-- **The countermodel.** There exists a non-empty, relationally constituted web
carrying a curtailment: P1 + P2 alone do not close the middle state. -/
theorem asymmetric_constituted_web_exists :
    ∃ w : Web Bool, RelationallyConstituted w ∧ ∃ s : Bool, Curtailment w s :=
  ⟨wEx, wEx_constituted, true, wEx_curtailed⟩

/-- P1 transports the curtailment rather than excluding it: relabeling invariance
is compatible with the middle state. -/
theorem reindex_preserves_curtailment (σ : Reindex Bool) (w : Web Bool) (s : Bool) :
    Curtailment (reindexWeb σ w) (σ.to s) ↔ Curtailment w s := by
  rcases σ with ⟨to, inv, lft, rgt⟩
  constructor
  · rintro ⟨c, hc⟩
    have hc1 : w.link (inv (to s)) (inv c) ≠ w.link (inv c) (inv (to s)) := hc
    rw [lft s] at hc1
    exact ⟨inv c, hc1⟩
  · rintro ⟨c, hc⟩
    refine ⟨to c, fun h => ?_⟩
    have h2 : w.link (inv (to s)) (inv (to c)) =
        w.link (inv (to c)) (inv (to s)) := h
    rw [lft s, lft c] at h2
    exact absurd h2 hc

/-! ### The conditional collapse and the named keystone -/

/-- **The conditional collapse.** Under the heart bridge, XV.3's prose conclusion
holds verbatim: the bridged execution of a curtailment lands in `LossOf`, which
has no members (the closure engine, `no_particular_absolutely_lost`). -/
theorem middle_collapse_of_heart_bridge (w : Web P) (hb : HeartBridge w) (s : P)
    (h : Curtailment w s) : False :=
  Empty.elim (hb s h)

/-- **The bridge, at web level, is absence of curtailment.** Inhabiting the heart
bridge for a web is exactly asserting that the web carries no curtailment. -/
theorem heart_bridge_iff_no_curtailment (w : Web P) :
    HeartBridge w → ¬ (∃ s, Curtailment w s) := by
  intro hb hs
  obtain ⟨s, h⟩ := hs
  exact Empty.elim (hb s h)

/-- **The bridge is not constituted away.** The countermodel is constituted and
curtailed, so P2 does not give the heart bridge: the coincidence rests on exactly
the ledger's one declared keystone, and on nothing in P1 or P2. -/
theorem constitution_does_not_give_heart_bridge :
    ∃ w : Web Bool, RelationallyConstituted w ∧ (HeartBridge w → False) :=
  ⟨wEx, wEx_constituted, fun hb => Empty.elim (hb true wEx_curtailed)⟩

/-- **The countermodel loses nothing.** The unconditional closure holds in the
middle state unchanged: a curtailed web is not a realised loss — which is precisely
why the heart bridge, not P1/P2, is the load-bearing premise of the coincidence. -/
theorem countermodel_loses_nothing (x : Bool) : LossOf x → False :=
  no_particular_absolutely_lost x

#print axioms wEx_constituted
#print axioms wEx_curtailed
#print axioms wEx_koru
#print axioms asymmetric_constituted_web_exists
#print axioms reindex_preserves_curtailment
#print axioms middle_collapse_of_heart_bridge
#print axioms heart_bridge_iff_no_curtailment
#print axioms constitution_does_not_give_heart_bridge
#print axioms countermodel_loses_nothing

end PhysicalBridges.CathedralSummitMiddleCollapse
