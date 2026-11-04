# Structure Spec — Category Time & Boundary-as-Genesis
**4 November 2026 · noncanonical · pre-Lean design spec · review-first · research lane · no release.**

A fence built before we go near the edge. Design only — no Lean has been written against
this yet. The whole spec is organised around one rule: **protect the arrow; the reversal lives
at the boundary; prove the machine is impossible rather than warn about it** — and one
reframing: **the boundary is not reversal, it is the genesis of the next.**

## 0. Intent, one line
We do **not** model time going backward. We model **why it categorically cannot, for any
subject**, while the whole stays conserved — and we identify the heat-death boundary as the
**genesis of the next**, carrying everything forward, losing nothing.

## 1. The two lists
**SHOW:**
- The **category distinction** between *objective* time (U as one whole) and *subjective* time
  (a position inside U), as **distinct types that provably don't collapse.**
- The interior **arrow** is strict (the Second Law) → **no interior return.**
- The objective whole carries a **global bijection** (koru/`Reindex`) — reversible/conserving,
  *pre-time*, a property of the whole only.
- The **non-implication**: objective reversibility grants **no** interior reverse (the category
  seal, as a theorem).
- The boundary = heat death = **arrow-maximum**; the koru there is **genesis**
  (terminus → next beginning, *forward → forward*), not reversal.
- **Nothing-lost = forward-carry** across the boundary: conservation realized as genesis.

**REFUSE (binding — if the artifact starts to look like any of these, stop):**
- No interior inverse, no construction/algorithm, no retrocausal channel — ever exhibited.
- **Do not inherit** `CyclicHistory.periodic` — `F^p = id` is an interior return and contradicts
  the arrow. Supersede it.
- Property-level, non-constructive wherever a construction would *be* the hazard.
- No claim about actual cosmology — structural model, labelled.
- Do not weaken the arrow. Do not pretend to discharge the keystone.

## 2. The structure (two layers, never one)
- **Objective** `Whole`: U as one actuality — the koru `Web` + `Reindex` (whole-at-once
  bijection). No "now." Reversible/conserving as a property of the *whole*.
- **Subjective / interior**: `Position`s in time; `arrow : Position → Phase` (entropy-like); a
  forward `step`; **the Second Law = strict monotonicity of `arrow` along `step`.**
- **Boundary**: `terminus` := where `arrow` is maximal (heat death);
  `genesis : terminus → (next) interior-start` — the koru at the boundary, a **forward** map
  that *creates* the next.
- **Carry**: a conserved invariant that `genesis` forwards across the boundary.
- **Hard rule:** `Objective` and `Position` are different types with **no coercion between
  them.** A coercion would be the category error walking back in.

## 3. The three theorems — all forward
1. **`no_backward_time`** — an interior inverse-step entails `False` (it would lower `arrow`,
   contradicting the Second Law). The trivial-paradox-as-guard, turned into a proof: the machine
   cannot even be *stated* consistently.
2. **`objective_reversibility_does_not_descend`** — the whole's bijection yields no interior
   inverse. *This single non-implication is the entire safety case:* reversible-as-a-whole
   ⊬ reversible-from-inside.
3. **`boundary_is_genesis`** — `genesis` maps `terminus` to the next beginning (provably forward,
   provably **not** terminus→earlier-interior), and **`nothing_lost_forward`**: the conserved
   invariant is carried across into the next. **`continuation_by_chaining`** — no final stage,
   from genesis, **never** from interior recurrence.

## 4. Protection & keystone (honest)
- "Nothing lost" = forward-carry at genesis → protection is a **boundary / eschatological**
  truth, fully consistent with **real, non-final interior harm**.
- This **does not discharge the keystone** (the ALL-IS-ONE inversion is ontological and provably
  not eliminable — `CathedralSummitPremiseNecessity`). It **shows the safe shape**; it does not
  smuggle the summit. No PR C.

## 5. The guardrails are detectors, not reassurance
Each theorem ships a **positive control** it must *reject*:
- an "interior machine" world (an interior inverse, or a periodic return) → must fail
  `no_backward_time` / must not typecheck as a lawful interior;
- a "reversal boundary" (a terminus→earlier map) → must be distinguished from `genesis`.
Three outcomes, never two: **forward-genesis / interior-machine / ill-formed.** A guardrail that
cannot tell them apart is a broken detector and is not trusted.

## 6. Non-constructive by design
`Objective` reversibility is the *existence/property* of a whole-bijection, confined to the
whole — never an interior extractable operation. `genesis` is forward; **no backward map is ever
exhibited, at any layer.** Existing `involutive` results stay as objective-layer algebra; the
arrow sits above them so nothing shipped reads as "reverse anytime."

## 7. The edges to nail before any Lean
- `no_backward_time` must be the **genuine** negation of a usable interior reversal (validated
  against the §5 machine-world), not a weaker strawman. Scope must match the claim.
- `boundary_is_genesis` must be **provably forward** — a theorem that it is *not* a
  terminus→interior-past map, or "genesis" could secretly be "reversal" in nicer words.
- The objective/subjective **non-collapse** must itself be a theorem — the two layers stay two.

## 8. FIND BEFORE BUILD
- **Reuse:** `Koru.Web` / `Koru.Reindex` (objective whole-bijection) + the conservative koru laws.
- **Avoid / supersede:** `CathedralSummitCyclicContinuation.CyclicHistory.periodic` (interior
  recurrence).
- **Read first:** `CathedralSummitPremiseNecessity` (what is proven about the premise /
  continuation), `ContinuationSubject.LaterStage` (identity-continuation hook), `IRContinuation`.
- **Reconcile:** the new arrow with existing `involutive` — prove they coexist (objective
  property vs. forbidden interior application), no contradiction.

## 9. Lane & review
Research lane, kernel-checked, axioms within `{propext, Classical.choice, Quot.sound}`,
hostile-reviewed, **no canon, no release**, labelled structural.

## 10. The flag this builds toward
Not "we proved time can go back." The opposite and stronger: **from the structure of
being-in-time, it categorically cannot — and the very thing that looks like reversal is, read
correctly, the birth of what comes after, with nothing lost in the crossing.** The arrow is safe
because the law is logic; the next is real because the whole is conserved; and the subject is
untouched because the objective register can only ever *create forward into* the subjective one.
