import PhysicalBridges.BCRDThreePopulationKey

/-!
# B.1 — projective measurement granularity and the three-population key

The three exact source probabilities are defined on a coherent
unmeasured constructed stage history. They are NOT automatically
three accessible single-shot results.

Here we test the *unread measurement channel* at the intermediate
C_LM stage. A coarse three-outcome computational-basis partition
{0}, {2}, {remaining positions} preserves every one of the six
specific modeled source-origin pure-state densities. In contrast,
a full basis-resolution dephasing channel destroys L1-M1 coherence
and maps origins 1 and 2 to the SAME dephased state, so their
later exact unitary source signatures are also identical.

This is a source-model measurement-channel calculation; no claim
of an actually implemented or nondemolition detector, an ideal
single-shot probability estimator, repeatable subjects, complete
history witness, or experiencing-subject continuity is made.
-/

namespace PhysicalBridges.BCRDPopulationMeasurementGranularity

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDComplexCarrierAudit
open PhysicalBridges.BCRDCoherenceFibre
open PhysicalBridges.BCRDThreePopulationKey

/-- The coarse algebraic measurement can report occupation of source
position 0, position 2, or their complement without distinguishing
the coherently mixed positions 1 and 3. This is a defined channel,
not a claim that it has been physically installed. -/
def coarseCell (position : Index) : Nat :=
  if position = 0 then 0 else if position = 2 then 1 else 2

/-- Unread projective measurement with three orthogonal blocks.
Inter-block coherences are removed; intra-block ones retained. -/
def coarseDephase (rho : StageMatrix) : StageMatrix :=
  fun i j => if coarseCell i = coarseCell j then rho i j else cz

/-- Unread full computational basis measurement: all off-diagonal
terms are removed, including the L1-M1 relative phase. -/
def fineDephase (rho : StageMatrix) : StageMatrix :=
  fun i j => if i = j then rho i j else cz

/-- Exact source-conditional non-disturbance for ALL SIX basis-origin
candidates at the FIRST L-M checkpoint. This is not a universal
non-disturbance statement for arbitrary coherent input states. -/
theorem coarse_measurement_preserves_each_source_candidate :
    ∀ origin : Index,
      coarseDephase (densityReadout .afterLM origin) =
        densityReadout .afterLM origin := by
  have h : ∀ origin i j : Index,
      coarseDephase (densityReadout .afterLM origin) i j =
        densityReadout .afterLM origin i j := by
    decide +kernel
  intro origin
  funext i j
  exact h origin i j

/-- At the same checkpoint, the chosen two early population
features are always a deterministic block indicator for each
one of the SIX modeled initial basis candidates. -/
theorem early_two_population_values_are_deterministic :
    ∀ origin : Index,
      (lm0 origin = so ∧ lm2 origin = sz) ∨
      (lm0 origin = sz ∧ lm2 origin = so) ∨
      (lm0 origin = sz ∧ lm2 origin = sz) := by
  decide +kernel

/-- A fine measurement loses precisely the relative coherence
distinguishing origins 1 and 2 at the L-M checkpoint. -/
theorem fine_measurement_merges_two_source_candidates :
    fineDephase (densityReadout .afterLM 1) =
      fineDephase (densityReadout .afterLM 2) := by
  have h : ∀ i j : Index,
      fineDephase (densityReadout .afterLM 1) i j =
        fineDephase (densityReadout .afterLM 2) i j := by
    decide +kernel
  funext i j
  exact h i j

theorem fine_measurement_removes_real_model_coherence :
    fineDephase (densityReadout .afterLM 2) 1 3 ≠
      densityReadout .afterLM 2 1 3 := by
  decide +kernel

/-- The modeled subsequent unmeasured operator is C_LM*U_MR6,
which advances a density state from afterLM through afterMR
to afterFinalLM. -/
def remainingOperator : StageMatrix :=
  matrixProduct sourceCLM sourceUMR6

def propagateRemaining (rho : StageMatrix) : StageMatrix :=
  matrixProduct (matrixProduct remainingOperator rho)
    (adjoint remainingOperator)

/-- Any modeled later evolution preserves the coincidence created
by fine dephasing. A downstream exact unitary cannot retrieve the
discarded relative phase from the equal post-measurement matrices. -/
theorem fine_measurement_keeps_candidates_merged_at_final_stage :
    propagateRemaining (fineDephase (densityReadout .afterLM 1)) =
      propagateRemaining (fineDephase (densityReadout .afterLM 2)) := by
  exact congrArg propagateRemaining
    fine_measurement_merges_two_source_candidates

/-- In contrast, source-state preservation under the COARSE unread
channel means the modeled downstream density is identical to the
unmeasured coherent branch on all six candidate origins. -/
theorem coarse_measurement_retains_coherent_future
    (origin : Index) :
    propagateRemaining (coarseDephase (densityReadout .afterLM origin)) =
      propagateRemaining (densityReadout .afterLM origin) := by
  exact congrArg propagateRemaining
    (coarse_measurement_preserves_each_source_candidate origin)

/-- A concrete hostile control for a proposed source-observation
instrument: changing measurement granularity can collapse the
origin-distinguishing downstream signature. The mathematical
three-population key does not make ALL population detectors safe. -/
theorem naive_fine_readout_destroys_information_needed_by_key :
    lm0 1 = lm0 2 ∧ lm2 1 = lm2 2 ∧
    propagateRemaining (fineDephase (densityReadout .afterLM 1)) =
      propagateRemaining (fineDephase (densityReadout .afterLM 2)) ∧
    final1 1 ≠ final1 2 := by
  exact ⟨dropping_final_coordinate_loses_information.1,
    dropping_final_coordinate_loses_information.2.1,
    fine_measurement_keeps_candidates_merged_at_final_stage,
    dropping_final_coordinate_loses_information.2.2⟩

/-!
## Single-execution output is not a source probability

The last scalar in the three-population key is an exact Born-rule
probability. On origins 1 and 2 it lies strictly between the deterministic
0 and 1 values (expressed here as unequal to either exact endpoint).
An ideal binary projective measurement at source position 1 returns
a Boolean outcome, not that probability as a rational-surd datum.

The following is an explicit model of ideal single-run *support*:
a position-1 detection is permitted when its modeled probability is
nonzero; a nondetection when its modeled probability is not one.
No general POVM theorem or laboratory instrument is claimed.
-/

/-- The final-stage exact source probabilities for origins 1 and 2
are distinct from both exact zero and exact one. -/
theorem final_population_not_deterministic_for_1_and_2 :
    final1 1 ≠ sz ∧ final1 1 ≠ so ∧
      final1 2 ≠ sz ∧ final1 2 ≠ so := by
  decide +kernel

/-- Model-support criterion for an ideal yes/no population probe.
True = position 1 detected; false = not detected. -/
def finalOneOutcomePermitted (origin : Index)
    (observedHit : Bool) : Prop :=
  if observedHit then final1 origin ≠ sz else final1 origin ≠ so

theorem both_origins_support_both_final_binary_outcomes
    (observedHit : Bool) :
    finalOneOutcomePermitted 1 observedHit ∧
      finalOneOutcomePermitted 2 observedHit := by
  cases observedHit <;> decide +kernel

/-- Ideal earlier readout supplies two deterministic stage-LM
populations on these six candidate inputs; the later readout
supplies one actual Boolean outcome, NOT an exact probability. -/
abbrev SingleShotTranscript := (Surd × Surd) × Bool

def earlyReadout (origin : Index) : Surd × Surd :=
  (lm0 origin, lm2 origin)

def SourceCouldProduce (origin : Index)
    (t : SingleShotTranscript) : Prop :=
  t.1 = earlyReadout origin ∧ finalOneOutcomePermitted origin t.2

/-- Source origins 1 and 2 can produce the SAME ideal coarse-early,
binary-late transcript even though their exact three-POPULATION
model keys are unequal. -/
theorem opposing_origins_share_a_possible_single_shot_transcript :
    ∃ t : SingleShotTranscript,
      SourceCouldProduce 1 t ∧ SourceCouldProduce 2 t := by
  refine ⟨(earlyReadout 1, true), ?_, ?_⟩
  · exact ⟨rfl, (both_origins_support_both_final_binary_outcomes true).1⟩
  · constructor
    · have h := dropping_final_coordinate_loses_information
      change earlyReadout 1 = earlyReadout 2
      exact Prod.ext h.1 h.2.1
    · exact (both_origins_support_both_final_binary_outcomes true).2

/-- NO deterministic exact initial-source decoder from this
single-run transcript exists over all six candidate origins.
The proof uses an explicit pair with overlapping possible
outcomes. It does not rule out ensembles, another POVM or
additional independently authenticated history information. -/
theorem no_perfect_single_shot_origin_decoder :
    ¬ ∃ decoder : SingleShotTranscript → Index,
      ∀ origin : Index, ∀ t : SingleShotTranscript,
        SourceCouldProduce origin t → decoder t = origin := by
  rintro ⟨decoder, hDecoder⟩
  obtain ⟨t, hOne, hTwo⟩ :=
    opposing_origins_share_a_possible_single_shot_transcript
  have h1 : decoder t = (1 : Index) := hDecoder 1 t hOne
  have h2 : decoder t = (2 : Index) := hDecoder 2 t hTwo
  have hDifferent : (1 : Index) ≠ 2 := by decide
  exact hDifferent (h1.symm.trans h2)

#print axioms final_population_not_deterministic_for_1_and_2
#print axioms both_origins_support_both_final_binary_outcomes
#print axioms opposing_origins_share_a_possible_single_shot_transcript
#print axioms no_perfect_single_shot_origin_decoder

#print axioms coarse_measurement_preserves_each_source_candidate
#print axioms early_two_population_values_are_deterministic
#print axioms fine_measurement_merges_two_source_candidates
#print axioms fine_measurement_removes_real_model_coherence
#print axioms fine_measurement_keeps_candidates_merged_at_final_stage
#print axioms coarse_measurement_retains_coherent_future
#print axioms naive_fine_readout_destroys_information_needed_by_key

end PhysicalBridges.BCRDPopulationMeasurementGranularity
