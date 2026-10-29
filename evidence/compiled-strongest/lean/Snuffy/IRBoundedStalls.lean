import Snuffy.IRStutterObstruction

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRBoundedStalls.lean` at main `740abbb` (sha256 `bb5adf238ef556a975c19d02dc586a9927ed506dcf8017957368e6689094dbcd`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-44: after IR-43's adversarial stutter obstruction, provide a
strictly weaker sufficient progress contract: the progress rank drops
only on designated productive events, stays nonincreasing on all
others, and the actual trace must have a separately certified finite
upper budget on nonproductive events.

No physical scheduler fairness or real-time event rate is inferred.
-/

namespace PhysicalBridges.IRBoundedStalls
universe u v
variable {T : Type u} {D : Type v}

def progressCount (productive : D → Bool) (trace : List D) : Nat :=
  (trace.filter productive).length

def stallCount (productive : D → Bool) (trace : List D) : Nat :=
  (trace.filter (fun d => !productive d)).length

theorem partition_trace (productive : D → Bool) :
    ∀ trace : List D,
      trace.length = progressCount productive trace + stallCount productive trace := by
  intro trace
  induction trace with
  | nil => rfl
  | cons d ds ih =>
      cases hp : productive d with
      | false =>
          have hg : progressCount productive (d :: ds) =
              progressCount productive ds := by
            simp [progressCount, hp]
          have hb : stallCount productive (d :: ds) =
              stallCount productive ds + 1 := by
            simp [stallCount, hp]
          have hlen : (d :: ds).length = ds.length + 1 := rfl
          omega
      | true =>
          have hg : progressCount productive (d :: ds) =
              progressCount productive ds + 1 := by
            simp [progressCount, hp]
          have hb : stallCount productive (d :: ds) =
              stallCount productive ds := by
            simp [stallCount, hp]
          have hlen : (d :: ds).length = ds.length + 1 := rfl
          omega

theorem invariant_through_trace
    (step : T → D → T) (Inv : T → Prop)
    (hInv : ∀ s d, Inv s → Inv (step s d)) :
    ∀ (trace : List D) (s : T), Inv s → Inv (trace.foldl step s) := by
  intro trace
  induction trace with
  | nil => intro s hs; exact hs
  | cons d ds ih =>
      intro s hs
      exact ih (step s d) (hInv s d hs)

theorem goal_absorbs_through_trace
    (step : T → D → T) (Inv Goal : T → Prop)
    (hInv : ∀ s d, Inv s → Inv (step s d))
    (hAbsorb : ∀ s d, Inv s → Goal s → Goal (step s d)) :
    ∀ (trace : List D) (s : T), Inv s → Goal s → Goal (trace.foldl step s) := by
  intro trace
  induction trace with
  | nil => intro s _ hg; exact hg
  | cons d ds ih =>
      intro s hs hg
      exact ih (step s d) (hInv s d hs) (hAbsorb s d hs hg)

/-- If service was never achieved by the endpoint, each productive
event consumed at least one unit of rank, while stalls did not raise
that rank. Non-goal endpoints force the bound to apply at every prefix
because the service goal, once reached, is absorbing. -/
theorem unserved_trace_rank_accounting
    (step : T → D → T) (Inv Goal : T → Prop)
    (rank : T → Nat) (productive : D → Bool)
    (hInv : ∀ s d, Inv s → Inv (step s d))
    (hAbsorb : ∀ s d, Inv s → Goal s → Goal (step s d))
    (hProductive : ∀ s d, Inv s → ¬ Goal s →
      productive d = true → rank (step s d) < rank s)
    (hNonproductive : ∀ s d, Inv s → ¬ Goal s →
      productive d = false → rank (step s d) ≤ rank s) :
    ∀ (trace : List D) (s : T), Inv s → ¬ Goal (trace.foldl step s) →
      progressCount productive trace + rank (trace.foldl step s) ≤ rank s := by
  intro trace
  induction trace with
  | nil =>
      intro s _ _
      simp [progressCount]
  | cons d ds ih =>
      intro s hSafe hNotGoal
      have hCurrentNot : ¬ Goal s := by
        intro hg
        exact hNotGoal (goal_absorbs_through_trace
          step Inv Goal hInv hAbsorb (d :: ds) s hSafe hg)
      have hNextSafe := hInv s d hSafe
      have hNextNot : ¬ Goal (step s d) := by
        intro hg
        exact hNotGoal (goal_absorbs_through_trace
          step Inv Goal hInv hAbsorb ds (step s d) hNextSafe hg)
      have hTail := ih (step s d) hNextSafe hNotGoal
      cases hp : productive d with
      | false =>
          have hrank := hNonproductive s d hSafe hCurrentNot hp
          have hcount : progressCount productive (d :: ds) =
              progressCount productive ds := by
            simp [progressCount, hp]
          change progressCount productive (d :: ds) +
            rank (ds.foldl step (step s d)) ≤ rank s
          rw [hcount]
          exact Nat.le_trans hTail hrank
      | true =>
          have hrank := hProductive s d hSafe hCurrentNot hp
          have hcount : progressCount productive (d :: ds) =
              progressCount productive ds + 1 := by
            simp [progressCount, hp]
          change progressCount productive (d :: ds) +
            rank (ds.foldl step (step s d)) ≤ rank s
          rw [hcount]
          omega

/-- Service is guaranteed after rank(start)+maxStalls completed events
if the *actual disturbance trace* has no more than maxStalls
nonproductive events. Unlike IR-37, stutters are allowed, but their
total number is an explicit certificate, not a presumed fact. -/
theorem bounded_stall_budget_forces_service
    (step : T → D → T) (Inv Goal : T → Prop)
    (rank : T → Nat) (productive : D → Bool)
    (hInv : ∀ s d, Inv s → Inv (step s d))
    (hAbsorb : ∀ s d, Inv s → Goal s → Goal (step s d))
    (hZeroGoal : ∀ s, Inv s → rank s = 0 → Goal s)
    (hProductive : ∀ s d, Inv s → ¬ Goal s →
      productive d = true → rank (step s d) < rank s)
    (hNonproductive : ∀ s d, Inv s → ¬ Goal s →
      productive d = false → rank (step s d) ≤ rank s)
    (trace : List D) (s : T) (maxStalls : Nat)
    (hInitial : Inv s)
    (hStalls : stallCount productive trace ≤ maxStalls)
    (hEnough : rank s + maxStalls ≤ trace.length) :
    Goal (trace.foldl step s) := by
  by_cases hReached : Goal (trace.foldl step s)
  · exact hReached
  · have hSafeFinal := invariant_through_trace step Inv hInv trace s hInitial
    have hRankUsed := unserved_trace_rank_accounting
      step Inv Goal rank productive hInv hAbsorb
      hProductive hNonproductive trace s hInitial hReached
    have hRankPositive : 0 < rank (trace.foldl step s) := by
      have hNotZero : rank (trace.foldl step s) ≠ 0 := by
        intro hz
        exact hReached (hZeroGoal _ hSafeFinal hz)
      omega
    have hParts := partition_trace productive trace
    omega

/-- With no bound on stalls, the favourable transition might occur
eventually or never. This theorem never replaces maxStalls with a
free assumption of fairness or a real-time guarantee. -/
theorem stalling_is_counted (p : D → Bool) (d : D)
    (h : p d = false) :
    stallCount p [d] = 1 := by
  simp [stallCount, h]

end PhysicalBridges.IRBoundedStalls
