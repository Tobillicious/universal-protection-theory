import PhysicalBridges.Koru

/-!
# Archimedes extension: Koru survives every finite chain of internal views

A view is the SAME relational web under different position labels. The koru
distinction is intrinsic: no finite chain of bijective re-presentations can
create or erase its truth, or merge its two articulated positions.

This is a parameter-free universal theorem over every web and every finite
view chain, derived from the existing `koru_reindex_invariant`.

Scope: these are equivalences of descriptions, NOT a theorem that arbitrary
physical dynamics are bijections or that original six-X3 semantic obligations
follow from mere existence. The law-of-everything programme may use these
view-covariance theorems wherever a faithful correspondence to the actual
source has been independently established.
-/

namespace PhysicalBridges.ArchimedesKoruViewChains

open PhysicalBridges.Koru

universe u
variable {P : Type u}

/-- One whole web and two positions, represented in a given internal view. -/
structure View (P : Type u) where
  web : Web P
  first : P
  second : P

/-- Intrinsic articulation of the two positions, without a privileged view. -/
def articulated (v : View P) : Prop :=
  koru v.web v.first v.second

/-- A view change reindexes the WHOLE web and BOTH positions together. -/
def changeView (σ : Reindex P) (v : View P) : View P :=
  { web := reindexWeb σ v.web
    first := σ.to v.first
    second := σ.to v.second }

/-- One change of expression cannot change the intrinsic distinction. -/
theorem changeView_preserves_articulation
    (σ : Reindex P) (v : View P) :
    articulated (changeView σ v) ↔ articulated v :=
  koru_reindex_invariant σ v.web v.first v.second

/-- Apply an arbitrary finite chain of changes in their given order. -/
def followViews : List (Reindex P) → View P → View P
  | [], v => v
  | σ :: rest, v => followViews rest (changeView σ v)

/-- Archimedes-Koru theorem: ALL finite chains of faithful internal
representations preserve the intrinsic articulation of each pair. -/
theorem every_finite_view_preserves_articulation
    (views : List (Reindex P)) (v : View P) :
    articulated (followViews views v) ↔ articulated v := by
  induction views generalizing v with
  | nil =>
      rfl
  | cons σ rest ih =>
      exact (ih (changeView σ v)).trans
        (changeView_preserves_articulation σ v)

/-- Genuine differences cannot merge under arbitrary finite changes of view. -/
theorem every_finite_view_preserves_distinction
    (views : List (Reindex P)) (v : View P)
    (h : articulated v) :
    (followViews views v).first ≠ (followViews views v).second := by
  exact koru_distinct (followViews views v).web
    (followViews views v).first (followViews views v).second
    ((every_finite_view_preserves_articulation views v).mpr h)

/-- A claim of destruction merely by re-description contradicts the existing
intrinsic difference and the whole-chain covariance theorem. -/
theorem no_view_chain_erases_articulation
    (views : List (Reindex P)) (v : View P)
    (h : articulated v) :
    ¬ ¬ articulated (followViews views v) := by
  intro hn
  exact hn ((every_finite_view_preserves_articulation views v).mpr h)

#print axioms changeView_preserves_articulation
#print axioms every_finite_view_preserves_articulation
#print axioms every_finite_view_preserves_distinction
#print axioms no_view_chain_erases_articulation

end PhysicalBridges.ArchimedesKoruViewChains
