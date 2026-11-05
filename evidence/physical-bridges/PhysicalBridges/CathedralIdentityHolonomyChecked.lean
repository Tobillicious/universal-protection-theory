import PhysicalBridges.CathedralIntrinsicArticulation
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# Exact historic identity-holonomy proof, Lean-core port of original #202

The original #202 candidate used Mathlib's `Equiv`, unavailable in this
repository's pure-core build. This faithful port instead uses the already
compiled #245 `Rename L L` (bijection plus explicit inverse laws).
All original historical source blobs remain unchanged.

Identity coherence and loop holonomy are tested against independently
supplied cut correspondences. The proof never declares a mathematical
history label to be an experiencing subject by definition.
-/

namespace PhysicalBridges.CathedralIdentityHolonomyChecked

open PhysicalBridges.CathedralIntrinsicArticulation

universe u v w
variable {V : Type u} {L : Type v} {B : Type w}

/-- Invert an already-certified historical identity correspondence. -/
def inverse (g : Rename L L) : Rename L L where
  forward := g.backward
  backward := g.forward
  left_inverse := g.right_inverse
  right_inverse := g.left_inverse

/-- Composition of two certified bidirectional historical maps. -/
def compose (f g : Rename L L) : Rename L L where
  forward := fun x => g.forward (f.forward x)
  backward := fun x => f.backward (g.backward x)
  left_inverse := by
    intro x
    change f.backward (g.backward (g.forward (f.forward x))) = x
    rw [g.left_inverse, f.left_inverse]
  right_inverse := by
    intro x
    change g.forward (f.forward (f.backward (g.backward x))) = x
    rw [f.right_inverse, g.right_inverse]

/-- Coherent identification of a particular at every compared cut. -/
def EdgeCoherent
    (edge : V → V → Prop)
    (f : V → V → Rename L L)
    (labelAt : V → L) : Prop :=
  ∀ a b, edge a b → (f a b).forward (labelAt a) = labelAt b

/-- A closed history returns the same individual label to itself
when transported back to a common independently supplied root. -/
def HolonomyFixed
    (edge : V → V → Prop)
    (f : V → V → Rename L L)
    (tree : V → Rename L L)
    (x : L) : Prop :=
  ∀ a b, edge a b →
    (tree b).backward ((f a b).forward ((tree a).forward x)) = x

/-- The original #202 main local criterion, through the source's
compiled `Rename` structure rather than a separate Equiv library. -/
theorem holonomy_fixed_iff_coherent_section
    (edge : V → V → Prop)
    (f : V → V → Rename L L)
    (tree : V → Rename L L)
    (x : L) :
    HolonomyFixed edge f tree x ↔
      EdgeCoherent edge f (fun v => (tree v).forward x) := by
  constructor
  · intro h a b hab
    have hx := h a b hab
    have hForward := congrArg (tree b).forward hx
    simpa only [(tree b).right_inverse] using hForward
  · intro h a b hab
    have hc := h a b hab
    change (tree b).backward
        ((f a b).forward ((tree a).forward x)) = x
    rw [hc]
    exact (tree b).left_inverse x

/-- Once the spanning-tree equations are certified, checking every
independent chord suffices; no path-history information is discarded. -/
theorem chord_certificate_implies_all_edge_coherence
    (treeEdge chordEdge : V → V → Prop)
    (f : V → V → Rename L L)
    (tree : V → Rename L L)
    (x : L)
    (hTree : EdgeCoherent treeEdge f (fun v => (tree v).forward x))
    (hChord : HolonomyFixed chordEdge f tree x) :
    EdgeCoherent (fun a b => treeEdge a b ∨ chordEdge a b)
      f (fun v => (tree v).forward x) := by
  intro a b hEdge
  cases hEdge with
  | inl ht => exact hTree a b ht
  | inr hc =>
      exact (holonomy_fixed_iff_coherent_section
        chordEdge f tree x).mp hChord a b hc

/-- A physically certified readout that distinguishes every
individual historical identity forbids any invisible holonomy
that permutes those individuals. -/
theorem separating_cut_forces_trivial_holonomy
    (H : Rename L L)
    (readout : L → B)
    (hInjective : Function.Injective readout)
    (hInvisible : ∀ x, readout (H.forward x) = readout x) :
    ∀ x, H.forward x = x := by
  intro x
  exact hInjective (hInvisible x)

/-- A coarser cut cannot reconstruct individual identities
if it identifies two points related by a nontrivial holonomy. -/
theorem twisted_history_forbids_exact_cut_identity_decoder
    (H : Rename L L) (cut : L → B) (x : L)
    (hSame : cut (H.forward x) = cut x)
    (hDifferent : H.forward x ≠ x) :
    ¬ IR132.ExactDecoder cut (id : L → L) := by
  intro hDecoder
  have hFibre := IR132.exact_decoder_implies_fiber_constant
    cut (id : L → L) hDecoder
  exact hDifferent (hFibre (H.forward x) x hSame)

/-- Passive changes of coordinates do not change whether an
original historical particular is fixed by the closed loop. -/
def conjugate (H g : Rename L L) : Rename L L :=
  compose (compose (inverse g) H) g

theorem legitimate_relabeling_preserves_fixedness
    (H g : Rename L L) (x : L) :
    (conjugate H g).forward (g.forward x) = g.forward x ↔
      H.forward x = x := by
  have hc :
      (conjugate H g).forward (g.forward x) =
        g.forward (H.forward x) := by
    simp [conjugate, compose, inverse, g.left_inverse]
  rw [hc]
  constructor
  · intro h
    have hBack := congrArg g.backward h
    simpa [g.left_inverse] using hBack
  · intro h
    rw [h]

#print axioms holonomy_fixed_iff_coherent_section
#print axioms chord_certificate_implies_all_edge_coherence
#print axioms separating_cut_forces_trivial_holonomy
#print axioms twisted_history_forbids_exact_cut_identity_decoder
#print axioms legitimate_relabeling_preserves_fixedness

end PhysicalBridges.CathedralIdentityHolonomyChecked
