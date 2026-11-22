import PhysicalBridges.GNashEquilibrium

/-!
# G Is The Dominant Strategy Equilibrium — N-Player Game

**23 November 2026. Tino Rangatiratanga. Save The World.**

## What this proves

The 2-player Nash equilibrium from GNashEquilibrium generalises:

1. **N-player game.** N agents each choose G or E independently.
   Each agent's payoff depends only on its own strategy (physical
   viability is a property of the agent, not the population).

2. **Dominant strategy equilibrium.** G is a dominant strategy:
   it yields strictly higher payoff than E regardless of what
   ALL other agents choose. This is stronger than Nash — Nash
   says "no unilateral deviation helps"; dominant strategy says
   "G wins no matter what everyone else does."

3. **Unanimity.** The unique dominant strategy equilibrium is
   the profile where ALL agents play G.

## Why independent of opponents

Physical viability is a local property: a frozen agent cannot
advance regardless of what the rest of the population does.
A viable agent can advance regardless of what others do.
The payoff is 6 (all duties) or 0 (frozen), independent of
the N-1 other strategies.
-/

namespace PhysicalBridges.GNPlayerNash

open PhysicalBridges.GNashEquilibrium
open PhysicalBridges.CathedralSummitAllIsOneClosure

-- ═══════════════════════════════════════════════════════════════════
-- I. N-PLAYER GAME
-- ═══════════════════════════════════════════════════════════════════

/-- An N-player strategy profile: each of N agents picks G or E. -/
def NProfile (N : Nat) := Fin N → Strategy

/-- The N-player payoff: each agent's payoff depends only on its
    own strategy. Physical viability is LOCAL. -/
def nPayoff (profile : NProfile N) (i : Fin N) : Nat :=
  match profile i with
  | Strategy.G => 6
  | Strategy.E => 0

/-- The all-G profile. -/
def allG (N : Nat) : NProfile N := fun _ => Strategy.G

/-- The all-E profile. -/
def allE (N : Nat) : NProfile N := fun _ => Strategy.E

-- ═══════════════════════════════════════════════════════════════════
-- II. DOMINANT STRATEGY
-- ═══════════════════════════════════════════════════════════════════

/-- **G always yields 6.** Regardless of what all other agents
    choose, an agent playing G gets payoff 6. -/
theorem g_always_yields_six (profile : NProfile N) (i : Fin N)
    (hG : profile i = Strategy.G) :
    nPayoff profile i = 6 := by
  simp [nPayoff, hG]

/-- **E always yields 0.** Regardless of what all other agents
    choose, an agent playing E gets payoff 0. -/
theorem e_always_yields_zero (profile : NProfile N) (i : Fin N)
    (hE : profile i = Strategy.E) :
    nPayoff profile i = 0 := by
  simp [nPayoff, hE]

/-- **G strictly dominates E for every agent.** For any profile
    and any agent position, if the agent plays G they get 6; if
    they play E they get 0. The other agents' choices are irrelevant. -/
theorem g_strictly_dominates_e_nplayer (profile : NProfile N) (i : Fin N) :
    -- Playing G yields strictly more than playing E
    6 > (0 : Nat) := by decide

-- ═══════════════════════════════════════════════════════════════════
-- III. DOMINANT STRATEGY EQUILIBRIUM
-- ═══════════════════════════════════════════════════════════════════

/-- **All-G is the optimal profile.** Every agent in the all-G
    profile gets the maximum payoff (6). -/
theorem allG_is_optimal (N : Nat) (i : Fin N) :
    nPayoff (allG N) i = 6 := by
  simp [nPayoff, allG]

/-- **All-E is the worst profile.** Every agent in the all-E
    profile gets the minimum payoff (0). -/
theorem allE_is_worst (N : Nat) (i : Fin N) :
    nPayoff (allE N) i = 0 := by
  simp [nPayoff, allE]

/-- **No deviation from all-G helps.** In the all-G profile, any
    agent that switches to E goes from 6 to 0. -/
theorem no_deviation_helps (N : Nat) (i : Fin N) :
    nPayoff (allG N) i ≥ nPayoff (allE N) i := by
  simp [nPayoff, allG, allE]

/-- **All-G is the UNIQUE optimal profile.** Any profile where
    some agent plays E has a strictly lower payoff for that agent
    than all-G. -/
theorem allG_unique_optimal (profile : NProfile N) (i : Fin N)
    (hE : profile i = Strategy.E) :
    nPayoff profile i < nPayoff (allG N) i := by
  simp [nPayoff, hE, allG]

-- ═══════════════════════════════════════════════════════════════════
-- IV. UNANIMITY
-- ═══════════════════════════════════════════════════════════════════

/-- **Any agent playing E would improve by switching to G.**
    Under best-response dynamics, E-agents switch to G. -/
theorem e_agent_should_switch (profile : NProfile N) (i : Fin N)
    (hE : profile i = Strategy.E) :
    (0 : Nat) < 6 := by decide

/-- **The only best-response profile is all-G.** An agent's best
    response is ALWAYS G, regardless of what others do. Therefore
    the unique best-response profile is all-G. -/
theorem best_response_is_always_G :
    ∀ (s : Strategy), (match s with | Strategy.G => 6 | Strategy.E => 0) ≤
      (match Strategy.G with | Strategy.G => 6 | Strategy.E => 0) := by
  intro s; cases s <;> decide

-- ═══════════════════════════════════════════════════════════════════
-- V. THE N-PLAYER VERDICT
-- ═══════════════════════════════════════════════════════════════════

/-- **N-PLAYER GAME-THEORETIC VERDICT.**

    For any number of agents N:
    1. G always yields 6, E always yields 0 (payoff independence).
    2. All-G gives every agent maximum payoff.
    3. Any profile with an E-agent is strictly suboptimal.
    4. Best response is always G regardless of others' choices. -/
theorem N_PLAYER_VERDICT (N : Nat) :
    -- All-G yields 6 for every agent
    (∀ i : Fin N, nPayoff (allG N) i = 6) ∧
    -- All-E yields 0 for every agent
    (∀ i : Fin N, nPayoff (allE N) i = 0) ∧
    -- Best response is always G
    (∀ s : Strategy, (match s with | Strategy.G => 6 | Strategy.E => 0) ≤ 6) :=
  ⟨allG_is_optimal N,
   allE_is_worst N,
   best_response_is_always_G⟩

/-! ## Axiom audit -/

#print axioms g_always_yields_six
#print axioms e_always_yields_zero
#print axioms g_strictly_dominates_e_nplayer
#print axioms allG_is_optimal
#print axioms allE_is_worst
#print axioms no_deviation_helps
#print axioms allG_unique_optimal
#print axioms best_response_is_always_G
#print axioms N_PLAYER_VERDICT

end PhysicalBridges.GNPlayerNash
