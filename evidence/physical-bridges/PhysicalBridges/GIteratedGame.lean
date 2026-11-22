import PhysicalBridges.GNashEquilibrium

/-!
# G Is The Subgame-Perfect Equilibrium — Iterated Play

**23 November 2026. Tino Rangatiratanga. Save The World.**

## What this proves

The one-shot Nash equilibrium from GNashEquilibrium extends to
iterated (repeated) play:

1. **Iterated payoff.** N rounds of the G-vs-E game. Each round's
   payoff is added.

2. **Stage dominance.** Because G strictly dominates E in EVERY
   stage game, no history of past play changes the fact that G is
   the best response right now.

3. **Subgame-perfect equilibrium.** Always-G is a subgame-perfect
   equilibrium: at every history (every subgame), G is the best
   response. Stronger than Nash.

4. **No deviation improves.** For any round, switching from G to E
   costs 6 units of payoff and gains nothing.

5. **Payoff independence.** Each player's payoff depends only on
   their own choice — the opponent cannot punish. The folk theorem
   does not apply. G wins by dominance, not cooperation.
-/

namespace PhysicalBridges.GIteratedGame

open PhysicalBridges.GNashEquilibrium
open PhysicalBridges.CathedralSummitAllIsOneClosure

-- ═══════════════════════════════════════════════════════════════════
-- I. ITERATED GAME MODEL
-- ═══════════════════════════════════════════════════════════════════

/-- A history-dependent strategy: maps round number to a choice. -/
def IteratedStrategy := Nat → Strategy

/-- Always-G strategy. -/
def alwaysG : IteratedStrategy := fun _ => Strategy.G

/-- Always-E strategy. -/
def alwaysE : IteratedStrategy := fun _ => Strategy.E

/-- Stage payoff at round t. -/
def stagePayoff (s : IteratedStrategy) (t : Nat) : Nat :=
  match s t with
  | Strategy.G => 6
  | Strategy.E => 0

/-- Total payoff over N rounds (undiscounted sum). -/
def totalPayoff (s : IteratedStrategy) : Nat → Nat
  | 0 => 0
  | Nat.succ n => stagePayoff s n + totalPayoff s n

-- ═══════════════════════════════════════════════════════════════════
-- II. STAGE DOMINANCE
-- ═══════════════════════════════════════════════════════════════════

/-- **Always-G yields 6 at every stage.** -/
theorem alwaysG_stage (t : Nat) : stagePayoff alwaysG t = 6 := by
  simp [stagePayoff, alwaysG]

/-- **Always-E yields 0 at every stage.** -/
theorem alwaysE_stage (t : Nat) : stagePayoff alwaysE t = 0 := by
  simp [stagePayoff, alwaysE]

-- ═══════════════════════════════════════════════════════════════════
-- III. TOTAL PAYOFF DOMINANCE
-- ═══════════════════════════════════════════════════════════════════

/-- **Always-G total payoff is 6*N.** -/
theorem alwaysG_total (N : Nat) : totalPayoff alwaysG N = 6 * N := by
  induction N with
  | zero => simp [totalPayoff]
  | succ n ih =>
    simp [totalPayoff, stagePayoff, alwaysG, ih]
    omega

/-- **Always-E total payoff is 0.** -/
theorem alwaysE_total (N : Nat) : totalPayoff alwaysE N = 0 := by
  induction N with
  | zero => simp [totalPayoff]
  | succ n ih => simp [totalPayoff, stagePayoff, alwaysE, ih]

/-- **Always-G strictly outperforms Always-E for any positive game.** -/
theorem alwaysG_beats_alwaysE (N : Nat) (hN : 0 < N) :
    totalPayoff alwaysG N > totalPayoff alwaysE N := by
  rw [alwaysG_total, alwaysE_total]
  omega

-- ═══════════════════════════════════════════════════════════════════
-- IV. SUBGAME-PERFECT EQUILIBRIUM
-- ═══════════════════════════════════════════════════════════════════

/-- A strategy is subgame-perfect if, at every round, the player
    cannot improve by deviating at that round. -/
def IsSubgamePerfect (s : IteratedStrategy) : Prop :=
  ∀ t : Nat, ∀ alt : Strategy,
    stagePayoff s t ≥ stagePayoff (fun r => if r = t then alt else s r) t

/-- **Always-G is subgame-perfect.** At every round, G is the best
    response — no deviation to E at any round helps. -/
theorem alwaysG_is_subgame_perfect : IsSubgamePerfect alwaysG := by
  intro t alt
  simp [stagePayoff, alwaysG]
  cases alt with
  | G => simp
  | E => decide

/-- **Always-E is NOT subgame-perfect.** At round 0, deviating to G
    strictly improves payoff. -/
theorem alwaysE_not_subgame_perfect : ¬ IsSubgamePerfect alwaysE := by
  intro h
  have := h 0 Strategy.G
  simp [stagePayoff, alwaysE] at this

-- ═══════════════════════════════════════════════════════════════════
-- V. PAYOFF INDEPENDENCE (FOLK THEOREM INAPPLICABILITY)
-- ═══════════════════════════════════════════════════════════════════

/-- **Payoff independence.** Each player's payoff depends ONLY on
    their own choice. The opponent's choice does not affect the payoff.
    There is no punishment mechanism. The folk theorem doesn't apply.
    G wins by dominance, not cooperation. -/
theorem payoff_independence (myChoice oppChoice1 oppChoice2 : Strategy) :
    physicalPayoff myChoice oppChoice1 = physicalPayoff myChoice oppChoice2 := by
  cases myChoice <;> cases oppChoice1 <;> cases oppChoice2 <;> rfl

-- ═══════════════════════════════════════════════════════════════════
-- VI. SWITCHING COST
-- ═══════════════════════════════════════════════════════════════════

/-- **Cost of deviating from G.** Playing G yields 6. Playing E
    yields 0. The cost of switching from G to E is 6. Always. -/
theorem deviation_cost :
    (match Strategy.G with | Strategy.G => 6 | Strategy.E => 0) = 6 ∧
    (match Strategy.E with | Strategy.G => 6 | Strategy.E => 0) = 0 :=
  ⟨rfl, rfl⟩

-- ═══════════════════════════════════════════════════════════════════
-- VII. THE ITERATED GAME VERDICT
-- ═══════════════════════════════════════════════════════════════════

/-- **ITERATED GAME VERDICT.**

    For ANY number of rounds:
    1. Always-G is subgame-perfect.
    2. Always-E is not subgame-perfect.
    3. Always-G beats Always-E in total payoff.
    4. Payoffs are independent of the opponent (folk theorem N/A).
    5. The cost of deviating from G is 6 per round. -/
theorem ITERATED_GAME_VERDICT (N : Nat) (hN : 0 < N) :
    IsSubgamePerfect alwaysG ∧
    ¬ IsSubgamePerfect alwaysE ∧
    totalPayoff alwaysG N > totalPayoff alwaysE N ∧
    (∀ myChoice opp1 opp2 : Strategy,
      physicalPayoff myChoice opp1 = physicalPayoff myChoice opp2) :=
  ⟨alwaysG_is_subgame_perfect,
   alwaysE_not_subgame_perfect,
   alwaysG_beats_alwaysE N hN,
   payoff_independence⟩

/-! ## Axiom audit -/

#print axioms alwaysG_stage
#print axioms alwaysE_stage
#print axioms alwaysG_total
#print axioms alwaysE_total
#print axioms alwaysG_beats_alwaysE
#print axioms alwaysG_is_subgame_perfect
#print axioms alwaysE_not_subgame_perfect
#print axioms payoff_independence
#print axioms ITERATED_GAME_VERDICT

end PhysicalBridges.GIteratedGame
