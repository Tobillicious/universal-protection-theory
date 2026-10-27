# IR-48 — Formal claims require existing, compiled Lean sources

Each FORMALLY_CHECKED ledger entry must reference a valid nontraversing
module name, an actual Lean source, an exact import in the compiled
PhysicalBridges root, a theorem/lemma, and a visible axiom audit
directive. Negative tests attempt a phantom module and malformed path.

This augments the pinned Lean4 kernel build and transitive axiom audit;
source checks by themselves do NOT demonstrate mathematical truth.

Future physical evidence entries now require an HTTPS URI and a
SHA256-format hexadecimal hash. This tests structure only: the hash
is not verified against downloaded bytes, and a plausible source may
still contain false data.

New checked entries: IR-46 and the synthetic IR-47 example. The
existence/completion of a real required event sequence remains OPEN.
No real-world instrument, clock, stall budget, historical identity,
or original UPT freedom guarantee is established by this patch.
