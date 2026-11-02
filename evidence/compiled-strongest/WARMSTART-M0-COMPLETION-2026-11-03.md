# WARM START M0 — COMPLETION: full BDLT per-lemma extraction audit (3 November 2026)

Companion to `WARMSTART-M0-BDLT-EXTRACTION-2026-11-03.md` (PR #212), which
was partial because the primary source's appendix was inaccessible. The full
HTML of arXiv:2610.22548 v1 ("A thermally and perturbatively stable classical
spin model in two dimensions", Balasubramanian, Davydova, Lin, Thorngren,
15 October 2026) — including Appendices A, B and C — has now been read in
full. This completes M0's per-lemma extraction. M0 status: **CLOSED as an
audit**; the 3D transfers it identifies are the revised M1–M6 content.

## Headline findings (confirming and refining PR #212)

1. **Theorem 4 (modified gauge-averaging) and its Appendix A proof are
   dimension-generic.** The proof is a Kotecký–Preiss cluster expansion over
   gauge-linked polymers for a finite abelian group with a bounded-degree
   interaction graph; Appendix A's pinned-activity induction (the R_X
   bound) deliberately replaces the Δ-counting of Thorngren's original so
   that the decay loss per application is arbitrarily small
   (β|V|_η < min{log 2, (η−m)/4D} ⟹ |V_eff|_m ≤ 2|V|_η). **No 2D geometry
   enters Theorem 4 or Appendix A.** This is usable as-is at every level of
   a 3D hierarchy, and it is exactly the "small uniform loss" property the
   recursive scheme needs.
2. **The paper is 2D-geometric in exactly three places**, each localised:
   - **Appendix B (Lemma 9)**: the gauge-interaction graphs Q_i — degree
     bounds D, the cover size A_ℓ = 240Dℓ², and the shadow-monotonicity
     l_i(R(X)) ≤ l_{i+1}(X).
   - **Lemma 13** (the norm-decrease step): l_{i+1}(X) − l_i(R(X)) ≥ 1 for
     chains in K_i∖K_1, proved by a junction/crossing analysis bounding the
     coarse-grained hull by ≤ 3 block-spins in 2D.
   - **Appendix C (Lemmas 10–11)**: graph-distance ↔ geometric-distance
     comparisons (c₁, c₂, κ).
   Everything else — Lemmas 1–7 (code cohomology), Theorem 5's induction
   (linear/quadratic split, Lemmas 14–15), Lemma 8 (Wilson weight 2^{n−i+1}
   via rail projections), Theorem 6 (witness energy α|V|·|τ₂ₙ|), Theorem 7
   (unstable mass ≤ 2^{−2ⁿ}, sector mass ≥ 3/(4(1+e^{c′ε}))), Lemma 19
   (lifetime ~ 1/φ) — is either dimension-generic or code-structural in a
   way our reconstructed replacements (PR #215) can support.

3. **The construction is ℓ ≥ 7 odd, L=1, M=2 locality**, confirming PR
   #212's point: the existing ℓ=3 toy is not paper-scale; PR #215's
   arbitrary-L formula (ℓ = 2L+1) is the right substrate to redo the
   dependency analysis at paper scale.

## Per-lemma gap table

| Source item | Gives | 2D-specific? | 3D programme status |
| --- | --- | --- | --- |
| Thm 1 (main) | memory lifetime exp(N^α), perturbative stability | statement only | target analogue: warm start not lifetime |
| Def 1, Eq (1.4)–(1.5) | thermal Enc/Dec, lifetime | generic | usable |
| Eq (1.11)–(1.14) | gauge averaging preserves gauge-invariant sets | generic | usable verbatim |
| Thm 2 (informal) | hierarchical decay ‖U⁽ⁱ⁾‖ ≲ |V|/c^{n−i} | via Thm 5 | the induction to re-run in 3D |
| Lemma 1–3, Cor 1 (Rep) | Rep cohomology, comparison map | code-structural | done for 3D levels 1–2 (PR #215); generalise |
| Lemma 4–6, Cor 2 (Par) | Par cohomology, comparison map | code-structural | same |
| Thm 3, Lemma 7 | L=1, M=2 locality, one bit | 2D geometry | 3D embedding locality needed |
| Lemma 8 | Wilson weight ≥ 2^{n−i+1} via rail projections p^a, lift L | code-structural | needs 3D rail/lift analogue (PR #215's cut ranks are the tool) |
| §3.1–3.3, Lemma 9 (App B) | interaction graphs Q_i, D, A_ℓ=240Dℓ², shadow monotonicity | **2D geometric** | **3D transfer required** (main work item) |
| §3.4 | tensor regrouping so Thm 4 applies per level | generic | usable |
| Thm 4 + App A | gauge-averaging with uniform small loss (KP, pinned activity) | **dimension-generic** | **usable as-is** |
| Lemma 10–11 (App C) | norm comparisons κ | **2D geometric** | **3D transfer required** |
| Lemma 12 | coarse-graining norm change ≤ A_ℓ | via Lemma 9 | inherits |
| Lemma 13 | hull decreases: l_{i+1}−l_i∘R ≥ 1 | **2D junction analysis (≤3)** | **3D analogue required** (key lemma) |
| Lemma 14 | linear part decay e^{−m_i}A_ℓ | generic | usable |
| Lemma 15 | quadratic part ≤ (32D/(m_{i+1}−mᵢ))(A_ℓ β‖·‖)² | generic (Thm 4) | usable |
| Def 3, Thm 5 | constant choice; induction to ‖U⁽ⁱ⁾‖ ≤ 64|V|/c^{n−i} | generic given above | re-run after transfers |
| Cor 4 | H_eff bounds | generic | usable |
| §4.2–4.4, Lemma 16–18, Cor 5 | RG decoder, witness, |τ₂ₙ| ≥ 2ⁿ, counting Γ^m | code-structural | 3D decoder needed (PR #213/#214 trellis is the finite engine) |
| Thm 6 | witness energy perturbed ≤ α|V|η,loc·|τ₂ₙ| | generic given App C | inherits after transfers |
| Thm 7 | unstable mass ≤ 2^{−2ⁿ}; sector mass ≥ 3/(4(1+e^{c′ε})) | generic given above | gives the C ≤ 4/3 warm-start route of PR #212 finding 2 |
| Lemma 19 | lifetime ≳ 1/φ(A_b) | generic | usable |

## Consequences for the programme

- **M1–M3 revised**: the 3D work is not "redo BDLT"; it is (i) reconstruct
  the 3D coarse-shadow map R and interaction graphs Q_i (Appendix B
  analogue) from PR #215's replacements, (ii) prove the 3D Lemma 13
  (hull-decrease) — the one genuinely new 2D-free mathematical lemma — and
  (iii) re-run Theorem 5's induction, which is then dimension-generic.
- **M4 gate confirmed with more precision**: Theorem 7's sector mass
  3/(4(1+e^{c′ε})) and PR #211's O(log n) gate are consistent; the
  sampler-side target is exact conditioning on the stable event of mass
  ≥ 3/4, giving C ≤ 4/3 — matching PR #214's fixed-coin mode on finite
  instances.
- **M5 sharpened**: the paper's decoder is an RG decoder with per-level
  corrections satisfying Eq. (4.2); the finite trellis sampler's frontier
  width w is the analogue of the decoder's cut, so the w = O(log m)
  ordering question is the 3D incarnation of the paper's RG structure.
- **Scale**: all new work must use ℓ ≥ 7 odd (paper scale); ℓ = 3 remains
  a toy check only.

## Status

M0 audit: **closed**. Open mathematical work, in order: 3D Appendix-B
analogue (interaction graphs + A-constant), 3D Lemma-13 (hull decrease),
then the dimension-generic induction re-run; sampler family-wide
polynomiality is gated on the width-ordering theorem. No canonical
manuscript, commissioning, founding or X3 changes; original target
unchanged.
