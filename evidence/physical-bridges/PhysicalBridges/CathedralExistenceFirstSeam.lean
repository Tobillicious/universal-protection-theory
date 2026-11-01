import PhysicalBridges.IR128EquivariantProcessEmbedding
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
BCRD CATHEDRAL: existence-first history and boundary-seam no-go candidates.

These corollaries IMPORT the existing IR-128 and IR-132 theorems instead
of replacing BCRD with unrelated dynamics.

The theorem says a certified history-preserving embedding cannot
retrospectively omit an old represented event. It does NOT say that
the same subject must be physically active indefinitely, or that
all real physical transitions admit the required faithful embedding.

This file is a DRAFT, not Lean-compiled in this environment.
-/

namespace PhysicalBridges.CathedralExistence

open PhysicalBridges

universe u v w x y z

variable {X : Type u} {Y : Type v} {Z : Type w}

/-- Two IR-128 seam embeddings, taken together, still faithfully represent
    all historically live nodes at every finite generator iteration.
    Source closure and actual seam certification are hypotheses. -/
theorem two_cut_live_history
    (s : IR128.Process X) (t : IR128.Process Y) (v : IR128.Process Z)
    (f : IR128.Embedding s t)
    (g : IR128.Embedding t v)
    (hClosed : ∀ x, s.live x → s.live (s.generator x))
    (x : X) (hx : s.live x) (n : Nat) :
    v.live (IR128.iterate v.generator n
      ((IR128.composeEmbedding s t v f g).map x)) := by
  exact IR128.old_living_orbits_remain_represented
    s v (IR128.composeEmbedding s t v f g) hClosed x hx n

/-- A proposed final cut with no represented old event cannot be
    related by certified two-seam IR-128 embeddings to a nonempty
    genuinely represented earlier cut. -/
theorem no_total_erase_of_a_represented_old_event
    (s : IR128.Process X) (t : IR128.Process Y) (v : IR128.Process Z)
    (f : IR128.Embedding s t)
    (g : IR128.Embedding t v)
    (x : X) (hx : s.live x)
    (hEmpty : ∀ z : Z, ¬ v.live z) : False := by
  have hMid : t.live (f.map x) := f.retainsLive x hx
  exact hEmpty (g.map (f.map x)) (g.retainsLive (f.map x) hMid)

/-- The two faithful BCRD seams cannot merge distinct earlier nodes. -/
theorem distinct_old_events_stay_distinct
    (s : IR128.Process X) (t : IR128.Process Y) (v : IR128.Process Z)
    (f : IR128.Embedding s t)
    (g : IR128.Embedding t v)
    {a b : X} (hab : a ≠ b) :
    (IR128.composeEmbedding s t v f g).map a ≠
      (IR128.composeEmbedding s t v f g).map b := by
  exact IR128.distinct_old_states_not_merged
    s v (IR128.composeEmbedding s t v f g) hab

/-- IR-132 supplies the crucial *observability* obstruction.
    If two physical histories have identical boundary data but
    distinct logical history, there cannot be a globally exact
    history decoder from those data alone. -/
theorem no_exact_history_readout_if_boundary_fiber_collapses
    {Physical : Type x} {Boundary : Type y} {History : Type z}
    (boundary : Physical → Boundary)
    (history : Physical → History)
    (a b : Physical)
    (hSameCut : boundary a = boundary b)
    (hDistinct : history a ≠ history b) :
    ¬ IR132.ExactDecoder boundary history := by
  intro hDecoder
  have hFiber :=
    IR132.exact_decoder_implies_fiber_constant
      boundary history hDecoder
  exact hDistinct (hFiber a b hSameCut)

/-- Hostile control: mathematical consistency alone permits a process
    whose 'currently active' indicator becomes false. This does not
    negate the mathematics used to describe its previous existence.
    It is not a claim about physical conscious beings. -/
theorem a_total_internal_operation_can_end_activity :
    ∃ step : Bool → Bool,
      step true = false ∧ (∀ b, step b = false) := by
  refine ⟨fun _ => false, rfl, ?_⟩
  intro b
  rfl

end PhysicalBridges.CathedralExistence
