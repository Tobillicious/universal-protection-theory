# Hostile referee report on Parts V–XII and the new Lean modules (29 October 2026)

An independent reviewer agent (Claude, run as a separate session with no access to the
author's reasoning) read PARTS-V-VIII.md, PARTS-IX-XII.md and the nine new Lean modules
in full, with the statements of the lemmas they cite. It was instructed not to argue
for narrowing the target, and to find where prose claims more than the cited theorem
proves. The dispositions are in the master's Part XII.3. The report is recorded here in
substance.

## Findings (most severe first)

1. **Lemma I counts the signal one way (ERROR).** `interception_in_time` proves
   `dist_g/cs + τ ≤ d`. The guard's action must also travel back. The correct
   condition is `2·dist/c_s + τ ≤ d`, so `ρ ≤ c_s(d−τ)/2`.
2. **The ρ=0 claim for d ≤ τ (ERROR).** At ρ=0 the hypothesis needs τ ≤ d, so for
   d<τ the lemma does not apply. The fence needs its own response time τ_f
   (synchronous, τ_f = 0) and its own statement.
3. **"Carries fenced effect channels" does not follow from Lemma W (GAP, central).**
   `wavefront_coverage` proves proximity only. Hypothesis 2 is the old P3 coverage
   premise moved to t₀. Only its propagation is derived.
4. **Lemma H's hold-safety hypothesis is not discharged (ERROR/GAP).**
   `qsl_within_radius` gives distance within a radius under a uniform `‖V‖ ≤ W`, a
   stationary record and a start within ε. Viability needs decode and repair, and the
   bound must hold for every hidden state in the class. `two_world_resolved` is
   stipulated. Repair: instantiate hold safety from the holding cycle, and import
   IR-113's `ClassViableAction`.
5. **Lemma F fails for a non-excludable good (ERROR).** When others already fund a
   public good, contribute minus abstain is −c. Repair: set the provision point so
   every pledge is necessary (Tabarrok), or prove an excludable benefit.
   `campaign_funded` is a tautology.
6. **Lemma E bounds less than claimed (ERROR/GAP).** For a computer E_em ≈ E_in.
   `requisite_variety_prob` is a probability only under a uniform law, and it covers
   deterministic maps only. Untargeted harms and one-bit triggers need little variety.
   Repair: a mediated emission sink, and a harm-class lemma.
7. **The quantum-branch decision is asserted (ERROR).** Emissions pass no fence and
   decohere coherent particulars. In branch (b) record-decode-repair is unavailable.
   Repair: a decoherence-rate bound from emitted power and coupling, with quantum
   error-correction holding.
8. **Theorem V(c) and E(E1/E4) are almost-sure results (GAP).** They are vacuous under
   full-support noise (Θ0), and Setting V needs a compact state space. Repair: Theorem
   V(d) and Θ2 per-step bounds through Lemma R.
9. **Lemma R's containment hypothesis is assumed (GAP).** Repair: itemise every failure
   mode and map each to an account.
10. **The growing bill is not Gate C-∞ (GAP).** Repair: a growing-bill perpetuity lemma.
11. **"Universal reach. Proved" (GAP).** It is conditional on G1 and on universal
    fencing at founding.
12. **StagedMaximality scope (GAP).** `Finitary` cannot express disjunctive
    requirements. Finite character is identified with a ruling, not derived. There is
    no bridge to Proposition 1's framework. Repair: derive finite character from
    compactness, and prove the bridge.
13. **"The rival bound is free at the top" (GAP).** It needs one policy realising ⊤(w)
    in every w (∃π∀w).
14. **Lemma W geometry (GAP).** It assumes a continuum of guards; discrete guards need a
    net lemma. Light-speed particulars need v = c_s. Cosmic expansion breaks `hD`.
15. **Lemma P (GAP).** Own-keeper noise is not modelled, and countably many keepers need
    a separate argument.
16. **How NarrowPlace is used (GAP/WORDING).** H must be deterministic or independent of
    the deliveries. Correlated failures must be charged separately.
17. **ContinuationPredicate schema (GAP).** `author = self` breaks continuation under
    care. D60 is enforced only by a stipulated first-event difference.
18. **Relations (GAP).** "Changes only through relata" is a supervenience premise.
19. **Wording.** The R(m) versus H(m) mapping; IR-72 is full-state; the test count.
20. **Gate C-∞ correction (CHECKED, correct).** It should note runs occurring from any
    history.

## Overall verdict (referee's words, condensed)

The nine modules are correct. Most are short algebra or union bounds. The load-bearing
steps were hypotheses that were never discharged: hold safety, the failure containment,
universal fencing at t₀, G1 completeness and Lemma F's excludable benefit. There were
two timing errors, and almost-sure results were cited in a regime where they are vacuous.
"Repairs 1–11 … would make it a valid composition. None of them requires narrowing the
target."
