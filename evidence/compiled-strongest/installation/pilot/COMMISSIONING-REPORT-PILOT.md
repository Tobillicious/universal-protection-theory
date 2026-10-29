# Commissioning report: Pilot: one Apple M2 MacBook Air (macOS 26.7.1) hosting the reference faithful-hold runtime

7 PASS, 4 FAIL, 13 NOT MEASURED of 24 checks. Commissioned: NO.

| Check | Theorem | Status | Detail |
|---|---|---|---|
| meter: total emission bounded by the meter | `ChannelMeter.channel_le_meter` | PASS | measured maximum 16.413 W <= declared meter bound 30.0 W |
| founding threshold r = C(1-eps)/H > 1 (lower confidence bound) | `Theorem NP; NarrowPlace` | NOT MEASURED | missing: keepers.C, keepers.eps_upper, keepers.H |
| holding failure, independent keepers | `NarrowPlace.np_splitting_bound` | NOT MEASURED | missing: keepers.n, keepers.C, keepers.eps_upper, keepers.H, budget.phi |
| holding failure, any joint law of keepers | `CorrelatedHolding.random_threat_correlated` | NOT MEASURED | missing: keepers.C, keepers.eps_upper, keepers.H, keepers.eta_H, budget.phi_correlated |
| round-trip interception before the deadline | `ReachTiming.round_trip_in_time` | NOT MEASURED | missing: guards.rho_m, guards.signal_speed_m_s, guards.response_s, guards.deadline_s |
| wavefront at least as fast as the domain | `OuterLane.wavefront_coverage` | NOT MEASURED | missing: guards.v_m_s, guards.domain_speed_m_s |
| hold interval (continuous perturbation) | `Bridge.qsl_within_radius` | NOT MEASURED | missing: records.eps, records.W_J, records.Delta_s, records.r_dec |
| hold interval (discrete faults) | `Bridge.headroom_within_radius` | NOT MEASURED | missing: records.lambda_per_s, records.tau_s, records.code_distance |
| hosted minds: no effect lands while held | `UPTFence.raise_then_nothing_lands` | PASS | 0 effects landed inside 400 randomised hold windows |
| hosted minds: hold interval Delta | `HoldCommonAction.hold_is_common_viable_action` | PASS | measured tau_max = 0 s <= declared Delta = 0.062219917 s |
| itemised accounts within the declared budget | `ItemisedRisk.itemised_risk; OuterLane.outer_lane_risk` | PASS | crash_recovery 0.00299 + hold_fence 0.00746 = 0.0105 <= 0.05 |
| funding: endowment covers the growing bill | `GrowingBill.endowment_suffices` | NOT MEASURED | missing: funding.bill_coeffs, funding.r_min, funding.endowment |
| founding: anchor benefit exceeds pledge plus activation cost | `FoundingAnchor.anchor_founds_iff` | NOT MEASURED | missing: founding.anchor_benefit, founding.anchor_pledge, founding.activation_cost |
| founding coverage: every location within rho of a commissioned guard | `FoundingCover.founded_reach` | NOT MEASURED | missing: founding.guards_commissioned, founding.guards_required |
| harm class: human body, RF heating (whole body) | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 1.94 m (M = 30.0 W, gain 3.16, threshold 2 W/m^2, ICNIRP 2020 general-public reference level, 30-400 MHz (the most stringent band), 30-min average; Health Physics 118(5):483-524); exclusion zone 0.5 m |
| harm class: human body, RF heating, per-channel meter | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | NOT MEASURED | missing: measured.rf.P_rad_W |
| harm class: electronic devices and records (radiated immunity, residential) | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 17.8 m (M = 30.0 W, gain 3.16, threshold 0.02389 W/m^2, IEC 61000-4-3 test level 2 (3 V/m)); exclusion zone 0.3 m |
| harm class: electronic devices and records (radiated immunity, industrial) | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 5.33 m (M = 30.0 W, gain 3.16, threshold 0.2654 W/m^2, IEC 61000-4-3 test level 3 (10 V/m)); exclusion zone 0.3 m |
| harm class: hearing, impulse injury | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | PASS | r* = 0.275 m (M = 30.0 W, gain 3.16, threshold 100 W/m^2, OSHA 29 CFR 1910.95(b)(1): impulsive noise not to exceed 140 dB peak SPL (1e-12 W/m^2 x 1e14)); exclusion zone 0.5 m |
| harm class: hearing, 8-hour exposure | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | FAIL | r* = 155 m (M = 30.0 W, gain 3.16, threshold 0.000316 W/m^2, NIOSH REL 85 dBA, 8-hour TWA (all metered power taken as sound: removed by excluding speakers)); exclusion zone 0.5 m |
| harm class: skin, radiant heat | `ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius` | PASS | r* = 0.0869 m (M = 30.0 W, gain 3.16, threshold 1000 W/m^2, ground-level solar irradiance (~1 kW/m^2), an everyday non-injurious exposure); exclusion zone 0.5 m |
| harm class: ionising radiation | `physical bound (Duane-Hunt law)` | PASS | maximum photon energy e*V = 100.0 eV (Duane-Hunt) < 1000.0 eV, photons below 1 keV are absorbed within millimetres of air (Henke, Gullikson and Davis 1993) |
| harm class: living tissue and devices, low-frequency magnetic field | `ExclusionRadius (n = 3)` | NOT MEASURED | missing: measured.magnetic.B_T, measured.magnetic.r_m |
| harm class: coherent quantum particulars, decoherence | `ExclusionRadius.received_effect_bound` | NOT MEASURED | missing: measured.decoherence.kappa, measured.decoherence.P_rx_W, measured.decoherence.Gamma_max |
