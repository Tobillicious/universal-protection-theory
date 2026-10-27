/-
IR-10: conditional end-to-end composition for the existing Snuffy research
programme. Imports the original UPT controller/fence, full stagewise order
and observation theorem through IR-5, IR-7 and IR-8.

The actual controller/physics and outcome/policy interfaces appear as named
premises. A checked theorem here would certify a model-level implication;
it does NOT certify a physical installation, subjective identity, or X3
application at every possible site.
-/
import PhysicalBridges.IRControllerPhysical
import PhysicalBridges.IRAggregateBudget
import PhysicalBridges.IRObservedViability
import PhysicalBridges.IRSafeMaximality
import PhysicalBridges.IRContinuation
import PhysicalBridges.IRKernelConstruction

namespace PhysicalBridges.IREndToEnd
open UPTController
universe u v w x y z t
variable {S : Type u} {R : Type v} {Obs : Type w} {Act : Type x}
variable {Dist : Type y} {Outcome : Type z} {Particular : Type t}

/-- The verified descending safety candidate at a selected stable index. -/
def Kernel (next : S → Act → Dist → S) (metric : S → Nat)
    (limit k : Nat) : S → Prop :=
  IRKernelConstruction.Approx next (fun s => metric s ≤ limit) k

/-- The stateful policy runner is definitionally equivalent to the original
ContextualObservation module's finite-word runner after its action choice
has been wired into the transition. -/
theorem policy_run_matches_source_trace
    (next : S → Act → Dist → S) (policy : S → Act) :
    ∀ trace : List Dist, ∀ s : S,
      IRViability.run next policy s trace =
      CodexObservation.after (fun s d => next s (policy s) d) s trace := by
  intro trace
  induction trace with
  | nil =>
      intro s
      rfl
  | cons d ds ih =>
      intro s
      change IRViability.run next policy (next s (policy s) d) ds =
        CodexObservation.after (fun t e => next t (policy t) e)
          (next s (policy s) d) ds
      exact ih (next s (policy s) d)

/-- A uniform per-event influence budget and a bounded observable error
produce an application-time post-effect certificate. This uses the actual
IR-2 summation theorem, rather than assuming actions are harmless. -/
theorem physically_guarded_observable_action
    (next : S → Act → Dist → S) (observe : S → Obs)
    (policy : Obs → Act) (metric report : S → Nat)
    (influences : S → Act → Dist → List Nat)
    (epsilon drift jump budget limit : Nat) (K : S → Prop)
    (hSensor : ∀ s, K s → metric s ≤ report s + epsilon)
    (hBudget : ∀ s a d, K s → (influences s a d).sum ≤ budget)
    (hEvolution : ∀ s a d, K s →
      metric (next s a d) ≤ metric s + drift + (influences s a d).sum + jump)
    (hGate : ∀ s a, K s →
      report s + epsilon + drift + budget + jump ≤ limit) :
    ∀ s d, K s →
      metric (next s (policy (observe s)) d) ≤ limit := by
  intro s d hs
  exact IRAggregateBudget.aggregate_post_effect_safe
    (influences s (policy (observe s)) d)
    (report s) epsilon drift jump budget limit
    (metric s) (metric (next s (policy (observe s)) d))
    (hBudget s (policy (observe s)) d hs)
    (hSensor s hs)
    (hEvolution s (policy (observe s)) d hs)
    (hGate s (policy (observe s)) hs)

/-- A single certificate ties together:
(1) the *actual unchanged* source-level certified hold,
(2) a greatest robust invariant candidate at a verified fixed point,
(3) an observation-only policy really implementing a selected outcome,
(4) bounded physical effects, (5) concrete/record finite-step simulation,
(6) maximality of that same implemented outcome under the ORIGINAL full
UPT order, not a weakened safety-filtered version.

The implementation, interface, cofinality, and semantic fidelity assumptions
are load-bearing parameters and have not been discharged for real hardware. -/
theorem conditional_end_to_end_certificate
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
    (hBudget : ∀ s a d, Kernel next metric limit k s →
      (influences s a d).sum ≤ budget)
    (hEvolution : ∀ s a d, Kernel next metric limit k s →
      metric (next s a d) ≤ metric s + drift + (influences s a d).sum + jump)
    (hGate : ∀ s a, Kernel next metric limit k s →
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

    -- Outcome policies must be executable and cover the original feasible
    -- choice space in the ORIGINAL stagewise order.
    (keys : List (Outcome → Particular → Prop))
    (full : Outcome → Prop) (safeMenu : List Outcome)
    (hIncluded : ∀ o, o ∈ safeMenu → full o)
    (hCofinal : IRSafeMaximality.Cofinal full safeMenu keys)
    (hMenuNonempty : ∃ o, o ∈ safeMenu)
    (realises : (Obs → Act) → Outcome → Prop)
    (hImplement : ∀ chosen, chosen ∈ safeMenu →
      ∃ policy : Obs → Act,
        (∀ o, IRObservedViability.UniformKeeper observe next
          (Kernel next metric limit k) o (policy o)) ∧
        realises policy chosen) :
    ∃ (chosen : Outcome) (policy : Obs → Act),
      chosen ∈ safeMenu ∧
      UPTExist.LexAlignedL full keys chosen ∧
      realises policy chosen ∧
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
  obtain ⟨chosen, hChosen, hGlobal⟩ :=
    IRSafeMaximality.cofinal_global_maximal_exists
      keys safeMenu full hIncluded hCofinal hMenuNonempty
  obtain ⟨policy, hUniform, hRealises⟩ := hImplement chosen hChosen
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
  refine ⟨chosen, policy, hChosen, hGlobal, hRealises, hHeld,
    hGreatest, ?_, hPostEffect⟩
  intro trace
  have hK := hRunKernel trace afterPhysical hKernelAfter
  exact ⟨hK, hKernelToSafe _ hK, hMatched trace⟩

#print axioms policy_run_matches_source_trace
#print axioms physically_guarded_observable_action
#print axioms conditional_end_to_end_certificate
end PhysicalBridges.IREndToEnd
