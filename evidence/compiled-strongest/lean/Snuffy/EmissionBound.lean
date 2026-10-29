import Mathlib

/-!
# Unmediated emissions cannot carry a targeted harm (compiled edition, XI.3)

Corollary XI.3 mediates a digital mind at its substrate's output channels. Its
physical emissions (heat, radiation, power draw) are outputs too. Two bounds
make them part of the mediated ledger:

* `requisite_variety` (Another Origin D116): a channel that delivers one of `M`
  messages lets a responder answer correctly for at most `M` of the possible
  disturbances, whatever encoder and decoder are used. A targeted effect that
  must select one of more than `M` distinct responses cannot be delivered
  through it with certainty; under uniform disturbances its success
  probability is at most `M / |D|` (`requisite_variety_prob`).
* `unmetered_energy_bound` (conservation, BCRD P1): metered input energy
  splits into the energy accounted at the fenced sinks and the emitted
  remainder; an effect needing more work than the unaccounted remainder
  cannot be powered by emissions.
-/

namespace Snuffy.EmissionBound

/-- Requisite variety: through a channel with message set `M`, the number of
disturbances `d` that the responder `g` answers correctly (`g (f d) = d`) is at
most `|M|`. -/
theorem requisite_variety {D M : Type*} [Fintype D] [Fintype M] [DecidableEq D]
    (f : D → M) (g : M → D) :
    (Finset.univ.filter (fun d => g (f d) = d)).card ≤ Fintype.card M := by
  classical
  have hinj : Set.InjOn f (Finset.univ.filter (fun d => g (f d) = d) : Set D) := by
    intro x hx y hy hxy
    simp only [Finset.coe_filter, Finset.mem_univ, true_and, Set.mem_ofPred_eq] at hx hy
    rw [← hx, ← hy, hxy]
  calc (Finset.univ.filter (fun d => g (f d) = d)).card
      ≤ (Finset.univ : Finset M).card :=
        Finset.card_le_card_of_injOn f (fun _ _ => Finset.mem_univ _) hinj
    _ = Fintype.card M := Finset.card_univ

/-- Under uniformly distributed disturbances, the success probability through a
channel with `|M|` messages is at most `|M| / |D|` (D116: `2^(k-n)` for `k` bits
against `n`-bit disturbances). -/
theorem requisite_variety_prob {D M : Type*} [Fintype D] [Fintype M] [DecidableEq D]
    [Nonempty D] (f : D → M) (g : M → D) :
    ((Finset.univ.filter (fun d => g (f d) = d)).card : ℝ) / Fintype.card D ≤
      (Fintype.card M : ℝ) / Fintype.card D := by
  have hD : (0 : ℝ) < Fintype.card D := by exact_mod_cast Fintype.card_pos
  exact div_le_div_of_nonneg_right (by exact_mod_cast requisite_variety f g) hD.le

/-- D116 with bits: `k` message bits against `n`-bit disturbances. -/
theorem narrow_channel_bits (n k : ℕ) (f : Fin (2 ^ n) → Fin (2 ^ k))
    (g : Fin (2 ^ k) → Fin (2 ^ n)) :
    (Finset.univ.filter (fun d => g (f d) = d)).card ≤ 2 ^ k := by
  simpa using requisite_variety f g

/-- Conservation: metered input = accounted + emitted. An effect needing work
`W` delivered through emissions requires `W ≤ E_in - E_acc`. -/
theorem unmetered_energy_bound (E_in E_acc E_em W : ℝ)
    (hcons : E_in = E_acc + E_em) (hpow : W ≤ E_em) :
    W ≤ E_in - E_acc := by
  linarith

/-- Contrapositive form used in XI.3: if the effect needs more work than the
unaccounted remainder, emissions cannot power it. -/
theorem emission_cannot_power (E_in E_acc E_em W : ℝ)
    (hcons : E_in = E_acc + E_em) (hneed : E_in - E_acc < W) :
    E_em < W := by
  linarith

end Snuffy.EmissionBound
