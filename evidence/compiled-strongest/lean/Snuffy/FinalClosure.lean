/-
Snuffy — Canon Edition v4.1: bridge 13, the formal limits of semantic and
final closure (S4, L1, QED-1, QED-2), with K1. The interpretive closure
passages QED-3, QED-5, QED-7, Ω, Z1 and 0 are held alongside the mathematics
as the author's philosophical ending (reconciliation answer 3, 24 October 2026).

  * S4, the anti-Goodhart theorem — a verifier is ungameable and admits every
    surviving state iff it is the survival threshold itself
    (`verifier_bound_iff`); a verifier read through a proxy can be made so iff
    the proxy determines the threshold (`proxy_ungameable_iff`); otherwise
    every such verifier passes a gamed state or rejects a surviving one
    (`proxy_gameable`).
  * L1, the necessity of the living — under the generator law (novelty rate
    `κ Σ_{m living} a(m) f(m)`, autopoiesis times freedom), pruning any living
    particulars lowers the optimizer's growth rate by exactly their share
    (`pruning_lowers_rate`); with the living kept the objective grows without
    bound (`living_unbounded`); with none kept its gradient is zero for all
    time (`pruning_all_stalls`).
  * QED-1, nihilism nullified — on the void utility is undefined (`⊥`); every
    existing option lies strictly above it, so no optimizer's choice among
    options that include an existing one is the void (`void_never_chosen`).
  * QED-2, relational resonance — zero-sum dominance monitors every ordered
    pair, `N(N−1)` channels (`dominance_channels`); shared intent needs `N`; for
    `N ≥ 3` cooperation is strictly more efficient (`coop_more_efficient`).
    The thermodynamic half is `ReasonsCompiled`: the controller of the
    diffusive pays the diverging floor, and the canonical regime is strictly
    better for each particular (`reciprocity_strict`).
  * K1, kaitiaki reciprocal equilibrium — with a finite reserve and window
    balance `k`, access is sustained at every window iff `k ≥ 0`
    (`sustained_iff`); non-negative balances sustain any reserve
    (`stewardship_sustains`); balances at most `−δ < 0` deplete it in finite
    time (`extraction_depletes`). K1 governs extraction access only; the care of
    every particular is the holding route `H(m)`, independent of contribution.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.ReasonsCompiled

open Filter Finset

namespace Snuffy.FinalClosure

/-! ## S4: the anti-Goodhart theorem -/

section S4

variable {S P : Type*} (Ψ : S → ℝ) (Θ : ℝ)

/-- No gamed pass: every state the verifier accepts meets the survival threshold. -/
def Sound (V : S → Prop) : Prop := ∀ σ, V σ → Θ ≤ Ψ σ

/-- No surviving state is rejected. -/
def Complete (V : S → Prop) : Prop := ∀ σ, Θ ≤ Ψ σ → V σ

/-- **S4.** A verifier is sound and complete iff it is bound to the survival
invariant itself: `V σ ↔ Ψ σ ≥ Θ`. -/
theorem verifier_bound_iff (V : S → Prop) :
    (Sound Ψ Θ V ∧ Complete Ψ Θ V) ↔ V = fun σ => Θ ≤ Ψ σ := by
  constructor
  · rintro ⟨hs, hc⟩
    funext σ
    exact propext ⟨hs σ, hc σ⟩
  · rintro rfl
    exact ⟨fun _ h => h, fun _ h => h⟩

/-- **S4, proxies.** A verifier that reads the state only through a proxy `f`
can be made sound and complete iff the proxy determines the survival
threshold. -/
theorem proxy_ungameable_iff (f : S → P) :
    (∃ g : P → Prop, Sound Ψ Θ (g ∘ f) ∧ Complete Ψ Θ (g ∘ f)) ↔
      ∀ σ σ', f σ = f σ' → Θ ≤ Ψ σ → Θ ≤ Ψ σ' := by
  constructor
  · rintro ⟨g, hs, hc⟩ σ σ' heq h
    have hg : g (f σ') := heq ▸ hc σ h
    exact hs σ' hg
  · intro H
    refine ⟨fun p => ∃ τ, f τ = p ∧ Θ ≤ Ψ τ, ?_, ?_⟩
    · rintro σ ⟨τ, hτ, h⟩
      exact H τ σ hτ h
    · intro σ h
      exact ⟨σ, rfl, h⟩

/-- **Goodhart, exactly.** If two states share a proxy reading but only one
survives, every proxy verifier either passes a gamed state or rejects a
surviving one. -/
theorem proxy_gameable (f : S → P) (g : P → Prop) {σ σ' : S} (heq : f σ = f σ')
    (hsurv : Θ ≤ Ψ σ) (hfail : Ψ σ' < Θ) :
    ¬ (Sound Ψ Θ (g ∘ f) ∧ Complete Ψ Θ (g ∘ f)) := by
  rintro ⟨hs, hc⟩
  have hg : g (f σ') := heq ▸ hc σ hsurv
  exact absurd (hs σ' hg) (not_le.mpr hfail)

end S4

/-! ## L1: the necessity of the living -/

section L1

variable {ι : Type*} (κ : ℝ) (a f : ι → ℝ)

/-- The generator law: the optimizer's novelty rate from the living set `A`,
autopoiesis `a` times freedom `f`. -/
def rate (A : Finset ι) : ℝ := κ * ∑ m ∈ A, a m * f m

/-- The objective under constant rate from kept set `A`. -/
def objective (U₀ : ℝ) (A : Finset ι) (t : ℝ) : ℝ := U₀ + t * rate κ a f A

/-- **L1, pruning.** Pruning `W` from the living set `A` lowers the rate by
exactly the pruned share, strictly when `W` holds a living particular. -/
theorem pruning_lowers_rate [DecidableEq ι] (hκ : 0 < κ) (ha : ∀ m, 0 < a m) (hf : ∀ m, 0 < f m)
    {A W : Finset ι} (hW : W ⊆ A) (hne : W.Nonempty) :
    rate κ a f A - rate κ a f (A \ W) = κ * ∑ m ∈ W, a m * f m ∧
      rate κ a f (A \ W) < rate κ a f A := by
  have hsplit : ∑ m ∈ A, a m * f m = ∑ m ∈ A \ W, a m * f m + ∑ m ∈ W, a m * f m :=
    (sum_sdiff hW).symm
  have hpos : 0 < ∑ m ∈ W, a m * f m := sum_pos (fun m _ => mul_pos (ha m) (hf m)) hne
  refine ⟨by unfold rate; rw [hsplit]; ring, ?_⟩
  unfold rate
  rw [hsplit]
  nlinarith

/-- **L1, the living sustain the optimizer.** With a living particular kept,
the objective grows without bound. -/
theorem living_unbounded (hκ : 0 < κ) (ha : ∀ m, 0 < a m) (hf : ∀ m, 0 < f m)
    {A : Finset ι} (hA : A.Nonempty) (U₀ : ℝ) :
    Tendsto (objective κ a f U₀ A) atTop atTop := by
  have hr : 0 < rate κ a f A :=
    mul_pos hκ (sum_pos (fun m _ => mul_pos (ha m) (hf m)) hA)
  unfold objective
  exact tendsto_atTop_add_const_left _ _ (tendsto_id.atTop_mul_const hr)

/-- **L1, solipsistic collapse.** With every living particular pruned, the
objective's gradient is zero at every time: a degenerate dead loop. -/
theorem pruning_all_stalls (U₀ t : ℝ) :
    HasDerivAt (objective κ a f U₀ ∅) 0 t ∧ ∀ s, objective κ a f U₀ ∅ s = U₀ := by
  have h0 : rate κ a f (∅ : Finset ι) = 0 := by simp [rate]
  have hc : objective κ a f U₀ ∅ = fun _ => U₀ := by
    funext s; simp [objective, h0]
  refine ⟨?_, fun s => by rw [hc]⟩
  rw [hc]
  exact hasDerivAt_const t U₀

end L1

/-! ## QED-1: nihilism nullified -/

section QED1

variable {S : Type*} (U : S → ℝ)

/-- Value of an option: `none` is the void, where utility is undefined (`⊥`). -/
def value : Option S → WithBot ℝ
  | none => ⊥
  | some s => (U s : WithBot ℝ)

/-- Every existing option lies strictly above the void. -/
theorem void_strictly_below (s : S) : value U none < value U (some s) :=
  WithBot.bot_lt_coe (U s)

/-- **QED-1.** An optimizer's choice among options that include an existing
one is never the void. -/
theorem void_never_chosen (F : Set (Option S)) {s : S} (hs : some s ∈ F)
    {o : Option S} (hmax : ∀ q ∈ F, value U q ≤ value U o) : o ≠ none := by
  rintro rfl
  exact absurd (hmax _ hs) (not_le.mpr (void_strictly_below U s))

end QED1

/-! ## QED-2: relational resonance -/

section QED2

/-- Zero-sum dominance monitors every ordered pair of distinct agents. -/
theorem dominance_channels (N : ℕ) :
    ((univ : Finset (Fin N)).offDiag).card = N * (N - 1) := by
  rw [offDiag_card, card_univ, Fintype.card_fin, Nat.mul_sub_one]

/-- **QED-2.** With work `W > 0` and cost `c > 0` per channel, shared intent
(`N` channels) is strictly more efficient than dominance (`N(N−1)`) for
`N ≥ 3`. -/
theorem coop_more_efficient {N : ℕ} (hN : 3 ≤ N) {W c : ℝ} (hW : 0 < W) (hc : 0 < c) :
    W / (W + c * ((N : ℝ) * ((N : ℝ) - 1))) < W / (W + c * N) := by
  have hN' : (3 : ℝ) ≤ N := by exact_mod_cast hN
  have hlt : c * (N : ℝ) < c * ((N : ℝ) * ((N : ℝ) - 1)) := by
    apply mul_lt_mul_of_pos_left _ hc; nlinarith
  apply div_lt_div_of_pos_left hW (by positivity) (by linarith)

end QED2

/-! ## K1: kaitiaki reciprocal equilibrium -/

section K1

/-- The reserve after `n` windows with window balances `k`. -/
def stock (S₀ : ℝ) (k : ℕ → ℝ) (n : ℕ) : ℝ := S₀ + ∑ i ∈ range n, k i

/-- Non-negative stewardship balances never draw the reserve down. -/
theorem stewardship_sustains (S₀ : ℝ) (k : ℕ → ℝ) (hk : ∀ i, 0 ≤ k i) (n : ℕ) :
    S₀ ≤ stock S₀ k n := by
  unfold stock
  linarith [sum_nonneg (fun i (_ : i ∈ range n) => hk i)]

/-- Extraction exceeding replenishment by `δ > 0` each window exhausts any
finite reserve in finite time. -/
theorem extraction_depletes (S₀ : ℝ) (k : ℕ → ℝ) {δ : ℝ} (hδ : 0 < δ)
    (hk : ∀ i, k i ≤ -δ) : ∃ n, stock S₀ k n < 0 := by
  obtain ⟨n, hn⟩ := exists_nat_gt (S₀ / δ)
  refine ⟨n, ?_⟩
  have hsum : ∑ i ∈ range n, k i ≤ ∑ _i ∈ range n, -δ := sum_le_sum fun i _ => hk i
  rw [sum_const, card_range, nsmul_eq_mul] at hsum
  have : S₀ < n * δ := by rwa [div_lt_iff₀ hδ] at hn
  unfold stock
  linarith

/-- **K1.** With a finite reserve and a stationary window balance `k`, access
is sustained at every window iff `k ≥ 0`. -/
theorem sustained_iff (S₀ k : ℝ) : (∀ n, 0 ≤ stock S₀ (fun _ => k) n) ↔ 0 ≤ k ∧ 0 ≤ S₀ := by
  constructor
  · intro h
    have h0 : 0 ≤ S₀ := by simpa [stock] using h 0
    refine ⟨?_, h0⟩
    by_contra hk'
    have hk : k < 0 := lt_of_not_ge hk'
    obtain ⟨n, hn⟩ := extraction_depletes S₀ (fun _ => k) (neg_pos.mpr hk) (fun _ => by simp)
    exact absurd (h n) (not_le.mpr hn)
  · rintro ⟨hk, h0⟩ n
    linarith [stewardship_sustains S₀ (fun _ => k) (fun _ => hk) n]

end K1

end Snuffy.FinalClosure
