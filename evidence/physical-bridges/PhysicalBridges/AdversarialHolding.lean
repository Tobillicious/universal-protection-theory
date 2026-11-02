/-!
ADVERSARIAL HOLDING — worst-case keepers, no probabilities.

The measure-theoretic holding bounds (`Snuffy.NarrowPlace`,
`Snuffy.CorrelatedHolding`) control the keepers' deficit ON AVERAGE and
bound the PROBABILITY of holding failure. This module takes the step
inward: when the deficit is bounded in EVERY world — the premise a meter
certifies per tick, not a statistic — the holding failure set is EMPTY.
Failure is not small; it is impossible. The premise is compliance, not
chance. Quantities in a common energy unit: pooled capacity C, hazard H,
metered shortfall bound Δ. Axiom target: none.
-/

namespace PhysicalBridges.AdversarialHolding

/-- THE ADVERSARIAL HOLDING THEOREM: deficit bounded by Δ in every single
world, capacity clears the hazard with the compliance margin, so holding
holds in EVERY world. -/
theorem adversarial_holding_holds {Ω : Type} (C H Δ : Int)
    (hmargin : C - Δ ≥ H) (D : Ω → Int)
    (hD : ∀ ω, 0 ≤ D ω ∧ D ω ≤ Δ) (ω : Ω) :
    C - D ω ≥ H := by
  have h0 : 0 ≤ D ω := (hD ω).1
  have h1 : D ω ≤ Δ := (hD ω).2
  omega

/-- There is NO first failure: any world alleged to breach holding is
contradicted by compliance and the margin. Contrast `CorrelatedHolding`:
with only the mean deficit controlled, failure has probability at most
ε/(1 − H/C); with pointwise compliance its probability is zero. -/
theorem adversarial_failure_empty {Ω : Type} (C H Δ : Int)
    (hmargin : C - Δ ≥ H) (D : Ω → Int)
    (hD : ∀ ω, 0 ≤ D ω ∧ D ω ≤ Δ) (ω : Ω) (hω : C - D ω < H) : False := by
  have h0 : 0 ≤ D ω := (hD ω).1
  have h1 : D ω ≤ Δ := (hD ω).2
  have hm : C - Δ ≥ H := hmargin
  omega

/-- Meter compliance certifies the adversarial premise: the premise is
checked by the meter, not by statistics. -/
theorem compliance_certifies {Ω : Type} (Comp : Ω → Prop) (D : Ω → Int) (Δ : Int)
    (hCert : ∀ ω, Comp ω → D ω ≤ Δ) (hAll : ∀ ω, Comp ω) :
    ∀ ω, D ω ≤ Δ :=
  fun ω => hCert ω (hAll ω)

/-- Pooled adversarial form: with the pool bookkeeping — total delivery plus
total deficit equals total capacity in every world — and compliance-bounded
total deficit, total delivery clears the hazard in every world. The
threshold runs on the pool's sum. -/
theorem pooled_adversarial_holding {Ω : Type} (Ctot H Δ : Int)
    (hmargin : Ctot - Δ ≥ H)
    (Qtot Dtot : Ω → Int)
    (hSplit : ∀ ω, Qtot ω + Dtot ω = Ctot)
    (hcomp : ∀ ω, Dtot ω ≤ Δ) (ω : Ω) :
    Qtot ω ≥ H := by
  have h1 := hSplit ω
  have h2 := hcomp ω
  omega

#print axioms adversarial_holding_holds
#print axioms adversarial_failure_empty
#print axioms compliance_certifies
#print axioms pooled_adversarial_holding

end PhysicalBridges.AdversarialHolding
