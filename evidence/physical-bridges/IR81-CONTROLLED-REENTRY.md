# IR-81 — Controlled re-entry, authenticated boundaries and honest liveness

## Why this theorem is needed

Gemini proposed a four-gate recovery protocol to avoid IR-79's permanently absorbing no-service hold. Its idea is useful, but its purported meta-theorem presupposes an authenticated external signal, correct physical diagnostics, an actual slew-rate limiter and an ideal atomic physical latch. A source theorem combining Boolean guards cannot derive those external facts.

A permanently absorbing state has **no exit** by definition under the same full transition relation. The new model therefore defines a latched operational hold in a larger supervisory state machine with a distinct guarded exit. It does **not** claim a truly absorbing physical particular suddenly becomes recoverable.

## Constructed and formally checked source-level result

The explicit state machine has four states:

```
hold --(external auth + fresh epoch + watchdog + fence)--> diagnostic
diagnostic --(accepted typed IR77 trace + independent physicalReady
              + epoch + watchdog + fence)--> ramp
ramp --(externally warranted slewReady + epoch + watchdog + fence)--> active
active --(lost epoch, watchdog or fence)--> hold
diagnostic or ramp --(failed gate)--> hold
```

The `primaryRequest` input has NO part in a `hold → diagnostic` transition: source-level non-self-authorization is proved for any primary software request when `sidebandAuth=false`. This is *not* a proof of true electrical isolation or unforgeable authenticated channel, which still require an independent physical implementation contract.

`diagnosticGuard (checkedDiagnostics x cfg records) = true` implies the actual **IR-77 source-level** `TraceValid cfg records`, rather than merely a string like "diagnostics okay." The `physicalReady` input is deliberately independent because even truthful recorded trace values cannot establish physical settling, true voltage reference, absence of unobserved current, all bypass paths or historical identity.

Constructive source-level guard proofs show each local `Bool` conjunction holds from exact, explicitly named positive inputs and derive:

```
startGuard a = true
diagnosticGuard b = true
rampGuard c = true
--------------------------------------
run hold [a,b,c] = active
```

They do NOT prove these three inputs will ever arrive. Instead, a negative control proves that absent external authorization at EVERY input tick, the system stays in hold for all FINITE input streams. Another counterexample proves that even a model reaching active can have no actual recipient service.

The final-actuation `commandPermitted` predicate rechecks original source-level IR-80 dual-domain permit and epoch at *use time*, including in the active state. The model denies commands in hold/diagnostic/ramp and when watchdog/fence is false even while the active mode bit remains set. This is source-level logic, not source-independent physical final actuation.

## Explicit hostile audit of Gemini's proposed premises

- **Not true:** "IR-80 proves the references are good and residual energy has completely dissipated." IR-80's conditional energy ledger establishes necessary clamp energy capacity only; it does not certify a real ADC reference or absence of remnant energy, nor voltage/thermal safety.
- **Not true:** "IR-79 proves passing diagnostic trace." IR-79 concerns fault/detection/fence/drain bounds and conditional complete physical effect envelopes. Typed telemetry soundness is IR-77; actual true-physical calibration is still external.
- **Not true:** "\u03a6 is not assumed, so recovery is guaranteed." Replacing a naked assumption of a conjunction with separately assumed conjuncts is structurally preferable for traceability, but NOT an existential proof of the conjuncts.
- **Not true:** "Energy below clamp max means the inductor has fully discharged." It just means it might be absorbable by the chosen path. A remaining-energy and actual waveform proof is separate.
- **Not true:** "A voltage-reference ratio within tolerance proves an independent absolute reference." Both rails can be perturbed together; an independent/calibrated reference premise is required.
- **Not true:** "Binary Lean Bool state proves no physical metastability." Physical analog flip-flops have settling and failure distributions; the binary abstraction has not been validated by a real timing and failure envelope.
- **Not true:** "Primary gating logically forces a physically isolated recovery channel." The absence of a primary path into the supervisor is a physical circuit/security architecture premise, not a consequence of a Boolean actuator gate.
- **Not true:** "Controlled entry proves continuous service and X3." Even a safe rapid return to active does not prove delivery of a named particular's service, freedom to change or eventually successful restoration under every admitted physical fault.

## Original X3 unchanged

The programme still needs authenticated side-band/epoch source, sensor soundness, physical finality of the hold, calibrated stored-energy/transient/clock envelopes, physically justified ramp bounds, liveness/fairness/replenishment and historical protected-particular service. The original maximal universal X3 claim remains OPEN in these branches.

## Review status

Formal conditional guard transition, source-level integration with IR-77/IR-80, deliberately *non-guaranteed* recovery, and countermodels. Claim FORMALLY_CHECKED only after pinned Lean/axiom checks and assurance ledger CI pass.
