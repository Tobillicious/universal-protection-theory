# Physical illustrations and what their arithmetic establishes

21 October 2026. Corrected status in the separate Codex successor candidate. `check_physical.py` checks12 arithmetic statements for the inherited inputs below. These checks do not certify a plant or a joint failure/timing law. Delta is the declared length of one model date. The empirical reference pointers and numerical examples are inherited historical illustrations; this audit has not independently revalidated those citations.

| # | Inherited illustrative input | Value used | Historical reference pointer |
|---|---|---|---|
| 1 | Landauer cost of erasing one bit at 300 K | k_B·T·ln 2 = 2.8709–2.8710 × 10⁻²¹ J | k_B = 1.380649×10⁻²³ J/K is exact in the 2019 SI |
| 2 | Light in silica fibre (n ≈ 1.468) | 4.897 µs per km, one way | c is exact in SI; standard single-mode index ≈ 1.4682 (fibre latency references; arXiv:1811.10737) |
| 3 | Longest on-Earth fibre round trip (antipodal, about 2 × 20,038 km) | ≈ 0.196 s | from 2 |
| 4 | Intra-datacentre round trips | tens of µs (a 64 µs empty-frame RTT on Gigabit Ethernet; NIC timing at µs accuracy) | TIMELY (Google, SIGCOMM 2015); arXiv:1509.01746 |
| 5 | Drive annualized failure rate, a 2025 fleet of 344,196 drives | 1.36% | Backblaze Drive Stats for 2025 |
| 6 | Field disk replacement rates, more than 100,000 disks | typically above 1%, commonly 2–4%, up to 13% on some systems | Schroeder & Gibson, FAST 2007 |
| 8 | Energy per operation in the illustrative accelerator input (H100 SXM: 700 W maximum, about 989.5 TFLOPS dense FP16) | about 7.07×10⁻¹³ J per operation, about 2.5×10⁸ times the Landauer cost of one bit erasure | NVIDIA H100 datasheet; Flopper.io dense-FP16 listing |
| 7 | Cryptographic erase | sanitizing the key that protects encrypted data makes the data infeasible to recover; a recognized sanitization method | NIST SP 800-88 Rev. 1; NIST glossary "Cryptographic Erase" |

## What actually follows

- The fibre calculation is a propagation illustration for the chosen refractive index and path length. An approximately 0.196-second round trip for that path is not an upper bound on all on-Earth routed paths, queuing, processing, cryptography or majority-round completion. Delta>=201 seconds covers that illustration's propagation budget; it does not certify P-LAT or P-LOCK.
- P-LAT is an enforced complete-or-exclude timeout with every slow/misclassified attempt charged to the specified loss law. The service and loss contracts must compose. P-LOCK concerns an actual complete majority round within the resident's deadline, or its explicitly charged probabilistic allowance.
- The annual-rate conversion is conditional arithmetic for its assumed survival/rate model. Even if the quoted marginal drive rates are accurate, they neither cover all causes of whole-site loss nor establish the subset law for every specified group. A common event can preserve each marginal while violating the product bound. The source's p=.002 design point and its larger sensitivity boundaries must also be distinguished.
- Consequently the 201-second to 16-hour interval is a compatibility illustration for those limited inputs, not a certified deployment window. It does not establish that P-LAT, P-LOCK and P-FAULT jointly hold.
- Cryptographic erase names a method. Actual key copies, capture, rollback and retired generations still require the declared erasure warranty and its 1e-8 shared allowance. A cited method does not measure that warranty.
- The computation-energy ratio compares the inherited operation example with a single-bit Landauer floor. It does not prove that the full plant, its capacities or its prices can be realised at that ratio. Commissioning and endowment remain supplied boundary conditions.

## Current evidence

The saved full-sync run is a local component observation with raw records and a pinned collector. The corrected measurement verdict in `../../measurements/MEASUREMENTS.md` certifies no full P-LAT/P-LOCK/P-START or rare-tail premise. Historical marginal rates and path arithmetic remain useful checks of a proposed implementation's inputs; they do not discharge the declared joint contracts.

RUNG5-AUDIT.md and RUNG5-DEPENDENCIES.md give the current proof and premise classification. All12 existing arithmetic checks remain; their output is not described as physical certification.
