# IR-41 — Steps are not seconds

IR-37 and IR-38 bound modeled service in **controller steps**.
That alone does not prove service by a real-world time.

A separate physically truthful clock must satisfy a maximum delay
between **genuinely executed** physical transitions. Lean proves
`time(n) <= time(0) + n * maxDelay` and composes that conditional
certificate with IR-38's actual-state, observation-history service
theorem. An actual served endpoint is obtained in the model by the
declared number of completed steps and given deadline.

Negative controls show that arbitrarily long elapsed delays remain
possible without a maximum-latency hypothesis, and even a frozen
timestamp function can satisfy a formal timing inequality without
actual progress.

**Open:** trusted external timestamps, guaranteed next-step execution,
real event-to-model correspondence, network/fault delay bounds,
appropriate real-world service and identity semantics. Nothing here
proves that any real-world emergency deadline can be met.
