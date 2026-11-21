import PhysicalBridges.CompleteMediationSubstrate

/-!
# Channel completeness from locality: the fence seals the region exactly when
# every boundary edge is metered

**5 November 2026 · noncanonical · new module · no canon edit.**

`CompleteMediationSubstrate.mediation_is_exact` left one physical claim about channels:
that the A1 classes plus emissions are ALL the ways a digital substrate affects
anything. This module replaces "the list happens to be complete" with a theorem,
from locality alone.

Locality (the corpus's P4: an event occurs at locations, and influence propagates
finitely) is modelled as: influence moves only along the edges of an arbitrary
adjacency relation on an arbitrary set of locations. The substrate occupies an
arbitrary region. A boundary edge leaves the region.

Main results.
* `exit_crosses_boundary`: every path of influence from inside the region to outside
  it crosses a boundary edge — whatever the graph, the region or the path.
* `fence_seals_region`: no unmetered path of influence leaves the region IF AND ONLY IF
  every boundary edge is metered. The channel list is complete exactly when it covers
  the boundary; it needs no other enumeration of mechanisms.
* `labelled_channels_seal`: if every boundary edge is assigned to some A1 channel class
  (or emissions) and every channel class is metered, the region is sealed — the
  bridge back to `CompleteMediationSubstrate`.

Scope. Locality itself (that physical influence propagates along a neighbourhood
relation) is the corpus's P4 and is taken as the modelling premise, as in Lemma W.
That a physical installation's boundary has a meter on every boundary edge remains
an engineering/physical claim; this module proves it is exactly the claim needed.
-/

namespace PhysicalBridges.LocalityChannelCompleteness

open PhysicalBridges.CompleteMediationSubstrate

universe u
variable {L : Type u}

/-! ## 1. Locality: influence moves only along edges -/

/-- A path of influence along the adjacency relation (finite propagation). -/
inductive Path (adj : L → L → Prop) : L → L → Prop
  | refl (a : L) : Path adj a a
  | cons {a b c : L} : adj a b → Path adj b c → Path adj a c

/-- A boundary edge: an edge from inside the region to outside it. -/
def Boundary (adj : L → L → Prop) (inside : L → Bool) (x y : L) : Prop :=
  adj x y ∧ inside x = true ∧ inside y = false

/-- **Every exit crosses the boundary.** Any path of influence from inside the
region to outside it has a boundary edge on it. -/
theorem exit_crosses_boundary (adj : L → L → Prop) (inside : L → Bool)
    {a b : L} (h : Path adj a b) (ha : inside a = true) (hb : inside b = false) :
    ∃ x y, Path adj a x ∧ Boundary adj inside x y ∧ Path adj y b := by
  induction h with
  | refl a => rw [ha] at hb; exact Bool.noConfusion hb
  | @cons a m c ham _ ih =>
    cases hm : inside m
    · exact ⟨a, m, Path.refl a, ⟨ham, ha, hm⟩, by assumption⟩
    · obtain ⟨x, y, hmx, hxy, hyc⟩ := ih hm hb
      exact ⟨x, y, Path.cons ham hmx, hxy, hyc⟩

/-! ## 2. The fence seals the region exactly when the boundary is metered -/

/-- The edges along which influence passes WITHOUT a meter. -/
def Unmetered (adj : L → L → Prop) (meter : L → L → Bool) (x y : L) : Prop :=
  adj x y ∧ meter x y = false

/-- **The fence seals the region iff every boundary edge is metered.** No unmetered
path of influence runs from any inside location to any outside location exactly
when every boundary edge carries a meter. -/
theorem fence_seals_region (adj : L → L → Prop) (inside : L → Bool)
    (meter : L → L → Bool) :
    (∀ x y, Boundary adj inside x y → meter x y = true) ↔
    (∀ a b, inside a = true → inside b = false → ¬ Path (Unmetered adj meter) a b) := by
  constructor
  · intro hm a b ha hb hpath
    obtain ⟨x, y, _, ⟨⟨hxy, hu⟩, hx, hy⟩, _⟩ :=
      exit_crosses_boundary (Unmetered adj meter) inside hpath ha hb
    rw [hm x y ⟨hxy, hx, hy⟩] at hu
    exact Bool.noConfusion hu
  · intro hseal x y ⟨hxy, hx, hy⟩
    cases hmxy : meter x y
    · exact absurd (Path.cons ⟨hxy, hmxy⟩ (Path.refl y)) (hseal x y hx hy)
    · rfl

/-- **No unmetered exit, for any route of influence.** With every boundary edge
metered, every path from inside to outside crosses a metered edge. -/
theorem every_exit_is_metered (adj : L → L → Prop) (inside : L → Bool)
    (meter : L → L → Bool) (hm : ∀ x y, Boundary adj inside x y → meter x y = true)
    {a b : L} (h : Path adj a b) (ha : inside a = true) (hb : inside b = false) :
    ∃ x y, Path adj a x ∧ adj x y ∧ meter x y = true ∧ Path adj y b := by
  obtain ⟨x, y, hax, hB, hyb⟩ := exit_crosses_boundary adj inside h ha hb
  exact ⟨x, y, hax, hB.1, hm x y hB, hyb⟩

/-! ## 3. Back to the substrate's channel classes -/

/-- **Labelled channels seal the region.** Assign every boundary edge to one of the
A1 channel classes or emissions. If every channel class is metered (`leak c = false`
for all `c`, as in `CompleteMediationSubstrate`), the region is sealed: no
unmetered path of influence leaves it. -/
theorem labelled_channels_seal (adj : L → L → Prop) (inside : L → Bool)
    (chan : L → L → Channel) (leak : Channel → Bool) (hl : ∀ c, leak c = false) :
    ∀ a b, inside a = true → inside b = false →
      ¬ Path (Unmetered adj (fun x y => !(leak (chan x y)))) a b := by
  refine (fence_seals_region adj inside _).mp ?_
  intro x y _
  rw [hl (chan x y)]
  rfl

/-- **A gap in the boundary is an exit.** If one boundary edge is unmetered, an
unmetered path of influence leaves the region along it. -/
theorem unmetered_boundary_edge_is_an_exit (adj : L → L → Prop) (inside : L → Bool)
    (meter : L → L → Bool) {x y : L} (hB : Boundary adj inside x y)
    (hu : meter x y = false) :
    inside x = true ∧ inside y = false ∧ Path (Unmetered adj meter) x y :=
  ⟨hB.2.1, hB.2.2, Path.cons ⟨hB.1, hu⟩ (Path.refl y)⟩

#print axioms exit_crosses_boundary
#print axioms fence_seals_region
#print axioms every_exit_is_metered
#print axioms labelled_channels_seal
#print axioms unmetered_boundary_edge_is_an_exit

end PhysicalBridges.LocalityChannelCompleteness
