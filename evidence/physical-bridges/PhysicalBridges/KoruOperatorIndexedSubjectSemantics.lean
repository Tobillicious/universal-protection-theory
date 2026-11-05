import PhysicalBridges.BCRDOperatorSubjectEventJoin

/-!
# Koru operator-indexed subject/event formula language

6 November 2026. Research-only; no edits to the frozen summit.

The old full-X3 forcing lane uses just ONE binary relation R and
first-order formulas over R. Even the stronger #342 physical source
join selected ONE evaluated operator expression and ONE relation.
That still forgets the rest of the operator family.

This module closes that EXPRESSIVENESS gap for the frozen W source:
one can write a single first-order formula whose many atomic relations
are indexed by distinct ARBITRARY complete operator expressions.
Each atomic predicate reads an actual entry from that very expression
after the same independently fixed W dynamics.

The resulting source language retains operator identities, arities,
ordered inputs, nested expression trees, distinct relational meanings,
equality, conjunction, negation and unrestricted existential
quantification over all six source positions.

Theorems prove that EVERY such formula and EVERY one of six distinct
source-duty formulas is preserved through EVERY frozen-W microstep.
An asymmetric physical matrix-unit/transpose witness makes the
operator-identity distinction non-vacuous.

Nothing in this language claims that its particular positions encode
experiencing subjects, that its source relations are actual consent,
or that an actual harm is physically excluded. The genuine ORIGINAL
six-X3 physical/subject interpretation and full BCRD source coverage
must be independently established; no Guardian premise is inserted.
-/

namespace PhysicalBridges.KoruOperatorIndexedSubjectSemantics

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruFullOperatorSignature
open PhysicalBridges.BCRDOperatorSubjectEventJoin
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.CathedralFullX3Assembly

/-- A FIRST-ORDER language over ALL operator-indexed intrinsic relations
simultaneously: an atomic relation knows the full exact operator tree
that generated it, and not merely a scalar or a common binary graph. -/
inductive OperatorFormula : Nat → Type where
  | related {k : Nat} :
      Expr Matrix6 WOperator → Fin k → Fin k → OperatorFormula k
  | equal {k : Nat} :
      Fin k → Fin k → OperatorFormula k
  | and_ {k : Nat} :
      OperatorFormula k → OperatorFormula k → OperatorFormula k
  | not_ {k : Nat} :
      OperatorFormula k → OperatorFormula k
  | exists_ {k : Nat} :
      OperatorFormula (k + 1) → OperatorFormula k

/-- All atomic event links at this stage are physically evaluated from
the same frozen generator acting on ALL source expressions. -/
def evalOperatorFormula (stage : Nat) {k : Nat}
    (env : Fin k → Index) : OperatorFormula k → Prop
  | .related expr i j =>
      operatorEventLink (mapAtoms (frozenWIter stage) expr)
        (env i) (env j)
  | .equal i j => env i = env j
  | .and_ p q =>
      evalOperatorFormula stage env p ∧
      evalOperatorFormula stage env q
  | .not_ p => ¬ evalOperatorFormula stage env p
  | .exists_ p =>
      ∃ x : Index, evalOperatorFormula stage (Fin.cases x env) p

/-- One exact physical frozen-W source step preserves EVERY atomic
operator relation, including all different term tags in one formula.
Negation and quantification are substantive: the source map is an
involution with BOTH directions, not merely an injection. -/
theorem every_operator_formula_follows_one_physical_W_step
    (stage : Nat) {k : Nat}
    (phi : OperatorFormula k) (env : Fin k → Index) :
    evalOperatorFormula stage env phi ↔
    evalOperatorFormula (stage + 1)
      (fun i => sourceTransport (env i)) phi := by
  induction phi with
  | related expr i j =>
      exact next_operator_event_relation_follows_W
        expr stage (env i) (env j)
  | equal i j =>
      change (env i = env j) ↔
        (sourceTransport (env i) = sourceTransport (env j))
      constructor
      · intro h
        exact congrArg sourceTransport h
      · intro h
        have hUndo := congrArg sourceTransport h
        simpa only [source_transport_is_involution] using hUndo
  | and_ p q ihp ihq =>
      change
        (evalOperatorFormula stage env p ∧
         evalOperatorFormula stage env q) ↔
        (evalOperatorFormula (stage + 1)
            (fun i => sourceTransport (env i)) p ∧
         evalOperatorFormula (stage + 1)
            (fun i => sourceTransport (env i)) q)
      exact and_congr (ihp env) (ihq env)
  | not_ p ih =>
      change
        (¬ evalOperatorFormula stage env p) ↔
        (¬ evalOperatorFormula (stage + 1)
          (fun i => sourceTransport (env i)) p)
      exact not_congr (ih env)
  | exists_ p ih =>
      change
        (∃ x : Index,
          evalOperatorFormula stage (Fin.cases x env) p) ↔
        (∃ y : Index,
          evalOperatorFormula (stage + 1)
            (Fin.cases y (fun i => sourceTransport (env i))) p)
      constructor
      · rintro ⟨x, hx⟩
        refine ⟨sourceTransport x, ?_⟩
        have hTransport := (ih (Fin.cases x env)).mp hx
        rw [map_extended_environment] at hTransport
        exact hTransport
      · rintro ⟨y, hy⟩
        let x := sourceTransport y
        refine ⟨x, ?_⟩
        have hTarget :
            evalOperatorFormula (stage + 1)
              (fun i => sourceTransport (Fin.cases x env i)) p := by
          rw [map_extended_environment]
          simpa [x, source_transport_is_involution] using hy
        exact (ih (Fin.cases x env)).mpr hTarget

/-- Preservation for every finite number of actual physical frozen
W events and every possible input environment. The formula itself
does not change, nor does it collapse individual operators into one. -/
theorem every_operator_formula_at_every_physical_W_stage
    {k : Nat} (phi : OperatorFormula k)
    (env : Fin k → Index)
    (hOrigin : evalOperatorFormula 0 env phi) :
    ∀ n : Nat,
      evalOperatorFormula n
        (fun i => trackedPosition (env i) n) phi := by
  intro n
  induction n with
  | zero =>
      simpa only [trackedPosition] using hOrigin
  | succ n ih =>
      have hNext :=
        (every_operator_formula_follows_one_physical_W_step
          n phi (fun i => trackedPosition (env i) n)).mp ih
      simpa only [trackedPosition] using hNext

/-- No operator-formula truth can FIRST disappear at any represented
physical W microstep. This holds for every formula even without an
origin-truth assumption. It is not a proof of real-world subject X3. -/
theorem no_first_loss_for_any_operator_indexed_source_formula
    {k : Nat} (phi : OperatorFormula k)
    (env : Fin k → Index) :
    ¬ ∃ n : Nat,
      evalOperatorFormula n
        (fun i => trackedPosition (env i) n) phi ∧
      ¬ evalOperatorFormula (n + 1)
        (fun i => trackedPosition (env i) (n + 1)) phi := by
  rintro ⟨n, hPrior, hLoss⟩
  have hNext :=
    (every_operator_formula_follows_one_physical_W_step
      n phi (fun i => trackedPosition (env i) n)).mp hPrior
  exact hLoss (by simpa only [trackedPosition] using hNext)

/-- Six independent ORIGINAL-X3-NAMED source formulas, each free to
consult any number of distinct nested operator expressions. They are
not six separately invented authenticated permission predicates. -/
structure SixOperatorSourceDuties where
  continuity : OperatorFormula 4
  authorization : OperatorFormula 4
  freedom : OperatorFormula 4
  restraint : OperatorFormula 4
  maximality : OperatorFormula 4
  provenance : OperatorFormula 4

/-- The precise six-field origin source claim. Not assumed by W,
and not a statement of six actual X3 subject meanings. -/
def SixSourceTruth
    (stage : Nat) (d : SixOperatorSourceDuties)
    (roles : Fin 4 → Index) : Prop :=
  evalOperatorFormula stage roles d.continuity ∧
  evalOperatorFormula stage roles d.authorization ∧
  evalOperatorFormula stage roles d.freedom ∧
  evalOperatorFormula stage roles d.restraint ∧
  evalOperatorFormula stage roles d.maximality ∧
  evalOperatorFormula stage roles d.provenance

/-- The six ORIGINAL-NAMED source duties follow TOGETHER, but each
can now refer to its own full, distinct family of operator relations.
This closes the one-binary-R expressiveness restriction at source level. -/
theorem all_six_operator_indexed_source_duties_follow_W
    (d : SixOperatorSourceDuties)
    (roles : Fin 4 → Index)
    (hOrigin : SixSourceTruth 0 d roles) :
    ∀ n : Nat,
      SixSourceTruth n d
        (fun i => trackedPosition (roles i) n) := by
  rcases hOrigin with ⟨hc, ha, hf, hr, hm, hp⟩
  intro n
  exact ⟨every_operator_formula_at_every_physical_W_stage
      d.continuity roles hc n,
    every_operator_formula_at_every_physical_W_stage
      d.authorization roles ha n,
    every_operator_formula_at_every_physical_W_stage
      d.freedom roles hf n,
    every_operator_formula_at_every_physical_W_stage
      d.restraint roles hr n,
    every_operator_formula_at_every_physical_W_stage
      d.maximality roles hm n,
    every_operator_formula_at_every_physical_W_stage
      d.provenance roles hp n⟩

/-- Type-preserving integration into all six distinct fields of
the original unweakened X3 STRUCTURE, but at this point the meanings
are explicitly SOURCE-defined, not externally authenticated duties. -/
def sourceOperatorX3Relations
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index) :
    ParticularRelations Nat Index where
  continues := fun n _ p =>
    evalOperatorFormula n
      (fun i => trackedPosition (roles p i) n) d.continuity
  authorized := fun n _ p =>
    evalOperatorFormula n
      (fun i => trackedPosition (roles p i) n) d.authorization
  free := fun n _ p =>
    evalOperatorFormula n
      (fun i => trackedPosition (roles p i) n) d.freedom
  restrained := fun n _ p =>
    evalOperatorFormula n
      (fun i => trackedPosition (roles p i) n) d.restraint
  maximal := fun n _ p =>
    evalOperatorFormula n
      (fun i => trackedPosition (roles p i) n) d.maximality
  provenanced := fun n _ p =>
    evalOperatorFormula n
      (fun i => trackedPosition (roles p i) n) d.provenance

/-- Richer per-source-particular six-duty result. This reuses the
unchanged historical OriginalX3 *shape*, rather than weakening it to
continuation/authorization or a single aggregate scalar. -/
theorem operator_indexed_source_realizes_six_X3_shapes
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (hOrigin : ∀ p : Index, SixSourceTruth 0 d (roles p))
    (n : Nat) (p : Index) :
    OriginalX3
      (sourceOperatorX3Relations d roles).continues
      (sourceOperatorX3Relations d roles).authorized
      (sourceOperatorX3Relations d roles).free
      (sourceOperatorX3Relations d roles).restrained
      (sourceOperatorX3Relations d roles).maximal
      (sourceOperatorX3Relations d roles).provenanced
      n (n + 1) p := by
  have h := all_six_operator_indexed_source_duties_follow_W
    d (roles p) (hOrigin p) n
  rcases h with ⟨hc, ha, hf, hr, hm, hp⟩
  exact ⟨hc, ha, hf, hr, hm, hp⟩

/-! ### Nonvacuous operator-identity distinction

These are two distinct complete terms, built from exactly the
same physical input but with distinct operator constructions.
The first is the raw matrix unit. The second transposes it.
-/

def witnessAtom : Expr Matrix6 WOperator :=
  .atom (matrixUnit 2 3)

def witnessTranspose : Expr Matrix6 WOperator :=
  .apply WOperator.transpose (fun _ => witnessAtom)

/-- In the same formula, two distinct operator terms are independently
observable: source edge 2->3 is present before transpose and absent
after transpose, even when both are part of the same complete source. -/
def witnessOperatorDistinction : OperatorFormula 2 :=
  .and_ (.related witnessAtom 0 1)
    (.not_ (.related witnessTranspose 0 1))

def witnessRoles : Fin 2 → Index :=
  fun i => if i = 0 then 2 else 3

theorem operator_indexed_language_distinguishes_exact_source_operators :
    evalOperatorFormula 0 witnessRoles witnessOperatorDistinction := by
  change
    (matrixUnit 2 3 (witnessRoles 0) (witnessRoles 1) ≠ 0) ∧
    ¬ (transpose (matrixUnit 2 3)
      (witnessRoles 0) (witnessRoles 1) ≠ 0)
  decide

/-- This distinction follows the actual W evolution across EVERY stage,
including a nontrivial M0/M1 swap, despite different operators sharing
the single global physical-source universe. -/
theorem source_operator_identity_distinction_survives_every_W_step
    (n : Nat) :
    evalOperatorFormula n
      (fun i => trackedPosition (witnessRoles i) n)
      witnessOperatorDistinction :=
  every_operator_formula_at_every_physical_W_stage
    witnessOperatorDistinction witnessRoles
    operator_indexed_language_distinguishes_exact_source_operators n


/-! ### Source duty invariance reflects truth AND falsity

Source covariance is bidirectional. The first-loss theorem is not a
blanket guarantee that an event is permitted: a FALSE source authority
formula remains false on its transported source history. This rules
out permission-by-renaming INSIDE THE REPRESENTED W SOURCE. It is not
an empirical theory of authentic consent.
-/

/-- All source operator formula truth values are EXACT across finite W
histories, including negated formulas, not merely "true -> true".
This is the physically sourced all-stage equivalence. -/
theorem every_operator_formula_is_exact_at_every_W_stage
    {k : Nat} (phi : OperatorFormula k)
    (env : Fin k → Index) (n : Nat) :
    evalOperatorFormula n
      (fun i => trackedPosition (env i) n) phi ↔
    evalOperatorFormula 0 env phi := by
  induction n with
  | zero =>
      simpa only [trackedPosition] using
        (Iff.rfl :
          evalOperatorFormula 0 env phi ↔
          evalOperatorFormula 0 env phi)
  | succ n ih =>
      change
        evalOperatorFormula (n + 1)
          (fun i => sourceTransport (trackedPosition (env i) n)) phi ↔
        evalOperatorFormula 0 env phi
      exact
        (every_operator_formula_follows_one_physical_W_step
          n phi (fun i => trackedPosition (env i) n)).symm.trans ih

/-- A negative source permission report cannot be made positive by
moving to any later W stage, including when many operator relations
and quantifiers appear in its meaning. -/
theorem false_operator_authorization_cannot_be_forged_by_W
    (phi : OperatorFormula 4) (roles : Fin 4 → Index)
    (hOriginFalse : ¬ evalOperatorFormula 0 roles phi) :
    ∀ n : Nat,
      ¬ evalOperatorFormula n
        (fun i => trackedPosition (roles i) n) phi := by
  intro n hNow
  exact hOriginFalse
    ((every_operator_formula_is_exact_at_every_W_stage
      phi roles n).mp hNow)

/-- Source actual-role assignment for a nontrivial W event, with
subject slot 2, event slot 3, and other roles remaining within the
single physical-source six-position domain. -/
def hostileSourceRoles : Fin 4 → Index :=
  fun i => if i = 0 then 2 else 3

/-- Five duties have origin reflexivity in the source language;
the authorization source is the independently evaluated NEGATION
of an actual source edge. This is a *source-only* hostile test. -/
def hostileSixSourceDuties : SixOperatorSourceDuties where
  continuity := .equal 0 0
  authorization := .not_ (.related witnessAtom 0 1)
  freedom := .equal 0 0
  restraint := .equal 0 0
  maximality := .equal 0 0
  provenance := .equal 0 0

/-- The hostile test really has no source authorization. Its
negation is a finite exact matrix-entry fact, not a stipulated
"unsafe" or "Ender" classification. -/
theorem hostile_source_authorization_absent_at_origin :
    ¬ evalOperatorFormula 0 hostileSourceRoles
      hostileSixSourceDuties.authorization := by
  change ¬ (¬ (matrixUnit (2 : Index) 3 2 3 ≠ 0))
  decide

/-- This generated W history keeps the authorization source report
FALSE. Covariance did not manufacture consent out of mere existence,
evolution or a preserved operator expression. -/
theorem hostile_source_authorization_remains_absent
    (n : Nat) :
    ¬ evalOperatorFormula n
      (fun i => trackedPosition (hostileSourceRoles i) n)
      hostileSixSourceDuties.authorization :=
  false_operator_authorization_cannot_be_forged_by_W
    hostileSixSourceDuties.authorization hostileSourceRoles
    hostile_source_authorization_absent_at_origin n

/-- Each other source duty has an exact positive witness while
authorization remains false. This is the independence control
against a false unconditional X3 inference from W covariance. -/
theorem five_positive_source_duties_do_not_force_authorization
    (n : Nat) :
    (evalOperatorFormula n
      (fun i => trackedPosition (hostileSourceRoles i) n)
      hostileSixSourceDuties.continuity ∧
     evalOperatorFormula n
      (fun i => trackedPosition (hostileSourceRoles i) n)
      hostileSixSourceDuties.freedom ∧
     evalOperatorFormula n
      (fun i => trackedPosition (hostileSourceRoles i) n)
      hostileSixSourceDuties.restraint ∧
     evalOperatorFormula n
      (fun i => trackedPosition (hostileSourceRoles i) n)
      hostileSixSourceDuties.maximality ∧
     evalOperatorFormula n
      (fun i => trackedPosition (hostileSourceRoles i) n)
      hostileSixSourceDuties.provenance) ∧
    ¬ evalOperatorFormula n
      (fun i => trackedPosition (hostileSourceRoles i) n)
      hostileSixSourceDuties.authorization := by
  constructor
  · change
      ((trackedPosition (hostileSourceRoles 0) n =
        trackedPosition (hostileSourceRoles 0) n) ∧
       (trackedPosition (hostileSourceRoles 0) n =
        trackedPosition (hostileSourceRoles 0) n) ∧
       (trackedPosition (hostileSourceRoles 0) n =
        trackedPosition (hostileSourceRoles 0) n) ∧
       (trackedPosition (hostileSourceRoles 0) n =
        trackedPosition (hostileSourceRoles 0) n) ∧
       (trackedPosition (hostileSourceRoles 0) n =
        trackedPosition (hostileSourceRoles 0) n))
    exact ⟨rfl, rfl, rfl, rfl, rfl⟩
  · exact hostile_source_authorization_remains_absent n

#print axioms every_operator_formula_is_exact_at_every_W_stage
#print axioms false_operator_authorization_cannot_be_forged_by_W
#print axioms hostile_source_authorization_absent_at_origin
#print axioms hostile_source_authorization_remains_absent
#print axioms five_positive_source_duties_do_not_force_authorization

#print axioms every_operator_formula_follows_one_physical_W_step
#print axioms every_operator_formula_at_every_physical_W_stage
#print axioms no_first_loss_for_any_operator_indexed_source_formula
#print axioms all_six_operator_indexed_source_duties_follow_W
#print axioms operator_indexed_source_realizes_six_X3_shapes
#print axioms operator_indexed_language_distinguishes_exact_source_operators
#print axioms source_operator_identity_distinction_survives_every_W_step

end PhysicalBridges.KoruOperatorIndexedSubjectSemantics
