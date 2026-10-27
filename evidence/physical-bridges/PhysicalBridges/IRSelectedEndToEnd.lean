/-
IR-selected-end-to-end: source-level integration of IR-17 into the actual
IR-10 composition. Supplies one selected observation-uniform policy,
rather than universal implementation, and forbids only excluded strict
improvers rather than requiring global safe-menu cofinality.
The original UPT order and full feasible set remain unchanged.
Physical correspondence and semantic premises remain conditional.
-/
import PhysicalBridges.IREndToEnd
import PhysicalBridges.IRSelectedMaximality

namespace PhysicalBridges.IRSelectedEndToEnd
open UPTController
universe v w x y z t
variable {S : Type} {R : Type v} {Obs : Type w} {Act : Type x}
variable {Dist : Type y} {Outcome : Type z} {Particular : Type t}

/-- A single certificate ties together:
(1) the *actual unchanged* source-level certified hold,
(2) a greatest robust invariant candidate at a verified fixed point,
(3) an observation-only policy really implementing a selected outcome,
(4) bounded physical effects, (5) concrete/record finite-step simulation,
(6) maximality of that same implemented outcome under the ORIGINAL full
UPT order, not a weakened safety-filtered version.

The implementation, interface, selected-exclusion, and semantic fidelity assumptions
are load-bearing parameters and have not been discharged for real hardware. -/
theorem selected_conditional_end_to_end_certificate
    (next : S → Act → Dist → S)
    (observe : S → Obs) (metric report : S → Nat)
    (influences : S → Act → Dist → List Nat)
    (epsilon drift jump budget limit k : Nat)
    (hStable : ∀ s,
      IRKernelConstruction.Prune next (IREndToEnd.Kernel next metric limit k) s ↔
      IREndToEnd.Kernel next metric limit k s)
    (beforePhysical afterPhysical : S)
    (hInitiallyViable : IREndToEnd.Kernel next metric limit k beforePhysical)

    -- Exact inherited controller, held target, and authenticated receipts.
    (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (hRetired : (step enrol (run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (hNoRelease : ∀ d, Op.release d ∉ during)
    (target : UPTFence.St) (attempts : List UPTFence.Ev)
    (hTokens : ∀ g, g ∈ target.minted →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (hLaterTokens : ∀ g, UPTFence.Ev.mint g ∈ attempts →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (physicalOfLog : List Nat → S)
    (hBeforeLog : beforePhysical = physicalOfLog target.log)
    (hAfterLog : afterPhysical = physicalOfLog
      (UPTFence.run (UPTFence.apply target (.raise (c.generation + 1))) attempts).log)

    -- Application-time physical bounds apply to each reachable viable state.
    (hSensor : ∀ s, IREndToEnd.Kernel next metric limit k s →
      metric s ≤ report s + epsilon)
    (hBudget : ∀ (s : S) (a : Act) (d : Dist), IREndToEnd.Kernel next metric limit k s →
      (influences s a d).sum ≤ budget)
    (hEvolution : ∀ (s : S) (a : Act) (d : Dist), IREndToEnd.Kernel next metric limit k s →
      metric (next s a d) ≤ metric s + drift + (influences s a d).sum + jump)
    (hGate : ∀ (s : S) (a : Act), IREndToEnd.Kernel next metric limit k s →
      report s + epsilon + drift + budget + jump ≤ limit)

    -- Abstract record must genuinely track concrete state under EACH event.
    (rel : S → R → Prop) (abstractStep : R → Dist → R)
    (recordObs : R → Obs) (recordStart : R)
    (hRelated : rel afterPhysical recordStart)
    (hObserved : ∀ s r, rel s r → observe s = recordObs r)
    (hRefines : ∀ policy : Obs → Act,
      (∀ o, IRObservedViability.UniformKeeper observe next
        (IREndToEnd.Kernel next metric limit k) o (policy o)) →
      IRContinuation.StepRefines rel
        (fun s d => next s (policy (observe s)) d) abstractStep)

    -- Selected policy must be executable and certified in the ORIGINAL
    -- full feasible space and stagewise order.
    (keys : List (Outcome → Particular → Prop))
    (full : Outcome → Prop) (safeMenu : List Outcome)
    (hIncluded : ∀ o, o ∈ safeMenu → full o)
    (chosen : Outcome) (policy : Obs → Act)
    (hLocal : UPTExist.LexAlignedL (fun o => o ∈ safeMenu) keys chosen)
    (hNoOutside : IRSelectedMaximality.NoExcludedImprover
      keys full safeMenu chosen)
    (realises : (Obs → Act) → Outcome → Prop)
    (hUniform : ∀ o, IRObservedViability.UniformKeeper observe next
      (IREndToEnd.Kernel next metric limit k) o (policy o))
    (hRealises : realises policy chosen) :
    ∃ (chosen : Outcome) (policy : Obs → Act),
      chosen ∈ safeMenu ∧
      UPTExist.LexAlignedL full keys chosen ∧
      realises policy chosen ∧
      afterPhysical = beforePhysical ∧
      (∀ I : S → Prop,
        IRKernelConstruction.Inside I (fun s => metric s ≤ limit) →
        (∀ s, I s → ∃ a : Act, ∀ d : Dist, I (next s a d)) →
        IRKernelConstruction.Inside I (IREndToEnd.Kernel next metric limit k)) ∧
      (∀ trace : List Dist,
        let finalState := IRViability.run next
          (fun s => policy (observe s)) afterPhysical trace
        IREndToEnd.Kernel next metric limit k finalState ∧
        metric finalState ≤ limit ∧
        observe finalState =
          recordObs (CodexObservation.after abstractStep recordStart trace)) ∧
      (∀ s d, IREndToEnd.Kernel next metric limit k s →
        metric (next s (policy (observe s)) d) ≤ limit) := by
  have hChosen : chosen ∈ safeMenu := hLocal.1
  have hGlobal : UPTExist.LexAlignedL full keys chosen :=
    IRSelectedMaximality.selected_safety_maximal_lifts_globally
      keys full safeMenu hIncluded chosen hLocal hNoOutside
  have hHeld : afterPhysical = beforePhysical :=
    IRControllerPhysical.certified_hold_physical_refinement
      enrol start before during c hRetired hNoRelease
      target attempts hTokens hLaterTokens
      physicalOfLog beforePhysical afterPhysical hBeforeLog hAfterLog
  have hKernelAfter : IREndToEnd.Kernel next metric limit k afterPhysical := by
    rw [hHeld]
    exact hInitiallyViable
  have hGreatest :=
    (IRKernelConstruction.stabilised_approx_is_greatest_invariant
      next (fun s => metric s ≤ limit) k hStable).2.2
  have hKernelToSafe :=
    IRKernelConstruction.approx_inside_initial next
      (fun s => metric s ≤ limit) k
  have hRunKernel :=
    IRObservedViability.observable_policy_preserves_kernel
      observe next (IREndToEnd.Kernel next metric limit k) policy hUniform
  have hPostEffect :=
    IREndToEnd.physically_guarded_observable_action
      next observe policy metric report influences
      epsilon drift jump budget limit (IREndToEnd.Kernel next metric limit k)
      hSensor hBudget hEvolution hGate
  have hMatched (trace : List Dist) :
      observe (IRViability.run next
        (fun s => policy (observe s)) afterPhysical trace) =
      recordObs (CodexObservation.after abstractStep recordStart trace) := by
    calc
      observe (IRViability.run next
        (fun s => policy (observe s)) afterPhysical trace) =
        observe (CodexObservation.after
          (fun s d => next s (policy (observe s)) d)
          afterPhysical trace) := by
            rw [IREndToEnd.policy_run_matches_source_trace]
      _ = recordObs (CodexObservation.after
          abstractStep recordStart trace) :=
        IRContinuation.future_observations_agree_under_refinement
          rel (fun s d => next s (policy (observe s)) d)
          abstractStep observe recordObs (hRefines policy hUniform)
          hObserved afterPhysical recordStart hRelated trace
  refine ⟨chosen, policy, hChosen, hGlobal, hRealises, hHeld,
    hGreatest, ?_, hPostEffect⟩
  intro trace
  have hK := hRunKernel trace afterPhysical hKernelAfter
  exact ⟨hK, hKernelToSafe _ hK, hMatched trace⟩




#print axioms selected_conditional_end_to_end_certificate
end PhysicalBridges.IRSelectedEndToEnd
