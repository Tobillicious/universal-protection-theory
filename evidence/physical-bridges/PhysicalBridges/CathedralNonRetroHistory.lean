import PhysicalBridges.IR128EquivariantProcessEmbedding
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
BCRD CATHEDRAL-NONRETRO-01 — Lean corollary candidate.
Only uses event/state graphs, IR128 certified source embeddings, and IR132
cut-fibre reconstruction. No Hamiltonian, Hilbert space or global clock.
NOT Lean-compiled in this environment. No physical universe theorem claimed.
-/

namespace PhysicalBridges.CathedralNonRetro

universe u v w z
variable {X : Type u} {Y : Type v} {Z : Type w}
variable {B : Type z}

/-- Two genuinely certified source seams preserve old distinctness:
    different historical source states cannot be merged by their composite. -/
theorem old_distinctions_survive_two_seams
    (p : IR128.Process X)
    (q : IR128.Process Y)
    (r : IR128.Process Z)
    (e : IR128.Embedding p q)
    (f : IR128.Embedding q r)
    {a b : X} (hab : a ≠ b) :
    f.map (e.map a) ≠ f.map (e.map b) := by
  intro h
  exact hab (e.injective (f.injective h))

/-- The original old-node live source representation survives across both
    maps. The physical meaning of live requires a separate source certificate. -/
theorem source_live_witness_survives_two_seams
    (p : IR128.Process X)
    (q : IR128.Process Y)
    (r : IR128.Process Z)
    (e : IR128.Embedding p q)
    (f : IR128.Embedding q r)
    (a : X) (h : p.live a) :
    r.live (f.map (e.map a)) := by
  exact f.retainsLive (e.map a) (e.retainsLive a h)

/-- Original source parent relations survive each certified seam. -/
theorem source_parent_survives_two_seams
    (p : IR128.Process X)
    (q : IR128.Process Y)
    (r : IR128.Process Z)
    (e : IR128.Embedding p q)
    (f : IR128.Embedding q r)
    (a b : X) (h : p.parent a b) :
    r.parent (f.map (e.map a)) (f.map (e.map b)) := by
  exact f.retainsParent (e.map a) (e.map b)
    (e.retainsParent a b h)

/-- Reuses original IR128 maps_every_finite_generator_iterate via its
    already-proved composition constructor. -/
theorem original_orbit_survives_two_seams
    (p : IR128.Process X)
    (q : IR128.Process Y)
    (r : IR128.Process Z)
    (e : IR128.Embedding p q)
    (f : IR128.Embedding q r)
    (a : X) (n : Nat) :
    f.map (e.map (IR128.iterate p.generator n a)) =
    IR128.iterate r.generator n (f.map (e.map a)) := by
  simpa [IR128.composeEmbedding] using
    (IR128.maps_every_finite_generator_iterate
      p r (IR128.composeEmbedding p q r e f) n a)

/-- If an actual cut fails to distinguish two different historical truths,
    there can be no universal exact decoder of the history from that cut. -/
theorem invisible_history_forbids_exact_cut_decoder
    (cut : X → B) (occurred : X → Bool)
    (a b : X)
    (hsame : cut a = cut b)
    (hdifferent : occurred a ≠ occurred b) :
    ¬ IR132.ExactDecoder cut occurred := by
  intro h
  have hFibre :=
    IR132.exact_decoder_implies_fiber_constant cut occurred h
  exact hdifferent (hFibre a b hsame)

/-- An occurrence in one complete immutable event set cannot be both
    present and absent in that *same* set. This is logical, not physical X3. -/
theorem occurred_cannot_have_never_occurred
    {Event : Type u} (history : Set Event) (a : Event)
    (ha : a ∈ history) : ¬ (a ∉ history) := by
  intro hNever
  exact hNever ha

end PhysicalBridges.CathedralNonRetro
