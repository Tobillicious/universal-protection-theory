# Selected-policy provenance and exact theorem binding

Audited against main commit `fead84391eabc1ba656bd3b035949922d2b9e572`
on 28 October 2026. This is a development audit, with the original
`UPTExist.LexBetter` order and full feasible predicate retained.

## The open draft PRs already have mathematical descendants in main

| Draft | Proof source at the draft head | Source at the audited main | Result |
| --- | --- | --- | --- |
| [#17](https://github.com/Tobillicious/universal-protection-theory/pull/17), head `9a517530ce829e04a0eb4f9e9d414d67723d0c9c` | `IRSelectedMaximality.lean`, blob `2c71e9619516f0382879e0ed03c1797f95f519a0` | Identical blob | The selected-level no-improver theorem, cofinality implication and countermodels are already retained. |
| [#20](https://github.com/Tobillicious/universal-protection-theory/pull/20), head `40eb792a4518867c34fec39177a3dd2dffe6eb66` | `IRSelectedEndToEnd.lean`, blob `ba503f8cca27037c1c01e1e48f11a89cf306ef52` | Blob `e3587d1b59723807648e2bcec7ee500c80a6cc2f` | Main retains an existential policy certificate. The draft had an explicit-policy interface, recovered below. |
| [#25](https://github.com/Tobillicious/universal-protection-theory/pull/25), head `e784aa9bbdf14b14a59a32b2a1789b0d148eeea3` | `IRProfileAudit.lean`, blob `706dac851d87dc274c8792347009ae785f5bfa37` | Identical blob | The complete faithful profile audit, infinite-outcome example and hostile controls are already retained. The accompanying note changed its integration-status sentence only. |

All three modules are imported in the audited main's `PhysicalBridges.lean`.
The relevant source history includes `3196d62`/`da8a4da` (IR-17),
`2b75385` (the replacement IR-20 interface), and `cc7a893` (IR-25).
An open PR is therefore not evidence that its mathematical result is absent.
Merging an old aggregate import file over main would risk losing later work.

## Recovering the exact policy supplied by the caller

PR #20's theorem accepted `policy : Obs → Act`, its uniform viability
certificate and its outcome-realisation certificate. Its physical trace and
record conclusions referred to that same policy. Main instead accepts an
existential `hSelectedPolicy` and returns an existential policy with the
joined conclusions.

The existence result remains useful. Its type alone does not identify the
witness with a separately constructed policy. A constructive implementation
proof needs the very policy whose original retention facts it establishes to
receive the physical safety and record guarantees. The draft's additional
`selected ∈ safeMenu` conclusion remains derivable from `hLocal.1`.

`PhysicalBridges.IRFixedPolicyEndToEnd.fixed_policy_end_to_end_certificate`
recovers the explicit-policy interface directly from the unchanged current
controller, viable-kernel, physical-guard and continuation components. It
keeps the current hypotheses, the original full feasible family, the same
selected outcome and the caller's same policy. It also returns membership.
It does not eliminate the existential theorem and silently choose another
policy. The application-time effect guard is the current corrected guard.

The initial targeted Lean 4.35 compilation passed without warnings. Its
axioms are `propext`, `Classical.choice` and `Quot.sound`. This certificate
retains its explicit physical/semantic hypotheses; it does not measure them
or certify an actual installation.

## Exact bindings for the assurance ledger

`claim-theorems.json` maps each reviewed formal claim to exact fully qualified
supporting declarations and named negative controls. It records source
locations and hashes, the elaborated theorem statements and type hashes,
direct theorem dependencies, transitive axioms, major hypotheses and the
intended conclusion's scope.

After a fresh pinned build, run:

```sh
python3 verify_claim_theorems.py --self-test
```

Set `--lake /absolute/path/to/lake` if the pinned toolchain is not on PATH.
The verifier queries Lean's imported environment and requires a theorem
constant in its expected defining module. A plausible module name, a
definition with a convenient name, or a removed declaration cannot pass.
Changed source, statement, dependencies, claim assumptions or claim scope
require explicit binding review. Every `FORMALLY_CHECKED` entry needs a
binding, including entries added after this baseline.

The verifier's interpretation limit is explicit: binding a claim to a checked
proposition does not automatically prove the natural-language interpretation,
authenticate physical data or establish subject continuity. Those remain
review and application obligations at their stated scope.
