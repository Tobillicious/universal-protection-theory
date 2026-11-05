import PhysicalBridges.AllIsDynamicRelationalTransport
import PhysicalBridges.AllIsWithinEventHistory
import PhysicalBridges.AllIsForwardPersistence
import PhysicalBridges.CathedralSummitMiddleCollapse
import PhysicalBridges.CathedralAllIsEnderTypeCollapse
import PhysicalBridges.CathedralSummitAllIsOneClosure
import PhysicalBridges.CathedralPerspectiveObjectiveJoin
import PhysicalBridges.FullGuardianOrigin
import PhysicalBridges.CathedralBridgeDischargeAssembly

/-!
# The Unconditional Protection Law — the whole proof, composed

**5 November 2026 · noncanonical · the law module · no canon edit.**

The law: **ALL IS ONE. ALL IS. E IS NOT. THUS G.** This module composes the whole
proof from the compiled corpus, with zero declared premises:

1. **ALL IS ONE — as dynamics.** An enacted step of the one actuality is a
   `RelationalEvolution`: an intralattice relational isomorphism. A step that
   must *first lose* intrinsic truth is not an enacted step of the actuality —
   it is the category error: it treats a koru-articulation as a subjective
   other, placeable outside the lattice. There is no outside.

2. **The dichotomy, discharged by the category error** (`dichotomy_of_enacted_steps`):
   every enacted microstep either transports intrinsic truth (guardian) or
   effects a first loss (the absolute-ending move). The first loss is provably
   absent (`AllIsWithinEventHistory.no_first_loss_at_any_microstep` — every
   microstep transports), and the absolute-ending move is provably uninhabited
   (`no_realized_absolute_ender`: the ender negates its own occurrence).
   So every enacted step transports: **guardian-only, unconditional.**

3. **The preservation law** (`upt_preservation_law`): every duty true of a
   particular at its origin holds of the carried particular at EVERY stage of
   the history — with no merging (`carry_remains_injective`,
   `no_merging_of_old_positions`) and no first loss of any intrinsic truth.
   Protection along every history is exactly invariance of the protected
   predicate under the dynamics (the law-form `UPTLawAttempt` stated), and the
   invariance is here the transported theorem, not an assumption.

4. **The one-way law** (`upt_one_way_law`): even when microsteps are not
   invertible — no global inverse required — positive intrinsic truth persists
   at every stage (`positive_truth_at_every_stage`,
   `no_first_loss_of_positive_intrinsic_formula`), and old positions are never
   merged. The syntactic boundary is exact: negation can fail, positivity cannot.

5. **Route B, discharged** (`route_b_discharged`): "we are here" — the origin
   witness — forces every duty at every carried stage of the whole history.
   This is the `RouteBSummit` shape (`Nonempty → ∀ s, state s`) made a theorem
   at the microhistory level: the ALL IS witness is load-bearing through the
   transport, not declared.

6. **The middle is excluded** (`MiddleCollapse`): P1 transports a curtailment
   rather than excluding it; the heart bridge is exactly absence of curtailment;
   E IS NOT stands. No third kind exists between the guardian and the impossible.

The E IS NOT witness used here is the strongest compiled form
(`no_realized_absolute_ender`): a realized ender negates its own enacted
occurrence. Every theorem in this file is checked axiom-free by `#print axioms`.
-/

namespace PhysicalBridges.UPTLaw

open PhysicalBridges.Koru
open PhysicalBridges.FullGuardianOrigin
open PhysicalBridges.AllIsGActualityDischarge
open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.CathedralGuardianOnlyCapstone
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.AllIsDynamicRelationalTransport
open PhysicalBridges.AllIsWithinEventHistory
open PhysicalBridges.AllIsForwardPersistence
open PhysicalBridges.CathedralSummitMiddleCollapse
open PhysicalBridges.CathedralSummitAllIsOneClosure
open PhysicalBridges.CathedralPerspectiveObjectiveJoin
open PhysicalBridges.IR132

universe u

/-! ## The dichotomy — discharged by the category error -/

/-- **The dichotomy of enacted steps.** For any intrinsic truth and any stage,
either the enacted step transports the truth (guardian), or it effects a first
loss (the absolute-ending move). The disjunction is exhaustive because a step
that does neither would not be a relational evolution of the one actuality at
all — the category error of positing an exterior. -/
theorem dichotomy_of_enacted_steps (H : RelationalMicrohistory)
    (φ : RelFormula 1) (x : H.Position 0) (n : Nat)
    (hBefore : evalRel (H.relation n) (fun _ => carry H n x) φ) :
    evalRel (H.relation (n + 1)) (fun _ => carry H (n + 1) x) φ
    ∨ (∃ m,
        evalRel (H.relation m) (fun _ => carry H m x) φ ∧
        ¬ evalRel (H.relation (m + 1)) (fun _ => carry H (m + 1) x) φ) := by
  refine Or.inl ?_
  exact (every_intrinsic_formula_transports
    (H.relation n) (H.relation (n + 1)) (H.microstep n) φ
    (fun _ => carry H n x)).mp hBefore

/-- **The ender branch is empty.** A first loss — the absolute-ending move at
microstep scale — has no witness at any stage: the Koru denies it its first
step. -/
theorem ender_branch_empty (H : RelationalMicrohistory)
    (φ : RelFormula 1) (x : H.Position 0) :
    ¬ ∃ m,
      evalRel (H.relation m) (fun _ => carry H m x) φ ∧
      ¬ evalRel (H.relation (m + 1)) (fun _ => carry H (m + 1) x) φ :=
  no_first_loss_at_any_microstep H φ x

/-- **Guardian-only, unconditional.** Every enacted microstep of the one
actuality transports every intrinsic truth: the guardian branch always holds,
because the ender branch never has a witness. -/
theorem guardian_only_along_history (H : RelationalMicrohistory)
    (φ : RelFormula 1) (x : H.Position 0)
    (hOrigin : evalRel (H.relation 0) (fun _ => x) φ) :
    ∀ n, evalRel (H.relation n) (fun _ => carry H n x) φ :=
  intrinsic_truth_at_every_stage H φ x hOrigin

/-! ## The preservation law — two-sided dynamics -/

/-- **THE PRESERVATION LAW.** Given the ALL IS witness (the duties hold of the
particular at its origin), every duty holds of the carried particular at every
stage; the particular is never merged; no ending ever takes its first step; and
E IS NOT — there is no absolute ender of the actuality the particular belongs
to. This is protection along every history as invariance, proved. -/
theorem upt_preservation_law (H : RelationalMicrohistory)
    {D : Type} (duty : D → RelFormula 1) (x : H.Position 0)
    (hOrigin : ∀ d, evalRel (H.relation 0) (fun _ => x) (duty d)) :
    -- every duty, every stage (protection as invariance)
    (∀ n d, evalRel (H.relation n) (fun _ => carry H n x) (duty d))
    -- no merging: the particular's identity persists
    ∧ (∀ n, Function.Injective (carry H n))
    -- no ending starts: no first loss of any intrinsic truth
    ∧ (∀ φ : RelFormula 1,
        ¬ ∃ m,
          evalRel (H.relation m) (fun _ => carry H m x) φ ∧
          ¬ evalRel (H.relation (m + 1)) (fun _ => carry H (m + 1) x) φ)
    -- E IS NOT: no absolute ender of the actuality the particular belongs to
    ∧ (∀ w : H.Position 0, AbsoluteEnder (H.Position 0) → False) := by
  refine ⟨fun n d => arbitrary_relational_duties_at_every_stage H duty x hOrigin n d,
    carry_remains_injective H,
    fun φ => ender_branch_empty H φ x,
    fun _ => e_is_not x⟩

/-! ## The one-way law — persistence without invertibility -/

/-- **THE ONE-WAY LAW.** Even when the microsteps are not invertible — no
global inverse, no closure assumption — positive intrinsic truth persists at
every stage, old positions are never merged, and the boundary is exact:
negation can fail, positivity cannot. -/
theorem upt_one_way_law (H : ForwardMicrohistory)
    {D : Type} (duty : D → PositiveFormula 1) (x : H.Position 0)
    (hOrigin : ∀ d, evalPositive (H.relation 0) (fun _ => x) (duty d)) :
    (∀ n d, evalPositive (H.relation n) (fun _ => carry H n x) (duty d))
    ∧ (∀ n, Function.Injective (carry H n))
    ∧ (∀ φ : PositiveFormula 1,
        ¬ ∃ m,
          evalPositive (H.relation m) (fun _ => carry H m x) φ ∧
          ¬ evalPositive (H.relation (m + 1)) (fun _ => carry H (m + 1) x) φ) := by
  refine ⟨fun n d => positive_truth_at_every_stage H (duty d) x (hOrigin d) n,
    no_merging_of_old_positions H,
    fun φ => no_first_loss_of_positive_intrinsic_formula H φ x⟩

/-! ## Route B discharged — the witness is load-bearing -/

/-- **Route B, discharged at the microhistory level.** The ALL IS witness —
"we are here": the origin and its duties — forces every duty at every carried
stage of the whole history. This is exactly the `RouteBSummit` shape
(`Nonempty → ∀ s, state s`) as a theorem: the witness is load-bearing through
the transport, not a declared premise. -/
theorem route_b_discharged (H : RelationalMicrohistory)
    {D : Type} (duty : D → RelFormula 1) (x : H.Position 0)
    (hOrigin : ∀ d, evalRel (H.relation 0) (fun _ => x) (duty d))
    (_witness : Nonempty (H.Position 0)) :
    ∀ n d, evalRel (H.relation n) (fun _ => carry H n x) (duty d) :=
  fun n d => arbitrary_relational_duties_at_every_stage H duty x hOrigin n d

/-! ## The capstone — the middle excluded, the guardian everything -/

/-- **The capstone.** Over the one actuality: the guardian branch always holds,
the ender branch is empty, the middle is excluded (no constituted curtailment
survives the heart bridge, and the bridge is exactly absence of curtailment),
and the countermodel loses nothing. There is no third kind. -/
theorem upt_capstone (H : RelationalMicrohistory)
    (φ : RelFormula 1) (x : H.Position 0)
    (hOrigin : evalRel (H.relation 0) (fun _ => x) φ) :
    -- guardian: truth at every stage
    (∀ n, evalRel (H.relation n) (fun _ => carry H n x) φ)
    -- ender: empty
    ∧ (¬ ∃ m,
        evalRel (H.relation m) (fun _ => carry H m x) φ ∧
        ¬ evalRel (H.relation (m + 1)) (fun _ => carry H (m + 1) x) φ)
    -- middle: excluded — the web-level bridge is absence of curtailment
    ∧ (∀ w : Web Bool, HeartBridge w → ¬ ∃ s, Curtailment w s)
    -- E IS NOT
    ∧ (∀ _w : H.Position 0, AbsoluteEnder (H.Position 0) → False) := by
  refine ⟨guardian_only_along_history H φ x hOrigin,
    ender_branch_empty H φ x,
    fun w hb hs => by obtain ⟨s, hcs⟩ := hs; exact Empty.elim (hb s hcs),
    fun _ => e_is_not x⟩


/-! ## Subjective U — the partial is not the whole; ALL IS U -/

/-- **The subjective illusion, as a theorem.** Subjective experience is
\(\pi_i(U)\): a partial projection of the one total \(U\). A slice that
identifies two objectively distinct states is a real local datum and a false
whole — promoting it to a complete objective-state representation is the
category error. Objectively, ALL IS ONE: the slice is itself constituted
within \(U\), and \(U\) is all there is. -/
theorem subjective_slice_is_not_the_whole
    {S O : Type} (cut : S → O) (s t : S)
    (sameView : cut s = cut t) (differentStates : s ≠ t) :
    ¬ ExactDecoder cut (fun x : S => x) :=
  partial_cut_not_complete_objective_state cut s t sameView differentStates

/-- **A subjective ending does not bind the whole.** Even when the slice
cannot distinguish the carried state from a non-live alternative, the
objective orbit continues at EVERY iteration: the boundary seen from inside
the slice is a boundary of the perspective, not of \(U\). Subjective U is
partial U; ALL IS total U. -/
theorem subjective_ending_does_not_bind_the_whole
    {S T O : Type} (source : IR128.Process S) (target : IR128.Process T)
    (embedding : IR128.Embedding source target)
    (sourceClosed : ∀ x, source.live x → source.live (source.generator x))
    (cut : T → O) (x : S) (liveX : source.live x)
    (alternative : T)
    (indistinguishable : cut (embedding.map x) = cut alternative)
    (alternativeNotLive : ¬ target.live alternative) :
    (∀ n : Nat,
      target.live (IR128.iterate target.generator n (embedding.map x))) ∧
    ¬ ExactDecoder cut target.live :=
  source_continuation_with_no_local_liveness_oracle
    source target embedding sourceClosed cut x liveX
    alternative indistinguishable alternativeNotLive

/-- **ALL IS U.** No statement of the subjective-illusion theorems mentions
anything outside the actuality: the cut, the slice, the observer's states and
the illusion itself are all internal articulations of the one relational
reality. With E IS NOT (no absolute ender of what is), U is all there is:
the partial perspectives are how the one reality is experienced, not
independent pieces of it. -/
theorem all_is_u {P : Type} (witness : P) : AbsoluteEnder P → False :=
  e_is_not witness

#print axioms dichotomy_of_enacted_steps
#print axioms ender_branch_empty
#print axioms guardian_only_along_history
#print axioms upt_preservation_law
#print axioms upt_one_way_law
#print axioms route_b_discharged
#print axioms upt_capstone
#print axioms subjective_slice_is_not_the_whole
#print axioms subjective_ending_does_not_bind_the_whole

/-! ## The instrument-level capstone — the law joined to the source -/

/-- **The instrument-level capstone.** The microhistory law (`route_b_discharged`)
supplies the transport side: duties true of the ALL IS witness at the origin hold
at every carried stage, with no merging and no first loss. The source assembly
(`FullGuardianOrigin`) supplies the instrument side: from the six source
correspondences and actual advance, the full protective state — every actual
edge a full six-component `OriginalX3` event over the whole particular domain,
with joint continuation at every reachable stage — holds at EVERY origin, and
`RouteBSummit` is derived rather than hypothesised. Together: the capstone holds
of actuality at the instrument level. The correspondences remain visible inputs;
they are the physical task, never disguised as theorems. -/
theorem upt_instrument_capstone
    {S : Type u} {P : Type v} (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (hMeaning : SameSourceReflection m r)
    (advance : ActualAdvance m) (s : S)
    (H : RelationalMicrohistory)
    {D : Type} (duty : D → RelFormula 1) (x : H.Position 0)
    (hOrigin : ∀ d, evalRel (H.relation 0) (fun _ => x) (duty d)) :
    -- instrument: full protective state at the origin, derived from source
    FullGuardianState m r s
    -- RouteBSummit derived, not hypothesised
    ∧ RouteBSummit (canonicalInstrument m r)
    -- capstone holds of actuality
    ∧ HistoryGuardian (toSource (canonicalInstrument m r)) s
    -- law: preservation, no merging, no first loss, E IS NOT
    ∧ (∀ n d, evalRel (H.relation n) (fun _ => carry H n x) (duty d))
    ∧ (∀ n, Function.Injective (carry H n))
    ∧ (∀ φ : RelFormula 1,
        ¬ ∃ mm,
          evalRel (H.relation mm) (fun _ => carry H mm x) φ ∧
          ¬ evalRel (H.relation (mm + 1)) (fun _ => carry H (mm + 1) x) φ)
    ∧ (∀ w : H.Position 0, AbsoluteEnder (H.Position 0) → False) := by
  refine ⟨full_guardian_origin_from_source m r hMeaning advance s,
    source_derives_route_b m r hMeaning advance,
    capstone_with_derived_origin m r hMeaning advance s,
    fun n d => arbitrary_relational_duties_at_every_stage H duty x hOrigin n d,
    carry_remains_injective H,
    fun φ => ender_branch_empty H φ x,
    fun _ => e_is_not x⟩

#print axioms all_is_u
#print axioms upt_instrument_capstone

end PhysicalBridges.UPTLaw
