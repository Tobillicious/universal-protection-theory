/-!
R16-CUT -- proposed core-Lean mathematical cut certificate.
Noncanonical source-compatible REVIEW CANDIDATE, 23 October 2026.

This file is a proof candidate; no successful Lean compilation is claimed.
The edge-soundness and boundary-equality premises are not physical theorems.
Acyclicity is expressed by a strict natural-valued rank on witnessed
predecessor edges, so time-delayed causal influences are allowed.
-/
namespace UPTR16CUT

universe u

inductive Reach {V : Type u} (R : V → V → Prop)
    (seed : V → Prop) : V → Prop where
  | initial (v : V) : seed v → Reach R seed v
  | follow (u v : V) : Reach R seed u → R u v → Reach R seed v

/-- Paths which do not ENTER a certified interface node. Their source is a
    difference seed, and boundary nodes themselves are stipulated equal. -/
def unmediated {V : Type u} (R : V → V → Prop)
    (boundary : V → Prop) : V → V → Prop :=
  fun u v => R u v ∧ ¬ boundary v

/-- Every difference in an acyclic causal model comes from a declared seed
    or from a different strictly earlier predecessor. This is the substantive
    source-level graph completeness / locality obligation. -/
theorem different_has_unmediated_path {V : Type u}
    (R : V → V → Prop) (seed boundary diff : V → Prop)
    (rank : V → Nat)
    (boundary_equal : ∀ v, boundary v → ¬ diff v)
    (locality : ∀ v, diff v →
      seed v ∨ ∃ u, R u v ∧ diff u ∧ rank u < rank v)
    (v : V) (hv : diff v) :
    Reach (unmediated R boundary) seed v := by
  have aux : ∀ n : Nat, ∀ v : V, rank v = n → diff v →
      Reach (unmediated R boundary) seed v := by
    intro n
    induction n using Nat.strongRecOn with
    | ind n ih =>
      intro v hvn hd
      have hnot : ¬ boundary v := by
        intro hb
        exact (boundary_equal v hb) hd
      rcases locality v hd with hs | ⟨u, huv, hdu, hlt⟩
      · exact Reach.initial v hs
      · have hlt' : rank u < n := by simpa [hvn] using hlt
        exact Reach.follow u v (ih (rank u) hlt' u rfl hdu) ⟨huv, hnot⟩
  exact aux (rank v) v rfl hv

/-- R16-CUT: with complete local-dependency accounting and matching
    boundary values, an outside-observation difference is impossible if
    every potential source-to-outside path meets the boundary. -/
theorem outside_equal_of_cut {V : Type u}
    (R : V → V → Prop) (seed boundary outside diff : V → Prop)
    (rank : V → Nat)
    (boundary_equal : ∀ v, boundary v → ¬ diff v)
    (locality : ∀ v, diff v →
      seed v ∨ ∃ u, R u v ∧ diff u ∧ rank u < rank v)
    (cut : ∀ v, outside v → ¬ Reach (unmediated R boundary) seed v) :
    ∀ v, outside v → ¬ diff v := by
  intro v ho hd
  exact (cut v ho) (different_has_unmediated_path R seed boundary diff
    rank boundary_equal locality v hd)

/-- R2's overconservative closed co-hold closure: symmetrise declared
    dependencies so there is no graph edge crossing the held component. -/
def adjacent {V : Type u} (R : V → V → Prop) (u v : V) : Prop :=
  R u v ∨ R v u

theorem r2_no_crossing {V : Type u} (R : V → V → Prop)
    (seed : V → Prop) (u v : V)
    (hu : Reach (adjacent R) seed u) (hedge : adjacent R u v) :
    Reach (adjacent R) seed v := Reach.follow u v hu hedge

end UPTR16CUT
