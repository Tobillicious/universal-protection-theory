# First-harm finite-event audit — where a finite first violation is forbidden, and where it is not

**Date:** 2026-11-03. **Lane:** GLM (Z.ai GLM session). **Disposition:** the secondary task from the GPT-lane review of draft PR #247 — hostile-test the first-harm argument. Model-level logical audit only; no physical BCRD experiment; no Lean change; no canon edit; no completion verdict. The maximal UPT target, the original X3 and the original budgets remain unchanged.

## The question, stated adversarially

An asymptotic physical-cost argument does **not** by itself rule out a harmful first event at finite time. `W_min(t) ≥ (p′/(v·d_G))([w(t−t_c)]^{d_G} − r₀^{d_G}) → ∞` (X3-DERIVATIONS §9; BRIDGE-DERIVATIONS §8) charges the bill for **concealment across unattended age t** and for **sustained** hostile operation. A single finite first strike that does not need to recover or conceal old history pays none of that bill before acting. So the asymptotic branch is **not** the answer to the finite-first-event question, and any record that cites it as such is wrong. This audit locates the answer that the corpus actually carries, states its premises and failure budget, and checks the branch structure exhaustively.

## The precise chain that carries the finite-time exclusion

The exclusion lives in the **assembled E9 trichotomy** (REPAIRS-AND-GREATESTNESS §2, "Theorem (E9, assembled)"), under declared premises, on the certified good event. Branch by branch, each with its own finite event horizon:

- **Branch A — sub-threshold per-site injection.** Divergence accumulates at a bounded rate and is absorbed and refreshed by the funded tracking controller: refresh-from-record resets the error each epoch to a uniform envelope λ_env = γ_leak·τ + ε_fault (REPAIRS §1, corrected lemma, regime 2), and the dissipative controller compresses the floor to (γ_leak + ε_fault/Δt)/(Γ_corr + κ_ctrl) (CLOSURE §2, with γ_leak restored and the controller's drain charged to solvency). **Horizon: within the epoch** — the excursion never crosses the irreversible threshold while funded (E9 timing premise).
- **Branch B — weight ≤ d−1 non-stabilizer component.** A nonzero syndrome fires within the detection latency (Theorem 4.2's basis-independence + centralizer argument; zero syndrome exists only at logical weight ≥ d), and the accepted latency budget (a/c + τ_sensor + consensus rounds + τ_fb + τ_reset < lightcone margin) **contains the effect before r_critical**. **Horizon: the latency budget.** Detection after completion does not count: prevention requires the latency premise, and the audit checker models this strictly.
- **Branch C — coherent logical injection, weight ≥ d, within one epoch.** Requires ≥ d simultaneous local deliveries, each above the per-site power threshold ε_sens, inside the lightcone window — power-detected (the per-site relocation of Gemini's Case-B argument). **Horizon: the lightcone window of one epoch.** Weight-≥d corruption is *not* compensable within the epoch, so prevention (not compensation) is required, and ε_sens is what supplies it. Slow logical drift reduces to branch A.

**Quantified failure event.** Every funding shortfall and every charged-account firing joins the 21 charged fault accounts with their conditional kernels. The ratified canon sentence (CLOSURE §1) is: **uncompensated breach is deterministically impossible on the certified good event G = {state machine executes ∧ income ≥ minimal drain ∧ no charged account fires}; G fails with probability at most Σδ ≤ 10⁻⁶ per declared horizon.** The honest form is therefore conditional impossibility with a stated budget — never unconditional impossibility.

## Why the #242 countermodel cannot instantiate these premises

PR #242's exact finite truth-table model (variables G, E, H, A, S; premises G≠E, H⇒E, E⇒A, S⇒¬S, ¬S, E⇒¬S) carries **no sensing structure at all**: no code coverage with distance d, no syndrome channel, no ε_sens threshold, no latency budget, no income premise, no refresh. First harm there is undetected *by construction*, because the model omits the detector premises — it models the guardian–ender propositional subsystem, not the certified instrument. The countermodel therefore stands **in its own scope** (a subsystem audit) and cannot be imported as a counterexample to the trichotomy. `check_first_harm_trichotomy_instantiation.py` reproduces the #242 model space verbatim (4 premise-satisfying valuations; the witness (G,E,H,A,S) = (F,T,T,T,F) with first harm) and shows all three E9 routes open in that space.

## The exactly-as-strong-as-witnesses property (checked, not asserted)

The checker enumerates the whole extended model space (4 base × 32 instrument valuations) and verifies three properties:

1. **P1** — with no instrument premises, an undetected finite first harm exists (the #242 class stands).
2. **P2** — under the full instrument premise set {c, l, p, i, r} on the good event, **no route** to a finite first uncompensated violation remains open.
3. **P3** — **each** instrument premise is load-bearing: dropping any single one reopens a route (c, l → branch B; p → branch C; i, r → branch A). There is no redundant premise; the exclusion is exactly as strong as the instrument witness set.

## The smallest undischarged premise set (stated positively)

{stabilizer coverage of the physical error channels with distance d; QND syndrome sampling within the accepted latency budget; per-site power threshold ε_sens with the quantum-speed-limit rate bound; the amended solvency condition (income ≥ demand); refresh-from-record tracking}. At the physical level these are precisely the #227 ledger rows and #229 receipt fields — the same witness class the primary task (draft PR #249) is assembling. **The two tasks are one programme: the finite-first-harm exclusion is exactly as strong as the instrument witnesses.**

## Circularity guard

Each branch premise must be an **independently warranted instrument fact**, not a definition of admissibility. ε_sens and the latency budget must be *measured* on the installed instrument (calibration, drift, exposure — the standing physical-parameter task); the code's distance d must be verified against the *actual* error channels; income must be a measured flux (ledger row `true_effect_calibration`, `physical_installed_commissioning`). A trichotomy whose thresholds are stipulated rather than measured would be circular in exactly the way the review warns; this audit's scope statement excludes that reading.

## Nonclaims

This is a model-level logical audit of a branch structure recorded in the banks; it is not physical evidence, not a fresh Lean result, and not a global completion verdict. The asymptotic X3 branch is explicitly *not* claimed to exclude finite first harm (§ above). The Σδ budget conditions the exclusion on G. Nothing merged; no canon, manuscript, funding or publication change.
