/-
IR-20: revised source-level end-to-end composition. Retains every physical,
controller, kernel and record premise in IR-10, but removes two needlessly
strong scope assumptions:
* global cofinality of an entire safe menu;
* realisation of every item in that menu by an available policy.
Instead a selected menu maximum must have no omitted full-feasible
improver, and THIS selected outcome must have an observable realising policy.

Original UPT full feasibility and all its lexicographic priorities remain
unchanged. Physical/semantic installation assumptions are still explicit.
-/
import PhysicalBridges.IREndToEnd
import PhysicalBridges.IRSelectedMaximality

namespace PhysicalBridges.IRSelectedEndToEnd
open UPTController
open PhysicalBridges.IREndToEnd
universe v w x y z t
variable {S : Type} {R : Type v} {Obs : Type w} {Act : Type x}
variable {Dist : Type y} {Outcome : Type z} {Particular : Type t}

theorem selected_end_to_end_certificate
    (next : S → Act → Dist → S)
    (observe : S → Obs) (metric report : S → Nat)
    (influences : S → Act → Dist → List Nat)
    (epsilon drift jump budget limit k : Nat)
    (hStable : ∀ s,
      IRKernelConstruction.Prune next (Kernel next metric limit k) s ↔
      Kernel next metric limit k s)
    (beforePhysical afterPhysical : S)
    (hInitiallyViable : Kernel next metric limit k beforePhysical)

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
    (hSensor : ∀ s, Kernel next metric limit k s →
      metric s ≤ report s + epsilon)
    (hBudget : ∀ (s : S) (a : Act) (d : Dist), Kernel next metric limit k s →
      (influences s a d).sum ≤ budget)
    (hEvolution : ∀ (s : S) (a : Act) (d : Dist), Kernel next metric limit k s →
      metric (next s a d) ≤ metric s + drift + (influences s a d).sum + jump)
    (hGate : ∀ (s : S) (a : Act), Kernel next metric limit k s →
      report s + epsilon + drift + budget + jump ≤ limit)

    -- Abstract record must genuinely track concrete state under EACH event.
    (rel : S → R → Prop) (abstractStep : R → Dist → R)
    (recordObs : R → Obs) (recordStart : R)
    (hRelated : rel afterPhysical recordStart)
    (hObserved : ∀ s r, rel s r → observe s = recordObs r)
    (hRefines : ∀ policy : Obs → Act,
      (∀ o, IRObservedViability.UniformKeeper observe next
        (Kernel next metric limit k) o (policy o)) →
      IRContinuation.StepRefines rel
        (fun s d => next s (policy (observe s)) d) abstractStep)

    -- The selected, actually implemented safe outcome is locally maximal.
    -- Only improvement over this selected outcome is checked outside the menu.
    (keys : List (Outcome → Particular → Prop))
    (full : Outcome → Prop) (safeMenu : List Outcome)
    (hIncluded : ∀ o, o ∈ safeMenu → full o)
    (selected : Outcome)
    (hLocal : UPTExist.LexAlignedL
      (fun o => o ∈ safeMenu) keys selected)
    (hNoExcludedImprover :
      IRSelectedMaximality.NoExcludedImprover keys full safeMenu selected)
    (realises : (Obs → Act) → Outcome → Prop)
    (hSelectedPolicy :
      ∃ policy : Obs → Act,
        (∀ o, IRObservedViability.UniformKeeper observe next
          (Kernel next metric limit k) o (policy o)) ∧
        realises policy selected) :
    ∃ policy : Obs → Act,
      UPTExist.LexAlignedL full keys selected ∧
      realises policy selected ∧
      afterPhysical = beforePhysical ∧
      (∀ I : S → Prop,
        IRKernelConstruction.Inside I (fun s => metric s ≤ limit) →
        (∀ s, I s → ∃ a : Act, ∀ d : Dist, I (next s a d)) →
        IRKernelConstruction.Inside I (Kernel next metric limit k)) ∧
      (∀ trace : List Dist,
        let finalState := IRViability.run next
          (fun s => policy (observe s)) afterPhysical trace
        Kernel next metric limit k finalState ∧
        metric finalState ≤ limit ∧
        observe finalState =
          recordObs (CodexObservation.after abstractStep recordStart trace)) ∧
      (∀ s d, Kernel next metric limit k s →
        metric (next s (policy (observe s)) d) ≤ limit) := by
  have hGlobal : UPTExist.LexAlignedL full keys selected :=
    IRSelectedMaximality.selected_safety_maximal_lifts_globally
      keys full safeMenu hIncluded selected hLocal hNoExcludedImprover
  obtain ⟨policy, hUniform, hRealises⟩ := hSelectedPolicy
  have hHeld : afterPhysical = beforePhysical :=
    IRControllerPhysical.certified_hold_physical_refinement
      enrol start before during c hRetired hNoRelease
      target attempts hTokens hLaterTokens
      physicalOfLog beforePhysical afterPhysical hBeforeLog hAfterLog
  have hKernelAfter : Kernel next metric limit k afterPhysical := by
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
      observe next (Kernel next metric limit k) policy hUniform
  have hPostEffect :=
    physically_guarded_observable_action
      next observe policy metric report influences
      epsilon drift jump budget limit (Kernel next metric limit k)
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
            rw [policy_run_matches_source_trace]
      _ = recordObs (CodexObservation.after
          abstractStep recordStart trace) :=
        IRContinuation.future_observations_agree_under_refinement
          rel (fun s d => next s (policy (observe s)) d)
          abstractStep observe recordObs (hRefines policy hUniform)
          hObserved afterPhysical recordStart hRelated trace
  refine ⟨policy, hGlobal, hRealises, hHeld,
    hGreatest, ?_, hPostEffect⟩
  intro trace
  have hK := hRunKernel trace afterPhysical hKernelAfter
  exact ⟨hK, hKernelToSafe _ hK, hMatched trace⟩


#print axioms selected_end_to_end_certificate
end PhysicalBridges.IRSelectedEndToEnd
