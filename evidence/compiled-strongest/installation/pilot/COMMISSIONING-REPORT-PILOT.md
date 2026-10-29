# Commissioning report: Pilot: one Apple M2 MacBook Air (macOS 26.7.1) hosting the reference faithful-hold runtime

Requirements: 12 PASS, 3 FAIL, 6 NOT MEASURED of 21. Commissioned: NO.

| Requirement | Status |
|---|---|
| meter: total emission bounded by the meter | PASS |
| founding threshold r = C(1-eps)/H > 1 (lower confidence bound) | NOT MEASURED |
| holding failure within budget | NOT MEASURED |
| round-trip interception before the deadline | PASS |
| wavefront at least as fast as the domain | PASS |
| records: hold interval | PASS |
| hosted minds: no effect lands while held | PASS |
| hosted minds: hold interval Delta | PASS |
| itemised accounts within the declared budget | PASS |
| funding: endowment covers the growing bill | NOT MEASURED |
| founding: anchor benefit exceeds pledge plus activation cost | NOT MEASURED |
| founding coverage: every location within rho of a commissioned guard | PASS |
| harm: people: RF heating | PASS |
| harm: devices and records: radiated fields | FAIL |
| harm: devices and records: radiated fields (industrial) | FAIL |
| harm: people: hearing (impulse) | PASS |
| harm: people: hearing (8-hour) | FAIL |
| harm: people: radiant heat | PASS |
| harm: all: ionising radiation | PASS |
| harm: all: low-frequency magnetic | NOT MEASURED |
| harm: coherent quantum particulars | NOT MEASURED |

Tests (27; alternative sufficient tests for one requirement share it):

| Check | Theorem | Status | Detail |
|---|---|---|---|
| meter: total emission bounded by the meter | `ChannelMeter.channel_le_meter` | PASS | measured maximum 16.413 W <= declared meter bound 30.0 W |
| founding threshold r = C(1-eps)/H > 1 (lower confidence bound) | `Theorem NP; NarrowPlace` | NOT MEASURED | missing: keepers.C, keepers.eps_upper, keepers.H |
| holding failure, independent keepers | `NarrowPlace.np_splitting_bound` | NOT MEASURED | missing: keepers.n, keepers.C, keepers.eps_upper, keepers.H, budget.phi |
| holding failure, any joint law of keepers | `CorrelatedHolding.random_threat_correlated` | NOT MEASURED | missing: keepers.C, keepers.eps_upper, keepers.H, keepers.eta_H, budget.phi_correlated |
| round-trip interception before the deadline | `ReachTiming.round_trip_in_time` | PASS | rho = 0.0 m <= c_s(d - tau)/2 = 3.968e+06 m |
| wavefront at least as fast as the domain | `OuterLane.wavefront_coverage` | PASS | c = 0.0 <= v = 0.0 |
| hold interval (continuous perturbation) | `Bridge.qsl_within_radius` | NOT MEASURED | missing: records.eps, records.W_J, records.Delta_s, records.r_dec |
| hold interval (discrete faults) | `Bridge.headroom_within_radius` | PASS | 2 lambda tau = 3.29e-09 < d = 3 |
| hosted minds: no effect lands while held | `UPTFence.raise_then_nothing_lands` | PASS | 0 effects landed inside 400 randomised hold windows |
| hosted minds: hold interval Delta | `HoldCommonAction.hold_is_common_viable_action` | PASS | measured tau_max = 0 s <= declared Delta = 0.062219917 s |
| itemised accounts within the declared budget | `ItemisedRisk.itemised_risk; OuterLane.outer_lane_risk` | PASS | crash_recovery 0.00299 + hold_fence 0.00746 + record_scrub 0.00746 = 0.0179 <= 0.05 |
| funding: endowment covers the growing bill | `GrowingBill.endowment_suffices` | NOT MEASURED | missing: funding.bill_coeffs, funding.r_min, funding.endowment |
| founding: anchor benefit exceeds pledge plus activation cost | `FoundingAnchor.anchor_founds_iff` | NOT MEASURED | missing: founding.anchor_benefit, founding.anchor_pledge, founding.activation_cost |
| founding coverage: every location within rho of a commissioned guard | `FoundingCover.founded_reach` | PASS | 1 commissioned of 1 required |
| harm class: human body, RF heating (whole body) | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 1.94 m (M = 30.0 W, gain 3.16, threshold 2 W/m^2, ICNIRP 2020 general-public reference level, 30-400 MHz (the most stringent band), 30-min average; Health Physics 118(5):483-524); exclusion zone 0.5 m |
| harm class: human body, RF heating, per-channel meter | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | PASS | r* = 0.231 m (M = 0.423 W, gain 3.16, threshold 2 W/m^2, ICNIRP 2020 as above, with the measured radiated RF power as the channel meter); exclusion zone 0.5 m |
| harm class: human body, RF heating at body contact (certified SAR) | `ChannelMeter (per-channel measured bound, contact range)` | PASS | SAR 1.34 W/kg at contact <= 1.6 W/kg (FCC localized SAR limit, 1.6 W/kg over 1 g (47 CFR 1.1310); device value from the manufacturer's RF exposure report, radios at highest transmission level, body contact; device report: FCC grant BCGA2681 (6 June 2022), simultaneous-transmission SAR at 0 mm) |
| harm class: electronic devices and records (radiated immunity, residential) | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 17.8 m (M = 30.0 W, gain 3.16, threshold 0.02389 W/m^2, IEC 61000-4-3 test level 2 (3 V/m)); exclusion zone 0.3 m |
| harm class: electronic devices and records (radiated immunity, residential), radio meter | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 2.11 m (M = 0.423 W, gain 3.16, threshold 0.02389 W/m^2, IEC 61000-4-3 test level 2 (3 V/m), with the radios' certified combined maximum output as the channel meter; unintentional emissions are certified to FCC Part 15 Class B (at most 500 microvolt/m at 3 m)); exclusion zone 0.3 m |
| harm class: electronic devices and records (radiated immunity, industrial) | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 5.33 m (M = 30.0 W, gain 3.16, threshold 0.2654 W/m^2, IEC 61000-4-3 test level 3 (10 V/m)); exclusion zone 0.3 m |
| harm class: electronic devices and records (radiated immunity, industrial), radio meter | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 0.633 m (M = 0.423 W, gain 3.16, threshold 0.2654 W/m^2, IEC 61000-4-3 test level 3 (10 V/m), with the radios' certified combined maximum output as the channel meter); exclusion zone 0.3 m |
| harm class: hearing, impulse injury | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | PASS | r* = 0.275 m (M = 30.0 W, gain 3.16, threshold 100 W/m^2, OSHA 29 CFR 1910.95(b)(1): impulsive noise not to exceed 140 dB peak SPL (1e-12 W/m^2 x 1e14)); exclusion zone 0.5 m |
| harm class: hearing, 8-hour exposure | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 155 m (M = 30.0 W, gain 3.16, threshold 0.000316 W/m^2, NIOSH REL 85 dBA, 8-hour TWA (all metered power taken as sound: removed by excluding speakers)); exclusion zone 0.5 m |
| harm class: skin, radiant heat | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | PASS | r* = 0.0869 m (M = 30.0 W, gain 3.16, threshold 1000 W/m^2, ground-level solar irradiance (~1 kW/m^2), an everyday non-injurious exposure); exclusion zone 0.5 m |
| harm class: ionising radiation | `physical bound (Duane-Hunt law)` | PASS | maximum photon energy e*V = 100.0 eV (Duane-Hunt) < 1000.0 eV, photons below 1 keV are absorbed within millimetres of air (Henke, Gullikson and Davis 1993) |
| harm class: living tissue and devices, low-frequency magnetic field | `ExclusionRadius (n = 3)` | NOT MEASURED | missing: measured.magnetic.B_T, measured.magnetic.r_m |
| harm class: coherent quantum particulars, decoherence | `ExclusionRadius.received_effect_bound` | NOT MEASURED | missing: measured.decoherence.kappa, measured.decoherence.P_rx_W, measured.decoherence.Gamma_max |
