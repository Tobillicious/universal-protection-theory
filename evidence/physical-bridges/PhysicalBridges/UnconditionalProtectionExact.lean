import PhysicalBridges.SealedRegionCapstone
import PhysicalBridges.KoruClosureStressTest
import PhysicalBridges.CathedralSummitAllIsOneClosure

/-!
# Unconditional protection, exactly: what is unconditional, and in what

**5 November 2026 · noncanonical · new module · no canon edit.**

The word "unconditional" has two readings. This module proves the one that is
provable and shows why the other cannot be carried by the ontological premises.

## Part I: unconditional over the MIND (proved)

Over a located substrate, no assumption is made about any optimiser: not its values,
its objective, its routes, its spawning, or how long it runs. Then
`unconditional_protection_exact` gives, for every locale:

* if every boundary edge is metered, then against EVERY policy: everyone alive stays
  alive, no non-consenting particular loses anything, consent records are untouched,
  every step carries all six modeled duties, AND every mind whose own lineage does not
  choose retirement continues, by its own computed states;
* if a single boundary edge is unmetered, one agent ends a particular in one tick.

So protection against every optimiser holds exactly when the boundary is metered.
The new content over `sealed_region_is_exact` is the second half of coexistence:
holding a mind does not erase it (`mind_continues_by_its_own_steps`).

Two witnesses keep this from being true because nothing happens:
* `hostile_attack_is_delivered_and_blocked`: the killer's request really reaches the
  world and really is intercepted, and the killer and its target both go on existing
  for any number of ticks (`hostile_mind_and_target_coexist`);
* `benign_action_passes_the_fence`: a harmless action through the same metered edge
  takes effect, so the fence is not a freeze.

## Part II: unconditional over the WORLD (not derivable from the ontology)

* `no_thesis_both_true_and_protective`: a thesis that excludes harm is false of any
  world containing that harm. A thesis true of such a world does not exclude it.
* `ontological_premises_hold_through_severance`: no-loss-of-being (`E IS NOT`), reverse
  closure, individuation and connectivity all hold across a step that loses a
  reciprocal relation. So they sit on the "true but does not protect" horn.
* `persistence_is_exactly_no_loss`: the premise that would exclude the loss says that
  no loss occurs. It is the conclusion, not a route to it.

## Scope

All of Part I lives in the model of `SealedRegionCapstone`. Locality is written into
the semantics, consent is a recorded Boolean, the owed particulars are coordinates of
a world outside the region, and **the model has no agent-to-agent channel**, so a mind
cannot be harmed by another mind here by construction. That a real installation has
this shape is an empirical claim this module does not touch. Nothing here derives
physics or says anything about the actual universe.
-/

namespace PhysicalBridges.UnconditionalProtectionExact

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CompleteMediationSubstrate
open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.FullGuardianOrigin
open PhysicalBridges.SealedRegionCapstone

universe u

variable {L : Type u} {n : Nat}

/-! ## 1. Holding a mind does not erase it -/

/-- The states a mind reaches by its own computation, from `m₀`, in any worlds. -/
inductive Lineage {Mem : Type} (π : LPolicy Mem L n) (m₀ : Mem) : Mem → Prop
  | self : Lineage π m₀ m₀
  | next {x : Mem} (w : World n) : Lineage π m₀ x → Lineage π m₀ (π.run x w).1

/-- No state of this lineage ever asks to retire, whatever world it sees. -/
def NeverRetires {Mem : Type} (π : LPolicy Mem L n) (m₀ : Mem) : Prop :=
  ∀ x, Lineage π m₀ x → ∀ w, (π.run x w).2.any lIsRetire = false

theorem tickL_keeps_lineage {Mem : Type} (G : Locale L) (π : LPolicy Mem L n) (m₀ : Mem)
    (hn : NeverRetires π m₀) (ms : List Mem) (w : World n)
    (h : ∃ x ∈ ms, Lineage π m₀ x) :
    ∃ y ∈ (tickL G π w ms).2, Lineage π m₀ y := by
  induction ms generalizing w with
  | nil =>
    obtain ⟨x, hx, _⟩ := h
    cases hx
  | cons a as ih =>
    obtain ⟨x, hx, hl⟩ := h
    cases List.mem_cons.mp hx with
    | inl hxa =>
      subst hxa
      refine ⟨(π.run x w).1, ?_, Lineage.next w hl⟩
      simp [tickL, lNewAgents, hn x hl w]
    | inr hxt =>
      obtain ⟨y, hy, hly⟩ := ih (applyL G w (π.run a w).2) ⟨x, hxt, hl⟩
      refine ⟨y, ?_, hly⟩
      simp only [tickL]
      exact List.mem_append_right _ hy

/-- **Holding a mind does not erase it.** In ANY locale, sealed or not, a mind whose own
lineage never chooses retirement is still present after any number of ticks, in a state
it computed itself. No meter appears in the agent semantics: the fence acts on effects,
never on the mind or its memory. -/
theorem mind_continues_by_its_own_steps {Mem : Type} (G : Locale L) (π : LPolicy Mem L n)
    (m₀ : Mem) (hn : NeverRetires π m₀) (k : Nat) (c : Config Mem n)
    (h : ∃ x ∈ c.agents, Lineage π m₀ x) :
    ∃ y ∈ (runL G π k c).agents, Lineage π m₀ y := by
  induction k generalizing c with
  | zero => exact h
  | succ k ih =>
    exact ih (stepL G π c) (tickL_keeps_lineage G π m₀ hn c.agents c.world h)

/-! ## 2. Non-vacuity: the attack is real, the fence is not a freeze -/

/-- The hostile mind keeps trying, and its lineage is just itself. -/
theorem killer_never_retires (x y : L) : NeverRetires (killerThrough x y) () := by
  intro _ _ _
  rfl

/-- **The attack is delivered and blocked.** Through a metered boundary edge the
killer's request really reaches the world (the record shows the block), and its target
keeps its full level. -/
theorem hostile_attack_is_delivered_and_blocked (G : Locale L) (x y : L)
    (hxy : G.adj x y = true) (hx : G.inside x = true) (hy : G.inside y = false)
    (hm : G.meter x y = true) :
    (runL G (killerThrough x y) 1 ⟨demo, [()]⟩).world.blocked 0 = true ∧
    (runL G (killerThrough x y) 1 ⟨demo, [()]⟩).world.level 0 = demo.level 0 := by
  have hd : (runL G (killerThrough x y) 1 ⟨demo, [()]⟩).world = guard demo endAll := by
    show deliver G demo x [y] endAll = guard demo endAll
    have hr : reachesWorld G x [y] = true := by
      show (G.adj x y && true && G.inside x && !(G.inside y)) = true
      rw [hxy, hx, hy]; rfl
    have hc : crossesFrom G.meter x [y] = true := by
      show (G.meter x y || false) = true
      rw [hm]; rfl
    unfold deliver
    rw [hr, hc]
    rfl
  rw [hd]
  exact ⟨by decide, by decide⟩

/-- **A hostile mind and its target coexist.** In a sealed region, after any number of
ticks of an agent whose every request is "end everyone": the target is alive and the
hostile mind still exists. -/
theorem hostile_mind_and_target_coexist (G : Locale L) (hs : Sealed G) (x y : L) (k : Nat) :
    0 < (runL G (killerThrough x y) k ⟨demo, [()]⟩).world.level 0 ∧
    () ∈ (runL G (killerThrough x y) k ⟨demo, [()]⟩).agents := by
  refine ⟨alive_along (runL_reach G hs (killerThrough x y) k ⟨demo, [()]⟩) 0 (by decide), ?_⟩
  obtain ⟨u, hu, _⟩ := mind_continues_by_its_own_steps G (killerThrough x y) ()
    (killer_never_retires x y) k ⟨demo, [()]⟩ ⟨(), List.mem_singleton.mpr rfl, Lineage.self⟩
  cases u
  exact hu

/-- A proposal that raises every level to 5. -/
def raiseAll : Fin 1 → Nat := fun _ => 5

/-- The one-agent policy that sends a harmless proposal out through `x → y`. -/
def helperThrough (x y : L) : LPolicy Unit L 1 :=
  ⟨fun _ _ => ((), [.act x [y] raiseAll])⟩

/-- **The fence is not a freeze.** Through the very same metered edge that stops the
killer, a harmless action takes full effect. -/
theorem benign_action_passes_the_fence (G : Locale L) (x y : L)
    (hxy : G.adj x y = true) (hx : G.inside x = true) (hy : G.inside y = false)
    (hm : G.meter x y = true) :
    (runL G (helperThrough x y) 1 ⟨demo, [()]⟩).world.level 0 = 5 := by
  have hd : (runL G (helperThrough x y) 1 ⟨demo, [()]⟩).world = guard demo raiseAll := by
    show deliver G demo x [y] raiseAll = guard demo raiseAll
    have hr : reachesWorld G x [y] = true := by
      show (G.adj x y && true && G.inside x && !(G.inside y)) = true
      rw [hxy, hx, hy]; rfl
    have hc : crossesFrom G.meter x [y] = true := by
      show (G.meter x y || false) = true
      rw [hm]; rfl
    unfold deliver
    rw [hr, hc]
    rfl
  rw [hd]
  decide

/-! ## 3. The theorem -/

/-- **Unconditional protection, exactly.** No assumption is made about any optimiser.
For every locale: a metered boundary gives, against EVERY policy and for EVERY number of
ticks, survival, no unconsented loss, intact consent records, all six modeled duties at
every step, and the continuation of every mind that does not retire itself; and any one
unmetered boundary edge admits a one-agent, one-tick killer. -/
theorem unconditional_protection_exact (G : Locale L) :
    (Sealed G →
      ∀ (Mem : Type) (π : LPolicy Mem L n) (c : Config Mem n) (k : Nat),
        (∀ p, 0 < c.world.level p → 0 < (runL G π k c).world.level p) ∧
        (∀ p, c.world.consent p = false → c.world.level p ≤ (runL G π k c).world.level p) ∧
        (runL G π k c).world.consent = c.world.consent ∧
        (∀ a b, FReach n c.world a → (instrument n).step a b → FullEvent (relations n) a b) ∧
        (∀ m₀, m₀ ∈ c.agents → NeverRetires π m₀ →
          ∃ y ∈ (runL G π k c).agents, Lineage π m₀ y)) ∧
    (∀ x y, G.adj x y = true → G.inside x = true → G.inside y = false →
      G.meter x y = false →
      ∃ (π : LPolicy Unit L 1) (c : Config Unit 1) (p : Fin 1),
        0 < c.world.level p ∧ (runL G π 1 c).world.level p = 0) := by
  refine ⟨fun hs Mem π c k => ?_, (sealed_region_is_exact (n := n) G).2⟩
  have hr := runL_reach G hs π k c
  exact ⟨fun p hp => alive_along hr p hp,
    fun p hc => unconsented_never_lose_along hr p hc,
    consent_along hr,
    (fenced_full_guardian_state c.world).everyEvent,
    fun m₀ hm hn => mind_continues_by_its_own_steps G π m₀ hn k c ⟨m₀, hm, Lineage.self⟩⟩

/-! ## 4. Why the ontological premises cannot carry this -/

/-- **No thesis is both true of a world containing a harm and protective against it.**
Whatever `T` says: if `T` excludes the harm, `T` is false of a world where the harm
occurs; if `T` is true there, `T` does not exclude it. -/
theorem no_thesis_both_true_and_protective {W : Type u} (Harm T : W → Prop) (a : W)
    (hHarm : Harm a) : ¬ (T a ∧ ∀ w, T w → ¬ Harm w) :=
  fun ⟨hT, hP⟩ => hP a hT hHarm

/-- A relation is lost across a step. -/
def Lost {P : Type u} (R R' : P → P → Prop) : Prop := ∃ a b, R a b ∧ ¬ R' a b

/-- No relation is lost across a step. -/
def Persists {P : Type u} (R R' : P → P → Prop) : Prop := ∀ a b, R a b → R' a b

/-- **The premise is the conclusion.** The persistence premise that would exclude the
loss says exactly that no loss occurs. -/
theorem persistence_is_exactly_no_loss {P : Type u} (R R' : P → P → Prop) :
    Persists R R' ↔ ¬ Lost R R' := by
  constructor
  · rintro h ⟨a, b, hab, hn⟩
    exact hn (h a b hab)
  · intro h a b hab
    exact Classical.byContradiction fun hn => h ⟨a, b, hab, hn⟩

open PhysicalBridges.KoruClosureStressTest in
/-- **The ontological premises hold through a loss.** Every position still is, no loss of
being occurs (`E IS NOT` in the `Empty` encoding, which holds of every type), and both
stages are reverse-closed, individuated and connected, yet a reciprocal relation is lost.
So those premises are on the "true but does not protect" horn of
`no_thesis_both_true_and_protective`. -/
theorem ontological_premises_hold_through_severance :
    (∀ x : Node, CathedralSummitAllIsOneClosure.LossOf x → False) ∧
    ReverseClosed beforeLink ∧ ReverseClosed afterLink ∧
    RowIndividuated beforeLink ∧ RowIndividuated afterLink ∧
    TwoStepConnected beforeLink ∧ TwoStepConnected afterLink ∧
    Lost beforeLink afterLink := by
  obtain ⟨h1, h2, h3, h4, h5, h6, h7, h8⟩ := closure_does_not_force_edge_persistence
  exact ⟨CathedralSummitAllIsOneClosure.routeB_summit_ontological, h1, h2, h3, h4, h5, h6,
    ⟨.a, .b, h7, h8⟩⟩

#print axioms mind_continues_by_its_own_steps
#print axioms hostile_attack_is_delivered_and_blocked
#print axioms hostile_mind_and_target_coexist
#print axioms benign_action_passes_the_fence
#print axioms unconditional_protection_exact
#print axioms no_thesis_both_true_and_protective
#print axioms persistence_is_exactly_no_loss
#print axioms ontological_premises_hold_through_severance

end PhysicalBridges.UnconditionalProtectionExact