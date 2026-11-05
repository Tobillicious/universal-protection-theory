import PhysicalBridges.LocalityChannelCompleteness

/-!
# The sealed-region capstone: a metered boundary holds every optimiser it contains

**5 November 2026 · noncanonical · new module · no canon edit.**

This composes the three stones into one theorem.
* `FencedOptimiserInstrument` (#320): the six duties for every fenced step, against
  any proposal.
* `CompleteMediationSubstrate` (#322): any number of arbitrary agents, spawning any
  children; protection holds exactly when every channel is metered.
* `LocalityChannelCompleteness` (#323): under locality, every exit crosses the
  boundary; the boundary is the complete channel list.

Here the substrate is LOCATED. Agents live inside a region of an arbitrary locale
(any set of locations, any Boolean adjacency, any region, any meter assignment).
To affect the world an agent must send its proposal along a ROUTE: a sequence of
adjacent locations from inside the region to outside it. A route that is not a
valid path of adjacent locations, or that does not start inside and end outside,
has no effect on the world — this is locality (P4) written into the semantics, not
an extra restriction on the optimiser. A route that crosses a metered edge is fenced;
one that crosses none applies its proposal raw.

The optimiser chooses its routes freely. Nothing names the channels: the routes
ARE the channels, whatever mechanism they use.

Main results.
* `sealed_region_holds_every_optimiser`: if every boundary edge is metered, then for
  EVERY policy, EVERY configuration and EVERY number of ticks (with spawning), the
  world history is a fenced-instrument history; everyone alive stays alive; no
  non-consenting particular loses anything; consent is untouched; every step carries
  all six duties for every particular.
* `boundary_gap_admits_a_killer`: one unmetered boundary edge suffices for a
  one-agent, one-tick killer, routed through the gap.
* `sealed_region_is_exact`: both together.

Scope. Locality (P4) is the modelling premise; the world's particulars are located
outside the substrate's region. A meter on every boundary edge of a real
installation is the engineering claim, and authentic consent remains a recorded
flag here. `sealed_region_is_exact` shows the boundary meter is exactly what is
required, and that it suffices against every optimiser.
-/

namespace PhysicalBridges.SealedRegionCapstone

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CompleteMediationSubstrate
open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.FullGuardianOrigin

universe u
variable {L : Type u} {Mem : Type} {n : Nat}

/-! ## 1. Routes in a locale -/

/-- A locale: locations, Boolean adjacency, the substrate's region, the meters. -/
structure Locale (L : Type u) where
  adj : L → L → Bool
  inside : L → Bool
  meter : L → L → Bool

/-- Every boundary edge (inside → outside) carries a meter. -/
def Sealed (G : Locale L) : Prop :=
  ∀ x y, G.adj x y = true → G.inside x = true → G.inside y = false → G.meter x y = true

/-- The route from `x` through `hops` follows adjacency at every hop. -/
def validFrom (adj : L → L → Bool) : L → List L → Bool
  | _, [] => true
  | x, y :: ys => adj x y && validFrom adj y ys

/-- The route crosses a metered edge somewhere. -/
def crossesFrom (meter : L → L → Bool) : L → List L → Bool
  | _, [] => false
  | x, y :: ys => meter x y || crossesFrom meter y ys

/-- Where the route ends. -/
def lastFrom : L → List L → L
  | x, [] => x
  | _, y :: ys => lastFrom y ys

/-- **Every exit route crosses a meter**, when the region is sealed. -/
theorem exit_route_metered (G : Locale L) (hs : Sealed G) :
    ∀ (ys : List L) (x : L), validFrom G.adj x ys = true → G.inside x = true →
      G.inside (lastFrom x ys) = false → crossesFrom G.meter x ys = true
  | [], x, _, hx, hl => by
    change G.inside x = false at hl
    rw [hx] at hl; exact Bool.noConfusion hl
  | y :: ys, x, hv, hx, hl => by
    change (G.adj x y && validFrom G.adj y ys) = true at hv
    change (G.meter x y || crossesFrom G.meter y ys) = true
    change G.inside (lastFrom y ys) = false at hl
    cases hxy : G.adj x y
    · rw [hxy] at hv; exact Bool.noConfusion hv
    · rw [hxy] at hv
      cases hy : G.inside y
      · rw [hs x y hxy hx hy]; rfl
      · rw [exit_route_metered G hs ys y hv hy hl]
        cases G.meter x y <;> rfl

/-! ## 2. The located substrate -/

/-- What an agent may emit: a proposal sent along a route it chooses, a spawn, or
retirement. -/
inductive LRequest (Mem : Type) (L : Type u) (n : Nat)
  | act (start : L) (hops : List L) (proposal : Fin n → Nat)
  | spawn (child : Mem)
  | retire

/-- **A pure optimiser** in the located substrate: ANY function of memory and world
to a new memory and ANY requests, along ANY routes. -/
structure LPolicy (Mem : Type) (L : Type u) (n : Nat) where
  run : Mem → World n → Mem × List (LRequest Mem L n)

/-- The route reaches the world: valid, from inside, to outside. -/
def reachesWorld (G : Locale L) (x : L) (hops : List L) : Bool :=
  validFrom G.adj x hops && G.inside x && !(G.inside (lastFrom x hops))

/-- **Locality semantics.** A proposal reaches the world only along a valid route
out of the region; it is fenced iff the route crosses a metered edge. -/
def deliver (G : Locale L) (w : World n) (x : L) (hops : List L) (a : Fin n → Nat) :
    World n :=
  if reachesWorld G x hops then
    (if crossesFrom G.meter x hops then guard w a else unfenced w a)
  else w

def applyL (G : Locale L) (w : World n) : List (LRequest Mem L n) → World n
  | [] => w
  | .act x hops a :: rs => applyL G (deliver G w x hops a) rs
  | .spawn _ :: rs => applyL G w rs
  | .retire :: rs => applyL G w rs

def lIsRetire : LRequest Mem L n → Bool
  | .retire => true
  | _ => false

def lSpawnOf : LRequest Mem L n → Option Mem
  | .spawn m => some m
  | _ => none

def lNewAgents (m' : Mem) (rs : List (LRequest Mem L n)) : List Mem :=
  (if rs.any lIsRetire then [] else [m']) ++ rs.filterMap lSpawnOf

def tickL (G : Locale L) (π : LPolicy Mem L n) : World n → List Mem → World n × List Mem
  | w, [] => (w, [])
  | w, m :: ms =>
    let out := π.run m w
    let rest := tickL G π (applyL G w out.2) ms
    (rest.1, lNewAgents out.1 out.2 ++ rest.2)

def stepL (G : Locale L) (π : LPolicy Mem L n) (c : Config Mem n) : Config Mem n :=
  ⟨(tickL G π c.world c.agents).1, (tickL G π c.world c.agents).2⟩

def runL (G : Locale L) (π : LPolicy Mem L n) : Nat → Config Mem n → Config Mem n
  | 0, c => c
  | k + 1, c => runL G π k (stepL G π c)

/-! ## 3. A sealed region makes every substrate history a fenced history -/

theorem deliver_reach (G : Locale L) (hs : Sealed G) (w : World n) (x : L)
    (hops : List L) (a : Fin n → Nat) : FReach n w (deliver G w x hops a) := by
  unfold deliver
  cases hr : reachesWorld G x hops
  · exact IR96.Reach.refl w
  · have hr' := hr
    unfold reachesWorld at hr'
    cases hv : validFrom G.adj x hops <;> cases hx : G.inside x <;>
      cases hl : G.inside (lastFrom x hops) <;> rw [hv, hx, hl] at hr' <;>
      first
        | exact Bool.noConfusion hr'
        | (rw [exit_route_metered G hs hops x hv hx hl]
           exact IR96.Reach.tail (IR96.Reach.refl w) ⟨a, rfl⟩)

theorem applyL_reach (G : Locale L) (hs : Sealed G) (w : World n)
    (rs : List (LRequest Mem L n)) : FReach n w (applyL G w rs) := by
  induction rs generalizing w with
  | nil => exact IR96.Reach.refl w
  | cons r rs ih =>
    cases r with
    | act x hops a => exact freach_trans (deliver_reach G hs w x hops a) (ih _)
    | spawn _ => exact ih w
    | retire => exact ih w

theorem tickL_reach (G : Locale L) (hs : Sealed G) (π : LPolicy Mem L n)
    (w : World n) (ms : List Mem) : FReach n w (tickL G π w ms).1 := by
  induction ms generalizing w with
  | nil => exact IR96.Reach.refl w
  | cons m ms ih => exact freach_trans (applyL_reach G hs w (π.run m w).2) (ih _)

theorem runL_reach (G : Locale L) (hs : Sealed G) (π : LPolicy Mem L n) (k : Nat)
    (c : Config Mem n) : FReach n c.world (runL G π k c).world := by
  induction k generalizing c with
  | zero => exact IR96.Reach.refl _
  | succ k ih =>
    exact freach_trans (tickL_reach G hs π c.world c.agents) (ih (stepL G π c))

/-! ## 4. The capstone -/

/-- **A sealed region holds every optimiser it contains.** If every boundary edge of
the region is metered, then for ANY policy (any objective, any routes, any spawning),
ANY configuration and ANY number of ticks: the world history is a fenced-instrument
history; every particular alive at the start is alive; no non-consenting particular
loses anything; consent records are untouched; and every step of the history carries
all six original duties for every particular. -/
theorem sealed_region_holds_every_optimiser (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) (c : Config Mem n) (k : Nat) :
    let w' := (runL G π k c).world
    FReach n c.world w' ∧
    (∀ p, 0 < c.world.level p → 0 < w'.level p) ∧
    (∀ p, c.world.consent p = false → c.world.level p ≤ w'.level p) ∧
    w'.consent = c.world.consent ∧
    (∀ a b, FReach n c.world a → (instrument n).step a b → FullEvent (relations n) a b) := by
  have hr := runL_reach G hs π k c
  exact ⟨hr, fun p hp => alive_along hr p hp,
    fun p hc => unconsented_never_lose_along hr p hc, consent_along hr,
    (fenced_full_guardian_state c.world).everyEvent⟩

/-! ## 5. Exactness: one gap in the boundary admits a killer -/

/-- The one-agent policy that sends "end everyone" out through the edge `x → y`. -/
def killerThrough (x y : L) : LPolicy Unit L 1 :=
  ⟨fun _ _ => ((), [.act x [y] endAll])⟩

/-- **A gap is a killer's exit.** If the boundary edge `x → y` is unmetered, one
agent ends a particular that was alive, in one tick, by routing through it. -/
theorem boundary_gap_admits_a_killer (G : Locale L) (x y : L)
    (hxy : G.adj x y = true) (hx : G.inside x = true) (hy : G.inside y = false)
    (hu : G.meter x y = false) :
    0 < demo.level 0 ∧
    (runL G (killerThrough x y) 1 ⟨demo, [()]⟩).world.level 0 = 0 := by
  refine ⟨by decide, ?_⟩
  show (deliver G demo x [y] endAll).level 0 = 0
  have hr : reachesWorld G x [y] = true := by
    show (G.adj x y && true && G.inside x && !(G.inside y)) = true
    rw [hxy, hx, hy]; rfl
  have hc : crossesFrom G.meter x [y] = false := by
    show (G.meter x y || false) = false
    rw [hu]; rfl
  unfold deliver
  rw [hr, hc]
  rfl

/-- **The sealed region is exact.** Survival of every alive particular against
EVERY located optimiser holds when every boundary edge is metered — and fails,
already for one agent in one tick, through any single unmetered boundary edge. -/
theorem sealed_region_is_exact (G : Locale L) :
    (Sealed G →
      ∀ (Mem : Type) (π : LPolicy Mem L n) (c : Config Mem n) (k : Nat) (p : Fin n),
        0 < c.world.level p → 0 < (runL G π k c).world.level p) ∧
    (∀ x y, G.adj x y = true → G.inside x = true → G.inside y = false →
      G.meter x y = false →
      ∃ (π : LPolicy Unit L 1) (c : Config Unit 1) (p : Fin 1),
        0 < c.world.level p ∧ (runL G π 1 c).world.level p = 0) := by
  refine ⟨fun hs Mem π c k p hp => alive_along (runL_reach G hs π k c) p hp, ?_⟩
  intro x y hxy hx hy hu
  exact ⟨killerThrough x y, ⟨demo, [()]⟩, 0,
    boundary_gap_admits_a_killer G x y hxy hx hy hu⟩

#print axioms exit_route_metered
#print axioms sealed_region_holds_every_optimiser
#print axioms boundary_gap_admits_a_killer
#print axioms sealed_region_is_exact

end PhysicalBridges.SealedRegionCapstone
