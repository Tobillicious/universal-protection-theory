import PhysicalBridges.BCRDCoherenceFibre
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# B.1 — a three-scalar late-stage population key and the physical-observation gate

Tenzing II follow-up to draft PR #295. Uses only the exact source-pinned
algebraic-complex stages already present in BCRDComplexM3dStage.

A SINGLE late-stage population snapshot does not identify all six source
basis origins (#295). Two stage populations from distinct checkpoints,
however, contain a smaller distinguishing signature. Three exact scalar
population values suffice, and each chosen value is individually
necessary for THIS three-coordinate key.

Crucial limitation: a source-model function that returns populations at
two times is NOT a joint nondisturbing measurement of one evolving
quantum state. Calibration, physical occurrence, temporal ordering,
measurement back-action, subject/experiential identity and original X3
are independent obligations. No model readout is promoted to a real
instrument in this file.
-/

namespace PhysicalBridges.BCRDThreePopulationKey

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDComplexCarrierAudit
open PhysicalBridges.BCRDCoherenceFibre

/-- Three source-derived *scalar* populations from two constructed
late-stage boundaries. No complex amplitude or density-matrix entry
is used; no claim of nondisturbing joint physical acquisition. -/
def lm0 (origin : Index) : Surd := populationReadout .afterLM origin 0
def lm2 (origin : Index) : Surd := populationReadout .afterLM origin 2
def final1 (origin : Index) : Surd :=
  populationReadout .afterFinalLM origin 1

def threePopulationKey (origin : Index) : Surd × Surd × Surd :=
  (lm0 origin, lm2 origin, final1 origin)

/-- All six actual frozen source basis origins have different
three-scalar signatures. This finite result is checked against
the literal W, C_LM, U_MR6, C_LM exact matrices, not postulated. -/
theorem three_population_key_injective :
    Function.Injective threePopulationKey := by
  have h : ∀ a b : Index,
      threePopulationKey a = threePopulationKey b → a = b := by
    decide +kernel
  exact h

/-- Mathematical exact decoding exists ON THE SIX-ORIGIN SOURCE
DOMAIN, by the inherited IR132 fibre criterion. Choice-based
decoder existence is NOT an apparatus or a physical measurement. -/
theorem three_population_key_has_exact_source_decoder :
    PhysicalBridges.IR132.ExactDecoder
      threePopulationKey (fun i : Index => i) := by
  apply (PhysicalBridges.IR132.exact_decoder_iff_fiber_constant
    threePopulationKey (fun i : Index => i)).mpr
  intro a b hEqual
  exact three_population_key_injective hEqual

/-- Without the *final-stage* coordinate, origins 1 and 2
remain indistinguishable in the two selected L-M readings. -/
theorem dropping_final_coordinate_loses_information :
    lm0 1 = lm0 2 ∧ lm2 1 = lm2 2 ∧
      final1 1 ≠ final1 2 := by
  decide +kernel

/-- Without the *L-M coordinate 2*, origins 3 and 4 are
indistinguishable by the two remaining selected populations. -/
theorem dropping_lm2_loses_information :
    lm0 3 = lm0 4 ∧ final1 3 = final1 4 ∧
      lm2 3 ≠ lm2 4 := by
  decide +kernel

/-- Without the *L-M coordinate 0*, origins 0 and 4 are
indistinguishable by the two remaining selected populations. -/
theorem dropping_lm0_loses_information :
    lm2 0 = lm2 4 ∧ final1 0 = final1 4 ∧
      lm0 0 ≠ lm0 4 := by
  decide +kernel

/-!
## Independent physical observation interface

The three reported scalar readings, the real-event relation and
the source-origin interpretation are separate fields. The needed
correspondence is named as a HYPOTHESIS and cannot be obtained
by defining the readouts as correct, or by source algebra alone.
-/

universe u

structure PhysicalPopulationReport (W : Type u) where
  realStep : W → W → Prop
  proposedSourceOrigin : W → Index
  measuredLM0 : W → Surd
  measuredLM2 : W → Surd
  measuredFinalLM1 : W → Surd

def reportKey {W : Type u} (r : PhysicalPopulationReport W)
    (w : W) : Surd × Surd × Surd :=
  (r.measuredLM0 w, r.measuredLM2 w, r.measuredFinalLM1 w)

/-- EXPLICITLY OPEN calibration/physical-trace correspondence:
the independently supplied readout really reports the model's three
populations for the proposed source origin, in the specified stage
order. No apparatus satisfying this is exhibited or assumed universal. -/
def AgreesWithSource {W : Type u}
    (r : PhysicalPopulationReport W) : Prop :=
  ∀ w, reportKey r w = threePopulationKey (r.proposedSourceOrigin w)

/-- Conditional physical-to-SOURCE identification: if an
independently established observation correspondence holds, equal
three-population reports force equal SOURCE origin labels.
It does not infer equality of world events or experiencing subjects. -/
theorem calibrated_reports_identify_source_origin
    {W : Type u} (r : PhysicalPopulationReport W)
    (hAgrees : AgreesWithSource r)
    {w v : W} (hSame : reportKey r w = reportKey r v) :
    r.proposedSourceOrigin w = r.proposedSourceOrigin v := by
  apply three_population_key_injective
  calc
    threePopulationKey (r.proposedSourceOrigin w) =
        reportKey r w := (hAgrees w).symm
    _ = reportKey r v := hSame
    _ = threePopulationKey (r.proposedSourceOrigin v) := hAgrees v

/-- Deliberately no physical execution. The model's population
functions are replayed as synthetic reports from two worlds with the
same proposed origin. Neither world contains a real step. -/
def noExecutionReport : PhysicalPopulationReport Bool where
  realStep := fun _ _ => False
  proposedSourceOrigin := fun _ => 2
  measuredLM0 := fun _ => lm0 2
  measuredLM2 := fun _ => lm2 2
  measuredFinalLM1 := fun _ => final1 2

theorem synthetic_report_agrees_with_source :
    AgreesWithSource noExecutionReport := by
  intro w
  rfl

/-- Even exactly source-matching *synthetic* observations do not
create an actual transition. Thus the source-origin reconstruction
cannot certify a real executed event or its subject continuity. -/
theorem calibrated_signatures_do_not_force_event_occurrence :
    AgreesWithSource noExecutionReport ∧
      ¬ noExecutionReport.realStep false true := by
  constructor
  · exact synthetic_report_agrees_with_source
  · intro h
    exact h

#print axioms three_population_key_injective
#print axioms three_population_key_has_exact_source_decoder
#print axioms dropping_final_coordinate_loses_information
#print axioms dropping_lm2_loses_information
#print axioms dropping_lm0_loses_information
#print axioms calibrated_reports_identify_source_origin
#print axioms calibrated_signatures_do_not_force_event_occurrence

end PhysicalBridges.BCRDThreePopulationKey
