import PhysicalBridges.BCRDComplexCarrierAudit
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# B.1 — coherence-sensitive source fibres at the actual complex stages

4 November 2026. Tenzing II continuation, stacked on draft PR B (#285).

Phase 19 proved that the six basis-origin candidates are separated by
complex amplitudes at every stage of the constructed exact M3d source
sequence W → C_LM → U_MR6 → C_LM. Complex amplitudes are not themselves
an operationally complete measurement protocol: populations |psi_k|²
forget relative phases.

These exact SOURCE-level checks exhibit real collisions in the
population readout of the pinned coherent stages, while a definite
off-diagonal density entry discriminates those same origins. This is a
readout-fibre obstruction, not a claim of actual subject fusion,
a calibrated coherence detector, nondisturbing access, authorization,
actual execution, or the six original X3 duties.

The observer's source-origin decoder is deliberately kept distinct
from any experiencing-subject continuity decoder.
-/

namespace PhysicalBridges.BCRDCoherenceFibre

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDComplexCarrierAudit

/-- A source MODEL's diagonal occupation probabilities at one
constructed stage; exact elements of Q(sqrt(2)), not samples. -/
def populationReadout (moment : SourceMoment) (origin : Index) :
    Index → Surd :=
  fun coordinate => cabs2 (snapshot moment origin coordinate)

/-- The complete pure-state density signature retains off-diagonal
coherences; it is not a claim that all entries are simultaneously
measurable in one physical run. -/
def densityReadout (moment : SourceMoment) (origin : Index) :
    StageMatrix :=
  density (snapshot moment origin)

/-- Concrete collision after the pinned controlled L-M stage.
The distinct initial source basis candidates L1 and M0 have the
SAME diagonal populations at this stage. -/
theorem after_LM_distinct_origins_have_identical_populations :
    populationReadout .afterLM 1 = populationReadout .afterLM 2 := by
  funext coordinate
  have h : ∀ k : Index,
      populationReadout .afterLM 1 k =
        populationReadout .afterLM 2 k := by decide +kernel
  exact h coordinate

/-- The collision is only diagonal: off-diagonal L1-M1 coherence
distinguishes the two exact source-model outputs. -/
theorem after_LM_coherence_separates_those_origins :
    densityReadout .afterLM 1 1 3 ≠
      densityReadout .afterLM 2 1 3 := by decide +kernel

/-- The independent middle-right stage has a SECOND distinct
population collision, between M1 and R0 source origins. -/
theorem after_MR_distinct_origins_have_identical_populations :
    populationReadout .afterMR 3 = populationReadout .afterMR 4 := by
  funext coordinate
  have h : ∀ k : Index,
      populationReadout .afterMR 3 k =
        populationReadout .afterMR 4 k := by decide +kernel
  exact h coordinate

/-- That second ambiguity is resolved at the density-matrix level
by exact coherent cross-term M0-R0. -/
theorem after_MR_coherence_separates_those_origins :
    densityReadout .afterMR 3 2 4 ≠
      densityReadout .afterMR 4 2 4 := by decide +kernel

/-- The same pair remains population-indistinguishable after
the final controlled L-M stage of the constructed history. -/
theorem after_final_LM_distinct_origins_have_identical_populations :
    populationReadout .afterFinalLM 3 =
      populationReadout .afterFinalLM 4 := by
  funext coordinate
  have h : ∀ k : Index,
      populationReadout .afterFinalLM 3 k =
        populationReadout .afterFinalLM 4 k := by decide +kernel
  exact h coordinate

/-- Their exact off-diagonal coherence remains discriminating
even though no diagonal occupation distinguishes them. -/
theorem after_final_LM_coherence_separates_those_origins :
    densityReadout .afterFinalLM 3 2 4 ≠
      densityReadout .afterFinalLM 4 2 4 := by decide +kernel

/-- Stronger, phase-insensitive SOURCE result: for every one of the
five modelled stage snapshots and every two distinct initial basis
origins, at least one exact density-matrix coefficient differs.
Unlike raw amplitude inequality, this survives the global-phase
quotient. This is an algebraic signature result, NOT a physical
tomography or nondisturbing observation instrument. -/
theorem density_signatures_separate_all_six_origins
    (moment : SourceMoment) :
    ∀ i j : Index, i ≠ j →
      ∃ r c : Index,
        densityReadout moment i r c ≠
          densityReadout moment j r c := by
  cases moment
  all_goals decide +kernel

/-- Any independently justified injection of candidate labels into
the six initial SOURCE slots remains injective after conversion to
each stage's PURE-STATE DENSITY signature. The initial candidate
assignment, genuine subjects, and measured histories are NOT
constructed by this theorem. -/
theorem density_stage_carriers_remain_injective
    {P : Type} (sourceSlot : P → Index)
    (hInitiallyDistinct : Function.Injective sourceSlot)
    (moment : SourceMoment) :
    Function.Injective
      (fun p : P => densityReadout moment (sourceSlot p)) := by
  intro p q hReadout
  by_cases hpq : p = q
  · exact hpq
  · have hSlots : sourceSlot p ≠ sourceSlot q := by
      intro heq
      exact hpq (hInitiallyDistinct heq)
    obtain ⟨r,c,hDiff⟩ :=
      density_signatures_separate_all_six_origins
        moment (sourceSlot p) (sourceSlot q) hSlots
    exact False.elim (hDiff (congrFun (congrFun hReadout r) c))

/-- A general, non-circular fibre test for exact source-origin
reconstruction from a SINGLE stage population readout. -/
theorem population_collision_blocks_exact_origin_decoder
    (moment : SourceMoment) (i j : Index)
    (hDistinct : i ≠ j)
    (hSame : populationReadout moment i = populationReadout moment j) :
    ¬ PhysicalBridges.IR132.ExactDecoder
        (populationReadout moment) (fun k : Index => k) := by
  intro hDecoder
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      (populationReadout moment) (fun k : Index => k) hDecoder
  exact hDistinct (hFiber i j hSame)

/-- Not even an ideal exact readout of ALL six populations at
the L-M boundary reconstructs every initial source origin. -/
theorem no_population_only_origin_decoder_after_LM :
    ¬ PhysicalBridges.IR132.ExactDecoder
        (populationReadout .afterLM) (fun k : Index => k) := by
  exact population_collision_blocks_exact_origin_decoder .afterLM 1 2
    (by decide) after_LM_distinct_origins_have_identical_populations

/-- The same information obstruction at the middle-right stage. -/
theorem no_population_only_origin_decoder_after_MR :
    ¬ PhysicalBridges.IR132.ExactDecoder
        (populationReadout .afterMR) (fun k : Index => k) := by
  exact population_collision_blocks_exact_origin_decoder .afterMR 3 4
    (by decide) after_MR_distinct_origins_have_identical_populations

/-- And at the final controlled stage. Earlier stage measurements
or an authenticated origin record may supply additional information;
this does not refute complete-history reconstruction. -/
theorem no_population_only_origin_decoder_after_final_LM :
    ¬ PhysicalBridges.IR132.ExactDecoder
        (populationReadout .afterFinalLM) (fun k : Index => k) := by
  exact population_collision_blocks_exact_origin_decoder .afterFinalLM 3 4
    (by decide) after_final_LM_distinct_origins_have_identical_populations

#print axioms density_signatures_separate_all_six_origins
#print axioms density_stage_carriers_remain_injective
#print axioms after_LM_distinct_origins_have_identical_populations
#print axioms after_LM_coherence_separates_those_origins
#print axioms after_MR_distinct_origins_have_identical_populations
#print axioms after_MR_coherence_separates_those_origins
#print axioms after_final_LM_distinct_origins_have_identical_populations
#print axioms after_final_LM_coherence_separates_those_origins
#print axioms population_collision_blocks_exact_origin_decoder
#print axioms no_population_only_origin_decoder_after_LM
#print axioms no_population_only_origin_decoder_after_MR
#print axioms no_population_only_origin_decoder_after_final_LM

end PhysicalBridges.BCRDCoherenceFibre
