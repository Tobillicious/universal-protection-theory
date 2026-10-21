# Timing evidence: preserved observations and an auditable collector

Paper 11 v0.17.12 and rungs 4/5 are retained with their declared physical, cryptographic and timing premises. Component observations concern an implementation; they do not add another rung or certify those premises by themselves.

## What is actually saved

`outputs/local.1.json` is the original preliminary run, byte-for-byte. Its hash and collector are recorded in `PROVENANCE.json`. The original narrative described corrected full-sync and longer-clock-interval runs, but their raw records were not included. This candidate does not label those unrecorded results PASS.

| Saved component | Raw record | Interpretation |
|---|---|---|
| Connections | Seven attempts per hostname; some median times are 16-18 ms | The old collector did not save peer IPs. Hostname geography and long-haul coverage cannot be inferred, including for CDN-backed hosts. |
| Durable write | Ordinary `os.fsync`; 1,000 appends; empirical median 0.063 ms, p99 0.327 ms, maximum 5.494 ms | Timings of the requested primitive, not the corrected F_FULLFSYNC run or a power-failure durability certificate. |
| Clock | `+0.073541 +/- 0.034641` and `+0.074974 +/- 0.034325`; the old script waits five seconds | Per-read monotonic timestamps were not saved. The reported 180.3-second/376-ppm correction cannot be reconstructed from this record. |
| Optional planner | Exit 1; elapsed 0.032 s | Execution failed. The two truncated optional simulators are preserved as provenance text, not active executable or timing evidence. The 140 exact rung checks do not depend on them. |

## New local full-sync record

`outputs/durable-fullsync-2026-10-21.json` records a new 1,000-append run on this Mac, using the corrected collector and F_FULLFSYNC. Every raw duration is saved. The empirical median is **5.123479 ms**, the empirical p99 **8.192375 ms**, and the maximum **13.067833 ms**. The collector hash is pinned in PROVENANCE.json. This replaces the need to rely on an unbanked durable-write number; it does not certify a power-failure model or a complete plant deadline.

## Deployment verdicts

No saved run certifies P-LAT, P-LOCK, P-START or a continuously valid clock-rate bound. A TCP connection plus a local flush is not a measured 4-of-7 lockstep round. Seven connection samples do not establish the rare tail required by the declared floor. State-transfer costs, all site pairs and attestation/planning remain distinct parts of the existing application contract.

This corrects the evidence labels; it does not refute a declared premise or undo a mathematical rung.

## Collector for subsequent measurements

`measure_local.py` is optional and never run by `reproduce.py`. With no arguments it prints help and makes no request. Explicit options collect durable requests, a clock pair or named endpoint connections. Save stdout outside the sealed package.

The collector records all raw durations in integer nanoseconds, UTC/monotonic clock data, connection failures and peer IPs. On macOS it requests F_FULLFSYNC (51 in the installed Darwin SDK); elsewhere it labels `os.fsync`. Empirical quantiles stay empirical. A clock pair produces only a conditional interval-average estimate, not a perpetual maximum drift. Endpoint location, protocol majority latency and deployment confidence are not inferred from a hostname.

The reproduction suite checks record custody and parsing/arithmetic with deterministic fixtures. It does not rerun measurements or treat a fixture as physical evidence.
