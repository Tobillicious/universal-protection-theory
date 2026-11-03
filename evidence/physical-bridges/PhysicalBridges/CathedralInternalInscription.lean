import PhysicalBridges.CathedralIntrinsicArticulation

/-!
CATHEDRAL: an INTERNAL inscription by an INTERNAL position of ONE web.

This tests, but does not claim to fully formalize, the philosophical
principle "the observer, the description, and the described are all
internal to the one relational reality".

Rather than assume a second type "outside" the web for descriptions, the
test uses THREE POSITIONS OF THE SAME TYPE P: speaker, target, token.
The witness token's relation to speaker and target is itself defined by
the SAME source `Web P`. Symmetries act on all three together.

Important: `Inscribes` is only a relational inscription PATTERN.
It is NOT yet syntax with a proved truth relation, a semantic oracle, a
conscious observer, or a physical BCRD source claim. The code of this
Lean module still inhabits the Lean meta-context. No such hidden
closure is claimed. In particular, a two-edge path is not a
representation of the complete objective mathematical universe.

This is a necessary small test of endogenous description, not a
new mathematical operator or universal UPT proof.
-/

namespace PhysicalBridges.CathedralInternalInscription

open CathedralIntrinsicArticulation
universe u v
variable {P : Type u} {Q : Type v}

/-- A ternary intrinsic pattern: p leaves an inscription token d
related both to p and to the described target t. No separate
substance/type of descriptions is postulated. -/
def Inscribes (w : Web P) (p t d : P) : Prop :=
  w.link p d ∧ w.link d t

/-- A whole-web presentation change also changes the observer and
the purported descriptive token. No privileged, fixed interpreter. -/
theorem inscribes_preserved_by_reindex
    (w : Web P) (f : Rename P Q) (p t d : P) :
    Inscribes (reindex w f) (f.forward p)
      (f.forward t) (f.forward d) ↔
    Inscribes w p t d := by
  simp [Inscribes, reindex, f.left_inverse]

/-- An automorphism may move every one of the three roles, but
does not change whether the one web supports their inscription. -/
theorem inscribes_preserved_by_symmetry
    (w : Web P) (σ : Symmetry w) (p t d : P) :
    Inscribes w (σ.perm.forward p) (σ.perm.forward t)
      (σ.perm.forward d) ↔ Inscribes w p t d := by
  unfold Inscribes
  constructor
  · intro h
    exact ⟨(σ.respects p d).mp h.1,
      (σ.respects d t).mp h.2⟩
  · intro h
    exact ⟨(σ.respects p d).mpr h.1,
      (σ.respects d t).mpr h.2⟩

/-- A very small internal self-description pattern:
the speaker and the target of a token can be the same position,
while the token is a different position IN the same web.
This does NOT assert that the token's content is a correct
self-truth theorem. -/
theorem distinct_internal_self_inscription :
    ∃ p d : Bool, p ≠ d ∧
      Inscribes (distinctWeb Bool) p p d := by
  refine ⟨false, true, by decide, ?_⟩
  exact ⟨by decide, by decide⟩

/-- The same pattern can be moved wholesale. The description is
not glued to a privileged outside interpreter or an absolute label. -/
theorem flip_preserves_internal_self_inscription :
    Inscribes (distinctWeb Bool) false false true ∧
    Inscribes (distinctWeb Bool) true true false := by
  constructor
  · exact ⟨by decide, by decide⟩
  · have h := inscribes_preserved_by_symmetry
      (distinctWeb Bool) swapSymmetry false false true
    exact h.mpr ⟨by decide, by decide⟩

/-- The symmetry of the whole can move ANY supposedly privileged
speaker, while the whole relational pattern remains invariant. -/
theorem no_invariant_exterior_speaker :
    ∀ p : Bool, ∃ σ : Symmetry (distinctWeb Bool),
      σ.perm.forward p ≠ p := by
  intro p
  exact ⟨swapSymmetry, swap_has_no_fixed_point p⟩

/-- Negative-control statement: when only one position exists and
the web is the strict distinction relation, there cannot be a
nontrivial self-inscription. Intra-web description does not
follow merely from "one connected thing" or from naming a token. -/
theorem one_position_has_no_strict_self_inscription :
    ¬ ∃ p d : Unit,
      Inscribes (distinctWeb Unit) p p d := by
  rintro ⟨p, d, h⟩
  cases p
  cases d
  exact h.1 rfl

#print axioms inscribes_preserved_by_reindex
#print axioms inscribes_preserved_by_symmetry
#print axioms distinct_internal_self_inscription
#print axioms flip_preserves_internal_self_inscription
#print axioms no_invariant_exterior_speaker
#print axioms one_position_has_no_strict_self_inscription

end PhysicalBridges.CathedralInternalInscription
