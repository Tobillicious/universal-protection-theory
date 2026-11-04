import PhysicalBridges.CathedralIntrinsicArticulation
import PhysicalBridges.Koru

/-!
# Original Koru / Cathedral precise join — 2:34 summit reconstruction

Joins the unchanged original #245 Cathedral relational web to #264's
conservative Koru operator. No new primitive, physical premise, or X3 atom.

This is a *positive* theorem about genuine distinct positions within ONE
intrinsic, relationally individuated actuality, not an attempt to replace
the six-component source→subject keystone (#290).
-/

namespace PhysicalBridges.OriginalKoruSummitJoin

universe u
variable {P : Type u}

/-- The original relational datum stays exactly the same across the
original Cathedral and the Koru formulations. -/
def asKoruWeb (w : CathedralIntrinsicArticulation.Web P) : Koru.Web P :=
  { link := w.link }

/-- In an individuated one-web actuality the Koru articulates *every*
genuinely distinct pair, and never collapses a pair into equality.
The discriminating profile is derived from individuation, not assumed. -/
theorem koru_iff_genuine_distinction
    (w : CathedralIntrinsicArticulation.Web P)
    (hw : CathedralIntrinsicArticulation.RelationallyIndividuated w)
    (a b : P) :
    Koru.koru (asKoruWeb w) a b ↔ a ≠ b := by
  constructor
  · intro h
    exact h.1
  · intro hne
    classical
    have hDisc : ∃ c : P, w.link a c ≠ w.link b c := by
      by_contra hAbs
      have hProfile : ∀ c : P, w.link a c ↔ w.link b c := by
        intro c
        by_contra hFail
        apply hAbs
        refine ⟨c, ?_⟩
        intro hEq
        apply hFail
        simpa [hEq]
      exact hne (hw a b hProfile)
    exact ⟨hne, hDisc⟩

/-- Same structural role is compatible with genuinely distinct positions,
and both positions are Koru-articulated in the one rootless web.
No particular is erased, identified with another, or privileged. -/
theorem same_role_koru_noncollapse :
    (false ≠ true) ∧
    CathedralIntrinsicArticulation.SameRole
      (CathedralIntrinsicArticulation.distinctWeb Bool) false true ∧
    Koru.koru (asKoruWeb (CathedralIntrinsicArticulation.distinctWeb Bool))
      false true := by
  refine ⟨by decide, ?_, ?_⟩
  · exact
      (CathedralIntrinsicArticulation.distinct_yet_same_role_in_one_web).2.1
  · exact
      (koru_iff_genuine_distinction
        (CathedralIntrinsicArticulation.distinctWeb Bool)
        (CathedralIntrinsicArticulation.distinct_web_relationally_individuated Bool)
        false true).mpr (by decide)

#print axioms koru_iff_genuine_distinction
#print axioms same_role_koru_noncollapse

end PhysicalBridges.OriginalKoruSummitJoin
