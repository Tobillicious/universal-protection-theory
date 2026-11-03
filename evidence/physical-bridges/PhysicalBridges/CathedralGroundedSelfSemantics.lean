import PhysicalBridges.CathedralIntrinsicAtomicSemantics

/-!
# Cathedral grounded partial self-semantics (finite and compositional)

Aim: move past an internal atomic token to *limited self-interpretation*
without a total global truth oracle.

All syntactic positions and their cited positions have the SAME type P
as the ONE relational source `w : Web P`. Every ground atomic value
is computed from a link in that SAME `w`, not by a presumed true log.

A code selects a compositional instruction for each position. This
code-to-instruction map is an additional explicitly supplied structure;
Lean, the instruction datatype and its meaning still live in the
metatheory. None of this proves full ontological self-internality.

Three-valued semantics separates:
  - holds    (grounded true),
  - refuted  (grounded false),
  - pending  (not yet semantically grounded).
The next stage is computed from earlier stages. The liar is pending
at every finite stage instead of forcing arbitrary consequences.

Our finite balancedWeb example has:
- rooted ground atomic self-description for the looped pair;
- ungrounded liar codes for the unlooped pair;
- a flip of the second coordinate which moves EVERY position and
  preserves both the source relation and the code instructions.
No privilege is assigned to the selected coordinate labels.

These are classical techniques (Kripke-style partial truth/grounding
and compositional connectives), not a new operation, BCRD physical
source theorem, X3 guarantee, or global satisfaction predicate.
-/

namespace PhysicalBridges.CathedralGroundedSelfSemantics
open CathedralIntrinsicArticulation
open CathedralIntrinsicAtomicSemantics

universe u
variable {P : Type u}

/-- A three-way *epistemic/semantic* classification, not a new
category of independent physical substance. -/
inductive Grounding where
  | pending
  | holds
  | refuted
  deriving DecidableEq, Repr

/-- Strong Kleene negation: unknown remains unknown. -/
def negate : Grounding → Grounding
  | .pending => .pending
  | .holds => .refuted
  | .refuted => .holds

/-- Compositional conjunction of locally grounded statements. -/
def conjoin : Grounding → Grounding → Grounding
  | .refuted, _ => .refuted
  | _, .refuted => .refuted
  | .holds, .holds => .holds
  | _, _ => .pending

/-- Positions in the ONE web can describe a source edge, quote an
internal position, negate an internal position, or conjoin two.
This syntax is explicitly specified *about* internal positions,
not presumed to be an exhaustive intrinsic decoding theory. -/
inductive Instruction (P : Type u) where
  | fact (a b : P)
  | quote (a : P)
  | deny (a : P)
  | both (a b : P)

/-- Evaluate the instruction at position p from the current partial
interpretation. Ground facts must be DECIDABLE from the source web:
the caller supplies a test of `w.link`, not a truth oracle for
arbitrary logical sentences. -/
def advance (w : Web P) (program : P → Instruction P)
    (edgeDecision : ∀ a b : P, Decidable (w.link a b))
    (value : P → Grounding) (p : P) : Grounding :=
  match program p with
  | .fact a b =>
      letI : Decidable (w.link a b) := edgeDecision a b
      if w.link a b then .holds else .refuted
  | .quote a => value a
  | .deny a => negate (value a)
  | .both a b => conjoin (value a) (value b)

/-- Beginning at NO assumed semantic truths, iterate the
compositional interpretation for n finite stages. -/
def stage (w : Web P) (program : P → Instruction P)
    (edgeDecision : ∀ a b : P, Decidable (w.link a b)) :
    Nat → P → Grounding
  | 0 => fun _ => .pending
  | n+1 => advance w program edgeDecision (stage w program edgeDecision n)

/-- A decidable readout of the PREVIOUSLY constructed bounded
four-node source, without a new truth predicate. -/
def balancedDecision (a b : Bool × Bool) :
    Decidable (balancedWeb.link a b) := by
  unfold balancedWeb
  infer_instance

/-- The code program respects the actual source-orbit partition.
Positions with first coordinate false make the source fact claim
"this position has a self-loop"; the remaining positions code
"this code's grounded truth is false" (the liar). -/
def balancedProgram (p : Bool × Bool) :
    Instruction (Bool × Bool) :=
  if p.1 then .deny p else .fact p p

def balancedStage : Nat → Bool × Bool → Grounding :=
  stage balancedWeb balancedProgram balancedDecision

/-- Grounded true self-assertion is already settled after one
compositional step, and remains settled at ALL later stages. -/
theorem grounded_true_at_every_positive_stage (n : Nat)
    (b : Bool) :
    balancedStage (n+1) (false, b) = .holds := by
  simp [balancedStage, stage, advance, balancedProgram,
    balancedDecision, balancedWeb]

/-- The unlooped mode asserts its own negation.
It does not acquire a two-valued semantic truth out of nothing. -/
theorem liar_pending_at_every_stage (n : Nat)
    (b : Bool) :
    balancedStage n (true, b) = .pending := by
  induction n with
  | zero => rfl
  | succ n ih =>
      simp [balancedStage, stage, advance, balancedProgram,
        negate, ih]

/-- The same one web contains both a grounded true internal
proposition and an unresolved diagonal self-interpretation. -/
theorem grounded_and_liar_coexist (n : Nat) :
    balancedStage (n+1) (false,false) = .holds ∧
    balancedStage (n+1) (true,false) = .pending := by
  exact ⟨grounded_true_at_every_positive_stage n false,
    liar_pending_at_every_stage (n+1) false⟩

/-- A liar position has no consistent TWO-valued fixed point.
We are excluding total semantic bivalence for this code, not
excluding self-reference, the position, or the whole relation. -/
theorem no_bivalent_liar_fixed_point (g : Grounding)
    (hTotal : g = .holds ∨ g = .refuted) :
    g ≠ negate g := by
  intro h
  cases g with
  | pending =>
      cases hTotal with
      | inl hp => cases hp
      | inr hp => cases hp
  | holds => cases h
  | refuted => cases h

/-- The only possible fixed point of negation is the *partial*
classification pending. The liar is representable but ungrounded. -/
theorem negation_fixed_point_is_pending (g : Grounding)
    (h : g = negate g) : g = .pending := by
  cases g with
  | pending => rfl
  | holds => cases h
  | refuted => cases h

/-- A separate, fully grounded program allows true AND false
same-web atomic reports. This rules out a built-in "every internal
statement is true" premise. -/
def atomicProgram (p : Bool × Bool) : Instruction (Bool × Bool) :=
  .fact p p

def atomicStage : Nat → Bool × Bool → Grounding :=
  stage balancedWeb atomicProgram balancedDecision

theorem grounded_true_and_false_are_distinct (n : Nat) :
    atomicStage (n+1) (false,false) = .holds ∧
    atomicStage (n+1) (true,false) = .refuted := by
  constructor <;>
    simp [atomicStage, stage, advance, atomicProgram,
      balancedDecision, balancedWeb]

/-- Transport ALL references that appear in the instruction under
the same reversible change of presentation as the entire web. -/
def renameInstruction {Q : Type u} (f : Rename P Q) :
    Instruction P → Instruction Q
  | .fact a b => .fact (f.forward a) (f.forward b)
  | .quote a => .quote (f.forward a)
  | .deny a => .deny (f.forward a)
  | .both a b => .both (f.forward a) (f.forward b)

/-- For our concrete source, both its edge relation and its code
program respect a fixed-point-free automorphism. Neither a privileged
listener nor a privileged statement is built into the source. -/
theorem balanced_program_flip_equivariant (p : Bool × Bool) :
    balancedProgram (flipSecond.forward p) =
      renameInstruction flipSecond (balancedProgram p) := by
  cases p with
  | mk a b =>
      cases a <;> cases b <;>
        rfl

/-- Grounded truth and ungrounded diagonal reference are invariant
under the same symmetry of the full source and code, not just under
arbitrary relabelling of the printed strings. -/
theorem balanced_stage_flip_equivariant (n : Nat)
    (p : Bool × Bool) :
    balancedStage n (flipSecond.forward p) =
      balancedStage n p := by
  cases n with
  | zero => rfl
  | succ n =>
      cases p with
      | mk a b =>
          cases a <;> cases b
          all_goals first
            | exact (grounded_true_at_every_positive_stage n _).trans
                (grounded_true_at_every_positive_stage n _).symm
            | exact (liar_pending_at_every_stage (n+1) _).trans
                (liar_pending_at_every_stage (n+1) _).symm

/-- A source-root-free finite model and a symmetry-respecting code
support grounded truth and ungrounded liar simultaneously. This is
a concrete instance of bounded nontrivial self-interpretation. -/
theorem no_root_needed_for_partial_self_interpretation (n : Nat) :
    IntrinsicArticulation balancedWeb ∧
    (∀ p : Bool × Bool,
      balancedProgram (flipSecond.forward p) =
        renameInstruction flipSecond (balancedProgram p)) ∧
    balancedStage (n+1) (false,false) = .holds ∧
    balancedStage (n+1) (true,false) = .pending := by
  exact ⟨balancedWeb_intrinsic_articulation,
    balanced_program_flip_equivariant,
    (grounded_and_liar_coexist n).1,
    (grounded_and_liar_coexist n).2⟩

#print axioms grounded_true_at_every_positive_stage
#print axioms liar_pending_at_every_stage
#print axioms no_bivalent_liar_fixed_point
#print axioms negation_fixed_point_is_pending
#print axioms grounded_true_and_false_are_distinct
#print axioms balanced_program_flip_equivariant
#print axioms balanced_stage_flip_equivariant
#print axioms no_root_needed_for_partial_self_interpretation

end PhysicalBridges.CathedralGroundedSelfSemantics
