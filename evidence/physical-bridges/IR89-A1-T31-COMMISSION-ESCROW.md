# IR-89 — A1 T3.1 commissioning escrow as a bounded-cost and robust-reserve contract

**Recovered archive source:** original 2026-10-24 A1-REGISTER T3.1: commissioning must have escrow for initial and continuing costs.

## Mathematical repair

The source accepts a finite commissioning horizon only when
`initialCost + horizon * recurringCost ≤ escrow`.
This is a **total finite-window budget**, not merely a one-time launch fee. Lean proves that the budget covers every earlier tick within the certified horizon.

If a strictly positive recurring mandatory cost exists without replenishment, **no fixed finite escrow** covers all future finite horizons. This is demonstrated by a finite horizon larger than the whole escrow. It matches the IR-74 exhaustion result and prevents a false inference that finite launch funding implies indefinite physical preservation.

## Constructive sufficient route under an explicit physical premise

Connect T3.1 to the independently verified **IR-74/IR-72 all-horizon reserve policy** theorem:

- Initial commissioning payment leaves `escrow - initialCost ≥ reserve`;
- For every admitted disturbance, independently warranted delivered replenishment per tick is **at least** `recurringCost`.

Then there exists one indefinitely reserve-safe modeled policy for every disturbance sequence in the specified discrete plant. This is source-level nontrivial theorem composition, not assumed all-horizon viability.

Hostile control: intermittent supply that sometimes fails to meet even one mandatory step can violate the reserve even when favorable supply traces exist. Commissioning acceptance cannot be based solely on an optimistic replenishment schedule.

## Physical X3 obligations remain

There is no demonstrated physical renewable energy/funding infrastructure, fault-complete consumption accounting, honest resource telemetry, actual continual maintenance supply under arbitrary real disturbances, commissioning of all original historical particulars, continued freedom to change, or original X3 global physically feasible maximality.

A physical T3.1 contract also needs mandatory duties and their service identities, initial plus ongoing hardware/journal/service costs, actual release and escrow custody, power-loss reserve semantics, and external audit of replenishment agreements. A numeric Nat model is not a measured financial/energy reality.

**Status:** source-level finite budget and conditional reserve-viability theorem only.
