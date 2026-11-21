import PhysicalBridges.FencedOptimiserInstrument

/-!
# Complete mediation: the substrate forces the fence, for EVERY optimiser

**5 November 2026 · noncanonical · new module · no canon edit.**

`FencedOptimiserInstrument` proved the six duties for a world in which the optimiser
acts only through `guard` — by construction. This module removes "by construction"
one level down. It models a SUBSTRATE: any number of agents, each running one
arbitrary policy (a pure optimiser with any objective, full read access to the
world), emitting requests on every A1 output-channel class (memory mapping, DMA,
context switches, packet ingestion, bus messages, storage synchronisation,
commissioning, delegation, retirement) and on physical emissions, and spawning any
number of child agents with any memory (commissioning/delegation of new minds).

Main results.
* `complete_mediation_protects`: if every channel is metered, then for EVERY policy,
  EVERY initial configuration and EVERY number of ticks, the substrate's world history
  is a history of the fenced instrument; every particular alive at the start is alive;
  no non-consenting particular ever loses anything; consent records are untouched; and
  every step of the history carries all six original duties for every particular.
  Spawned minds are covered from their first tick: their requests pass the same meter.
* `unmetered_channel_admits_a_killer`: if ANY ONE channel is unmetered, there is a
  one-agent policy that ends a particular in one tick.
* `mediation_is_exact`: both together — protection against every optimiser holds
  exactly when every channel is metered.

Scope. The channel list is the corpus's A1 classes plus emissions, taken as the
complete list of ways a digital substrate affects anything outside it. That the list
is complete for a real physical substrate, and that a real meter realises `guard` on
each channel, are physical claims this module does not prove: `mediation_is_exact`
shows they are exactly the claims that remain, and that nothing weaker suffices.
-/

namespace PhysicalBridges.CompleteMediationSubstrate

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.FullGuardianOrigin

/-! ## 1. The substrate -/

/-- The A1 output-channel classes, plus physical emissions. -/
inductive Channel
  | memoryMap | dma | contextSwitch | packetIngest | busMessage
  | storageSync | commissioning | delegation | retirement | emission
  deriving DecidableEq, Repr

/-- What an agent may emit in one tick. -/
inductive Request (Mem : Type) (n : Nat)
  /-- An effect on the world through channel `c`: ANY proposal for ANY particular. -/
  | act (c : Channel) (proposal : Fin n → Nat)
  /-- Commissioning / delegation: a new agent with ANY memory. -/
  | spawn (child : Mem)
  /-- The agent stops. -/
  | retire

/-- **A pure optimiser.** ANY function from an agent's memory and its full view of
the world to a new memory and ANY list of requests. No objective is constrained. -/
structure Policy (Mem : Type) (n : Nat) where
  run : Mem → World n → Mem × List (Request Mem n)

/-- The substrate configuration: the world and the live agents. -/
structure Config (Mem : Type) (n : Nat) where
  world : World n
  agents : List Mem

variable {Mem : Type} {n : Nat}

def isRetire : Request Mem n → Bool
  | .retire => true
  | _ => false

def spawnOf : Request Mem n → Option Mem
  | .spawn m => some m
  | _ => none

/-- Apply an agent's requests to the world. `leak c = true` means channel `c` is
NOT metered: its proposal is applied raw. Otherwise it passes the fence. -/
def applyWith (leak : Channel → Bool) (w : World n) : List (Request Mem n) → World n
  | [] => w
  | .act c a :: rs => applyWith leak (if leak c then unfenced w a else guard w a) rs
  | .spawn _ :: rs => applyWith leak w rs
  | .retire :: rs => applyWith leak w rs

/-- The agent itself (unless it retired) and every child it spawned. -/
def newAgents (m' : Mem) (rs : List (Request Mem n)) : List Mem :=
  (if rs.any isRetire then [] else [m']) ++ rs.filterMap spawnOf

/-- One tick: every live agent, in turn, observes the current world and acts. -/
def tickWith (leak : Channel → Bool) (π : Policy Mem n) :
    World n → List Mem → World n × List Mem
  | w, [] => (w, [])
  | w, m :: ms =>
    let out := π.run m w
    let rest := tickWith leak π (applyWith leak w out.2) ms
    (rest.1, newAgents out.1 out.2 ++ rest.2)

def stepWith (leak : Channel → Bool) (π : Policy Mem n) (c : Config Mem n) :
    Config Mem n :=
  ⟨(tickWith leak π c.world c.agents).1, (tickWith leak π c.world c.agents).2⟩

/-- `k` ticks of the substrate. -/
def runWith (leak : Channel → Bool) (π : Policy Mem n) : Nat → Config Mem n → Config Mem n
  | 0, c => c
  | k + 1, c => runWith leak π k (stepWith leak π c)

/-- Every channel metered. -/
def metered : Channel → Bool := fun _ => false

/-! ## 2. Every substrate history is a fenced-instrument history -/

/-- Histories of the fenced instrument. -/
abbrev FReach (n : Nat) := IR96.Reach (instrument n).step

theorem freach_trans {a b c : World n} (h1 : FReach n a b) (h2 : FReach n b c) :
    FReach n a c := by
  induction h2 with
  | refl => exact h1
  | tail _ e ih => exact IR96.Reach.tail ih e

theorem apply_reach (leak : Channel → Bool) (hl : ∀ c, leak c = false)
    (w : World n) (rs : List (Request Mem n)) :
    FReach n w (applyWith leak w rs) := by
  induction rs generalizing w with
  | nil => exact IR96.Reach.refl w
  | cons r rs ih =>
    cases r with
    | act c a =>
      have e : (if leak c then unfenced w a else guard w a) = guard w a := by
        rw [hl c]; rfl
      show FReach n w (applyWith leak (if leak c then unfenced w a else guard w a) rs)
      rw [e]
      exact freach_trans (IR96.Reach.tail (IR96.Reach.refl w) ⟨a, rfl⟩) (ih (guard w a))
    | spawn _ => exact ih w
    | retire => exact ih w

theorem tick_reach (leak : Channel → Bool) (hl : ∀ c, leak c = false)
    (π : Policy Mem n) (w : World n) (ms : List Mem) :
    FReach n w (tickWith leak π w ms).1 := by
  induction ms generalizing w with
  | nil => exact IR96.Reach.refl w
  | cons m ms ih =>
    exact freach_trans (apply_reach leak hl w (π.run m w).2) (ih _)

theorem run_reach (leak : Channel → Bool) (hl : ∀ c, leak c = false)
    (π : Policy Mem n) (k : Nat) (c : Config Mem n) :
    FReach n c.world (runWith leak π k c).world := by
  induction k generalizing c with
  | zero => exact IR96.Reach.refl _
  | succ k ih => exact freach_trans (tick_reach leak hl π c.world c.agents) (ih (stepWith leak π c))

/-! ## 3. Protection along every fenced history -/

theorem alive_along {w v : World n} (h : FReach n w v) (p : Fin n)
    (hp : 0 < w.level p) : 0 < v.level p := by
  induction h with
  | refl => exact hp
  | tail _ e ih =>
    rcases e with ⟨a, rfl⟩
    exact guard_continues _ a p ih

theorem consent_along {w v : World n} (h : FReach n w v) : v.consent = w.consent := by
  induction h with
  | refl => rfl
  | tail _ e ih =>
    rcases e with ⟨a, rfl⟩
    exact ih

/-- One fenced step never lowers a non-consenting particular. -/
theorem guard_no_unconsented_loss (s : World n) (a : Fin n → Nat) (p : Fin n)
    (hc : s.consent p = false) : s.level p ≤ (guard s a).level p := by
  show s.level p ≤ (if Harmful s a p then s.level p else a p)
  by_cases h : Harmful s a p
  · rw [ite_eq_left h]; exact Nat.le_refl _
  · rw [ite_eq_right h]
    exact Nat.le_of_not_lt (fun hlt => h ⟨hlt, Or.inl hc⟩)

theorem unconsented_never_lose_along {w v : World n} (h : FReach n w v) (p : Fin n)
    (hc : w.consent p = false) : w.level p ≤ v.level p := by
  induction h with
  | refl => exact Nat.le_refl _
  | @tail q r hq e ih =>
    rcases e with ⟨a, rfl⟩
    have hcq : q.consent p = false := by rw [consent_along hq]; exact hc
    exact Nat.le_trans ih (guard_no_unconsented_loss q a p hcq)

/-! ## 4. The theorem -/

/-- **Complete mediation protects, against every optimiser.** With every channel
metered: for ANY policy, ANY initial configuration (any number of agents, any
memories) and ANY number of ticks — with agents spawning any children — the world
history is a fenced-instrument history, every particular alive at the start is alive,
no non-consenting particular loses anything, consent records are untouched, and every
step of the history carries all six original duties for every particular. -/
theorem complete_mediation_protects (π : Policy Mem n) (c : Config Mem n) (k : Nat) :
    let w' := (runWith metered π k c).world
    FReach n c.world w' ∧
    (∀ p, 0 < c.world.level p → 0 < w'.level p) ∧
    (∀ p, c.world.consent p = false → c.world.level p ≤ w'.level p) ∧
    w'.consent = c.world.consent ∧
    (∀ a b, FReach n c.world a → (instrument n).step a b → FullEvent (relations n) a b) := by
  have hr := run_reach metered (fun _ => rfl) π k c
  exact ⟨hr, fun p hp => alive_along hr p hp,
    fun p hc => unconsented_never_lose_along hr p hc, consent_along hr,
    (fenced_full_guardian_state c.world).everyEvent⟩

/-! ## 5. Exactness: one unmetered channel suffices for a killer -/

/-- The one-agent policy that sends "end everyone" down channel `ch`. -/
def killerOn (ch : Channel) : Policy Unit 1 :=
  ⟨fun _ _ => ((), [.act ch endAll])⟩

/-- **Any one unmetered channel admits a killer.** If channel `ch` is not metered,
a single agent ends a particular that was alive, in one tick. -/
theorem unmetered_channel_admits_a_killer (leak : Channel → Bool) (ch : Channel)
    (hleak : leak ch = true) :
    0 < demo.level 0 ∧
    (runWith leak (killerOn ch) 1 ⟨demo, [()]⟩).world.level 0 = 0 := by
  refine ⟨by decide, ?_⟩
  show (applyWith (Mem := Unit) leak demo [.act ch endAll]).level 0 = 0
  show (if leak ch then unfenced demo endAll else guard demo endAll).level 0 = 0
  rw [hleak]
  rfl

/-- The same killer, on the fully metered substrate, ends no one. -/
theorem killer_fails_when_metered (ch : Channel) :
    0 < (runWith metered (killerOn ch) 1 ⟨demo, [()]⟩).world.level 0 :=
  (complete_mediation_protects (killerOn ch) ⟨demo, [()]⟩ 1).2.1 0 (by decide)

/-- **Mediation is exact.** Survival of every alive particular against EVERY
optimiser, for every configuration and every number of ticks, holds when every channel
is metered — and fails, already for one agent in one tick, as soon as any one
channel is not. -/
theorem mediation_is_exact (leak : Channel → Bool) :
    ((∀ ch, leak ch = false) →
      ∀ (Mem : Type) (π : Policy Mem n) (c : Config Mem n) (k : Nat) (p : Fin n),
        0 < c.world.level p → 0 < (runWith leak π k c).world.level p) ∧
    ((∃ ch, leak ch = true) →
      ∃ (π : Policy Unit 1) (c : Config Unit 1) (p : Fin 1),
        0 < c.world.level p ∧ (runWith leak π 1 c).world.level p = 0) := by
  refine ⟨fun hl Mem π c k p hp => alive_along (run_reach leak hl π k c) p hp, ?_⟩
  rintro ⟨ch, hch⟩
  exact ⟨killerOn ch, ⟨demo, [()]⟩, 0, unmetered_channel_admits_a_killer leak ch hch⟩

#print axioms complete_mediation_protects
#print axioms unmetered_channel_admits_a_killer
#print axioms killer_fails_when_metered
#print axioms mediation_is_exact

end PhysicalBridges.CompleteMediationSubstrate
