import PhysicalBridges.CathedralFullX3Assembly
import PhysicalBridges.Koru

/-!
# Koru positive construction: ALL six original X3 meanings in ONE relation

A minimal binary relational web can fail to express stage-sensitive
particular facts. This constructive companion encodes the SIX unchanged
source-semantic relations of OriginalX3 in exactly ONE intrinsic
binary relation, using internal event nodes and duty-tag nodes.

The encoding is faithful in BOTH directions: the tagged event's
complete relational profile satisfies all six tags iff it satisfies
the actual OriginalX3 structure, with no missing or substituted duty.

A second theorem says that preserving the entire tagged relational
profile preserves the truth of full original X3. Neither theorem
asserts that every real physical transition preserves that profile.
This is a pure representation theorem and the exact compositional
join a full BCRD/Koru physical source could use.

No Guardian, safety, holding or physics assumptions are used to
construct the representation or prove its exactness.
-/

namespace PhysicalBridges.KoruSixOriginalRelationsOneWeb

open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.Koru

universe u v

variable {S : Type u} {P : Type v}

/-- Exactly the six ORIGINAL original-X3 components; none discarded. -/
inductive DutyTag where
  | historicalContinuity
  | authorization
  | freedom
  | restraint
  | maximality
  | provenance
  deriving DecidableEq, Repr

/-- Event and duty tags are NODES OF ONE WEB, not separate ontologies. -/
inductive OneNode (S : Type u) (P : Type v) where
  | event : S → S → P → OneNode S P
  | tag : DutyTag → OneNode S P

/-- Single relational datum faithfully encoding all six independently
supplied original subject-level semantic relations. -/
def relation (r : ParticularRelations S P) : OneNode S P → OneNode S P → Prop
  | .event s t p, .tag .historicalContinuity => r.continues s t p
  | .event s t p, .tag .authorization => r.authorized s t p
  | .event s t p, .tag .freedom => r.free s t p
  | .event s t p, .tag .restraint => r.restrained s t p
  | .event s t p, .tag .maximality => r.maximal s t p
  | .event s t p, .tag .provenance => r.provenanced s t p
  | _, _ => False

/-- The SAME Koru Web signature, now semantically rich rather than
restricted to numerical values or an unrelated graph edge. -/
def oneWeb (r : ParticularRelations S P) : Web (OneNode S P) :=
  ⟨relation r⟩

/-- The all-duty relational *profile* of one original event/particular. -/
def completeProfile (r : ParticularRelations S P)
    (s t : S) (p : P) : Prop :=
  ∀ tag : DutyTag, (oneWeb r).link (.event s t p) (.tag tag)

/-- Main theorem: the one-web profile is EXACTLY the original six X3,
not weaker and not stronger. No semantic fields are inferred or erased. -/
theorem complete_profile_iff_original_x3
    (r : ParticularRelations S P) (s t : S) (p : P) :
    completeProfile r s t p ↔
      OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced s t p := by
  constructor
  · intro h
    exact ⟨h .historicalContinuity, h .authorization,
      h .freedom, h .restraint, h .maximality, h .provenance⟩
  · intro h tag
    cases tag with
    | historicalContinuity => exact h.historicalContinuity
    | authorization => exact h.authorization
    | freedom => exact h.freedom
    | restraint => exact h.restraint
    | maximality => exact h.maximality
    | provenance => exact h.provenance

/-- If two full semantic presentations preserve each SAME EVENT's
complete intrinsically tagged relational profile, their SIX-X3 truth
values are identical. The complete map is not a score or a proxy. -/
theorem identical_complete_profiles_preserve_original_x3
    (r r' : ParticularRelations S P) (s t : S) (p : P)
    (hProfile : ∀ tag : DutyTag,
       (oneWeb r).link (.event s t p) (.tag tag) ↔
       (oneWeb r').link (.event s t p) (.tag tag)) :
    (OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced s t p) ↔
      (OriginalX3 r'.continues r'.authorized r'.free r'.restrained
        r'.maximal r'.provenanced s t p) := by
  have hTagged : completeProfile r s t p ↔
      completeProfile r' s t p := by
    constructor
    · intro h tag
      exact (hProfile tag).mp (h tag)
    · intro h tag
      exact (hProfile tag).mpr (h tag)
  exact (complete_profile_iff_original_x3 r s t p).symm.trans
    (hTagged.trans (complete_profile_iff_original_x3 r' s t p))

/-- Every original-X3 duty individually has a literal internal edge.
Thus any proof based on the full one-web relation can name precisely
the edge whose preservation is needed, with NO semantic oracle added
after the fact. The input semantic relations must still be sourced. -/
theorem every_duty_has_exact_internal_edge
    (r : ParticularRelations S P) (s t : S) (p : P) :
    (r.continues s t p ↔ relation r (.event s t p) (.tag .historicalContinuity)) ∧
    (r.authorized s t p ↔ relation r (.event s t p) (.tag .authorization)) ∧
    (r.free s t p ↔ relation r (.event s t p) (.tag .freedom)) ∧
    (r.restrained s t p ↔ relation r (.event s t p) (.tag .restraint)) ∧
    (r.maximal s t p ↔ relation r (.event s t p) (.tag .maximality)) ∧
    (r.provenanced s t p ↔ relation r (.event s t p) (.tag .provenance)) := by
  exact ⟨Iff.rfl, Iff.rfl, Iff.rfl, Iff.rfl, Iff.rfl, Iff.rfl⟩

#print axioms complete_profile_iff_original_x3
#print axioms identical_complete_profiles_preserve_original_x3
#print axioms every_duty_has_exact_internal_edge

end PhysicalBridges.KoruSixOriginalRelationsOneWeb
