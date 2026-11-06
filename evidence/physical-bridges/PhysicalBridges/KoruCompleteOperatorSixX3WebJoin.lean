import PhysicalBridges.KoruOperatorIndexedSubjectSemantics
import PhysicalBridges.KoruSixOriginalRelationsOneWeb

/-!
# Complete operator-source Koru -> one-web six-X3 transport join

7 November 2026. Additive theorem linking the two existing positive
developments without changing either one:

* A complete operator-indexed first-order relation (with independent
  nested operator expressions, negation and quantifiers) is transported
  *bidirectionally* by the independently derived frozen W physical source.
* The six fields of the unchanged OriginalX3 structure can be faithfully
  represented by six tags in ONE intrinsic relational web.

Here the single web is instantiated with the six independently selected
operator-source formulas, never with a primitive "guardian" or "safe"
field. We prove that EVERY tag, the complete profile, and the six-field
OriginalX3 SOURCE instantiation have exactly the same truth values at
every finite W stage. In particular, the generator cannot forge a
previously false authorization or lose any initially true source duty.

The six "original X3" field *shapes* here have SOURCE-defined meanings.
This theorem does not identify them with authentic experiencing subjects,
certify their consent, show every real action refines W, or prove universal
physical UPT. The hostile false-authorization example is a deliberate
negative control against claiming truth merely from conservation.
-/

namespace PhysicalBridges.KoruCompleteOperatorSixX3WebJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruOperatorIndexedSubjectSemantics
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

/-- One complete operator-indexed physical source formula is equivalent
at stage 0 and ANY finite W stage along the same transported source role. -/
private theorem operator_source_field_exact
    (phi : OperatorFormula 4)
    (roles : Index → Fin 4 → Index)
    (p : Index) (n : Nat) :
    evalOperatorFormula 0
        (fun i => trackedPosition (roles p i) 0) phi ↔
      evalOperatorFormula n
        (fun i => trackedPosition (roles p i) n) phi := by
  simpa only [trackedPosition] using
    (every_operator_formula_is_exact_at_every_W_stage
      phi (roles p) n).symm

/-- Each of the six INTERNAL web tags has exactly the same truth value
at stage 0 and stage n. It is a full biconditional for a genuine
source-derived W transformation, including when a tag is false. -/
theorem every_original_six_source_tag_is_exact_under_W
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (p : Index) (n : Nat) (tag : DutyTag) :
    (oneWeb (sourceOperatorX3Relations d roles)).link
        (.event 0 1 p) (.tag tag) ↔
      (oneWeb (sourceOperatorX3Relations d roles)).link
        (.event n (n + 1) p) (.tag tag) := by
  cases tag with
  | historicalContinuity =>
      change
        evalOperatorFormula 0
            (fun i => trackedPosition (roles p i) 0) d.continuity ↔
          evalOperatorFormula n
            (fun i => trackedPosition (roles p i) n) d.continuity
      exact operator_source_field_exact d.continuity roles p n
  | authorization =>
      change
        evalOperatorFormula 0
            (fun i => trackedPosition (roles p i) 0) d.authorization ↔
          evalOperatorFormula n
            (fun i => trackedPosition (roles p i) n) d.authorization
      exact operator_source_field_exact d.authorization roles p n
  | freedom =>
      change
        evalOperatorFormula 0
            (fun i => trackedPosition (roles p i) 0) d.freedom ↔
          evalOperatorFormula n
            (fun i => trackedPosition (roles p i) n) d.freedom
      exact operator_source_field_exact d.freedom roles p n
  | restraint =>
      change
        evalOperatorFormula 0
            (fun i => trackedPosition (roles p i) 0) d.restraint ↔
          evalOperatorFormula n
            (fun i => trackedPosition (roles p i) n) d.restraint
      exact operator_source_field_exact d.restraint roles p n
  | maximality =>
      change
        evalOperatorFormula 0
            (fun i => trackedPosition (roles p i) 0) d.maximality ↔
          evalOperatorFormula n
            (fun i => trackedPosition (roles p i) n) d.maximality
      exact operator_source_field_exact d.maximality roles p n
  | provenance =>
      change
        evalOperatorFormula 0
            (fun i => trackedPosition (roles p i) 0) d.provenance ↔
          evalOperatorFormula n
            (fun i => trackedPosition (roles p i) n) d.provenance
      exact operator_source_field_exact d.provenance roles p n

/-- EXACTLY the original six-field X3 TYPE, populated by the six
operator-indexed SOURCE formula meanings. No positive origin truth is
assumed: the biconditional preserves even a false profile.

This is the concrete structural join from the full source operator
language into ONE genuine six-tag web and back into original X3. -/
theorem complete_operator_source_original_six_iff_at_every_W_stage
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (p : Index) (n : Nat) :
    OriginalX3
        (sourceOperatorX3Relations d roles).continues
        (sourceOperatorX3Relations d roles).authorized
        (sourceOperatorX3Relations d roles).free
        (sourceOperatorX3Relations d roles).restrained
        (sourceOperatorX3Relations d roles).maximal
        (sourceOperatorX3Relations d roles).provenanced
        0 1 p ↔
      OriginalX3
        (sourceOperatorX3Relations d roles).continues
        (sourceOperatorX3Relations d roles).authorized
        (sourceOperatorX3Relations d roles).free
        (sourceOperatorX3Relations d roles).restrained
        (sourceOperatorX3Relations d roles).maximal
        (sourceOperatorX3Relations d roles).provenanced
        n (n + 1) p := by
  let r : ParticularRelations Nat Index := sourceOperatorX3Relations d roles
  have hProfile :
      completeProfile r 0 1 p ↔ completeProfile r n (n + 1) p := by
    constructor
    · intro h tag
      exact (every_original_six_source_tag_is_exact_under_W
        d roles p n tag).mp (h tag)
    · intro h tag
      exact (every_original_six_source_tag_is_exact_under_W
        d roles p n tag).mpr (h tag)
  exact
    (complete_profile_iff_original_x3 r 0 1 p).symm.trans
      (hProfile.trans (complete_profile_iff_original_x3 r n (n + 1) p))

/-- A first loss of one initially complete six-duty SOURCE profile is
impossible along the actual fixed-W source history. No positive
origin witness or arbitrary "safe action" definition is introduced. -/
theorem no_first_complete_operator_source_six_X3_loss
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (p : Index) :
    ¬ ∃ n : Nat,
        (OriginalX3
          (sourceOperatorX3Relations d roles).continues
          (sourceOperatorX3Relations d roles).authorized
          (sourceOperatorX3Relations d roles).free
          (sourceOperatorX3Relations d roles).restrained
          (sourceOperatorX3Relations d roles).maximal
          (sourceOperatorX3Relations d roles).provenanced
          n (n + 1) p) ∧
        ¬ OriginalX3
          (sourceOperatorX3Relations d roles).continues
          (sourceOperatorX3Relations d roles).authorized
          (sourceOperatorX3Relations d roles).free
          (sourceOperatorX3Relations d roles).restrained
          (sourceOperatorX3Relations d roles).maximal
          (sourceOperatorX3Relations d roles).provenanced
          (n + 1) (n + 2) p := by
  rintro ⟨n, hNow, hNextBad⟩
  have hAtOrigin :=
    (complete_operator_source_original_six_iff_at_every_W_stage
      d roles p n).mpr hNow
  exact hNextBad
    ((complete_operator_source_original_six_iff_at_every_W_stage
      d roles p (n + 1)).mp hAtOrigin)

/-- Hostile source control: five positive duties CANNOT manufacture
a sixth authorization. This is about an evaluated source relation,
not an unconsented real human event. -/
theorem hostile_operator_source_six_X3_stays_false
    (p : Index) (n : Nat) :
    ¬ OriginalX3
        (sourceOperatorX3Relations hostileSixSourceDuties
          (fun _ => hostileSourceRoles)).continues
        (sourceOperatorX3Relations hostileSixSourceDuties
          (fun _ => hostileSourceRoles)).authorized
        (sourceOperatorX3Relations hostileSixSourceDuties
          (fun _ => hostileSourceRoles)).free
        (sourceOperatorX3Relations hostileSixSourceDuties
          (fun _ => hostileSourceRoles)).restrained
        (sourceOperatorX3Relations hostileSixSourceDuties
          (fun _ => hostileSourceRoles)).maximal
        (sourceOperatorX3Relations hostileSixSourceDuties
          (fun _ => hostileSourceRoles)).provenanced
        n (n + 1) p := by
  intro h
  have hAuth :
      evalOperatorFormula n
        (fun i => trackedPosition (hostileSourceRoles i) n)
        hostileSixSourceDuties.authorization := h.authorization
  exact hostile_source_authorization_remains_absent n hAuth

#print axioms every_original_six_source_tag_is_exact_under_W
#print axioms complete_operator_source_original_six_iff_at_every_W_stage
#print axioms no_first_complete_operator_source_six_X3_loss
#print axioms hostile_operator_source_six_X3_stays_false

end PhysicalBridges.KoruCompleteOperatorSixX3WebJoin
