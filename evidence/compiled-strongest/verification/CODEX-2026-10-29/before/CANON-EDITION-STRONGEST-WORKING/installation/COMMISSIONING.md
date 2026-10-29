# Commissioning a Universal Protection Theory installation

29 October 2026. Every hypothesis the theorems still need is a measurement or a declared design
value. An installation:

1. fills `PARAMS-TEMPLATE.json` with what it measured;
2. runs `python3 commission.py params.json report.md`;
3. is commissioned when every check reads PASS.

NOT MEASURED never counts as a pass. The harm thresholds are in `HARM-CLASSES.json`, with their
sources. The pilot run on one Mac is in `pilot/`.

## The checks, how to measure, and what passes

| # | Hypothesis (theorem) | How to measure | Passes when |
|---|---|---|---|
| 1 | Meter bounds every channel (`ChannelMeter.channel_le_meter`) | Total power drawn by the enclosure from every source, sampled faster than the hold interval | Measured maximum ≤ declared bound M, with an alarm at M |
| 2 | Exclusion radius per harm class (`ChannelMeter.every_channel_excluded`, `ExclusionRadius`) | Meter M; maximum directive gain G; zone distances | Zone ≥ r* = √(G·M / 4πS) for each radiated class; inverse cube from a measured B for magnetic |
| 3 | Ionising radiation excluded (Duane–Hunt) | Highest internal voltage | e·V below 1 keV |
| 4 | Founding threshold (Theorem NP) | Keepers' committed capacity C, upper bound on undelivered fraction ε, threat cap plus headroom H, from B4 telemetry | r_lower = C(1−ε)/H > 1 |
| 5 | Holding failure, independent keepers (`NarrowPlace.np_splitting_bound`) | n, C, ε, H | exp(−2n(1−ε−H/C)²) ≤ φ |
| 6 | Holding failure, any joint law (`CorrelatedHolding.random_threat_correlated`) | η_H = probability the threat exceeds H | η_H + ε/(1−H/C) ≤ φ |
| 7 | Round trip before the deadline (`ReachTiming.round_trip_in_time`) | Guard spacing ρ, signal speed c_s, response τ, shortest effect deadline d | ρ ≤ c_s(d−τ)/2 |
| 8 | Wavefront keeps pace (`OuterLane.wavefront_coverage`) | Guard expansion speed v, fastest domain speed c | c ≤ v |
| 9 | Hold interval, continuous perturbation (`Bridge.qsl_within_radius`) | Per record class: ε, perturbation power W, hold interval Δ, decoding radius r_dec | ε + (W/ħ)Δ ≤ r_dec |
| 10 | Hold interval, discrete faults (`Bridge.headroom_within_radius`) | Fault rate λ, response τ, code distance d | 2λτ < d |
| 11 | Nothing lands while held (`UPTFence.raise_then_nothing_lands`) | Randomised hold campaign (`pilot/reference-runtime/campaign.py`) | Zero landings inside every hold window |
| 12 | Hold interval for hosted minds (`HoldCommonAction`) | Latest execution after a hold is raised | τ_max ≤ declared Δ |
| 13 | Accounts within budget (`ItemisedRisk.itemised_risk`) | Each account's failures k in n trials; δ is its exact 95% Clopper–Pearson upper bound | Σδᵢ ≤ declared budget |
| 14 | Funding (`GrowingBill.endowment_suffices`) | Polynomial bill b(t), minimum return r_min, endowment | e* = Σ b(t)(1+r_min)^(−t) ≤ endowment |
| 15 | Anchor founds (`FoundingAnchor.anchor_founds_iff`) | The anchor's own benefit, pledge and activation cost | Benefit > pledge + cost |
| 16 | Founding coverage (`FoundingCover.founded_reach`) | Guards commissioned against the finite cover of the initial domain | Commissioned ≥ required |

## The defect the pilot found, and the repair

The first randomised hold trials failed one time in three. The resident checked the hold at the top of
each step, then spent 5–12 ms on its fsynced journal write before executing. A hold raised inside that
gap did not stop the step. The original 27-test suite had passed only by luck of timing.

The theory already says where the check belongs: every applied effect needs its permit at the moment
it is applied (II.5, `UPTFence.raise_then_nothing_lands`). The runtime now does this:

- the monitor grants execution permits only while no hold is raised;
- the sink refuses every delivery while held, and the resident retries.

After the repair:

- the deterministic suite passes (27 tests, 28 real SIGKILLs, all three mutants caught);
- the randomised campaign's results are in `pilot/campaign-2026-10-29.json`.

## The pilot's report

`pilot/COMMISSIONING-REPORT-PILOT.md` reads, of 21 requirements, 12 PASS, 3 FAIL and 6 NOT MEASURED.
Alternative sufficient tests for one requirement are grouped, so a requirement passes when any of
them passes.

The radio figures are from the FCC grant for this Mac (FCC ID BCGA2681, 6 June 2022):

- maximum conducted output 0.246 W (5.8 GHz Wi-Fi) and 0.177 W (Bluetooth);
- SAR evaluated at 0 mm: 1.34 W/kg with all radios transmitting, against the 1.6 W/kg limit.

The three failures are real, and each states its remedy:

- **Devices within 2.11 m.** At full radio power, devices built only to residential immunity
  (3 V/m) need that distance; industrial-immunity devices need 0.63 m.
- **Eight-hour hearing.** On the meter bound alone this needs the speakers removed or their acoustic
  output measured.

This is what commissioning is for. It also shows that the theorem's requirement, a check at
application time, is necessary and not just sufficient.

## What only people can do

Some items need physical work and human decisions, which this document cannot supply:

- the anchor's decision;
- building the enclosures, meters and guards over a real domain;
- keepers' capacity and its telemetry;
- per-device magnetic and decoherence measurements;
- the funding contracts.

Each enters the checker as a number with a stated pass condition.
