# IR repair ledger — 27 October 2026

Candidate proofs are scoped to explicit models and assumptions. No physical installation certified.

| IR | New formal result | Still declared / not established |
|---|---|---|
| IR-1R | Bounded post-effect guard | physical effect, drift, and sampling bounds |
| IR-2 | Finite-list aggregate physical influence under a common enforced charge | implementation of atomic charging; no uncounted channels or infinite accumulation |
| IR-3 | Greatest sound one-step observation-based action relation | correct and complete physical observation and successor relation |
| IR-4 | Robust finite-horizon viability and indefinite safety of a supplied invariant policy | viable nonempty kernel and policy exist for actual instrument; limit time |
| IR-5 | Existing ControllerFence source implies invariant log-derived physical projection under exact log coverage | physical semantics of logs and absence of off-log changes |
| IR-6 | A single observation-only controller preserves a robust kernel iff suitably certified in its observation fibers (sufficient direction formalised) | existence of such uniform choices for the instrument; data about hidden states; nondeterministic disturbances |

**Negative witness IR-6:** two viable physical states map to the same observation yet demand opposite safe actions. Statewise viability does not imply observation-only viability.

Future: connect selected safety kernel to the full UPT preservation order (rather than quietly narrowing the feasible family), and prove abstraction completeness.
