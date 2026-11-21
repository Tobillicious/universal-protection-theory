# G1 exact assumption-discharge ledger — 2026-11-14

This is the G1 theorem-interface audit, **not** another Everest ascent and not a new physical theorem. Historical G1 proof remains intact. This ledger distinguishes a discharged premise from an independently measured property of an actual installation.

## Already discharged by the original Lean proofs

1. `G1Held.held_source_protection`: the **five internal `hcert` fields** for the canonical held source are constructed in the proof, using reflexive refinement/observation identities, initialization and the decoder/drift lemmas.
2. `G1Held.held_source_qsl`: `hdrift` follows from `SpeedLimit.qsl_growth` **given `htraj`, `hħ`, `hΔ`**.
3. `G1E9.held_source_e9`: the coupling bound follows by the subthreshold-or-alarm case split **given `hf`, `hhonest`, `hsub`, `hresp`, `hevol`, `hW`**.
4. `G1Refinement.physical_protection`: protects the modeled physical-state run itself; it does **not** require a separate abstract held-machine refinement map. The actual correction and drift properties are its inputs.
5. `G1Refinement.physical_protection_qsl`: replaces `hdrift` with `physical_qsl_drift` under its stated physical trajectory and coupling hypotheses.
6. `G1Refinement.journaled_protection`: records and replays the same modeled live history.
7. `G1Refinement.physical_instance_inhabited`: explicitly witnesses correction, trajectory and initialization for an identity perturbation / zero Hamiltonians; this proves *consistency and inhabitance*, not robustness of arbitrary hardware.

## Exact premises still visible in the strongest inspected G1 physical theorem

Source: `evidence/compiled-strongest/lean/Snuffy/G1Refinement.lean`, theorem `physical_protection_qsl`.

- **Fault accounts**: `hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i`. Requires bounds for the *chosen actual* event distribution.
- **Code**: `hrec`, `hsep`, `ht`, `hdecC`, `hnear`. Constructible in formal examples, but a particular physical code/decoder needs its own validated instance.
- **Physical correction**: `hcorr : ∀ s x, read (correct s) x = dec (read s x)`. Exact equality on every modeled state/particular is not entailed by defining `correct` in a separate mathematical toy.
- **Actual dynamics**: `htraj` requires self-adjoint Hamiltonians, the bound `‖V s‖ ≤ W`, stationary record under `H₀`, Schrödinger solution and matching physical readouts for **every good-event state, command, event and particular**.
- **Timing/threshold**: `hħ : 0 < ħ`, `hΔ : 0 ≤ Δ`, `hbudget : ε + W / ħ * Δ ≤ t`, with `2*t < dmin`. Algebraically checkable once physically valid quantities are supplied.
- **Initialization**: `hinit : ∀ ω x, read (s₀ ω) x = rec x`. Requires actual device initialization correspondence.
- **Scope**: `Part`, `read`, `S`, `perturb` are supplied; a theorem quantifying over every modeled `Part` does not itself prove that `Part` captures every real owed particular or all physical effect channels.

## Exact alternative G1 E9 interface

Source: `Snuffy/G1E9.lean`, theorem `held_source_e9`. The theorem *derives* the perturbing coupling bound, but assumes `hf` (faulty-sensor cardinality), `hhonest` (honest threshold reading), `hsub` (subthreshold coupling), `hresp` (alarmed response actually eliminates perturbing coupling), and `hevol` (realized quantum dynamics). No appeal to the E9 theorem alone discharges these independent assumptions.

## Noncircular completion test

For a named real installation, provide an independently measured or implemented witness for each outstanding premise **of that same installation**. Then instantiate `physical_protection_qsl` or `held_source_e9` with the actual witnesses, compile, inspect axioms and record the measured domain and horizon. A source-defined predicate, an empty fault account, a zero-Hamiltonian identity instance, or a separately proved existential safe policy is **not** an acceptable substitute for actual universal coverage/enforcement.

**Status:** original G1 formal Q.E.D. retained. No claim that real-world G1 assumptions are universally discharged. This file changes no original theorem or definition.
