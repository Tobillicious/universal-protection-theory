# Structure Spec — Category Time & Boundary-as-Genesis
**4 November 2026 · noncanonical · pre-Lean design spec · review-first · research lane · no release.**
**v2 — incorporates Tenzing's #291 review (three distinct conditions + physics scope).**

A fence built before we go near the edge. Design only — no Lean has been written against
this yet. Organised around one rule — **protect the arrow; the reversal lives at the boundary;
prove the machine is impossible rather than warn about it** — and one reframing: **the boundary
is not reversal, it is the genesis of the next.**

## 0. Intent, one line
We do **not** model time going backward. We model, **within a specified causal model**, **why
an interior subject categorically cannot reverse**, while the whole stays conserved — and we
identify the heat-death boundary as the **genesis of the next**, carrying everything forward,
losing nothing. **We do not claim a universal physical impossibility of backward time** (see §9).

## 1. The two lists
**SHOW:**
- The **category distinction** between *objective* time (U as one whole) and *subjective* time
  (a position inside U), as **distinct types that provably don't collapse.**
- **Three distinct, non-interchangeable conditions** (Tenzing #291), each its own predicate:
  (a) **causal direction** — every permitted event, *including the epoch crossing*, advances a
  global temporal ordering; (b) **entropy arrow** — an entropy-like quantity rises on the
  interior (may reset at genesis); (c) **spatial handedness** — a chosen right-handed orientation
  is preserved.
- The objective whole carries a **global bijection** (koru/`Reindex`) — reversible/conserving,
  *pre-time*, a property of the whole only.
- The **non-implication**: objective reversibility (or a repeated state) grants **no** interior
  reverse (the category seal, as a theorem).
- The boundary = heat death = **arrow-maximum**; the koru there is **genesis**
  (terminus → next beginning, *forward → forward*), **orientation-preserving**, advancing the
  causal order — not reversal, not a mirror.
- **Nothing-lost = forward-carry** across the boundary: conservation realized as genesis.

**REFUSE (binding):**
- No interior inverse, no construction/algorithm, no retrocausal channel — ever exhibited.
- **Do not inherit** `CyclicHistory.periodic` — `F^p = id` is an interior return and contradicts
  the causal direction + arrow. Supersede it.
- **No mirror/parity flip at the boundary** — genesis is orientation-*preserving*; a
  handedness-reversing crossing is explicitly rejected.
- **No claim of universal physical backward-time impossibility** — the no-reverse result is
  model-internal, not a refutation of GR closed-timelike-curve spacetimes (§9).
- Property-level, non-constructive wherever a construction would *be* the hazard.
- No claim about actual cosmology — the heat-death→new-epoch crossing is a **proposed structure,
  not an observed fact.** Do not weaken the arrow. Do not pretend to discharge the keystone.

## 2. The structure (two layers; three conditions; never collapsed)
- **Objective** `Whole`: U as one actuality — the koru `Web` + `Reindex` (whole-at-once
  bijection). No "now." Reversible/conserving as a property of the *whole*.
- **Subjective / interior**: `Position`s in time, carrying three *separate* data:
  - `causalOrder : Position → Ordinal`-like — the global temporal successor;
  - `arrow : Position → Phase` — entropy-like;
  - `handed : Position → Orientation` — the chosen right-handed frame.
  A forward `step`; the interior laws say `step` **advances `causalOrder`** and **raises `arrow`**
  and **preserves `handed`** — three conditions, each stated and proved separately.
- **Boundary**: `terminus` := where `arrow` is maximal (heat death);
  `genesis : terminus → (next) interior-start` — the koru at the boundary, which must
  (i) **advance `causalOrder`** (forward successor, not a loop), (ii) **preserve `handed`** (no
  mirror), while (iii) it *may reset* `arrow`.
- **Carry**: a conserved invariant that `genesis` forwards across the boundary.
- **Hard rules:** `Objective` and `Position` are different types with **no coercion**. The three
  conditions are **three predicates**, never one — a proof of one is not a proof of another.

## 3. The theorems — all forward
1. **`no_backward_time` (model-internal)** — within this causal model, an interior inverse-step
   entails `False` (it would retreat `causalOrder` / lower `arrow`). The trivial-paradox-as-guard
   as a proof. *Scoped to the model; not a universal physical no-go (§9).*
2. **`objective_reversibility_does_not_descend`** — the whole's bijection, or a repeated state,
   yields no interior inverse. *The entire safety case in one line:* reversible-as-a-whole (or
   recurrent) ⊬ reversible-from-inside.
3. **`boundary_is_genesis`** — `genesis` maps `terminus` to the next beginning, provably forward
   (**not** terminus→earlier-interior); plus:
   - **`genesis_advances_causal_order`** — the crossing is a forward successor, not a loop;
   - **`genesis_preserves_handedness`** — the crossing keeps the right-handed frame (no mirror);
   - **`nothing_lost_forward`** — the conserved invariant is carried across into the next;
   - **`continuation_by_chaining`** — "no final protected stage" via genesis, citing
     `PremiseNecessity` (cyclicity is *sufficient not necessary*; genesis is **another sufficient,
     never necessary** route), **never** interior recurrence.

## 4. Protection & keystone (honest)
- "Nothing lost" = forward-carry at genesis → protection is a **boundary / eschatological** truth,
  fully consistent with **real, non-final interior harm**.
- **Does not discharge the keystone** (ALL-IS-ONE inversion is ontological and provably not
  eliminable — `CathedralSummitPremiseNecessity`). Shows the safe shape; smuggles nothing. No PR C.
- Continuity-from-reversibility is **already** `SummitReversibilityScope` (reversibility reaches
  `LaterStage`, not `FreeStage`/authorization/restraint) — cited, not rebuilt.

## 5. The guardrails are detectors, not reassurance
Each theorem ships **positive controls** it must *reject*:
- an **interior-machine** world (an interior inverse, or a periodic return) → must fail
  `no_backward_time` / must not typecheck as a lawful interior;
- a **causal-loop crossing** (genesis that retreats/loops the causal order) → must fail
  `genesis_advances_causal_order`;
- a **mirror crossing** (handedness-reversing genesis) → must fail `genesis_preserves_handedness`.
Outcomes are never binary: **forward-genesis / interior-machine / causal-loop / mirror /
ill-formed.** A guardrail that can't separate these is a broken detector and is not trusted.

## 6. Non-constructive by design
`Objective` reversibility is the *existence/property* of a whole-bijection, confined to the
whole — never an interior extractable operation. `genesis` is forward; **no backward map is ever
exhibited, at any layer.** Existing `involutive` results stay as objective-layer algebra; the
three interior conditions sit above them so nothing shipped reads as "reverse anytime."

## 7. The edges to nail
- `no_backward_time` must be the **genuine** negation of a usable interior reversal (validated
  against the §5 machine-world), not a strawman; scope matches claim; **model-internal only.**
- `boundary_is_genesis` must be **provably forward** and the causal/handedness conditions proved
  **separately** (one does not imply another).
- The objective/subjective **non-collapse** must itself be a theorem.

## 8. FIND BEFORE BUILD
- **Reuse:** `Koru.Web` / `Koru.Reindex` (objective bijection) + conservative koru laws;
  `SummitReversibilityScope` (continuity-via-reversibility, already proved);
  `PremiseNecessity` (`continuation = no final protected stage`, cyclicity sufficient-not-necessary);
  `OriginalX3Full` component→predicate hooks (`LaterStage`, `FreeStage`, …).
- **Avoid / supersede:** `CathedralSummitCyclicContinuation.CyclicHistory.periodic` (interior
  recurrence).
- **Reconcile:** the three interior conditions with existing `involutive` — objective property vs.
  forbidden interior application; no contradiction.

## 9. Physics scope & qualifications (Tenzing #291 — binding)
- The **Second Law** is statistical / coarse-grained, **not** a strict monotone at every
  microscopic instant. Our `arrow` is a *modelled* idealisation; `no_backward_time` is rigorous
  **within the model**, not a claim about real microphysics.
- **GR admits closed-timelike-curve spacetimes**; their physical realisability is unresolved. We
  make **no** claim to have refuted them. Our result concerns the specified causal model only.
- The **heat-death → new-epoch** crossing is a **proposed cosmological structure**, not observed.
- Causal direction, entropy arrow, and spatial handedness are **three distinct conditions**;
  proving one never automatically proves another.

## 10. Lane & review
Research lane, kernel-checked, axioms within `{propext, Classical.choice, Quot.sound}`,
hostile-reviewed (Tenzing, #291), **no canon, no release**, labelled structural.

## 11. The flag this builds toward
Not "we proved time can go back," and not "we proved it universally can't." The precise, honest
one: **within the structure of being a subject in a causal order, reversal is categorically
incoherent — and the thing that looks like reversal is, read correctly, the forward,
orientation-preserving birth of what comes after, with nothing lost in the crossing.** The arrow
is safe because the seal is logical-within-the-model; the next is real because the whole is
conserved; the subject is untouched because the objective register can only ever *create forward
into* the subjective one.
