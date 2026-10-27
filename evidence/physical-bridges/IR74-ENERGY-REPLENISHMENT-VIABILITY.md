# IR-74 — Energy exhaustion and independently warranted replenishment

Source: original X3 physical-history programme, archived X3-DERIVATIONS and mandatory-protection context; mainline IR-72's **all finite robust horizons ⇒ one infinite safe policy** theorem.

## Kernel-checked results

1. **Exact finite-bank viability:** In a discrete mandatory-service model with energy credit E and exactly one positive unit consumed per tick, `Viable n E ↔ n < E`. In particular, horizon E is not viable with E fixed. This directly refutes the claim that a fixed battery draining by a positive amount has every finite horizon viable but lacks an infinite policy.
2. **Actual replenishment as a sufficient invariant:** With a positive reserve R, cost c per step and supply(d) delivered under disturbance d, assuming `∀d, supply(d) ≥ c`, the fixed permitting action preserves `energy ≥ R` for all admissible disturbances. Composition with IRViability derives *all* finite horizons, and with IR-72 derives one indefinitely safe modeled policy.
3. **An adverse-supply negative control:** If supply is guaranteed only in favorable disturbance cases, the reserve can fail after one tick. Existence of one replenishing schedule is not robust viability.

The energy arithmetic uses Nat integer credit units. This is **not** a proof of physical perpetual motion, a real uniform energy source, or any hardware guarantee. Replenishment is an independent physical contract; it might include solar input, delivered replacement fuel, externally funded maintenance, resource renewals and fault-tolerant storage, but only measured/enforced capacity counts.

## Precise physical gap

To use the theorem for original X3 one must identify each actual mandatory service/continuation cost, calibrated available energy over every possible disturbance, a complete renewable source and replacement schedule, a consistent time/energy unit, and a real robust policy that does not freeze autonomy. Proving a *reserve invariant* does not automatically prove historical same-particular identity, nontrivial service/liveness, or global original X3 lex maximality.

A 100 J starting battery with 5 J reserve and a 0.01 J/tick strict mandatory cost has 95 J of headroom. With no replenishment, it can pay 9500 ticks and reach 5 J, then the **9501st** costs below reserve. No 'all finite horizons' claim can hold in this fixed model.

**Status:** Lean-verified conditional model mathematics; original physical X3 uniform robust replenishment remains OPEN.