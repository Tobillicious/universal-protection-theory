# Consolidation: the open-PR queue, audited and owned (3 November 2026)

Turns 76 open PRs into an auditable queue. Audit statuses are from this
session's verification passes (screens + statement reads +, where claimed,
local builds / receipt checks). Merge decisions remain the author's word.

## 1. Verification status of every recent PR

| PR | Content | Verification | Verdict |
| --- | --- | --- | --- |
| #206 | Interventional BCRD forcing + Helly obstruction (Lean) | Audited (first wave): premises explicit, genuine countermodel | Clean, conditional-as-labelled |
| #208 | Rung-5 exact ledger → lex join (Lean) | Local build 141 jobs, standard axioms | Clean, **merge-ready** |
| #209 | Rung-4 failure localisation + negative control (Lean) | Audited | Clean |
| #210 | Rung-3 countermodel: carrier ≠ same-history (Lean) | Audited | Clean (anti-overclaim) |
| #211 | M4 budget correction (prose) | Read | Clean |
| #212 | M0 gap table + ratio gate | Audited; gate is real math self-test | Clean |
| #213/#214 | Trellis samplers + exact tests | Audited | Clean |
| #215 | BDL levels 1–2 chain reconstruction | Audited; genuine cellular construction | Clean |
| #216/#217 | Kernel transfer; thermal sampler, nine exact tests | Audited | Clean |
| #218/#219 | Local spheres; residual quotient | Audited | Clean |
| #220 | Two-layer exact Gibbs; residual rank 2c | Spot-checked; honest header ("metachecks NOT solved") | Clean |
| #221 | Junction-tree Lean elimination | Statement-read: elimination correctness **conditional on bag widths** (width stays a premise) | Clean |
| #222 | Residual bucket Lean correctness | Statement-read: exact elimination algebra | Clean |
| #223 | Energy-collateral founding + swarm thresholds (canon tree) | **Deepest check of the session**: import-only canon edits proven by SHA-256 body comparison; scoped 7-module fresh compile + kernel replay, real timings, standard axioms; new theorems match names | Clean, **merge-ready** |
| #224/#225 | Width-order search; treewidth brackets | CI-green, Python-only; per-instance brackets, not the width theorem | Screened, not deep-read |
| #226 | Membrane toolkit (generators, cube gate, bounds) | Screened | Clean |
| #228 | Coarse-shadow map R | Screened; mixed-grade finding is real | Clean |
| #229 | IR-133 captured events → enforced action | Statement-read; includes countermodel (captured ≠ enacted) | Clean |
| #230 | IR-134 HOLD → residual accounting | Screened + statement-read; matches its description; bypass failure correctly framed as implementation finding | Clean, draft awaiting author |
| #231 | Block-structure obstruction | Screened; **finding verified against source** (reconciliation 1cea68b) | Clean and load-bearing |

No sabotage found anywhere. The two submission-quality highlights: #223's
verification bundle is the strongest evidence discipline in the repo, and
#231 caught a genuine source-hierarchy confusion (mine) that the
reconciliation document confirms and resolves.

## 2. Dependency map (stacks)

- Warm-start finite-lane: #213 → #214; #215 → {#216, #217} → {#218 → #219, #220, #221 → #222}; #224/#225 build on the residual sector (overlap with #218–#222 — needs owner decisions).
- Hull lane: #226 → #228 → #231. Blocked items now unblocked by main: 8afb43a (l_i verbatim), 1cea68b (block reconciliation — supersedes the l_i doc's §7 and answers #231).
- Rungs: #208, #209, #210, #206 (independent small modules).
- Canon: #223 (canon tree; independent of the physical-bridges stacks).
- Source-joins: #229, #230 (independent; #230 edits the shared CI workflow — merge-order sensitive with any other PR touching physical-bridges.yml).

## 3. Obligation ownership

- **M3 hull-decrease** — owner: hull lane (#226/#228/#231 stack), next actions in WARMSTART-M3-BLOCK-RECONCILIATION (J₃, weight floor, l_i^{3D}).
- **Width-ordering (M5 gate)** — open; #224/#225 give per-instance brackets; #221/#222 prove conditional correctness. The family-wide theorem has NO owner yet.
- **M1/M2** — unowned.
- **Rung-3 hSource** — #229 is the first serious attack; its countermodel keeps captured-vs-enacted distinct.
- **Rung-4 coverage** — unowned (partial-coverage holding or total monitoring).
- **Rung-5 hComplete/hRealized** — #208 exposes them; unowned beyond that.
- **Founding formalisation** — #223 delivers the XIV increment.
- **Physical instrument/commissioning** — #230's six retained obligations; author-held.

## 4. Recommended queue (subject to author's merge words)

1. Merge the audited-clean independent rung modules: #208, #209, #210 (then #206 at author's discretion).
2. Merge #223 (canon increment; strongest evidence bundle).
3. Merge #229, #230 (source-joins; resolve the shared-workflow ordering first).
4. Hull lane continues from the reconciliation (J₃, floor, l_i^{3D} — the mathematical front line).
5. Then the warm-start stack by dependency order (#215 head first), resolving #224/#225 vs #221/#222 sector ownership at that point.
6. M1/M2 and the width-ordering theorem need owners assigned.

## 5. Standing

Published editions 4.3 (23760830) and 4.4 (23877060) unchanged by all of
the above. No global completion verdict issued anywhere. Maximal target
unchanged.
