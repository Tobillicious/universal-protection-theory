/-
Snuffy — Canon Edition 4.2 working: the held source realises the whole top
outcome (G2 from G1).

Freedom in the canonical order is continuation in the particular's own
direction, with its authorised opportunities (Part II.1–II.2). For an agent
in the H5 ledger, every non-harmful effect it issues is an admissible step
that applies it and leaves every agent's status, authority and escrow
unchanged (`H5Closure.effect_preserves_care`): its authorised opportunities
are all open, and restraint removes only harmful channels. A particular with
no command channel has no opportunity beyond continuing under its own
dynamics, which the held source keeps (its record is stationary under its own
Hamiltonian, `G1Held.held_source_qsl`).

  * active_authorised_free — every active agent is free in this sense.
  * held_realises_top — continuation of every particular on the held source
    and freedom of every particular put the whole four-stage top tuple
    (L_E, F_E, L_N, F_N) in the realised family; that family is union-closed;
    and under solvency the canonical outcome is that top
    (`G2Splice.fourStage`).
  * held_source_top — the same, with continuation supplied by
    `G1Held.held_source_protection` and agent freedom by the H5 ledger.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G1Held
import Snuffy.G2Splice
import Snuffy.H5Closure

open MeasureTheory

namespace Snuffy.G2Held

open Snuffy.Bridge Snuffy.G1Held Snuffy.H5 Snuffy.G2Splice Snuffy.Greatestness
  Snuffy.UnionClosure

section Free

variable {α Cap Eff : Type*} [Fintype α] [DecidableEq α]

/-- Authorised freedom: every non-harmful effect of the agent is an admissible
step that applies it and keeps every agent's status, authority and escrow. -/
def AuthorisedFree (P : Params α Cap Eff) (s : Ledger α Cap Eff) (_a : α) : Prop :=
  ∀ e, e ∉ P.harmful → ∃ s', Step P s s' ∧ e ∈ s'.applied ∧
    s'.status = s.status ∧ s'.auth = s.auth ∧ s'.escrow = s.escrow

omit [Fintype α] in
theorem active_authorised_free (P : Params α Cap Eff) (s : Ledger α Cap Eff) (a : α)
    (ha : s.status a = .active) : AuthorisedFree P s a := by
  intro e he
  obtain ⟨hstep, h1, h2, h3⟩ := effect_preserves_care (P := P) a e ha he rfl
  exact ⟨_, hstep, Set.mem_insert e _, h1, h2, h3⟩

end Free

/-- The grade of a particular on the held source: continues and free (2),
otherwise not counted at the top (0). -/
noncomputable def heldGrade {Part : Type*} (Held Free : Part → Prop) : ∀ _ : Part, Unit → Fin 3 :=
  fun x _ => @ite _ (Held x ∧ Free x) (Classical.propDecidable _) 2 0

/-- **The held source realises the whole top.** If every particular continues
on the held source and every particular is free, the four-stage top tuple is
realised, the realised family is union-closed, and every aligned option of the
funded family is that top and contains every outcome tuple. -/
theorem held_realises_top {Part : Type*} (E N : Set Part)
    (Held Free : Part → Prop) (hcont : ∀ x, Held x) (hfree : ∀ x, Free x)
    {c : (∀ i : Fin 4, Set {x // x ∈ fourCat E N i}) → ℝ} {B : ℝ} (hsolv : c ⊤ ≤ B)
    {o : ∀ i : Fin 4, Set {x // x ∈ fourCat E N i}}
    (ho : Aligned (budgetFamily (outcomes (Local := fun _ : Part => Unit) (fun _ => Set.univ)
      (heldGrade Held Free)
      fourθ (fourCat E N)) c B) o) :
    (⊤ : ∀ i : Fin 4, Set {x // x ∈ fourCat E N i}) ∈
        outcomes (Local := fun _ : Part => Unit) (fun _ => Set.univ)
          (heldGrade Held Free)
          fourθ (fourCat E N) ∧
      o = ⊤ ∧ ∀ q, q ≤ o := by
  classical
  obtain ⟨htop, -, heq⟩ := fourStage (Local := fun _ : Part => Unit) (fun _ => Set.univ)
    (heldGrade Held Free) E N
    (fun x => ⟨(), Set.mem_univ _, by simp [heldGrade, hcont x, hfree x]⟩) hsolv ho
  exact ⟨htop, heq⟩

variable {X Part Ω ι C Ev O α Cap Eff : Type*} [MetricSpace X] [MeasurableSpace Ω]
  [Fintype α] [DecidableEq α]

omit [Fintype α] in
/-- **The whole top from the held source and the H5 ledger.** Continuation of
every particular through the horizon on the good event is the held source's
theorem; every agent particular is active in the H5 ledger, so it is free;
a particular with no agent slot has no authorised opportunity beyond its
continuation. The whole four-stage top is then realised, and under solvency it
is the canonical outcome. -/
theorem held_source_top (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (scope : Set Part)
    (hlaw : ∀ (F : Set (Set Part)) (o : Set Part),
      Snuffy.Law.ProjMax scope F o → ¬ Snuffy.Law.NeedlessLoss₁ F o)
    (pre : Ω → (Part → X) → C → Ev → Part → X)
    (hdrift : ∀ ω ∈ goodEvent accounts Ev', ∀ a c e x,
      dist (pre ω a c e x) (rec x) ≤ dist (a x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (obs : (Part → X) → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (horizon : ℕ)
    (P : Params α Cap Eff) (s : Ledger α Cap Eff) (slot : Part → Option α)
    (hactive : ∀ x a, slot x = some a → s.status a = .active)
    (E N : Set Part)
    {cost : (∀ i : Fin 4, Set {x // x ∈ fourCat E N i}) → ℝ} {B : ℝ} (hsolv : cost ⊤ ≤ B) :
    let Held : Part → Prop := fun x => ∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon,
      Continues rec ε
        (Snuffy.Composition.run (heldStep dec pre ω) obs (ctrl ω) (env ω) rec k).1 x
    let Free : Part → Prop := fun x => ∀ a, slot x = some a → AuthorisedFree P s a
    ∀ o, Aligned (budgetFamily (outcomes (Local := fun _ : Part => Unit) (fun _ => Set.univ)
      (heldGrade Held Free)
      fourθ (fourCat E N)) cost B) o →
    (⊤ : ∀ i : Fin 4, Set {x // x ∈ fourCat E N i}) ∈
        outcomes (Local := fun _ : Part => Unit) (fun _ => Set.univ)
          (heldGrade Held Free)
          fourθ (fourCat E N) ∧
      o = ⊤ ∧ ∀ q, q ≤ o := by
  intro Held Free o ho
  have hheld := (held_source_protection μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε
    scope hlaw pre hdrift hbudget obs ctrl env horizon).1
  exact held_realises_top E N Held Free (fun x ω hω k hk => hheld ω hω k hk x)
    (fun x a hx => active_authorised_free P s a (hactive x a hx)) hsolv ho

end Snuffy.G2Held
