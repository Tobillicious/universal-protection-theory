# Item 3: attestation timing (21 October 2026)

Claude (Opus 5.5). The cryptographic part is **measured** on this Mac. The hardware-quote part is **cited**: every
quotation below was read from its source page.

## Measured here (raw records in `outputs/`)

Two independent instruments agree.

| Operation | Python `cryptography` 46.0.3, per operation (median / p99 / max), n = 5,000 | OpenSSL 3.6.3 `speed` (throughput) |
|---|---|---|
| ECDSA P-256 sign | 26.92 / 33.42 / 11,402.5 µs (one scheduling outlier) | 58,963.8/s, about 17 µs |
| ECDSA P-256 verify | 60.42 / 72.00 / 199.04 µs | 19,667.7/s, about 51 µs |
| Ed25519 sign | 86.17 / 99.00 / 339.25 µs | 34,442.5/s, about 29 µs |
| Ed25519 verify | 188.92 / 234.08 / 536.96 µs | 11,954.8/s, about 84 µs |
| SHA-256 over state | median 2,507.2 MB/s (20 runs over 64 MiB), about **0.43 s per GiB** | |

Raw files: `attest-crypto-*.jsonl` (every timing) and `openssl-speed-*.txt`.

## Cited: TPM 2.0 hardware quote

These are **2017 reports on individual machines, not systematic benchmarks**.

- **Greg Wettstein**, LKML, 10 February 2017, a Skylake system with a hardware TPM 2.0: "quote: 810 milliseconds",
  "verify signature: 635 milliseconds", and "The elapsed time to load and validate a key into the chip averages
  1200 milliseconds".
  https://lkml.iu.edu/hypermail/linux/kernel/1702.1/02464.html
- **Wettstein**, the same thread, Kaby Lake: "Average time for a quote is 600 milliseconds with a signature
  verification clocking in at 100 milliseconds."
  https://lkml.iu.edu/hypermail/linux/kernel/1702.1/04615.html
- **James Bottomley**, the same thread, Skylake: "my Skylake system has these figures down around 100ms or so".

## Consequence for P-START (re-attestation plus planning ≤ 3δ/4)

The worst cited attestation path (key load, quote, verify) is about 1.2 + 0.81 + 0.64 ≈ **2.7 s**. Hashing a GiB
of state adds 0.43 s, and signature crypto adds microseconds. So re-attestation takes **seconds**.

The residual is 3δ/4: at least **6.9 minutes** at the shortest admissible date length measured today (9.2 min),
and **18 hours** at δ = 1 day. **Re-attestation fits with a large margin.**

**Planning time is not yet measured**: Paper 11's planner diagnostic is truncated. It needs a working planner
timed on a plant-sized instance.
