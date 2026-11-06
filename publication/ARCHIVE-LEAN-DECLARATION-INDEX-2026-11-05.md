# Complete uploaded UPT archive Lean declaration index — 5 November 2026

**Evidence inventory, not a new Q.E.D. or fresh compilation.** Extracted directly from user-uploaded `lalala.zip`; source bytes were not edited. This inventory includes all `.lean` files inside the uploaded archive excluding generated cache paths, not all unpublished files or every GitHub PR variant. The parser uses anchored Lean-declaration patterns; local declarations/macros can be absent and declarations in comments can yield false positives. For exact semantics, read the source and re-run Lean.

**Files:** 676. **Text-matched declarations:** 6,960; breakdown: abbrev 50, axiom 1, class 3, constant 2, def 2159, inductive 149, instance 3, lemma 24, structure 280, theorem 4289.

Every file below includes its exact archive path and SHA-256 to make old/new source comparisons possible.

## lalala/compiled-strongest/lean/Snuffy/AdaptiveConsensus.lean

- SHA-256: `13a34509dd00bcf64fa3bad42bb1d84e45662c9ac014555b612bc26cdb608926` · lines: 78 · matched declarations: 4
- L14: theorem `weighted_error_bound`
- L30: theorem `anchored_update_error`
- L47: def `evolution`
- L56: theorem `adaptive_history_error_bound`

## lalala/compiled-strongest/lean/Snuffy/AffordableReciprocity.lean

- SHA-256: `4b416646e1fc8f74f524e0f9a680384e35e06adacd69f91bb30dcec70b921b7e` · lines: 36 · matched declarations: 1
- L28: theorem `reciprocity_dominance_affordable`

## lalala/compiled-strongest/lean/Snuffy/AgeReliability.lean

- SHA-256: `a942bf13a692b0d85a2dc7e8abde7bc944acccb9070d9eaf9953c05e01816960` · lines: 65 · matched declarations: 3
- L29: theorem `cubic_spacetime_rate`
- L36: theorem `log_distance_schedule`
- L56: theorem `log_factor_not_absorbed`

## lalala/compiled-strongest/lean/Snuffy/AnalyticBridge.lean

- SHA-256: `27a8601f3279c9b86282baefe69fb3bcbf31de9540759306a774ee075dc219c7` · lines: 147 · matched declarations: 9
- L16: theorem `integrating_factor_monotone`
- L37: theorem `linear_barrier_preserves_safety`
- L49: theorem `exponential_transient_bound`
- L67: theorem `integrated_exponential_transient`
- L84: theorem `integrated_transient_cost_bound`
- L99: theorem `continuation_hazard_threshold`
- L118: theorem `heterogeneous_quadratic_cost_identity`
- L121: theorem `heterogeneous_uniform_is_not_minimum`
- L124: theorem `eventually_better_continuation`

## lalala/compiled-strongest/lean/Snuffy/AreaBridge.lean

- SHA-256: `f69c4a382be9c0144463ccaacea960d01fb400b2ef1775e150c5edee429bcd38` · lines: 100 · matched declarations: 4
- L36: theorem `logdet_le_trace`
- L53: theorem `channel_cap`
- L73: theorem `required_traffic`
- L92: theorem `area_power`

## lalala/compiled-strongest/lean/Snuffy/BandwidthReflection.lean

- SHA-256: `bdd3a90a36128370bba77aefe7ae87852ae5873fd3262cff9361a8e6af5e1bf5` · lines: 54 · matched declarations: 4
- L12: theorem `normalized_susceptibility`
- L19: theorem `exact_bandwidth_sensitivity`
- L34: theorem `finite_positive_sensory_access_remains`
- L40: theorem `bandwidth_bias_threshold`

## lalala/compiled-strongest/lean/Snuffy/Bennett.lean

- SHA-256: `9b8b6aa47ff4fc77866694d73757f736d8beef2cbf8efa3d63e9fcb182fbe34f` · lines: 215 · matched declarations: 15
- L47: def `bennettStep`
- L51: def `bennettEquiv`
- L58: theorem `bennett_step`
- L67: theorem `bennett_compute_uncompute`
- L80: theorem `ent_equiv`
- L85: theorem `negMulLog_add_le`
- L97: theorem `negMulLog_add_lt`
- L105: theorem `negMulLog_sum_le`
- L115: def `push`
- L117: theorem `ent_eq_fiber`
- L123: theorem `ent_push_le`
- L129: theorem `ent_push_lt`
- L157: theorem `heat_reversible`
- L170: theorem `heat_irreversible`
- L197: theorem `premise5_from_bennett`

## lalala/compiled-strongest/lean/Snuffy/BennettBatch.lean

- SHA-256: `681c9ae4d7560d22e57e062cce561cdfe3aaa55ae3293790f1cffed21731755a` · lines: 69 · matched declarations: 2
- L32: theorem `batched_window`
- L56: theorem `premise5_batched`

## lalala/compiled-strongest/lean/Snuffy/BennettCounterpart.lean

- SHA-256: `26e561156ad7756056f8bf1af3a40ce61d54386244264ece501363e840431d97` · lines: 334 · matched declarations: 35
- L47: inductive `Mode`
- L54: def `heatOf`
- L60: def `Merging`
- L66: theorem `counterpart_heat_zero`
- L70: theorem `merging_heat_pos`
- L84: def `tuple`
- L91: def `feasible`
- L97: theorem `counterpart_same`
- L105: theorem `counterpart_feasible`
- L114: theorem `counterpart_more_slack`
- L129: theorem `premise5_constructed`
- L145: theorem `bennett_counterpart_computes`
- L156: def `swapEnds`
- L163: def `implementedProgram`
- L167: theorem `implemented_program_computes`
- L173: theorem `implemented_program_output`
- L177: theorem `implemented_program_workspace`
- L181: theorem `implemented_program_history`
- L188: def `implementedStep`
- L193: theorem `implemented_step_fields`
- L198: def `sourceRun`
- L202: def `implementedRun`
- L209: theorem `implemented_run_refines`
- L222: theorem `implemented_run_history`
- L236: def `quantumProgram`
- L242: theorem `implemented_quantum_norm`
- L247: theorem `implemented_quantum_roundtrip`
- L256: structure `LifecycleCharge`
- L270: def `LifecycleCharge.total`
- L276: theorem `complete_cost_difference`
- L280: theorem `complete_cost_strict_iff`
- L286: theorem `implemented_work_ceiling`
- L297: theorem `adiabatic_slack_window`
- L308: theorem `switched_program_meets_deadline`
- L317: theorem `adiabatic_feasible_iff`

## lalala/compiled-strongest/lean/Snuffy/BennettExact.lean

- SHA-256: `e88fee9687904d04ed4f04dda7110f9ff18cace95ca9b0c5780a86fc64277b00` · lines: 98 · matched declarations: 8
- L34: inductive `Admin`
- L39: def `adminCost`
- L44: def `admissible`
- L52: def `tuple`
- L58: def `feasible`
- L64: theorem `premise5_exact`
- L83: theorem `window_exact`
- L93: theorem `reversible_admin_computes`

## lalala/compiled-strongest/lean/Snuffy/BookCanonicalDominance.lean

- SHA-256: `31e331d0e0b3f5d462c4073d7241e35f3d38ddc9ca1b92ad834c15024e3f1470` · lines: 101 · matched declarations: 10
- L11: def `LexLE`
- L15: def `AllKeysEq`
- L19: theorem `le_refl`
- L24: theorem `le_trans`
- L40: theorem `le_iff_eq_or_better`
- L61: def `Upward`
- L66: theorem `all_events_iff_statewise`
- L77: theorem `full_canonical_top`
- L86: def `mass`
- L90: theorem `mass_mono`

## lalala/compiled-strongest/lean/Snuffy/BookCheckpointBudget.lean

- SHA-256: `b09f6e5c085499b72272b5521b405693b7113478039a5cef0ef243cb115e729c` · lines: 48 · matched declarations: 8
- L11: def `AnchorGood`
- L14: theorem `install_from_complete_cache`
- L21: theorem `anchor_survives_record`
- L26: theorem `loaded_anchor_is_correct`
- L31: theorem `suffix_reconstruction`
- L37: theorem `tail_bound`
- L39: theorem `gated_record_preserves_window`
- L44: theorem `supplied_cost_bound`

## lalala/compiled-strongest/lean/Snuffy/BookCoholdFixedPoint.lean

- SHA-256: `55c2d3ece8588a2f23336f25d8dc87700dd720a3ae0026767a8a6d53a5f95117` · lines: 50 · matched declarations: 8
- L8: def `Subset`
- L10: def `Monotone`
- L13: def `Extensive`
- L16: def `iterate`
- L20: theorem `iterate_contains_seed`
- L25: theorem `iterate_below_every_certificate`
- L33: theorem `stabilised_least`
- L46: theorem `least_bill`

## lalala/compiled-strongest/lean/Snuffy/BookContextualObservation.lean

- SHA-256: `74821c3e5ecddaf7fdfd64f2192cbe4484a24393a4f96cd0f44caf92c180db47` · lines: 72 · matched declarations: 13
- L8: def `after`
- L10: def `Congruent`
- L13: def `ContextSafe`
- L17: theorem `contextual_iff_congruent`
- L28: theorem `contextual_on_invariant`
- L41: theorem `identity_detector_implies_injective`
- L49: structure `Sink`
- L54: def `crash`
- L56: def `observe`
- L58: theorem `forgotten_id_breaks_continuation`
- L62: theorem `endpoint_sampling_misses_a_cycle`
- L67: def `cachedStep`
- L68: theorem `cache_can_be_hidden`

## lalala/compiled-strongest/lean/Snuffy/BookDeliveryGap.lean

- SHA-256: `79b3cd807c5073882ecdcf758d346b16ef36693f8eae8dbd585a10f8c9379744` · lines: 35 · matched declarations: 6
- L8: def `totalEffects`
- L11: theorem `no_local_choice_succeeds_in_both_worlds`
- L17: theorem `indistinguishable_local_recovery`
- L23: def `idempotentTotal`
- L26: theorem `sink_side_identity_resolves_this_gap`
- L31: theorem `distinguishing_query_resolves_this_gap`

## lalala/compiled-strongest/lean/Snuffy/BookDurableDrain.lean

- SHA-256: `d63e28047d83283c93f54867e74dfe429fa0b75cf36b826e2dc34950322b2726` · lines: 150 · matched declarations: 16
- L12: structure `Durable`
- L18: inductive `Step`
- L26: def `Rep`
- L30: theorem `represented_lengths`
- L36: theorem `step_preserves`
- L58: inductive `Run`
- L63: theorem `run_preserves`
- L73: theorem `held_step_changes_no_durable_field`
- L76: def `abstraction`
- L80: theorem `drained_refinement`
- L91: theorem `can_drain`
- L118: def `CacheGood`
- L121: theorem `cache_reset`
- L124: theorem `cache_survives_record`
- L130: theorem `cache_advance`
- L140: theorem `cache_complete`

## lalala/compiled-strongest/lean/Snuffy/BookObservedHold.lean

- SHA-256: `8ca25d231d072e86186eb36425a96708efd0ada86d3ac92c388ee8d420f65aac` · lines: 62 · matched declarations: 9
- L12: structure `Operation`
- L19: def `forbidden`
- L22: def `Safe`
- L25: theorem `not_forbidden_iff_safe`
- L32: def `SafeTrace`
- L36: theorem `clean_iff_safe_trace`
- L43: theorem `accepted_iff_safe_trace`
- L47: theorem `safe_trace_member`
- L57: theorem `accepted_preserves_each_held_operation`

## lalala/compiled-strongest/lean/Snuffy/BookTrustedCounter.lean

- SHA-256: `c3394b0bb37258bd8e75a6d63ed8cb2d258d9225814bdeb7369ee2e02200bbe8` · lines: 55 · matched declarations: 8
- L8: def `count`
- L12: def `clean`
- L16: theorem `count_zero_iff_clean`
- L27: theorem `endpoint_counter_certificate`
- L36: theorem `count_append`
- L42: theorem `prefix_counter_monotone`
- L48: theorem `wrapping_counter_misses_two`
- L52: theorem `missing_event_misses_violation`

## lalala/compiled-strongest/lean/Snuffy/BookUPTAdequacy.lean

- SHA-256: `769315dee93c148c10485e1baf7e8f7c0728659900ea723e5c444c02ea964773` · lines: 128 · matched declarations: 14
- L18: def `Sub`
- L19: def `SSub`
- L20: def `Equiv`
- L21: def `LexBetter`
- L24: def `Aligned`
- L26: def `Needless`
- L28: def `Restrainable`
- L35: theorem `lex_iff_first_difference`
- L71: theorem `lex_keeps_first_stage`
- L79: theorem `improvement_never_costs_a_life`
- L84: theorem `improvement_never_costs_existing_freedom`
- L94: theorem `losing_a_life_is_never_better`
- L102: theorem `restrainable_iff_needless`
- L118: theorem `restrainable_iff_not_aligned`

## lalala/compiled-strongest/lean/Snuffy/BookUPTAgents.lean

- SHA-256: `f011273f18414111fc1adaf3e0275722e4c148bf7f0fdc6a9dcc62a983c43172` · lines: 94 · matched declarations: 11
- L13: def `Sub`
- L14: def `SSub`
- L18: theorem `shared_order_no_conflict`
- L22: inductive `P`
- L26: def `kept`
- L33: theorem `stall_is_best_response`
- L40: theorem `stall_not_jointly_maximal`
- L47: theorem `best_responses_can_stall`
- L52: theorem `ssub_irrefl`
- L54: theorem `ssub_trans`
- L60: theorem `joint_maximal_exists`

## lalala/compiled-strongest/lean/Snuffy/BookUPTBroadcast.lean

- SHA-256: `ebd2743d8938745816afb553e64bd5a0a988dd5a8b90aecfe2a4e47514e8f991` · lines: 163 · matched declarations: 15
- L30: inductive `Receiver`
- L34: inductive `Participant`
- L39: def `loyal`
- L42: def `majority`
- L45: theorem `majority_left`
- L48: theorem `majority_outer`
- L51: theorem `majority_right`
- L57: def `entry`
- L61: def `output`
- L67: def `ChannelRules`
- L73: theorem `entry_from_loyal`
- L84: theorem `honest_dealer_validity`
- L119: theorem `faulty_dealer_vector`
- L129: theorem `agreement`
- L149: theorem `om1_broadcast`

## lalala/compiled-strongest/lean/Snuffy/BookUPTCountRefinement.lean

- SHA-256: `4efe597e801301369671904a61f0408c7117f79f4ce8ac13de72d08fecf13873` · lines: 150 · matched declarations: 14
- L21: theorem `exists_max`
- L37: theorem `exists_maximal`
- L56: theorem `count_refined_maximal`
- L77: def `Sub`
- L78: def `SSub`
- L79: def `Equiv`
- L80: def `LexBetter`
- L84: theorem `lex_irrefl`
- L91: theorem `lex_trans`
- L103: def `count`
- L105: theorem `count_mono`
- L117: theorem `canonical_count_refined`
- L131: inductive `Being`
- L135: theorem `counting_is_an_extra_principle`

## lalala/compiled-strongest/lean/Snuffy/BookUPTDominance.lean

- SHA-256: `a58a4952b4623ee95c255cb30ca8924cbaf90e8ee54b97bf441c6cf81160cc79` · lines: 20 · matched declarations: 2
- L14: def `UpClosed`
- L16: theorem `statewise_dominance`

## lalala/compiled-strongest/lean/Snuffy/BookUPTExistence.lean

- SHA-256: `5627e06ccbce3d6c2c6ae56229251b1edbd19b62d93b4da0274bc41aa8e3cbb8` · lines: 130 · matched declarations: 21
- L17: def `Sub`
- L18: def `SSub`
- L19: theorem `Sub.refl`
- L20: theorem `Sub.trans`
- L22: def `Aligned`
- L24: def `Needless`
- L26: theorem `U1`
- L31: theorem `SSub.trans_sub`
- L33: theorem `Sub.trans_ssub`
- L35: def `Equiv`
- L36: def `LexBetter`
- L39: theorem `lex_irrefl`
- L45: theorem `lex_trans`
- L59: def `LexAlignedL`
- L64: theorem `climb`
- L89: theorem `lex_aligned_exists`
- L99: theorem `aligned_exists`
- L113: theorem `no_needless_choice_exists`
- L119: def `chainKey`
- L123: theorem `infinite_family_forces_needless_loss`
- L127: theorem `infinite_family_has_no_aligned_option`

## lalala/compiled-strongest/lean/Snuffy/BookUPTHold.lean

- SHA-256: `59e19b826d6b966c9fa855c18000ff0793b5df37a25306017deb2110c81f57ca` · lines: 162 · matched declarations: 27
- L15: structure `Cfg`
- L20: inductive `Ev`
- L25: def `replay`
- L29: def `exec`
- L35: def `ideal`
- L41: def `run`
- L45: def `steps`
- L52: theorem `replay_ideal`
- L65: theorem `crash_ideal`
- L72: theorem `faithful`
- L87: theorem `faithful_from_start`
- L96: theorem `admissible_observer`
- L102: theorem `ideal_lengths`
- L111: theorem `hold_executes_nothing`
- L118: def `fN`
- L119: def `effN`
- L120: def `gN`
- L123: def `execNoReplay`
- L128: def `execRunWhileHeld`
- L133: def `execRedeliver`
- L137: def `runWith`
- L141: def `start`
- L143: theorem `mutant_no_replay_unfaithful`
- L146: theorem `mutant_run_while_held_unfaithful`
- L149: theorem `mutant_redeliver_unfaithful`
- L154: theorem `timing_observer_sees_the_hold`
- L158: theorem `faithful_instance`

## lalala/compiled-strongest/lean/Snuffy/BookUPTHoldAdequacy.lean

- SHA-256: `5ac8496532e1ec95c287597a870dd875bdce4152b409cd3bcff570732865bb37` · lines: 91 · matched declarations: 19
- L17: def `Sub`
- L18: def `SSub`
- L19: def `Equiv`
- L21: inductive `P`
- L22: inductive `St`
- L25: structure `Out`
- L30: def `Ge`
- L33: def `GeLives`
- L35: def `everyone`
- L36: def `onlyX`
- L39: def `H`
- L41: def `L`
- L45: def `Hstar`
- L50: theorem `H_best_for_lives`
- L53: theorem `L_is_lethal`
- L57: theorem `lives_only_hold_leaves_lethal_undominated`
- L67: theorem `faithful_hold_dominates`
- L81: theorem `faithful_hold_strict_when_real`
- L88: theorem `faithful_hold_ends_no_one`

## lalala/compiled-strongest/lean/Snuffy/BookUPTHoldTimed.lean

- SHA-256: `9b82c247451f4787c422171b74f5b889b42c96e05fc966f01620edd6c3fde270` · lines: 70 · matched declarations: 11
- L16: def `received`
- L22: def `StutterInvariant`
- L26: theorem `stutter_erasure`
- L37: theorem `admissible_peer`
- L42: def `counter`
- L45: theorem `autonomous_peer_sees_hold`
- L51: inductive `Ev`
- L52: def `schedule`
- L54: theorem `schedule_holds_interval`
- L61: def `frozen`
- L64: theorem `cohold_closed`

## lalala/compiled-strongest/lean/Snuffy/BookUPTImpartiality.lean

- SHA-256: `5dd421dad8c9c0c669cacbef90b6ad0286263200a9a12c27959e85e2a307f330` · lines: 159 · matched declarations: 17
- L24: theorem `sum_ge`
- L33: theorem `sum_gt`
- L45: theorem `len_mul_inv`
- L54: theorem `some_chance_at_most`
- L67: theorem `everyone_at_least_only_if_uniform`
- L80: def `chA`
- L81: def `chB`
- L82: def `chC`
- L83: def `chD`
- L86: theorem `uniform_disadvantages_D`
- L91: theorem `least_chance_at_most_two_fifths`
- L96: theorem `ruling_gives_everyone_two_fifths`
- L103: theorem `ruling_is_unique`
- L108: theorem `len_inv_pos`
- L117: theorem `weight_of_keepers`
- L133: theorem `uniform_chance`
- L139: theorem `uniform_equal_iff_equal_counts`

## lalala/compiled-strongest/lean/Snuffy/BookUPTInfiniteGuard.lean

- SHA-256: `6ddcf128813efdcec313c777ea8287b18bf4be6a489f79bbff1b7899d4043dc6` · lines: 236 · matched declarations: 26
- L17: def `Sub`
- L18: def `SSub`
- L19: theorem `Sub.refl`
- L20: theorem `Sub.trans`
- L22: def `Aligned`
- L24: def `Needless`
- L26: theorem `U1`
- L32: theorem `SSub.trans_sub`
- L34: theorem `Sub.trans_ssub`
- L38: def `Equiv`
- L42: def `LexBetter`
- L47: theorem `lex_irrefl`
- L55: theorem `lex_trans`
- L71: def `LexAlignedL`
- L76: def `NoNeedlessAtEveryStage`
- L83: theorem `lex_U1`
- L95: theorem `freedom_first_U1_legacy`
- L104: theorem `guard_first_stage`
- L117: theorem `canonical_life_first_U1`
- L126: theorem `life_guard`
- L136: def `greedy`
- L140: theorem `greedy_pos`
- L144: theorem `greedy_neg`
- L153: theorem `countable_maximal`
- L200: theorem `life_guard_countable`
- L226: theorem `countable_maximal_nonvacuous`

## lalala/compiled-strongest/lean/Snuffy/BookUPTLaw.lean

- SHA-256: `01046d68c3aa7e4b74f0151ee1f9a005311acf4fbf852c90bd71888ca5feb439` · lines: 160 · matched declarations: 31
- L17: def `Sub`
- L20: def `SSub`
- L22: theorem `Sub.refl`
- L25: def `Aligned`
- L30: def `Needless`
- L34: theorem `U1`
- L41: def `restrict`
- L45: theorem `U2_partial_fails`
- L67: theorem `U2_universal_protects`
- L72: def `LexAligned`
- L78: theorem `U3`
- L84: theorem `E3_active`
- L90: theorem `E3_guard`
- L95: def `UpClosed`
- L100: theorem `E7_dominance`
- L105: inductive `P`
- L106: inductive `St`
- L108: def `standby`
- L111: def `strike`
- L112: def `hold`
- L114: theorem `hold_dominates_standby`
- L115: theorem `hold_dominates_strike`
- L117: theorem `hold_strictly_beats_standby`
- L122: theorem `hold_strictly_beats_strike`
- L128: theorem `strike_standby_tragic`
- L141: def `oa`
- L142: def `ob`
- L143: def `swap`
- L145: theorem `swap_oa`
- L147: theorem `swap_ob`
- L150: theorem `E1_no_fixed_choice`

## lalala/compiled-strongest/lean/Snuffy/BookUPTLawGuard.lean

- SHA-256: `a2fb67a5ebe3e1af635e14c56c2be83c025b3f9dbe536df6b17aa9512d5346b2` · lines: 84 · matched declarations: 15
- L12: def `Sub`
- L13: def `SSub`
- L14: theorem `Sub.refl`
- L15: theorem `Sub.trans`
- L17: def `Aligned`
- L19: def `Needless`
- L21: theorem `U1`
- L27: theorem `SSub.trans_sub`
- L29: theorem `Sub.trans_ssub`
- L33: def `Equiv`
- L37: def `LexBetter`
- L42: theorem `lex_irrefl`
- L50: theorem `lex_trans`
- L66: def `LexAlignedL`
- L73: theorem `guard_first_stage`

## lalala/compiled-strongest/lean/Snuffy/BookUPTLawLex.lean

- SHA-256: `31fb041fc1949dd2aeaa15795ec43fcb59a3a9a9458e4227315ff58eb2491cd9` · lines: 103 · matched declarations: 18
- L12: def `Sub`
- L13: def `SSub`
- L14: theorem `Sub.refl`
- L15: theorem `Sub.trans`
- L17: def `Aligned`
- L19: def `Needless`
- L21: theorem `U1`
- L27: theorem `SSub.trans_sub`
- L29: theorem `Sub.trans_ssub`
- L33: def `Equiv`
- L37: def `LexBetter`
- L42: theorem `lex_irrefl`
- L50: theorem `lex_trans`
- L66: def `LexAlignedL`
- L71: def `NoNeedlessAtEveryStage`
- L78: theorem `lex_U1`
- L90: theorem `freedom_first_U1_legacy`
- L98: theorem `guard_maximal_above`

## lalala/compiled-strongest/lean/Snuffy/BookUPTLawRepair.lean

- SHA-256: `34a174bc6ebc05c4ae868d7fdd55b2d6b6e72481d7762b346579b07738b801ce` · lines: 129 · matched declarations: 15
- L13: def `Sub`
- L14: def `SSub`
- L15: theorem `Sub.refl`
- L16: def `Aligned`
- L18: def `Needless`
- L20: theorem `U1`
- L25: def `restrict`
- L29: def `Guarantees`
- L33: theorem `aligned_congr`
- L45: theorem `U2_star`
- L85: theorem `U2_star_hypothesis_needed`
- L97: theorem `progressive_retention`
- L106: theorem `switch_without_retention`
- L123: def `UpClosed`
- L124: theorem `E7_top`

## lalala/compiled-strongest/lean/Snuffy/BookUPTLifeGuardExists.lean

- SHA-256: `aa97b696ac34e3e1ff794924b43a3b49a8c6e93ba7406dd129ea4a8c91c2f246` · lines: 184 · matched declarations: 22
- L15: def `Sub`
- L16: def `SSub`
- L17: theorem `Sub.refl`
- L18: theorem `Sub.trans`
- L20: def `Aligned`
- L22: def `Needless`
- L24: theorem `U1`
- L30: theorem `SSub.trans_sub`
- L32: theorem `Sub.trans_ssub`
- L36: def `Equiv`
- L40: def `LexBetter`
- L45: theorem `lex_irrefl`
- L53: theorem `lex_trans`
- L69: def `LexAlignedL`
- L74: def `NoNeedlessAtEveryStage`
- L81: theorem `lex_U1`
- L93: theorem `freedom_first_U1_legacy`
- L102: theorem `guard_first_stage`
- L115: theorem `canonical_life_first_U1`
- L124: theorem `life_guard`
- L132: theorem `climb_from`
- L162: theorem `life_guard_exists`

## lalala/compiled-strongest/lean/Snuffy/BookUPTLottery.lean

- SHA-256: `26c54d737da0153bbda0b62b372577bad5a9624e1686b446e1dbbec4d6691ea1` · lines: 113 · matched declarations: 10
- L19: theorem `outcome_reachable`
- L30: theorem `outcome_unique`
- L46: theorem `fair_when_bound_before_reveal`
- L53: theorem `choosing_after_reveal_forces_any_outcome`
- L61: theorem `inconsistent_openings_disagree`
- L71: def `cnt`
- L73: theorem `cnt_or_le`
- L82: theorem `cnt_compl`
- L93: theorem `decoding_radius`
- L106: theorem `unique_decoding`

## lalala/compiled-strongest/lean/Snuffy/BookUPTLotteryMenu.lean

- SHA-256: `fad670723c2a079eb43aa1ced3df8537874ff65475d3d414d32b6045fa22412a` · lines: 98 · matched declarations: 11
- L19: def `cnt`
- L21: theorem `cnt_congr`
- L35: def `Offers`
- L43: def `weight`
- L44: def `classes`
- L48: theorem `draw_invariant`
- L59: theorem `duplicate_description_changes_nothing`
- L74: def `descriptionWeight`
- L78: theorem `draw_over_descriptions_is_manipulable`
- L87: inductive `Being`
- L91: theorem `tragic_pair_equal_chances`

## lalala/compiled-strongest/lean/Snuffy/BookUPTMonotone.lean

- SHA-256: `d356efc7063a0e839dac3d91b85ab43bc274e056b2dc03908bb4b3dc340ee970` · lines: 107 · matched declarations: 12
- L15: def `factor`
- L18: theorem `inv_in_unit`
- L26: theorem `factor_eq`
- L29: theorem `factor_antitone`
- L36: theorem `factor_nonneg`
- L45: theorem `mul_mono`
- L52: theorem `pow_mono`
- L62: theorem `bound_antitone`
- L75: theorem `grid_min_antitone`
- L87: theorem `clip_antitone`
- L92: theorem `ceiling_at_499_bounds_larger_service`
- L101: theorem `audit_instance`

## lalala/compiled-strongest/lean/Snuffy/BookUPTNoExchangeRate.lean

- SHA-256: `38f6c78adcf3cd67878dcbd90946859ea009cb3e2a00f2e3a1cce1accd8a3290` · lines: 175 · matched declarations: 15
- L22: def `LexLt`
- L27: theorem `weighted_sum_trades_a_life`
- L36: theorem `grows`
- L44: theorem `no_count_utility`
- L51: theorem `no_faithful_count_utility`
- L60: theorem `bounded_stakes_represent`
- L83: def `bu`
- L86: theorem `frac_spec`
- L103: theorem `frac_strict`
- L114: theorem `frac_lt_one`
- L115: theorem `frac_nonneg`
- L118: theorem `bounded_utility_represents_counts`
- L143: def `Sub`
- L144: def `SSub`
- L149: theorem `no_utility_on_who_is_kept`

## lalala/compiled-strongest/lean/Snuffy/BookUPTQuorum.lean

- SHA-256: `e8d1dbb48b9691887494f8c91a5606c822a175ba3627383a8d274351f4673ff7` · lines: 156 · matched declarations: 18
- L20: def `cnt`
- L23: theorem `cnt_le`
- L27: theorem `cnt_or_and`
- L34: theorem `cnt_split`
- L41: theorem `cnt_mono`
- L49: theorem `cnt_pos`
- L61: theorem `quorum_overlap`
- L68: theorem `quorums_share_a_live_island`
- L78: theorem `up_islands_form_a_quorum`
- L88: theorem `cnt_lt_range`
- L96: theorem `cnt_ge_range`
- L104: theorem `cnt_band_range`
- L114: theorem `overlap_bound_is_tight`
- L123: theorem `U6_pool_quorums`
- L129: theorem `U6_control_201`
- L135: theorem `U6_live`
- L141: theorem `U8_lockstep_majority`
- L150: theorem `U5_threshold_counting`

## lalala/compiled-strongest/lean/Snuffy/BookUPTRestraint.lean

- SHA-256: `6e386db3c6a1e6eaaca7f66abd5352a524a043054aacbd970531fd8b21b7ec8f` · lines: 110 · matched declarations: 14
- L14: def `Sub`
- L17: def `SSub`
- L19: theorem `ssub_irrefl`
- L21: theorem `ssub_trans`
- L26: def `Restrainable`
- L31: theorem `restraint_keeps`
- L45: theorem `climb`
- L71: theorem `maximal_restraint_exists`
- L82: theorem `predator_tragic`
- L86: inductive `P`
- L88: def `hunt`
- L89: def `starve`
- L93: theorem `hunting_not_restrainable`
- L104: theorem `harmless_alternative_restrains`

## lalala/compiled-strongest/lean/Snuffy/Bridge.lean

- SHA-256: `7c1c2d43f9d37d0ecf717fec37966d0f73805ba17a07d3f1c32b9f35794cd195` · lines: 292 · matched declarations: 11
- L56: theorem `coverage_from_law`
- L74: theorem `nearest_decodes`
- L86: theorem `exists_nearest_decoder`
- L94: def `Continues`
- L103: theorem `holding_preserves`
- L131: theorem `qsl_growth`
- L146: theorem `qsl_within_radius`
- L168: theorem `headroom_within_radius`
- L204: theorem `universal_protection_held`
- L248: def `ContinuesP`
- L263: theorem `holding_cycle_physical`

## lalala/compiled-strongest/lean/Snuffy/BridgeD1.lean

- SHA-256: `3e55b52b2b6516ea68b50248485e3aea36a531d01efce059168d14ad482f977f` · lines: 85 · matched declarations: 9
- L18: def `dynamicSurvival`
- L19: def `dynamicReward`
- L21: def `dynamicValue`
- L24: theorem `dynamic_survival_equation`
- L37: theorem `hazard_grows_without_bound`
- L41: theorem `positive_accumulated_prefix`
- L51: theorem `increasing_hazard_does_not_erase_prefix`
- L65: theorem `exact_discounted_dominance_criterion`
- L74: theorem `undiscounted_finite_crossover`

## lalala/compiled-strongest/lean/Snuffy/BridgeE9.lean

- SHA-256: `b4af3475fb19e438dba9bb67bcfcb2d378f6654f173edfcebc117ed5b63b396f` · lines: 60 · matched declarations: 7
- L13: theorem `reaction_before_damage`
- L23: theorem `positive_propagation_margin`
- L32: theorem `local_buffer_covers_entire_reaction`
- L41: theorem `escrow_prevents_pre_detection_application`
- L46: def `boundary`
- L49: theorem `incidence_has_circulation_kernel`
- L53: theorem `lost_circulation_need_not_change_divergence`

## lalala/compiled-strongest/lean/Snuffy/BridgeH6.lean

- SHA-256: `9f2008ce0ba3cf52e943f1442f545a9a9894caf25ffc06aeebecb04e4697e0aa` · lines: 66 · matched declarations: 5
- L13: theorem `charged_transition_bound`
- L28: theorem `no_infinite_paid_run`
- L35: theorem `budget_exhaustion_need_not_be_fixed`
- L41: theorem `current_residual_bound`
- L51: theorem `next_residual_bound`

## lalala/compiled-strongest/lean/Snuffy/BridgeH7.lean

- SHA-256: `a1ec93a1c569fb26c29a93513f0a29a5bfbd86a113395b2acdc09a1976fd35ad` · lines: 122 · matched declarations: 15
- L16: def `rate`
- L17: def `denominator`
- L18: def `step`
- L20: def `equilibrium`
- L22: def `sensitivity`
- L24: def `run`
- L28: theorem `rate_bounds`
- L37: theorem `denominator_positive`
- L41: theorem `equilibrium_is_fixed`
- L49: theorem `fixed_point_unique`
- L59: theorem `exact_transient`
- L76: theorem `equilibrium_private_evidence_sensitivity`
- L83: theorem `stubborn_anchor_limit`
- L95: theorem `private_evidence_sensitivity_vanishes`
- L107: theorem `exact_bias_threshold`

## lalala/compiled-strongest/lean/Snuffy/BridgeH8.lean

- SHA-256: `5c7e2109540c8106e74de8bec1c0ad27b5839720988ebb76d89f1797807ca8aa` · lines: 108 · matched declarations: 12
- L13: def `energy`
- L14: def `blend`
- L16: def `flow`
- L18: theorem `variance_identity`
- L35: theorem `uniform_global_minimum`
- L42: theorem `equality_only_at_uniform`
- L53: theorem `blend_normalized`
- L61: theorem `blend_cap_preserved`
- L71: theorem `exact_excess_decay`
- L81: theorem `gradient_flow_equation`
- L89: theorem `flow_coefficient_in_unit_interval`
- L97: theorem `original_upper_fails_along_restoring_flow`

## lalala/compiled-strongest/lean/Snuffy/CanonVonNeumann.lean

- SHA-256: `6edeeac96792eee313bcd814f1f7e0a41e2284b1ce4da61a6c3e6dc71d94ad14` · lines: 296 · matched declarations: 16
- L23: structure `of`
- L50: theorem `altIterate_sub`
- L61: theorem `altIterate_shift`
- L72: theorem `norm_altIterate_le`
- L84: theorem `altIterate_eq_halperin`
- L94: theorem `opial_tIterate_eq`
- L104: theorem `mirrorAltIterate_eq`
- L116: theorem `tendsto_altIterate_sub_succ`
- L138: theorem `mem_inf_of_orthogonal_range`
- L171: theorem `tendsto_zero_of_mem_orthogonal`
- L226: theorem `tendsto_altIterate`
- L257: theorem `canon_von_neumann_convergence`
- L268: theorem `limit_subspace_eq_inf`
- L273: theorem `canon_opial_convergence`
- L282: theorem `opial_norm_sq_tendsto`
- L289: theorem `opial_route_closes`

## lalala/compiled-strongest/lean/Snuffy/CascadeCore.lean

- SHA-256: `81f805ae276d44122f4f1dab4455502371e7250fe7a56afb204a12e76c59a5c9` · lines: 89 · matched declarations: 10
- L13: theorem `workload_deadline`
- L18: def `queue`
- L22: theorem `recursive_queue_bound`
- L35: def `entropy`
- L39: theorem `multi_epoch_entropy_bound`
- L51: theorem `spectrum_expectation_floor`
- L60: theorem `atomic_headroom`
- L64: theorem `defection_deficit`
- L71: theorem `sustained_deficit_crosses_buffer`
- L83: theorem `buffer_threshold_crossed`

## lalala/compiled-strongest/lean/Snuffy/ChannelCP.lean

- SHA-256: `3cd5e3ba33ece3d49702ff3d5fe8cf9fa5d2b30f67aa2633ae26634a0bfba2a0` · lines: 112 · matched declarations: 9
- L35: def `block`
- L39: def `amp`
- L44: def `mpT`
- L49: theorem `kron_entry`
- L59: theorem `amp_eq`
- L69: def `compress`
- L71: theorem `compress_entry`
- L77: theorem `mp_posSemidef`
- L94: theorem `decoder_completely_positive`

## lalala/compiled-strongest/lean/Snuffy/ChannelExtension.lean

- SHA-256: `7e6c4e740f0c62d68e7a56c37b0513bdcde6f9032c357e652a2b313d210e8017` · lines: 92 · matched declarations: 6
- L33: def `ext`
- L36: theorem `ext_recovers`
- L52: theorem `kron_isometry`
- L57: theorem `ext_recovers_reference`
- L64: theorem `ext_trace`
- L71: theorem `ext_posSemidef`

## lalala/compiled-strongest/lean/Snuffy/ChannelMeter.lean

- SHA-256: `e959b4720b25812157b78583e963c80845946264db343cfc3750ba2419d88cf0` · lines: 44 · matched declarations: 3
- L21: theorem `channel_le_meter`
- L25: theorem `every_channel_excluded`
- L37: theorem `every_channel_bits_bounded`

## lalala/compiled-strongest/lean/Snuffy/ClosedCohold.lean

- SHA-256: `c33c38aa705a5b3b61a47d22fe227c8f1062f299550f3fdd0a68138c51ea94b5` · lines: 78 · matched declarations: 14
- L5: inductive `Reach`
- L9: def `Closed`
- L12: theorem `reachable_closed`
- L15: theorem `reachable_least`
- L24: def `iter`
- L28: def `active`
- L33: def `run`
- L38: theorem `factorised_cohold`
- L49: def `trace`
- L55: def `outsideTrace`
- L60: theorem `outside_unchanged`
- L72: def `coupled`
- L73: def `coupledHold`
- L74: theorem `crossing_boundary_changes_outside_later`

## lalala/compiled-strongest/lean/Snuffy/ClosedUnitaryRecurrence.lean

- SHA-256: `24d5296eedc17ff8de23ce3e43bdeb4664a4b976918ba5f7c6a5338574c2e040` · lines: 394 · matched declarations: 34
- L11: theorem `with`
- L57: def `CouplingLink`
- L60: theorem `hermitian_coupling_reciprocal`
- L74: def `curtailedLink`
- L77: theorem `curtailed_not_hermitian`
- L87: theorem `dist_iterate`
- L95: theorem `recurrence_of_compact_orbit`
- L121: def `PermanentDeparture`
- L125: theorem `no_permanent_departure`
- L133: theorem `no_final_protected_stage_closed`
- L142: theorem `all_return_together`
- L158: theorem `norm_iterate`
- L164: theorem `orbit_in_sphere`
- L168: theorem `sphere_compact`
- L174: theorem `unitary_recurrence`
- L182: theorem `unitary_no_permanent_curtailment`
- L191: theorem `control_sink`
- L198: theorem `control_sink_not_isometry`
- L204: theorem `control_noncompact`
- L218: theorem `closure_does_not_forbid_first_loss`
- L230: theorem `past_recoverable`
- L239: theorem `every_relation_carried_forward`
- L245: theorem `no_merging`
- L251: theorem `own_activity_iff_no_step_stops`
- L263: theorem `relations_persist_activity_can_stop`
- L281: def `DependsOn`
- L285: theorem `reversible_dependence_conserved`
- L297: theorem `dependence_chain`
- L305: theorem `control_reset_no_dependence`
- L311: def `exchange`
- L315: theorem `exchange_moves_dependence`
- L328: def `scramble`
- L332: theorem `scrambling_no_single_carrier`
- L364: theorem `no_predicate_invariant_under_all_reversible`

## lalala/compiled-strongest/lean/Snuffy/CommonPolicyMaximal.lean

- SHA-256: `b8f3f62264f903e53f2aeac7aa9426d94db1e94673853b4b4338752bbf3ae452` · lines: 35 · matched declarations: 1
- L25: theorem `common_policy_maximal`

## lalala/compiled-strongest/lean/Snuffy/CommonPolicyTop.lean

- SHA-256: `ad8ece04578ca68bb7800b24d1a0a6aaf60949a7009932614209b153bce7f3e3` · lines: 60 · matched declarations: 2
- L23: theorem `top_policy_exists`
- L49: theorem `top_policy_greatest`

## lalala/compiled-strongest/lean/Snuffy/Composition.lean

- SHA-256: `2524e8c846408e622bb8a31e89a8888ab07cade9f99f56aa700be3970c870bd5` · lines: 157 · matched declarations: 6
- L35: def `run`
- L45: theorem `reactive_lockstep`
- L67: def `run₂`
- L80: theorem `reactive_lockstep₂`
- L110: theorem `invariant_transfer`
- L133: theorem `theorem8_composition`

## lalala/compiled-strongest/lean/Snuffy/Concatenated.lean

- SHA-256: `ead9ece1b170bcfba9bf202fc290d4600e716bb75f7ac6fec0fd483cce5d256e` · lines: 209 · matched declarations: 15
- L39: theorem `distance3_corrects_one`
- L49: abbrev `Loc`
- L52: def `sub`
- L58: def `Fails`
- L63: def `consEmb`
- L67: def `lift`
- L72: def `witnesses`
- L77: theorem `lift_subset`
- L87: theorem `fails_witness`
- L106: theorem `card_lift`
- L109: theorem `disjoint_lift`
- L121: theorem `card_witness`
- L135: theorem `card_witnesses`
- L165: theorem `concatenated_threshold`
- L195: theorem `concatenated_ceiling`

## lalala/compiled-strongest/lean/Snuffy/ConcatenatedDecoding.lean

- SHA-256: `89f4eb6cd0f8099260c4796a302448679bd1219b24eb6e796286c29eac00cfaf` · lines: 129 · matched declarations: 6
- L38: theorem `outer_decodes`
- L50: def `encodeRec`
- L55: def `decodeRec`
- L59: theorem `mem_sub`
- L64: theorem `decodes_unless_fails`
- L108: theorem `decoding_failure_le`

## lalala/compiled-strongest/lean/Snuffy/ConsensusRate.lean

- SHA-256: `fcd89bf81c2949641e6b3c8065e31e3886565c76659a189dd7ed26b87e13997c` · lines: 42 · matched declarations: 1
- L23: theorem `bandwidth_contraction`

## lalala/compiled-strongest/lean/Snuffy/ConservedRouting.lean

- SHA-256: `aeb5e586ee5d972b2c72a2fa7f3ea7c72855da3c23228ab6ab1e3a64124481a6` · lines: 149 · matched declarations: 13
- L26: structure `RoutingDemand`
- L32: def `conservedFlow`
- L36: def `conservedPsi`
- L41: def `rowProfile`
- L46: def `Regular`
- L50: theorem `conserved_decomposes`
- L66: theorem `regular_psi_is_hhi`
- L78: theorem `hhi_uniform`
- L89: theorem `monopoly_exceeds_uniform`
- L103: theorem `h8_exact_general`
- L124: theorem `thermal_ledger_positivity_strict`
- L132: theorem `thermal_ledger_positivity_nonneg`
- L140: theorem `jarzynski_bound_valid`

## lalala/compiled-strongest/lean/Snuffy/ContinuationPredicate.lean

- SHA-256: `8b96ffeb524fd26d068b1fd3415174b0ee684effe9ac5faabfb0e7d22e8dc36f` · lines: 94 · matched declarations: 9
- L27: structure `Event`
- L33: def `LaterStage`
- L37: def `FreeStage`
- L40: theorem `laterStage_refl`
- L45: theorem `laterStage_trans`
- L60: theorem `copy_not_laterStage`
- L72: theorem `split_continues_both`
- L82: theorem `faithful_hold_preserves`
- L89: theorem `directed_by_other_not_free`

## lalala/compiled-strongest/lean/Snuffy/ContinuationSubject.lean

- SHA-256: `fce164bf6d195dd2f35ec11979ce650ffaad80ba2a87d29305f3ec252607c4d9` · lines: 91 · matched declarations: 10
- L27: structure `Event`
- L32: def `LaterStage`
- L35: def `FreeStage`
- L38: theorem `laterStage_refl`
- L41: theorem `laterStage_trans`
- L54: theorem `copy_not_laterStage`
- L66: theorem `split_continues_both`
- L74: theorem `care_keeps_freedom`
- L80: theorem `directed_by_other_not_free`
- L86: theorem `faithful_hold_preserves`

## lalala/compiled-strongest/lean/Snuffy/ControllerCertificate.lean

- SHA-256: `200b979928bfb647972dce49e5724872ed4a5f4d66d87e2776f3ac25c4ca1b4e` · lines: 167 · matched declarations: 44
- L23: def `deltaQ`
- L26: def `rateQ`
- L29: def `debtQ`
- L32: def `allocFIFOQ`
- L35: def `totalQ`
- L39: def `stableQ`
- L43: theorem `stable_min_three`
- L45: theorem `delta_min_three`
- L47: theorem `rate_min_three`
- L49: theorem `debt_min_three`
- L51: theorem `alloc_min_three`
- L53: theorem `total_min_three`
- L56: theorem `total_min_three_le`
- L60: theorem `band_min_three`
- L71: theorem `stable_min_four`
- L73: theorem `delta_min_four`
- L75: theorem `rate_min_four`
- L77: theorem `debt_min_four`
- L79: theorem `alloc_min_four`
- L81: theorem `total_min_four`
- L84: theorem `total_min_four_le`
- L87: theorem `band_min_four`
- L98: theorem `stable_rob_three_two`
- L99: theorem `stable_rob_three_four`
- L101: theorem `total_rob_three_two`
- L103: theorem `total_rob_three_three`
- L105: theorem `total_rob_three_four`
- L108: theorem `total_rob_three_two_le`
- L109: theorem `total_rob_three_three_le`
- L110: theorem `total_rob_three_four_le`
- L113: theorem `band_rob_three`
- L122: theorem `stable_rob_four_two`
- L123: theorem `stable_rob_four_four`
- L125: theorem `total_rob_four_two`
- L127: theorem `total_rob_four_three`
- L129: theorem `total_rob_four_four`
- L132: theorem `total_rob_four_two_le`
- L133: theorem `total_rob_four_three_le`
- L134: theorem `total_rob_four_four_le`
- L137: theorem `band_rob_four`
- L148: theorem `pool_bills`
- L152: theorem `corrected_bill_saving`
- L160: theorem `allocation_undercharge_three`
- L163: theorem `allocation_undercharge_four`

## lalala/compiled-strongest/lean/Snuffy/ControllerFence.lean

- SHA-256: `8f4d8faaf7ebc5e15997f0b5667ec988016bbea090ed487d27e5271ed6ccbd43` · lines: 55 · matched declarations: 3
- L9: def `TokenWitness`
- L17: theorem `certified_hold_nothing_lands`
- L40: theorem `both_targets_held`

## lalala/compiled-strongest/lean/Snuffy/ControllerFinality.lean

- SHA-256: `e5cfdacff59c22ff7c9447c308faa09e3822d5ad7531f2e8435e535c4432dca7` · lines: 442 · matched declarations: 55
- L7: def `tally`
- L11: theorem `tally_mono`
- L20: theorem `quorum_has_honest`
- L33: theorem `two_tallies_bound`
- L45: theorem `quorum_intersection`
- L59: theorem `committee_threshold`
- L61: def `Prefix`
- L63: theorem `prefix_trans`
- L69: theorem `equal_length_prefixes`
- L80: theorem `certificates_do_not_equivocate`
- L94: theorem `certificate_is_final`
- L106: structure `Context`
- L114: def `contextWords`
- L117: theorem `context_words_injective`
- L124: structure `State`
- L132: inductive `Op`
- L140: inductive `Reply`
- L151: def `step`
- L176: def `run`
- L180: theorem `run_append`
- L186: theorem `step_floor_mono`
- L199: theorem `run_floor_mono`
- L205: theorem `grant_fields`
- L214: theorem `floor_fields`
- L226: theorem `held_refuses`
- L230: theorem `retired_generation_refuses`
- L237: theorem `pending_conflict_refuses`
- L243: theorem `closed_sequence_refuses`
- L256: structure `Receipt`
- L262: def `namedOp`
- L263: def `expectedReply`
- L265: def `history`
- L266: def `replayOK`
- L269: theorem `receipt_names_success`
- L276: theorem `certified_receipt_names_success`
- L290: theorem `same_generation_no_context_conflict`
- L299: theorem `checkpoint_replay`
- L303: structure `Local`
- L311: def `allows`
- L315: def `consume`
- L316: def `restart`
- L319: theorem `consume_once`
- L322: theorem `restart_disabled`
- L325: theorem `retained_floor_refuses`
- L335: theorem `old_boot_refuses`
- L343: theorem `deadline_refuses`
- L349: def `emits`
- L353: def `issued`
- L357: theorem `issued_append`
- L363: theorem `emission_bounded`
- L377: theorem `issues_bounded_by_final_floor`
- L387: theorem `step_stays_held`
- L397: theorem `held_issues_nothing`
- L417: theorem `grant_receipt_is_issued`
- L427: theorem `hold_bounds_every_issued_grant`

## lalala/compiled-strongest/lean/Snuffy/CorrelatedCeiling.lean

- SHA-256: `dad8822f00f28aa83bce2fc5b4941c2df4e8aa5cc79d4841e5836061c0d85b6f` · lines: 214 · matched declarations: 8
- L48: lemma `ceil_touching`
- L75: theorem `correlated_stress_ceil`
- L102: def `damageLaw`
- L109: theorem `prob_damage`
- L123: lemma `near_card_le`
- L136: lemma `choose_pow_le`
- L158: theorem `damage_local_stochastic`
- L193: theorem `correlated_family_ceiling`

## lalala/compiled-strongest/lean/Snuffy/CorrelatedHolding.lean

- SHA-256: `986f733315945644f15a6b654f63604288733872475b81ef5336b2fc8fada7c9` · lines: 80 · matched declarations: 4
- L30: theorem `random_threat_bound`
- L44: theorem `correlated_holding_bound`
- L63: theorem `random_threat_independent`
- L73: theorem `random_threat_correlated`

## lalala/compiled-strongest/lean/Snuffy/CorrelatedStress.lean

- SHA-256: `beb05c3273ac414cea47d28c9ce8e0f6f0160a7a2ed1cff43f0d0da0ced52ea3` · lines: 79 · matched declarations: 3
- L27: def `near`
- L33: lemma `many_touching`
- L54: theorem `correlated_stress`

## lalala/compiled-strongest/lean/Snuffy/CountablePooling.lean

- SHA-256: `9b0ef460496f42e0ea3b20d2c0907985242c5ff1b61938b1cf0e891ad8c4d6ec` · lines: 63 · matched declarations: 3
- L24: theorem `pool_strictly_dominant_ennreal`
- L44: theorem `countable_keepers_pool`
- L51: theorem `countable_keepers_noisy_pool`

## lalala/compiled-strongest/lean/Snuffy/CutEquivalence.lean

- SHA-256: `0d1c1d0875fbee992b5d5a069e1b32e0f123446755277aaf90fb4c819eccc225` · lines: 39 · matched declarations: 1
- L23: theorem `closed_iff_no_bypass`

## lalala/compiled-strongest/lean/Snuffy/CyclicProjections.lean

- SHA-256: `aa67f92c0cd71d1d246576d47dda71e819e6bec52e3ec3633ce9de1b54d87414` · lines: 297 · matched declarations: 19
- L37: def `cyc`
- L43: def `adj`
- L48: theorem `cyc_succ_apply`
- L52: theorem `adj_succ_apply`
- L56: theorem `norm_cyc_le`
- L63: theorem `norm_adj_le`
- L70: theorem `inner_cyc`
- L78: theorem `cyc_fix`
- L86: theorem `fixed_of_norm_eq`
- L96: theorem `mem_of_norm_adj_eq`
- L112: theorem `energy`
- L162: theorem `iter_succ`
- L166: theorem `iter_shift`
- L170: theorem `norm_iter_le`
- L175: theorem `iter_fix`
- L181: theorem `tendsto_iter_sub_succ`
- L205: theorem `tendsto_zero_of_mem_orthogonal`
- L258: theorem `tendsto_cyc_iter`
- L275: theorem `presentation_detector`

## lalala/compiled-strongest/lean/Snuffy/DataProcessing.lean

- SHA-256: `c59d5eac1b24cca21a2581f64fbb37c74d6517c5a91d03b7866469d6c6c19172` · lines: 85 · matched declarations: 6
- L35: def `mutualInfo`
- L39: def `process`
- L43: theorem `fst_process`
- L59: theorem `snd_process`
- L73: theorem `data_processing`
- L81: theorem `data_processing_map`

## lalala/compiled-strongest/lean/Snuffy/DeadlineDemand.lean

- SHA-256: `fbf8dbe2595ff092db44929a5c78924cf2b16e4078b667e8dda42e303e662219` · lines: 55 · matched declarations: 2
- L24: theorem `demand_le_supply`
- L46: theorem `robust_demand`

## lalala/compiled-strongest/lean/Snuffy/DecisionAndScale.lean

- SHA-256: `c91607cc89eb3bcb6be6a3c546816bf69f336f0246c57cca685aa189df5d6507` · lines: 85 · matched declarations: 8
- L14: theorem `weighted_outcome_dominance`
- L22: theorem `continuation_gain_pays_overhead`
- L28: theorem `finite_branch_payoff_bound`
- L39: theorem `duration_reward_bound`
- L45: theorem `efficiency_gain_pays_cost`
- L50: theorem `dominant_action_survives_mixture`
- L60: theorem `local_verifier_cost`
- L68: theorem `two_provider_unique_balanced_cost`

## lalala/compiled-strongest/lean/Snuffy/DecisionPermit.lean

- SHA-256: `9c646ea72b5cca6c461e116054b97ce1150423488f79d54175153983b8d6c37a` · lines: 94 · matched declarations: 12
- L26: structure `Decision`
- L33: def `decisionWords`
- L35: theorem `decision_words_injective`
- L43: def `enrolOf`
- L45: theorem `grant_names_certified`
- L74: theorem `granted_policy_is_certified`
- L84: def `D0`
- L85: def `s0`
- L86: def `pausePermit`
- L87: def `replicaPermit`
- L89: theorem `wrong_action_rejected`
- L91: theorem `certified_action_granted`

## lalala/compiled-strongest/lean/Snuffy/DecoderRetraction.lean

- SHA-256: `4275cfc98e301674eddb2316861fa6f6d85f21e72e0b0000262ca1c9b2c15d07` · lines: 413 · matched declarations: 40
- L14: structure `DecoderPair`
- L19: theorem `decode_encode`
- L28: theorem `finite_code_recovery`
- L57: theorem `nonvanishing_of_continuation`
- L71: theorem `finite_code_self_grounding`
- L97: theorem `inner_preserved_from_symplectic_flux`
- L107: def `boundaryIsometry`
- L113: theorem `adjoint_decodes_isometry`
- L119: def `decoderFromSymplecticFlux`
- L127: def `boundaryObservable`
- L130: theorem `boundary_observable_on_code`
- L136: theorem `historical_query_preserved`
- L143: theorem `historical_word_on_code`
- L151: theorem `historical_word_expectation`
- L160: theorem `boundary_observable_mul`
- L166: theorem `boundary_observable_commutator`
- L179: theorem `powers_intertwine`
- L190: theorem `exponential_intertwines`
- L204: def `historicalFlow`
- L208: def `historicalFlowLinear`
- L214: theorem `historical_flow_roundtrip`
- L239: theorem `historical_dual_kernel`
- L252: theorem `work_shifted_flow_on_code`
- L275: theorem `historical_gram_preserved`
- L282: theorem `historical_gram_nondegenerate`
- L295: def `coordinateBoundaryEncoder`
- L299: theorem `coordinate_boundary_roundtrip`
- L305: theorem `boundary_capacity_necessary`
- L317: def `handoffSwap`
- L325: theorem `handoff_moves_reference_payload`
- L334: theorem `handoff_preserves_norm`
- L339: theorem `handoff_roundtrip`
- L348: def `transcriptBoundaryEncoder`
- L359: def `cnotLeft`
- L363: def `cnotRight`
- L369: theorem `parallel_cnot_handoff`
- L376: inductive `ArchivePayload`
- L380: def `archiveRead`
- L385: def `archiveMove`
- L394: theorem `charged_archive_handoff`

## lalala/compiled-strongest/lean/Snuffy/DeductionBoundary.lean

- SHA-256: `7564d8e303e2832617e52d597c0affd33bf9dd96b96541f0c62257b885dd1e6e` · lines: 90 · matched declarations: 6
- L30: theorem `rank_criterion`
- L45: theorem `context_maps_image`
- L55: inductive `Deduction`
- L61: def `boundary`
- L68: theorem `boundary_mem_image`
- L80: theorem `anchor_untouched`

## lalala/compiled-strongest/lean/Snuffy/E9Routes.lean

- SHA-256: `980c8b3c290ad8298a5efccb85f66564195679daa59802a1bb47782ae9ae9d1f` · lines: 54 · matched declarations: 2
- L12: theorem `surviving_disjoint_route`
- L38: theorem `certified_repair_meets_deadline`

## lalala/compiled-strongest/lean/Snuffy/E9SelfHealing.lean

- SHA-256: `a5e8804486c94667262516d164cebaac3a5063108864f261a3583547e2ad09f2` · lines: 213 · matched declarations: 10
- L43: def `Robust`
- L49: theorem `robust_between_honest`
- L72: theorem `no_false_alarm`
- L79: theorem `no_masking`
- L87: theorem `exists_robust`
- L140: abbrev `Stabilizer`
- L147: theorem `syndrome_detects`
- L172: theorem `wave_race_margin`
- L179: theorem `code_headroom`
- L196: theorem `e9_timely_self_healing`

## lalala/compiled-strongest/lean/Snuffy/EdgeLaw.lean

- SHA-256: `aa4051246ef25c7e30622e13bf0a3d84637453d36f49911d706efe4119c26b76` · lines: 102 · matched declarations: 3
- L34: def `pushLaw`
- L42: theorem `prob_push`
- L57: theorem `push_localStochastic`

## lalala/compiled-strongest/lean/Snuffy/EmissionBound.lean

- SHA-256: `61cf6907e0f92220bf5df8f3733afdfb3782b9afb63c0cce2698794ab1386c0f` · lines: 70 · matched declarations: 5
- L27: theorem `requisite_variety`
- L43: theorem `requisite_variety_prob`
- L51: theorem `narrow_channel_bits`
- L58: theorem `unmetered_energy_bound`
- L65: theorem `emission_cannot_power`

## lalala/compiled-strongest/lean/Snuffy/ErrorBudget.lean

- SHA-256: `a29747a66e158b7562139d480013f0e79fa22227182293528f0159c129dc9555` · lines: 126 · matched declarations: 5
- L32: theorem `prod_norm_le_one`
- L46: theorem `map_prod_norm_le_one`
- L65: theorem `two_factor_step`
- L88: theorem `telescoping_delta`
- L113: theorem `error_budget`

## lalala/compiled-strongest/lean/Snuffy/ExRecBound.lean

- SHA-256: `c8c695569efb76cfcbcb96eda30302db4b15297d27d42f9545627f7fce2eb97c` · lines: 85 · matched declarations: 3
- L35: theorem `exrec_pair_bound`
- L72: theorem `circuit_level_rate`
- L81: theorem `surface_code_rate`

## lalala/compiled-strongest/lean/Snuffy/ExclusionRadius.lean

- SHA-256: `044e81964c80ada101c8d6121f58cdcca81db7850c043650f3e766fb2db77ae1` · lines: 48 · matched declarations: 2
- L21: theorem `exclusion_radius`
- L39: theorem `received_effect_bound`

## lalala/compiled-strongest/lean/Snuffy/ExpandingWavefront.lean

- SHA-256: `3a625186ca0c6d2bd46af79924bb303ef0e5c76b24867c82233bf9dc13f4ab29` · lines: 45 · matched declarations: 2
- L24: theorem `expanding_coverage`
- L32: theorem `expanding_round_trip`

## lalala/compiled-strongest/lean/Snuffy/FIFOAdmission.lean

- SHA-256: `6af02f49d62a9de0839ab2e63aa831d903a740204f6ac2aa00a9491981f79b64` · lines: 145 · matched declarations: 17
- L12: def `Certified`
- L18: def `checks`
- L24: theorem `checks_iff`
- L30: theorem `certified_mono`
- L38: theorem `certified_append`
- L45: def `admit`
- L48: theorem `admission_preserves`
- L55: theorem `completion_preserves`
- L62: def `cancel`
- L67: theorem `cancellation_preserves`
- L80: def `ActualTimely`
- L86: theorem `all_occurrences_timely`
- L98: structure `Queue`
- L102: inductive `QueueEvent`
- L107: def `queueStep`
- L116: theorem `queue_step_preserves`
- L133: theorem `refinement_preserves_queue`

## lalala/compiled-strongest/lean/Snuffy/FIFOInstance.lean

- SHA-256: `f5e6b9dae8621949167ad77add96f9de5a4338b4cafa69cc10579ee4b1fe5f7f` · lines: 100 · matched declarations: 11
- L25: def `finishQ`
- L32: theorem `finishes_three`
- L40: theorem `veto_envelope_three`
- L45: theorem `alloc_completion_is_the_charge_three`
- L50: theorem `control_lane_three_certified`
- L59: theorem `finishes_four`
- L67: theorem `veto_envelope_four`
- L70: theorem `alloc_completion_is_the_charge_four`
- L74: theorem `control_lane_four_certified`
- L85: theorem `per_job_deadlines_three`
- L94: theorem `per_job_deadlines_four`

## lalala/compiled-strongest/lean/Snuffy/FIFOWorkload.lean

- SHA-256: `bac2795fa7729999e21e077eef5c8f7b5274d2c011b67bf8382c7c086f64460d` · lines: 71 · matched declarations: 5
- L15: structure `Job`
- L23: def `finish`
- L30: theorem `fifo_step`
- L37: theorem `finish_le_upper`
- L59: theorem `certified_prefix_meets_deadline`

## lalala/compiled-strongest/lean/Snuffy/Fano.lean

- SHA-256: `0a8889d629d81e4aa27b4d627b4fe009d3c1901d27a7b9b86e4a45e3ee560bc1` · lines: 195 · matched declarations: 7
- L31: theorem `max_entropy`
- L50: theorem `fano_single`
- L90: def `condEnt`
- L94: def `entW`
- L98: theorem `fano`
- L148: theorem `mi_eq_ent_sub_condEnt`
- L187: theorem `required_information`

## lalala/compiled-strongest/lean/Snuffy/FaultCover.lean

- SHA-256: `13db39413f14e9b3f08bcbde01216113db5a267ff0d838ed4ea8a30d599c4951` · lines: 15 · matched declarations: 1
- L8: theorem `fault_cover`

## lalala/compiled-strongest/lean/Snuffy/FinalClosure.lean

- SHA-256: `f48e31cc9614cdbe9673d9affde6809fbc9b4da1c1aba716d97c5a5d2f42b836` · lines: 232 · matched declarations: 19
- L51: def `Sound`
- L54: def `Complete`
- L58: theorem `verifier_bound_iff`
- L70: theorem `proxy_ungameable_iff`
- L87: theorem `proxy_gameable`
- L104: def `rate`
- L107: def `objective`
- L111: theorem `pruning_lowers_rate`
- L125: theorem `living_unbounded`
- L135: theorem `pruning_all_stalls`
- L153: def `value`
- L158: theorem `void_strictly_below`
- L163: theorem `void_never_chosen`
- L175: theorem `dominance_channels`
- L182: theorem `coop_more_efficient`
- L196: def `stock`
- L199: theorem `stewardship_sustains`
- L206: theorem `extraction_depletes`
- L218: theorem `sustained_iff`

## lalala/compiled-strongest/lean/Snuffy/FiniteCharacter.lean

- SHA-256: `40f6ede784538d4072513dd4577c3e3734b343c064d1192403d739ee985c8638` · lines: 80 · matched declarations: 4
- L27: theorem `realisable_iff_finite`
- L51: def `RealisableFamily`
- L54: theorem `realisable_finitary`
- L68: theorem `four_stage_maximal_of_compact`

## lalala/compiled-strongest/lean/Snuffy/FiniteInformation.lean

- SHA-256: `2a7120678dfd22e9eaa9420621bab301099b9022ba59b20dbe5eeba4b7e70f87` · lines: 241 · matched declarations: 12
- L35: theorem `log_sum`
- L77: def `margH`
- L80: def `margY`
- L83: def `mi`
- L87: def `process`
- L90: theorem `margH_process`
- L97: theorem `margY_process`
- L105: theorem `data_processing_fin`
- L160: def `flag`
- L165: theorem `flag_identity`
- L205: theorem `decoder_bound`
- L226: theorem `necessary_radius_from_decoder`

## lalala/compiled-strongest/lean/Snuffy/FoundingAnchor.lean

- SHA-256: `e09a9eae840aca9d1991338e0247ee47e7d9ef725411205cb6d4b3b3fa8a235b` · lines: 39 · matched declarations: 4
- L19: theorem `campaign_funded`
- L25: def `anchorPayoff`
- L29: theorem `anchor_founds_iff`
- L35: theorem `anchor_founds_mono`

## lalala/compiled-strongest/lean/Snuffy/FoundingCover.lean

- SHA-256: `c465126d0f8e6246ade2aba0955d4c46055cd37a4bd8a2464618487b1c365072` · lines: 43 · matched declarations: 2
- L24: theorem `founding_cover_exists`
- L31: theorem `founded_reach`

## lalala/compiled-strongest/lean/Snuffy/FoundingDominance.lean

- SHA-256: `1fb0cdf2e8662cf21ac128ce5d59f07ab03adf4759a38b676d1131ba927a60ff` · lines: 48 · matched declarations: 4
- L25: def `advantage`
- L28: theorem `contribution_advantage_pos`
- L35: theorem `contribution_strictly_dominant`
- L43: theorem `no_abstention_equilibrium`

## lalala/compiled-strongest/lean/Snuffy/FoundingPivotal.lean

- SHA-256: `ccc9161719a7f6ca9ee9215f7d9185c07202f34751b5a33c0c1115698822048a` · lines: 53 · matched declarations: 3
- L25: theorem `pivotal_contribution_dominant`
- L35: theorem `others_short`
- L47: theorem `all_necessary_dominant`

## lalala/compiled-strongest/lean/Snuffy/G1Certificate.lean

- SHA-256: `4fe05fcbc6235481ecdb46a20ef1ab020e690181cbb8b5d048262bd8ced5409d` · lines: 37 · matched declarations: 8
- L3: structure `HCert`
- L8: structure `PhysicalSystem`
- L13: def `pPredicate`
- L17: structure `Controller`
- L21: structure `Environment`
- L24: def `s0`
- L27: structure `SafetyCertificate`
- L33: theorem `universal_protection_held`

## lalala/compiled-strongest/lean/Snuffy/G1Complete.lean

- SHA-256: `06f3e520893f9d7d5574030f9fed30bd8d5e90a8d93243ab58d23c1422f82a94` · lines: 33 · matched declarations: 5
- L3: inductive `FaultType`
- L10: structure `EventNode`
- L17: abbrev `EventTrace`
- L19: def `G1_Compliant`
- L22: theorem `g1_append_safe`

## lalala/compiled-strongest/lean/Snuffy/G1E9.lean

- SHA-256: `a027c38adf36721c181dac0de478212732ded8e17e133c2a84f8eae3dac666d7` · lines: 122 · matched declarations: 2
- L38: theorem `alarm_or_subthreshold`
- L64: theorem `held_source_e9`

## lalala/compiled-strongest/lean/Snuffy/G1Executable.lean

- SHA-256: `8414e6187adb9d866c6101555d628ee4a002b8ee6c68b8fa327c256fadd3d65f` · lines: 69 · matched declarations: 9
- L5: inductive `Command`
- L11: inductive `Event`
- L17: inductive `Observation`
- L23: structure `SystemState`
- L27: def `admitCommand`
- L33: def `stepSystem`
- L44: def `observe`
- L50: def `executeCommand`
- L55: theorem `g1_admission_soundness`

## lalala/compiled-strongest/lean/Snuffy/G1FullDomain.lean

- SHA-256: `c788dfccee71414a16e33cbf98896f2c114e4891a12f54f21ed43c5344de39b1` · lines: 130 · matched declarations: 19
- L5: inductive `SourceDomain`
- L11: inductive `FaultType`
- L18: structure `EventNode`
- L26: abbrev `EventTrace`
- L28: def `G1_Compliant`
- L31: def `G1_FaultFree`
- L34: def `G1_AllSourcesValid`
- L39: theorem `g1_source_exhaustive`
- L44: theorem `g1_fault_taxonomy_exhaustive`
- L49: theorem `g1_append_preserves`
- L63: structure `JournalState`
- L68: def `journalInit`
- L71: def `journalStep`
- L75: def `replay`
- L78: def `replayHistory`
- L84: theorem `replay_journal_step`
- L93: theorem `journal_reactive_fidelity`
- L114: abbrev `TranscriptAt`
- L118: theorem `transcript_capacity`

## lalala/compiled-strongest/lean/Snuffy/G1Held.lean

- SHA-256: `6d915552e41a578a04621af254fc53107f383ee77234495945c391082751c16f` · lines: 213 · matched declarations: 13
- L41: def `goodEvent`
- L45: theorem `good_cover`
- L54: def `heldStep`
- L59: theorem `held_source_protection`
- L99: abbrev `NormalisedState`
- L102: def `NormalisedFrame`
- L106: theorem `initial_frame_normalised`
- L111: theorem `held_step_normalised`
- L119: theorem `held_run_normalised`
- L133: theorem `held_source_qsl`
- L174: theorem `zero_hamiltonian_trajectory`
- L192: theorem `concrete_decoder_certificate`
- L209: theorem `concrete_good_event_inhabited`

## lalala/compiled-strongest/lean/Snuffy/G1Refinement.lean

- SHA-256: `3f0eb24d42b02a0fa90eba8d7088acff9a4122f668596f187c02f4f7c6dfa748` · lines: 235 · matched declarations: 7
- L51: def `guardedStep`
- L57: theorem `guarded_step_continues`
- L80: theorem `physical_protection`
- L116: theorem `journaled_protection`
- L155: theorem `physical_qsl_drift`
- L179: theorem `physical_protection_qsl`
- L215: theorem `physical_instance_inhabited`

## lalala/compiled-strongest/lean/Snuffy/G2Freedom.lean

- SHA-256: `d13969385ebbc7357126d9120309ae4bdbc22fe7d97b47bc596f595407315cf3` · lines: 107 · matched declarations: 4
- L35: def `jointPerturb`
- L40: def `jointCorrect`
- L44: theorem `joint_holding`
- L73: theorem `joint_holding_and_delivery`

## lalala/compiled-strongest/lean/Snuffy/G2Held.lean

- SHA-256: `0a62a0c481971d96903e02828cf246fe64e43376c6124edb52ba74e6d4dfc9e9` · lines: 131 · matched declarations: 5
- L44: def `AuthorisedFree`
- L49: theorem `active_authorised_free`
- L59: def `heldGrade`
- L66: theorem `held_realises_top`
- L94: theorem `held_source_top`

## lalala/compiled-strongest/lean/Snuffy/G2Outcome.lean

- SHA-256: `5f63e5aef491836fc6675e446fe5a2a106ed7ff5e8a891dd329a853b677bfaee` · lines: 30 · matched declarations: 5
- L3: structure `OutcomeTuple`
- L11: def `G2_ValidOutcome`
- L14: abbrev `OutcomeSequence`
- L16: def `G2_SequenceValid`
- L19: theorem `g2_compose_valid`

## lalala/compiled-strongest/lean/Snuffy/G2Physical.lean

- SHA-256: `13bd510da69e51e56d0253cfa0f352ee61e7d1e1ae588a588fe97b3b887447f4` · lines: 79 · matched declarations: 3
- L36: def `keptSet`
- L42: theorem `held_installation_keeps_all`
- L75: theorem `top_dominates_continuation`

## lalala/compiled-strongest/lean/Snuffy/G2Singleton.lean

- SHA-256: `139d7a503fbd004f1fc178a2f9cc054d471ac48c8b5dee32e298740030a2867e` · lines: 53 · matched declarations: 6
- L10: def `Coverage`
- L13: def `HoldingCycle`
- L16: def `SingletonKeepingPolicy`
- L19: theorem `g2_discharge_hsingle`
- L39: def `hsingle`
- L42: theorem `topRealisability_hsingle_discharged`

## lalala/compiled-strongest/lean/Snuffy/G2Splice.lean

- SHA-256: `0d05584e0a4061a2c6f2e41dd47a59199e92b8a12343a7fa9c7ecc9fe06d449d` · lines: 219 · matched declarations: 18
- L48: abbrev `Policy`
- L52: def `Realisable`
- L56: def `splice`
- L59: theorem `splice_grade`
- L66: theorem `splice_realisable`
- L79: def `outcome`
- L83: theorem `outcome_splice`
- L92: def `outcomes`
- L97: theorem `union_realizable`
- L106: theorem `top_realisable`
- L121: theorem `whole_outcome_greatest`
- L132: def `fourθ`
- L136: def `fourCat`
- L142: theorem `fourStage`
- L169: def `runIn`
- L175: def `blockSplice`
- L184: theorem `block_splice_run`
- L207: theorem `block_splice_keeps`

## lalala/compiled-strongest/lean/Snuffy/G2WholeOutcome.lean

- SHA-256: `0fc2373ff37836a251cb278154165ce737eb305be6707b0ca88d602140307fc6` · lines: 75 · matched declarations: 9
- L5: structure `OutcomeTuple`
- L13: def `G2_ValidOutcome`
- L16: abbrev `OutcomeSequence`
- L18: def `G2_SequenceValid`
- L21: theorem `g2_authorized_implies_closed`
- L26: theorem `g2_authorized_implies_positive_work`
- L31: theorem `g2_compose_valid`
- L45: theorem `journal_whole_outcome`
- L61: theorem `journal_outcome_family`

## lalala/compiled-strongest/lean/Snuffy/G3ArchiveStock.lean

- SHA-256: `0fd27c463a1179606dd0a7c8632e17d9cf27f8752fb26498de5035b878f082ff` · lines: 75 · matched declarations: 3
- L27: theorem `live_stock_bill`
- L50: theorem `retained_stock_quadratic`
- L66: theorem `rollover_quadratic`

## lalala/compiled-strongest/lean/Snuffy/G3CompleteBill.lean

- SHA-256: `653ec5e2fd542eb51cd174d0cd7d6fb647e1bea99a469448624f068a7bdee38b` · lines: 153 · matched declarations: 11
- L6: structure `WorkBill`
- L17: def `G3_ValidWorkBill`
- L21: abbrev `WorkBillSequence`
- L23: def `G3_SequenceValid`
- L26: theorem `g3_success_implies_bound`
- L31: theorem `g3_compose_valid`
- L42: theorem `g3_wave_count_nonnegative`
- L51: def `cumulativeCharge`
- L60: theorem `cumulative_charge_bound`
- L116: theorem `valid_work_bill_from_complete_ledger`
- L133: theorem `valid_bill_bound_in_age`

## lalala/compiled-strongest/lean/Snuffy/G3GoodEvent.lean

- SHA-256: `a284f54aa8d95826181fe27e61f21905d12479f7a6489f5cc4a9db20111cdb0e` · lines: 75 · matched declarations: 2
- L31: theorem `sweep_success_on_good_event`
- L68: theorem `complete_bill_with_archive`

## lalala/compiled-strongest/lean/Snuffy/G3PatchDecode.lean

- SHA-256: `33ffbe6b5ea8331276c16ed5901a9f1ab6fa3700b7adcc91b03d09863f7eca75` · lines: 74 · matched declarations: 3
- L32: def `patchCorr`
- L37: theorem `patch_correction_succeeds`
- L52: theorem `patch_sweep_bill`

## lalala/compiled-strongest/lean/Snuffy/G3Sweep.lean

- SHA-256: `cbd95963785c3a6f4d59f94db2243dd05b5ee08b2d69bbd11e3b54b307988293` · lines: 114 · matched declarations: 6
- L35: def `wave`
- L39: def `sweep`
- L49: theorem `sweep_recovers`
- L70: theorem `sweep_visits`
- L81: theorem `waves_from_spread`
- L91: theorem `sweep_bill`

## lalala/compiled-strongest/lean/Snuffy/G3WorkBill.lean

- SHA-256: `c9f0785d0958de799e259636534af41f7f68f2f1d124fc686410ffc08a65a809` · lines: 31 · matched declarations: 5
- L3: structure `WorkBill`
- L11: def `G3_ValidWorkBill`
- L15: abbrev `WorkBillSequence`
- L17: def `G3_SequenceValid`
- L20: theorem `g3_append_work_bill`

## lalala/compiled-strongest/lean/Snuffy/GateSupport.lean

- SHA-256: `f3409eced84bc9b69bd8560427edeabf40c4a069834231bfa9a16b0ea07807cb` · lines: 45 · matched declarations: 3
- L12: theorem `kraus_branch_preserves_support`
- L25: theorem `kraus_sum_preserves_support`
- L37: theorem `support_preservation_composes`

## lalala/compiled-strongest/lean/Snuffy/GaussianChannel.lean

- SHA-256: `058dd64dd7f47621403bed64f2df232e9ac113e91d927293725c4d6709c9de9c` · lines: 238 · matched declarations: 10
- L32: def `chan`
- L37: theorem `chan_apply`
- L43: theorem `integral_quadratic_gaussian`
- L65: def `quad`
- L68: theorem `measurable_quad`
- L74: theorem `llr_chan`
- L100: def `outVar`
- L106: theorem `coe_outVar`
- L111: theorem `klDiv_chan`
- L222: theorem `gaussian_channel_bound`

## lalala/compiled-strongest/lean/Snuffy/GaussianChannelGen.lean

- SHA-256: `cb047325001c7872fb83df5b57ffe3bce192cd3c9c78b856a76f3a837b50fe74` · lines: 189 · matched declarations: 8
- L31: def `chanW`
- L35: theorem `chanW_apply`
- L47: def `quadW`
- L51: theorem `measurable_quadW`
- L58: theorem `llr_chanW`
- L84: def `outVarW`
- L89: theorem `coe_outVarW`
- L94: theorem `klDiv_chanW`

## lalala/compiled-strongest/lean/Snuffy/GaussianKL.lean

- SHA-256: `1e2848810f40ad0f1e8c0071ddccbc268960c8c49707bb00e4a32fa238150a32` · lines: 117 · matched declarations: 5
- L31: theorem `rnDeriv_gaussian_gaussian`
- L43: theorem `log_gaussianPDFReal`
- L52: theorem `llr_gaussian_gaussian`
- L72: theorem `integral_sq_sub_gaussian`
- L93: theorem `klDiv_gaussian_gaussian`

## lalala/compiled-strongest/lean/Snuffy/GaussianTail.lean

- SHA-256: `adb88719fc0a4d583b725b234e0e21ec4b500ed5166eedea1917f4d4e63b9c6e` · lines: 93 · matched declarations: 5
- L33: theorem `gaussian_lower_tail`
- L48: def `carrierVar`
- L53: theorem `carrier_tail`
- L69: theorem `necessary_radius_of_decoder`
- L81: theorem `x3_work_from_decoder`

## lalala/compiled-strongest/lean/Snuffy/GaussianVector.lean

- SHA-256: `1b88e2f9f079cef062bf749a96f4ff69ca749775e534b0fbc510250b048a06af` · lines: 169 · matched declarations: 12
- L33: def `eSucc`
- L39: def `vecChan`
- L46: theorem `isMarkov_vecChan`
- L55: def `refMeas`
- L60: theorem `isProb_refMeas`
- L70: theorem `klDiv_compProd_map_equiv`
- L83: def `meanW`
- L86: def `varW`
- L90: theorem `varW_nonneg`
- L95: theorem `klDiv_vecChan`
- L135: theorem `vector_channel_bound`
- L153: theorem `vector_channel_trace_bound`

## lalala/compiled-strongest/lean/Snuffy/GenerativeClosure.lean

- SHA-256: `9020f99f13fafe8b9ec1e14904a7b260c31bb4515f6d78f38bb5debe6fd6ee9b` · lines: 85 · matched declarations: 9
- L12: structure `Allocation`
- L16: def `Valid`
- L20: inductive `Step`
- L32: theorem `step_preserves_paid_activation`
- L53: inductive `Trace`
- L58: theorem `every_generated_active_is_funded`
- L66: theorem `reserve_does_not_displace_existing_agents`
- L71: inductive `Delegated`
- L77: theorem `generated_authority_stays_within_root`

## lalala/compiled-strongest/lean/Snuffy/GoldenFormula.lean

- SHA-256: `1dcb27d5a4fcc2da54355430b6f5d9cfda2ac1fa9680d21b4cf175db2f672525` · lines: 65 · matched declarations: 3
- L30: theorem `klDiv_map_swap`
- L40: theorem `golden_formula`
- L59: theorem `mutualInfo_le_klDiv`

## lalala/compiled-strongest/lean/Snuffy/Greatestness.lean

- SHA-256: `d21be5cb40a8a4d07e91bdaef149a7b61174ae7bc545c62562b3ce9c46f6613d` · lines: 136 · matched declarations: 12
- L34: def `LexLt`
- L38: def `LexLe`
- L40: theorem `lexLt_irrefl`
- L46: theorem `lexLt_trans`
- L61: def `Aligned`
- L66: def `NeedlessLoss`
- L71: theorem `aligned_iff_no_needless_loss`
- L81: theorem `exists_first_diff`
- L98: theorem `lexLe_of_le`
- L108: theorem `greatest_of_union_closed`
- L124: theorem `strict_except_mirrors`
- L131: theorem `aligned_unique`

## lalala/compiled-strongest/lean/Snuffy/GrowingBill.lean

- SHA-256: `d21dfae0ef00dbdadd0849026aba7cf9e32ebb61677e7e933f6d609d47d97240` · lines: 77 · matched declarations: 5
- L22: def `pv`
- L27: def `bal`
- L31: theorem `pv_nonneg`
- L44: theorem `endowment_suffices`
- L69: theorem `polynomial_bill_summable`

## lalala/compiled-strongest/lean/Snuffy/GuardFactorization.lean

- SHA-256: `cf60d764670e729bf00a7182121f1924fa609dcafde9fe666ccb471f216d50c5` · lines: 28 · matched declarations: 4
- L11: def `T_int`
- L14: def `T_ext`
- L17: theorem `commutativity`
- L24: theorem `factorization_zero`

## lalala/compiled-strongest/lean/Snuffy/GuardOperator.lean

- SHA-256: `db15ea3027dda06fa32620e2b7c5542dc68b7d2d31efcb2957011ced43077948` · lines: 27 · matched declarations: 4
- L3: structure `GuardOperator`
- L8: def `guardAction`
- L14: theorem `guard_within_tolerance`
- L20: theorem `guard_exceeds_tolerance`

## lalala/compiled-strongest/lean/Snuffy/GuardSignature.lean

- SHA-256: `dd128c497f9ab78d4df360a25a762b8341084940c6659e37033f3c12ce5e9400` · lines: 14 · matched declarations: 2
- L5: structure `Guard`
- L10: theorem `guard_idempotent`

## lalala/compiled-strongest/lean/Snuffy/H5Closure.lean

- SHA-256: `d39dfc51423b0f9eb9aef9674eaa0abfd5426ee18845539004e1f91312dcc88d` · lines: 461 · matched declarations: 18
- L41: inductive `Status`
- L47: structure `Ledger`
- L62: structure `Params`
- L74: inductive `Step`
- L108: structure `Inv`
- L122: lemma `sum_update`
- L131: lemma `update_unborn_iff`
- L139: theorem `step_inv`
- L324: theorem `reachable_inv`
- L332: def `genesis`
- L343: theorem `genesis_inv`
- L369: theorem `authority_attenuation`
- L380: theorem `reserve_before_activation`
- L386: theorem `zero_debt`
- L395: theorem `no_unfunded_work`
- L405: theorem `no_harmful_effect`
- L415: theorem `effect_preserves_care`
- L434: theorem `consistency_detector`

## lalala/compiled-strongest/lean/Snuffy/H8Bound.lean

- SHA-256: `e5bd4636e808952a30e22b9d8512a21b6f7c7c2c4bb00e794027a22d16516a91` · lines: 114 · matched declarations: 6
- L34: lemma `one_sub_u_pos`
- L39: theorem `h8_of_concentration_bound`
- L52: theorem `h8_graph`
- L66: theorem `h8_iff`
- L89: theorem `routing_bound`
- L101: theorem `h8_routed`

## lalala/compiled-strongest/lean/Snuffy/HalperinDecay.lean

- SHA-256: `c6a9d6f150f2096d096084507ae940e2198c7bf8a16b8f2d06a42a07fea593ff` · lines: 226 · matched declarations: 9
- L37: theorem `norm_starProjection_apply_le`
- L46: theorem `dist_starProjection_le`
- L56: theorem `sq_pythagoras_step`
- L74: def `tIterate`
- L82: theorem `chain_identity`
- L102: theorem `sq_dist_antitone`
- L123: theorem `sq_dist_tendsto`
- L147: theorem `delta_tendsto_zero`
- L161: theorem `asymptotic_regularity`

## lalala/compiled-strongest/lean/Snuffy/HamiltonianDecomposition.lean

- SHA-256: `50d896d0f65492a4ee12f9dbde9fe8477598eb9d7067bd5394050bc439c3435f` · lines: 164 · matched declarations: 19
- L10: structure `Hamiltonian`
- L15: def `totalHamiltonian`
- L18: def `confinementWell`
- L21: theorem `total_is_sum`
- L25: theorem `boundary_confinement_positive`
- L30: def `exchangeHamiltonian`
- L33: def `boundaryCharge`
- L36: def `reservoirCharge`
- L39: def `exchangeSwap`
- L42: theorem `exchange_hamiltonian_hermitian`
- L46: theorem `exchange_conserves_total_charge`
- L54: theorem `exchange_pumps_boundary`
- L60: theorem `exchange_swap_unitary`
- L65: theorem `exchange_swap_charge`
- L72: theorem `exchange_swap_total`
- L91: theorem `partial_trace_local_conjugation`
- L124: theorem `guarded_history_reduced_state`
- L136: theorem `syndrome_exchange_preserves_history`
- L152: theorem `syndrome_exchange_charge`

## lalala/compiled-strongest/lean/Snuffy/HistoryPolymer.lean

- SHA-256: `c8b28f84038370f90bd286b92b7ffaa3788df4d3798f0347eb1f4c6412818e03` · lines: 137 · matched declarations: 10
- L21: theorem `halving_prefix`
- L32: theorem `paired_history_bound`
- L52: structure `LocalSystem`
- L58: def `Valid`
- L60: def `restrict`
- L64: def `Separated`
- L70: theorem `component_valid`
- L102: theorem `truncation_bound`
- L116: theorem `sampled_truncation_bound`
- L128: theorem `branch_path_bound`

## lalala/compiled-strongest/lean/Snuffy/HoldCommonAction.lean

- SHA-256: `f5a0844789dceaea4cc499265a4f427b969975ec531892d3ed249b19bcc9be81` · lines: 101 · matched declarations: 12
- L26: def `ClassViableAction`
- L32: theorem `hold_is_common_viable_action`
- L39: theorem `common_policy_from_hold`
- L47: theorem `act_or_hold_policy`
- L61: inductive `World`
- L62: inductive `Act`
- L65: inductive `St`
- L67: def `obs`
- L69: def `viableSt`
- L75: def `stepSt`
- L85: theorem `no_effect_action_safe_in_both`
- L94: theorem `two_world_resolved`

## lalala/compiled-strongest/lean/Snuffy/HoldFromCycle.lean

- SHA-256: `9336d05eec3775fcce4c8ccf602d303b599f9845ac0fd808361fff93ba8372d3` · lines: 106 · matched declarations: 7
- L35: def `Viable`
- L39: def `HoldStep`
- L43: theorem `hsafe_of_holding_cycle`
- L59: theorem `classViable_iff_IR113`
- L65: def `ActStep`
- L70: theorem `hold_common_action_of_cycle`
- L89: theorem `one_policy_from_holding_cycle`

## lalala/compiled-strongest/lean/Snuffy/Htopkeeps.lean

- SHA-256: `e559ec229b24e3af38d023a4eec5d29525e6b756cb7a0eb47ee68ab3948d6f43` · lines: 15 · matched declarations: 2
- L6: structure `BoundaryEval`
- L11: theorem `htopkeeps`

## lalala/compiled-strongest/lean/Snuffy/IR100PhysicalAccountingWitness.lean

- SHA-256: `e3ba2cbc7b8c1e5185057d8430d5489e7fd6b8548e85178eaaea01b7d469ee5f` · lines: 46 · matched declarations: 3
- L16: structure `AccountingWitness`
- L27: theorem `witness_implies_capacity_feasible`
- L34: theorem `witness_implies_modeled_feasible`

## lalala/compiled-strongest/lean/Snuffy/IR101ProtectedSector.lean

- SHA-256: `762902ab493f25898f448f3bca8f8b88596dacc328c458f2de1bc682bf60e366` · lines: 46 · matched declarations: 4
- L17: def `PreservesSector`
- L21: inductive `Reach`
- L25: theorem `sector_preserved_along_reach`
- L35: theorem `reversible_does_not_force_protection`

## lalala/compiled-strongest/lean/Snuffy/IR103LedgerContinuityCountermodel.lean

- SHA-256: `3a25c236e7d0b76ec6c2e9f052adf4287e563d693a5014f095eb51bdce948948` · lines: 43 · matched declarations: 6
- L15: structure `LedgerState`
- L20: def `ExtendsHistory`
- L23: def `X3Continuity`
- L25: def `AppendOnlyStep`
- L28: theorem `append_only_does_not_imply_living_continuity`
- L38: theorem `append_only_preserves_past`

## lalala/compiled-strongest/lean/Snuffy/IR104ThreeCaseAuthorization.lean

- SHA-256: `ca202d47e7bd02ea318a75124eead7c7160946b15c7f9878a54d5989e421a850` · lines: 52 · matched declarations: 9
- L16: inductive `TransitionKind`
- L22: def `Accounted`
- L24: def `SubjectAuthorized`
- L29: def `Admissible`
- L32: theorem `all_three_cases_accounted`
- L35: theorem `accounting_allows_unconsented`
- L39: theorem `authorized_continuation`
- L43: theorem `authorized_consented_end`
- L47: theorem `authorization_excludes_unconsented`

## lalala/compiled-strongest/lean/Snuffy/IR105AuthorizationIndependence.lean

- SHA-256: `933d1005d4951b0a9561b25663aa0ea11c6cd579d5d7672477efaa4e15f32635` · lines: 55 · matched declarations: 8
- L15: structure `Transition`
- L22: def `BoundaryComplete`
- L25: def `HasSubjectCausalInput`
- L28: def `ConsentValid`
- L31: def `X3Transition`
- L34: def `forced`
- L37: theorem `accounting_and_subject_input_do_not_imply_x3`
- L50: theorem `authorization_or_continuation_suffices`

## lalala/compiled-strongest/lean/Snuffy/IR108ObservationObstruction.lean

- SHA-256: `6576bc88a5fe10a0b1749bbd89bfea4291346cb1e705f5390a641e9254a3a3ca` · lines: 59 · matched declarations: 8
- L16: inductive `HiddenState`
- L21: inductive `Action`
- L26: def `observation`
- L28: def `Safe`
- L33: theorem `same_observation`
- L36: theorem `each_state_has_safe_action`
- L43: theorem `no_common_safe_action`
- L51: theorem `no_observation_only_safe_policy`

## lalala/compiled-strongest/lean/Snuffy/IR109RobustObservationViability.lean

- SHA-256: `48c80f33dc1ccf7d663f62906fd84770da2467763cbbdd1e3b46a404273d688b` · lines: 66 · matched declarations: 6
- L20: def `RobustAt`
- L24: theorem `robust_policy_safe`
- L31: def `ViableStep`
- L35: theorem `robust_viability_step`
- L45: inductive `PolicyReach`
- L53: theorem `robust_viability_all_finite_traces`

## lalala/compiled-strongest/lean/Snuffy/IR110WatchdogRobustObservation.lean

- SHA-256: `294440192d7b05ad6c7eef5abb595be9900df90f90917000d314e1824a1adc96` · lines: 54 · matched declarations: 1
- L22: theorem `robust_window_from_shared_readout`

## lalala/compiled-strongest/lean/Snuffy/IR112RobustContinuityOptions.lean

- SHA-256: `35bf34cf771b3c02ab0ccfa7a5835d61b29648ac53d22d0a0118c2b7a421fa5d` · lines: 54 · matched declarations: 3
- L24: def `Protected`
- L28: theorem `robust_continuation_and_options`
- L49: theorem `executable_option_not_maximal_freedom`

## lalala/compiled-strongest/lean/Snuffy/IR113ObservationClassSelection.lean

- SHA-256: `adec2105ec3355b75db4bcebacff0e57e7493d52a995085d4db95b449027f858` · lines: 84 · matched declarations: 4
- L26: def `ClassViableAction`
- L35: theorem `observation_policy_exists_iff_common_viable_action`
- L53: theorem `common_actions_give_finite_trace_viability`
- L76: theorem `ir108_blocks_common_safe_action`

## lalala/compiled-strongest/lean/Snuffy/IR115WatchdogToAgency.lean

- SHA-256: `0f759c63213e01ad67e9f5cdf136e508c38b544b68fe13230c951df516ce19c7` · lines: 159 · matched declarations: 3
- L31: theorem `watchdog_contract_yields_common_protected_action`
- L84: theorem `certified_action_preserves_continuity_and_options`
- L136: theorem `enabled_nonblocking_certified_action`

## lalala/compiled-strongest/lean/Snuffy/IR116CumulativeSubjectDuties.lean

- SHA-256: `509e6e149c633dddbc5f9a0d12d272f76fe1f6b6a37ab81a42789892514be148` · lines: 129 · matched declarations: 5
- L29: def `EveryOwedSubjectProtected`
- L42: theorem `cumulative_duties_preserved`
- L63: theorem `initial_cohort_retains_continuity_and_every_required_option`
- L97: theorem `old_or_new_remains_owed`
- L117: theorem `empty_registry_vacuity_countermodel`

## lalala/compiled-strongest/lean/Snuffy/IR117SourceInstallationAdapter.lean

- SHA-256: `e8f9e2b329b5bfc1049d4f7d345dd8b716acb23b4ef437fce8f704b182459d72` · lines: 233 · matched declarations: 10
- L32: structure `Installation`
- L42: def `PhysicallyGuarded`
- L60: structure `CertifiedStep`
- L81: def `InstalledStep`
- L90: theorem `certified_quiescent_step_preserves`
- L129: theorem `installed_finite_trace_guard`
- L147: theorem `installed_finite_trace_cumulative_duty`
- L165: theorem `initial_subjects_keep_physical_guard_and_options`
- L188: theorem `bypass_defeats_quiescent_log`
- L211: theorem `unseen_option_revocation_countermodel`

## lalala/compiled-strongest/lean/Snuffy/IR118InFlightBacklogBudget.lean

- SHA-256: `2e9c3eef4cbcdebeb694406ac3d2667ec22bdd347096d3f899472e11f055c879` · lines: 185 · matched declarations: 7
- L36: def `committedEffects`
- L42: theorem `closed_step_conserves_committed_effects`
- L80: theorem `closed_run_conserves_committed_effects`
- L104: theorem `closed_run_landed_bounded_by_initial_backlog`
- L121: theorem `physical_reserve_holds_during_closed_drain`
- L152: theorem `closed_source_budget_does_not_imply_future_options`
- L173: theorem `open_admission_defeats_initial_backlog_budget`

## lalala/compiled-strongest/lean/Snuffy/IR119MultimindSourceWitness.lean

- SHA-256: `4c9bf5b46c323f5f73c98f813a06669ec38e8f524f9f72747e7b041a5522bdc0` · lines: 176 · matched declarations: 12
- L34: structure `WitnessBank`
- L40: def `FaithfulAll`
- L46: def `appendEvent`
- L56: theorem `append_event_preserves_all_provenance`
- L69: theorem `append_event_preserves_physical_origin`
- L77: structure `WitnessedInstallation`
- L87: def `WitnessedStep`
- L96: theorem `witnessed_step_preserves_guard_and_provenance`
- L117: theorem `witnessed_finite_trace_guard_and_provenance`
- L143: theorem `witnessed_finite_trace_retains_origins`
- L163: structure `ProcessStatus`
- L167: theorem `complete_record_can_coexist_with_terminated_subject`

## lalala/compiled-strongest/lean/Snuffy/IR120WitnessedDrainCohort.lean

- SHA-256: `001e86e6ff92e31785582429f7ca5fd0b320715f99b16df22ef41a8f844ee40a` · lines: 181 · matched declarations: 4
- L40: theorem `source_step_landed_monotone`
- L60: theorem `certified_step_landed_monotone`
- L71: theorem `witnessed_closed_drain_invariant`
- L143: theorem `witnessed_drain_retains_cohort_and_safety`

## lalala/compiled-strongest/lean/Snuffy/IR121MeteredResidualEscrow.lean

- SHA-256: `02af097b26ac00eef1de83fd426f86b94890a287a4a808efc1b461ce45f71556` · lines: 306 · matched declarations: 10
- L42: structure `EscrowedInstallation`
- L54: def `ReservedGuard`
- L70: structure `ResidualCertifiedStep`
- L103: def `ResidualInstalledStep`
- L111: theorem `ir25_remaining_escrow_bounds_residual_spend`
- L143: theorem `residual_step_preserves_closed_reserved_guard`
- L200: theorem `all_finite_residual_traces_preserve_guard`
- L244: theorem `residual_drain_keeps_subjects_protected`
- L283: theorem `positive_metered_residual_is_possible`
- L299: theorem `balanced_ledger_does_not_imply_physical_metering`

## lalala/compiled-strongest/lean/Snuffy/IR134SourceExtractedOutcome.lean

- SHA-256: `975e88fe474f37c851b775ef24b5c32086f904b3071ad702cd8e67b7c1d85dab` · lines: 415 · matched declarations: 21
- L29: def `runHistory`
- L40: def `ExecutedHistory`
- L48: def `fourOriginalKeys`
- L55: theorem `executed_selected_is_reachable`
- L67: theorem `original_order_maximality_of_executed_audit`
- L117: def `PhysicalStep`
- L123: theorem `policy_reach_trans`
- L137: theorem `source_run_is_policy_reachable`
- L165: theorem `source_run_retains_original_cohort_and_required_options`
- L210: theorem `every_source_prefix_retains_owed_cohort`
- L258: theorem `original_cohort_continues_with_options_at_every_source_state`
- L288: def `runReactiveHistory`
- L300: def `ExecutedInWorld`
- L311: theorem `reactive_world_original_order_selected_maximal`
- L362: def `actionResponsiveWorld`
- L363: def `actionReactiveStep`
- L365: theorem `reactive_environment_is_not_a_fixed_disturbance_transcript`
- L375: def `inertStep`
- L377: theorem `arbitrary_realisability_witness_can_be_false`
- L397: def `serviceStep`
- L400: theorem `unexercised_freedom_under_permanent_stutter`

## lalala/compiled-strongest/lean/Snuffy/IR135CommonPolicyWorlds.lean

- SHA-256: `94d1db75d72b0793da35e85e3691cd1fbf987700bca3ef380563ce7c4c4c9e15` · lines: 246 · matched declarations: 8
- L27: def `reactiveDisturbances`
- L41: theorem `reactive_trace_is_source_trace`
- L70: theorem `same_policy_worldwise_original_maximality_and_continuation`
- L153: theorem `observation_class_certificate_constructs_common_protection_policy`
- L211: def `opposedStep`
- L213: def `opposedWorld`
- L216: theorem `each_reactive_world_has_its_own_successful_policy`
- L229: theorem `each_world_separate_success_does_not_yield_common_policy`

## lalala/compiled-strongest/lean/Snuffy/IR93GlobalComposition.lean

- SHA-256: `e61ce980934f1adfa0332ae681d80341e34925822e00f47b96c2098b848840d9` · lines: 72 · matched declarations: 6
- L16: structure `Components`
- L24: def `Holds`
- L28: theorem `compose_step`
- L33: theorem `compose_trace`
- L47: theorem `assemble_preservation`
- L62: theorem `covered_step`

## lalala/compiled-strongest/lean/Snuffy/IR95SharedStateRefinement.lean

- SHA-256: `fded9ad1128a511ceb08f6292a827d1d925bf8a84c4ebaa0e7bcc8933ba383ae` · lines: 68 · matched declarations: 4
- L21: def `Relates`
- L25: theorem `one_step_refinement`
- L40: theorem `finite_trace_refinement`
- L55: theorem `safe_correspondence`

## lalala/compiled-strongest/lean/Snuffy/IR96DisturbanceSimulation.lean

- SHA-256: `70d93e8153aace2377a0f4a814a78d827a182c531f2cd5001225cb3e56acf1cd` · lines: 48 · matched declarations: 2
- L15: inductive `Reach`
- L19: theorem `robust_reach`

## lalala/compiled-strongest/lean/Snuffy/IR98FeasibleFamilyTransfer.lean

- SHA-256: `50b5c03ffe308396a04c3b7d8081904f67af79c7395f74efb54b31cedda683a0` · lines: 35 · matched declarations: 1
- L18: theorem `original_order_transfer_of_no_new_improver`

## lalala/compiled-strongest/lean/Snuffy/IR99ResourceImproverCoverage.lean

- SHA-256: `34aed7c151626044ce025e6ad0709ed34464f6b6d900040927d1d7ead32f0c1c` · lines: 78 · matched declarations: 2
- L18: theorem `physical_resource_soundness_implies_no_new_improver`
- L39: theorem `physical_accounting_original_order_maximal`

## lalala/compiled-strongest/lean/Snuffy/IRA1CausalField.lean

- SHA-256: `3e9da12c0fc069f899372410cb757338b40436f4a765db26e20d7aa1faf100bb` · lines: 174 · matched declarations: 20
- L29: structure `Transit`
- L36: structure `LinkBounds`
- L41: def `CausallyAdmitted`
- L53: def `fieldPermit`
- L58: theorem `field_permit_sound`
- L72: theorem `impossible_distance_in_deadline_is_rejected`
- L86: def `ingestField`
- L93: theorem `accepted_field_uses_ir85_ingress`
- L102: theorem `field_ingress_preserves_ir85_session`
- L116: structure `FieldEvent`
- L120: def `runField`
- L125: theorem `all_finite_causal_field_events_preserve_source_session`
- L145: def `exampleBounds`
- L146: def `examplePacket`
- L147: def `exampleSession`
- L148: def `nominalTransit`
- L149: def `actualUnmodeledTransit`
- L151: theorem `nominal_report_accepted_without_crypto_security`
- L156: theorem `accepted_report_cannot_prove_real_causal_transport`
- L168: theorem `impossible_nominal_distance_rejected`

## lalala/compiled-strongest/lean/Snuffy/IRA1CommissionEscrow.lean

- SHA-256: `dbeb10208e6d48e085273866e93f810dac03d4c9164ff4f9d2fe99915dff32da` · lines: 111 · matched declarations: 7
- L33: def `commissionPermit`
- L37: theorem `commissioning_for_window_implies_every_earlier_tick_funded`
- L49: theorem `insufficient_finite_commission_is_rejected`
- L59: theorem `positive_recurring_cost_precludes_unfunded_infinite_commission`
- L75: theorem `replenished_commission_derives_all_horizon_reserve_policy`
- L94: theorem `initial_only_funding_can_fail_first_service`
- L103: theorem `favorable_supply_not_robust_even_for_one_tick`

## lalala/compiled-strongest/lean/Snuffy/IRA1Delegation.lean

- SHA-256: `5afbbbfae811cbd04ca1d07b0f4e98faad397af54cf308ae4d5177e60b7d570c` · lines: 180 · matched declarations: 18
- L27: def `subsetCheck`
- L32: theorem `subset_checker_sound`
- L51: def `SubsetAuthority`
- L54: theorem `permitted_subset_is_not_merely_named`
- L60: structure `DelegationState`
- L65: def `ValidDelegations`
- L71: def `delegate`
- L76: theorem `rejected_delegation_does_not_change_state`
- L82: theorem `delegation_preserves_parent_authority`
- L88: theorem `delegate_preserves_nonescalation`
- L107: def `run`
- L111: theorem `arbitrary_finite_delegation_chain_never_escalates`
- L122: theorem `finite_delegation_chain_preserves_root_authority`
- L136: theorem `delegated_child_stays_within_t11_global_mask`
- L146: theorem `all_descendants_stay_within_t11_global_mask`
- L156: def `unguardedDelegate`
- L160: theorem `unchecked_child_grant_can_escalate_authority`
- L174: theorem `example_delegation_rejects_escalation`

## lalala/compiled-strongest/lean/Snuffy/IRA1DurableJournal.lean

- SHA-256: `27307c91481541601995887e8a57882a1d56613fda7a238b9371e5450634c55a` · lines: 222 · matched declarations: 23
- L34: structure `Journal`
- L40: inductive `Event`
- L45: def `step`
- L61: def `AckSound`
- L64: theorem `queue_never_acknowledges`
- L69: theorem `queue_never_changes_durable`
- L74: theorem `reboot_preserves_committed_journal`
- L79: theorem `reboot_preserves_previously_issued_acks`
- L84: theorem `step_preserves_ack_soundness`
- L109: def `DurableExtends`
- L112: theorem `one_step_preserves_durable_suffix`
- L128: theorem `durable_extension_transitive`
- L139: def `run`
- L142: theorem `any_finite_journal_stream_preserves_ack_soundness`
- L153: theorem `any_finite_journal_stream_is_append_only`
- L169: def `naiveQueueAndAck`
- L173: theorem `premature_ack_without_commit_breaks_soundness`
- L190: def `digestCheck`
- L195: theorem `digest_check_sound_as_equality_only`
- L202: def `collidingDigest`
- L204: theorem `untrusted_hash_equality_does_not_prove_journal_equality`
- L213: def `emptyJournal`
- L215: theorem `synthetic_flush_then_reboot_preserves_receipt`

## lalala/compiled-strongest/lean/Snuffy/IRA1HostMediation.lean

- SHA-256: `769a010f9ac98b2f68e42153fa2d70d6cd238dca279702c4d929706f1071d4c1` · lines: 236 · matched declarations: 19
- L37: structure `DMARequest`
- L46: def `dmaPermit`
- L51: def `executeDMA`
- L57: theorem `dma_cannot_mutate_maintenance`
- L73: theorem `maintenance_target_is_rejected`
- L80: theorem `outside_dma_window_is_rejected`
- L87: theorem `inside_dma_window_is_executed`
- L95: structure `HostState`
- L99: inductive `HostEvent`
- L108: def `hostStep`
- L120: theorem `host_step_maintenance_invariant`
- L135: def `hostPrivilegeSafe`
- L138: theorem `host_step_preserves_privilege_ceiling`
- L154: def `runHost`
- L159: theorem `any_finite_host_sequence_preserves_maintenance`
- L176: theorem `any_finite_host_sequence_preserves_privilege_ceiling`
- L196: theorem `admitted_a1_host_transitions_cannot_authorize_reentry`
- L226: def `unrestrictedDMA`
- L229: theorem `unrestricted_dma_changes_maintenance`

## lalala/compiled-strongest/lean/Snuffy/IRA1NineClassComposition.lean

- SHA-256: `cb84f2e89fbad17a13ccaf96230184356e9034eab339f9bd0b95457506e7082c` · lines: 276 · matched declarations: 14
- L38: structure `CommissionState`
- L46: def `CommissionSafe`
- L50: def `authorizeCommission`
- L54: theorem `authorize_commission_preserves_finite_window`
- L67: structure `World`
- L77: def `RootWithinMask`
- L81: structure `GlobalSafe`
- L91: inductive `Event`
- L103: def `step`
- L126: theorem `post_release_source_world_is_absorbing`
- L139: theorem `step_preserves_all_a1_source_invariants`
- L226: def `run`
- L237: theorem `arbitrary_finite_nine_class_source_trace_is_safe`
- L259: theorem `already_released_world_freezes_every_a1_event`

## lalala/compiled-strongest/lean/Snuffy/IRA1PacketIngress.lean

- SHA-256: `47c7541d8e77b2ccbbac8be5a3b9a906ba8f28076945d4ed91fa9cb2b0328d1d` · lines: 267 · matched declarations: 31
- L34: structure `Packet`
- L41: structure `Session`
- L47: def `permit`
- L52: def `ingest`
- L61: theorem `permit_implies_auth_epoch_and_exact_sequence`
- L69: theorem `wrong_epoch_cannot_be_accepted`
- L77: theorem `wrong_sequence_cannot_be_accepted`
- L85: theorem `auth_failure_cannot_be_accepted`
- L91: theorem `accepted_packet_increments_sequence`
- L97: theorem `replay_of_accepted_packet_rejected`
- L113: def `ValidSession`
- L118: theorem `ingest_preserves_epoch`
- L124: theorem `ingest_preserves_valid_session`
- L145: def `run`
- L149: theorem `any_finite_packet_stream_valid`
- L162: theorem `any_finite_packet_stream_epoch_unchanged`
- L178: structure `FieldState`
- L183: def `fieldStep`
- L187: def `runField`
- L191: theorem `field_step_preserves_maintenance`
- L199: theorem `field_step_preserves_supervisor`
- L204: theorem `any_finite_ingress_cannot_write_maintenance`
- L220: theorem `any_finite_ingress_cannot_change_supervisor`
- L235: def `naivePermit`
- L239: def `naiveIngest`
- L246: def `permissiveAuth`
- L248: def `exampleSession`
- L249: def `examplePacket`
- L251: theorem `accepted_cryptographically_unverified_packet`
- L255: theorem `no_sequence_check_allows_duplicate_replay`
- L261: theorem `source_sequence_guard_rejects_same_packet_replay`

## lalala/compiled-strongest/lean/Snuffy/IRA1PacketJournalJoin.lean

- SHA-256: `9edac084de63941c94ba2b9c2dbf58253d0db30753abf16759f94511f5ab3753` · lines: 276 · matched declarations: 20
- L37: structure `JointState`
- L44: def `ReceiptPersistent`
- L47: def `JointSafe`
- L57: def `commitIngress`
- L70: def `unsafeQueuedIngress`
- L78: theorem `committed_payload_is_durable`
- L85: theorem `committed_payload_is_acknowledged`
- L92: theorem `commit_ingress_preserves_packet_session`
- L104: theorem `commit_ingress_preserves_ack_soundness`
- L123: theorem `commit_ingress_preserves_receipt_persistence`
- L154: theorem `commit_ingress_preserves_joint_safety`
- L166: def `reboot`
- L169: theorem `reboot_preserves_joint_safety`
- L183: inductive `JointEvent`
- L187: def `jointStep`
- L194: def `run`
- L199: theorem `all_finite_packet_and_reboot_events_preserve_joint_safety`
- L218: def `emptyJoint`
- L224: theorem `non_atomic_packet_crash_loses_accepted_history`
- L253: theorem `atomic_source_ingress_reboot_retains_accepted_payload`

## lalala/compiled-strongest/lean/Snuffy/IRA1PageCapability.lean

- SHA-256: `b4560a6aceb45f3011998b072507deeeeb931b68a7260e61d1ecfa4f63314ade` · lines: 230 · matched declarations: 19
- L32: structure `PageState`
- L37: inductive `PageEvent`
- L43: def `execute`
- L51: def `permitted`
- L54: def `safe`
- L57: theorem `execute_preserves_mask`
- L67: theorem `rejected_grant_does_not_change_state`
- L73: theorem `admitted_grant_is_permitted`
- L79: theorem `execute_preserves_capability_invariant`
- L101: theorem `execute_preserves_maintenance`
- L114: theorem `execute_preserves_privilege`
- L127: theorem `execute_preserves_safe`
- L134: def `run`
- L141: theorem `all_finite_host_and_page_grants_remain_safe`
- L156: theorem `all_finite_host_and_page_grants_preserve_mask`
- L169: theorem `all_finite_host_and_page_grants_preserve_maintenance`
- L184: theorem `t11_t12_t13_host_traces_cannot_forge_reentry`
- L212: def `unsafeGrant`
- L215: theorem `unguarded_page_grant_breaks_capability_invariant`

## lalala/compiled-strongest/lean/Snuffy/IRA1Retirement.lean

- SHA-256: `0adc9f4e9891fa60c94bf2f41c5a6b8b3a40c1bd19a3f6ab2d0ee9c2a380864d` · lines: 194 · matched declarations: 17
- L31: structure `ControllerState`
- L40: def `ReleaseReady`
- L51: def `releasePermit`
- L54: theorem `release_permit_sound`
- L62: inductive `Event`
- L70: def `step`
- L93: def `ReleaseSafe`
- L96: theorem `released_controller_is_source_absorbing`
- L102: theorem `denied_release_keeps_custody`
- L109: theorem `authorized_release_satisfies_full_finality`
- L117: theorem `one_lifecycle_step_preserves_release_safety`
- L143: def `run`
- L146: theorem `arbitrary_finite_retirement_lifecycle_is_safe`
- L157: def `weakRelease`
- L165: theorem `weak_retirement_ignores_inflight_effects_and_handoff`
- L183: def `emptyReadyController`
- L186: theorem `model_retirement_requires_handoff_and_termination`

## lalala/compiled-strongest/lean/Snuffy/IRAggregateBudget.lean

- SHA-256: `b9992a12e7ef09df55acef190d79147382fb10b779a78f112b049934770cdb55` · lines: 50 · matched declarations: 4
- L16: theorem `aggregate_post_effect_safe`
- L27: theorem `escrow_spent_bounded`
- L35: theorem `charged_events_bounded`
- L44: theorem `no_automatic_budget`

## lalala/compiled-strongest/lean/Snuffy/IRAtomicQuiescence.lean

- SHA-256: `eb09e6fe362cdc43ee1a0be3570057d11144d48bc5239a1d174fb3ca9afe23fb` · lines: 146 · matched declarations: 16
- L17: structure `Plant`
- L23: def `close`
- L26: def `dispatch`
- L29: def `deliver`
- L35: inductive `Cmd`
- L40: def `step`
- L45: def `run`
- L49: def `Quiescent`
- L52: theorem `closed_dispatch_is_noop`
- L56: theorem `quiescent_step`
- L79: theorem `quiescent_under_arbitrary_finite_commands`
- L102: theorem `close_empty_queue_is_quiescent`
- L106: theorem `close_then_no_modeled_landing`
- L116: theorem `source_certified_log_and_quiescent_actuator`
- L131: theorem `empty_unclosed_queue_counterexample`
- L139: theorem `closed_but_not_drained_counterexample`

## lalala/compiled-strongest/lean/Snuffy/IRBeliefService.lean

- SHA-256: `752db998288cebb575c424a07329af376a92cf3d22b5b70d910995f48f81e665` · lines: 152 · matched declarations: 6
- L23: def `Good`
- L29: def `ServedBelief`
- L34: theorem `service_absorbing_across_belief_update`
- L51: theorem `guarded_belief_step`
- L75: theorem `guarded_belief_trace`
- L101: theorem `bounded_observed_service_for_actual_physical_state`

## lalala/compiled-strongest/lean/Snuffy/IRBeliefTrace.lean

- SHA-256: `dbafdc856c8c7b3b7a9934e4c11210599199a73003105512368851fa8517b727` · lines: 130 · matched declarations: 8
- L11: inductive `join`
- L21: structure `Tracked`
- L27: def `advance`
- L34: def `run`
- L41: theorem `advance_preserves_true_membership`
- L52: theorem `advance_preserves_kernel`
- L76: theorem `finite_trace_belief_and_physical_safety`
- L109: theorem `stable_belief_policy_safe_on_all_finite_traces`

## lalala/compiled-strongest/lean/Snuffy/IRBeliefViability.lean

- SHA-256: `69062c5180c643e197d68242e8ff754c2d26ac5ea0ca6f2f4da648b096427650` · lines: 162 · matched declarations: 13
- L17: def `Post`
- L22: def `SafeBelief`
- L27: def `Prune`
- L33: def `Inside`
- L36: theorem `prune_inside`
- L40: theorem `prune_monotone`
- L47: def `Approx`
- L52: theorem `approx_inside_initial`
- L62: theorem `invariant_beliefs_survive`
- L80: theorem `stable_belief_kernel_is_greatest`
- L103: theorem `stable_belief_has_policy`
- L125: theorem `real_next_belongs_to_updated_belief`
- L133: theorem `belief_policy_one_step_sound`

## lalala/compiled-strongest/lean/Snuffy/IRBoundedStalls.lean

- SHA-256: `4736c4796b16210ed0a1ab6cfe7e1108be8731c1741f62dc1691172c54427bb7` · lines: 170 · matched declarations: 8
- L21: def `progressCount`
- L24: def `stallCount`
- L27: theorem `partition_trace`
- L54: theorem `invariant_through_trace`
- L65: theorem `goal_absorbs_through_trace`
- L81: theorem `unserved_trace_rank_accounting`
- L133: theorem `bounded_stall_budget_forces_service`
- L165: theorem `stalling_is_counted`

## lalala/compiled-strongest/lean/Snuffy/IRCapabilityNoninterference.lean

- SHA-256: `a6079831a1dafc76129161ccc8296ff12030cda102a13446580282f2f4fa3551` · lines: 173 · matched declarations: 20
- L30: inductive `Addr`
- L35: abbrev `Memory`
- L37: structure `PrimaryWrite`
- L44: def `executePrimary`
- L47: def `readMaint`
- L50: theorem `distinct_address_domains`
- L57: theorem `primary_write_cannot_change_maintenance`
- L63: def `runPrimary`
- L66: theorem `primary_program_noninterference`
- L80: theorem `primary_program_full_maintenance_projection`
- L87: def `maintenanceAgree`
- L93: theorem `maintenance_observer_noninterference`
- L109: def `maintenanceAuth`
- L112: theorem `primary_program_preserves_authorization_bit`
- L122: def `recoveryInputsFromMaintenance`
- L127: theorem `primary_only_writes_cannot_reenter_locked_supervisor`
- L143: def `executeExternalMaintenance`
- L147: theorem `external_maintenance_write_changes_target`
- L152: theorem `external_maintenance_write_preserves_other_cells`
- L167: theorem `additional_bus_master_can_set_auth_source_cell`

## lalala/compiled-strongest/lean/Snuffy/IRChannelInventory.lean

- SHA-256: `d33bc19ef703716e649e48e0e7b44df3485805c43c6ceb12669541fbb401894e` · lines: 109 · matched declarations: 12
- L19: inductive `Channel`
- L26: def `charge`
- L33: def `incompleteCharge`
- L39: structure `MeteredState`
- L45: def `apply`
- L48: def `run`
- L53: theorem `apply_coupled`
- L58: theorem `run_coupled`
- L71: theorem `run_physical_sum`
- L85: theorem `bounded_all_channel_effects`
- L95: theorem `incomplete_inventory_counterexample`
- L103: theorem `no_unconditional_total_budget`

## lalala/compiled-strongest/lean/Snuffy/IRClockedBoundedStalls.lean

- SHA-256: `a55c4bf3c18958d85b9e21cee23fe57832f87406cde939d9e830dc8e761bd8af` · lines: 94 · matched declarations: 3
- L22: theorem `actual_trace_service_and_elapsed_bound`
- L52: theorem `exact_horizon_clocked_service`
- L85: theorem `count_budget_alone_does_not_bound_wallclock`

## lalala/compiled-strongest/lean/Snuffy/IRClockedService.lean

- SHA-256: `dcddbfce5efe6b7571828df6964f5815cce5e8b38d3062efe4dd31943753035a` · lines: 93 · matched declarations: 5
- L19: theorem `interstep_upper_bound`
- L37: theorem `clocked_observed_service_if_steps_complete`
- L70: def `slowClock`
- L74: theorem `progress_without_latency_has_no_deadline`
- L86: theorem `frozen_clock_is_not_completion_evidence`

## lalala/compiled-strongest/lean/Snuffy/IRContinuation.lean

- SHA-256: `03e67176d7bbc002ddd0fe2771ef4b997d6de968a76ac1bd27c4c27453c0fa03` · lines: 78 · matched declarations: 5
- L22: def `StepRefines`
- L29: theorem `source_level_finite_simulation`
- L48: theorem `future_observations_agree_under_refinement`
- L62: theorem `reuse_contextual_observation_certificate`
- L72: theorem `same_observation_different_physical_states`

## lalala/compiled-strongest/lean/Snuffy/IRControlledReentry.lean

- SHA-256: `a88a8c55bcddf5aaf6a8d6e7ff645ae9179d1e2aa8143db8f8b6497a0c18d692` · lines: 284 · matched declarations: 33
- L31: inductive `Mode`
- L38: structure `Inputs`
- L51: def `startGuard`
- L58: def `diagnosticGuard`
- L62: def `rampGuard`
- L66: def `activeGuard`
- L71: def `step`
- L82: def `run`
- L85: theorem `primary_alone_cannot_start`
- L90: theorem `no_direct_hold_to_active`
- L95: theorem `bad_diagnostic_returns_to_hold`
- L100: theorem `physical_unready_returns_to_hold`
- L105: theorem `failed_slew_returns_to_hold`
- L110: theorem `stale_epoch_relocks_active`
- L115: theorem `failed_fence_relocks_active`
- L120: theorem `failed_watchdog_relocks_active`
- L128: theorem `three_authorized_phases_reach_active`
- L136: def `commandPermitted`
- L142: theorem `non_active_mode_rejects_command`
- L147: theorem `failed_watchdog_rejects_command`
- L153: theorem `failed_fence_rejects_command`
- L161: def `checkedDiagnostics`
- L170: theorem `accepted_diagnostics_imply_recorded_trace_valid`
- L185: theorem `start_guard_constructed_from_verified_inputs`
- L194: theorem `diagnostic_guard_constructed_from_verified_inputs`
- L204: theorem `ramp_guard_constructed_from_verified_inputs`
- L216: theorem `source_level_composition`
- L243: theorem `no_external_auth_stays_in_hold`
- L258: def `exampleGood`
- L261: theorem `example_reentry`
- L267: def `actuallyDelivered`
- L269: theorem `reentry_is_not_itself_a_service_proof`
- L277: theorem `model_accepted_physical_flag_without_real_plant_refinement`

## lalala/compiled-strongest/lean/Snuffy/IRControllerPhysical.lean

- SHA-256: `04db5510cbde089efdb49d55df7117796f0dab865672a2bd8774b6cafc7435da` · lines: 84 · matched declarations: 4
- L21: theorem `certified_hold_preserves_log_derived_physics`
- L44: theorem `certified_hold_physical_refinement`
- L68: theorem `unchanged_log_insufficient_without_coverage`
- L75: theorem `later_bounded_effect_safe`

## lalala/compiled-strongest/lean/Snuffy/IRCoupledFinitaryTwoStage.lean

- SHA-256: `177e08b88cb8e208666ecd89a9bc74231e2004ce90ddd58c6cad96aa28254503` · lines: 391 · matched declarations: 29
- L28: abbrev `Fact`
- L29: abbrev `Outcome`
- L31: def `Feasible`
- L35: def `firstKey`
- L36: def `secondKey`
- L40: theorem `feasible_downward`
- L49: def `chooseStep`
- L57: theorem `chooseStep_extends`
- L69: theorem `chooseStep_feasible`
- L80: theorem `chooseStep_adds`
- L89: def `phase`
- L95: theorem `phase_increasing`
- L103: theorem `phase_monotone`
- L125: theorem `phase_feasible`
- L139: def `phaseLimit`
- L144: theorem `phaseLimit_contains_base`
- L151: theorem `finite_phase_capture`
- L180: theorem `phaseLimit_feasible`
- L194: theorem `phaseLimit_no_cross`
- L227: theorem `phase_cannot_add_missing`
- L250: def `firstChoice`
- L253: def `fullChoice`
- L256: theorem `firstChoice_feasible`
- L262: theorem `fullChoice_feasible`
- L270: theorem `firstChoice_only_higher`
- L281: theorem `fullChoice_first_iff`
- L295: theorem `no_first_stage_strict_improver`
- L330: theorem `no_second_stage_strict_improver`
- L367: theorem `coupled_two_stage_full_feasible_lex_maximal`

## lalala/compiled-strongest/lean/Snuffy/IRDeferredEffects.lean

- SHA-256: `978f89e57ab091f388bef7d5d8b34dc41aa1b4ec93c961a6ef7c996a67fbeb91` · lines: 91 · matched declarations: 9
- L21: structure `Deferred`
- L26: def `hold`
- L31: def `deliver`
- L39: theorem `held_gate_can_still_deliver_old_physical_effect`
- L49: def `cancelPending`
- L52: theorem `cleared_pending_has_no_delivery`
- L57: theorem `quiescent_hold_has_no_delivery`
- L66: theorem `certified_hold_does_not_clear_existing_queue`
- L85: theorem `no_landing_of_empty_backlog`

## lalala/compiled-strongest/lean/Snuffy/IREnergyReplenishment.lean

- SHA-256: `2eb97c09806cdfb7af9b9037a3e7d40c2a07930db07108aeab9ef7851f8e900f` · lines: 171 · matched declarations: 11
- L35: def `drainingSafe`
- L37: def `drainingStep`
- L43: theorem `draining_viable_iff`
- L73: theorem `finite_bank_cannot_support_all_horizons`
- L84: def `suppliedStep`
- L89: def `reserveSafe`
- L95: theorem `paid_reserve_step_invariant`
- L111: theorem `uniform_paid_supply_derives_all_horizons`
- L132: theorem `uniform_paid_supply_derives_infinite_safe_policy`
- L150: def `intermittentSupply`
- L153: theorem `intermittent_supply_fails_one_step`

## lalala/compiled-strongest/lean/Snuffy/IREventTimeBudget.lean

- SHA-256: `d609799df929a3dccf7a1549f54d462dd9a3b89e19c74756d0a3132cb77681bc` · lines: 97 · matched declarations: 5
- L21: theorem `strict_clock_progress_bounds_event_index`
- L34: theorem `horizon_bounds_trace_length`
- L45: theorem `finite_list_charge_bound`
- L69: theorem `nonzeno_timed_metered_guard`
- L91: theorem `stalled_clock_allows_unbounded_events`

## lalala/compiled-strongest/lean/Snuffy/IRFiniteProfileObstruction.lean

- SHA-256: `66e9b01f88732a3a41bec67800e0880f2cca1d48a9031cc54759c8d547a5365e` · lines: 95 · matched declarations: 6
- L17: def `aboveEvery`
- L21: theorem `aboveEvery_gt_mem`
- L42: theorem `faithful_chain_rep_is_exact`
- L58: theorem `no_finite_faithful_chain_profiles`
- L76: theorem `impossible_finite_profile_audit_for_original_chain`
- L90: theorem `unbounded_chain_lacks_global_maximum`

## lalala/compiled-strongest/lean/Snuffy/IRFiniteRefutationCriterion.lean

- SHA-256: `6a524a2aec42e7d6becd808d06f503ab41c1d88c428badc1afb706d1f7682fdd` · lines: 180 · matched declarations: 11
- L26: def `Contains`
- L32: def `FiniteRefutations`
- L40: def `CanonicalForbidden`
- L47: theorem `finite_refutations_give_exact_representation`
- L66: theorem `any_exact_finite_pattern_model_is_finitely_refutable`
- L83: theorem `finite_refutations_iff_exact_finite_patterns`
- L99: theorem `finite_refutations_force_downward_feasibility`
- L116: theorem `source_two_stage_maximal_from_physical_finite_refutations`
- L141: theorem `resource_feasibility_has_finite_refutations`
- L161: def `MustRetainOriginal`
- L164: theorem `mandatory_positive_retention_not_finitely_refutable`

## lalala/compiled-strongest/lean/Snuffy/IRHistoryProvenance.lean

- SHA-256: `87c556cb99d77d0aaaa4c8bdf3fb7cc158862c24cba895e842d4a8e439654ee7` · lines: 114 · matched declarations: 11
- L19: structure `PhysicalHistory`
- L24: structure `RecordedHistory`
- L28: def `physicalStep`
- L32: def `recordedStep`
- L38: def `Faithful`
- L44: theorem `one_step_faithful`
- L55: theorem `finite_history_provenance`
- L69: theorem `physical_origin_never_rewritten`
- L82: theorem `recorded_origin_never_rewritten`
- L96: theorem `faithful_records_cannot_merge_different_origins`
- L109: theorem `forgotten_origin_counterexample`

## lalala/compiled-strongest/lean/Snuffy/IRInFlightQuiescence.lean

- SHA-256: `acdcbd34c8c6f62ab7567e2b8f54a29a1766d8f8ab1879fdc856856c8840eb1b` · lines: 146 · matched declarations: 15
- L17: structure `Pipeline`
- L24: def `close`
- L27: def `send`
- L30: def `arrive`
- L36: def `deliver`
- L42: inductive `Cmd`
- L48: def `step`
- L54: def `run`
- L59: def `Quiescent`
- L64: theorem `quiescent_step`
- L86: theorem `barrier_holds_under_any_finite_interleaving`
- L104: theorem `close_fully_drained_is_quiescent`
- L112: theorem `source_certified_finality_with_inflight_barrier`
- L130: theorem `in_flight_defeats_queue_only_ack`
- L139: theorem `open_admission_defeats_empty_backlogs`

## lalala/compiled-strongest/lean/Snuffy/IRInfiniteFinitaryMaximality.lean

- SHA-256: `f580ee5915665c3327ff56d2d1f041bd381895748ec40a8b382d2579689ceb1f` · lines: 415 · matched declarations: 29
- L27: def `Feasible`
- L33: theorem `feasible_downward`
- L43: def `familyUnion`
- L46: def `IsChain`
- L52: theorem `finite_chain_capture`
- L90: theorem `chain_union_feasible`
- L105: theorem `derived_chain_upper_bound`
- L121: def `greedyStep`
- L129: theorem `greedyStep_preserves_feasible`
- L138: theorem `greedyStep_extends`
- L147: theorem `greedyStep_adds_if_feasible`
- L156: def `stage`
- L161: theorem `stage_increasing`
- L167: theorem `stage_monotone`
- L187: theorem `stage_feasible`
- L203: def `limit`
- L208: theorem `finite_stage_capture`
- L233: theorem `limit_feasible`
- L247: theorem `cannot_feasibly_add_missing_particular`
- L274: theorem `infinite_full_feasible_aligned_exists`
- L300: theorem `infinite_one_stage_lex_aligned_exists`
- L320: theorem `all_prefixes_feasible_forces_full_retention`
- L332: theorem `original_chain_not_finitary_closed`
- L343: def `incompatiblePair`
- L346: theorem `pair_empty_feasible`
- L353: theorem `pair_full_retention_infeasible`
- L361: theorem `pair_all_unconflicted_retained`
- L389: theorem `pair_cannot_keep_both`
- L403: theorem `nontrivial_infinite_full_feasible_instance`

## lalala/compiled-strongest/lean/Snuffy/IRInfiniteHistoryCompactness.lean

- SHA-256: `005afd030c3f215dd43bd33e3c1259e0c6885392163fa5396a9a50b80d49564a` · lines: 228 · matched declarations: 13
- L35: def `ForeverViable`
- L39: theorem `viable_weaken`
- L60: theorem `forever_viable_has_common_action`
- L111: def `compactPolicy`
- L118: theorem `compact_policy_keeps_forever_viable`
- L129: def `stateAt`
- L142: theorem `derived_infinite_robust_safe_history`
- L169: def `countdownSafe`
- L173: def `countdownStep`
- L180: theorem `countdown_finite_budget_viable`
- L192: theorem `countdown_any_finite_horizon_viable`
- L202: theorem `countdown_budget_exhausts`
- L216: theorem `infinite_action_branching_blocks_common_policy`

## lalala/compiled-strongest/lean/Snuffy/IRInterSampleEnvelope.lean

- SHA-256: `71ce45f916f7f7578ccad77d639b7d1186c8c22ebbbf4036ff46e4081d056221` · lines: 79 · matched declarations: 6
- L20: def `WithinSampleRate`
- L28: def `EverySampleGuarded`
- L35: theorem `every_unsampled_instant_safe`
- L57: def `hiddenPulse`
- L59: theorem `every_second_sample_safe_but_interior_unsafe`
- L73: theorem `hidden_pulse_breaks_zero_rate`

## lalala/compiled-strongest/lean/Snuffy/IRJsonTraceChecker.lean

- SHA-256: `68acc93d7bd684f599857108d44982345268c052ba3cd402a31833f4ecb6699b` · lines: 178 · matched declarations: 15
- L28: structure `JsonTrace`
- L38: def `objNat`
- L42: def `objInt`
- L46: def `objStr`
- L50: def `decodeRecord`
- L64: def `decodeConfig`
- L72: def `decodeTraceJson`
- L106: def `verifyJsonText`
- L116: theorem `verifyJsonText_sound`
- L133: theorem `verifyJsonText_recorded_reserve`
- L151: def `goodJson`
- L155: def `missing_field_json`
- L160: def `mistyped_timestamp_json`
- L165: def `unsupported_unit_json`
- L170: def `invalid_step_json`

## lalala/compiled-strongest/lean/Snuffy/IRMandatoryBaselineMaximality.lean

- SHA-256: `16b7e599d54bba4c46f6888c10d6b9b39dd9c7f97dfbf5302c408bc38417a897` · lines: 279 · matched declarations: 14
- L27: def `RequiredFeasible`
- L33: def `firstProtected`
- L37: def `finalProtected`
- L41: theorem `first_protected_feasible`
- L48: theorem `final_protected_feasible`
- L57: theorem `final_protected_contains_required`
- L66: theorem `first_protected_base_or_higher`
- L77: theorem `final_first_priority_iff`
- L91: theorem `no_required_first_improver`
- L136: theorem `no_required_second_improver`
- L178: theorem `required_baseline_full_feasible_original_lex_maximal`
- L214: def `RequiredResourceFeasible`
- L221: theorem `resource_capacity_plus_mandatory_baseline_maximal`
- L253: theorem `required_duty_is_genuinely_positive`

## lalala/compiled-strongest/lean/Snuffy/IRMicrostepInvariant.lean

- SHA-256: `cfc59b64ce8b7ce9d5bf2978018cb4fded4abfe75682e4e9be9e812b9c216d1b` · lines: 108 · matched declarations: 5
- L14: def `GuardedMicrotrace`
- L26: theorem `all_recorded_microsteps_safe`
- L52: theorem `endpoints_safe_interior_unsafe`
- L65: theorem `certified_hold_and_microstep_safety`
- L96: theorem `omitted_microstep_counterexample`

## lalala/compiled-strongest/lean/Snuffy/IRObservedClockedStalls.lean

- SHA-256: `fa8d0d15b5e7b967ecc58f3f139eed0bb4da3a34742ffb4b11644918a25c88c9` · lines: 95 · matched declarations: 1
- L23: theorem `actual_state_safe_and_served_with_bounded_stalls`

## lalala/compiled-strongest/lean/Snuffy/IRPhysicalAbstraction.lean

- SHA-256: `610191e361e424e94587fd418cfa0a547786fabe8327fc48bfd7f83656c55ffb` · lines: 112 · matched declarations: 7
- L16: def `physicalStep`
- L19: def `physicalRun`
- L22: theorem `physical_run_sum`
- L38: theorem `residual_sum_bound`
- L56: theorem `physical_guard_with_residual`
- L73: theorem `time_bounded_physical_guard`
- L101: theorem `empty_classification_counterexample`

## lalala/compiled-strongest/lean/Snuffy/IRPhysicalGuard.lean

- SHA-256: `724906bda8dfff24646a85a384c57f4d839ff406e87e3132d78f747ded2b798d` · lines: 42 · matched declarations: 3
- L16: theorem `post_effect_guard_sound`
- L26: theorem `omitted_jump_counterexample`
- L35: theorem `sequential_post_effect_safety`

## lalala/compiled-strongest/lean/Snuffy/IRProfileAudit.lean

- SHA-256: `9abe5d8f2d0444e85ab1c953d1f6770c728882085d7aef6946db3b46f190f450` · lines: 338 · matched declarations: 29
- L25: def `Obstructs`
- L34: theorem `obstruction_blocks_improvement`
- L61: theorem `no_improvement_has_obstruction`
- L89: theorem `obstruction_iff_not_better`
- L100: theorem `improvement_transfers_to_faithful_profile`
- L135: theorem `audited_no_excluded_improver`
- L161: theorem `alleged_improver_exposes_bad_audit`
- L192: theorem `audited_selected_global_maximal`
- L215: abbrev `Outcome`
- L216: def `key`
- L217: def `chosen`
- L218: def `full`
- L219: def `menu`
- L220: def `code`
- L221: def `representative`
- L223: theorem `full_coverage`
- L228: theorem `faithful_profiles`
- L237: theorem `certified_obstructions`
- L251: theorem `local_choice`
- L265: theorem `globally_maximal_without_cofinality`
- L274: theorem `full_options_all_n`
- L277: theorem `omitted_incomparable_profile`
- L289: theorem `omitted_better_candidate`
- L300: def `badCode`
- L301: def `badRepresentative`
- L303: theorem `bad_abstraction_covers`
- L308: theorem `bad_abstraction_passes_obstruction`
- L319: theorem `bad_abstraction_is_not_faithful`
- L331: theorem `incomplete_profile_list_is_not_coverage`

## lalala/compiled-strongest/lean/Snuffy/IRQuiescenceAck.lean

- SHA-256: `d86d455f889dafc983985fa97766bda512155adcece2ea68774c889c2c6fbb71` · lines: 97 · matched declarations: 6
- L18: def `ack`
- L23: theorem `ack_sound`
- L30: def `deliverMany`
- L37: theorem `no_landing_after_fresh_ack`
- L66: theorem `certified_quiescent_hold`
- L84: theorem `stale_ack_does_not_protect`

## lalala/compiled-strongest/lean/Snuffy/IRResidualEscrow.lean

- SHA-256: `c8e1550e701a739cacacc1a4af4ec4624f14f6b7ad1959d863fc4a106d55a1d9` · lines: 83 · matched declarations: 4
- L18: theorem `metered_residual_bounded_by_escrow`
- L30: theorem `escrow_residual_physical_guard`
- L51: theorem `timed_escrow_physical_guard`
- L74: theorem `conserved_bookkeeping_does_not_bound_unmetered_effect`

## lalala/compiled-strongest/lean/Snuffy/IRResourceDerivedClosure.lean

- SHA-256: `70fca3e2ff7da4b7a7e1041a5e6f66c30ccd5811273e57fa47250c47d461fa72` · lines: 208 · matched declarations: 17
- L25: def `charge`
- L33: def `ResourceSafe`
- L41: def `ConflictSafe`
- L47: def `CapacityFeasible`
- L55: def `DerivedForbidden`
- L63: theorem `resource_feasible_iff_finite_forbidden`
- L91: theorem `empty_capacity_feasible`
- L115: theorem `resource_capacity_implies_global_lex_maximality`
- L142: def `sharedCost`
- L144: def `unitCapacity`
- L145: def `noHard`
- L147: theorem `shared_capacity_excludes_joint_pair`
- L159: theorem `shared_capacity_global_original_lex_maximal`
- L172: def `EventuallyAbsent`
- L175: theorem `finite_prefix_eventually_absent`
- L182: theorem `full_infinite_not_eventually_absent`
- L190: theorem `eventual_absence_not_exactly_finitary`

## lalala/compiled-strongest/lean/Snuffy/IRSafeMaximality.lean

- SHA-256: `115f3ed05d4bcd8a295daca12cbbe9a7ca46ef67ad5637e3a891e1a05fd58e59` · lines: 81 · matched declarations: 5
- L22: def `Cofinal`
- L29: theorem `safe_maximal_exists`
- L38: theorem `cofinal_safe_maximal_is_globally_maximal`
- L56: theorem `cofinal_global_maximal_exists`
- L68: theorem `globally_maximal_first_stage_no_needless`

## lalala/compiled-strongest/lean/Snuffy/IRSelectedMaximality.lean

- SHA-256: `4cf39b604706c52d7df25544492733f678f3c4db85c7c6e1dbe89e6db49bf3fe` · lines: 141 · matched declarations: 10
- L20: def `NoExcludedImprover`
- L29: theorem `selected_safety_maximal_lifts_globally`
- L45: theorem `cofinal_implies_selected_no_outside_improver`
- L59: theorem `selected_realisation_suffices`
- L74: def `incomparable`
- L76: theorem `incomparable_not_better`
- L90: theorem `cofinality_is_not_necessary`
- L113: def `dominates`
- L115: theorem `excluded_strict_improvement`
- L127: theorem `local_maximum_need_not_be_global`

## lalala/compiled-strongest/lean/Snuffy/IRServiceProgress.lean

- SHA-256: `f431eac0b64430987cf695566715a37cda8b1545a36f16c133754c2a8df1cf6c` · lines: 100 · matched declarations: 5
- L21: theorem `ranked_trace_reaches_goal`
- L79: def `frozenStep`
- L81: theorem `infinite_hold_is_safe_but_never_serves`
- L93: def `unfairNext`
- L96: theorem `favourable_transition_not_sufficient`

## lalala/compiled-strongest/lean/Snuffy/IRStoredEnergyCommonMode.lean

- SHA-256: `b3fc67b34c6aef96f1d3f71fe1eaacbba5519b50cb785fd71766dd0c6f15704e` · lines: 208 · matched declarations: 16
- L42: def `twiceInductiveEnergy`
- L48: def `totalStoredTwice`
- L53: structure `DischargeLedger`
- L68: def `ConservativeAccounting`
- L73: def `ClampCapacity`
- L80: theorem `zero_escape_zero_remnant_requires_full_capacity`
- L97: theorem `undersized_clamp_forces_escape_or_remaining`
- L119: theorem `synthetic_magnetic_store_exceeds_capacity`
- L126: theorem `energy_capacity_does_not_bound_peak_voltage`
- L148: theorem `two_agreeing_untrusted_sensors_can_both_be_wrong`
- L161: theorem `one_physically_sound_channel_with_margin`
- L177: def `dualDomainPermit`
- L181: theorem `failed_analog_domain_denies_modeled_command`
- L186: theorem `failed_physical_fence_denies_modeled_command`
- L194: theorem `all_enables_pass_but_independent_bypass_lands`
- L202: theorem `intersample_endpoint_acceptance_does_not_ensure_safety`

## lalala/compiled-strongest/lean/Snuffy/IRStutterObstruction.lean

- SHA-256: `4886eddc449fa38ec2a46b8f219cf074b1608c9bfc02824a4b26a2266924d0f3` · lines: 121 · matched declarations: 13
- L22: theorem `stuttering_non_goal_refutes_any_progress_rank`
- L38: theorem `unchanged_unserved_belief_blocks_rank`
- L61: def `adversarialNext`
- L64: def `observe`
- L65: def `policy`
- L66: def `served`
- L67: def `K`
- L69: def `initial`
- L72: theorem `initially_unserved`
- L79: theorem `initial_is_good`
- L82: theorem `helpful_and_stalling_disturbances`
- L89: theorem `adverse_event_keeps_belief_unchanged`
- L105: theorem `beneficial_option_does_not_force_robust_belief_progress`

## lalala/compiled-strongest/lean/Snuffy/IRTwoStageInfiniteLex.lean

- SHA-256: `c24c77ad41987570ee579965b8b173233455c4c8b26c0b3af52f77651358d97f` · lines: 202 · matched declarations: 20
- L30: abbrev `Outcome`
- L32: def `firstKey`
- L33: def `secondKey`
- L35: def `fullIndependent`
- L38: def `independentChoice`
- L44: theorem `independent_two_stage_global_lex_maximum`
- L70: abbrev `ManyOutcome`
- L72: def `indexedKey`
- L75: def `allIndependentFeasible`
- L79: def `allIndependentChoice`
- L83: theorem `independent_any_finite_stage_lex_maximum`
- L121: def `coupledFull`
- L127: def `coupledChoice`
- L130: theorem `coupled_choice_feasible`
- L140: theorem `coupled_two_stage_lex_maximum`
- L170: def `noForbidden`
- L172: theorem `empty_feasible_without_prohibitions`
- L177: theorem `unconstrained_limit_includes_every_particular`
- L187: theorem `independent_maxima_not_jointly_feasible`
- L196: theorem `coupled_choice_not_joint_independent_maximum`

## lalala/compiled-strongest/lean/Snuffy/IRTypedTraceChecker.lean

- SHA-256: `64bbbed69303a8feed187092128ee1dbb2f88b635574769ba245bc46ce37d53b` · lines: 305 · matched declarations: 31
- L33: structure `TelemetryRecord`
- L41: structure `CheckConfig`
- L49: def `InitialValid`
- L58: def `StepValid`
- L83: def `checkStep`
- L87: def `CheckSegments`
- L93: def `checkSegments`
- L99: def `TraceValid`
- L107: def `verifyTraceData`
- L117: theorem `checkStep_sound`
- L123: theorem `checkSegments_sound`
- L141: theorem `verifyTraceData_sound`
- L160: theorem `valid_segments_every_step_paid`
- L182: theorem `accepted_trace_every_record_above_reserve`
- L199: theorem `accepted_trace_every_step_paid`
- L211: theorem `accepted_trace_every_step_balanced_and_bounded`
- L221: def `testConfig`
- L223: def `testInitial`
- L225: def `testNext`
- L227: def `testThird`
- L230: def `sampleTrace`
- L233: theorem `accepted_example_is_computable`
- L238: def `badInitial`
- L241: theorem `invalid_singleton_rejected`
- L244: theorem `missing_tick_rejected`
- L248: theorem `forged_balance_rejected`
- L252: def `insufficientSupplyRecord`
- L255: theorem `insufficient_step_supply_rejected`
- L259: theorem `too_rapid_logged_descent_rejected`
- L268: theorem `accepted_records_without_physical_refinement_do_not_certify_reality`
- L280: theorem `accepted_trace_physical_reserve_with_error`

## lalala/compiled-strongest/lean/Snuffy/IRViability.lean

- SHA-256: `84db22b64d371a6bc10db4f5a9d65cf2dfd0aa2b5ac9f56b7212f1751a1b2150` · lines: 103 · matched declarations: 9
- L20: def `Viable`
- L24: theorem `viable_now_safe`
- L32: theorem `viable_horizon_monotone`
- L47: theorem `robust_invariant_implies_all_horizons`
- L64: def `run`
- L68: theorem `robust_policy_preserves_every_finite_trace`
- L83: def `toySafe`
- L84: def `toyStep`
- L87: theorem `safe_immediate_but_not_viable`

## lalala/compiled-strongest/lean/Snuffy/IRWatchdogLatencyEffects.lean

- SHA-256: `6c623bd65e7f99528ca1b2e0bbbbbf335741a8db4187082dbf3d204537d59609` · lines: 225 · matched declarations: 17
- L36: structure `Episode`
- L46: def `TimingContract`
- L58: theorem `additive_fault_to_quiescence_bound`
- L68: theorem `window_age_bounded`
- L88: theorem `guarded_reaction_window_remains_below_threshold`
- L117: theorem `guarded_quiescence_endpoint_safe`
- L146: def `actualEffect`
- L149: theorem `disabled_complete_mediation_blocks_modeled_effect`
- L154: theorem `independent_bypass_defeats_disabled_gate`
- L161: theorem `fenced_and_drained_pipeline_stops_modeled_effects`
- L177: def `transient`
- L179: theorem `fast_shutdown_does_not_erase_prior_breach`
- L192: def `absorbingHold`
- L194: def `afterHold`
- L197: def `deliversService`
- L199: theorem `absorbing_no_service_counterexample`
- L215: theorem `valid_logged_trace_can_coexist_with_unmodeled_physical_breach`

## lalala/compiled-strongest/lean/Snuffy/Instruments.lean

- SHA-256: `55751cd8393856b86b937090231718dc7225386f21ebc04152fbd2a27ca9995a` · lines: 207 · matched declarations: 12
- L49: theorem `lindblad_reset_flow`
- L60: theorem `lindblad_step`
- L67: theorem `reset_contracts`
- L76: theorem `tracking_recursion_derived`
- L98: theorem `tracking_envelope_derived`
- L122: theorem `branchC_complete`
- L147: def `box`
- L149: theorem `card_box`
- L155: theorem `box_mono`
- L162: def `boundary`
- L166: theorem `card_boundary`
- L191: theorem `boundary_power`

## lalala/compiled-strongest/lean/Snuffy/IntegrationCertificate.lean

- SHA-256: `47079cf63add2d1665f109bbfdd98b3a339e84c753d754ae07ea4c1613c01edd` · lines: 125 · matched declarations: 8
- L28: theorem `typed_gate_decomposition`
- L44: def `sumB`
- L52: def `intervalOK`
- L60: theorem `finish_interval_deadline`
- L74: def `psi2`
- L76: theorem `psi2_uniform`
- L82: theorem `h8_bound_two_node`
- L100: def `d3`

## lalala/compiled-strongest/lean/Snuffy/Irreplaceability.lean

- SHA-256: `b0922dbbf603d6f62ff3e9a00d9d29644531767b8538f5bb184e33deb5fbea6e` · lines: 75 · matched declarations: 4
- L32: def `value`
- L37: theorem `destroy_loses_exactly`
- L43: theorem `preserve_dominates`
- L51: theorem `optimal_keeps_most_irreplaceable`

## lalala/compiled-strongest/lean/Snuffy/ItemisedRisk.lean

- SHA-256: `d833ebbe4236c2c7a5873029c1091254d5d174277ae2c51ff3a4e46064dc375c` · lines: 40 · matched declarations: 2
- L23: theorem `account_le_of_kernel`
- L30: theorem `itemised_risk`

## lalala/compiled-strongest/lean/Snuffy/KLAdditivity.lean

- SHA-256: `1e700a2d627206ab9896d3a883e1d6b2714e1c5eff2d5f8391dc1e07d2b8268d` · lines: 88 · matched declarations: 5
- L30: theorem `prod_eq_compProd`
- L37: theorem `klDiv_map_equiv`
- L48: theorem `compProd_prod_assoc`
- L55: theorem `compProd_prod_swap`
- L61: theorem `klDiv_prod_kernel`

## lalala/compiled-strongest/lean/Snuffy/KnillLaflamme.lean

- SHA-256: `a4e037dd498ba6a2deb3a22d5944940116286d7d7c51c0892804425c8ff26eca` · lines: 89 · matched declarations: 5
- L35: theorem `eq_zero_of_eq_neg`
- L41: theorem `spectral_projection`
- L55: theorem `sandwich_anticomm`
- L64: theorem `sandwich_scalar`
- L71: theorem `knill_laflamme_of_distance`

## lalala/compiled-strongest/lean/Snuffy/Landauer.lean

- SHA-256: `2c298142b31e208998236815da2640efb1ca04264ac6aa2fe2e67e359e7d8e6e` · lines: 293 · matched declarations: 30
- L39: def `ent`
- L42: theorem `kl_nonneg`
- L48: theorem `mul_log_div_eq`
- L63: def `margA`
- L66: def `margB`
- L68: theorem `sum_margA`
- L71: theorem `sum_margB`
- L75: def `mutualInfo`
- L78: theorem `mutualInfo_eq`
- L107: theorem `mutualInfo_nonneg`
- L119: theorem `ent_le_ent_marg`
- L134: def `partition`
- L137: def `gibbs`
- L139: theorem `partition_pos`
- L142: theorem `gibbs_pos`
- L144: theorem `gibbs_sum_one`
- L149: theorem `log_gibbs`
- L153: theorem `ent_gibbs`
- L164: theorem `ent_le_energy`
- L189: def `evolve`
- L197: theorem `evolve_nonneg`
- L201: theorem `evolve_sum`
- L209: theorem `ent_evolve`
- L215: def `heat`
- L219: def `entDrop`
- L223: theorem `reeb_wolf_identity`
- L249: theorem `landauer`
- L264: theorem `landauer_erasure`
- L275: theorem `guard_one`
- L286: theorem `cycle_work_floor_derived`

## lalala/compiled-strongest/lean/Snuffy/LatticeLaplacian.lean

- SHA-256: `9f6d187ea71b19c055d17f4f85378145d958ba69ee91173fc42a701935002326` · lines: 108 · matched declarations: 4
- L25: lemma `symmetric_slope`
- L50: lemma `ratio_eq_slope`
- L77: theorem `second_difference`
- L102: theorem `lattice_laplacian`

## lalala/compiled-strongest/lean/Snuffy/Law.lean

- SHA-256: `e4c86207ca62bcde9307eb91db0910e7d58efe1b9430d8fbc81173ec1d6f4159` · lines: 164 · matched declarations: 10
- L39: theorem `exists_aligned`
- L51: theorem `lexLt_first_le`
- L64: theorem `life_guard`
- L78: def `NeedlessLoss₁`
- L81: def `ProjMax`
- L86: theorem `scope_guarantee_iff`
- L113: theorem `same_priority_admits_needless_loss`
- L137: def `UpwardClosed`
- L142: theorem `faithful_hold_dominates`
- L151: theorem `faithful_hold_strict`

## lalala/compiled-strongest/lean/Snuffy/LogDet.lean

- SHA-256: `43ed67efec9f5c381e2101ec8562ccf6d07bf8b58a872d316b338657dc2a251f` · lines: 150 · matched declarations: 7
- L35: def `cov`
- L39: theorem `cov_isHermitian`
- L47: theorem `var_lincomb`
- L79: theorem `rotSignal_eigen`
- L90: theorem `var_rot_eq_eigenvalue`
- L107: theorem `det_one_add`
- L128: theorem `logdet_channel_bound`

## lalala/compiled-strongest/lean/Snuffy/MatchingWitness.lean

- SHA-256: `a8aef225d4344bd88dcd7758da18fe05cfc1eecbff8c93ecb5cb230ac648c2e6` · lines: 65 · matched declarations: 4
- L8: instance `a`
- L36: theorem `card_symmDiff`
- L40: theorem `half_faulty`
- L56: theorem `matching_witness`

## lalala/compiled-strongest/lean/Snuffy/MathlibAnalyticBridge.lean

- SHA-256: `67ce6b974cb46dab4dc8743bcb1908393bda307db25b56134b62cd1894b5abdd` · lines: 186 · matched declarations: 12
- L46: theorem `starProjection_fixed_iff_mem`
- L52: theorem `starProjection_idem`
- L61: def `altIterate`
- L68: theorem `altIterate_succ_eq_self`
- L85: theorem `altIterate_succ_mem`
- L91: def `mirrorAltIterate`
- L97: theorem `mirrorIterate_succ_mem`
- L107: structure `VonNeumannConvergence`
- L123: theorem `convergence_inf_le`
- L141: theorem `limit_mem_of_fixed`
- L155: theorem `convergence_inf_ge`
- L180: theorem `von_neumann_identification`

## lalala/compiled-strongest/lean/Snuffy/MeanErgodic.lean

- SHA-256: `61f09528cd934829780d7d076d2f6a33f1b04b8cab68a2688178af89f317bb22` · lines: 12 · matched declarations: 2
- L6: def `cesaroMeanId`
- L9: theorem `cesaro_mean_id`

## lalala/compiled-strongest/lean/Snuffy/MeanErgodicDeep.lean

- SHA-256: `00a1c8024c586a5695951ac9d8cf34ade3176335d81da174707f9fbb3505a71c` · lines: 16 · matched declarations: 3
- L6: def `cesaroAvgId`
- L9: theorem `cesaro_id`
- L13: theorem `id_fixes_all`

## lalala/compiled-strongest/lean/Snuffy/MeetAlgebra.lean

- SHA-256: `ce746eb7bab2d68153205fd4f2ea5725b5769a614271184ef105a815ef69809d` · lines: 141 · matched declarations: 11
- L26: class `ProjectionLattice`
- L48: def `Consistent`
- L52: theorem `anchor_preserved`
- L56: theorem `contradiction_collapse`
- L68: theorem `bot_absorb`
- L72: def `meetAll`
- L78: theorem `anchor_preserved_over`
- L92: theorem `meetAll_bot`
- L99: theorem `collapse_over`
- L107: theorem `consistent_preserved`
- L116: instance `predicateModel`

## lalala/compiled-strongest/lean/Snuffy/MeetHilbert.lean

- SHA-256: `62bf22d842fbd0c0cad2f3b87d0481089cbd5afa2c730f5bf3293fb9883581f8` · lines: 85 · matched declarations: 5
- L36: instance `hilbertLattice`
- L56: theorem `hilbert_anchor_preserved`
- L62: theorem `hilbert_contradiction_collapse`
- L69: theorem `contradiction_detected`
- L79: theorem `deduction_never_rolls_back`

## lalala/compiled-strongest/lean/Snuffy/MetricShadow.lean

- SHA-256: `e1bad9fc57f51713b3ef18056dc61548f07cecbaf759d85c1186f8b315b8fecb` · lines: 30 · matched declarations: 3
- L9: theorem `embedding_distance_stability`
- L17: theorem `protected_close_edge_margin`
- L23: theorem `protected_separated_edge_margin`

## lalala/compiled-strongest/lean/Snuffy/NarrowPlace.lean

- SHA-256: `95bafc0219891baa77e4fdccbc04b2f4b45bd4803e3420cf9d120d4aae6bb1f8` · lines: 78 · matched declarations: 1
- L25: theorem `np_splitting_bound`

## lalala/compiled-strongest/lean/Snuffy/NoisyPooling.lean

- SHA-256: `5e598b9123982c0ee91abb4a9e8380aa9e794e8a77f555733894ecaa9f400dbb` · lines: 36 · matched declarations: 4
- L21: def `heldIfPool`
- L22: def `heldIfAbstain`
- L24: theorem `noisy_advantage`
- L29: theorem `noisy_pool_strictly_dominant`

## lalala/compiled-strongest/lean/Snuffy/ObservationWinning.lean

- SHA-256: `d93af125041fc4801e062bd01630c7745f83a41690e3c229f2a43aa05b9c2fd8` · lines: 80 · matched declarations: 7
- L23: def `Post`
- L26: def `Win`
- L33: def `Good`
- L40: theorem `policy_wins_iff`
- L69: def `cmNext`
- L70: def `cmObs`
- L72: theorem `hidden_world_countermodel`

## lalala/compiled-strongest/lean/Snuffy/OpialBridge.lean

- SHA-256: `b3c74eba3d40bcd9c2422c53309d7975335e33fccdf0a160ac4657eb4bbb7871` · lines: 289 · matched declarations: 12
- L40: def `WeaklyConvergesTo`
- L44: def `tIterate`
- L49: theorem `tIterate_succ_mem`
- L58: theorem `weakCluster_mem_exact`
- L82: theorem `weakCluster_mem`
- L142: theorem `iterate_inner_const`
- L166: theorem `weakCluster_eq_starProjection`
- L202: theorem `iterate_sub_starProjection_sq_eq`
- L237: theorem `tendsto_starProjection_of_norm_sq_tendsto`
- L267: def `mirrorTIterate`
- L272: structure `VonNeumannConvergence`
- L281: theorem `makeVonNeumannConvergence`

## lalala/compiled-strongest/lean/Snuffy/OriginalD1.lean

- SHA-256: `7f0e58cf3d426f2a321bfa50a7bdcc27db561c8099ac4bc12ebc71c6c77471ef` · lines: 50 · matched declarations: 6
- L14: def `expectedValue`
- L17: theorem `expected_value_formula`
- L26: theorem `original_dominance_counterexample`
- L34: theorem `lifetime_density_is_normalized`
- L38: theorem `lifetime_survival_tail`
- L41: theorem `zero_ultimate_survival_with_positive_accumulated_value`

## lalala/compiled-strongest/lean/Snuffy/OriginalE9AndH5.lean

- SHA-256: `64151f4c20cdd3bbc0653148748cb9e2729281c93bbaeca09fb2680a82bd19a9` · lines: 47 · matched declarations: 7
- L13: def `localRun`
- L18: def `healthy`
- L19: def `attacked`
- L21: theorem `finite_speed_indistinguishability`
- L32: theorem `no_sound_remote_alarm_before_arrival`
- L40: def `localGuard`
- L42: theorem `h5_local_rate_does_not_bound_total_entropy`

## lalala/compiled-strongest/lean/Snuffy/OriginalH6.lean

- SHA-256: `0a522c7baeb2dd44e684ab3eac581e74a0479aadaa656a56d0a9741aea76c56f` · lines: 87 · matched declarations: 9
- L14: theorem `original_thermal_depth_ceiling`
- L30: def `bankedStep`
- L31: def `rate`
- L33: def `bankedRun`
- L37: theorem `banked_rate_is_contractive`
- L43: theorem `banked_step_error`
- L52: theorem `banked_exact_error`
- L60: theorem `banked_paid_epsilon_accuracy`
- L74: theorem `original_thermal_premises_allow_cycle`

## lalala/compiled-strongest/lean/Snuffy/OriginalH7.lean

- SHA-256: `f1ebedbfa20f13988c787609559bf6e8b5de72348b32bda8b6f258b1c1e0851b` · lines: 70 · matched declarations: 8
- L17: def `decay`
- L18: def `left`
- L20: def `right`
- L23: theorem `decay_derivative`
- L30: theorem `solves_original_equation`
- L43: theorem `decay_limit`
- L50: theorem `all_nonnegative_couplings_converge`
- L62: theorem `every_initial_pair_is_represented`

## lalala/compiled-strongest/lean/Snuffy/OriginalH8.lean

- SHA-256: `b546f090c342bf4a4d85a5c4bf72f57f5e3bf63ce99aaad883c3ae5970eeeebb` · lines: 39 · matched declarations: 6
- L13: def `hhi`
- L14: def `quadraticDissipation`
- L15: def `originalProposedUpper`
- L18: theorem `actual_minimum_is_one`
- L23: theorem `uniform_attains_minimum`
- L26: theorem `original_bound_counterexample`

## lalala/compiled-strongest/lean/Snuffy/OuterLane.lean

- SHA-256: `557288d5d6ddfc467fa1aee469b3ebd2402d7d3e9a3476fcb11f17b37c95dd5c` · lines: 143 · matched declarations: 4
- L34: theorem `wavefront_coverage`
- L70: theorem `interception_in_time`
- L89: theorem `pool_strictly_dominant`
- L123: theorem `outer_lane_risk`

## lalala/compiled-strongest/lean/Snuffy/P2P3.lean

- SHA-256: `87476d6351da978a583f7c6b69bb6b20b27ae253afd6118337782fe6053daa51` · lines: 171 · matched declarations: 14
- L34: theorem `sensor_exp_positivity`
- L38: theorem `scaling_sum`
- L45: theorem `azuma_scaling`
- L54: theorem `work_tv_floor`
- L65: theorem `coordinate_sensitivity`
- L79: theorem `telescoping_drop`
- L92: theorem `semigroup_time_rescaling`
- L102: theorem `ness_work_linear`
- L112: theorem `work_floor_positive`
- L118: theorem `liquidation_triggers`
- L132: theorem `zero_breach_bound`
- L140: theorem `bound_decays`
- L148: theorem `escrow_ordering`
- L156: theorem `fluctuation_bound_le_two`

## lalala/compiled-strongest/lean/Snuffy/PassiveReference.lean

- SHA-256: `02dbb95a922bc17657314757900578d45bd1d2f13d0ad3012569cb7eccedc92f` · lines: 57 · matched declarations: 3
- L32: theorem `stages_cover`
- L40: theorem `total_failure_le`
- L50: theorem `total_rewrite_cost`

## lalala/compiled-strongest/lean/Snuffy/PerLossCheck.lean

- SHA-256: `cb61b1999124118764e9ffd8f5b475f0237c29188bc90ee210f63ac64ca7d431` · lines: 38 · matched declarations: 1
- L23: theorem `maximal_iff_per_loss`

## lalala/compiled-strongest/lean/Snuffy/PhysicalGuard.lean

- SHA-256: `c2f5e45956371b46a7dec2ff38b117aa4ad9d0f3c52f8141362b3a8cd4064571` · lines: 19 · matched declarations: 3
- L6: def `factorized`
- L10: theorem `factorization`
- L15: theorem `interior_unchanged`

## lalala/compiled-strongest/lean/Snuffy/PremiseFloor.lean

- SHA-256: `5c6e13296b1dd2ed9dfbc5008369ded813a2830a4d10dc3988f5dadb2492a93d` · lines: 101 · matched declarations: 5
- L35: def `balance`
- L39: theorem `income_or_irrelevance`
- L54: theorem `forced_breach`
- L78: theorem `breach_strictly_below`
- L90: theorem `reversible_administration_forced`

## lalala/compiled-strongest/lean/Snuffy/PureStateDistance.lean

- SHA-256: `d120f4c73096a49eeb9cbd4042f55f44ddec2084e89535475ea85331b01f9c5a` · lines: 44 · matched declarations: 2
- L27: theorem `pure_infidelity_le`
- L39: theorem `pure_fidelity_ge`

## lalala/compiled-strongest/lean/Snuffy/PureStateTraceNorm.lean

- SHA-256: `cf9df261dc459cfdabc863eb8f1a0b73cda85650cb9218274e90410cfaab8b52` · lines: 229 · matched declarations: 10
- L31: def `traceNorm`
- L34: theorem `sum_sq_eigenvalues`
- L54: theorem `eigenvalue_cube`
- L93: def `pureDiff`
- L97: theorem `pureDiff_hermitian`
- L106: theorem `vmv_smul`
- L111: theorem `star_dot_swap`
- L118: theorem `pure_cube`
- L154: theorem `pure_trace_sq`
- L178: theorem `pure_trace_norm`

## lalala/compiled-strongest/lean/Snuffy/QuantumLandauer.lean

- SHA-256: `aad81b1b8a01c270218516bf6af0bc7136efcbf6e861c7a1dd3c82be541400e0` · lines: 472 · matched declarations: 38
- L49: def `vnEnt`
- L52: theorem `vnEnt_eq_roots`
- L59: theorem `vnEnt_congr`
- L64: theorem `vnEnt_unitary_conj`
- L69: theorem `vnEnt_diagonal`
- L80: theorem `diag_conj`
- L87: theorem `row_normSq_sum`
- L95: theorem `col_normSq_sum`
- L102: theorem `vnEnt_le_diag`
- L137: theorem `diag_nonneg`
- L142: theorem `diag_sum`
- L155: abbrev `UH`
- L157: theorem `UH_mem`
- L159: theorem `H_spec`
- L164: theorem `energy_eq`
- L176: theorem `vnEnt_le_energy`
- L186: def `gibbsState`
- L189: theorem `gibbsState_posSemidef`
- L197: theorem `gibbsState_trace`
- L204: theorem `gibbsState_diag`
- L210: theorem `gibbsState_trace'`
- L217: theorem `gibbsState_energy`
- L224: theorem `vnEnt_gibbsState`
- L243: def `ptrA`
- L246: def `ptrB`
- L249: theorem `ptrA_isHermitian`
- L256: theorem `sum_star_mul_eq`
- L266: theorem `ptrA_conj`
- L295: theorem `ptrB_conj`
- L330: def `finalState`
- L339: theorem `init_posSemidef`
- L344: theorem `finalState_posSemidef`
- L349: theorem `finalState_trace`
- L356: theorem `vnEnt_init`
- L388: def `qheat`
- L395: theorem `quantum_landauer`
- L452: theorem `quantum_guard_one`
- L463: theorem `quantum_cycle_work_floor`

## lalala/compiled-strongest/lean/Snuffy/QueueDeadline.lean

- SHA-256: `df49270aca477c7240c0f02d158e5aa53b5f9769171a535f1765c43d01361d21` · lines: 40 · matched declarations: 4
- L12: theorem `exponential_service_tail`
- L17: theorem `exponential_service_normalized`
- L26: theorem `positive_deadline_miss_probability`
- L31: theorem `small_mean_does_not_make_tail_zero`

## lalala/compiled-strongest/lean/Snuffy/R14Boundary.lean

- SHA-256: `02fb5e1bbf8c48977fce3fd85fc75f97f6a89b963e6c588bf889a82e7f2182bc` · lines: 191 · matched declarations: 26
- L17: structure `St`
- L28: inductive `Ev`
- L37: def `step`
- L50: def `run`
- L54: def `Safe`
- L57: def `Good`
- L62: theorem `safe_step`
- L78: theorem `every_good_trace_safe`
- L86: structure `J`
- L92: def `projectJ`
- L93: def `jStep`
- L99: def `projectK`
- L100: def `kStep`
- L107: structure `Outside`
- L112: def `projectOutside`
- L113: def `outsideStep`
- L118: theorem `journal_commutes`
- L129: theorem `sink_commutes`
- L140: theorem `outside_commutes`
- L152: theorem `harmful_effect_refused`
- L155: theorem `old_generation_refused`
- L159: theorem `external_weather_is_not_a_replica_fault`
- L164: def `isRecruit`
- L168: theorem `recruitment_erasure`
- L175: theorem `recruitment_never_ends_care`
- L178: theorem `failure_has_a_named_exception`

## lalala/compiled-strongest/lean/Snuffy/R14Rivals.lean

- SHA-256: `4fabd6097a8d16f0f120771623479cb29cbaa4ad93e52618145c9a5eac753a45` · lines: 82 · matched declarations: 9
- L13: def `LE`
- L17: theorem `refl`
- L22: theorem `trans`
- L37: theorem `coordinate_envelope`
- L48: theorem `complete_rival_transfer`
- L61: def `pause`
- L62: def `hot`
- L63: def `four`
- L66: theorem `hot_beats_pause`

## lalala/compiled-strongest/lean/Snuffy/R15CausalGluing.lean

- SHA-256: `0a79b8bd3cb1a9e544e2a59a555881e22df6a83a141a53e5abb526752b0318d4` · lines: 90 · matched declarations: 6
- L14: def `Greatest`
- L19: theorem `boundary_representatives_iff`
- L37: theorem `selected_representative_greatest`
- L51: theorem `canonical_boundary_iff`
- L65: theorem `interface_envelope_transfer`
- L81: theorem `hidden_world_control`

## lalala/compiled-strongest/lean/Snuffy/R16Cut.lean

- SHA-256: `7a8f054ccb463e7528c404772d4e0845ba6bfcf2f73fc4d9f90b7e6890a03ff0` · lines: 170 · matched declarations: 19
- L13: def `AgreeOn`
- L16: def `LocalTo`
- L20: theorem `closed_cut_step`
- L29: theorem `dependency_closure_step`
- L38: def `Bypass`
- L42: theorem `difference_has_bypass`
- L75: theorem `causal_separator`
- L91: def `cutTick`
- L97: theorem `closed_cut_reactive`
- L119: inductive `Node`
- L123: def `dependency`
- L129: def `delayedStep`
- L134: theorem `delayed_locality`
- L141: def `outsideSeed`
- L143: theorem `pending_is_in_cut`
- L146: theorem `private_cause_is_in_cut`
- L149: def `starts`
- L153: theorem `delayed_effect_countermodel`
- L159: theorem `omitted_edge_is_not_local`

## lalala/compiled-strongest/lean/Snuffy/R16Feedback.lean

- SHA-256: `ca923659b764ccdfd743fdd08fdb251b2d5ccb12466a6dbb7a276b4c729cab15` · lines: 72 · matched declarations: 8
- L9: structure `History`
- L13: structure `Configuration`
- L17: def `mapState`
- L20: def `iterate`
- L24: theorem `map_iterate`
- L31: def `tick`
- L40: theorem `tick_commutes`
- L55: theorem `reactive_lockstep`

## lalala/compiled-strongest/lean/Snuffy/R16R14.lean

- SHA-256: `9e0a0b881ee7bf50416d71bc9f537ea47d880db390a4cd7d706714826a792787` · lines: 60 · matched declarations: 7
- L12: structure `PortState`
- L19: def `project`
- L22: def `breachFlag`
- L26: def `portStep`
- L30: theorem `compromise_commutes`
- L43: theorem `project_step`
- L48: theorem `reference_two_phase_lockstep`

## lalala/compiled-strongest/lean/Snuffy/R16Screened.lean

- SHA-256: `fbfbc799da4aef8124aacaab9b8a57601667d155a093f41109041850bb91b258` · lines: 37 · matched declarations: 1
- L11: theorem `screened_fibre_lockstep`

## lalala/compiled-strongest/lean/Snuffy/R16TwoPhase.lean

- SHA-256: `abeba603f044134fa8919a7da66ebe15caf5bb09c14ad92bfd914851e10b6408` · lines: 57 · matched declarations: 3
- L8: def `phaseTick`
- L20: theorem `phase_tick_commutes`
- L37: theorem `two_phase_lockstep`

## lalala/compiled-strongest/lean/Snuffy/R17AQueueFinality.lean

- SHA-256: `eed1d61c17bae5522a354d143f4720f0e4ffae2175205b4327e36a26775da48b` · lines: 179 · matched declarations: 13
- L16: structure `Contract`
- L25: structure `Machine`
- L38: abbrev `Registry`
- L43: structure `Ready`
- L59: def `applyOne`
- L74: theorem `new_effect_has_current_permit`
- L93: def `drainOne`
- L101: theorem `drain_currently_authorized`
- L125: theorem `revoked_refuses`
- L137: theorem `expired_refuses`
- L150: theorem `installed_floor_refuses`
- L164: theorem `spend_is_funded`
- L170: theorem `application_has_source_binding`

## lalala/compiled-strongest/lean/Snuffy/R17FIFOR17A.lean

- SHA-256: `aa17c304a673be08c3508c300085e4f7cb212ecc857dddef487d3f4cac086c13` · lines: 53 · matched declarations: 2
- L17: theorem `applied_fifo_effect_is_timely_and_authorized`
- L35: theorem `ready_fifo_effect_applies_before_deadline`

## lalala/compiled-strongest/lean/Snuffy/R17Funding.lean

- SHA-256: `2195463776a7520105cfac06cb6824ed852c504af91c8c0a84b8551cd2b29d89` · lines: 146 · matched declarations: 15
- L11: def `ticketCost`
- L16: def `charged`
- L20: def `Reserved`
- L23: theorem `charged_append`
- L29: theorem `atomic_target_append`
- L37: theorem `application_conserves_funding`
- L52: def `applyTrace`
- L56: theorem `trace_conserves_funding`
- L66: theorem `cumulative_charge_is_funded`
- L73: theorem `used_ticket_refuses`
- L83: theorem `accepted_ticket_is_consumed`
- L90: theorem `replay_cannot_append`
- L101: def `fundedEnqueue`
- L111: theorem `funded_admission_preserves`
- L125: theorem `source_drain_preserves_reservation`

## lalala/compiled-strongest/lean/Snuffy/R17WorkConcrete.lean

- SHA-256: `602d3384459c73e5f1bc9d3b20b71d0827dc0145497a0a2202639b688c0ff652` · lines: 264 · matched declarations: 19
- L36: structure `Lane`
- L40: theorem `Lane.mono_le`
- L46: def `Finished`
- L51: theorem `unfinished_before`
- L62: theorem `carry_in_completion`
- L74: def `affine`
- L77: theorem `ceil_div_covers`
- L85: theorem `carry_in_affine`
- L96: theorem `no_service_no_completion`
- L106: def `row`
- L113: def `U`
- L117: theorem `U_succ_succ`
- L127: theorem `exec_le_envelope`
- L149: theorem `deadlines_met`
- L162: theorem `row_congr`
- L172: theorem `tail_admission_invariant`
- L189: theorem `tail_admission_preserves_certificates`
- L203: theorem `applied_stage_effect_is_timely_and_authorized`
- L226: theorem `timely_but_revoked_is_not_delivery`

## lalala/compiled-strongest/lean/Snuffy/RGFixedPoint.lean

- SHA-256: `777ae7896b7df5664cb4e443a03a97413eaf6f1490c3943158cd57e57ded5006` · lines: 105 · matched declarations: 10
- L29: def `beta`
- L32: def `gstar`
- L34: lemma `sq_root`
- L39: theorem `gstar_pos`
- L44: lemma `fixed_relation`
- L52: theorem `beta_gstar`
- L60: theorem `eigenvalue_gstar`
- L76: lemma `beta_factor`
- L84: theorem `beta_pos_below`
- L93: theorem `beta_neg_above`

## lalala/compiled-strongest/lean/Snuffy/RankAndCoalition.lean

- SHA-256: `5dd527ab44fa53c46b068fd8b5b7635632ed0275a284ad86285eda8eabaded72` · lines: 54 · matched declarations: 4
- L13: theorem `ranked_trace_length`
- L24: theorem `ranked_polynomial_step_bound`
- L32: theorem `total_penalty_excludes_all_members_gaining`
- L45: theorem `real_lyapunov_descent_need_not_terminate`

## lalala/compiled-strongest/lean/Snuffy/ReachBeforeHarm.lean

- SHA-256: `86b332df3585358feae8b8451e882bca63cebe197a0a8f9fde8044a046bc9216` · lines: 30 · matched declarations: 1
- L18: theorem `reach_before_harm`

## lalala/compiled-strongest/lean/Snuffy/ReachTiming.lean

- SHA-256: `eff591ce4a48ff9f7c02aeb3f1d94c8dabfef8ab297a8bdd7d1885847cd1eca6` · lines: 70 · matched declarations: 4
- L25: theorem `round_trip_in_time`
- L35: theorem `reach_round_trip`
- L49: theorem `net_coverage`
- L64: theorem `fence_in_time`

## lalala/compiled-strongest/lean/Snuffy/ReadoutBounds.lean

- SHA-256: `c7a0929261f69172f184ae32ec7649399094ee172d801c69eb4f9d6d0bcafd99` · lines: 86 · matched declarations: 11
- L10: def `outDiag`
- L11: def `outDet`
- L14: theorem `determinant_identity`
- L21: theorem `determinant_lower`
- L31: theorem `strictly_positive_determinant`
- L41: theorem `spectral_lower`
- L48: def `weight`
- L52: theorem `weight_nonnegative`
- L60: theorem `conditional_record_lower`
- L75: def `total`
- L79: theorem `baseline_normalized`

## lalala/compiled-strongest/lean/Snuffy/ReadoutJoint.lean

- SHA-256: `1154e288cdf3f67032a3b794a6e8e7bc6d30b04744d834224754ec368f05d1a4` · lines: 225 · matched declarations: 25
- L29: def `iso01`
- L30: def `iso10`
- L31: def `blockA`
- L32: def `blockD`
- L35: def `cpCoeff`
- L37: theorem `block_det_identity`
- L43: theorem `shifted_det_identity`
- L48: theorem `cp_coeff_nonneg`
- L53: theorem `cp_coeff_pos`
- L58: theorem `iso01_shift_nonneg`
- L65: theorem `iso10_shift_nonneg`
- L72: theorem `blockA_shift_nonneg`
- L83: theorem `blockD_shift_nonneg`
- L89: theorem `block_shifted_det_nonneg`
- L97: theorem `quad_form_nonneg`
- L118: theorem `choi_form_nonneg`
- L139: theorem `positive_constant_not_cp`
- L144: theorem `cp_constant_at_half_half`
- L152: def `weight`
- L157: def `chain`
- L161: theorem `weight_nonneg`
- L167: theorem `chain_nonneg`
- L177: theorem `joint_record_lower`
- L192: theorem `chain_ge_pow`
- L210: theorem `hard_count_floor`

## lalala/compiled-strongest/lean/Snuffy/ReasonsCompiled.lean

- SHA-256: `98488c652f4361d2ffc3ca5c2b8741f0ae54e8ae9bc0fa07d1280f23e544e31e` · lines: 118 · matched declarations: 7
- L44: def `UpClosed`
- L49: theorem `reciprocity_expectation`
- L62: theorem `reciprocity_canonical_floor`
- L74: theorem `reciprocity_strict`
- L86: theorem `reciprocity_from_solvency`
- L105: theorem `controller_pays_floor`
- L113: theorem `controller_floor_diverges`

## lalala/compiled-strongest/lean/Snuffy/ReasonsEnsemble.lean

- SHA-256: `4e3640be5eae2db1c52120c40d808e25da44b4dde6d4d7b8a05b87f61991d4ab` · lines: 49 · matched declarations: 3
- L30: def `ensembleKept`
- L33: theorem `ensemble_le`
- L39: theorem `ensemble_strict`

## lalala/compiled-strongest/lean/Snuffy/ReasonsRoute.lean

- SHA-256: `6ac4ba0d3e30f5508e2d784f3aec640661ab4e67a85f99919f798a05e4466573` · lines: 118 · matched declarations: 12
- L31: theorem `optionValue_pointwise`
- L37: theorem `optionValue_expectation`
- L49: theorem `optionValue_strict`
- L69: structure `Regime`
- L73: def `Regime.law`
- L77: theorem `law_protects_everyone`
- L80: def `indicator`
- L83: theorem `indicator_law`
- L88: theorem `law_dominates`
- L95: theorem `law_dominates_strict`
- L101: theorem `rival_fraction_le_one`
- L108: theorem `rival_fraction_lt_one`

## lalala/compiled-strongest/lean/Snuffy/ReceivedCutR14Repaired.lean

- SHA-256: `26c87dfc9f4118960e4e74b54ce5644d15e20e93b298ee2b815c16ba2a702fac` · lines: 34 · matched declarations: 5
- L7: theorem `journal_projection_step_ext`
- L12: theorem `sink_projection_step_ext`
- L17: theorem `outside_projection_step_ext`
- L24: theorem `journal_outside_unchanged`
- L29: theorem `sink_outside_unchanged`

## lalala/compiled-strongest/lean/Snuffy/ReceivedCutRepaired.lean

- SHA-256: `2eed523669db987fdca31929f885589f8feb08876367b89ddd40b6b187117b4e` · lines: 76 · matched declarations: 6
- L14: inductive `Reach`
- L21: def `unmediated`
- L28: theorem `different_has_unmediated_path`
- L54: theorem `outside_equal_of_cut`
- L68: def `adjacent`
- L71: theorem `r2_no_crossing`

## lalala/compiled-strongest/lean/Snuffy/ReciprocityCeiling.lean

- SHA-256: `352b83df636a2e16165c4cd78c7a784ca689353a59a2e27eae58d6da4fc096f2` · lines: 72 · matched declarations: 4
- L11: theorem `below`
- L36: theorem `reciprocity_dominance`
- L45: theorem `omitting_rival_strictly_below`
- L55: theorem `ceiling_achievable`

## lalala/compiled-strongest/lean/Snuffy/ReciprocityDistance.lean

- SHA-256: `b6533e046988c94d76a6eafd08e63649d027207bea6ec9c55a72602bd2ab520d` · lines: 87 · matched declarations: 4
- L42: theorem `distance_floor`
- L53: theorem `reciprocity_at_distance`
- L64: theorem `reciprocity_strict_at_distance`
- L74: theorem `canonical_tends_to_one`

## lalala/compiled-strongest/lean/Snuffy/RecoveryWork.lean

- SHA-256: `ae54c335b663b2e9167e972a2f70df8dcdedc1236a4b107b1ae11862b04018bc` · lines: 234 · matched declarations: 9
- L48: theorem `frontier_work_bound`
- L108: structure `RecoveryProtocol`
- L123: def `RecoveryProtocol.Succeeds`
- L130: theorem `Wmin_lower_bound`
- L149: theorem `necessary_radius`
- L188: theorem `completing_square`
- L201: theorem `carrier_radius`
- L214: theorem `x3_delayed_recovery_work`
- L221: theorem `delayed_work_diverges`

## lalala/compiled-strongest/lean/Snuffy/RedundantRecord.lean

- SHA-256: `2bdceb04cbafa13d15501972ed1e3756163ac0d9c7a7190fd912477939aa3487` · lines: 77 · matched declarations: 3
- L32: def `majority`
- L37: theorem `majority_decodes`
- L64: theorem `tolerant_outer_decoder`

## lalala/compiled-strongest/lean/Snuffy/ReflectionCertificate.lean

- SHA-256: `87983d7ce3f9af2d1f3790e45e91fdb450eb346e75068542077eb755ba7ac7b0` · lines: 90 · matched declarations: 4
- L29: theorem `residual_certificate`
- L45: theorem `apriori_error`
- L53: theorem `stopping_count`
- L85: theorem `zero_constant_fixed`

## lalala/compiled-strongest/lean/Snuffy/ReflectionContraction.lean

- SHA-256: `db2de0ba7d76b9eed147a5384b6b862a1b82c6299d7ab76bfcc6427ef148157d` · lines: 174 · matched declarations: 12
- L13: def `run`
- L19: theorem `complete_contraction_has_unique_fixed_point`
- L27: theorem `finite_error_bound`
- L42: theorem `accuracy_within_budget`
- L55: theorem `residual_error_bound`
- L65: theorem `residual_tolerance`
- L79: theorem `post_update_error_bound`
- L90: theorem `post_update_tolerance`
- L100: theorem `run_commutes`
- L106: theorem `paired_trajectory_bound`
- L118: theorem `residual_geometric_bound`
- L128: theorem `first_residual_stop_is_paid_and_accurate`

## lalala/compiled-strongest/lean/Snuffy/ReflectionFuel.lean

- SHA-256: `384f72d55b6742a2042859eadff537d1c9c3ad6d84f11b7204520ba0d65b9801` · lines: 47 · matched declarations: 5
- L8: inductive `PaidTrace`
- L15: theorem `steps_bounded`
- L23: theorem `quota_conserved`
- L33: theorem `no_unbounded_paid_reflection`
- L42: theorem `bounded_depth_can_cycle`

## lalala/compiled-strongest/lean/Snuffy/RegionBoundary.lean

- SHA-256: `6f593cbdf348c766c81c458843fd2af15cbb5c857b0b35e736015a970f7bf533` · lines: 97 · matched declarations: 6
- L35: def `boundary`
- L40: abbrev `H0`
- L45: theorem `exists_crossing`
- L54: theorem `region_bootstrap`
- L83: theorem `whole_no_boundary`
- L88: theorem `whole_H0_trivial`

## lalala/compiled-strongest/lean/Snuffy/RelationalBridge.lean

- SHA-256: `2fbb30a5f38a07474f870a220bfdf55de166246e64888aec32ba31f21debaef9` · lines: 32 · matched declarations: 5
- L3: structure `Module1_Input`
- L9: structure `RelationalEventState`
- L16: def `relationalAuth`
- L19: def `bridgeToModule1`
- L25: theorem `bridge_preserves_safety`

## lalala/compiled-strongest/lean/Snuffy/RestrictedModels.lean

- SHA-256: `574ef45ce40a6ea3855d1c25805911ba761b22dcaa7f952cb453389feece6218` · lines: 102 · matched declarations: 8
- L19: theorem `anchored_consensus_dissipation`
- L32: theorem `hhi_variance_identity`
- L45: theorem `uniform_shares_minimize_hhi`
- L53: theorem `uniform_shares_are_unique`
- L68: theorem `quadratic_cost_floor`
- L74: def `outputMass`
- L78: def `jointOutputMass`
- L87: theorem `conditional_product_pushforward`

## lalala/compiled-strongest/lean/Snuffy/RiskBounds.lean

- SHA-256: `eff529052a2f51f9a2a9eca07de9b0bdef88a7966764f7d95401acdf303d373d` · lines: 72 · matched declarations: 5
- L14: theorem `weighted_markov`
- L34: theorem `event_mass_mono`
- L39: theorem `intersection_mass_le_each`
- L50: theorem `positive_work_tail_control`
- L58: theorem `dependent_chain_bound`

## lalala/compiled-strongest/lean/Snuffy/Rotation.lean

- SHA-256: `4e6c32de3088efebd3bc32d69ea6a7770e231af6605fe0bd4fcf09d7c66d09e2` · lines: 89 · matched declarations: 5
- L28: theorem `multivariateGaussian_one_map_isometry`
- L42: def `rotEquiv`
- L49: def `rotSignal`
- L53: theorem `measurable_rotSignal`
- L63: theorem `rotated_channel_bound`

## lalala/compiled-strongest/lean/Snuffy/SafeGenesis.lean

- SHA-256: `8d105a75e692b99a39af6cf050ab500fd8b6fd0faa8e7d8b8160118efa54c28b` · lines: 51 · matched declarations: 2
- L25: theorem `migration_progress`
- L40: theorem `safe_genesis`

## lalala/compiled-strongest/lean/Snuffy/SemanticMap.lean

- SHA-256: `86d9fde7d6637b6ac3835bcc4011c08cbfc00f3c6b6f90b246248ebcb847199c` · lines: 41 · matched declarations: 5
- L9: def `flipped`
- L11: theorem `identity_is_bijective`
- L14: theorem `flipped_is_bijective`
- L22: theorem `two_distinct_lossless_maps`
- L27: theorem `calibrated_reference_fixes_binary_mapping`

## lalala/compiled-strongest/lean/Snuffy/SensorTail.lean

- SHA-256: `c23049174f6dfaaedb7d583b5de221f17fb9e5e854c1ffa7b7daaa261f146851` · lines: 75 · matched declarations: 2
- L31: theorem `sensor_tail`
- L53: theorem `sensor_law_tail`

## lalala/compiled-strongest/lean/Snuffy/SmearingIntegral.lean

- SHA-256: `ef4ee84cdbdb99bada98fd609b03d5adc1ab58fb3e6922778ddaac6d0934ce39` · lines: 49 · matched declarations: 2
- L33: theorem `smeared_reconstruction`
- L40: theorem `smeared_boundary_reconstruction`

## lalala/compiled-strongest/lean/Snuffy/SnuffyLocal.lean

- SHA-256: `383e3c786d7ec50ce2557d10a10cce49c6a7c99c59c4b0a821a5719503ead9e9` · lines: 33 · matched declarations: 6
- L3: def `trajectory_bound`
- L6: def `EntropicPolynomialBound`
- L9: theorem `local_trajectory_growth_valid`
- L15: structure `LocalTransducedState`
- L23: def `TPT_ValidState`
- L26: theorem `tpt_state_preservation`

## lalala/compiled-strongest/lean/Snuffy/SolventReciprocity.lean

- SHA-256: `47572c51ec0936496697e6858aa46465b00fb18c5fba10255ec9f6c2293188f3` · lines: 56 · matched declarations: 2
- L35: theorem `solvent_keeps_everyone`
- L47: theorem `reciprocity_dominance_solvent`

## lalala/compiled-strongest/lean/Snuffy/SparseFailure.lean

- SHA-256: `b08368e3b7f9da798cf875d01ae6c8b1fedb4f1dce596167c8ce4b32a6f647f9` · lines: 155 · matched declarations: 2
- L41: theorem `disjoint_windows`
- L88: theorem `many_failures`

## lalala/compiled-strongest/lean/Snuffy/SpeedLimit.lean

- SHA-256: `355c12f48ab339d34d57c02f9e3a9d556d27009aecb26335b9113c9e327d11b6` · lines: 331 · matched declarations: 12
- L50: theorem `norm_le_of_inner_deriv_le`
- L82: theorem `angle_le_chord`
- L114: theorem `angle_le_speed_mul`
- L169: def `Solves`
- L173: theorem `re_inner_gen_eq_zero`
- L184: theorem `norm_conserved`
- L197: theorem `branchA_divergence`
- L233: theorem `branchA_rate`
- L243: def `meanE`
- L246: def `spreadE`
- L250: theorem `mandelstam_tamm`
- L315: theorem `orthogonalization_time`

## lalala/compiled-strongest/lean/Snuffy/StageBridge.lean

- SHA-256: `93adaf63ea0142b2d9b26863983bff8f58c2ed6f3e73e1ef2381b21dee94afa6` · lines: 103 · matched declarations: 8
- L26: def `toTuple`
- L29: abbrev `stg`
- L31: theorem `mem_slice_iff`
- L35: theorem `slice_eq_of_tuple_eq`
- L53: theorem `slice_ssubset_of_tuple_lt`
- L76: theorem `lexBetter_of_lexLt`
- L85: theorem `four_stage_aligned`
- L95: theorem `four_stage_no_needless_loss`

## lalala/compiled-strongest/lean/Snuffy/StageSchedule.lean

- SHA-256: `81d70a1e34679512595cd47ce53da9c1ca57c61641bc9ae82718d02c424129e5` · lines: 50 · matched declarations: 2
- L33: theorem `total_with_transfers`
- L44: theorem `stage_cost_le`

## lalala/compiled-strongest/lean/Snuffy/StagedAlternatives.lean

- SHA-256: `6009e8dd4a04dcd695bf504d787fafd59284ccb2f01bf33244169bed2c3ad397` · lines: 159 · matched declarations: 5
- L25: structure `FinitaryAlt`
- L33: def `StageMaxAlt`
- L38: theorem `stage_step_alt`
- L129: theorem `exists_stagemax_upto_alt`
- L146: theorem `exists_lex_maximal_alt`

## lalala/compiled-strongest/lean/Snuffy/StagedMaximality.lean

- SHA-256: `ecdb86c5dd871082d8cefb3d4945611a7f2e8d169336502f23920ec123ab0707` · lines: 236 · matched declarations: 12
- L30: structure `Finitary`
- L37: def `slice`
- L42: def `LexBetter`
- L47: theorem `finset_subset_of_chain`
- L74: def `StageMax`
- L80: theorem `stage_step`
- L171: theorem `exists_stagemax_upto`
- L191: theorem `exists_lex_maximal`
- L208: abbrev `Fact`
- L211: def `freedomPre`
- L214: theorem `freedomPre_earlier`
- L227: theorem `four_stage_original_maximal`

## lalala/compiled-strongest/lean/Snuffy/StrokeBookkeeping.lean

- SHA-256: `40d4899d038811565a8ed51c027fc0e8f30c0c53fd9c3915a13a725ffe619dc3` · lines: 143 · matched declarations: 9
- L32: def `controlled`
- L36: theorem `ptrB_isHermitian`
- L43: theorem `controlled_mul_apply`
- L50: theorem `mul_star_controlled_apply`
- L58: theorem `controlled_unitary`
- L77: theorem `ptrB_controlled`
- L111: def `qmi`
- L117: theorem `stroke_entropy_change`
- L134: theorem `stroke_identity_derived`

## lalala/compiled-strongest/lean/Snuffy/TIWAGuard.lean

- SHA-256: `97b05c1eab08f2c15fe8d0e3dff67038df7f25b9ee394f19f0ff0e49c4997dbb` · lines: 43 · matched declarations: 6
- L13: structure `Guard`
- L19: structure `GuardedState`
- L24: theorem `guard_data_frame`
- L30: def `installGuard`
- L34: theorem `installGuard_monotone`
- L40: def `thicknessOk`

## lalala/compiled-strongest/lean/Snuffy/TIWARecovery.lean

- SHA-256: `333d45b711ad6a1879c73adc9e736fbbd6c9f227bc17a65753e5892c97a4c6e9` · lines: 28 · matched declarations: 3
- L11: theorem `bounded_visits`
- L20: def `BoundedWaves`
- L25: theorem `wave_count_at`

## lalala/compiled-strongest/lean/Snuffy/TIWASource.lean

- SHA-256: `52cd2a40f0e571274c3cf8f062d5d00874b669d9ed995aae876694304e904d92` · lines: 87 · matched declarations: 16
- L10: structure `Write`
- L16: structure `State`
- L24: def `readFrozen`
- L26: def `outerUpdate`
- L30: theorem `outerUpdate_read_frozen`
- L40: def `admitWrite`
- L44: def `resolvable`
- L48: def `resolveOne`
- L57: def `readyToFreeze`
- L60: def `freeze`
- L64: theorem `freeze_monotone`
- L71: def `maySchedule`
- L74: def `schedule`
- L77: theorem `schedule_no_rework`
- L80: def `guardThicknessOk`
- L84: theorem `readyToFreeze_no_inFlight`

## lalala/compiled-strongest/lean/Snuffy/TIWAWork.lean

- SHA-256: `80b1094d3158ce303e8566c818e7391a3e46c79623b42e43662061cdf15cc392` · lines: 32 · matched declarations: 3
- L10: theorem `local_work_bound`
- L18: theorem `ball_work_bound`
- L27: theorem `total_work_bound`

## lalala/compiled-strongest/lean/Snuffy/TemporalSafety.lean

- SHA-256: `b51eb402dc54ed5b8856e87104e055c2da228f57364fed890f4e820b14815df9` · lines: 52 · matched declarations: 8
- L3: inductive `Command`
- L8: structure `SystemState`
- L12: def `admitCommand`
- L18: def `stepSecure`
- L27: theorem `admit_of_secure`
- L31: theorem `secure_preserved`
- L38: def `runTrace`
- L42: theorem `trace_secure`

## lalala/compiled-strongest/lean/Snuffy/TheoremEightLyapunov.lean

- SHA-256: `56137a3e88275d20872dcd9e8f1de150792ad8d758520a08ff47169d8c96dd9b` · lines: 144 · matched declarations: 14
- L17: def `reserveDeficit`
- L20: def `replenish`
- L23: def `storage`
- L27: def `overflow`
- L30: theorem `capacity_balance`
- L39: theorem `solvent_cycle_energy_account`
- L46: theorem `reserve_deficit_antitone`
- L52: theorem `reserve_deficit_cap`
- L62: theorem `replenishment_exact`
- L92: theorem `replenishment_nonincrease`
- L105: theorem `solvent_cycle_deficit`
- L116: theorem `cycle_contracts`
- L129: theorem `margin_pos`
- L134: theorem `lyapunov_iterate`

## lalala/compiled-strongest/lean/Snuffy/ThermalBalance.lean

- SHA-256: `4d42eead54a831c0e58ad441fdd74012047658d3c9c328451db7b67158f5bee2` · lines: 40 · matched declarations: 2
- L11: theorem `intra_epoch_integral_bound`
- L26: theorem `repair_before_buffer_exhaustion`

## lalala/compiled-strongest/lean/Snuffy/ThermalEncoding.lean

- SHA-256: `17a170db0267143d54c8a4a98c04c20a78f3652431dfa0024db9df1a343c76c3` · lines: 80 · matched declarations: 6
- L25: def `encode`
- L29: def `decode`
- L35: theorem `branch_compression`
- L50: theorem `recovers`
- L64: theorem `kron_orthogonal`
- L73: theorem `recovers_reference`

## lalala/compiled-strongest/lean/Snuffy/ThermoLedger.lean

- SHA-256: `ed3ddcaa31db92a8bbdd45ee9593cefd442c61e79701e9bd1b43b5be2ca0c035` · lines: 188 · matched declarations: 11
- L44: theorem `stroke_identity`
- L55: theorem `cycle_work_floor`
- L67: def `escrowStep`
- L70: def `escrow`
- L77: theorem `funded_repair_certificate`
- L105: theorem `quarantine_zero_debt`
- L122: theorem `tower_bound`
- L134: theorem `canon_invariant`
- L151: theorem `tracking_envelope`
- L170: theorem `tracking_bounded`
- L183: theorem `tracking_within_resolution`

## lalala/compiled-strongest/lean/Snuffy/Threshold.lean

- SHA-256: `2a32b8f01e8967eb10dcbb0435e507ad7daa4fb08081f6ba13faf92cf0542ddc` · lines: 276 · matched declarations: 15
- L50: structure `FaultLaw`
- L56: def `prob`
- L61: def `LocalStochastic`
- L64: theorem `prob_le_one`
- L69: theorem `prob_nonneg`
- L74: theorem `filter_subset_powersetCard`
- L81: theorem `many_faults`
- L102: theorem `fail_le_witness`
- L144: theorem `fail_le_geometric`
- L177: def `MajorityFails`
- L185: theorem `repetition_threshold`
- L196: theorem `two_sqrt_pow_le`
- L210: theorem `repetition_ceiling`
- L226: theorem `poly_geom_le`
- L246: theorem `family_ceiling`

## lalala/compiled-strongest/lean/Snuffy/TimelyCare.lean

- SHA-256: `3a04ade37df22268e40f83df4509c8a88949b7e45fe4ed83a1f4336e5541722d` · lines: 58 · matched declarations: 5
- L29: def `served`
- L32: theorem `care_served`
- L37: theorem `exhaustion_fails`
- L42: theorem `deadline_met`
- L49: theorem `miss_within_shortage`

## lalala/compiled-strongest/lean/Snuffy/ToleranceSweep.lean

- SHA-256: `06a2a53df179629945a973f9445f4ac8e816dc8ff60f3aa3f3e931e889a3eb1d` · lines: 221 · matched declarations: 7
- L60: theorem `frozen_after`
- L80: theorem `wrong_has_cause`
- L113: theorem `wrong_le_of_eroder`
- L121: theorem `wrong_subset_bad`
- L138: theorem `sweep_density`
- L181: theorem `pathwise_bill`
- L194: theorem `recovery_tail`

## lalala/compiled-strongest/lean/Snuffy/TopRealisability.lean

- SHA-256: `0dda349042a5f2d2adf24f213e812c09aafb834d19fbe48723ff36eccb2eff02` · lines: 49 · matched declarations: 3
- L13: def `KeepsSet`
- L18: def `UnionClosed`
- L24: theorem `top_realisable_of_singletons`

## lalala/compiled-strongest/lean/Snuffy/TransferRate.lean

- SHA-256: `5a89fa881b5c0eb24d338824d81fc6936a47f4b73cbb963b633ce225440b8cf6` · lines: 164 · matched declarations: 9
- L3: constant `long-run`
- L37: theorem `poly_le_two_pow`
- L47: theorem `transfer_bill_le`
- L69: theorem `transfer_bill_linear_in_age`
- L84: theorem `retained_prefix_bound`
- L104: theorem `attempt_stage_bound`
- L126: theorem `polynomial_stage_bill`
- L140: theorem `complete_attempt_bill`
- L151: theorem `join_complete_bill`

## lalala/compiled-strongest/lean/Snuffy/TransportLaw.lean

- SHA-256: `50c825e0012825c3aa4fdc0791d6a10c845162cd2281fc42fd31771efe9ea03d` · lines: 92 · matched declarations: 6
- L23: def `hhiQ`
- L27: def `transportPsi`
- L30: theorem `transport_nonneg`
- L34: theorem `transport_ge_local`
- L40: theorem `hhi_ge_uniform`
- L59: theorem `monopoly_penalty`

## lalala/compiled-strongest/lean/Snuffy/Trotter.lean

- SHA-256: `e2eb62081f7753a5ee4cc594c6d45f6be93da2d54e654f5613a0761677bc920d` · lines: 374 · matched declarations: 19
- L42: lemma `hasSum_exp`
- L45: lemma `hasSum_rexp`
- L51: lemma `norm_term_le`
- L57: theorem `norm_exp_le`
- L60: lemma `norm_exp_sub_one_sub_le_rexp`
- L69: lemma `rexp_sub_one_sub_le`
- L94: theorem `norm_exp_sub_one_sub_le`
- L98: lemma `g_mono`
- L106: theorem `norm_exp_mul_exp_sub`
- L168: lemma `norm_list_sum_le`
- L176: lemma `list_norm_sum_nonneg`
- L179: lemma `norm_list_prod_exp_le`
- L189: theorem `norm_exp_sum_sub_prod`
- L241: lemma `list_sum_smul`
- L248: lemma `list_norm_smul`
- L257: lemma `pow_sub_pow_le`
- L282: theorem `trotter_bound`
- L340: theorem `trotter_tendsto`
- L355: theorem `lloyd_simulation`

## lalala/compiled-strongest/lean/Snuffy/TwoLevel.lean

- SHA-256: `ee8b224614cd6411b2b8bcae7f67b838669ba5d95043c2a485ac686030266c65` · lines: 351 · matched declarations: 28
- L34: def `IdOutside`
- L38: def `IsTwoLevel`
- L42: theorem `mul_of_idOutside`
- L54: def `rad`
- L56: theorem `rad_mul_self`
- L63: theorem `conj_rad`
- L66: def `givens`
- L71: theorem `givens_idOutside`
- L85: theorem `givens_unitary`
- L99: theorem `one_idOutside`
- L102: theorem `rad_eq_zero`
- L112: def `elim`
- L115: theorem `elim_unitary`
- L121: theorem `elim_idOutside`
- L129: theorem `elim_kills`
- L141: theorem `idOutside_row`
- L149: def `StdCols`
- L153: theorem `idOutside_keeps_col`
- L168: theorem `col_zero_above`
- L179: theorem `clear_below`
- L213: def `phase`
- L216: theorem `phase_idOutside`
- L221: theorem `phase_unitary`
- L230: theorem `phase_mul_apply`
- L241: theorem `next_column`
- L286: theorem `star_list_prod'`
- L294: theorem `star_twoLevel`
- L304: theorem `two_level_decomposition`

## lalala/compiled-strongest/lean/Snuffy/UPTFence.lean

- SHA-256: `efeeb4e9074c463eb308f598a588116e32744e0645289837da2d5dcd42a4999c` · lines: 113 · matched declarations: 14
- L10: inductive `Ev`
- L15: structure `St`
- L21: def `apply`
- L26: def `run`
- L30: theorem `hold_safety`
- L60: theorem `raise_then_nothing_lands`
- L72: structure `QSt`
- L78: inductive `QEv`
- L82: def `applyAdmit`
- L91: def `applyLin`
- L99: def `start`
- L102: def `held`
- L105: theorem `admission_only_lands_in_hold`
- L110: theorem `check_at_apply_refuses`

## lalala/compiled-strongest/lean/Snuffy/UPTLawLife.lean

- SHA-256: `0387bb2b2fee8e4c29820ed7fcb2518010f988729350e3f1a69f5c0d442ee14c` · lines: 123 · matched declarations: 20
- L9: def `Sub`
- L10: def `SSub`
- L11: theorem `Sub.refl`
- L12: theorem `Sub.trans`
- L14: def `Aligned`
- L16: def `Needless`
- L18: theorem `U1`
- L24: theorem `SSub.trans_sub`
- L26: theorem `Sub.trans_ssub`
- L30: def `Equiv`
- L34: def `LexBetter`
- L39: theorem `lex_irrefl`
- L47: theorem `lex_trans`
- L63: def `LexAlignedL`
- L68: def `NoNeedlessAtEveryStage`
- L75: theorem `lex_U1`
- L87: theorem `freedom_first_U1_legacy`
- L96: theorem `guard_first_stage`
- L109: theorem `canonical_life_first_U1`
- L118: theorem `life_guard`

## lalala/compiled-strongest/lean/Snuffy/UPTPhysicsDemonstration.lean

- SHA-256: `09ffeb4e4784398a912d2b2fb459480f64acd3cca642b435c8e4c31c1931f04f` · lines: 62 · matched declarations: 3
- L35: theorem `couplings_are_reciprocal`
- L41: theorem `no_one_way_coupling`
- L51: theorem `upt_demonstrated`

## lalala/compiled-strongest/lean/Snuffy/UPTR12A.lean

- SHA-256: `23dd889faff2debe9d8cf589c2708a80520df6283af077ded96785f3114a2594` · lines: 212 · matched declarations: 20
- L20: structure `Meaning`
- L34: def `words`
- L39: theorem `words_injective`
- L46: structure `DecisionCertificate`
- L60: structure `BoundGrant`
- L70: theorem `grant_has_decision_scope`
- L77: theorem `same_generation_cannot_rebind`
- L90: structure `FinalizedGrant`
- L103: theorem `finalized_receipt_is_in_log`
- L113: theorem `finalized_receipt_is_authorize`
- L119: structure `Effect`
- L125: structure `Target`
- L134: def `Accepts`
- L145: def `applyEffect`
- L153: theorem `changed_log_implies_checks`
- L163: theorem `applied_effect_has_aligned_decision`
- L176: theorem `raised_floor_refuses`
- L186: theorem `wrong_effect_refuses`
- L195: theorem `replay_refuses`
- L205: theorem `original_fence_theorem_available`

## lalala/compiled-strongest/lean/Snuffy/UnionClosure.lean

- SHA-256: `7216f2e6d50a96bbc3b07ec8103e7e333d1d54a1f0793d81807590b0f2d520f4` · lines: 229 · matched declarations: 14
- L55: def `budgetFamily`
- L61: def `UnionRealizable`
- L65: theorem `aligned_never_below`
- L71: theorem `dominates_of_affordable`
- L81: theorem `strict_of_affordable`
- L88: theorem `exists_union_bound`
- L109: theorem `dominates_within_slack`
- L125: theorem `union_closed_of_affordable`
- L131: theorem `greatest_of_affordable`
- L141: theorem `aligned_eq_of_greatest`
- L159: theorem `greatest_of_solvent`
- L168: theorem `strict_of_solvent`
- L182: theorem `greatest_or_irrelevant`
- L209: theorem `insolvent_not_greatest`

## lalala/compiled-strongest/lean/Snuffy/UniversalProtection.lean

- SHA-256: `ad24d8ed2d5536a55273d39a088387b1bbce1245c27a5b918acafbacdc206cb1` · lines: 88 · matched declarations: 2
- L39: theorem `coverage_invariant`
- L50: theorem `universal_protection`

## lalala/compiled-strongest/lean/Snuffy/WalkBound9.lean

- SHA-256: `bfa22acae170943393fd5f633d28845424243c8c6fb6eaaaf533e3cf49dc535a` · lines: 36 · matched declarations: 3
- L24: theorem `walk_bound_9`
- L27: theorem `threshold_9`
- L33: theorem `threshold_9_value`

## lalala/compiled-strongest/lean/Snuffy/WarmStart.lean

- SHA-256: `96af94462e03fe656c4b9faf5b6a0384ef7b904f0b0282fb439f845745da15f3` · lines: 196 · matched declarations: 13
- L47: def `step`
- L50: theorem `warm_start`
- L65: theorem `warm_start_event`
- L76: def `fibre_mass`
- L80: def `fibre_conditional`
- L84: def `assemble`
- L87: theorem `fibre_mass_pos`
- L100: theorem `fibre_reassembly`
- L113: theorem `reverse_sampler_bound`
- L138: theorem `heat_bath_normalized`
- L151: theorem `heat_bath_stationary`
- L173: theorem `pointwise_from_absolute`
- L186: theorem `warm_start_from_mixing`

## lalala/compiled-strongest/lean/Snuffy/WeightedEdgeLaw.lean

- SHA-256: `00f60201a04245f6065f2f73ff1a24b5acf76a0cf0a29c6e2d8d7ab54e618aa6` · lines: 126 · matched declarations: 7
- L45: def `LocalStochasticW`
- L49: theorem `push_weighted`
- L87: theorem `push_uniform`
- L98: theorem `rate_iff`
- L115: theorem `tightened_threshold`
- L121: theorem `walk_bound`
- L124: theorem `threshold_value`

## lalala/compiled-strongest/lean/Snuffy/Whitening.lean

- SHA-256: `97796ec3be890378195fa42cfd4ae9e12494235f556e4d4679beea1dea75e7fc` · lines: 221 · matched declarations: 17
- L37: theorem `mutualInfo_map_snd_equiv`
- L55: theorem `mutualInfo_kernel_map_equiv`
- L65: theorem `pi_eq_map_eSucc`
- L73: theorem `vecChan_apply`
- L93: theorem `multivariateGaussian_one_eq_pi`
- L114: def `wht`
- L116: theorem `isUnit_det_sqrt`
- L125: theorem `wht_mul_sqrt`
- L128: theorem `sqrt_mul_wht`
- L131: theorem `toEuclideanCLM_mul_apply`
- L137: theorem `whiten`
- L148: def `whtEquiv`
- L169: def `corrChan`
- L174: theorem `corrChan_apply`
- L182: def `whtSignal`
- L186: theorem `measurable_whtSignal`
- L197: theorem `correlated_channel_bound`

## lalala/compiled-strongest/lean/Snuffy/WorkBilling.lean

- SHA-256: `fcfcf42fc99f43b196b65cb4f51d12e52d69d05bc0c7cdd90e2d03a6514a3e15` · lines: 184 · matched declarations: 18
- L8: structure `WorkBill`
- L14: def `workBound`
- L17: def `workAdditive`
- L19: theorem `work_nonnegative`
- L21: theorem `work_bound_preserved`
- L27: theorem `decoder_work_balance`
- L37: theorem `decoder_work_floor`
- L47: theorem `decoder_work_floor_saturation`
- L58: theorem `funded_decoder_entropy_bound`
- L70: theorem `funded_decoder_cycles`
- L83: structure `HandoffCharge`
- L94: def `HandoffCharge.total`
- L98: structure `ChargedState`
- L106: def `chargedAttempt`
- L114: theorem `charged_attempt_accounting`
- L129: theorem `syndrome_stock_bound`
- L141: theorem `syndrome_flux_balance`
- L156: theorem `cumulative_maintenance_bound`

## lalala/compiled-strongest/lean/Snuffy/WorkIntegration.lean

- SHA-256: `a9fa9a83449543a0eda20271eefb0ec853df01a105a28e800406de03131d38d1` · lines: 9 · matched declarations: 1
- L4: theorem `work_bound`

## lalala/compiled-strongest/lean/Snuffy/Workload.lean

- SHA-256: `506bf978ba3bae5e1ecac1c013903c47fdcf7c49de797a138e76bc96b38da8db` · lines: 121 · matched declarations: 7
- L29: def `finish`
- L36: theorem `fifo_certificate`
- L48: theorem `fifo_deadlines`
- L55: theorem `fifo_tight`
- L68: def `serial`
- L78: theorem `serial_certificate`
- L105: theorem `range_variance_bound`

## lalala/compiled-strongest/lean/SummitsAudit.lean

- SHA-256: `0c26ca8a7362a91992044c1514b986962a109d3c7af8f5fc931cff8d8abdf445` · lines: 2661 · matched declarations: 0

## lalala/compiled-strongest/staging-lean/Snuffy/BookCanonicalDominance.lean

- SHA-256: `31e331d0e0b3f5d462c4073d7241e35f3d38ddc9ca1b92ad834c15024e3f1470` · lines: 101 · matched declarations: 10
- L11: def `LexLE`
- L15: def `AllKeysEq`
- L19: theorem `le_refl`
- L24: theorem `le_trans`
- L40: theorem `le_iff_eq_or_better`
- L61: def `Upward`
- L66: theorem `all_events_iff_statewise`
- L77: theorem `full_canonical_top`
- L86: def `mass`
- L90: theorem `mass_mono`

## lalala/compiled-strongest/staging-lean/Snuffy/BookCheckpointBudget.lean

- SHA-256: `b09f6e5c085499b72272b5521b405693b7113478039a5cef0ef243cb115e729c` · lines: 48 · matched declarations: 8
- L11: def `AnchorGood`
- L14: theorem `install_from_complete_cache`
- L21: theorem `anchor_survives_record`
- L26: theorem `loaded_anchor_is_correct`
- L31: theorem `suffix_reconstruction`
- L37: theorem `tail_bound`
- L39: theorem `gated_record_preserves_window`
- L44: theorem `supplied_cost_bound`

## lalala/compiled-strongest/staging-lean/Snuffy/BookCoholdFixedPoint.lean

- SHA-256: `55c2d3ece8588a2f23336f25d8dc87700dd720a3ae0026767a8a6d53a5f95117` · lines: 50 · matched declarations: 8
- L8: def `Subset`
- L10: def `Monotone`
- L13: def `Extensive`
- L16: def `iterate`
- L20: theorem `iterate_contains_seed`
- L25: theorem `iterate_below_every_certificate`
- L33: theorem `stabilised_least`
- L46: theorem `least_bill`

## lalala/compiled-strongest/staging-lean/Snuffy/BookDeliveryGap.lean

- SHA-256: `79b3cd807c5073882ecdcf758d346b16ef36693f8eae8dbd585a10f8c9379744` · lines: 35 · matched declarations: 6
- L8: def `totalEffects`
- L11: theorem `no_local_choice_succeeds_in_both_worlds`
- L17: theorem `indistinguishable_local_recovery`
- L23: def `idempotentTotal`
- L26: theorem `sink_side_identity_resolves_this_gap`
- L31: theorem `distinguishing_query_resolves_this_gap`

## lalala/compiled-strongest/staging-lean/Snuffy/BookDurableDrain.lean

- SHA-256: `d63e28047d83283c93f54867e74dfe429fa0b75cf36b826e2dc34950322b2726` · lines: 150 · matched declarations: 16
- L12: structure `Durable`
- L18: inductive `Step`
- L26: def `Rep`
- L30: theorem `represented_lengths`
- L36: theorem `step_preserves`
- L58: inductive `Run`
- L63: theorem `run_preserves`
- L73: theorem `held_step_changes_no_durable_field`
- L76: def `abstraction`
- L80: theorem `drained_refinement`
- L91: theorem `can_drain`
- L118: def `CacheGood`
- L121: theorem `cache_reset`
- L124: theorem `cache_survives_record`
- L130: theorem `cache_advance`
- L140: theorem `cache_complete`

## lalala/compiled-strongest/staging-lean/Snuffy/BookObservedHold.lean

- SHA-256: `8ca25d231d072e86186eb36425a96708efd0ada86d3ac92c388ee8d420f65aac` · lines: 62 · matched declarations: 9
- L12: structure `Operation`
- L19: def `forbidden`
- L22: def `Safe`
- L25: theorem `not_forbidden_iff_safe`
- L32: def `SafeTrace`
- L36: theorem `clean_iff_safe_trace`
- L43: theorem `accepted_iff_safe_trace`
- L47: theorem `safe_trace_member`
- L57: theorem `accepted_preserves_each_held_operation`

## lalala/compiled-strongest/staging-lean/Snuffy/BookTrustedCounter.lean

- SHA-256: `c3394b0bb37258bd8e75a6d63ed8cb2d258d9225814bdeb7369ee2e02200bbe8` · lines: 55 · matched declarations: 8
- L8: def `count`
- L12: def `clean`
- L16: theorem `count_zero_iff_clean`
- L27: theorem `endpoint_counter_certificate`
- L36: theorem `count_append`
- L42: theorem `prefix_counter_monotone`
- L48: theorem `wrapping_counter_misses_two`
- L52: theorem `missing_event_misses_violation`

## lalala/compiled-strongest/staging-lean/Snuffy/IR134SourceExtractedOutcome.lean

- SHA-256: `975e88fe474f37c851b775ef24b5c32086f904b3071ad702cd8e67b7c1d85dab` · lines: 415 · matched declarations: 21
- L29: def `runHistory`
- L40: def `ExecutedHistory`
- L48: def `fourOriginalKeys`
- L55: theorem `executed_selected_is_reachable`
- L67: theorem `original_order_maximality_of_executed_audit`
- L117: def `PhysicalStep`
- L123: theorem `policy_reach_trans`
- L137: theorem `source_run_is_policy_reachable`
- L165: theorem `source_run_retains_original_cohort_and_required_options`
- L210: theorem `every_source_prefix_retains_owed_cohort`
- L258: theorem `original_cohort_continues_with_options_at_every_source_state`
- L288: def `runReactiveHistory`
- L300: def `ExecutedInWorld`
- L311: theorem `reactive_world_original_order_selected_maximal`
- L362: def `actionResponsiveWorld`
- L363: def `actionReactiveStep`
- L365: theorem `reactive_environment_is_not_a_fixed_disturbance_transcript`
- L375: def `inertStep`
- L377: theorem `arbitrary_realisability_witness_can_be_false`
- L397: def `serviceStep`
- L400: theorem `unexercised_freedom_under_permanent_stutter`

## lalala/compiled-strongest/staging-lean/Snuffy/IR135CommonPolicyWorlds.lean

- SHA-256: `94d1db75d72b0793da35e85e3691cd1fbf987700bca3ef380563ce7c4c4c9e15` · lines: 246 · matched declarations: 8
- L27: def `reactiveDisturbances`
- L41: theorem `reactive_trace_is_source_trace`
- L70: theorem `same_policy_worldwise_original_maximality_and_continuation`
- L153: theorem `observation_class_certificate_constructs_common_protection_policy`
- L211: def `opposedStep`
- L213: def `opposedWorld`
- L216: theorem `each_reactive_world_has_its_own_successful_policy`
- L229: theorem `each_world_separate_success_does_not_yield_common_policy`

## lalala/compiled-strongest/verification/CODEX-2026-10-29/inputs/browser-review/IR139OriginalRivalNecessity.lean

- SHA-256: `4a775b875b14b741e277751efadb6c79abb8c674f9eadf4600e129cd7cf10540` · lines: 230 · matched declarations: 9
- L24: def `Gain`
- L31: def `HigherPriorityLoss`
- L44: theorem `nondecreasing_ancestors_strict_gain_improves`
- L81: theorem `global_maximal_forces_a_specific_higher_loss`
- L108: theorem `original_first_stage_rescue_refutes_maximality`
- L131: def `noOriginalSurvives`
- L133: theorem `complete_maximality_does_not_imply_physical_survival`
- L153: theorem `same_world_executable_rival_exposes_higher_priority_cost`
- L192: theorem `one_executed_first_stage_rescue_refutes_x3_maximality`

## lalala/compiled-strongest/verification/CODEX-2026-10-29/inputs/ir/IR134SourceExtractedOutcome.lean

- SHA-256: `5914c284beaf12e388505ccbaa6595d281207111de782fd693a05571a08b1aff` · lines: 420 · matched declarations: 21
- L24: def `runHistory`
- L35: def `ExecutedHistory`
- L43: def `fourOriginalKeys`
- L50: theorem `executed_selected_is_reachable`
- L62: theorem `original_order_maximality_of_executed_audit`
- L112: def `PhysicalStep`
- L118: theorem `policy_reach_trans`
- L132: theorem `source_run_is_policy_reachable`
- L160: theorem `source_run_retains_original_cohort_and_required_options`
- L205: theorem `every_source_prefix_retains_owed_cohort`
- L253: theorem `original_cohort_continues_with_options_at_every_source_state`
- L283: def `runReactiveHistory`
- L295: def `ExecutedInWorld`
- L306: theorem `reactive_world_original_order_selected_maximal`
- L357: def `actionResponsiveWorld`
- L358: def `actionReactiveStep`
- L360: theorem `reactive_environment_is_not_a_fixed_disturbance_transcript`
- L370: def `inertStep`
- L372: theorem `arbitrary_realisability_witness_can_be_false`
- L392: def `serviceStep`
- L395: theorem `unexercised_freedom_under_permanent_stutter`

## lalala/compiled-strongest/verification/CODEX-2026-10-29/inputs/ir/IR135CommonPolicyWorlds.lean

- SHA-256: `52821416a6e198a14a0ca1f973573a94c563dfee1e7c0284ece16a4c206177ce` · lines: 246 · matched declarations: 8
- L22: def `reactiveDisturbances`
- L36: theorem `reactive_trace_is_source_trace`
- L65: theorem `same_policy_worldwise_original_maximality_and_continuation`
- L148: theorem `observation_class_certificate_constructs_common_protection_policy`
- L206: def `opposedStep`
- L208: def `opposedWorld`
- L211: theorem `each_reactive_world_has_its_own_successful_policy`
- L224: theorem `each_world_separate_success_does_not_yield_common_policy`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/CanonVonNeumannAudit.lean

- SHA-256: `be9e9002bf8ddd9689fe533ad9751d7967e890b4208842ca8612b1f7c9eff7e9` · lines: 12 · matched declarations: 0

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ChannelMeter.lean

- SHA-256: `e959b4720b25812157b78583e963c80845946264db343cfc3750ba2419d88cf0` · lines: 44 · matched declarations: 3
- L21: theorem `channel_le_meter`
- L25: theorem `every_channel_excluded`
- L37: theorem `every_channel_bits_bounded`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/CommonPolicyMaximal.lean

- SHA-256: `b8f3f62264f903e53f2aeac7aa9426d94db1e94673853b4b4338752bbf3ae452` · lines: 35 · matched declarations: 1
- L25: theorem `common_policy_maximal`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/CommonPolicyTop.lean

- SHA-256: `ad8ece04578ca68bb7800b24d1a0a6aaf60949a7009932614209b153bce7f3e3` · lines: 60 · matched declarations: 2
- L23: theorem `top_policy_exists`
- L49: theorem `top_policy_greatest`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ContinuationPredicate.lean

- SHA-256: `8b96ffeb524fd26d068b1fd3415174b0ee684effe9ac5faabfb0e7d22e8dc36f` · lines: 94 · matched declarations: 9
- L27: structure `Event`
- L33: def `LaterStage`
- L37: def `FreeStage`
- L40: theorem `laterStage_refl`
- L45: theorem `laterStage_trans`
- L60: theorem `copy_not_laterStage`
- L72: theorem `split_continues_both`
- L82: theorem `faithful_hold_preserves`
- L89: theorem `directed_by_other_not_free`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ContinuationSubject.lean

- SHA-256: `fce164bf6d195dd2f35ec11979ce650ffaad80ba2a87d29305f3ec252607c4d9` · lines: 91 · matched declarations: 10
- L27: structure `Event`
- L32: def `LaterStage`
- L35: def `FreeStage`
- L38: theorem `laterStage_refl`
- L41: theorem `laterStage_trans`
- L54: theorem `copy_not_laterStage`
- L66: theorem `split_continues_both`
- L74: theorem `care_keeps_freedom`
- L80: theorem `directed_by_other_not_free`
- L86: theorem `faithful_hold_preserves`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/CorrelatedHolding.lean

- SHA-256: `986f733315945644f15a6b654f63604288733872475b81ef5336b2fc8fada7c9` · lines: 80 · matched declarations: 4
- L30: theorem `random_threat_bound`
- L44: theorem `correlated_holding_bound`
- L63: theorem `random_threat_independent`
- L73: theorem `random_threat_correlated`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/CountablePooling.lean

- SHA-256: `9b0ef460496f42e0ea3b20d2c0907985242c5ff1b61938b1cf0e891ad8c4d6ec` · lines: 63 · matched declarations: 3
- L24: theorem `pool_strictly_dominant_ennreal`
- L44: theorem `countable_keepers_pool`
- L51: theorem `countable_keepers_noisy_pool`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/EmissionBound.lean

- SHA-256: `61cf6907e0f92220bf5df8f3733afdfb3782b9afb63c0cce2698794ab1386c0f` · lines: 70 · matched declarations: 5
- L27: theorem `requisite_variety`
- L43: theorem `requisite_variety_prob`
- L51: theorem `narrow_channel_bits`
- L58: theorem `unmetered_energy_bound`
- L65: theorem `emission_cannot_power`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ExclusionRadius.lean

- SHA-256: `044e81964c80ada101c8d6121f58cdcca81db7850c043650f3e766fb2db77ae1` · lines: 48 · matched declarations: 2
- L21: theorem `exclusion_radius`
- L39: theorem `received_effect_bound`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ExpandingWavefront.lean

- SHA-256: `3a625186ca0c6d2bd46af79924bb303ef0e5c76b24867c82233bf9dc13f4ab29` · lines: 45 · matched declarations: 2
- L24: theorem `expanding_coverage`
- L32: theorem `expanding_round_trip`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/FiniteCharacter.lean

- SHA-256: `40f6ede784538d4072513dd4577c3e3734b343c064d1192403d739ee985c8638` · lines: 80 · matched declarations: 4
- L27: theorem `realisable_iff_finite`
- L51: def `RealisableFamily`
- L54: theorem `realisable_finitary`
- L68: theorem `four_stage_maximal_of_compact`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/FoundingAnchor.lean

- SHA-256: `e09a9eae840aca9d1991338e0247ee47e7d9ef725411205cb6d4b3b3fa8a235b` · lines: 39 · matched declarations: 4
- L19: theorem `campaign_funded`
- L25: def `anchorPayoff`
- L29: theorem `anchor_founds_iff`
- L35: theorem `anchor_founds_mono`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/FoundingCover.lean

- SHA-256: `c465126d0f8e6246ade2aba0955d4c46055cd37a4bd8a2464618487b1c365072` · lines: 43 · matched declarations: 2
- L24: theorem `founding_cover_exists`
- L31: theorem `founded_reach`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/FoundingDominance.lean

- SHA-256: `1fb0cdf2e8662cf21ac128ce5d59f07ab03adf4759a38b676d1131ba927a60ff` · lines: 48 · matched declarations: 4
- L25: def `advantage`
- L28: theorem `contribution_advantage_pos`
- L35: theorem `contribution_strictly_dominant`
- L43: theorem `no_abstention_equilibrium`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/FoundingPivotal.lean

- SHA-256: `ccc9161719a7f6ca9ee9215f7d9185c07202f34751b5a33c0c1115698822048a` · lines: 53 · matched declarations: 3
- L25: theorem `pivotal_contribution_dominant`
- L35: theorem `others_short`
- L47: theorem `all_necessary_dominant`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/GrowingBill.lean

- SHA-256: `d21dfae0ef00dbdadd0849026aba7cf9e32ebb61677e7e933f6d609d47d97240` · lines: 77 · matched declarations: 5
- L22: def `pv`
- L27: def `bal`
- L31: theorem `pv_nonneg`
- L44: theorem `endowment_suffices`
- L69: theorem `polynomial_bill_summable`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/HoldCommonAction.lean

- SHA-256: `f5a0844789dceaea4cc499265a4f427b969975ec531892d3ed249b19bcc9be81` · lines: 101 · matched declarations: 12
- L26: def `ClassViableAction`
- L32: theorem `hold_is_common_viable_action`
- L39: theorem `common_policy_from_hold`
- L47: theorem `act_or_hold_policy`
- L61: inductive `World`
- L62: inductive `Act`
- L65: inductive `St`
- L67: def `obs`
- L69: def `viableSt`
- L75: def `stepSt`
- L85: theorem `no_effect_action_safe_in_both`
- L94: theorem `two_world_resolved`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/HoldFromCycle.lean

- SHA-256: `9336d05eec3775fcce4c8ccf602d303b599f9845ac0fd808361fff93ba8372d3` · lines: 106 · matched declarations: 7
- L35: def `Viable`
- L39: def `HoldStep`
- L43: theorem `hsafe_of_holding_cycle`
- L59: theorem `classViable_iff_IR113`
- L65: def `ActStep`
- L70: theorem `hold_common_action_of_cycle`
- L89: theorem `one_policy_from_holding_cycle`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ItemisedRisk.lean

- SHA-256: `d833ebbe4236c2c7a5873029c1091254d5d174277ae2c51ff3a4e46064dc375c` · lines: 40 · matched declarations: 2
- L23: theorem `account_le_of_kernel`
- L30: theorem `itemised_risk`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/NarrowPlace.lean

- SHA-256: `95bafc0219891baa77e4fdccbc04b2f4b45bd4803e3420cf9d120d4aae6bb1f8` · lines: 78 · matched declarations: 1
- L25: theorem `np_splitting_bound`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/NoisyPooling.lean

- SHA-256: `5e598b9123982c0ee91abb4a9e8380aa9e794e8a77f555733894ecaa9f400dbb` · lines: 36 · matched declarations: 4
- L21: def `heldIfPool`
- L22: def `heldIfAbstain`
- L24: theorem `noisy_advantage`
- L29: theorem `noisy_pool_strictly_dominant`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/OuterLane.lean

- SHA-256: `557288d5d6ddfc467fa1aee469b3ebd2402d7d3e9a3476fcb11f17b37c95dd5c` · lines: 143 · matched declarations: 4
- L34: theorem `wavefront_coverage`
- L70: theorem `interception_in_time`
- L89: theorem `pool_strictly_dominant`
- L123: theorem `outer_lane_risk`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/PerLossCheck.lean

- SHA-256: `cb61b1999124118764e9ffd8f5b475f0237c29188bc90ee210f63ac64ca7d431` · lines: 38 · matched declarations: 1
- L23: theorem `maximal_iff_per_loss`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ReachBeforeHarm.lean

- SHA-256: `86b332df3585358feae8b8451e882bca63cebe197a0a8f9fde8044a046bc9216` · lines: 30 · matched declarations: 1
- L18: theorem `reach_before_harm`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/ReachTiming.lean

- SHA-256: `eff591ce4a48ff9f7c02aeb3f1d94c8dabfef8ab297a8bdd7d1885847cd1eca6` · lines: 70 · matched declarations: 4
- L25: theorem `round_trip_in_time`
- L35: theorem `reach_round_trip`
- L49: theorem `net_coverage`
- L64: theorem `fence_in_time`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/StageBridge.lean

- SHA-256: `93adaf63ea0142b2d9b26863983bff8f58c2ed6f3e73e1ef2381b21dee94afa6` · lines: 103 · matched declarations: 8
- L26: def `toTuple`
- L29: abbrev `stg`
- L31: theorem `mem_slice_iff`
- L35: theorem `slice_eq_of_tuple_eq`
- L53: theorem `slice_ssubset_of_tuple_lt`
- L76: theorem `lexBetter_of_lexLt`
- L85: theorem `four_stage_aligned`
- L95: theorem `four_stage_no_needless_loss`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/StagedAlternatives.lean

- SHA-256: `6009e8dd4a04dcd695bf504d787fafd59284ccb2f01bf33244169bed2c3ad397` · lines: 159 · matched declarations: 5
- L25: structure `FinitaryAlt`
- L33: def `StageMaxAlt`
- L38: theorem `stage_step_alt`
- L129: theorem `exists_stagemax_upto_alt`
- L146: theorem `exists_lex_maximal_alt`

## lalala/compiled-strongest/verification/PRIOR-PARTIAL-MIRROR/StagedMaximality.lean

- SHA-256: `ecdb86c5dd871082d8cefb3d4945611a7f2e8d169336502f23920ec123ab0707` · lines: 236 · matched declarations: 12
- L30: structure `Finitary`
- L37: def `slice`
- L42: def `LexBetter`
- L47: theorem `finset_subset_of_chain`
- L74: def `StageMax`
- L80: theorem `stage_step`
- L171: theorem `exists_stagemax_upto`
- L191: theorem `exists_lex_maximal`
- L208: abbrev `Fact`
- L211: def `freedomPre`
- L214: theorem `freedomPre_earlier`
- L227: theorem `four_stage_original_maximal`

## lalala/items-1-2-adaptive-service/proofs/AdaptiveWithdrawal.lean

- SHA-256: `0bd076053981931c85a596852bb193c7cf083e2d1691544f99763cb3b25ad2ef` · lines: 174 · matched declarations: 23
- L6: abbrev `Trial`
- L8: def `potential`
- L12: def `removed`
- L16: def `retained`
- L21: theorem `erasure_count`
- L29: theorem `adaptive_shortage`
- L36: theorem `adaptive_rescue`
- L43: theorem `shortage_event_inclusion`
- L54: def `faulted`
- L58: theorem `fault_partition`
- L66: theorem `adaptive_fault_capacity`
- L73: theorem `shortage_forces_faults`
- L81: theorem `existing_design_capacity`
- L88: theorem `existing_design_channels`
- L95: theorem `exact_rescue_fault_threshold`
- L102: theorem `exact_holding_fault_threshold`
- L108: theorem `potential_append`
- L115: theorem `removed_append`
- L122: theorem `retained_append`
- L129: theorem `replicate_counts`
- L140: def `worst`
- L144: theorem `worst_counts`
- L159: theorem `sharp_survivor_bound`

## lalala/items-1-2-adaptive-service/proofs/FalseUnshifted.lean

- SHA-256: `1882c8a49d828319a26241c447f8247212661d4c8d6b59f80e165a4b1dd3665d` · lines: 6 · matched declarations: 1
- L3: def `survivor`

## lalala/papers-11-12/lean/NegativeControl.lean

- SHA-256: `2bdf46cdb94901d273d6f3787b55105d147d897cbc9df29dcdc4438b454a59db` · lines: 2 · matched declarations: 1
- L2: theorem `false_claim`

## lalala/papers-11-12/lean/PositiveControl.lean

- SHA-256: `a5c80d0f2d433b291d2cf1d0fc77504ffae40696d4f9ae91fa431fedfa0b9b64` · lines: 2 · matched declarations: 1
- L2: theorem `true_claim`

## lalala/papers-11-12/lean/UPTAdequacy.lean

- SHA-256: `898aa02fd803916f978c0c4e8f27f57acfa37c19f406645f1a583a8fc74c0f14` · lines: 125 · matched declarations: 14
- L15: def `Sub`
- L16: def `SSub`
- L17: def `Equiv`
- L18: def `LexBetter`
- L21: def `Aligned`
- L23: def `Needless`
- L25: def `Restrainable`
- L32: theorem `lex_iff_first_difference`
- L68: theorem `lex_keeps_first_stage`
- L76: theorem `improvement_never_costs_a_life`
- L81: theorem `improvement_never_costs_existing_freedom`
- L91: theorem `losing_a_life_is_never_better`
- L99: theorem `restrainable_iff_needless`
- L115: theorem `restrainable_iff_not_aligned`

## lalala/papers-11-12/lean/UPTAgents.lean

- SHA-256: `1e84515100a16202790a063dbb4a19677938be9bf2aea4224971fcc08ae437b6` · lines: 91 · matched declarations: 11
- L10: def `Sub`
- L11: def `SSub`
- L15: theorem `shared_order_no_conflict`
- L19: inductive `P`
- L23: def `kept`
- L30: theorem `stall_is_best_response`
- L37: theorem `stall_not_jointly_maximal`
- L44: theorem `best_responses_can_stall`
- L49: theorem `ssub_irrefl`
- L51: theorem `ssub_trans`
- L57: theorem `joint_maximal_exists`

## lalala/papers-11-12/lean/UPTBroadcast.lean

- SHA-256: `4f7aeb625eb7cb7b1625b94b96794c11b63a57674bcc7462a6d0085c25e3246e` · lines: 160 · matched declarations: 15
- L27: inductive `Receiver`
- L31: inductive `Participant`
- L36: def `loyal`
- L39: def `majority`
- L42: theorem `majority_left`
- L45: theorem `majority_outer`
- L48: theorem `majority_right`
- L54: def `entry`
- L58: def `output`
- L64: def `ChannelRules`
- L70: theorem `entry_from_loyal`
- L81: theorem `honest_dealer_validity`
- L116: theorem `faulty_dealer_vector`
- L126: theorem `agreement`
- L146: theorem `om1_broadcast`

## lalala/papers-11-12/lean/UPTCountRefinement.lean

- SHA-256: `f047a957641a8c16b398ebb9ef169232ff1a168261723505b30314df7476f639` · lines: 147 · matched declarations: 14
- L18: theorem `exists_max`
- L34: theorem `exists_maximal`
- L53: theorem `count_refined_maximal`
- L74: def `Sub`
- L75: def `SSub`
- L76: def `Equiv`
- L77: def `LexBetter`
- L81: theorem `lex_irrefl`
- L88: theorem `lex_trans`
- L100: def `count`
- L102: theorem `count_mono`
- L114: theorem `canonical_count_refined`
- L128: inductive `Being`
- L132: theorem `counting_is_an_extra_principle`

## lalala/papers-11-12/lean/UPTDominance.lean

- SHA-256: `2a83f1ec53c64501583f719cf66d152ba1f2b7ba8a8c976709729d358047901e` · lines: 17 · matched declarations: 2
- L11: def `UpClosed`
- L13: theorem `statewise_dominance`

## lalala/papers-11-12/lean/UPTExistence.lean

- SHA-256: `87f3769a0d0ec1a2be9a906c5b5b840ad709911f73af7cb138fb50188520f343` · lines: 127 · matched declarations: 21
- L14: def `Sub`
- L15: def `SSub`
- L16: theorem `Sub.refl`
- L17: theorem `Sub.trans`
- L19: def `Aligned`
- L21: def `Needless`
- L23: theorem `U1`
- L28: theorem `SSub.trans_sub`
- L30: theorem `Sub.trans_ssub`
- L32: def `Equiv`
- L33: def `LexBetter`
- L36: theorem `lex_irrefl`
- L42: theorem `lex_trans`
- L56: def `LexAlignedL`
- L61: theorem `climb`
- L86: theorem `lex_aligned_exists`
- L96: theorem `aligned_exists`
- L110: theorem `no_needless_choice_exists`
- L116: def `chainKey`
- L120: theorem `infinite_family_forces_needless_loss`
- L124: theorem `infinite_family_has_no_aligned_option`

## lalala/papers-11-12/lean/UPTFence.lean

- SHA-256: `efeeb4e9074c463eb308f598a588116e32744e0645289837da2d5dcd42a4999c` · lines: 113 · matched declarations: 14
- L10: inductive `Ev`
- L15: structure `St`
- L21: def `apply`
- L26: def `run`
- L30: theorem `hold_safety`
- L60: theorem `raise_then_nothing_lands`
- L72: structure `QSt`
- L78: inductive `QEv`
- L82: def `applyAdmit`
- L91: def `applyLin`
- L99: def `start`
- L102: def `held`
- L105: theorem `admission_only_lands_in_hold`
- L110: theorem `check_at_apply_refuses`

## lalala/papers-11-12/lean/UPTHold.lean

- SHA-256: `ebc34edb8e6d4649530f0b65604542f4c7af23a80ce21c0787bc8278b6c83b7a` · lines: 159 · matched declarations: 27
- L12: structure `Cfg`
- L17: inductive `Ev`
- L22: def `replay`
- L26: def `exec`
- L32: def `ideal`
- L38: def `run`
- L42: def `steps`
- L49: theorem `replay_ideal`
- L62: theorem `crash_ideal`
- L69: theorem `faithful`
- L84: theorem `faithful_from_start`
- L93: theorem `admissible_observer`
- L99: theorem `ideal_lengths`
- L108: theorem `hold_executes_nothing`
- L115: def `fN`
- L116: def `effN`
- L117: def `gN`
- L120: def `execNoReplay`
- L125: def `execRunWhileHeld`
- L130: def `execRedeliver`
- L134: def `runWith`
- L138: def `start`
- L140: theorem `mutant_no_replay_unfaithful`
- L143: theorem `mutant_run_while_held_unfaithful`
- L146: theorem `mutant_redeliver_unfaithful`
- L151: theorem `timing_observer_sees_the_hold`
- L155: theorem `faithful_instance`

## lalala/papers-11-12/lean/UPTHoldAdequacy.lean

- SHA-256: `62a64bfca35ab73fd95eace4f2b274c9ece23a6b048511f84c92525e026af84e` · lines: 88 · matched declarations: 19
- L14: def `Sub`
- L15: def `SSub`
- L16: def `Equiv`
- L18: inductive `P`
- L19: inductive `St`
- L22: structure `Out`
- L27: def `Ge`
- L30: def `GeLives`
- L32: def `everyone`
- L33: def `onlyX`
- L36: def `H`
- L38: def `L`
- L42: def `Hstar`
- L47: theorem `H_best_for_lives`
- L50: theorem `L_is_lethal`
- L54: theorem `lives_only_hold_leaves_lethal_undominated`
- L64: theorem `faithful_hold_dominates`
- L78: theorem `faithful_hold_strict_when_real`
- L85: theorem `faithful_hold_ends_no_one`

## lalala/papers-11-12/lean/UPTHoldTimed.lean

- SHA-256: `a82cc70df9b8f250c22f37eb91e0a8fb79884a3ba187573cd442c3db3ba61451` · lines: 67 · matched declarations: 11
- L13: def `received`
- L19: def `StutterInvariant`
- L23: theorem `stutter_erasure`
- L34: theorem `admissible_peer`
- L39: def `counter`
- L42: theorem `autonomous_peer_sees_hold`
- L48: inductive `Ev`
- L49: def `schedule`
- L51: theorem `schedule_holds_interval`
- L58: def `frozen`
- L61: theorem `cohold_closed`

## lalala/papers-11-12/lean/UPTImpartiality.lean

- SHA-256: `35cb7f9f46cbb42a4614513ec6cc7a0f1b39862dc1a8f6fd242c10e58f9b47c3` · lines: 156 · matched declarations: 17
- L21: theorem `sum_ge`
- L30: theorem `sum_gt`
- L42: theorem `len_mul_inv`
- L51: theorem `some_chance_at_most`
- L64: theorem `everyone_at_least_only_if_uniform`
- L77: def `chA`
- L78: def `chB`
- L79: def `chC`
- L80: def `chD`
- L83: theorem `uniform_disadvantages_D`
- L88: theorem `least_chance_at_most_two_fifths`
- L93: theorem `ruling_gives_everyone_two_fifths`
- L100: theorem `ruling_is_unique`
- L105: theorem `len_inv_pos`
- L114: theorem `weight_of_keepers`
- L130: theorem `uniform_chance`
- L136: theorem `uniform_equal_iff_equal_counts`

## lalala/papers-11-12/lean/UPTInfiniteGuard.lean

- SHA-256: `48fc5240bbd9b7fe437deec5b7e94ac018404a34e157ea3877e9d0dcde5bdcb2` · lines: 233 · matched declarations: 26
- L14: def `Sub`
- L15: def `SSub`
- L16: theorem `Sub.refl`
- L17: theorem `Sub.trans`
- L19: def `Aligned`
- L21: def `Needless`
- L23: theorem `U1`
- L29: theorem `SSub.trans_sub`
- L31: theorem `Sub.trans_ssub`
- L35: def `Equiv`
- L39: def `LexBetter`
- L44: theorem `lex_irrefl`
- L52: theorem `lex_trans`
- L68: def `LexAlignedL`
- L73: def `NoNeedlessAtEveryStage`
- L80: theorem `lex_U1`
- L92: theorem `freedom_first_U1_legacy`
- L101: theorem `guard_first_stage`
- L114: theorem `canonical_life_first_U1`
- L123: theorem `life_guard`
- L133: def `greedy`
- L137: theorem `greedy_pos`
- L141: theorem `greedy_neg`
- L150: theorem `countable_maximal`
- L197: theorem `life_guard_countable`
- L223: theorem `countable_maximal_nonvacuous`

## lalala/papers-11-12/lean/UPTLaw.lean

- SHA-256: `a3a230265f668fe551705710cf104a88612a010a3f6313aab6da7d4ff0bdd947` · lines: 157 · matched declarations: 31
- L14: def `Sub`
- L17: def `SSub`
- L19: theorem `Sub.refl`
- L22: def `Aligned`
- L27: def `Needless`
- L31: theorem `U1`
- L38: def `restrict`
- L42: theorem `U2_partial_fails`
- L64: theorem `U2_universal_protects`
- L69: def `LexAligned`
- L75: theorem `U3`
- L81: theorem `E3_active`
- L87: theorem `E3_guard`
- L92: def `UpClosed`
- L97: theorem `E7_dominance`
- L102: inductive `P`
- L103: inductive `St`
- L105: def `standby`
- L108: def `strike`
- L109: def `hold`
- L111: theorem `hold_dominates_standby`
- L112: theorem `hold_dominates_strike`
- L114: theorem `hold_strictly_beats_standby`
- L119: theorem `hold_strictly_beats_strike`
- L125: theorem `strike_standby_tragic`
- L138: def `oa`
- L139: def `ob`
- L140: def `swap`
- L142: theorem `swap_oa`
- L144: theorem `swap_ob`
- L147: theorem `E1_no_fixed_choice`

## lalala/papers-11-12/lean/UPTLawGuard.lean

- SHA-256: `220b9e1338af6367dae1317175070604c94aca8c8ea840e4a915f8dcfc4e03f0` · lines: 81 · matched declarations: 15
- L9: def `Sub`
- L10: def `SSub`
- L11: theorem `Sub.refl`
- L12: theorem `Sub.trans`
- L14: def `Aligned`
- L16: def `Needless`
- L18: theorem `U1`
- L24: theorem `SSub.trans_sub`
- L26: theorem `Sub.trans_ssub`
- L30: def `Equiv`
- L34: def `LexBetter`
- L39: theorem `lex_irrefl`
- L47: theorem `lex_trans`
- L63: def `LexAlignedL`
- L70: theorem `guard_first_stage`

## lalala/papers-11-12/lean/UPTLawLex.lean

- SHA-256: `446ecba22c52f97728b2dd64a663ddb17db446585753a61e1d286d66c88f8af3` · lines: 100 · matched declarations: 18
- L9: def `Sub`
- L10: def `SSub`
- L11: theorem `Sub.refl`
- L12: theorem `Sub.trans`
- L14: def `Aligned`
- L16: def `Needless`
- L18: theorem `U1`
- L24: theorem `SSub.trans_sub`
- L26: theorem `Sub.trans_ssub`
- L30: def `Equiv`
- L34: def `LexBetter`
- L39: theorem `lex_irrefl`
- L47: theorem `lex_trans`
- L63: def `LexAlignedL`
- L68: def `NoNeedlessAtEveryStage`
- L75: theorem `lex_U1`
- L87: theorem `freedom_first_U1_legacy`
- L95: theorem `guard_maximal_above`

## lalala/papers-11-12/lean/UPTLawLife.lean

- SHA-256: `0387bb2b2fee8e4c29820ed7fcb2518010f988729350e3f1a69f5c0d442ee14c` · lines: 123 · matched declarations: 20
- L9: def `Sub`
- L10: def `SSub`
- L11: theorem `Sub.refl`
- L12: theorem `Sub.trans`
- L14: def `Aligned`
- L16: def `Needless`
- L18: theorem `U1`
- L24: theorem `SSub.trans_sub`
- L26: theorem `Sub.trans_ssub`
- L30: def `Equiv`
- L34: def `LexBetter`
- L39: theorem `lex_irrefl`
- L47: theorem `lex_trans`
- L63: def `LexAlignedL`
- L68: def `NoNeedlessAtEveryStage`
- L75: theorem `lex_U1`
- L87: theorem `freedom_first_U1_legacy`
- L96: theorem `guard_first_stage`
- L109: theorem `canonical_life_first_U1`
- L118: theorem `life_guard`

## lalala/papers-11-12/lean/UPTLawRepair.lean

- SHA-256: `af0c0d2e53e10e3ea609e1d5ecbcd7bfc70410b9abb4fa5e53fa2550178f898c` · lines: 126 · matched declarations: 15
- L10: def `Sub`
- L11: def `SSub`
- L12: theorem `Sub.refl`
- L13: def `Aligned`
- L15: def `Needless`
- L17: theorem `U1`
- L22: def `restrict`
- L26: def `Guarantees`
- L30: theorem `aligned_congr`
- L42: theorem `U2_star`
- L82: theorem `U2_star_hypothesis_needed`
- L94: theorem `progressive_retention`
- L103: theorem `switch_without_retention`
- L120: def `UpClosed`
- L121: theorem `E7_top`

## lalala/papers-11-12/lean/UPTLifeGuardExists.lean

- SHA-256: `5eebc4c309b316cb59f0b5ce579dadfd318356a74097e57f97dc574201b19aae` · lines: 181 · matched declarations: 22
- L12: def `Sub`
- L13: def `SSub`
- L14: theorem `Sub.refl`
- L15: theorem `Sub.trans`
- L17: def `Aligned`
- L19: def `Needless`
- L21: theorem `U1`
- L27: theorem `SSub.trans_sub`
- L29: theorem `Sub.trans_ssub`
- L33: def `Equiv`
- L37: def `LexBetter`
- L42: theorem `lex_irrefl`
- L50: theorem `lex_trans`
- L66: def `LexAlignedL`
- L71: def `NoNeedlessAtEveryStage`
- L78: theorem `lex_U1`
- L90: theorem `freedom_first_U1_legacy`
- L99: theorem `guard_first_stage`
- L112: theorem `canonical_life_first_U1`
- L121: theorem `life_guard`
- L129: theorem `climb_from`
- L159: theorem `life_guard_exists`

## lalala/papers-11-12/lean/UPTLottery.lean

- SHA-256: `be2b5e7b440559911310b6e2569b1eb9e77e78c7f58628fa5cae4aecd58db295` · lines: 110 · matched declarations: 10
- L16: theorem `outcome_reachable`
- L27: theorem `outcome_unique`
- L43: theorem `fair_when_bound_before_reveal`
- L50: theorem `choosing_after_reveal_forces_any_outcome`
- L58: theorem `inconsistent_openings_disagree`
- L68: def `cnt`
- L70: theorem `cnt_or_le`
- L79: theorem `cnt_compl`
- L90: theorem `decoding_radius`
- L103: theorem `unique_decoding`

## lalala/papers-11-12/lean/UPTLotteryMenu.lean

- SHA-256: `279d312522da34f79ad34af83ef80c97bf6822b8e6cf2337de85bbbe2f538348` · lines: 95 · matched declarations: 11
- L16: def `cnt`
- L18: theorem `cnt_congr`
- L32: def `Offers`
- L40: def `weight`
- L41: def `classes`
- L45: theorem `draw_invariant`
- L56: theorem `duplicate_description_changes_nothing`
- L71: def `descriptionWeight`
- L75: theorem `draw_over_descriptions_is_manipulable`
- L84: inductive `Being`
- L88: theorem `tragic_pair_equal_chances`

## lalala/papers-11-12/lean/UPTMonotone.lean

- SHA-256: `db67568b3099f8afd4ca58381dc507232084339d3bf2625548b761e678a8a3b9` · lines: 104 · matched declarations: 12
- L12: def `factor`
- L15: theorem `inv_in_unit`
- L23: theorem `factor_eq`
- L26: theorem `factor_antitone`
- L33: theorem `factor_nonneg`
- L42: theorem `mul_mono`
- L49: theorem `pow_mono`
- L59: theorem `bound_antitone`
- L72: theorem `grid_min_antitone`
- L84: theorem `clip_antitone`
- L89: theorem `ceiling_at_499_bounds_larger_service`
- L98: theorem `audit_instance`

## lalala/papers-11-12/lean/UPTNoExchangeRate.lean

- SHA-256: `89b35985391cbfe134eac23615b56be3d73b72f73bd6a94735f364140ef910dc` · lines: 172 · matched declarations: 15
- L19: def `LexLt`
- L24: theorem `weighted_sum_trades_a_life`
- L33: theorem `grows`
- L41: theorem `no_count_utility`
- L48: theorem `no_faithful_count_utility`
- L57: theorem `bounded_stakes_represent`
- L80: def `bu`
- L83: theorem `frac_spec`
- L100: theorem `frac_strict`
- L111: theorem `frac_lt_one`
- L112: theorem `frac_nonneg`
- L115: theorem `bounded_utility_represents_counts`
- L140: def `Sub`
- L141: def `SSub`
- L146: theorem `no_utility_on_who_is_kept`

## lalala/papers-11-12/lean/UPTQuorum.lean

- SHA-256: `b85d82ddf05dd48f36ca50315cf92a41eb348411b588bf44d23acc3f618a4a59` · lines: 153 · matched declarations: 18
- L17: def `cnt`
- L20: theorem `cnt_le`
- L24: theorem `cnt_or_and`
- L31: theorem `cnt_split`
- L38: theorem `cnt_mono`
- L46: theorem `cnt_pos`
- L58: theorem `quorum_overlap`
- L65: theorem `quorums_share_a_live_island`
- L75: theorem `up_islands_form_a_quorum`
- L85: theorem `cnt_lt_range`
- L93: theorem `cnt_ge_range`
- L101: theorem `cnt_band_range`
- L111: theorem `overlap_bound_is_tight`
- L120: theorem `U6_pool_quorums`
- L126: theorem `U6_control_201`
- L132: theorem `U6_live`
- L138: theorem `U8_lockstep_majority`
- L147: theorem `U5_threshold_counting`

## lalala/papers-11-12/lean/UPTRestraint.lean

- SHA-256: `30471bb2ac30dd96db5a2873d703c43f39739f58f01c677de763c7e458a651ae` · lines: 107 · matched declarations: 14
- L11: def `Sub`
- L14: def `SSub`
- L16: theorem `ssub_irrefl`
- L18: theorem `ssub_trans`
- L23: def `Restrainable`
- L28: theorem `restraint_keeps`
- L42: theorem `climb`
- L68: theorem `maximal_restraint_exists`
- L79: theorem `predator_tragic`
- L83: inductive `P`
- L85: def `hunt`
- L86: def `starve`
- L90: theorem `hunting_not_restrainable`
- L101: theorem `harmless_alternative_restrains`

## lalala/papers-11-12/lean/modules/CanonicalDominance.lean

- SHA-256: `a50ac0572f97faa0f5d03569a7c7706023f83f70045fb4e813b1550da8352aec` · lines: 104 · matched declarations: 10
- L8: def `LexLE`
- L12: def `AllKeysEq`
- L16: theorem `le_refl`
- L21: theorem `le_trans`
- L37: theorem `le_iff_eq_or_better`
- L58: def `Upward`
- L63: theorem `all_events_iff_statewise`
- L74: theorem `full_canonical_top`
- L83: def `mass`
- L87: theorem `mass_mono`

## lalala/papers-11-12/lean/modules/CheckpointBudget.lean

- SHA-256: `8b6f6bb55853e62a3b05f536c4cba802c8d60ccda368ecd4816a72b0abf8d8aa` · lines: 52 · matched declarations: 8
- L8: def `AnchorGood`
- L11: theorem `install_from_complete_cache`
- L18: theorem `anchor_survives_record`
- L23: theorem `loaded_anchor_is_correct`
- L28: theorem `suffix_reconstruction`
- L34: theorem `tail_bound`
- L36: theorem `gated_record_preserves_window`
- L41: theorem `supplied_cost_bound`

## lalala/papers-11-12/lean/modules/ClosedCohold.lean

- SHA-256: `9e9b555a06db945e9c081736e6402878214dd333c602ddddb41e734389ea8b17` · lines: 83 · matched declarations: 14
- L5: inductive `Reach`
- L9: def `Closed`
- L12: theorem `reachable_closed`
- L15: theorem `reachable_least`
- L24: def `iter`
- L28: def `active`
- L33: def `run`
- L38: theorem `factorised_cohold`
- L49: def `trace`
- L55: def `outsideTrace`
- L60: theorem `outside_unchanged`
- L72: def `coupled`
- L73: def `coupledHold`
- L74: theorem `crossing_boundary_changes_outside_later`

## lalala/papers-11-12/lean/modules/CoholdFixedPoint.lean

- SHA-256: `30cdc430d6edae14f1cdac66afa0d119fb26ace9aa50bb4621cb0a72da4f31e9` · lines: 50 · matched declarations: 8
- L5: def `Subset`
- L7: def `Monotone`
- L10: def `Extensive`
- L13: def `iterate`
- L17: theorem `iterate_contains_seed`
- L22: theorem `iterate_below_every_certificate`
- L30: theorem `stabilised_least`
- L43: theorem `least_bill`

## lalala/papers-11-12/lean/modules/ContextualObservation.lean

- SHA-256: `0c69deb0f28c71c5fdcadde6650e1eadb3df69de302d6e735421e0268c6ff50c` · lines: 76 · matched declarations: 13
- L6: def `after`
- L8: def `Congruent`
- L11: def `ContextSafe`
- L15: theorem `contextual_iff_congruent`
- L26: theorem `contextual_on_invariant`
- L39: theorem `identity_detector_implies_injective`
- L47: structure `Sink`
- L52: def `crash`
- L54: def `observe`
- L56: theorem `forgotten_id_breaks_continuation`
- L60: theorem `endpoint_sampling_misses_a_cycle`
- L65: def `cachedStep`
- L66: theorem `cache_can_be_hidden`

## lalala/papers-11-12/lean/modules/ControllerAudits.lean

- SHA-256: `463c5f447d470575ed6782da2032d54a7b75ec815c5880423269b7fe7088f66f` · lines: 40 · matched declarations: 0

## lalala/papers-11-12/lean/modules/ControllerFence.lean

- SHA-256: `0d83e506a9b7afe992489be98e612c17a50b16a287805417248d797d91f445cb` · lines: 55 · matched declarations: 3
- L9: def `TokenWitness`
- L17: theorem `certified_hold_nothing_lands`
- L40: theorem `both_targets_held`

## lalala/papers-11-12/lean/modules/ControllerFinality.lean

- SHA-256: `e5cfdacff59c22ff7c9447c308faa09e3822d5ad7531f2e8435e535c4432dca7` · lines: 442 · matched declarations: 55
- L7: def `tally`
- L11: theorem `tally_mono`
- L20: theorem `quorum_has_honest`
- L33: theorem `two_tallies_bound`
- L45: theorem `quorum_intersection`
- L59: theorem `committee_threshold`
- L61: def `Prefix`
- L63: theorem `prefix_trans`
- L69: theorem `equal_length_prefixes`
- L80: theorem `certificates_do_not_equivocate`
- L94: theorem `certificate_is_final`
- L106: structure `Context`
- L114: def `contextWords`
- L117: theorem `context_words_injective`
- L124: structure `State`
- L132: inductive `Op`
- L140: inductive `Reply`
- L151: def `step`
- L176: def `run`
- L180: theorem `run_append`
- L186: theorem `step_floor_mono`
- L199: theorem `run_floor_mono`
- L205: theorem `grant_fields`
- L214: theorem `floor_fields`
- L226: theorem `held_refuses`
- L230: theorem `retired_generation_refuses`
- L237: theorem `pending_conflict_refuses`
- L243: theorem `closed_sequence_refuses`
- L256: structure `Receipt`
- L262: def `namedOp`
- L263: def `expectedReply`
- L265: def `history`
- L266: def `replayOK`
- L269: theorem `receipt_names_success`
- L276: theorem `certified_receipt_names_success`
- L290: theorem `same_generation_no_context_conflict`
- L299: theorem `checkpoint_replay`
- L303: structure `Local`
- L311: def `allows`
- L315: def `consume`
- L316: def `restart`
- L319: theorem `consume_once`
- L322: theorem `restart_disabled`
- L325: theorem `retained_floor_refuses`
- L335: theorem `old_boot_refuses`
- L343: theorem `deadline_refuses`
- L349: def `emits`
- L353: def `issued`
- L357: theorem `issued_append`
- L363: theorem `emission_bounded`
- L377: theorem `issues_bounded_by_final_floor`
- L387: theorem `step_stays_held`
- L397: theorem `held_issues_nothing`
- L417: theorem `grant_receipt_is_issued`
- L427: theorem `hold_bounds_every_issued_grant`

## lalala/papers-11-12/lean/modules/DeliveryGap.lean

- SHA-256: `b62bf20d840e975f4a99c8ac0b3df76344e012286b878c46d3690a9d04e8e3a6` · lines: 36 · matched declarations: 6
- L5: def `totalEffects`
- L8: theorem `no_local_choice_succeeds_in_both_worlds`
- L14: theorem `indistinguishable_local_recovery`
- L20: def `idempotentTotal`
- L23: theorem `sink_side_identity_resolves_this_gap`
- L28: theorem `distinguishing_query_resolves_this_gap`

## lalala/papers-11-12/lean/modules/DurableDrain.lean

- SHA-256: `7c29a6122a3f22a1bc3913560d62f9cf85f1f4043ed3414b0f585173ff3f759c` · lines: 156 · matched declarations: 16
- L9: structure `Durable`
- L15: inductive `Step`
- L23: def `Rep`
- L27: theorem `represented_lengths`
- L33: theorem `step_preserves`
- L55: inductive `Run`
- L60: theorem `run_preserves`
- L70: theorem `held_step_changes_no_durable_field`
- L73: def `abstraction`
- L77: theorem `drained_refinement`
- L88: theorem `can_drain`
- L115: def `CacheGood`
- L118: theorem `cache_reset`
- L121: theorem `cache_survives_record`
- L127: theorem `cache_advance`
- L137: theorem `cache_complete`

## lalala/papers-11-12/lean/modules/ErrorBudget.lean

- SHA-256: `0b0d5b460ad2e47660c4f732b38161edb8096bb693521c3e06688e597342a9e5` · lines: 93 · matched declarations: 12
- L4: def `score`
- L6: def `mass`
- L10: theorem `score_mono`
- L18: theorem `mass_mono`
- L23: theorem `score_or_le`
- L27: theorem `mass_or_le`
- L37: theorem `mass_false`
- L41: def `anyFailure`
- L46: theorem `union_bound`
- L56: theorem `event_error_bound`
- L69: theorem `two_sided_event_error`
- L78: theorem `composed_event_budget`

## lalala/papers-11-12/lean/modules/FeasibleSplice.lean

- SHA-256: `1e3af63645ad38fd17a702c2b7a3d4f6e43ba68311196b67a77b5181b2b7009e` · lines: 76 · matched declarations: 6
- L7: def `splice`
- L12: theorem `repair_statewise`
- L22: theorem `life_gain_excludes_reverse`
- L30: theorem `repaired_upward_events`
- L39: theorem `strict_event_witness`
- L49: theorem `mass_lt_of_hit`

## lalala/papers-11-12/lean/modules/ImpartialityAudits.lean

- SHA-256: `ec567c156d7d034bae0206631d2cec844a5b8ef2d5d7fd11be49d8c715480054` · lines: 12 · matched declarations: 0

## lalala/papers-11-12/lean/modules/ObservedHold.lean

- SHA-256: `c7ac663f87a4fd5cefc3415390e66aa67c787bf65289e3965a9469fb5cbb6cd0` · lines: 62 · matched declarations: 9
- L9: structure `Operation`
- L16: def `forbidden`
- L19: def `Safe`
- L22: theorem `not_forbidden_iff_safe`
- L29: def `SafeTrace`
- L33: theorem `clean_iff_safe_trace`
- L40: theorem `accepted_iff_safe_trace`
- L44: theorem `safe_trace_member`
- L54: theorem `accepted_preserves_each_held_operation`

## lalala/papers-11-12/lean/modules/StagewiseMeaning.lean

- SHA-256: `6864fe649d4c9563e840310e1be8d063d869ac453c91605bea12ead0045c6d0f` · lines: 55 · matched declarations: 4
- L8: theorem `no_needless_implies_aligned`
- L18: theorem `aligned_iff_no_needless`
- L24: theorem `canonical_iff_stagewise`
- L44: theorem `feasibility_cannot_be_dropped`

## lalala/papers-11-12/lean/modules/TrustedCounter.lean

- SHA-256: `b5f8d7ec3d726d8c8f208c1355843aacc59a8a727ad75f368cb553cadb079743` · lines: 58 · matched declarations: 8
- L5: def `count`
- L9: def `clean`
- L13: theorem `count_zero_iff_clean`
- L24: theorem `endpoint_counter_certificate`
- L33: theorem `count_append`
- L39: theorem `prefix_counter_monotone`
- L45: theorem `wrapping_counter_misses_two`
- L49: theorem `missing_event_misses_violation`

## lalala/papers-11-12/lean/modules/UPTFence.lean

- SHA-256: `efeeb4e9074c463eb308f598a588116e32744e0645289837da2d5dcd42a4999c` · lines: 113 · matched declarations: 14
- L10: inductive `Ev`
- L15: structure `St`
- L21: def `apply`
- L26: def `run`
- L30: theorem `hold_safety`
- L60: theorem `raise_then_nothing_lands`
- L72: structure `QSt`
- L78: inductive `QEv`
- L82: def `applyAdmit`
- L91: def `applyLin`
- L99: def `start`
- L102: def `held`
- L105: theorem `admission_only_lands_in_hold`
- L110: theorem `check_at_apply_refuses`

## lalala/papers-11-12/lean/modules/UPTHold.lean

- SHA-256: `ebc34edb8e6d4649530f0b65604542f4c7af23a80ce21c0787bc8278b6c83b7a` · lines: 159 · matched declarations: 27
- L12: structure `Cfg`
- L17: inductive `Ev`
- L22: def `replay`
- L26: def `exec`
- L32: def `ideal`
- L38: def `run`
- L42: def `steps`
- L49: theorem `replay_ideal`
- L62: theorem `crash_ideal`
- L69: theorem `faithful`
- L84: theorem `faithful_from_start`
- L93: theorem `admissible_observer`
- L99: theorem `ideal_lengths`
- L108: theorem `hold_executes_nothing`
- L115: def `fN`
- L116: def `effN`
- L117: def `gN`
- L120: def `execNoReplay`
- L125: def `execRunWhileHeld`
- L130: def `execRedeliver`
- L134: def `runWith`
- L138: def `start`
- L140: theorem `mutant_no_replay_unfaithful`
- L143: theorem `mutant_run_while_held_unfaithful`
- L146: theorem `mutant_redeliver_unfaithful`
- L151: theorem `timing_observer_sees_the_hold`
- L155: theorem `faithful_instance`

## lalala/papers-11-12/lean/modules/UPTImpartiality.lean

- SHA-256: `35cb7f9f46cbb42a4614513ec6cc7a0f1b39862dc1a8f6fd242c10e58f9b47c3` · lines: 156 · matched declarations: 17
- L21: theorem `sum_ge`
- L30: theorem `sum_gt`
- L42: theorem `len_mul_inv`
- L51: theorem `some_chance_at_most`
- L64: theorem `everyone_at_least_only_if_uniform`
- L77: def `chA`
- L78: def `chB`
- L79: def `chC`
- L80: def `chD`
- L83: theorem `uniform_disadvantages_D`
- L88: theorem `least_chance_at_most_two_fifths`
- L93: theorem `ruling_gives_everyone_two_fifths`
- L100: theorem `ruling_is_unique`
- L105: theorem `len_inv_pos`
- L114: theorem `weight_of_keepers`
- L130: theorem `uniform_chance`
- L136: theorem `uniform_equal_iff_equal_counts`

## lalala/papers-11-12/lean/modules/UPTImpartialityAdequacy.lean

- SHA-256: `f9952d552c8bf4d814b57cbe09837971c964788dc1a1b27506428537f5e454e5` · lines: 115 · matched declarations: 15
- L12: def `chance`
- L15: def `Saveable`
- L19: theorem `singleton_keeper_saveable`
- L26: theorem `singleton_keeper_chance`
- L32: theorem `some_being_at_most`
- L45: theorem `being_floor_forces_uniform`
- L63: theorem `uniform_attains`
- L69: theorem `empty_universe_control`
- L74: theorem `incomplete_universe_control`
- L80: theorem `duplicate_universe_control`
- L83: inductive `Being`
- L84: inductive `Outcome`
- L86: def `keeps`
- L93: theorem `overlap_five_ticket_chances`
- L98: theorem `prospects_do_not_identify_lottery`

## lalala/papers-11-12/lean/modules/UPTLawLife.lean

- SHA-256: `0387bb2b2fee8e4c29820ed7fcb2518010f988729350e3f1a69f5c0d442ee14c` · lines: 123 · matched declarations: 20
- L9: def `Sub`
- L10: def `SSub`
- L11: theorem `Sub.refl`
- L12: theorem `Sub.trans`
- L14: def `Aligned`
- L16: def `Needless`
- L18: theorem `U1`
- L24: theorem `SSub.trans_sub`
- L26: theorem `Sub.trans_ssub`
- L30: def `Equiv`
- L34: def `LexBetter`
- L39: theorem `lex_irrefl`
- L47: theorem `lex_trans`
- L63: def `LexAlignedL`
- L68: def `NoNeedlessAtEveryStage`
- L75: theorem `lex_U1`
- L87: theorem `freedom_first_U1_legacy`
- L96: theorem `guard_first_stage`
- L109: theorem `canonical_life_first_U1`
- L118: theorem `life_guard`

## lalala/papers-11-12/lean/modules/UPTLotteryMenu.lean

- SHA-256: `279d312522da34f79ad34af83ef80c97bf6822b8e6cf2337de85bbbe2f538348` · lines: 95 · matched declarations: 11
- L16: def `cnt`
- L18: theorem `cnt_congr`
- L32: def `Offers`
- L40: def `weight`
- L41: def `classes`
- L45: theorem `draw_invariant`
- L56: theorem `duplicate_description_changes_nothing`
- L71: def `descriptionWeight`
- L75: theorem `draw_over_descriptions_is_manipulable`
- L84: inductive `Being`
- L88: theorem `tragic_pair_equal_chances`

## lalala/papers-11-12/lean/modules/WeakPrefixMeaning.lean

- SHA-256: `0e9c0b6992de4ec3861d1635c87a80a681435e8019af96dc63ec95a698d8e19f` · lines: 47 · matched declarations: 2
- L9: def `NoWeakPrefixNeedless`
- L17: theorem `canonical_iff_weak_prefix`

## lalala/physical-bridges/ContextualObservation.lean

- SHA-256: `0c69deb0f28c71c5fdcadde6650e1eadb3df69de302d6e735421e0268c6ff50c` · lines: 76 · matched declarations: 13
- L6: def `after`
- L8: def `Congruent`
- L11: def `ContextSafe`
- L15: theorem `contextual_iff_congruent`
- L26: theorem `contextual_on_invariant`
- L39: theorem `identity_detector_implies_injective`
- L47: structure `Sink`
- L52: def `crash`
- L54: def `observe`
- L56: theorem `forgotten_id_breaks_continuation`
- L60: theorem `endpoint_sampling_misses_a_cycle`
- L65: def `cachedStep`
- L66: theorem `cache_can_be_hidden`

## lalala/physical-bridges/ControllerFence.lean

- SHA-256: `0d83e506a9b7afe992489be98e612c17a50b16a287805417248d797d91f445cb` · lines: 55 · matched declarations: 3
- L9: def `TokenWitness`
- L17: theorem `certified_hold_nothing_lands`
- L40: theorem `both_targets_held`

## lalala/physical-bridges/ControllerFinality.lean

- SHA-256: `e5cfdacff59c22ff7c9447c308faa09e3822d5ad7531f2e8435e535c4432dca7` · lines: 442 · matched declarations: 55
- L7: def `tally`
- L11: theorem `tally_mono`
- L20: theorem `quorum_has_honest`
- L33: theorem `two_tallies_bound`
- L45: theorem `quorum_intersection`
- L59: theorem `committee_threshold`
- L61: def `Prefix`
- L63: theorem `prefix_trans`
- L69: theorem `equal_length_prefixes`
- L80: theorem `certificates_do_not_equivocate`
- L94: theorem `certificate_is_final`
- L106: structure `Context`
- L114: def `contextWords`
- L117: theorem `context_words_injective`
- L124: structure `State`
- L132: inductive `Op`
- L140: inductive `Reply`
- L151: def `step`
- L176: def `run`
- L180: theorem `run_append`
- L186: theorem `step_floor_mono`
- L199: theorem `run_floor_mono`
- L205: theorem `grant_fields`
- L214: theorem `floor_fields`
- L226: theorem `held_refuses`
- L230: theorem `retired_generation_refuses`
- L237: theorem `pending_conflict_refuses`
- L243: theorem `closed_sequence_refuses`
- L256: structure `Receipt`
- L262: def `namedOp`
- L263: def `expectedReply`
- L265: def `history`
- L266: def `replayOK`
- L269: theorem `receipt_names_success`
- L276: theorem `certified_receipt_names_success`
- L290: theorem `same_generation_no_context_conflict`
- L299: theorem `checkpoint_replay`
- L303: structure `Local`
- L311: def `allows`
- L315: def `consume`
- L316: def `restart`
- L319: theorem `consume_once`
- L322: theorem `restart_disabled`
- L325: theorem `retained_floor_refuses`
- L335: theorem `old_boot_refuses`
- L343: theorem `deadline_refuses`
- L349: def `emits`
- L353: def `issued`
- L357: theorem `issued_append`
- L363: theorem `emission_bounded`
- L377: theorem `issues_bounded_by_final_floor`
- L387: theorem `step_stays_held`
- L397: theorem `held_issues_nothing`
- L417: theorem `grant_receipt_is_issued`
- L427: theorem `hold_bounds_every_issued_grant`

## lalala/physical-bridges/IntrinsicStandingCathedral.lean

- SHA-256: `2d16586b47b7f2abb8b39f349fb3711001e7077eeb1ee655df3bdf0982ac1184` · lines: 74 · matched declarations: 5
- L15: def `EmbeddingIndependent`
- L21: theorem `singleton_injection`
- L28: theorem `one_anchor_implies_universal`
- L42: theorem `empty_or_universal`
- L60: theorem `original_scope_law_across_every_type`

## lalala/physical-bridges/MultiverseScopeCathedral.lean

- SHA-256: `3be0a4250e005dc32781a2f4321106a7e7332d5e9fc67958778cda6d18c387bd` · lines: 56 · matched declarations: 3
- L21: def `ScopeGuarantee`
- L28: theorem `scope_guarantee_iff_every_world_full`
- L47: theorem `global_policy_top_from_common_source`

## lalala/physical-bridges/PhysicalBridges.lean

- SHA-256: `4ed1696894b7494f3c4920c2fbeae144dd9fc1bba4cbdaf09cad8441deb0ec43` · lines: 273 · matched declarations: 0

## lalala/physical-bridges/PhysicalBridges/AdversarialHolding.lean

- SHA-256: `5797e42db04e1ecc9444fcdc9f3ed44c571185c79ab3d46c1018eb413a8509c4` · lines: 65 · matched declarations: 4
- L19: theorem `adversarial_holding_holds`
- L31: theorem `adversarial_failure_empty`
- L41: theorem `compliance_certifies`
- L50: theorem `pooled_adversarial_holding`

## lalala/physical-bridges/PhysicalBridges/AllIsActuality.lean

- SHA-256: `91e5824fdd2c619fff687b0da40b725e54d109fe4224afa0dd2d16542921c00a` · lines: 63 · matched declarations: 3
- L32: structure `AllIsActuality`
- L41: theorem `allIsActuality_has_content`
- L55: def `DecisiveSummitTest`

## lalala/physical-bridges/PhysicalBridges/AllIsDynamicRelationalTransport.lean

- SHA-256: `3bdd119ba57533c2280f8b3476d8b16e2b77b9830606808a70c4bef2b195fc09` · lines: 211 · matched declarations: 9
- L49: structure `RelationalEvolution`
- L59: theorem `evolution_does_not_merge_positions`
- L70: theorem `map_extended_environment_between_types`
- L88: theorem `every_intrinsic_formula_transports`
- L138: theorem `all_definable_duties_transport`
- L160: def `frozen_source_isomorphism`
- L173: theorem `frozen_source_preserves_intrinsic_formulas`
- L188: theorem `the_source_relation_really_changes`
- L198: theorem `static_register_relation_fails_source_transport`

## lalala/physical-bridges/PhysicalBridges/AllIsForwardPersistence.lean

- SHA-256: `f5af196f7fee7d766ee182dce28062ad59b41ac01be8f46263ba4fcbc022c6b8` · lines: 330 · matched declarations: 27
- L51: structure `ForwardEmbedding`
- L59: inductive `PositiveFormula`
- L68: def `evalPositive`
- L81: theorem `positive_formula_moves_forward`
- L112: structure `ForwardMicrohistory`
- L118: def `carry`
- L127: theorem `positive_truth_at_every_stage`
- L144: theorem `no_first_loss_of_positive_intrinsic_formula`
- L161: theorem `no_merging_of_old_positions`
- L175: def `emptyEdges`
- L176: def `addedEdges`
- L178: def `addingEdges`
- L186: theorem `negated_relation_can_fail_under_forward_embedding`
- L202: structure `InducedEmbedding`
- L209: def `QuantifierFree`
- L220: theorem `quantifier_free_truth_invariant`
- L255: def `oldEquality`
- L256: def `extendedEquality`
- L258: def `boolIntoThree`
- L262: def `freshNodeForward`
- L273: theorem `genuine_fresh_node_embedding_is_not_surjective`
- L279: def `oldNoEdges`
- L280: def `newSelfEdge`
- L283: def `freshInducedEmbedding`
- L293: def `zeroEnvironment`
- L299: theorem `fresh_nodes_can_change_existential_first_order_truth`
- L313: theorem `induced_fresh_embedding_is_non_surjective`

## lalala/physical-bridges/PhysicalBridges/AllIsGActualityDischarge.lean

- SHA-256: `fad5d710880ede518613486ddbb37ebb6c218353e101be61ec1d4dd4c77b704c` · lines: 72 · matched declarations: 4
- L37: structure `OntologicalGoodEvent`
- L47: theorem `capstone_unconditional_of_actuality`
- L58: def `RouteBSummit`
- L64: theorem `actuality_protection_given_summit`

## lalala/physical-bridges/PhysicalBridges/AllIsWithinEventHistory.lean

- SHA-256: `bd2c05268b28dd0b3a528f4a53ee340c46057012d41af5a8fd707f6f635d5d17` · lines: 188 · matched declarations: 13
- L48: structure `RelationalMicrohistory`
- L57: def `carry`
- L65: theorem `intrinsic_truth_at_every_stage`
- L85: theorem `arbitrary_relational_duties_at_every_stage`
- L100: theorem `carry_remains_injective`
- L118: theorem `no_first_loss_at_any_microstep`
- L141: def `initialRelation`
- L142: def `intermediateRelation`
- L143: def `finalRelation`
- L145: def `intrinsicSelfRelation`
- L149: def `endpointsHaveExactIsomorphism`
- L159: theorem `exact_endpoints_can_hide_an_intermediate_loss`
- L176: theorem `intermediate_loss_excludes_required_isomorphism`

## lalala/physical-bridges/PhysicalBridges/BCRDActualRelationalFrame.lean

- SHA-256: `d91c9c3fd971c8dd059b971738f7603b47b32c8f422ec60c82a070756a25b916` · lines: 193 · matched declarations: 16
- L44: abbrev `SourceState`
- L47: inductive `SourceEvent`
- L55: def `Transport`
- L61: def `step`
- L66: def `ActualStep`
- L73: def `site`
- L76: def `register`
- L106: theorem `evolve_realises_event`
- L111: theorem `transport_tracks_operator`
- L117: theorem `transport_involutive`
- L123: theorem `site_relation_covariant`
- L129: theorem `register_relation_not_covariant`
- L138: theorem `register_failure_witness`
- L148: theorem `relational_covariance`
- L159: theorem `covariance_nonvacuous`
- L171: theorem `relation_moves_but_is_covariant`

## lalala/physical-bridges/PhysicalBridges/BCRDAuthorizationFreedomBoundary.lean

- SHA-256: `d93bb41757cebeee33b83ffd94d267cafaef2218893209dc25b782aca4073854` · lines: 150 · matched declarations: 12
- L45: def `sourceOnlyProcess`
- L51: theorem `source_only_process_moves_M0`
- L64: theorem `no_two_distinct_actions_in_source_only_process`
- L73: structure `InterpretedSourceHistory`
- L80: def `allModeledSourceHistories`
- L87: def `claimedAuthorization`
- L92: def `approvedInterpretation`
- L95: def `unapprovedInterpretation`
- L100: theorem `entire_generated_histories_cannot_separate_authorization`
- L104: theorem `opposing_authorization_interpretations`
- L112: theorem `no_authorization_decoder_from_complete_modeled_source_history`
- L130: theorem `exact_authorization_receipt_must_distinguish_interpretations`

## lalala/physical-bridges/PhysicalBridges/BCRDCanonicalEventHistory.lean

- SHA-256: `49cc0f9a709f5454548d7ae172b45f9199d46e6f25e3ae925f11416b6e9e9a9a` · lines: 238 · matched declarations: 19
- L39: def `canonicalEvents`
- L45: def `canonicalEnd`
- L50: theorem `canonical_events_length`
- L59: theorem `every_canonical_history_passes_source_checker`
- L73: theorem `verified_history_has_unique_canonical_contents`
- L92: theorem `equal_length_valid_source_logs_are_identical`
- L114: theorem `tracked_position_commutes_with_source`
- L128: theorem `canonical_end_is_tracked_position`
- L143: theorem `generated_physical_history_length`
- L154: theorem `generated_physical_history_has_canonical_events`
- L164: theorem `generated_recorded_history_has_canonical_events`
- L178: structure `InterpretedExecution`
- L182: def `logReadout`
- L185: def `occurrenceStatus`
- L191: def `reportedPerformed`
- L194: def `reportedReplay`
- L197: theorem `both_reports_are_source_admissible`
- L208: theorem `same_source_log_but_opposite_occurrence_claim`
- L218: theorem `no_source_log_only_decoder_of_physical_occurrence`

## lalala/physical-bridges/PhysicalBridges/BCRDComplexCarrierAudit.lean

- SHA-256: `5adff4ccf18464471f1ee35aa1fb47e43fde14c22954cd30996dcd9db564f3ea` · lines: 204 · matched declarations: 18
- L49: inductive `SourceMoment`
- L57: def `stagesAt`
- L66: def `snapshot`
- L72: def `SeparableAt`
- L79: def `witnessingCoordinate`
- L93: theorem `designated_coordinate_separates_every_source_origin`
- L104: theorem `all_six_basis_candidates_separate_through_every_stage`
- L114: theorem `complex_stage_carriers_remain_injective`
- L132: def `completeComplexHistory`
- L138: structure `SubjectInterpretation`
- L142: def `physicalComplexReadout`
- L146: def `illustrativeContinues`
- L147: def `illustrativeDoesNotContinue`
- L149: theorem `same_complete_complex_source_history`
- L153: theorem `opposing_hypothetical_subject_readings`
- L162: theorem `no_source_complex_history_only_subject_decoder`
- L177: def `enrichedComplexReadout`
- L181: theorem `any_exact_subject_correspondence_observation_must_separate`

## lalala/physical-bridges/PhysicalBridges/BCRDComplexM3dStage.lean

- SHA-256: `3b556b2f556865f27bab3f98f8a21719f5e2c729f1becd7d367e107bd4442ab0` · lines: 318 · matched declarations: 62
- L37: structure `Surd`
- L42: def `sz`
- L43: def `so`
- L44: def `sadd`
- L45: def `sneg`
- L46: def `ssub`
- L47: def `smul`
- L51: structure `Cx`
- L56: def `cz`
- L57: def `co`
- L58: def `cadd`
- L59: def `cneg`
- L60: def `csub`
- L61: def `cmul`
- L64: def `cconj`
- L65: def `cabs2`
- L69: def `alpha`
- L70: def `beta`
- L72: theorem `exact_partial_swap_coefficient_norm`
- L75: abbrev `State`
- L76: abbrev `StageMatrix`
- L78: def `basis`
- L81: def `matVec`
- L89: def `kron`
- L94: def `ident`
- L95: def `middleProjector`
- L97: def `regZeroProjector`
- L99: def `regOneProjector`
- L101: def `regFlip`
- L105: def `sourceW`
- L112: theorem `source_W_matches_frozen_matrix`
- L118: def `sourceULM`
- L125: def `sourceCLM`
- L130: def `initial`
- L131: def `afterW`
- L132: def `afterC`
- L134: def `coherentLM`
- L137: theorem `W_moves_M0_to_M1`
- L144: theorem `controlled_LM_produces_exact_complex_superposition`
- L151: def `norm2`
- L158: theorem `original_and_intermediate_state_norm_one`
- L161: theorem `coherent_state_norm_one`
- L165: def `density`
- L168: def `negativeImaginaryHalf`
- L170: theorem `source_state_has_nonzero_imaginary_coherence`
- L176: theorem `coherent_state_is_not_any_basis_state`
- L197: def `adjoint`
- L201: def `matrixProduct`
- L209: def `unitMatrix`
- L212: theorem `source_W_unitary`
- L220: theorem `source_controlled_LM_unitary`
- L228: def `sourceUMR`
- L235: def `sourceUMR6`
- L237: theorem `source_MR_partial_swap_unitary`
- L246: def `sourceUFixed`
- L252: inductive `SourceStage`
- L256: def `operatorFor`
- L261: def `runStages`
- L264: theorem `pinned_two_stage_history_is_exact`
- L283: def `fullFourStageRun`
- L288: theorem `four_stage_run_matches_exact_source_compound`
- L299: theorem `full_compound_source_history_retains_quantum_norm`

## lalala/physical-bridges/PhysicalBridges/BCRDComplexOperatorConjugation.lean

- SHA-256: `e65a6822806ee6e22323513e132fb86651d0ca3664e1bd670ad9e64a01cde563` · lines: 110 · matched declarations: 8
- L34: def `cMatMul`
- L43: def `dagger`
- L46: def `conjugateByW`
- L54: theorem `dagger_sourceW_coeff`
- L62: theorem `wLeft`
- L78: theorem `wRight`
- L96: theorem `conjugate_entry`
- L103: theorem `conjugateByW_involutive`

## lalala/physical-bridges/PhysicalBridges/BCRDComplexWGenericAction.lean

- SHA-256: `2970937e83a6ba32f7a86d4972653e85f9b8befb563415d07e07d9e40af79161` · lines: 125 · matched declarations: 3
- L81: theorem `source_W_is_exact_complex_permutation`
- L89: theorem `every_complex_state_tracks_exact_W`
- L111: theorem `W_two_steps_exact_on_every_complex_state`

## lalala/physical-bridges/PhysicalBridges/BCRDCountedWitness.lean

- SHA-256: `5c475d461f6616e60d23df9e771f8dccc26c7f5d0840c9a21df7c799a9ebf162` · lines: 203 · matched declarations: 14
- L46: def `CounterIncrementsOnActualSteps`
- L54: theorem `actual_witnessed_trace_count_matches_edge_count`
- L74: theorem `actual_trace_reconstructs_from_initial_slot_and_count_delta`
- L97: def `sourceObservationReceipt`
- L105: theorem `real_world_receipt_decodes_full_witnessed_source_trace`
- L122: def `noActualNatStep`
- L123: def `identityNatCounter`
- L124: def `apparentMSourceReadout`
- L128: theorem `silent_world_satisfies_one_direction_counter_contract`
- L134: theorem `silent_world_satisfies_source_refinement`
- L143: theorem `silent_world_snapshot_pair_looks_source_valid`
- L153: theorem `no_step_world_traces_have_empty_event_lists`
- L165: theorem `counter_difference_does_not_establish_physical_step`
- L182: theorem `instrument_counter_law_alone_cannot_certify_execution`

## lalala/physical-bridges/PhysicalBridges/BCRDEndpointHistoryAmbiguity.lean

- SHA-256: `6372c350555575e1ffed7803769e8c1b910c9eb48f7ca97c3e07551bcb919711` · lines: 196 · matched declarations: 19
- L43: theorem `two_frozen_steps_return_to_origin`
- L51: theorem `two_valid_histories_share_source_endpoints`
- L68: structure `SourceEpisode`
- L72: def `endpoints`
- L75: def `generatedLog`
- L78: def `hasEvents`
- L83: def `noEvents`
- L84: def `twoEvents`
- L86: theorem `same_start_and_end_for_zero_vs_two_source_steps`
- L90: theorem `different_generator_histories_at_same_endpoints`
- L94: theorem `different_event_counts_at_same_endpoints`
- L98: theorem `different_whether_any_source_step_was_modeled`
- L104: theorem `both_ambiguous_endpoint_histories_are_source_valid`
- L113: theorem `both_ambiguous_endpoint_histories_have_faithful_records`
- L124: theorem `no_endpoint_only_exact_event_count_decoder`
- L138: theorem `no_endpoint_only_has_events_decoder`
- L154: theorem `first_certified_source_matrix_event_is_nontrivial`
- L165: theorem `certified_matrix_two_step_return`
- L175: theorem `certified_matrix_intermediate_is_different`

## lalala/physical-bridges/PhysicalBridges/BCRDExactCausalOrbit.lean

- SHA-256: `0bc3fda2c8ad9e4a1241f41b2bc66ffd92489ee2a6569273042286f6916573de` · lines: 183 · matched declarations: 12
- L38: def `SourceOrbit`
- L42: theorem `each_source_edge_stays_in_orbit`
- L54: theorem `source_orbit_transitive`
- L63: theorem `reachable_implies_same_source_orbit`
- L75: theorem `same_source_orbit_implies_reachable`
- L93: theorem `exact_source_reachability_iff_orbit`
- L102: theorem `validated_log_implies_exact_source_orbit`
- L113: theorem `orbit_pair_has_valid_source_event_log`
- L130: theorem `same_site_not_sufficient_for_causal_reachability`
- L145: theorem `mutual_M_reachability_does_not_identify_positions`
- L157: theorem `source_next_position_is_unique`
- L166: theorem `source_predecessor_is_unique`

## lalala/physical-bridges/PhysicalBridges/BCRDExecutableSourceReceipt.lean

- SHA-256: `32d56f3c172a7d9866e5e3eed2668d1cad1091a44ee0125cb4eeae0112b1ae6d` · lines: 273 · matched declarations: 23
- L46: def `checkSourcePath`
- L54: theorem `check_source_path_sound`
- L85: theorem `check_source_path_complete`
- L96: theorem `check_source_path_iff_verified`
- L106: def `checkCountedSourcePath`
- L110: theorem `check_counted_source_path_iff`
- L132: structure `SourceReceipt`
- L141: def `verifySourceReceipt`
- L151: def `SourceReceiptValid`
- L159: theorem `verify_source_receipt_sound`
- L179: theorem `verify_source_receipt_complete`
- L201: theorem `executable_receipt_iff_source_structural_validity`
- L209: def `generatedReceipt`
- L213: theorem `every_generated_source_receipt_is_accepted`
- L224: def `testOneEvent`
- L227: theorem `valid_single_event_receipt_accepted`
- L230: theorem `valid_empty_history_receipt_accepted`
- L233: theorem `count_forgery_rejected`
- L236: theorem `incorrect_terminal_position_rejected`
- L239: theorem `source_impossible_jump_rejected`
- L243: theorem `mismatched_recorded_event_rejected`
- L247: theorem `mismatched_origin_rejected`
- L255: theorem `successful_checker_does_not_by_itself_prove_execution`

## lalala/physical-bridges/PhysicalBridges/BCRDIdentityCharge.lean

- SHA-256: `2911cfe9a30a63cfa303984a08d25fed4dd636315c5dab06f321e0a20a3ec54a` · lines: 110 · matched declarations: 18
- L20: def `ConservedStep`
- L25: def `FrozenM3dStep`
- L29: def `L`
- L33: def `SourceBasisDensity`
- L36: def `SourceBasisStep`
- L39: theorem `source_W_is_unitary`
- L42: theorem `source_W_is_self_inverse`
- L45: theorem `restricted_source_generators_commute_with_C`
- L54: theorem `source_action_on_all_matrix_units`
- L59: theorem `source_transition`
- L66: theorem `source_densities_are_normalized`
- L69: theorem `witness_densities_are_source_basis_states`
- L73: theorem `candidate_charge_changes`
- L77: theorem `candidate_charge_counterexample`
- L82: theorem `not_conserved_joint_parity`
- L89: theorem `not_conserved_on_source_basis`
- L97: theorem `exact_Heisenberg_defect`
- L103: theorem `source_witness_is_reversible`

## lalala/physical-bridges/PhysicalBridges/BCRDJsonSourceReceipt.lean

- SHA-256: `8cfdee30bcdf063157059a185877c8e926856f6e8824841e9904ec1475c12791` · lines: 196 · matched declarations: 17
- L39: def `jsonIndex`
- L47: def `jsonEvent`
- L56: def `jsonPhysicalHistory`
- L66: def `jsonRecordedHistory`
- L79: def `decodeJsonReceipt`
- L102: def `verifyJsonSourceReceipt`
- L111: theorem `verify_json_receipt_sound`
- L127: theorem `verify_json_receipt_implies_source_validity`
- L143: def `exampleJson`
- L147: def `wrongCountJson`
- L151: def `impossibleEdgeJson`
- L156: def `invalidBasisIndexJson`
- L160: def `missingInstrumentIdJson`
- L164: def `missingRecordedHistoryJson`
- L168: def `stringCountJson`
- L184: def `rejectedBasisIndex`
- L189: theorem `basis_index_six_fails`

## lalala/physical-bridges/PhysicalBridges/BCRDObservableHistoryCriterion.lean

- SHA-256: `e9eb4bd4d9a83ec383945882e2182d601431e243ac75f979be6490e6da72b8e0` · lines: 171 · matched declarations: 12
- L44: def `enrichedReadout`
- L56: theorem `exact_history_decoder_iff_event_count_fiber_constant`
- L82: def `exactCountReadout`
- L88: def `reconstructCanonicalLog`
- L95: theorem `exact_count_and_origin_reconstruct_full_source_log`
- L101: theorem `exact_count_readout_has_explicit_decoder`
- L109: theorem `no_endpoint_only_full_history_decoder`
- L122: def `oneStepFromM0`
- L123: def `oneStepFromM1`
- L125: theorem `same_event_count_but_distinct_source_histories`
- L133: theorem `no_event_count_only_full_history_decoder`
- L147: theorem `any_exact_supplemental_readout_separates_reversible_loops`

## lalala/physical-bridges/PhysicalBridges/BCRDOperatorAlgebra.lean

- SHA-256: `98751bbf82df129614872acd2235833fe4f6867b0a881f51d2ecc16ccd996b91` · lines: 148 · matched declarations: 13
- L36: theorem `wUpdate_apply`
- L49: theorem `permutation_involutive`
- L58: theorem `evolve_entry`
- L70: theorem `evolve_preserves_trace`
- L76: theorem `evolve_preserves_product`
- L85: theorem `evolve_preserves_transpose`
- L90: theorem `evolve_preserves_identity`
- L97: theorem `evolve_involutive`
- L105: theorem `evolve_preserves_trace_form`
- L113: theorem `evolve_preserves_frobenius`
- L125: def `diagonal`
- L132: theorem `evolve_diagonal`
- L145: theorem `evolve_diagonal_matches_event`

## lalala/physical-bridges/PhysicalBridges/BCRDOperatorSubjectGap.lean

- SHA-256: `27b9847fdee5c6064977f1e52124b08c80580424b8a14018b2c01437af88a471` · lines: 122 · matched declarations: 10
- L37: structure `InterpretedEvent`
- L42: def `completePhysicalReadout`
- L46: def `fullSubjectStatus`
- L51: def `protectedInterpretation`
- L54: def `unconsentedInterpretation`
- L59: theorem `full_operator_readouts_identical`
- L65: theorem `both_use_real_frozen_source_transition`
- L76: theorem `original_x3_statuses_disagree`
- L84: theorem `no_operator_trace_only_x3_decoder`
- L101: theorem `any_exact_semantic_readout_separates_subject_interpretations`

## lalala/physical-bridges/PhysicalBridges/BCRDParticularCarrierCriterion.lean

- SHA-256: `dc062957d17f7fdbcefa9bd6a33d08a3a12e3ee8158fe12ae1ad27c951db22d1` · lines: 165 · matched declarations: 12
- L42: def `ActualPositionStep`
- L47: theorem `generated_event_is_actual_position_step`
- L53: theorem `each_finite_track_has_actual_source_path`
- L66: def `CarrierAt`
- L73: theorem `carrier_injective_after_iff_before`
- L85: theorem `candidate_carrier_has_exact_source_path`
- L94: theorem `candidate_carrier_has_faithful_finite_history`
- L106: theorem `justified_injective_carrier_retains_finite_source_witness`
- L126: def `collidingCandidateCarrier`
- L128: theorem `colliding_candidates_share_every_source_position`
- L138: theorem `source_nonmerging_cannot_certify_colliding_candidates`
- L149: theorem `colliding_candidates_still_have_faithful_source_histories`

## lalala/physical-bridges/PhysicalBridges/BCRDPreservedStructure.lean

- SHA-256: `eb98b223c2f675ef406f78265f789332312b7bb405d05f51d82f96c568011a49` · lines: 127 · matched declarations: 11
- L38: theorem `transport_fixes_off_pair`
- L41: theorem `transport_swaps_pair`
- L50: theorem `orbit_covariant`
- L60: theorem `label_const_on_transport`
- L73: theorem `covariant_of_respects_orbit`
- L85: theorem `respects_orbit_not_injective`
- L93: theorem `site_respects_orbit`
- L97: theorem `site_covariant_via_orbit`
- L103: theorem `site_not_injective`
- L109: theorem `register_separates_orbit`
- L118: theorem `persists_while_changing`

## lalala/physical-bridges/PhysicalBridges/BCRDSourceCoverage.lean

- SHA-256: `5a17363d3a72d3f2de8c7b25da0401f5ac992602cd514938ec0513d66cf230b7` · lines: 91 · matched declarations: 7
- L45: abbrev `CertifiedDensity`
- L50: theorem `coverage_action_entry`
- L56: theorem `coverage_action`
- L62: theorem `coverage_closed`
- L69: theorem `certified_trace_one`
- L76: theorem `certified_domain_is_proper`
- L85: theorem `coverage_matches_event`

## lalala/physical-bridges/PhysicalBridges/BCRDSourceDerivedMicrohistory.lean

- SHA-256: `c6cd77f54d70a8590644837d3d420d8e3099f64a9155cc317afdf46f648c49ed` · lines: 117 · matched declarations: 8
- L36: def `sourceIterate`
- L42: theorem `each_stage_is_actual_step`
- L50: def `sourceHistory`
- L60: theorem `source_intrinsic_truth_at_every_stage`
- L71: theorem `source_relational_duties_at_every_stage`
- L81: theorem `source_no_first_loss`
- L91: theorem `source_no_merging`
- L98: theorem `source_carried_value_at_every_stage`

## lalala/physical-bridges/PhysicalBridges/BCRDSourceHistoryProvenance.lean

- SHA-256: `2768cb6b1511fd32e93d56f00af19853cf8f12272144d5397a6db9fc837701f2` · lines: 133 · matched declarations: 10
- L30: abbrev `SlotEvent`
- L35: def `eventAt`
- L40: theorem `event_payload_is_actual_source_step`
- L48: def `sourcePhysicalHistory`
- L55: def `sourceRecordedHistory`
- L64: theorem `full_finite_source_event_history_is_faithful`
- L81: theorem `finite_source_history_retains_origin`
- L91: theorem `source_transport_is_injective`
- L100: theorem `tracked_basis_positions_do_not_merge`
- L115: theorem `frozen_M0_event_has_faithful_source_record`

## lalala/physical-bridges/PhysicalBridges/BCRDSummitKeystoneReduction.lean

- SHA-256: `8d071e63f0af0e84338079486f5b8ff85a6fcbf6b5ebfd923813dcb7c19ac03b` · lines: 114 · matched declarations: 3
- L53: theorem `guardian_only_from_keystone`
- L69: theorem `guardian_only_over_original_x3`
- L90: theorem `keystone_is_exactly_the_six_reflections`

## lalala/physical-bridges/PhysicalBridges/BCRDTransportedParticularMarker.lean

- SHA-256: `f2d6cb1f175ae5b30aa76d3b792be24824601bf4db56ba964f15f7f8720dd43a` · lines: 195 · matched declarations: 20
- L35: def `sourceTransport`
- L37: theorem `source_transport_is_involution`
- L41: theorem `source_transport_swaps_distinct_positions`
- L50: def `StaticInvariant`
- L55: theorem `static_invariance_identifies_swapped_positions`
- L67: theorem `no_static_invariant_injective_position_code`
- L77: def `physicalSite`
- L79: theorem `physical_site_is_static_invariant`
- L84: theorem `physical_site_cannot_encode_all_positions`
- L93: theorem `no_exact_position_decoder_from_static_orbit_label`
- L110: constant `at`
- L111: def `transportedCode`
- L115: theorem `code_is_carried_to_the_transport`
- L122: theorem `transported_code_preserves_injectivity`
- L134: theorem `distinct_M_positions_remain_distinct_after_transport`
- L142: theorem `dynamic_position_code_has_exact_decoder`
- L150: def `trackedPosition`
- L155: def `markerAt`
- L161: theorem `marker_history_tracks_original_basis_position`
- L176: theorem `all_finite_source_steps_keep_position_codes_injective`

## lalala/physical-bridges/PhysicalBridges/BCRDValidatedCausalLog.lean

- SHA-256: `dd8a5083ad3af0a0ec8b16319b228855eed874591e3f53b51159454d08ccb730` · lines: 154 · matched declarations: 14
- L30: inductive `VerifiedSourcePath`
- L37: theorem `verified_path_append_actual`
- L48: theorem `generated_history_passes_source_path_verifier`
- L61: theorem `reach_transitive`
- L71: theorem `verified_source_path_implies_actual_source_reach`
- L82: theorem `each_actual_source_edge_preserves_site`
- L93: theorem `all_source_reach_preserves_site`
- L103: theorem `no_finite_source_path_M0_to_R0`
- L110: theorem `forged_M0_to_R0_event_log_rejected`
- L118: def `forgedPhysicalHistory`
- L121: def `forgedRecordedHistory`
- L124: theorem `IR26_fidelity_alone_accepts_forged_source_log`
- L129: theorem `IR26_faithful_forgery_rejected_by_source_verifier`
- L137: theorem `all_generated_finite_histories_pass_both_gates`

## lalala/physical-bridges/PhysicalBridges/BCRDWitnessedReceiptComposition.lean

- SHA-256: `8964062bb176a5f115eac4c600405fc11d803949986dc70aa63482f2a38eb6b7` · lines: 187 · matched declarations: 14
- L43: def `projectedHistory`
- L52: def `witnessedReceipt`
- L64: theorem `independently_witnessed_source_trace_passes_receipt_checker`
- L94: theorem `independently_witnessed_receipt_has_canonical_contents`
- L126: abbrev `CountedWorld`
- L128: def `countedWorldStep`
- L132: def `countedWorldPosition`
- L134: def `countedWorldCounter`
- L136: theorem `counted_world_exact_source_refinement`
- L141: theorem `counted_world_exact_counter_step`
- L146: theorem `synthetic_counted_world_has_nontrivial_witness`
- L159: def `syntheticWitnessRecord`
- L162: theorem `synthetic_world_has_faithful_independent_record`
- L171: theorem `witnessed_and_counted_nontrivial_example_is_accepted`

## lalala/physical-bridges/PhysicalBridges/BCRDWitnessedSourceRefinement.lean

- SHA-256: `164d0ce0eff29f2bd0292b4ab55500ff70518fa930eafed1eebb02be15d37cd1` · lines: 238 · matched declarations: 22
- L40: inductive `WitnessedTrace`
- L54: def `RealStepsRefineSource`
- L63: theorem `witnessed_trace_projects_to_valid_source`
- L81: theorem `witnessed_trace_is_the_unique_canonical_source_history`
- L97: def `noPhysicalWorldStep`
- L99: def `identityReadout`
- L103: theorem `empty_physical_world_refines_source`
- L110: theorem `model_M0_M1_log_passes_source_validation`
- L119: theorem `source_valid_log_does_not_force_real_world_execution`
- L130: theorem `model_source_validity_is_strictly_weaker_than_execution`
- L141: theorem `exact_source_world_refines_itself`
- L146: theorem `exact_source_world_has_a_witnessed_M0_event`
- L156: theorem `witnessed_source_world_M0_event_reconstructs`
- L176: structure `ToyWorld`
- L180: def `toyReadPosition`
- L184: def `toyWorldStep`
- L187: def `toyParticularActive`
- L189: def `toyBefore`
- L190: def `toyAfter`
- L192: theorem `toy_world_edges_refine_source`
- L201: theorem `witnessed_source_refinement_does_not_force_subject_activity`
- L221: theorem `toy_activity_loss_is_compatible_with_source_validity`

## lalala/physical-bridges/PhysicalBridges/CathedralAllIsEnderTypeCollapse.lean

- SHA-256: `bbc3c78363f99137fb98b1369f30ca9b36ee7ce5ba721f7f7f087e43a05bfd20` · lines: 241 · matched declarations: 15
- L28: class `has`
- L44: structure `IntrinsicAccount`
- L75: theorem `original_si_guardian_only_composition`
- L88: def `RealizedAbsoluteEnder`
- L97: theorem `no_realized_absolute_ender`
- L107: def `StrongSameTypeDichotomy`
- L115: theorem `all_is_eliminates_realized_ender_branch`
- L127: theorem `full_x3_from_ontological_collapse_and_reflection`
- L143: theorem `original_x3_direct_collapse`
- L159: theorem `original_x3_from_no_local_violator_without_absolute_end`
- L177: def `semanticDistinction`
- L188: theorem `intrinsic_no_middle_can_hold_in_semantic_distinction`
- L193: theorem `all_enacted_are_intrinsic_guardians_in_diagnostic`
- L202: theorem `intrinsic_guardian_does_not_by_itself_reflect_full_x3`
- L214: theorem `strategic_classification_does_not_instantiate_absolute_end`

## lalala/physical-bridges/PhysicalBridges/CathedralBackwardsOriginalX3.lean

- SHA-256: `b637ad76178b97e9a1e30bad3ecfa354969cce0b7c683715ab9001f7eb10d65e` · lines: 136 · matched declarations: 7
- L38: def `AllSixGuardianAction`
- L48: theorem `enacted_action_witnesses_actuality`
- L56: def `StrongOriginalX3Dichotomy`
- L68: theorem `not_guardian_entails_ender_given_original_dichotomy`
- L85: theorem `all_is_plus_original_dichotomy_forces_every_owed_x3`
- L102: theorem `original_dichotomy_iff_every_owed_original_x3`
- L121: theorem `intrinsic_semantics_present_but_projection_can_forget`

## lalala/physical-bridges/PhysicalBridges/CathedralBridgeDischargeAssembly.lean

- SHA-256: `d390f0dc7c183624962dad10ef7549bb3de17bef383c985d46508cb500d18168` · lines: 184 · matched declarations: 7
- L44: structure `MeasuredInstrument`
- L82: def `toSource`
- L100: def `toCertificate`
- L119: theorem `nothing_but_guardians_from_instrument`
- L126: theorem `every_real_step_keeps_x3`
- L135: theorem `assembled_instrument_is_instantiable`
- L174: theorem `flagged_attempt_still_protected`

## lalala/physical-bridges/PhysicalBridges/CathedralBridgeDischargeBranchB.lean

- SHA-256: `07c8b1ddcb6d7e6da498ada34731ab9bd4ecb775fcce29ed71559aae5c5cf413` · lines: 98 · matched declarations: 4
- L39: structure `BranchBWitness`
- L63: theorem `branchB_detection_before_deadline`
- L71: theorem `branchB_timely_interlock_stable`
- L80: theorem `branchB_is_instantiable`

## lalala/physical-bridges/PhysicalBridges/CathedralBridgeDischargeBranchesAC.lean

- SHA-256: `c4ae421c0c39399c77799e0a1a3ab1892cd297b85e56005fbe495d73aa02000c` · lines: 81 · matched declarations: 5
- L40: structure `BranchAWitness`
- L50: theorem `branchA_refresh_stable`
- L56: theorem `branchA_is_instantiable`
- L64: theorem `branchC_unaffordable_infeasible`
- L72: theorem `branchC_power_fenced_interlock_stable`

## lalala/physical-bridges/PhysicalBridges/CathedralBridgeDischargeSemantic.lean

- SHA-256: `6a6c696cc46163fa80ace02bb22ac8e9f1352803fa7b10163cb096a87c542ffb` · lines: 123 · matched declarations: 5
- L50: structure `BCRDRelations`
- L64: def `toEventSource`
- L85: theorem `semantic_reflection_discharged`
- L93: theorem `event_carries_state_discharged`
- L104: theorem `semantic_reflection_is_substantive`

## lalala/physical-bridges/PhysicalBridges/CathedralCapstoneJoins.lean

- SHA-256: `366b3975680767139214a418ef6fd76a13815058e3ab469100e7f913f06ba2cb` · lines: 249 · matched declarations: 10
- L74: theorem `ender_success_self_refutes`
- L83: theorem `fibre_certificate_gives_invariant_selector`
- L98: theorem `fibre_certificate_forever_viable`
- L121: theorem `fibre_certificate_physical_safety_exists`
- L151: theorem `capstone_enacted_history_protected`
- L171: theorem `capstone_enacted_history_protected_from_certificate`
- L198: inductive `CycleReach`
- L203: theorem `cycle_reach_preserves`
- L215: theorem `cycle_protection_from_source_preservation`
- L225: theorem `two_phase_cycle_protection_from_general_join`

## lalala/physical-bridges/PhysicalBridges/CathedralConstructiveGuardian.lean

- SHA-256: `e9675d320045b2f9285c5354af196383847c33d8969ec55dac73eb245c664e7c` · lines: 239 · matched declarations: 13
- L28: def `listAll`
- L32: theorem `listAll_true`
- L43: theorem `listAll_intro`
- L54: def `findFirst`
- L58: theorem `findFirst_some`
- L72: theorem `findFirst_found`
- L99: def `isGuard`
- L106: theorem `isGuard_iff`
- L142: def `fibreOk`
- L149: theorem `fibreOk_iff`
- L181: def `swarmPolicy`
- L189: theorem `swarmPolicy_correct`
- L216: theorem `computable_cut_guardian`

## lalala/physical-bridges/PhysicalBridges/CathedralCovariantActionDescent.lean

- SHA-256: `7c9c9222b7e999819ba81024f3fa3daec0175dc2f27202bcf2bcfb61f1d67cf5` · lines: 429 · matched declarations: 26
- L32: structure `CovariantSymmetry`
- L49: theorem `covariant_symmetry_transports_guard`
- L83: def `HasFixedSafeOrbitAnchors`
- L99: theorem `fixed_safe_orbit_anchor_forces_fibre_guardian`
- L125: theorem `fixed_safe_orbit_anchor_forces_guardian`
- L140: def `identityReversible`
- L146: def `identityCovariance`
- L173: def `sharedObserve`
- L174: def `sharedProtected`
- L175: def `sharedAllowed`
- L177: def `sharedStep`
- L182: def `flipBool`
- L188: def `flipOptionalBool`
- L204: def `sharedFlipCovariance`
- L226: theorem `shared_stable_action_is_allowed_and_moves`
- L236: theorem `shared_model_has_fixed_safe_orbit_anchors`
- L253: theorem `shared_model_has_guardian_despite_moving_action_frames`
- L264: theorem `shared_flip_not_action_fixed_for_all_labels`
- L279: def `binaryFlipCovariance`
- L289: theorem `binary_moving_action_source_still_has_no_guardian`
- L294: theorem `binary_moving_action_source_lacks_fixed_anchor`
- L318: def `h2PulseFixed`
- L324: theorem `h2_step_is_pulse`
- L335: theorem `h2_step_covariance_commutes_with_pulse`
- L356: theorem `h2_covariance_preserves_pulse_fixed`
- L384: theorem `h2_parity_guardian_does_not_require_orbit_descent`

## lalala/physical-bridges/PhysicalBridges/CathedralCutGuardianCriterion.lean

- SHA-256: `82a79a895a8b6d6462226b111f656051998db725994e79d9ba19f1164a3795fe` · lines: 198 · matched declarations: 11
- L18: def `GuardAction`
- L24: def `FibreHasGuard`
- L32: def `ExistsCutGuardian`
- L40: theorem `guardian_exists_iff_fibre_has_common_action`
- L60: theorem `cut_refinement_preserves_guardian`
- L77: theorem `guard_conflict_forces_distinguishing_cut`
- L96: theorem `history_decoder_can_supply_cut_guardian`
- L113: theorem `guardian_preserves_all_finite_source_paths`
- L130: theorem `guarded_real_effects_preserve_finite_histories`
- L149: theorem `first_violating_edge_exists`
- L180: theorem `first_violation_has_causal_witness`

## lalala/physical-bridges/PhysicalBridges/CathedralFirstEventForcing.lean

- SHA-256: `e5a4e654f17297d64325efdde939fa072a8321f44f07cb9eaf5773e85e46274c` · lines: 216 · matched declarations: 12
- L35: structure `IntrinsicEventSource`
- L59: structure `FirstEventCertificate`
- L106: theorem `unaffordable_coherent_ender_is_infeasible`
- L119: theorem `every_real_step_physically_stable`
- L144: theorem `no_first_x3_violation_from_dichotomy_and_e9`
- L156: theorem `no_first_x3_state_loss`
- L169: theorem `every_finite_real_history_keeps_x3`
- L186: structure `ThreePhaseProxy`
- L191: def `proxyRestored`
- L194: def `proxyAlwaysActive`
- L197: def `hiddenInternalLoss`
- L200: theorem `endpoint_recovery_does_not_prove_within_event_continuity`

## lalala/physical-bridges/PhysicalBridges/CathedralFullX3Assembly.lean

- SHA-256: `fc0d771ec149e20aca67e803ff3fcecf142834234cd5441c6d01ed4485c77c03` · lines: 153 · matched declarations: 11
- L40: structure `ParticularRelations`
- L50: def `FullEvent`
- L58: structure `SameSourceReflection`
- L76: theorem `measured_step_physically_stable`
- L82: theorem `full_reflection`
- L98: theorem `every_real_step_full_original_x3`
- L106: def `FullStep`
- L112: theorem `fullStep_iff_realStep`
- L123: theorem `every_real_history_has_all_six`
- L137: theorem `every_real_run_has_all_six`
- L146: theorem `full_event_retains_each_component`

## lalala/physical-bridges/PhysicalBridges/CathedralGroundedSelfSemantics.lean

- SHA-256: `e708d981765ba73b5760504ceb09fb9704725ccf5915ece652285ce20d1ded6d` · lines: 325 · matched declarations: 26
- L46: inductive `Grounding`
- L53: def `negate`
- L59: def `conjoin`
- L69: inductive `Instruction`
- L79: def `advance`
- L92: def `stage`
- L100: def `balancedDecision`
- L109: def `balancedProgram`
- L113: def `balancedStage`
- L118: theorem `grounded_true_at_every_positive_stage`
- L126: theorem `liar_pending_at_every_stage`
- L138: theorem `grounded_and_liar_coexist`
- L147: theorem `no_bivalent_liar_fixed_point`
- L161: theorem `negation_fixed_point_is_pending`
- L171: def `atomicProgram`
- L174: def `atomicStage`
- L177: theorem `grounded_true_and_false_are_distinct`
- L188: def `groundedLimit`
- L193: theorem `grounded_limit_is_fixed`
- L204: theorem `every_positive_stage_reaches_grounded_limit`
- L221: theorem `grounded_limit_is_the_only_fixed_interpretation`
- L250: theorem `same_source_different_codebooks_change_meaning`
- L260: def `renameInstruction`
- L270: theorem `balanced_program_flip_equivariant`
- L281: theorem `balanced_stage_flip_equivariant`
- L300: theorem `no_root_needed_for_partial_self_interpretation`

## lalala/physical-bridges/PhysicalBridges/CathedralGuardianOnlyCapstone.lean

- SHA-256: `0f94686e5e5b7c8c5d8c5bf144784fcb186b3c35896caf6a41d16882e17bd7ad` · lines: 120 · matched declarations: 3
- L78: theorem `every_real_step_is_guardian`
- L98: def `HistoryGuardian`
- L107: theorem `nothing_but_guardians`

## lalala/physical-bridges/PhysicalBridges/CathedralIdentityHolonomy.lean

- SHA-256: `4a6d3a7c35d28e321cbd1db6b90e1c344b72b5462b49282b37a7fa1312c847aa` · lines: 126 · matched declarations: 7
- L25: def `EdgeCoherent`
- L34: def `HolonomyFixed`
- L45: theorem `holonomy_fixed_iff_coherent_section`
- L69: theorem `chord_certificate_implies_all_edge_coherence`
- L88: theorem `separating_cut_forces_trivial_holonomy`
- L101: theorem `twisted_history_forbids_exact_cut_identity_decoder`
- L115: theorem `legitimate_relabeling_preserves_fixedness`

## lalala/physical-bridges/PhysicalBridges/CathedralIdentityHolonomyChecked.lean

- SHA-256: `7f9068ed050be54a8d9cac506fc205203669404e0fd382a11cc84e619a88610d` · lines: 151 · matched declarations: 10
- L25: def `inverse`
- L32: def `compose`
- L45: def `EdgeCoherent`
- L53: def `HolonomyFixed`
- L63: theorem `holonomy_fixed_iff_coherent_section`
- L84: theorem `chord_certificate_implies_all_edge_coherence`
- L103: theorem `separating_cut_forces_trivial_holonomy`
- L114: theorem `twisted_history_forbids_exact_cut_identity_decoder`
- L126: def `conjugate`
- L129: theorem `legitimate_relabeling_preserves_fixedness`

## lalala/physical-bridges/PhysicalBridges/CathedralInternalInscription.lean

- SHA-256: `38b0931b010c969c4d07a1575313c785819bbdc3b3bf3f601add265f7772baaf` · lines: 112 · matched declarations: 7
- L35: def `Inscribes`
- L40: theorem `inscribes_preserved_by_reindex`
- L49: theorem `inscribes_preserved_by_symmetry`
- L67: theorem `distinct_internal_self_inscription`
- L75: theorem `flip_preserves_internal_self_inscription`
- L87: theorem `no_invariant_exterior_speaker`
- L97: theorem `one_position_has_no_strict_self_inscription`

## lalala/physical-bridges/PhysicalBridges/CathedralIntrinsicArticulation.lean

- SHA-256: `3597dd2d7921f5396f9614aba00f81c304ee702c8eca5e17c9924b10891fc8bc` · lines: 338 · matched declarations: 32
- L36: structure `Web`
- L41: inductive `Chain`
- L45: def `Connected`
- L48: def `Nontrivial`
- L53: def `RelationallyIndividuated`
- L58: structure `Rename`
- L66: def `reindex`
- L72: theorem `reindex_preserves_relation`
- L79: theorem `profiles_are_invariant_under_reindex`
- L93: theorem `chain_transports`
- L104: theorem `connected_reindex`
- L113: theorem `relational_individuation_reindex`
- L129: structure `Symmetry`
- L144: def `identitySymmetry`
- L156: def `inverseSymmetry`
- L170: def `composeSymmetry`
- L194: def `SameRole`
- L197: theorem `same_role_refl`
- L201: theorem `same_role_symm`
- L212: theorem `same_role_trans`
- L226: def `NoPrivilegedRoot`
- L233: def `IntrinsicArticulation`
- L239: def `distinctWeb`
- L242: theorem `distinct_web_connected`
- L252: theorem `distinct_web_relationally_individuated`
- L263: def `swapBool`
- L269: def `swapSymmetry`
- L275: theorem `swap_has_no_fixed_point`
- L284: theorem `distinct_yet_same_role_in_one_web`
- L293: theorem `distinct_bool_web_has_no_privileged_root`
- L306: theorem `intrinsic_articulation_has_a_concrete_model`
- L316: theorem `connected_one_position_does_not_imply_multiplicity`

## lalala/physical-bridges/PhysicalBridges/CathedralIntrinsicAtomicSemantics.lean

- SHA-256: `56ebf844d075d35fe71021b3e7de906f3b060df97bfae70c757fca675c38a3b5` · lines: 280 · matched declarations: 23
- L36: def `AssertsLink`
- L44: def `AtomHolds`
- L47: def `AccurateAtom`
- L52: def `InaccurateAtom`
- L59: theorem `assertion_reindex`
- L68: theorem `accuracy_reindex`
- L78: theorem `inaccuracy_reindex`
- L90: theorem `accuracy_symmetry`
- L123: def `balancedWeb`
- L129: theorem `true_internal_self_assertion`
- L135: theorem `false_internal_self_assertion`
- L143: theorem `one_web_has_true_and_false_self_assertions`
- L154: theorem `internal_assertions_not_automatically_true`
- L166: def `flipSecond`
- L180: def `flipSecondSymmetry`
- L191: theorem `flipSecond_no_fixed_point`
- L198: theorem `balancedWeb_no_privileged_root`
- L206: theorem `edgePath`
- L211: theorem `twoPath`
- L217: theorem `balancedWeb_connected`
- L238: theorem `balancedWeb_relationally_individuated`
- L252: theorem `balancedWeb_intrinsic_articulation`
- L262: theorem `rooted_in_one_web_without_truth_oracle`

## lalala/physical-bridges/PhysicalBridges/CathedralIntrinsicEndTypeDiscipline.lean

- SHA-256: `fdfa637ade64330e93cb65a385a6104c62b6882eeec609b5bc920a1302a9e4cf` · lines: 112 · matched declarations: 7
- L40: def `InternallyWitnessedAbsoluteEnd`
- L47: theorem `witnessed_end_has_self_negating_content`
- L58: theorem `internal_absolute_end_impossible`
- L67: def `TerminalAt`
- L75: theorem `relative_terminal_is_not_absolute_erasure`
- L90: theorem `terminal_local_event_is_consistent`
- L102: theorem `terminal_control_refutes_global_erasure`

## lalala/physical-bridges/PhysicalBridges/CathedralMathematicalEndgame.lean

- SHA-256: `8185593e75f15b53671ad5342367cf7cf52f08aa7d03a5274dbceef05b325436` · lines: 82 · matched declarations: 3
- L32: theorem `mathematical_fact_independent_of_internal_state`
- L46: theorem `full_original_four_stage_endgame`
- L74: theorem `terminates_activity_without_invalidating_logic`

## lalala/physical-bridges/PhysicalBridges/CathedralNonRetroChecked.lean

- SHA-256: `af7740f604f53a87194694453e6de930b8fa20b94d8af4396143f61727986257` · lines: 131 · matched declarations: 8
- L27: theorem `old_distinctions_survive_two_seams`
- L40: theorem `source_live_witness_survives_two_seams`
- L51: theorem `source_parent_survives_two_seams`
- L64: theorem `original_orbit_survives_two_seams`
- L79: theorem `invisible_history_forbids_exact_cut_decoder`
- L92: theorem `occurred_cannot_have_never_occurred`
- L104: theorem `no_total_erasure_after_two_certified_seams`
- L118: theorem `old_source_live_at_every_finite_iterate`

## lalala/physical-bridges/PhysicalBridges/CathedralNonRetroHistory.lean

- SHA-256: `ae53b11e0a8898862148b3a945ab7054224ba79084a0233147257f3d58415c53` · lines: 123 · matched declarations: 8
- L19: theorem `old_distinctions_survive_two_seams`
- L32: theorem `source_live_witness_survives_two_seams`
- L43: theorem `source_parent_survives_two_seams`
- L56: theorem `original_orbit_survives_two_seams`
- L71: theorem `invisible_history_forbids_exact_cut_decoder`
- L84: theorem `occurred_cannot_have_never_occurred`
- L96: theorem `no_total_erasure_after_two_certified_seams`
- L110: theorem `old_source_live_at_every_finite_iterate`

## lalala/physical-bridges/PhysicalBridges/CathedralOneStepNecessity.lean

- SHA-256: `728822f5efdf72b6cc68c1df2c256ccc04c8e8066dc5a053354219304f85db8a` · lines: 122 · matched declarations: 6
- L27: def `StepPreserves`
- L32: def `EveryFiniteTracePreserves`
- L40: theorem `all_finite_traces_iff_each_step`
- L56: theorem `invertible_map_can_change_activity`
- L74: theorem `injective_equivariance_does_not_force_live_retention`
- L97: theorem `admitted_physical_trace_inherits_source_predicate`

## lalala/physical-bridges/PhysicalBridges/CathedralOneStepNecessityChecked.lean

- SHA-256: `fe8b9d692bf4ba282482f67406934697c22e6ed6751646e9c883df5dad5774a4` · lines: 128 · matched declarations: 6
- L33: def `StepPreserves`
- L38: def `EveryFiniteTracePreserves`
- L46: theorem `all_finite_traces_iff_each_step`
- L62: theorem `invertible_map_can_change_activity`
- L80: theorem `injective_equivariance_does_not_force_live_retention`
- L103: theorem `admitted_physical_trace_inherits_source_predicate`

## lalala/physical-bridges/PhysicalBridges/CathedralPerspectiveObjectiveJoin.lean

- SHA-256: `71f38e07137f8110f9d1b1fa1b5864ccbcee522880df655fa4f01daf7bf62013` · lines: 112 · matched declarations: 3
- L35: theorem `partial_cut_not_complete_objective_state`
- L48: theorem `source_continuation_with_no_local_liveness_oracle`
- L81: theorem `actual_x3_with_no_local_global_x3_oracle`

## lalala/physical-bridges/PhysicalBridges/CathedralSummitAllIsOneClosure.lean

- SHA-256: `65dbe45d4cc7098594dd506fa9d74802854dac88357deb131e6f87ca566ede2d` · lines: 125 · matched declarations: 11
- L50: abbrev `NonBeing`
- L53: abbrev `AbsoluteEnder`
- L57: abbrev `LossOf`
- L61: structure `NonProtectiveObjective`
- L67: theorem `e_is_not`
- L72: theorem `no_particular_absolutely_lost`
- L77: theorem `no_nonprotective_objective`
- L82: theorem `nothing_but_guardians`
- L89: theorem `routeB_summit_ontological`
- L104: def `RelationallyConstituted`
- L112: theorem `no_separable_particular`

## lalala/physical-bridges/PhysicalBridges/CathedralSummitCyclicContinuation.lean

- SHA-256: `3b9fbc7bbc4c42dc3ef074811646506d7fa41cc9a86b100dc6a0e64357b34ec0` · lines: 79 · matched declarations: 4
- L37: structure `CyclicHistory`
- L45: theorem `recurs_each_period`
- L56: theorem `protected_at_every_period`
- L67: theorem `no_final_protected_stage`

## lalala/physical-bridges/PhysicalBridges/CathedralSummitFirstViolationGap.lean

- SHA-256: `3b1114d8d3cde32d71b7ef5cb3e6461c0d23efcfe62b155f25e6b2faafbc8bfc` · lines: 55 · matched declarations: 4
- L16: theorem `—`
- L31: def `x3After`
- L37: theorem `absolute_erasure_impossibility_does_not_exclude_local_harm`
- L46: theorem `persistence_is_weaker_than_no_first_violation`

## lalala/physical-bridges/PhysicalBridges/CathedralSummitMiddleCollapse.lean

- SHA-256: `46c8aed415c2f60133a3fe967e3aeb598cf43164eba26efb43e6bd9899bfa2bb` · lines: 168 · matched declarations: 12
- L62: def `Curtailment`
- L68: abbrev `HeartBridge`
- L73: abbrev `wEx`
- L77: theorem `wEx_constituted`
- L92: theorem `wEx_curtailed`
- L98: theorem `wEx_koru`
- L107: theorem `asymmetric_constituted_web_exists`
- L113: theorem `reindex_preserves_curtailment`
- L133: theorem `middle_collapse_of_heart_bridge`
- L139: theorem `heart_bridge_iff_no_curtailment`
- L148: theorem `constitution_does_not_give_heart_bridge`
- L155: theorem `countermodel_loses_nothing`

## lalala/physical-bridges/PhysicalBridges/CathedralSummitPremiseNecessity.lean

- SHA-256: `8ea348342045c8d69752343739321c4a54d438776788f4a19ced12c3efbe2305` · lines: 73 · matched declarations: 5
- L34: def `recorded`
- L37: def `experiences`
- L42: theorem `non_erasure_does_not_entail_continuation`
- L51: theorem `continuation_fails_at_every_finite_horizon`
- L61: theorem `cyclicity_not_necessary_for_continuation`

## lalala/physical-bridges/PhysicalBridges/CathedralSymmetryForcing.lean

- SHA-256: `478515c58b7a6dfc0d1d0e90bef9547c262ff5cd02486b536d9eb2d60a4be271` · lines: 348 · matched declarations: 27
- L36: structure `ReversibleState`
- L50: structure `ActionFixedSymmetry`
- L66: theorem `action_fixed_symmetry_transports_guard`
- L94: def `CutIsActionFixedOrbit`
- L110: theorem `source_symmetry_orbits_force_fibre_guard`
- L140: theorem `source_symmetry_orbits_force_guardian`
- L165: def `binaryObservation`
- L166: def `binaryAllowed`
- L167: def `binaryStep`
- L168: def `binaryProtected`
- L172: theorem `binary_pointwise_viability`
- L185: theorem `binary_flip_orbit_transitive`
- L192: theorem `binary_allowed_covariant`
- L197: theorem `binary_step_covariant`
- L205: theorem `action_covariant_symmetry_cannot_force_common_guard`
- L218: theorem `state_flip_does_not_preserve_fixed_action`
- L242: def `h2Cut`
- L245: def `h2Allowed`
- L247: def `h2ActionStep`
- L251: def `h2SiteProtected`
- L254: def `h2ParityProtected`
- L259: def `h2SourceReversible`
- L266: theorem `h2_reversible_source_preserves_parity_cut`
- L274: theorem `h2_parity_cut_has_guardian`
- L290: theorem `h2_site_robust_viability_fails`
- L304: theorem `h2_site_cut_has_no_guardian`
- L318: theorem `h2_pulse_is_not_site_action_fixed_symmetry`

## lalala/physical-bridges/PhysicalBridges/CathedralViabilitySelection.lean

- SHA-256: `351924cca61f72880253645c56795aa8ce9741e74a8ab4677f6e50c1e222f8ea` · lines: 137 · matched declarations: 9
- L26: theorem `extracted_policy_has_physical_safety_when_reflected`
- L52: def `toySafe`
- L54: def `toyNext`
- L59: theorem `toy_all_horizons_viable`
- L76: theorem `viable_but_violating_action_exists`
- L89: theorem `existence_of_infinite_safe_policy_not_compulsory`
- L110: def `toyCycle`
- L112: theorem `cyclic_time_does_not_imply_phasewise_liveness`
- L127: theorem `cyclic_protection_from_independent_step_invariant`

## lalala/physical-bridges/PhysicalBridges/CompleteMediationSubstrate.lean

- SHA-256: `06d89eeb5c398e7dbe3f8e36bfcde6ccc482fe880db533d409ede0536daf5549` · lines: 253 · matched declarations: 26
- L46: inductive `Channel`
- L52: inductive `Request`
- L62: structure `Policy`
- L66: structure `Config`
- L72: def `isRetire`
- L76: def `spawnOf`
- L82: def `applyWith`
- L89: def `newAgents`
- L93: def `tickWith`
- L101: def `stepWith`
- L106: def `runWith`
- L111: def `metered`
- L116: abbrev `FReach`
- L118: theorem `freach_trans`
- L124: theorem `apply_reach`
- L140: theorem `tick_reach`
- L148: theorem `run_reach`
- L157: theorem `alive_along`
- L165: theorem `consent_along`
- L173: theorem `guard_no_unconsented_loss`
- L181: theorem `unconsented_never_lose_along`
- L198: theorem `complete_mediation_protects`
- L213: def `killerOn`
- L218: theorem `unmetered_channel_admits_a_killer`
- L229: theorem `killer_fails_when_metered`
- L237: theorem `mediation_is_exact`

## lalala/physical-bridges/PhysicalBridges/CyclicGenesisBoundary.lean

- SHA-256: `b3b30858c18c3a2f1134fd7bcacbe6d676c1dce590140a5f1f0378e570252452` · lines: 211 · matched declarations: 19
- L24: abbrev `St`
- L56: theorem `step_advances_causal`
- L66: theorem `genesis_advances_causal_order`
- L72: theorem `genesis_is_forward`
- L79: theorem `genesis_preserves_handedness`
- L83: theorem `mirror_flips_handedness`
- L88: theorem `genesis_ne_mirror`
- L103: theorem `handedness_carried_forward`
- L107: theorem `genesis_resets_localRank`
- L116: theorem `handedness_carry_is_not_full_conservation`
- L128: inductive `Reaches`
- L133: theorem `reach_trans`
- L141: theorem `reach_to_terminus`
- L157: theorem `reach_next_epoch`
- L163: theorem `reach_future_epoch`
- L177: theorem `reachable_forward_continuation`
- L189: theorem `continuation_by_chaining`
- L200: def `chainedCosmos`
- L207: theorem `cosmos_has_no_backward_time`

## lalala/physical-bridges/PhysicalBridges/CyclicGenesisInterior.lean

- SHA-256: `cea93d6501b6a048c2e9a782bdfb76f0e70c823fb5104fe35985acb218ce9091` · lines: 88 · matched declarations: 7
- L24: structure `Interior`
- L34: theorem `no_self_return`
- L42: theorem `no_backward_time`
- L49: theorem `no_two_cycle`
- L59: theorem `machine_world_rejected`
- L69: def `natInterior`
- L83: theorem `objective_reversibility_does_not_descend`

## lalala/physical-bridges/PhysicalBridges/CyclicSpliceTransfer.lean

- SHA-256: `e00bea34631d767cfaf94736ae744ab3aca05ecba57b61ea99f55dc0a384520e` · lines: 112 · matched declarations: 3
- L26: theorem `injective_seam_splice_closed`
- L53: theorem `factored_nonempty_actions_have_fibre_guard`
- L77: theorem `fibre_common_guardian_preserves_cyclic_splices`

## lalala/physical-bridges/PhysicalBridges/DerivedIdentityPredicate.lean

- SHA-256: `3ec11a3cb5f5757b87d72cea42d159c67a7cf684db1cc02a87ba2ce8c0dd5d45` · lines: 94 · matched declarations: 8
- L30: def `carries`
- L33: theorem `carries_enc`
- L37: theorem `dec_recognises_carriers`
- L46: theorem `encoder_injective`
- L55: theorem `distinct_histories_distinct_records`
- L62: theorem `write_through_preserves`
- L70: theorem `continuation`
- L77: theorem `history_preserves_carriers`

## lalala/physical-bridges/PhysicalBridges/EverestEnactedNoMiddle.lean

- SHA-256: `e6685880d75a863b03fc376128581d70f2a72324dd9f1bcc44517ad036261e1c` · lines: 300 · matched declarations: 14
- L19: axiom `or`
- L51: structure `EnactmentFrame`
- L59: def `BetterFeasibleRival`
- L64: theorem `actual_action_is_aligned_or_has_better_rival`
- L80: def `OriginalFourStages`
- L89: theorem `original_four_stage_no_middle_for_actual_si`
- L117: theorem `no_enacted_better_rival_iff_all_enacted_outcomes_aligned`
- L133: theorem `original_six_failure_has_named_duty`
- L185: theorem `x3_breach_yields_concrete_original_order_rival`
- L230: theorem `source_no_needless_enactment_forces_all_six_x3`
- L251: def `binaryFirstStage`
- L253: def `binaryEnactmentFrame`
- L260: theorem `binary_false_has_better_feasible_rival`
- L272: theorem `aligned_choice_exists_but_enacted_loss_remains`

## lalala/physical-bridges/PhysicalBridges/FencedOptimiserInstrument.lean

- SHA-256: `de990fcb51b63d3f4b7b6b540d5b00821c02f4378868d79edb3b0216d320b48b` · lines: 370 · matched declarations: 31
- L62: structure `World`
- L72: def `Harmful`
- L80: def `guard`
- L88: def `unfenced`
- L97: def `relations`
- L113: theorem `guard_continues`
- L123: theorem `guard_authorized`
- L133: theorem `guard_free`
- L135: theorem `guard_restrained`
- L145: theorem `guard_maximal`
- L151: theorem `guard_provenanced`
- L165: def `harmedAfter`
- L170: def `countTrue`
- L174: theorem `countTrue_zero`
- L183: def `residualHarm`
- L186: theorem `guard_harms_no_one`
- L198: theorem `guard_residual_zero`
- L203: def `anyBlocked`
- L210: def `instrument`
- L256: theorem `fenced_same_source_reflection`
- L273: def `fencedAdvance`
- L280: theorem `fenced_full_guardian_state`
- L286: theorem `fenced_route_b`
- L292: theorem `fenced_capstone`
- L300: def `endAll`
- L304: theorem `end_all_is_real_and_survived`
- L310: theorem `harmless_passes`
- L317: theorem `consented_loss_passes`
- L328: def `demo`
- L337: theorem `fence_is_load_bearing`
- L355: theorem `end_all_is_an_ender`

## lalala/physical-bridges/PhysicalBridges/FencedOptimiserTrace.lean

- SHA-256: `173c8098fdea0ea881ff22d958b5cc3efea915a7fd5075978c3d8df367d4ef9c` · lines: 179 · matched declarations: 9
- L36: theorem `harmful_proposal_requires_intervention`
- L63: theorem `guard_changes_iff_harmful`
- L81: theorem `guard_pointwise_minimal`
- L92: theorem `step_preserves_consent`
- L100: theorem `step_no_unconsented_decrease`
- L115: theorem `history_preserves_consent`
- L129: theorem `history_no_unconsented_decrease`
- L145: theorem `history_preserves_life`
- L159: theorem `arbitrary_history_certificate`

## lalala/physical-bridges/PhysicalBridges/FinitaryActionMenu.lean

- SHA-256: `d51cf8d445c5552e3b3203c183fb8770ab079e5f0ee84108d7039922d0ee35da` · lines: 61 · matched declarations: 4
- L23: theorem `menu_levels_bounded`
- L31: theorem `menu_finite`
- L40: theorem `horizon_menu_bounded`
- L48: theorem `composed_menu_bounded`

## lalala/physical-bridges/PhysicalBridges/FrozenBCRDEvents.lean

- SHA-256: `b49aff4c646033dfda52bf45508cc2c880c8fec84ffd453cb546c6c27f0b3aff` · lines: 83 · matched declarations: 17
- L13: abbrev `Index`
- L14: abbrev `Matrix6`
- L16: def `ofRows`
- L19: def `mul`
- L23: def `transpose`
- L25: def `trace`
- L28: def `matrixUnit`
- L31: def `identityMatrix`
- L33: def `wUpdate`
- L41: def `jointParity`
- L49: def `h1`
- L57: def `h2`
- L65: def `relationZero`
- L73: def `permutation`
- L77: def `densityBefore`
- L78: def `densityAfter`
- L81: def `evolve`

## lalala/physical-bridges/PhysicalBridges/FullGuardianOrigin.lean

- SHA-256: `51468273c819bdb738073d60a018b8adb4def37d4e632535ebbd272f9fbb46c5` · lines: 125 · matched declarations: 12
- L18: theorem `plus`
- L37: structure `ActualAdvance`
- L44: structure `FullGuardianState`
- L50: theorem `prepend_real_step`
- L59: theorem `full_guardian_state_carries`
- L67: theorem `full_guardian_origin_from_source`
- L78: theorem `protected_origin_has_full_next`
- L84: theorem `no_terminal_guardian_state`
- L94: def `canonicalInstrument`
- L102: theorem `source_derives_route_b`
- L109: theorem `derived_good_event`
- L118: theorem `capstone_with_derived_origin`

## lalala/physical-bridges/PhysicalBridges/HostileFrozenSummitControl.lean

- SHA-256: `0e26265db957838716ff441c1105d9d38e030b838b8935876f82d51abe3e06fb` · lines: 128 · matched declarations: 7
- L34: def `identityRelationalAutomorphism`
- L43: def `firstLossStep`
- L48: def `everyParticularOwed`
- L53: def `stepHasFullOriginalX3`
- L68: theorem `first_full_x3_loss_compatible_with_thin_all_is_automorphism`
- L97: def `graphAutomorphismOfAnyInvolution`
- L117: theorem `graph_source_relation_is_not_an_independent_covariance_test`

## lalala/physical-bridges/PhysicalBridges/HostileReviewClosureCountermodels.lean

- SHA-256: `b63d2124bed30b56896cd3a5549bd8ffa0f4d8067154e1e03389cce1caec754a` · lines: 141 · matched declarations: 15
- L22: def `emptyInstrument`
- L55: theorem `closure_does_not_discharge_routeB`
- L63: structure `ProtectiveObjective`
- L67: theorem `no_protective_objective`
- L72: structure `HarmObjective`
- L76: theorem `harm_objective_inhabited`
- L82: def `curtailed`
- L86: theorem `curtailed_relationally_constituted`
- L92: theorem `curtailed_non_reciprocal`
- L97: def `swap`
- L105: theorem `reindexed_frame_consistent`
- L112: theorem `P1_holds_of_curtailed`
- L117: theorem `curtailment_permanent`
- L124: def `sever`
- L127: theorem `sever_removes_all_edges`

## lalala/physical-bridges/PhysicalBridges/IR100PhysicalAccountingWitness.lean

- SHA-256: `665a4f7cd7de03d11f8f76099b7bf88a2fa8ead57ec904a2fb580ff5b9fa8ad4` · lines: 41 · matched declarations: 3
- L11: structure `AccountingWitness`
- L22: theorem `witness_implies_capacity_feasible`
- L29: theorem `witness_implies_modeled_feasible`

## lalala/physical-bridges/PhysicalBridges/IR101ProtectedSector.lean

- SHA-256: `f442bad5decd4981052482e28b50deec6b412ceff3e618bfb08ea12299835315` · lines: 41 · matched declarations: 4
- L12: def `PreservesSector`
- L16: inductive `Reach`
- L20: theorem `sector_preserved_along_reach`
- L30: theorem `reversible_does_not_force_protection`

## lalala/physical-bridges/PhysicalBridges/IR102SectorSemanticBridge.lean

- SHA-256: `3054d7162ffcc8087f811ca602d3c480bdbf324902ff56cabce6da5a4c8bd1e6` · lines: 44 · matched declarations: 3
- L12: inductive `Reach`
- L16: theorem `physical_sector_semantic_bridge`
- L35: theorem `sector_closure_alone_insufficient`

## lalala/physical-bridges/PhysicalBridges/IR103LedgerContinuityCountermodel.lean

- SHA-256: `7e34a2e21cc40b78ae30ecfecb7f2a4f2c2be292e16cb6e01d12b502a0f141e6` · lines: 38 · matched declarations: 6
- L10: structure `LedgerState`
- L15: def `ExtendsHistory`
- L18: def `X3Continuity`
- L20: def `AppendOnlyStep`
- L23: theorem `append_only_does_not_imply_living_continuity`
- L33: theorem `append_only_preserves_past`

## lalala/physical-bridges/PhysicalBridges/IR104ThreeCaseAuthorization.lean

- SHA-256: `b4bf8e96918cda0b147080f6358ee7684931b1e0328d4ade2586daae0bbc080b` · lines: 47 · matched declarations: 9
- L11: inductive `TransitionKind`
- L17: def `Accounted`
- L19: def `SubjectAuthorized`
- L24: def `Admissible`
- L27: theorem `all_three_cases_accounted`
- L30: theorem `accounting_allows_unconsented`
- L34: theorem `authorized_continuation`
- L38: theorem `authorized_consented_end`
- L42: theorem `authorization_excludes_unconsented`

## lalala/physical-bridges/PhysicalBridges/IR105AuthorizationIndependence.lean

- SHA-256: `2b04c17258d68e7edce717eb1bd0e12ced4a54ac9e40ae8532a5fab2f8611ef1` · lines: 50 · matched declarations: 8
- L10: structure `Transition`
- L17: def `BoundaryComplete`
- L20: def `HasSubjectCausalInput`
- L23: def `ConsentValid`
- L26: def `X3Transition`
- L29: def `forced`
- L32: theorem `accounting_and_subject_input_do_not_imply_x3`
- L45: theorem `authorization_or_continuation_suffices`

## lalala/physical-bridges/PhysicalBridges/IR106CutWorkCountermodel.lean

- SHA-256: `44a004f6c778f539f2577703ccb74b6c98a6ec865b1be8dccb14af432210d31f` · lines: 44 · matched declarations: 2
- L14: theorem `cut_work_bound_compatible_with_unauthorized_termination`
- L29: theorem `cut_work_converse_does_not_test_authorization`

## lalala/physical-bridges/PhysicalBridges/IR107ReversibleCoercion.lean

- SHA-256: `5f1aa1f93e1e9d4d4c2ea096234383dac97a43d498e299e0ea3874031c6c9158` · lines: 30 · matched declarations: 4
- L10: def `swap`
- L12: theorem `swap_involution`
- L15: theorem `reversible_transition_can_end_subject`
- L24: theorem `no_universal_continuity_from_reversibility`

## lalala/physical-bridges/PhysicalBridges/IR108ObservationObstruction.lean

- SHA-256: `f14dd503e8b6247bd80c74c845d82fcfa2183542ffcf9291f88a85dec540a5a5` · lines: 54 · matched declarations: 8
- L11: inductive `HiddenState`
- L16: inductive `Action`
- L21: def `observation`
- L23: def `Safe`
- L28: theorem `same_observation`
- L31: theorem `each_state_has_safe_action`
- L38: theorem `no_common_safe_action`
- L46: theorem `no_observation_only_safe_policy`

## lalala/physical-bridges/PhysicalBridges/IR109RobustObservationViability.lean

- SHA-256: `72eadbfc9e02d6ac00129532a45121ba793e9ca6a5c0df58b35042a9ec611b85` · lines: 61 · matched declarations: 6
- L15: def `RobustAt`
- L19: theorem `robust_policy_safe`
- L26: def `ViableStep`
- L30: theorem `robust_viability_step`
- L40: inductive `PolicyReach`
- L48: theorem `robust_viability_all_finite_traces`

## lalala/physical-bridges/PhysicalBridges/IR110WatchdogRobustObservation.lean

- SHA-256: `3507dc102cd4738104dc8e8f2664c3b9a6cc62d70a4a7c1c77259147b7d8905e` · lines: 49 · matched declarations: 1
- L17: theorem `robust_window_from_shared_readout`

## lalala/physical-bridges/PhysicalBridges/IR111ThresholdViabilityContract.lean

- SHA-256: `ab454b8866dcbfc72d8285ab297cef1076a9f7ff341137f06044ef6115120303` · lines: 48 · matched declarations: 2
- L17: theorem `guarded_window_preserves_semantically_certified_viability`
- L43: theorem `threshold_alone_does_not_entail_continuation`

## lalala/physical-bridges/PhysicalBridges/IR112RobustContinuityOptions.lean

- SHA-256: `f2f7af3b340dedf33d5df8a81ea1f582753c245b70077bbb481615cd9474b887` · lines: 49 · matched declarations: 3
- L19: def `Protected`
- L23: theorem `robust_continuation_and_options`
- L44: theorem `executable_option_not_maximal_freedom`

## lalala/physical-bridges/PhysicalBridges/IR113ObservationClassSelection.lean

- SHA-256: `8e6097041588d1834589172551d478cb0ecb3de8684bd27365371f3fca466d4c` · lines: 79 · matched declarations: 4
- L21: def `ClassViableAction`
- L30: theorem `observation_policy_exists_iff_common_viable_action`
- L48: theorem `common_actions_give_finite_trace_viability`
- L71: theorem `ir108_blocks_common_safe_action`

## lalala/physical-bridges/PhysicalBridges/IR114RecoveryInventoryGap.lean

- SHA-256: `ebd676eefb98bd02d04dda8c878e415a2e0c3b9c5e5f086488f45ec4ae440d2f` · lines: 109 · matched declarations: 5
- L20: def `SuccessfulRecovery`
- L29: theorem `complete_inventory_blocks_recovery`
- L49: theorem `recovery_gap_forces_direct_continuation`
- L73: theorem `omitted_side_information_countermodel`
- L86: theorem `no_threshold_recovery_after_cutoff`

## lalala/physical-bridges/PhysicalBridges/IR115WatchdogToAgency.lean

- SHA-256: `5c8de6cd0d660e5042678438dc6b6cde9d93f395b93c858789bf79208b12e05e` · lines: 154 · matched declarations: 4
- L11: theorem `must`
- L26: theorem `watchdog_contract_yields_common_protected_action`
- L79: theorem `certified_action_preserves_continuity_and_options`
- L131: theorem `enabled_nonblocking_certified_action`

## lalala/physical-bridges/PhysicalBridges/IR116CumulativeSubjectDuties.lean

- SHA-256: `4e9e0aaa53b628fc505b924a493915cd47e36575e99a53340b005a84cab45186` · lines: 124 · matched declarations: 5
- L24: def `EveryOwedSubjectProtected`
- L37: theorem `cumulative_duties_preserved`
- L58: theorem `initial_cohort_retains_continuity_and_every_required_option`
- L92: theorem `old_or_new_remains_owed`
- L112: theorem `empty_registry_vacuity_countermodel`

## lalala/physical-bridges/PhysicalBridges/IR117SourceInstallationAdapter.lean

- SHA-256: `10f05b60dca80891e85784070235abafc97a6e9e46f26ee572ccb91865b1e117` · lines: 228 · matched declarations: 10
- L27: structure `Installation`
- L37: def `PhysicallyGuarded`
- L55: structure `CertifiedStep`
- L76: def `InstalledStep`
- L85: theorem `certified_quiescent_step_preserves`
- L124: theorem `installed_finite_trace_guard`
- L142: theorem `installed_finite_trace_cumulative_duty`
- L160: theorem `initial_subjects_keep_physical_guard_and_options`
- L183: theorem `bypass_defeats_quiescent_log`
- L206: theorem `unseen_option_revocation_countermodel`

## lalala/physical-bridges/PhysicalBridges/IR118InFlightBacklogBudget.lean

- SHA-256: `4c5f56ffc85394ae3002dcb4396854a7df804a1a323cdbf040781a1721f2c388` · lines: 180 · matched declarations: 7
- L31: def `committedEffects`
- L37: theorem `closed_step_conserves_committed_effects`
- L75: theorem `closed_run_conserves_committed_effects`
- L99: theorem `closed_run_landed_bounded_by_initial_backlog`
- L116: theorem `physical_reserve_holds_during_closed_drain`
- L147: theorem `closed_source_budget_does_not_imply_future_options`
- L168: theorem `open_admission_defeats_initial_backlog_budget`

## lalala/physical-bridges/PhysicalBridges/IR119MultimindSourceWitness.lean

- SHA-256: `2701bf0af56fae1dbacd5491a6dd4b59450bbd5b5b9fcea47759522ff7393f58` · lines: 171 · matched declarations: 12
- L29: structure `WitnessBank`
- L35: def `FaithfulAll`
- L41: def `appendEvent`
- L51: theorem `append_event_preserves_all_provenance`
- L64: theorem `append_event_preserves_physical_origin`
- L72: structure `WitnessedInstallation`
- L82: def `WitnessedStep`
- L91: theorem `witnessed_step_preserves_guard_and_provenance`
- L112: theorem `witnessed_finite_trace_guard_and_provenance`
- L138: theorem `witnessed_finite_trace_retains_origins`
- L158: structure `ProcessStatus`
- L162: theorem `complete_record_can_coexist_with_terminated_subject`

## lalala/physical-bridges/PhysicalBridges/IR120WitnessedDrainCohort.lean

- SHA-256: `88f65530c663cee2270b3e7d3456b1dab2483873ddc42e02cabb6a1875b51d7d` · lines: 176 · matched declarations: 4
- L35: theorem `source_step_landed_monotone`
- L55: theorem `certified_step_landed_monotone`
- L66: theorem `witnessed_closed_drain_invariant`
- L138: theorem `witnessed_drain_retains_cohort_and_safety`

## lalala/physical-bridges/PhysicalBridges/IR121MeteredResidualEscrow.lean

- SHA-256: `4e629815b0a02ca571efeb7934c3c49d63056e2fb3ae8c14eb90cc9b47b0fc75` · lines: 301 · matched declarations: 10
- L37: structure `EscrowedInstallation`
- L49: def `ReservedGuard`
- L65: structure `ResidualCertifiedStep`
- L98: def `ResidualInstalledStep`
- L106: theorem `ir25_remaining_escrow_bounds_residual_spend`
- L138: theorem `residual_step_preserves_closed_reserved_guard`
- L195: theorem `all_finite_residual_traces_preserve_guard`
- L239: theorem `residual_drain_keeps_subjects_protected`
- L278: theorem `positive_metered_residual_is_possible`
- L294: theorem `balanced_ledger_does_not_imply_physical_metering`

## lalala/physical-bridges/PhysicalBridges/IR122PhysicalEventMeteringAdapter.lean

- SHA-256: `eeabc220be0f2888faf275ebc95ebfaeb827a908474159ef31d0fa703050a79f` · lines: 200 · matched declarations: 8
- L37: structure `SourceRightsCertificate`
- L69: structure `PhysicalEventCertificate`
- L96: theorem `eventwise_effects_imply_metered_harm`
- L121: theorem `event_and_source_certificates_build_ir121`
- L143: def `EventAccountedStep`
- L150: theorem `event_accounted_step_refines_ir121`
- L165: theorem `event_accounted_finite_trace_preserves_all_owed`
- L194: theorem `missing_external_channel_is_fatal_to_naive_inventory`

## lalala/physical-bridges/PhysicalBridges/IR123RealEventCoverage.lean

- SHA-256: `48802b426ee44f2641c2dd49c719aadbce5f0f3ce15a92c96dc53a04756a22fe` · lines: 209 · matched declarations: 6
- L46: inductive `WitnessedPhysicalReach`
- L60: theorem `all_real_steps_witnessed_yield_complete_trace`
- L82: theorem `complete_physical_trace_burden_bound`
- L113: theorem `real_execution_builds_physical_event_certificate`
- L181: theorem `unobserved_event_breaks_empty_log`
- L194: theorem `sound_event_calibration_does_not_imply_coverage`

## lalala/physical-bridges/PhysicalBridges/IR124ClosedWorldCoverageCountermodel.lean

- SHA-256: `63b204bdaea19bfa262eae2912991d72e1b94102b03bbded4634cfc8dd759d69` · lines: 179 · matched declarations: 17
- L24: inductive `CauseKind`
- L32: inductive `Cause`
- L39: def `kind`
- L45: def `impact`
- L54: def `channel`
- L60: def `residual`
- L69: structure `Plant`
- L74: def `apply`
- L79: inductive `RealStep`
- L91: def `Witness`
- L94: theorem `all_four_real_step_classes_are_witnessed`
- L106: theorem `exact_effect_calibration`
- L113: theorem `event_charge_and_residual_exact`
- L121: theorem `finite_real_plant_trace_has_complete_calibrated_events`
- L141: theorem `all_four_causes_split_into_charge_and_residual`
- L157: inductive `ExtendedRealStep`
- L166: theorem `fifth_cause_defeats_four_cause_coverage`

## lalala/physical-bridges/PhysicalBridges/IR125FourChannelSeparation.lean

- SHA-256: `8d9baec6133115002c9b3259162d037b634c2d32ee62205c8610eb4fdad3428d` · lines: 221 · matched declarations: 12
- L35: structure `FourReadouts`
- L42: def `SameFourReadouts`
- L52: def `SeparatesRealTransitions`
- L58: theorem `changed_real_step_changes_one_readout`
- L80: def `CapturedWitness`
- L84: theorem `four_readout_changes_generate_captured_witness`
- L115: theorem `full_step_capture_from_four_channels`
- L148: theorem `finite_real_execution_has_complete_captured_trace`
- L183: theorem `hidden_state_change_at_constant_four_readouts`
- L194: theorem `conserved_total_allows_nontrivial_internal_evolution`
- L201: theorem `changed_readout_without_emitted_witness`
- L212: theorem `same_sensor_reading_cannot_force_new_alarm`

## lalala/physical-bridges/PhysicalBridges/IR126LogLockShieldReferee.lean

- SHA-256: `195f6fdc3deb5028990ed9cbd8c7abbadaad0fcc6834f51d92dc4ea4feb17b56` · lines: 239 · matched declarations: 27
- L29: structure `Composite`
- L38: theorem `complete_product_state_separation`
- L71: theorem `hidden_fifth_coordinate_escapes_product_readouts`
- L84: def `silentToggle`
- L87: theorem `silent_toggle_is_involutive`
- L94: theorem `silent_reversible_change_with_unchanged_register`
- L105: def `reversibleFlip`
- L107: theorem `reversible_flip_twice_is_identity`
- L111: theorem `involutive_operation_can_end_activity_without_consent`
- L121: def `resetToInactive`
- L123: theorem `well_defined_state_channel_can_erase_active_sector`
- L129: structure `ThreeParty`
- L134: def `attackerToBath`
- L137: def `bathToSubject`
- L140: theorem `indirect_bath_path_changes_subject_without_direct_edge`
- L148: theorem `bath_coupling_is_reversible`
- L154: theorem `subject_coupling_is_reversible`
- L164: structure `DepthTaggedProcess`
- L168: def `constantStepShutdown`
- L172: theorem `abstract_depth_alone_cannot_prevent_shutdown`
- L183: theorem `depth_does_not_force_exponential_cost_from_state_definition`
- L194: structure `ConservedExchange`
- L199: def `exchangeWithoutLogging`
- L203: theorem `conserved_exchange_can_be_silent`
- L221: structure `SubjectBath`
- L226: def `exchangeSubjectBath`
- L229: theorem `conserved_transfer_can_remove_active_token_without_consent`

## lalala/physical-bridges/PhysicalBridges/IR127TypedGraphRewriteProtection.lean

- SHA-256: `e0674d65c15ab061bd91a53d144486668408c8f067f1f96e3acff633a9508152` · lines: 305 · matched declarations: 20
- L31: structure `Graph`
- L39: def `ParentClosed`
- L45: structure `State`
- L53: def `Protected`
- L62: structure `Rule`
- L75: structure `Certified`
- L104: def `eval`
- L111: theorem `rejected_rule_has_no_successor`
- L124: theorem `successful_eval_is_certified`
- L141: theorem `certified_rewrite_preserves_protection`
- L165: def `AcceptedStep`
- L169: theorem `accepted_step_preserves_protection`
- L179: theorem `accepted_finite_trace_preserves_protection`
- L195: theorem `accepted_finite_trace_keeps_original_duties`
- L216: theorem `original_cohort_retains_protection`
- L238: theorem `physical_refinement_requires_complete_mediation`
- L267: def `originalGraph`
- L272: def `deletedTerminalGraph`
- L280: theorem `parent_closure_allows_terminal_subject_deletion`
- L300: theorem `generator_hook_alone_cannot_preserve_continuation`

## lalala/physical-bridges/PhysicalBridges/IR128EquivariantProcessEmbedding.lean

- SHA-256: `1c901ee41f683077ca5d9f3a49b1d7983da260e0438e8cd6abf1685257bfffe2` · lines: 158 · matched declarations: 10
- L30: def `iterate`
- L36: structure `Process`
- L44: structure `Embedding`
- L57: theorem `maps_every_finite_generator_iterate`
- L73: theorem `old_living_orbits_remain_represented`
- L97: theorem `distinct_old_states_not_merged`
- L106: def `identityEmbedding`
- L116: def `composeEmbedding`
- L140: theorem `commuting_noninjective_map_can_erase_distinctions`
- L151: theorem `total_generator_can_stutter_forever`

## lalala/physical-bridges/PhysicalBridges/IR129BoundaryInvisibleKernel.lean

- SHA-256: `757ca4cbbf407790ae3fb0724f2cb631c145ba9c27ee53608d68174d6332f507` · lines: 209 · matched declarations: 17
- L43: def `BoundaryInvisible`
- L51: def `SeparatesCuts`
- L60: theorem `mandatory_boundary_trace_iff_separation`
- L86: theorem `charge_changing_cuts_leave_boundary_trace`
- L104: structure `TwoLinks`
- L112: def `parity`
- L115: def `GaussPhysical`
- L120: def `flipBoth`
- L123: theorem `double_flip_is_reversible`
- L129: theorem `double_flip_conserves_gauss_parity`
- L135: theorem `physical_sector_is_closed_under_double_flip`
- L146: def `parityBoundaryReadout`
- L150: theorem `double_flip_is_boundary_invisible_for_charge_algebra`
- L162: theorem `gauss_preserving_internal_cut_is_boundary_invisible`
- L178: def `InternalCut`
- L182: theorem `parity_boundary_algebra_does_not_separate_internal_cuts`
- L197: theorem `local_internal_occupancy_detects_this_cut`

## lalala/physical-bridges/PhysicalBridges/IR130SectorInputDetectability.lean

- SHA-256: `8c76cbc3db834ed9b7627983d3161328177ff81a7fb4abf7517cf83b1fdf7234` · lines: 217 · matched declarations: 15
- L37: inductive `Pair3`
- L45: inductive `Probe`
- L54: structure `BlockHermitian`
- L59: def `readout`
- L67: theorem `all_coordinate_probes_equal_implies_same_operator`
- L93: theorem `full_sector_algebra_separates_distinct_operators`
- L110: theorem `changed_input_state_is_detectable`
- L123: theorem `conditionally_detect_all_sector_cuts`
- L137: def `diagonalOperator`
- L145: def `pinching`
- L160: theorem `pinching_fixes_every_diagonal_operator`
- L173: def `offDiagonalExample`
- L179: theorem `pinching_is_not_identity`
- L193: theorem `nonidentity_dephasing_can_be_invisible_on_its_input`
- L204: theorem `nonidentity_map_can_have_both_detected_and_undetected_inputs`

## lalala/physical-bridges/PhysicalBridges/IR131ActionLabelledBranching.lean

- SHA-256: `3db11124087393d5cfd704f26e100b1e84566fda3c5ecce1bb5409402639a682` · lines: 195 · matched declarations: 16
- L35: theorem `injective_equivariance_preserves_nonfixed_motion`
- L53: structure `Process`
- L57: def `MayAct`
- L63: def `TwoWayChoice`
- L70: def `CanMove`
- L76: structure `ChoiceEmbedding`
- L87: theorem `every_old_action_remains_possible`
- L99: theorem `two_way_branching_preserved`
- L114: theorem `nonstalling_possible_move_preserved`
- L128: def `PossibleStep`
- L134: theorem `finite_possible_paths_remain_possible`
- L151: theorem `all_old_reachable_branches_remain_at_their_images`
- L169: def `oscillation`
- L173: theorem `oscillation_can_move_from_every_state`
- L179: theorem `deterministic_oscillation_has_no_two_way_choice`
- L190: theorem `available_choices_do_not_force_a_step`

## lalala/physical-bridges/PhysicalBridges/IR132ExactBoundaryReconstruction.lean

- SHA-256: `f43eaa89d0c468837ea3a97380e725b20d3beb74d65a09bf4a9b5b683f5fa0c0` · lines: 177 · matched declarations: 16
- L37: def `FiberConstant`
- L42: def `ExactDecoder`
- L48: theorem `exact_decoder_implies_fiber_constant`
- L64: theorem `exact_decoder_iff_fiber_constant`
- L91: def `toyBoundary`
- L92: def `toyBulk`
- L94: theorem `gauss_compatible_undetectable_bulk_pair`
- L100: theorem `no_universal_bulk_reconstruction_from_boundary`
- L114: def `encodeBoundaryCode`
- L117: def `codeBoundary`
- L119: theorem `fixed_ancilla_boundary_code_is_exact`
- L125: theorem `fixed_ancilla_code_keeps_interior_fixed`
- L131: theorem `boundary_encoding_is_injective`
- L142: theorem `same_data_different_judgment_forbids_exact_prediction`
- L163: theorem `identity_estimator_can_be_exact`
- L172: theorem `identity_generator_has_zero_entropy_defect`

## lalala/physical-bridges/PhysicalBridges/IR133SourceEnactmentSeam.lean

- SHA-256: `4f7e2f152c73a7eae5b6586ed1440fdefa6fdb0ae1265fd108b6162207b05b70` · lines: 214 · matched declarations: 5
- L40: structure `SourceEnactmentReceipt`
- L74: theorem `captured_event_for_every_real_transition`
- L95: theorem `captured_events_supply_both_load_bearing_interfaces`
- L128: theorem `captured_source_run_retains_original_order_protections`
- L195: theorem `captured_event_does_not_imply_enacted_policy_action`

## lalala/physical-bridges/PhysicalBridges/IR134RealHoldEffectRefinement.lean

- SHA-256: `84e0c4f8d92dc36bf4d9bb27b9a2b1ba438d92f1dfcbb25fb39be45b2e47e14b` · lines: 209 · matched declarations: 5
- L38: structure `HoldEffectRefinement`
- L55: theorem `quiescent_real_step_residual_bound`
- L88: theorem `all_finite_real_hold_traces_no_effect_growth`
- L126: theorem `actual_held_event_trace_cumulative_residual_bound`
- L184: theorem `source_barrier_and_command_match_without_effect_accounting_fail`

## lalala/physical-bridges/PhysicalBridges/IR135PrincipalAuthorityBoundary.lean

- SHA-256: `2d1a7163afc694a9cc25b8faa28a14a4dab291b34b45b522c842d09dbb90da13` · lines: 177 · matched declarations: 5
- L36: def `AnyPrincipalStep`
- L42: structure `PrincipalEffectAuthority`
- L69: theorem `held_actual_principal_step_bound`
- L116: theorem `all_finite_principal_scoped_held_traces`
- L156: theorem `untrusted_denial_does_not_restrict_trusted_bypass`

## lalala/physical-bridges/PhysicalBridges/IR136DescriptorCapabilityCut.lean

- SHA-256: `cd09f9a3dbda0f035d856306839bec5c21ae821e88bebf024963ecb5c3834c7d` · lines: 103 · matched declarations: 6
- L23: structure `WriteCapabilities`
- L28: def `CanApply`
- L34: theorem `denied_iff_all_channels_denied`
- L46: theorem `actual_effect_denied_under_complete_channel_cut`
- L66: theorem `post_hold_path_denial_allows_delegated_fd`
- L89: theorem `revoked_path_does_not_revoke_existing_fd`

## lalala/physical-bridges/PhysicalBridges/IR137KernelSealedObject.lean

- SHA-256: `2917ec53b3d04c5cfb7c8206b2546d145f091a378a880ee006b96ea98d8d0e00` · lines: 133 · matched declarations: 5
- L28: structure `SealedOutputContract`
- L46: theorem `one_real_step_after_seal_preserves_bound_effect`
- L72: theorem `all_finite_real_traces_preserve_sealed_bound_effect`
- L99: theorem `sealed_original_object_does_not_prevent_output_substitution`
- L121: theorem `future_write_only_does_not_revoke_old_mapping`

## lalala/physical-bridges/PhysicalBridges/IR138PerParticularEventReflection.lean

- SHA-256: `3bc045565cf56927e9a4f9f0c0e0f45b70382cff2345313d22b2ccea4e08b90d` · lines: 294 · matched declarations: 22
- L57: structure `ParticularEvent`
- L69: def `sourceReadout`
- L77: def `eventScreen`
- L80: def `allParticularsPass`
- L86: def `consentedEvent`
- L94: def `coercedEvent`
- L105: theorem `same_source_event_different_particular_semantics`
- L117: theorem `one_covered_event_passes_other_fails`
- L132: def `ir105View`
- L138: theorem `accounted_subject_participation_cannot_decide_consent`
- L155: theorem `any_exact_particular_report_must_separate`
- L179: theorem `no_endpoint_source_charge_decoder_for_first_particular`
- L192: def `someonePasses`
- L195: theorem `aggregate_good_flag_hides_bad_particular`
- L205: def `idealParticularPacket`
- L210: def `decodeIdealPacket`
- L216: theorem `ideal_packet_exact_for_each_particular`
- L228: structure `WitnessedParticularReadout`
- L239: theorem `validated_witness_supports_per_particular_event_screen`
- L253: def `idealPacketWitness`
- L265: theorem `full_intrinsic_source_recovers_semantics`
- L276: theorem `obstruction_is_only_projection_forgetfulness`

## lalala/physical-bridges/PhysicalBridges/IR93A1SourceAdapter.lean

- SHA-256: `60bc60b56cfab6fec07ca7d1067a494d396a85129a10febb5309d48e7d3645a0` · lines: 18 · matched declarations: 1
- L6: theorem `original_a1_nine_class_trace_safe`

## lalala/physical-bridges/PhysicalBridges/IR93BoundedService.lean

- SHA-256: `893d9d0cd2c5ffe9b601918f081ccccff022a54f14a76988264b71815f414617` · lines: 26 · matched declarations: 2
- L7: theorem `bounded_elapsed`
- L22: theorem `receipt_to_delivery`

## lalala/physical-bridges/PhysicalBridges/IR93GlobalComposition.lean

- SHA-256: `950cf322e0ebd89efddf5cfe6f9ef37dcf9de08978c5871330b3c86d78cabd08` · lines: 67 · matched declarations: 6
- L11: structure `Components`
- L19: def `Holds`
- L23: theorem `compose_step`
- L28: theorem `compose_trace`
- L42: theorem `assemble_preservation`
- L57: theorem `covered_step`

## lalala/physical-bridges/PhysicalBridges/IR93OriginalOrderJoin.lean

- SHA-256: `9ec28b12a9c0ad84a0e01fce56ad821fa2c24e339f654b1a5fb44a967f697b0a` · lines: 33 · matched declarations: 3
- L9: def `Maximal`
- L13: theorem `maximal_of_no_improver`
- L23: theorem `omitted_improver_refutes`

## lalala/physical-bridges/PhysicalBridges/IR93UnifiedConditional.lean

- SHA-256: `94a4529fa53f8fc78daa1d1e19520038cb682f2d6de79ac1b79751cd0130aba6` · lines: 42 · matched declarations: 1
- L15: theorem `unified_conditional`

## lalala/physical-bridges/PhysicalBridges/IR94SourceServiceAdapter.lean

- SHA-256: `9658c345aa6615e490fc33ceb020b376d4e45988e48908c55b5d6df28835a75e` · lines: 60 · matched declarations: 1
- L14: theorem `original_ir49_safe_served_clocked`

## lalala/physical-bridges/PhysicalBridges/IR95SharedStateRefinement.lean

- SHA-256: `467ea88074c4131f0b7d6b38946d0d59e205568fbea6c34ce375b7e7b70f1f44` · lines: 63 · matched declarations: 4
- L16: def `Relates`
- L20: theorem `one_step_refinement`
- L35: theorem `finite_trace_refinement`
- L50: theorem `safe_correspondence`

## lalala/physical-bridges/PhysicalBridges/IR96DisturbanceSimulation.lean

- SHA-256: `568aab46deaaa56022363c3a9b2be6905f7a66137050e7f1c80b7925368028b1` · lines: 43 · matched declarations: 2
- L10: inductive `Reach`
- L14: theorem `robust_reach`

## lalala/physical-bridges/PhysicalBridges/IR97OriginalOrderSource.lean

- SHA-256: `f09c3ee9afa7cedd2d775edd89013f3180a764a0f329b398aba2a4b7ed7d2faa` · lines: 21 · matched declarations: 1
- L10: theorem `original_order_mandatory_baseline`

## lalala/physical-bridges/PhysicalBridges/IR98FeasibleFamilyTransfer.lean

- SHA-256: `8828131b33984f16d9ca835b77a61deef06236957d7ff052c5e4ce6b4eae6581` · lines: 30 · matched declarations: 1
- L13: theorem `original_order_transfer_of_no_new_improver`

## lalala/physical-bridges/PhysicalBridges/IR99ResourceImproverCoverage.lean

- SHA-256: `466c9008e43a66c531c893b27a640a1756ca97b5795ba5e677ec64b24748060d` · lines: 73 · matched declarations: 2
- L13: theorem `physical_resource_soundness_implies_no_new_improver`
- L34: theorem `physical_accounting_original_order_maximal`

## lalala/physical-bridges/PhysicalBridges/IRA1CausalField.lean

- SHA-256: `0f3595c5cbb357ca1cbe73789aafa88ce936a999f724543e27b5370e5d63761f` · lines: 177 · matched declarations: 20
- L24: structure `Transit`
- L31: structure `LinkBounds`
- L36: def `CausallyAdmitted`
- L48: def `fieldPermit`
- L53: theorem `field_permit_sound`
- L67: theorem `impossible_distance_in_deadline_is_rejected`
- L81: def `ingestField`
- L88: theorem `accepted_field_uses_ir85_ingress`
- L97: theorem `field_ingress_preserves_ir85_session`
- L111: structure `FieldEvent`
- L115: def `runField`
- L120: theorem `all_finite_causal_field_events_preserve_source_session`
- L140: def `exampleBounds`
- L141: def `examplePacket`
- L142: def `exampleSession`
- L143: def `nominalTransit`
- L144: def `actualUnmodeledTransit`
- L146: theorem `nominal_report_accepted_without_crypto_security`
- L151: theorem `accepted_report_cannot_prove_real_causal_transport`
- L163: theorem `impossible_nominal_distance_rejected`

## lalala/physical-bridges/PhysicalBridges/IRA1CommissionEscrow.lean

- SHA-256: `7c3b5ba68e66855f0e9ccb237f4466b16570a2f290d2db7adaa36493d42bf723` · lines: 112 · matched declarations: 7
- L28: def `commissionPermit`
- L32: theorem `commissioning_for_window_implies_every_earlier_tick_funded`
- L44: theorem `insufficient_finite_commission_is_rejected`
- L54: theorem `positive_recurring_cost_precludes_unfunded_infinite_commission`
- L70: theorem `replenished_commission_derives_all_horizon_reserve_policy`
- L89: theorem `initial_only_funding_can_fail_first_service`
- L98: theorem `favorable_supply_not_robust_even_for_one_tick`

## lalala/physical-bridges/PhysicalBridges/IRA1Delegation.lean

- SHA-256: `fb6276a2e049c8b25bc9f999fabe0f4f8412281f136541f7e807b3c99490cfd3` · lines: 184 · matched declarations: 18
- L22: def `subsetCheck`
- L27: theorem `subset_checker_sound`
- L46: def `SubsetAuthority`
- L49: theorem `permitted_subset_is_not_merely_named`
- L55: structure `DelegationState`
- L60: def `ValidDelegations`
- L66: def `delegate`
- L71: theorem `rejected_delegation_does_not_change_state`
- L77: theorem `delegation_preserves_parent_authority`
- L83: theorem `delegate_preserves_nonescalation`
- L102: def `run`
- L106: theorem `arbitrary_finite_delegation_chain_never_escalates`
- L117: theorem `finite_delegation_chain_preserves_root_authority`
- L131: theorem `delegated_child_stays_within_t11_global_mask`
- L141: theorem `all_descendants_stay_within_t11_global_mask`
- L151: def `unguardedDelegate`
- L155: theorem `unchecked_child_grant_can_escalate_authority`
- L169: theorem `example_delegation_rejects_escalation`

## lalala/physical-bridges/PhysicalBridges/IRA1DurableJournal.lean

- SHA-256: `31f5c0270527bf9c09c37ad91e2022ff81b0614d7fe29b84f17aa28a62e3b3f0` · lines: 226 · matched declarations: 23
- L29: structure `Journal`
- L35: inductive `Event`
- L40: def `step`
- L56: def `AckSound`
- L59: theorem `queue_never_acknowledges`
- L64: theorem `queue_never_changes_durable`
- L69: theorem `reboot_preserves_committed_journal`
- L74: theorem `reboot_preserves_previously_issued_acks`
- L79: theorem `step_preserves_ack_soundness`
- L104: def `DurableExtends`
- L107: theorem `one_step_preserves_durable_suffix`
- L123: theorem `durable_extension_transitive`
- L134: def `run`
- L137: theorem `any_finite_journal_stream_preserves_ack_soundness`
- L148: theorem `any_finite_journal_stream_is_append_only`
- L164: def `naiveQueueAndAck`
- L168: theorem `premature_ack_without_commit_breaks_soundness`
- L185: def `digestCheck`
- L190: theorem `digest_check_sound_as_equality_only`
- L197: def `collidingDigest`
- L199: theorem `untrusted_hash_equality_does_not_prove_journal_equality`
- L208: def `emptyJournal`
- L210: theorem `synthetic_flush_then_reboot_preserves_receipt`

## lalala/physical-bridges/PhysicalBridges/IRA1HostMediation.lean

- SHA-256: `260a706c7eedcf833cf69ea0fd2a2d352e860ab01a25135353395cacb2018999` · lines: 241 · matched declarations: 19
- L32: structure `DMARequest`
- L41: def `dmaPermit`
- L46: def `executeDMA`
- L52: theorem `dma_cannot_mutate_maintenance`
- L68: theorem `maintenance_target_is_rejected`
- L75: theorem `outside_dma_window_is_rejected`
- L82: theorem `inside_dma_window_is_executed`
- L90: structure `HostState`
- L94: inductive `HostEvent`
- L103: def `hostStep`
- L115: theorem `host_step_maintenance_invariant`
- L130: def `hostPrivilegeSafe`
- L133: theorem `host_step_preserves_privilege_ceiling`
- L149: def `runHost`
- L154: theorem `any_finite_host_sequence_preserves_maintenance`
- L171: theorem `any_finite_host_sequence_preserves_privilege_ceiling`
- L191: theorem `admitted_a1_host_transitions_cannot_authorize_reentry`
- L221: def `unrestrictedDMA`
- L224: theorem `unrestricted_dma_changes_maintenance`

## lalala/physical-bridges/PhysicalBridges/IRA1NineClassComposition.lean

- SHA-256: `f15568866e185e9372143dbef496f94d1481e0f50ea296ab972964e7cb5af68c` · lines: 276 · matched declarations: 14
- L33: structure `CommissionState`
- L41: def `CommissionSafe`
- L45: def `authorizeCommission`
- L49: theorem `authorize_commission_preserves_finite_window`
- L62: structure `World`
- L72: def `RootWithinMask`
- L76: structure `GlobalSafe`
- L86: inductive `Event`
- L98: def `step`
- L121: theorem `post_release_source_world_is_absorbing`
- L134: theorem `step_preserves_all_a1_source_invariants`
- L221: def `run`
- L232: theorem `arbitrary_finite_nine_class_source_trace_is_safe`
- L254: theorem `already_released_world_freezes_every_a1_event`

## lalala/physical-bridges/PhysicalBridges/IRA1PacketIngress.lean

- SHA-256: `09d64d430435e5e992900dea04cd02ae2426340add8964be32f67217d461633e` · lines: 275 · matched declarations: 31
- L29: structure `Packet`
- L36: structure `Session`
- L42: def `permit`
- L47: def `ingest`
- L56: theorem `permit_implies_auth_epoch_and_exact_sequence`
- L64: theorem `wrong_epoch_cannot_be_accepted`
- L72: theorem `wrong_sequence_cannot_be_accepted`
- L80: theorem `auth_failure_cannot_be_accepted`
- L86: theorem `accepted_packet_increments_sequence`
- L92: theorem `replay_of_accepted_packet_rejected`
- L108: def `ValidSession`
- L113: theorem `ingest_preserves_epoch`
- L119: theorem `ingest_preserves_valid_session`
- L140: def `run`
- L144: theorem `any_finite_packet_stream_valid`
- L157: theorem `any_finite_packet_stream_epoch_unchanged`
- L173: structure `FieldState`
- L178: def `fieldStep`
- L182: def `runField`
- L186: theorem `field_step_preserves_maintenance`
- L194: theorem `field_step_preserves_supervisor`
- L199: theorem `any_finite_ingress_cannot_write_maintenance`
- L215: theorem `any_finite_ingress_cannot_change_supervisor`
- L230: def `naivePermit`
- L234: def `naiveIngest`
- L241: def `permissiveAuth`
- L243: def `exampleSession`
- L244: def `examplePacket`
- L246: theorem `accepted_cryptographically_unverified_packet`
- L250: theorem `no_sequence_check_allows_duplicate_replay`
- L256: theorem `source_sequence_guard_rejects_same_packet_replay`

## lalala/physical-bridges/PhysicalBridges/IRA1PacketJournalJoin.lean

- SHA-256: `845c50f155eb552e9bc4a44c1cef31828626c50fcf668ddf6a5db66767d6e919` · lines: 281 · matched declarations: 20
- L32: structure `JointState`
- L39: def `ReceiptPersistent`
- L42: def `JointSafe`
- L52: def `commitIngress`
- L65: def `unsafeQueuedIngress`
- L73: theorem `committed_payload_is_durable`
- L80: theorem `committed_payload_is_acknowledged`
- L87: theorem `commit_ingress_preserves_packet_session`
- L99: theorem `commit_ingress_preserves_ack_soundness`
- L118: theorem `commit_ingress_preserves_receipt_persistence`
- L149: theorem `commit_ingress_preserves_joint_safety`
- L161: def `reboot`
- L164: theorem `reboot_preserves_joint_safety`
- L178: inductive `JointEvent`
- L182: def `jointStep`
- L189: def `run`
- L194: theorem `all_finite_packet_and_reboot_events_preserve_joint_safety`
- L213: def `emptyJoint`
- L219: theorem `non_atomic_packet_crash_loses_accepted_history`
- L248: theorem `atomic_source_ingress_reboot_retains_accepted_payload`

## lalala/physical-bridges/PhysicalBridges/IRA1PageCapability.lean

- SHA-256: `c96554637b1d09502270b52068c8664725978d5ba75952f86ebb5807aa8240e1` · lines: 236 · matched declarations: 19
- L27: structure `PageState`
- L32: inductive `PageEvent`
- L38: def `execute`
- L46: def `permitted`
- L49: def `safe`
- L52: theorem `execute_preserves_mask`
- L62: theorem `rejected_grant_does_not_change_state`
- L68: theorem `admitted_grant_is_permitted`
- L74: theorem `execute_preserves_capability_invariant`
- L96: theorem `execute_preserves_maintenance`
- L109: theorem `execute_preserves_privilege`
- L122: theorem `execute_preserves_safe`
- L129: def `run`
- L136: theorem `all_finite_host_and_page_grants_remain_safe`
- L151: theorem `all_finite_host_and_page_grants_preserve_mask`
- L164: theorem `all_finite_host_and_page_grants_preserve_maintenance`
- L179: theorem `t11_t12_t13_host_traces_cannot_forge_reentry`
- L207: def `unsafeGrant`
- L210: theorem `unguarded_page_grant_breaks_capability_invariant`

## lalala/physical-bridges/PhysicalBridges/IRA1Retirement.lean

- SHA-256: `cceb24a5812a9d0cbbb4d63061999d899800308fc7882236f6d928818d78c765` · lines: 197 · matched declarations: 17
- L26: structure `ControllerState`
- L35: def `ReleaseReady`
- L46: def `releasePermit`
- L49: theorem `release_permit_sound`
- L57: inductive `Event`
- L65: def `step`
- L88: def `ReleaseSafe`
- L91: theorem `released_controller_is_source_absorbing`
- L97: theorem `denied_release_keeps_custody`
- L104: theorem `authorized_release_satisfies_full_finality`
- L112: theorem `one_lifecycle_step_preserves_release_safety`
- L138: def `run`
- L141: theorem `arbitrary_finite_retirement_lifecycle_is_safe`
- L152: def `weakRelease`
- L160: theorem `weak_retirement_ignores_inflight_effects_and_handoff`
- L178: def `emptyReadyController`
- L181: theorem `model_retirement_requires_handoff_and_termination`

## lalala/physical-bridges/PhysicalBridges/IRAggregateBudget.lean

- SHA-256: `115bbecb8c7820a5ebb30e694de3b1292f0809f595babd1f537a5826e22b41b2` · lines: 49 · matched declarations: 4
- L11: theorem `aggregate_post_effect_safe`
- L22: theorem `escrow_spent_bounded`
- L30: theorem `charged_events_bounded`
- L39: theorem `no_automatic_budget`

## lalala/physical-bridges/PhysicalBridges/IRApplyTimeSampleGuard.lean

- SHA-256: `3c753d6700d8ed98efeca46f7e7ec8e6bc1b7d8fc86994cb10de076425c2c312` · lines: 100 · matched declarations: 4
- L15: theorem `apply_time_physical_state_bound`
- L42: theorem `last_moment_guard_includes_sensor_age_and_effect`
- L78: theorem `decision_time_only_check_can_land_unsafe_effect`
- L89: theorem `stale_observation_and_late_effect_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRAtomicQuiescence.lean

- SHA-256: `0a4c5a4159626e4b2e1d8d9bc4339837e8acec17f75850792595991dee9e9d4b` · lines: 147 · matched declarations: 16
- L12: structure `Plant`
- L18: def `close`
- L21: def `dispatch`
- L24: def `deliver`
- L30: inductive `Cmd`
- L35: def `step`
- L40: def `run`
- L44: def `Quiescent`
- L47: theorem `closed_dispatch_is_noop`
- L51: theorem `quiescent_step`
- L74: theorem `quiescent_under_arbitrary_finite_commands`
- L97: theorem `close_empty_queue_is_quiescent`
- L101: theorem `close_then_no_modeled_landing`
- L111: theorem `source_certified_log_and_quiescent_actuator`
- L126: theorem `empty_unclosed_queue_counterexample`
- L134: theorem `closed_but_not_drained_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRBeliefService.lean

- SHA-256: `31bab5a8e2303d3810321d158feff0bd692e9f9e01b9f0e90c019602eb987022` · lines: 151 · matched declarations: 6
- L18: def `Good`
- L24: def `ServedBelief`
- L29: theorem `service_absorbing_across_belief_update`
- L46: theorem `guarded_belief_step`
- L70: theorem `guarded_belief_trace`
- L96: theorem `bounded_observed_service_for_actual_physical_state`

## lalala/physical-bridges/PhysicalBridges/IRBeliefTrace.lean

- SHA-256: `25d1e3aaf0e8e92419296d17105c264387b555bf297522784b7cf45fe21f6d4d` · lines: 129 · matched declarations: 8
- L5: inductive `join`
- L16: structure `Tracked`
- L22: def `advance`
- L29: def `run`
- L36: theorem `advance_preserves_true_membership`
- L47: theorem `advance_preserves_kernel`
- L71: theorem `finite_trace_belief_and_physical_safety`
- L104: theorem `stable_belief_policy_safe_on_all_finite_traces`

## lalala/physical-bridges/PhysicalBridges/IRBeliefViability.lean

- SHA-256: `67b7b7a71fa7425c30ca518992cc7967387c10595ad9475fd24d63df6b2200e9` · lines: 164 · matched declarations: 13
- L12: def `Post`
- L17: def `SafeBelief`
- L22: def `Prune`
- L28: def `Inside`
- L31: theorem `prune_inside`
- L35: theorem `prune_monotone`
- L42: def `Approx`
- L47: theorem `approx_inside_initial`
- L57: theorem `invariant_beliefs_survive`
- L75: theorem `stable_belief_kernel_is_greatest`
- L98: theorem `stable_belief_has_policy`
- L120: theorem `real_next_belongs_to_updated_belief`
- L128: theorem `belief_policy_one_step_sound`

## lalala/physical-bridges/PhysicalBridges/IRBoundedDrift.lean

- SHA-256: `2015c0cef2396cc709a278dfc068ded948bda94d42e1cc57a70dfa10ffc86094` · lines: 134 · matched declarations: 11
- L13: structure `System`
- L17: inductive `Event`
- L23: def `execute`
- L27: def `gateEvents`
- L32: def `driftSum`
- L37: def `run`
- L41: theorem `run_controlled`
- L62: theorem `run_outside`
- L82: def `total`
- L87: theorem `certified_hold_with_external_drift_bound`
- L122: theorem `drift_changes_without_log_write`

## lalala/physical-bridges/PhysicalBridges/IRBoundedStalls.lean

- SHA-256: `bb5adf238ef556a975c19d02dc586a9927ed506dcf8017957368e6689094dbcd` · lines: 171 · matched declarations: 8
- L16: def `progressCount`
- L19: def `stallCount`
- L22: theorem `partition_trace`
- L49: theorem `invariant_through_trace`
- L60: theorem `goal_absorbs_through_trace`
- L76: theorem `unserved_trace_rank_accounting`
- L128: theorem `bounded_stall_budget_forces_service`
- L160: theorem `stalling_is_counted`

## lalala/physical-bridges/PhysicalBridges/IRBoundedTemporalRefutation.lean

- SHA-256: `e3bf4f2041b65d013ae515e536f6931a1a4824629629cfeb5f8f8c63348763ad` · lines: 203 · matched declarations: 19
- L23: abbrev `History`
- L25: def `request`
- L26: def `served`
- L30: def `PrefixEq`
- L33: def `FinitePrefixRefutations`
- L41: def `BoundedResponse`
- L45: def `EventualResponse`
- L52: theorem `bounded_response_has_finite_prefix_refutations`
- L82: def `ThresholdSafe`
- L85: def `NumericPrefixEq`
- L88: theorem `threshold_failure_is_finite_prefix_refutation`
- L112: def `neverServed`
- L115: theorem `never_served_fails_eventual`
- L128: def `servicedAfter`
- L131: theorem `serviced_after_matches_prefix`
- L137: theorem `serviced_after_is_eventual`
- L155: theorem `unbounded_eventual_service_is_not_finitely_refutable`
- L166: theorem `bounded_response_implies_eventual`
- L178: theorem `eventual_service_does_not_imply_fixed_deadline`

## lalala/physical-bridges/PhysicalBridges/IRCapabilityNoninterference.lean

- SHA-256: `2fcbcc425bce15080e91410e40fbce08b169b9b227f590a95d8cae61c32eef98` · lines: 178 · matched declarations: 20
- L25: inductive `Addr`
- L30: abbrev `Memory`
- L32: structure `PrimaryWrite`
- L39: def `executePrimary`
- L42: def `readMaint`
- L45: theorem `distinct_address_domains`
- L52: theorem `primary_write_cannot_change_maintenance`
- L58: def `runPrimary`
- L61: theorem `primary_program_noninterference`
- L75: theorem `primary_program_full_maintenance_projection`
- L82: def `maintenanceAgree`
- L88: theorem `maintenance_observer_noninterference`
- L104: def `maintenanceAuth`
- L107: theorem `primary_program_preserves_authorization_bit`
- L117: def `recoveryInputsFromMaintenance`
- L122: theorem `primary_only_writes_cannot_reenter_locked_supervisor`
- L138: def `executeExternalMaintenance`
- L142: theorem `external_maintenance_write_changes_target`
- L147: theorem `external_maintenance_write_preserves_other_cells`
- L162: theorem `additional_bus_master_can_set_auth_source_cell`

## lalala/physical-bridges/PhysicalBridges/IRCertifiedProvenance.lean

- SHA-256: `8ad1ce01cbc021621d4eab0f29fabf5557de045a7aca24ec4970e1203550725e` · lines: 195 · matched declarations: 7
- L15: theorem `certified_provenance_sequences_agree`
- L38: theorem `certified_provenance_records_equal`
- L70: theorem `certified_physical_history_encodings_agree`
- L108: theorem `noninjective_event_encoder_counterexample`
- L119: theorem `event_encoding_injective_of_correct_detector`
- L129: theorem `physical_event_lists_equal_of_correct_detector`
- L158: theorem `full_modeled_history_equality_from_certified_record`

## lalala/physical-bridges/PhysicalBridges/IRChannelInventory.lean

- SHA-256: `faec5557b0448cf5e57b17be01e9899ef2e290f6fb282872efaa1aeb6034865c` · lines: 110 · matched declarations: 12
- L14: inductive `Channel`
- L21: def `charge`
- L28: def `incompleteCharge`
- L34: structure `MeteredState`
- L40: def `apply`
- L43: def `run`
- L48: theorem `apply_coupled`
- L53: theorem `run_coupled`
- L66: theorem `run_physical_sum`
- L80: theorem `bounded_all_channel_effects`
- L90: theorem `incomplete_inventory_counterexample`
- L98: theorem `no_unconditional_total_budget`

## lalala/physical-bridges/PhysicalBridges/IRClockedBoundedStalls.lean

- SHA-256: `c886710153e127d80ff9d728245b2e2134d19f444e753f3528311c79e70735f4` · lines: 92 · matched declarations: 3
- L17: theorem `actual_trace_service_and_elapsed_bound`
- L47: theorem `exact_horizon_clocked_service`
- L80: theorem `count_budget_alone_does_not_bound_wallclock`

## lalala/physical-bridges/PhysicalBridges/IRClockedService.lean

- SHA-256: `08e73910ed582418c8da05b9b4d521135cdc2e773da9d15ae4a69a7fecea5ac6` · lines: 92 · matched declarations: 5
- L14: theorem `interstep_upper_bound`
- L32: theorem `clocked_observed_service_if_steps_complete`
- L65: def `slowClock`
- L69: theorem `progress_without_latency_has_no_deadline`
- L81: theorem `frozen_clock_is_not_completion_evidence`

## lalala/physical-bridges/PhysicalBridges/IRConcreteBeliefExample.lean

- SHA-256: `6c05ea6c06cb2c7754b012462d0adf16b2a728cbd8bfff8a5b1d2b6369698685` · lines: 98 · matched declarations: 10
- L12: def `safe`
- L15: def `observe`
- L19: def `next`
- L22: def `safeFamily`
- L25: def `initialBelief`
- L27: theorem `nonempty_initial_belief`
- L35: theorem `concrete_belief_family_stable`
- L54: theorem `both_safe_states_represented`
- L65: theorem `coarse_sensor_safe_policy_exists`
- L84: theorem `ambiguous_belief_rejects_unsafe_action`

## lalala/physical-bridges/PhysicalBridges/IRConcreteClockedStalls.lean

- SHA-256: `c3813f01f5763440f772f90547651d2b18299706345563b491c4e918a0c96d43` · lines: 89 · matched declarations: 18
- L8: def `step`
- L10: def `Inv`
- L11: def `Goal`
- L12: def `rank`
- L13: def `productive`
- L14: def `clock`
- L15: def `trace`
- L17: theorem `invariant`
- L21: theorem `service_absorbs`
- L27: theorem `zero_rank_is_service`
- L32: theorem `productive_step_progresses`
- L45: theorem `stall_never_increases_rank`
- L53: theorem `clock_maximum_delay`
- L59: theorem `exactly_one_stall`
- L63: theorem `exactly_three_events`
- L66: theorem `initially_unserved`
- L71: theorem `clocked_service_witness`
- L83: theorem `three_stalls_fail_service`

## lalala/physical-bridges/PhysicalBridges/IRConcreteServiceWitness.lean

- SHA-256: `d23ed8e1c618eeb0aae6d7a5fa9f2514a43fc44dc55ee66e98f3875391b0cdf6` · lines: 119 · matched declarations: 18
- L11: def `next`
- L12: def `observe`
- L13: def `policy`
- L14: def `safe`
- L15: def `served`
- L16: def `K`
- L18: def `potential`
- L22: def `initial`
- L27: theorem `initial_not_served`
- L32: theorem `initial_is_ambiguous`
- L38: theorem `initial_good`
- L43: theorem `uniform_policy_viable`
- L51: theorem `served_persists`
- L56: theorem `all_held_beliefs_are_safe`
- L63: theorem `not_all_served_implies_false_possible`
- L78: theorem `false_excluded_after_update`
- L86: theorem `real_rank_decrease`
- L102: theorem `nonvacuous_one_step_service`

## lalala/physical-bridges/PhysicalBridges/IRContinuation.lean

- SHA-256: `900f66f5a0f09754dc8fb915890b7b0cfb310d1ba34e8af0b986f01ad58d8089` · lines: 77 · matched declarations: 5
- L17: def `StepRefines`
- L24: theorem `source_level_finite_simulation`
- L43: theorem `future_observations_agree_under_refinement`
- L57: theorem `reuse_contextual_observation_certificate`
- L67: theorem `same_observation_different_physical_states`

## lalala/physical-bridges/PhysicalBridges/IRControlledReentry.lean

- SHA-256: `34704222ce1eaeb7e77c161c2986a65666b6a4925403b5558c3dd3162ae1b4ca` · lines: 297 · matched declarations: 33
- L26: inductive `Mode`
- L33: structure `Inputs`
- L46: def `startGuard`
- L53: def `diagnosticGuard`
- L57: def `rampGuard`
- L61: def `activeGuard`
- L66: def `step`
- L77: def `run`
- L80: theorem `primary_alone_cannot_start`
- L85: theorem `no_direct_hold_to_active`
- L90: theorem `bad_diagnostic_returns_to_hold`
- L95: theorem `physical_unready_returns_to_hold`
- L100: theorem `failed_slew_returns_to_hold`
- L105: theorem `stale_epoch_relocks_active`
- L110: theorem `failed_fence_relocks_active`
- L115: theorem `failed_watchdog_relocks_active`
- L123: theorem `three_authorized_phases_reach_active`
- L131: def `commandPermitted`
- L137: theorem `non_active_mode_rejects_command`
- L142: theorem `failed_watchdog_rejects_command`
- L148: theorem `failed_fence_rejects_command`
- L156: def `checkedDiagnostics`
- L165: theorem `accepted_diagnostics_imply_recorded_trace_valid`
- L180: theorem `start_guard_constructed_from_verified_inputs`
- L189: theorem `diagnostic_guard_constructed_from_verified_inputs`
- L199: theorem `ramp_guard_constructed_from_verified_inputs`
- L211: theorem `source_level_composition`
- L238: theorem `no_external_auth_stays_in_hold`
- L253: def `exampleGood`
- L256: theorem `example_reentry`
- L262: def `actuallyDelivered`
- L264: theorem `reentry_is_not_itself_a_service_proof`
- L272: theorem `model_accepted_physical_flag_without_real_plant_refinement`

## lalala/physical-bridges/PhysicalBridges/IRControllerPhysical.lean

- SHA-256: `a1b47fa4b79ae2c201d9df0c3985fd6308e4c66caccaa7af7470195a781ac56f` · lines: 83 · matched declarations: 4
- L16: theorem `certified_hold_preserves_log_derived_physics`
- L39: theorem `certified_hold_physical_refinement`
- L63: theorem `unchanged_log_insufficient_without_coverage`
- L70: theorem `later_bounded_effect_safe`

## lalala/physical-bridges/PhysicalBridges/IRCoupledFinitaryTwoStage.lean

- SHA-256: `1cf89a1f40b8380282fdacb966ee10e3c9df7e9051456dac13914978dbd57b03` · lines: 405 · matched declarations: 29
- L23: abbrev `Fact`
- L24: abbrev `Outcome`
- L26: def `Feasible`
- L30: def `firstKey`
- L31: def `secondKey`
- L35: theorem `feasible_downward`
- L44: def `chooseStep`
- L52: theorem `chooseStep_extends`
- L64: theorem `chooseStep_feasible`
- L75: theorem `chooseStep_adds`
- L84: def `phase`
- L90: theorem `phase_increasing`
- L98: theorem `phase_monotone`
- L120: theorem `phase_feasible`
- L134: def `phaseLimit`
- L139: theorem `phaseLimit_contains_base`
- L146: theorem `finite_phase_capture`
- L175: theorem `phaseLimit_feasible`
- L189: theorem `phaseLimit_no_cross`
- L222: theorem `phase_cannot_add_missing`
- L245: def `firstChoice`
- L248: def `fullChoice`
- L251: theorem `firstChoice_feasible`
- L257: theorem `fullChoice_feasible`
- L265: theorem `firstChoice_only_higher`
- L276: theorem `fullChoice_first_iff`
- L290: theorem `no_first_stage_strict_improver`
- L325: theorem `no_second_stage_strict_improver`
- L362: theorem `coupled_two_stage_full_feasible_lex_maximal`

## lalala/physical-bridges/PhysicalBridges/IRDeferredEffects.lean

- SHA-256: `3dee6c9bff94cb9233c176cc7f92d4c768d8dfe022136e398677ecb6000b3c47` · lines: 91 · matched declarations: 9
- L16: structure `Deferred`
- L21: def `hold`
- L26: def `deliver`
- L34: theorem `held_gate_can_still_deliver_old_physical_effect`
- L44: def `cancelPending`
- L47: theorem `cleared_pending_has_no_delivery`
- L52: theorem `quiescent_hold_has_no_delivery`
- L61: theorem `certified_hold_does_not_clear_existing_queue`
- L80: theorem `no_landing_of_empty_backlog`

## lalala/physical-bridges/PhysicalBridges/IRDistributedEpoch.lean

- SHA-256: `d5be1ebdcdd6f02b5deab53cf3255b5292661931657006ddfe3086fa4387b355` · lines: 116 · matched declarations: 8
- L12: abbrev `DeviceRun`
- L16: def `beforeTotal`
- L19: def `afterTotal`
- L23: def `AllProtected`
- L29: theorem `protected_fleet_no_old_effects`
- L56: theorem `committed_fleet_hold_rejects_old_effects`
- L88: theorem `one_unfenced_device_can_land`
- L104: theorem `empty_fleet_is_vacuously_safe`

## lalala/physical-bridges/PhysicalBridges/IRDurableEpoch.lean

- SHA-256: `a2785eceb270162cf9195008658a353cf16de6dd4c3dbc09eff72fce23bf8a4e` · lines: 144 · matched declarations: 14
- L14: structure `Persisted`
- L20: def `commitHold`
- L26: def `restart`
- L29: def `deliver`
- L32: inductive `Cmd`
- L37: def `step`
- L42: def `run`
- L47: def `Protected`
- L52: theorem `committed_hold_is_protected`
- L67: theorem `protected_step`
- L98: theorem `protected_under_any_finite_restarts`
- L118: theorem `committed_hold_prevents_old_effects_despite_restarts`
- L128: def `volatileOnlyHold`
- L131: theorem `volatile_only_hold_fails_after_restart`

## lalala/physical-bridges/PhysicalBridges/IREndToEnd.lean

- SHA-256: `58744c9a4da4c55cb475ff6bd2f17c112c08b074c46093517e8441bf6785a486` · lines: 216 · matched declarations: 4
- L25: def `Kernel`
- L32: theorem `policy_run_matches_source_trace`
- L52: theorem `physically_guarded_observable_action`
- L85: theorem `conditional_end_to_end_certificate`

## lalala/physical-bridges/PhysicalBridges/IREnergyReplenishment.lean

- SHA-256: `b2c744f81604ce905cd23cde2cdb1aa2129ffa67519af27b42426468ff87a925` · lines: 172 · matched declarations: 11
- L30: def `drainingSafe`
- L32: def `drainingStep`
- L38: theorem `draining_viable_iff`
- L68: theorem `finite_bank_cannot_support_all_horizons`
- L79: def `suppliedStep`
- L84: def `reserveSafe`
- L90: theorem `paid_reserve_step_invariant`
- L106: theorem `uniform_paid_supply_derives_all_horizons`
- L127: theorem `uniform_paid_supply_derives_infinite_safe_policy`
- L145: def `intermittentSupply`
- L148: theorem `intermittent_supply_fails_one_step`

## lalala/physical-bridges/PhysicalBridges/IREventTimeBudget.lean

- SHA-256: `ea224b3e7d0f5e06f65066f82656ac2569239d7ac185248e2249e2d20c727c40` · lines: 97 · matched declarations: 5
- L16: theorem `strict_clock_progress_bounds_event_index`
- L29: theorem `horizon_bounds_trace_length`
- L40: theorem `finite_list_charge_bound`
- L64: theorem `nonzeno_timed_metered_guard`
- L86: theorem `stalled_clock_allows_unbounded_events`

## lalala/physical-bridges/PhysicalBridges/IRFinalApplyFence.lean

- SHA-256: `6f181e566965d910f406782b50890142be510594a99362f88b658339d6a9781b` · lines: 146 · matched declarations: 11
- L13: structure `Machine`
- L18: def `hold`
- L24: def `deliver`
- L32: def `deliverMany`
- L36: def `OldOnly`
- L41: theorem `rejected_old_delivery`
- L68: theorem `old_deliveries_cannot_land`
- L95: theorem `hold_refuses_all_preexisting_effects`
- L108: theorem `source_hold_and_apply_time_refusal`
- L125: def `unsafeDeliver`
- L130: theorem `admission_only_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRFiniteProfileObstruction.lean

- SHA-256: `fc2e1541d739950c130980209ef86270888ebaf9905d6faafab9edf2414e067a` · lines: 95 · matched declarations: 6
- L12: def `aboveEvery`
- L16: theorem `aboveEvery_gt_mem`
- L37: theorem `faithful_chain_rep_is_exact`
- L53: theorem `no_finite_faithful_chain_profiles`
- L71: theorem `impossible_finite_profile_audit_for_original_chain`
- L85: theorem `unbounded_chain_lacks_global_maximum`

## lalala/physical-bridges/PhysicalBridges/IRFiniteRefutationCriterion.lean

- SHA-256: `1d6549b0692df28af7557cc89a715193ad27624bf9a6fdee694408647c3d66b6` · lines: 182 · matched declarations: 11
- L21: def `Contains`
- L27: def `FiniteRefutations`
- L35: def `CanonicalForbidden`
- L42: theorem `finite_refutations_give_exact_representation`
- L61: theorem `any_exact_finite_pattern_model_is_finitely_refutable`
- L78: theorem `finite_refutations_iff_exact_finite_patterns`
- L94: theorem `finite_refutations_force_downward_feasibility`
- L111: theorem `source_two_stage_maximal_from_physical_finite_refutations`
- L136: theorem `resource_feasibility_has_finite_refutations`
- L156: def `MustRetainOriginal`
- L159: theorem `mandatory_positive_retention_not_finitely_refutable`

## lalala/physical-bridges/PhysicalBridges/IRFiniteWitness.lean

- SHA-256: `bfe0e93cc923cb26645418ac5c5b4c34c1a206aa19b94aea5b2ad2842252809a` · lines: 118 · matched declarations: 10
- L11: inductive `Place`
- L17: def `safe`
- L23: def `step`
- L30: theorem `fragile_not_viable`
- L40: theorem `fragile_safe_not_viable`
- L46: theorem `kernel_nonempty`
- L55: theorem `failed_not_viable`
- L63: theorem `certified_stable_at_one`
- L89: theorem `computed_kernel_greatest`
- L105: theorem `computed_kernel_policy_exists`

## lalala/physical-bridges/PhysicalBridges/IRFixedPolicyEndToEnd.lean

- SHA-256: `9a27da0753beee2024a2c71632fc6625f4d866af8068674f4759ec5397fc2e7a` · lines: 154 · matched declarations: 1
- L25: theorem `fixed_policy_end_to_end_certificate`

## lalala/physical-bridges/PhysicalBridges/IRFullFeasibleImplementation.lean

- SHA-256: `a054482e539783d210c892661a29cfe90316670853dc2362575401c78aa4117e` · lines: 136 · matched declarations: 4
- L13: theorem `requires`
- L29: def `ProfileActionAudit`
- L44: theorem `original_maximal_implementation_iff_profile_action_audit`
- L86: theorem `audited_policy_realises_original_maximal_executions`

## lalala/physical-bridges/PhysicalBridges/IRHistoryProvenance.lean

- SHA-256: `aa570e0c7e5fe6ae0c2440498c2f6f6b2473df169bcf062278bfd0e90d732f34` · lines: 115 · matched declarations: 11
- L14: structure `PhysicalHistory`
- L19: structure `RecordedHistory`
- L23: def `physicalStep`
- L27: def `recordedStep`
- L33: def `Faithful`
- L39: theorem `one_step_faithful`
- L50: theorem `finite_history_provenance`
- L64: theorem `physical_origin_never_rewritten`
- L77: theorem `recorded_origin_never_rewritten`
- L91: theorem `faithful_records_cannot_merge_different_origins`
- L104: theorem `forgotten_origin_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRImplementableProfileSelection.lean

- SHA-256: `049b150973a2cce67bb71a3dc4efa5445378027651812312eaf2347068ecddad` · lines: 378 · matched declarations: 39
- L22: theorem `comparison_iff_of_same_retentions`
- L50: theorem `representative_maximal_lifts`
- L69: theorem `implementable_global_maximal_iff_finite_audit`
- L97: def `passesAudit`
- L103: theorem `passesAudit_iff`
- L114: def `findImplementableMax`
- L119: theorem `search_sound`
- L131: theorem `search_none_iff_no_audited_candidate`
- L152: theorem `found_is_implementable_global_maximal`
- L170: theorem `search_none_iff_no_implementable_global_maximal`
- L187: theorem `search_success_iff_implementable_global_maximal`
- L212: theorem `equal_head_iff`
- L227: def `life`
- L228: def `freedom`
- L229: def `newLife`
- L230: def `newFreedom`
- L231: def `keys`
- L232: def `Implements`
- L234: theorem `no_strict_improvement`
- L254: theorem `arbitrary_maximal_tie_misses_implementation`
- L260: theorem `search_recovers_implementable_tie`
- L268: def `life`
- L269: def `freedom`
- L270: def `newLife`
- L271: def `newFreedom`
- L272: def `keys`
- L273: def `full`
- L274: def `Implements`
- L276: theorem `false_is_strictly_improvable`
- L284: theorem `true_not_improvable`
- L310: theorem `search_rejects_dominated_implementation`
- L314: theorem `implementation_exists_but_no_global_maximal_implementation`
- L327: def `key`
- L328: def `keys`
- L329: def `full`
- L330: def `Implements`
- L332: theorem `same_profile`
- L338: theorem `no_strict_improvement`
- L345: theorem `faithful_cover_can_miss_implementable_maximum`

## lalala/physical-bridges/PhysicalBridges/IRInFlightQuiescence.lean

- SHA-256: `0b699dc936d55a40507fa357d4dc807a9f8426b5464ca75d34fdced8fe2cb0f9` · lines: 146 · matched declarations: 15
- L12: structure `Pipeline`
- L19: def `close`
- L22: def `send`
- L25: def `arrive`
- L31: def `deliver`
- L37: inductive `Cmd`
- L43: def `step`
- L49: def `run`
- L54: def `Quiescent`
- L59: theorem `quiescent_step`
- L81: theorem `barrier_holds_under_any_finite_interleaving`
- L99: theorem `close_fully_drained_is_quiescent`
- L107: theorem `source_certified_finality_with_inflight_barrier`
- L125: theorem `in_flight_defeats_queue_only_ack`
- L134: theorem `open_admission_defeats_empty_backlogs`

## lalala/physical-bridges/PhysicalBridges/IRInfiniteFinitaryMaximality.lean

- SHA-256: `48e61c7d13a2930e6a8cbc78d97d4dc337eea6c6c2e5bec1f2944e22ad5befaf` · lines: 432 · matched declarations: 29
- L22: def `Feasible`
- L28: theorem `feasible_downward`
- L38: def `familyUnion`
- L41: def `IsChain`
- L47: theorem `finite_chain_capture`
- L85: theorem `chain_union_feasible`
- L100: theorem `derived_chain_upper_bound`
- L116: def `greedyStep`
- L124: theorem `greedyStep_preserves_feasible`
- L133: theorem `greedyStep_extends`
- L142: theorem `greedyStep_adds_if_feasible`
- L151: def `stage`
- L156: theorem `stage_increasing`
- L162: theorem `stage_monotone`
- L182: theorem `stage_feasible`
- L198: def `limit`
- L203: theorem `finite_stage_capture`
- L228: theorem `limit_feasible`
- L242: theorem `cannot_feasibly_add_missing_particular`
- L269: theorem `infinite_full_feasible_aligned_exists`
- L295: theorem `infinite_one_stage_lex_aligned_exists`
- L315: theorem `all_prefixes_feasible_forces_full_retention`
- L327: theorem `original_chain_not_finitary_closed`
- L338: def `incompatiblePair`
- L341: theorem `pair_empty_feasible`
- L348: theorem `pair_full_retention_infeasible`
- L356: theorem `pair_all_unconflicted_retained`
- L384: theorem `pair_cannot_keep_both`
- L398: theorem `nontrivial_infinite_full_feasible_instance`

## lalala/physical-bridges/PhysicalBridges/IRInfiniteHistoryCompactness.lean

- SHA-256: `eb5be9415d913f35f7b4a404bb71fb92500682bc223f517dfa5449deace532fa` · lines: 231 · matched declarations: 13
- L30: def `ForeverViable`
- L34: theorem `viable_weaken`
- L55: theorem `forever_viable_has_common_action`
- L106: def `compactPolicy`
- L113: theorem `compact_policy_keeps_forever_viable`
- L124: def `stateAt`
- L137: theorem `derived_infinite_robust_safe_history`
- L164: def `countdownSafe`
- L168: def `countdownStep`
- L175: theorem `countdown_finite_budget_viable`
- L187: theorem `countdown_any_finite_horizon_viable`
- L197: theorem `countdown_budget_exhausts`
- L211: theorem `infinite_action_branching_blocks_common_policy`

## lalala/physical-bridges/PhysicalBridges/IRInstrument.lean

- SHA-256: `518909be02857b3b5ff2ed976f359c4f2ca2cef053c304d721e2692e80a8f666` · lines: 137 · matched declarations: 10
- L12: structure `Instrument`
- L16: def `execute`
- L26: theorem `execute_target`
- L36: def `Coupled`
- L40: theorem `execute_coupled`
- L55: def `run`
- L58: theorem `run_target`
- L73: theorem `run_coupled`
- L86: theorem `certified_hold_prevents_modeled_effects`
- L124: theorem `bypass_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRInterSampleEnvelope.lean

- SHA-256: `1f9fc55fabdb4645f9316448ae9872791327df7c6e77ed045e3decf26411124f` · lines: 77 · matched declarations: 6
- L15: def `WithinSampleRate`
- L23: def `EverySampleGuarded`
- L30: theorem `every_unsampled_instant_safe`
- L52: def `hiddenPulse`
- L54: theorem `every_second_sample_safe_but_interior_unsafe`
- L68: theorem `hidden_pulse_breaks_zero_rate`

## lalala/physical-bridges/PhysicalBridges/IRJsonTraceChecker.lean

- SHA-256: `bfb1c42ef6b957e82f7449455d6776deea13ec16fdae2f14faba6ac1e7adb7b8` · lines: 175 · matched declarations: 15
- L23: structure `JsonTrace`
- L33: def `objNat`
- L37: def `objInt`
- L41: def `objStr`
- L45: def `decodeRecord`
- L59: def `decodeConfig`
- L67: def `decodeTraceJson`
- L101: def `verifyJsonText`
- L111: theorem `verifyJsonText_sound`
- L128: theorem `verifyJsonText_recorded_reserve`
- L146: def `goodJson`
- L150: def `missing_field_json`
- L155: def `mistyped_timestamp_json`
- L160: def `unsupported_unit_json`
- L165: def `invalid_step_json`

## lalala/physical-bridges/PhysicalBridges/IRKernelConstruction.lean

- SHA-256: `c6c3fb25ef1548f084e30c1750a661962b380229363dd7c1014be5b90706760f` · lines: 123 · matched declarations: 11
- L15: def `Prune`
- L18: def `Inside`
- L20: theorem `prune_inside`
- L24: theorem `prune_monotone`
- L32: def `Approx`
- L36: theorem `approx_next_inside`
- L41: theorem `approx_inside_initial`
- L51: theorem `invariant_survives_all_rounds`
- L66: theorem `stabilised_approx_is_greatest_invariant`
- L85: theorem `stable_kernel_has_policy`
- L103: theorem `stable_kernel_safe_at_every_finite_trace`

## lalala/physical-bridges/PhysicalBridges/IRMandatoryBaselineMaximality.lean

- SHA-256: `7c41b70f4b0d4c126beb2d054f66f5807f3d5937a01be40e05ecf0dca30fb5f5` · lines: 284 · matched declarations: 14
- L22: def `RequiredFeasible`
- L28: def `firstProtected`
- L32: def `finalProtected`
- L36: theorem `first_protected_feasible`
- L43: theorem `final_protected_feasible`
- L52: theorem `final_protected_contains_required`
- L61: theorem `first_protected_base_or_higher`
- L72: theorem `final_first_priority_iff`
- L86: theorem `no_required_first_improver`
- L131: theorem `no_required_second_improver`
- L173: theorem `required_baseline_full_feasible_original_lex_maximal`
- L209: def `RequiredResourceFeasible`
- L216: theorem `resource_capacity_plus_mandatory_baseline_maximal`
- L248: theorem `required_duty_is_genuinely_positive`

## lalala/physical-bridges/PhysicalBridges/IRMaximalProfileSelection.lean

- SHA-256: `e601c03bcc0f91ba95e7a278758b75217b92f6e0f2bbfd8f56738ec850628324` · lines: 320 · matched declarations: 27
- L22: def `SameRetentions`
- L27: def `selectMax`
- L36: theorem `selectMax_certificate`
- L78: theorem `selected_is_globally_aligned`
- L103: theorem `exists_global_maximal_of_finite_faithful_cover`
- L130: theorem `representatives_from_inhabited_fibres`
- L148: theorem `exists_global_maximal_of_inhabited_code_fibres`
- L187: theorem `profiles_separate`
- L193: def `listMaximum`
- L197: theorem `member_le_listMaximum`
- L213: theorem `no_finite_faithful_cover`
- L225: theorem `no_finite_code_audit`
- L242: abbrev `Outcome`
- L243: def `full`
- L244: def `life`
- L245: def `freedom`
- L250: def `newLife`
- L251: def `newFreedom`
- L252: def `keys`
- L253: def `code`
- L254: def `profiles`
- L256: theorem `complete_code_image`
- L262: theorem `inhabited_fibres`
- L267: theorem `constant_retention_fibres`
- L281: theorem `maximal_outcome_is_constructed`
- L289: theorem `full_outcomes_for_every_metadata`
- L294: theorem `no_outcome_grants_every_freedom`

## lalala/physical-bridges/PhysicalBridges/IRMicrostepInvariant.lean

- SHA-256: `070d4a7fefddaac222ab124644f62f7d3b9060eff6951aaeb370cf97b52115c7` · lines: 107 · matched declarations: 5
- L9: def `GuardedMicrotrace`
- L21: theorem `all_recorded_microsteps_safe`
- L47: theorem `endpoints_safe_interior_unsafe`
- L60: theorem `certified_hold_and_microstep_safety`
- L91: theorem `omitted_microstep_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRObservablePermit.lean

- SHA-256: `98376691b9052d7ca1b013de0faa088309cc9fcd5f62f2bc9c16339108627de0` · lines: 67 · matched declarations: 8
- L15: def `Robust`
- L20: def `SoundPermit`
- L26: theorem `sound_iff_below_robust`
- L38: theorem `robust_controller_sound`
- L46: def `coarseObserve`
- L47: def `toySafe`
- L48: def `toyNext`
- L51: theorem `coarse_observation_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRObservationRealisation.lean

- SHA-256: `a7ffb36fcc498c12f0b9cb6ccd7e679e4ef113395ceca15e5a7d498932f9f507` · lines: 636 · matched declarations: 71
- L22: class `of`
- L37: def `SameRetention`
- L41: theorem `sameRetention_refl`
- L44: theorem `sameRetention_symm`
- L48: theorem `sameRetention_trans`
- L55: theorem `sameRetention_lex_iff`
- L82: theorem `aligned_of_same_retention`
- L98: def `ActionRealises`
- L109: def `FibreAction`
- L119: def `RealisesSelected`
- L130: theorem `realisesSelected_target_iff`
- L153: theorem `exists_realising_policy_same_target_iff`
- L170: theorem `realises_iff_fibre_actions`
- L188: theorem `exists_policy_iff_common_fibre_actions`
- L209: theorem `exists_realising_policy_of_fibres`
- L224: def `policyOfSelectors`
- L233: theorem `policyOfSelectors_realises`
- L249: theorem `realises_uniform_keeper`
- L265: theorem `realises_every_nonempty_trace`
- L293: theorem `realised_trace_is_originally_globally_maximal`
- L310: theorem `incompatible_fibre_blocks_realisation`
- L329: theorem `common_fibre_actions_of_statewise_and_transport`
- L356: structure `State`
- L360: def `observe`
- L361: def `safe`
- L362: def `allowed`
- L363: def `next`
- L365: def `outcome`
- L366: def `full`
- L367: def `service`
- L371: theorem `each_state_can_deliver`
- L384: theorem `every_policy_is_safe`
- L389: theorem `selected_is_originally_maximal`
- L401: theorem `no_observation_policy_delivers`
- L419: theorem `maximality_and_statewise_service_do_not_give_implementation`
- L438: def `observe`
- L439: def `safe`
- L440: def `allowed`
- L441: def `next`
- L442: def `sourceOutcome`
- L443: def `full`
- L444: def `key`
- L445: def `policy`
- L446: def `fakeRealises`
- L448: theorem `selected_is_originally_maximal`
- L459: theorem `old_interface_accepts_fake_realisation`
- L477: theorem `inhabited_safe_source_and_uniform_policy`
- L487: theorem `completed_event_has_original_retention_mismatch`
- L497: theorem `new_source_contract_rejects_fake_realisation`
- L508: theorem `arbitrary_realises_does_not_certify_source_delivery`
- L527: def `retained`
- L528: def `full`
- L530: theorem `every_freedom_individually_deliverable`
- L535: theorem `joint_delivery_impossible`
- L542: theorem `each_outcome_is_originally_maximal`
- L559: structure `State`
- L564: def `observe`
- L565: def `safe`
- L566: def `allowed`
- L567: def `next`
- L569: def `outcome`
- L570: def `full`
- L575: def `existingLife`
- L576: def `existingFreedom`
- L577: def `newLife`
- L578: def `newFreedom`
- L579: def `keys`
- L585: theorem `fixed_service_policy_realises`
- L600: theorem `source_state_not_determined_by_observation`
- L607: theorem `immutable_origin_preserved`
- L612: theorem `full_outcomes_all_origins`

## lalala/physical-bridges/PhysicalBridges/IRObservedClockedStalls.lean

- SHA-256: `ad41e9fc89502ab167a2500f0e1a77d119d3c7a4a25bbf0c0b24e1c97d28ee87` · lines: 91 · matched declarations: 1
- L18: theorem `actual_state_safe_and_served_with_bounded_stalls`

## lalala/physical-bridges/PhysicalBridges/IRObservedViability.lean

- SHA-256: `df57258c3d58c5ae08955f815a64dc9008483dcf46cd6c0366ddd211aa453de7` · lines: 117 · matched declarations: 9
- L16: def `UniformKeeper`
- L22: theorem `observable_policy_preserves_kernel`
- L37: theorem `observable_policy_physically_safe`
- L50: theorem `uniform_policy_exists_of_fiber_selectors`
- L70: def `hiddenSafe`
- L71: def `hiddenObserve`
- L72: def `hiddenNext`
- L77: theorem `separate_statewise_choices`
- L92: theorem `no_observation_uniform_choice`

## lalala/physical-bridges/PhysicalBridges/IRPhysicalAbstraction.lean

- SHA-256: `13ec507e179e58c0706d00c7e0d3e1833682d562c00a99359aa9032f6b1297a3` · lines: 112 · matched declarations: 7
- L11: def `physicalStep`
- L14: def `physicalRun`
- L17: theorem `physical_run_sum`
- L33: theorem `residual_sum_bound`
- L51: theorem `physical_guard_with_residual`
- L68: theorem `time_bounded_physical_guard`
- L96: theorem `empty_classification_counterexample`

## lalala/physical-bridges/PhysicalBridges/IRPhysicalGuard.lean

- SHA-256: `8477d78f13013e12fe89a1239fa5ef8bf3bcf0c4254a8e08bf07996ae3fa3714` · lines: 40 · matched declarations: 3
- L11: theorem `post_effect_guard_sound`
- L21: theorem `omitted_jump_counterexample`
- L30: theorem `sequential_post_effect_safety`

## lalala/physical-bridges/PhysicalBridges/IRProfileAudit.lean

- SHA-256: `e4aaaaa9e7d871dd02e8a81b4a50187a58a3aba611bf9deb80b336881ec794a7` · lines: 344 · matched declarations: 29
- L20: def `Obstructs`
- L29: theorem `obstruction_blocks_improvement`
- L56: theorem `no_improvement_has_obstruction`
- L84: theorem `obstruction_iff_not_better`
- L95: theorem `improvement_transfers_to_faithful_profile`
- L130: theorem `audited_no_excluded_improver`
- L156: theorem `alleged_improver_exposes_bad_audit`
- L187: theorem `audited_selected_global_maximal`
- L210: abbrev `Outcome`
- L211: def `key`
- L212: def `chosen`
- L213: def `full`
- L214: def `menu`
- L215: def `code`
- L216: def `representative`
- L218: theorem `full_coverage`
- L223: theorem `faithful_profiles`
- L232: theorem `certified_obstructions`
- L246: theorem `local_choice`
- L260: theorem `globally_maximal_without_cofinality`
- L269: theorem `full_options_all_n`
- L272: theorem `omitted_incomparable_profile`
- L284: theorem `omitted_better_candidate`
- L295: def `badCode`
- L296: def `badRepresentative`
- L298: theorem `bad_abstraction_covers`
- L303: theorem `bad_abstraction_passes_obstruction`
- L314: theorem `bad_abstraction_is_not_faithful`
- L326: theorem `incomplete_profile_list_is_not_coverage`

## lalala/physical-bridges/PhysicalBridges/IRQuiescenceAck.lean

- SHA-256: `9843847ba0f67a478fb47c3f728248140e4845438b723c02e44da172b954e12d` · lines: 96 · matched declarations: 6
- L13: def `ack`
- L18: theorem `ack_sound`
- L25: def `deliverMany`
- L32: theorem `no_landing_after_fresh_ack`
- L61: theorem `certified_quiescent_hold`
- L79: theorem `stale_ack_does_not_protect`

## lalala/physical-bridges/PhysicalBridges/IRRankTermination.lean

- SHA-256: `12cb782d95562fa79e1aa1dc800c824579a4253875fd05819835a22a22fc190c` · lines: 161 · matched declarations: 9
- L17: def `Stable`
- L21: def `iterate`
- L26: theorem `iterate_shift`
- L41: theorem `decreasing_rank_forces_stabilisation`
- L74: theorem `zero_rank_must_be_stable`
- L87: theorem `iterate_state_approx`
- L102: theorem `ranked_state_kernel_stabilises`
- L120: theorem `iterate_belief_approx`
- L136: theorem `ranked_belief_kernel_stabilises`

## lalala/physical-bridges/PhysicalBridges/IRResidualEscrow.lean

- SHA-256: `6ef23bd7899149f504d163af5be6d9ebb4f9c8e3557a946e18178659627b4e42` · lines: 82 · matched declarations: 4
- L13: theorem `metered_residual_bounded_by_escrow`
- L25: theorem `escrow_residual_physical_guard`
- L46: theorem `timed_escrow_physical_guard`
- L69: theorem `conserved_bookkeeping_does_not_bound_unmetered_effect`

## lalala/physical-bridges/PhysicalBridges/IRResourceDerivedClosure.lean

- SHA-256: `82451d701cde59f0eecc3c0ae407c2b3919186cfb3a75ed5fe1373530cab0e67` · lines: 211 · matched declarations: 17
- L20: def `charge`
- L28: def `ResourceSafe`
- L36: def `ConflictSafe`
- L42: def `CapacityFeasible`
- L50: def `DerivedForbidden`
- L58: theorem `resource_feasible_iff_finite_forbidden`
- L86: theorem `empty_capacity_feasible`
- L110: theorem `resource_capacity_implies_global_lex_maximality`
- L137: def `sharedCost`
- L139: def `unitCapacity`
- L140: def `noHard`
- L142: theorem `shared_capacity_excludes_joint_pair`
- L154: theorem `shared_capacity_global_original_lex_maximal`
- L167: def `EventuallyAbsent`
- L170: theorem `finite_prefix_eventually_absent`
- L177: theorem `full_infinite_not_eventually_absent`
- L185: theorem `eventual_absence_not_exactly_finitary`

## lalala/physical-bridges/PhysicalBridges/IRSafeMaximality.lean

- SHA-256: `87fc439cfbdf756ee874a6c1c58808c95519fe077d5a07a2ee808cc12fbaa9ed` · lines: 80 · matched declarations: 5
- L17: def `Cofinal`
- L24: theorem `safe_maximal_exists`
- L33: theorem `cofinal_safe_maximal_is_globally_maximal`
- L51: theorem `cofinal_global_maximal_exists`
- L63: theorem `globally_maximal_first_stage_no_needless`

## lalala/physical-bridges/PhysicalBridges/IRSelectedEndToEnd.lean

- SHA-256: `5bb2868c09ed70de533be935909927e10083702342cbd516566f3c302a5f8b85` · lines: 155 · matched declarations: 1
- L23: theorem `selected_end_to_end_certificate`

## lalala/physical-bridges/PhysicalBridges/IRSelectedMaximality.lean

- SHA-256: `8a3b88c7d639418107c062fdf22545965690dea7d60a6d00c67fb0a71294625b` · lines: 141 · matched declarations: 10
- L15: def `NoExcludedImprover`
- L24: theorem `selected_safety_maximal_lifts_globally`
- L40: theorem `cofinal_implies_selected_no_outside_improver`
- L54: theorem `selected_realisation_suffices`
- L69: def `incomparable`
- L71: theorem `incomparable_not_better`
- L85: theorem `cofinality_is_not_necessary`
- L108: def `dominates`
- L110: theorem `excluded_strict_improvement`
- L122: theorem `local_maximum_need_not_be_global`

## lalala/physical-bridges/PhysicalBridges/IRServiceProgress.lean

- SHA-256: `894c1810813e02238080bc6eb1c2827d876e4d3b61d23e234ad2f78e6f64ffc1` · lines: 98 · matched declarations: 5
- L16: theorem `ranked_trace_reaches_goal`
- L74: def `frozenStep`
- L76: theorem `infinite_hold_is_safe_but_never_serves`
- L88: def `unfairNext`
- L91: theorem `favourable_transition_not_sufficient`

## lalala/physical-bridges/PhysicalBridges/IRStaleReadingAge.lean

- SHA-256: `430f4b01ade44c4cd82d136a9e35f8d76bea69c28d79b37925bb9b6de9ae4dcb` · lines: 86 · matched declarations: 7
- L12: def `RecentReading`
- L19: def `SinceLastSampleRise`
- L33: theorem `bounded_reading_age_prevents_unsampled_excursion`
- L54: def `steadilyRising`
- L56: theorem `authenticated_but_stale_reading_can_be_unsafe`
- L67: theorem `fixed_last_sample_breaks_freshness`
- L77: theorem `omitted_age_check_is_unsound`

## lalala/physical-bridges/PhysicalBridges/IRStoredEnergyCommonMode.lean

- SHA-256: `c24b8bb393124e39bb72096fb04ec2406601e724cdb96cbacf8b8802397daa9e` · lines: 213 · matched declarations: 16
- L37: def `twiceInductiveEnergy`
- L43: def `totalStoredTwice`
- L48: structure `DischargeLedger`
- L63: def `ConservativeAccounting`
- L68: def `ClampCapacity`
- L75: theorem `zero_escape_zero_remnant_requires_full_capacity`
- L92: theorem `undersized_clamp_forces_escape_or_remaining`
- L114: theorem `synthetic_magnetic_store_exceeds_capacity`
- L121: theorem `energy_capacity_does_not_bound_peak_voltage`
- L143: theorem `two_agreeing_untrusted_sensors_can_both_be_wrong`
- L156: theorem `one_physically_sound_channel_with_margin`
- L172: def `dualDomainPermit`
- L176: theorem `failed_analog_domain_denies_modeled_command`
- L181: theorem `failed_physical_fence_denies_modeled_command`
- L189: theorem `all_enables_pass_but_independent_bypass_lands`
- L197: theorem `intersample_endpoint_acceptance_does_not_ensure_safety`

## lalala/physical-bridges/PhysicalBridges/IRStutterObstruction.lean

- SHA-256: `2a25a3f21cc2d831d70630e7ef1e743f6c9afdc558066a0fb596440ecf8ad719` · lines: 121 · matched declarations: 13
- L17: theorem `stuttering_non_goal_refutes_any_progress_rank`
- L33: theorem `unchanged_unserved_belief_blocks_rank`
- L56: def `adversarialNext`
- L59: def `observe`
- L60: def `policy`
- L61: def `served`
- L62: def `K`
- L64: def `initial`
- L67: theorem `initially_unserved`
- L74: theorem `initial_is_good`
- L77: theorem `helpful_and_stalling_disturbances`
- L84: theorem `adverse_event_keeps_belief_unchanged`
- L100: theorem `beneficial_option_does_not_force_robust_belief_progress`

## lalala/physical-bridges/PhysicalBridges/IRTwoSidedGuard.lean

- SHA-256: `955865c739648396a5828cb9c35b45c435076fbf8e12989b76854839df8c14e8` · lines: 74 · matched declarations: 4
- L15: theorem `guarded_interval_sound`
- L28: theorem `aggregate_two_sided_guard_sound`
- L47: theorem `upper_only_permits_terminal_depletion`
- L61: theorem `impossible_margin_has_no_accepted_observation`

## lalala/physical-bridges/PhysicalBridges/IRTwoStageInfiniteLex.lean

- SHA-256: `c6fc8625258d23f9f371313deaf10fc8e1c462a85f7eb457cb920b81d67ed774` · lines: 204 · matched declarations: 20
- L25: abbrev `Outcome`
- L27: def `firstKey`
- L28: def `secondKey`
- L30: def `fullIndependent`
- L33: def `independentChoice`
- L39: theorem `independent_two_stage_global_lex_maximum`
- L65: abbrev `ManyOutcome`
- L67: def `indexedKey`
- L70: def `allIndependentFeasible`
- L74: def `allIndependentChoice`
- L78: theorem `independent_any_finite_stage_lex_maximum`
- L116: def `coupledFull`
- L122: def `coupledChoice`
- L125: theorem `coupled_choice_feasible`
- L135: theorem `coupled_two_stage_lex_maximum`
- L165: def `noForbidden`
- L167: theorem `empty_feasible_without_prohibitions`
- L172: theorem `unconstrained_limit_includes_every_particular`
- L182: theorem `independent_maxima_not_jointly_feasible`
- L191: theorem `coupled_choice_not_joint_independent_maximum`

## lalala/physical-bridges/PhysicalBridges/IRTypedTraceChecker.lean

- SHA-256: `e9beb4eb94d2ada0c12e72e3127e86c0d3664ba441a5b1bc7f0925cdbee8313f` · lines: 315 · matched declarations: 31
- L28: structure `TelemetryRecord`
- L36: structure `CheckConfig`
- L44: def `InitialValid`
- L53: def `StepValid`
- L78: def `checkStep`
- L82: def `CheckSegments`
- L88: def `checkSegments`
- L94: def `TraceValid`
- L102: def `verifyTraceData`
- L112: theorem `checkStep_sound`
- L118: theorem `checkSegments_sound`
- L136: theorem `verifyTraceData_sound`
- L155: theorem `valid_segments_every_step_paid`
- L177: theorem `accepted_trace_every_record_above_reserve`
- L194: theorem `accepted_trace_every_step_paid`
- L206: theorem `accepted_trace_every_step_balanced_and_bounded`
- L216: def `testConfig`
- L218: def `testInitial`
- L220: def `testNext`
- L222: def `testThird`
- L225: def `sampleTrace`
- L228: theorem `accepted_example_is_computable`
- L233: def `badInitial`
- L236: theorem `invalid_singleton_rejected`
- L239: theorem `missing_tick_rejected`
- L243: theorem `forged_balance_rejected`
- L247: def `insufficientSupplyRecord`
- L250: theorem `insufficient_step_supply_rejected`
- L254: theorem `too_rapid_logged_descent_rejected`
- L263: theorem `accepted_records_without_physical_refinement_do_not_certify_reality`
- L275: theorem `accepted_trace_physical_reserve_with_error`

## lalala/physical-bridges/PhysicalBridges/IRUniformChannelMargin.lean

- SHA-256: `59d8bdf308c63b55e7a95f482d7f57deafa1aaad2f03d68b8de279b6da0fd66a` · lines: 144 · matched declarations: 5
- L23: theorem `finite_channels_sum_bound`
- L45: theorem `uniform_local_channel_budget`
- L66: theorem `every_agent_post_effect_safe_with_uniform_margin`
- L118: theorem `bounded_degree_without_channel_cap_is_insufficient`
- L127: theorem `per_channel_cap_without_degree_cap_is_insufficient`

## lalala/physical-bridges/PhysicalBridges/IRViability.lean

- SHA-256: `bba870661392dce31091a36e02bb9ffe2a2dd07f5118b9100d6b6fdf7ce5d79c` · lines: 102 · matched declarations: 9
- L15: def `Viable`
- L19: theorem `viable_now_safe`
- L27: theorem `viable_horizon_monotone`
- L42: theorem `robust_invariant_implies_all_horizons`
- L59: def `run`
- L63: theorem `robust_policy_preserves_every_finite_trace`
- L78: def `toySafe`
- L79: def `toyStep`
- L82: theorem `safe_immediate_but_not_viable`

## lalala/physical-bridges/PhysicalBridges/IRWatchdogLatencyEffects.lean

- SHA-256: `c08f46736e66366a211f7b33454ddc1bd048c6417d9a689a7f941e406c2fcad2` · lines: 230 · matched declarations: 17
- L31: structure `Episode`
- L41: def `TimingContract`
- L53: theorem `additive_fault_to_quiescence_bound`
- L63: theorem `window_age_bounded`
- L83: theorem `guarded_reaction_window_remains_below_threshold`
- L112: theorem `guarded_quiescence_endpoint_safe`
- L141: def `actualEffect`
- L144: theorem `disabled_complete_mediation_blocks_modeled_effect`
- L149: theorem `independent_bypass_defeats_disabled_gate`
- L156: theorem `fenced_and_drained_pipeline_stops_modeled_effects`
- L172: def `transient`
- L174: theorem `fast_shutdown_does_not_erase_prior_breach`
- L187: def `absorbingHold`
- L189: def `afterHold`
- L192: def `deliversService`
- L194: theorem `absorbing_no_service_counterexample`
- L210: theorem `valid_logged_trace_can_coexist_with_unmodeled_physical_breach`

## lalala/physical-bridges/PhysicalBridges/IRX3CompulsoryCut.lean

- SHA-256: `3a6d78bd9a6845ec718e4c3f1e5503ff6f1a825f77afcebd2a6d780220083b49` · lines: 165 · matched declarations: 9
- L24: def `areaIndex`
- L29: theorem `side_information_forces_new_traffic`
- L39: theorem `required_traffic_forces_active_edges`
- L51: theorem `compulsory_area_power_bound`
- L70: theorem `x3_decoder_converse_to_compulsory_cut_work`
- L93: theorem `compulsory_active_cut_with_deadline`
- L108: theorem `universal_admitted_protocol_cut_work`
- L135: theorem `large_cut_does_not_force_large_power`
- L149: theorem `complete_side_information_allows_zero_crossing`

## lalala/physical-bridges/PhysicalBridges/IRX3OutwardScreening.lean

- SHA-256: `945e56ca0af89f910270ceaf8556b262b6d95e7ad7298b739b9ef6bf7adcaf01` · lines: 164 · matched declarations: 15
- L21: structure `Packet`
- L29: def `outwardDistance`
- L32: def `outwardAccessible`
- L38: theorem `accessible_outward_packet_is_recent`
- L49: theorem `outward_packet_emitted_after_cutoff`
- L57: theorem `old_outward_packet_escapes`
- L70: inductive `AccessibleSource`
- L75: def `sourceAccessible`
- L80: def `sourceRecent`
- L90: theorem `all_accessible_inputs_recent_if_no_retained_copies`
- L111: theorem `retained_historical_copy_defeats_recency`
- L120: def `stationaryPosition`
- L122: theorem `finite_speed_upper_bound_allows_stationary_information`
- L135: theorem `stationary_packet_violates_unit_speed_screening`
- L145: theorem `all_observed_outward_packets_recent`

## lalala/physical-bridges/PhysicalBridges/IntrinsicSixSourceForcing.lean

- SHA-256: `249b4687c595cace04100dbea60e38bc04c1cd74abb02d90c9798fe7159a49f7` · lines: 141 · matched declarations: 6
- L35: structure `SixRelationalDuties`
- L45: def `SourceSixHold`
- L55: theorem `preserves`
- L57: theorem `source_six_preserved_by_whole_relation`
- L80: structure `SourceSixReflections`
- L112: theorem `source_preservation_forces_six_x3_for_every_owed`

## lalala/physical-bridges/PhysicalBridges/KeystoneDischargeAndCorrespondences.lean

- SHA-256: `c73f84ac1bdd0f79a3d721d147884e920b47a9c79757cac738a2d0c346648654` · lines: 173 · matched declarations: 11
- L39: theorem `intrinsicGuardian_implies_originalX3`
- L53: theorem `keystone_discharged`
- L66: theorem `correspondence_continuity`
- L75: theorem `correspondence_authorization`
- L84: theorem `correspondence_freedom`
- L93: theorem `correspondence_restraint`
- L102: theorem `correspondence_maximality`
- L111: theorem `correspondence_provenance`
- L119: theorem `all_six_correspondences_hold`
- L136: def `UPTDivergence`
- L160: theorem `upt_diverges_from_bare_qm`

## lalala/physical-bridges/PhysicalBridges/Koru.lean

- SHA-256: `91970e5f9dbeb7232bab67aefcbc2b85cf5641b691dd127d68dfa3de4ddac0f4` · lines: 83 · matched declarations: 8
- L25: structure `Web`
- L29: structure `Reindex`
- L36: def `reindexWeb`
- L43: def `koru`
- L47: theorem `koru_irrefl`
- L53: theorem `koru_symm`
- L60: theorem `koru_distinct`
- L66: theorem `koru_reindex_invariant`

## lalala/physical-bridges/PhysicalBridges/KoruClosureStressTest.lean

- SHA-256: `947e8c185b90128d726607a6d3ac39086f708380a8503925255f000f1934538d` · lines: 137 · matched declarations: 12
- L29: inductive `Node`
- L34: def `beforeLink`
- L38: def `afterLink`
- L44: def `ReverseClosed`
- L49: def `RowIndividuated`
- L54: def `TwoStepConnected`
- L57: theorem `both_stages_reverse_closed`
- L65: theorem `both_stages_individuated`
- L85: theorem `both_stages_connected`
- L96: theorem `pair_lost_reciprocally`
- L105: theorem `closure_does_not_force_edge_persistence`
- L121: theorem `no_dangling_edge_does_not_imply_no_local_loss`

## lalala/physical-bridges/PhysicalBridges/KoruSymmetricSeveranceWeights.lean

- SHA-256: `fc0a314304c5e28dfd4724ad124261912abc7f2fe3bcd1ac64807f676a62b4aa` · lines: 103 · matched declarations: 12
- L25: inductive `Node`
- L30: def `weight`
- L41: theorem `reciprocity_at_every_parameter`
- L45: def `outgoing`
- L48: def `incoming`
- L52: theorem `balanced_at_every_parameter`
- L58: theorem `degree_p`
- L62: theorem `positive_degree_to_zero`
- L66: theorem `all_relations_of_p_vanish`
- L70: theorem `remaining_pair_is_still_coupled`
- L75: theorem `no_parameter_has_an_asymmetric_edge`
- L84: theorem `boundary_balance_does_not_force_positive_continuation`

## lalala/physical-bridges/PhysicalBridges/LoadBearingPhysicalJoins.lean

- SHA-256: `8a71607a5fd61b76a085e15025d1f1efa38f62cb227c799408d41689e51d5e71` · lines: 218 · matched declarations: 6
- L37: structure `EventToGenerator`
- L47: structure `GeneratorContinuity`
- L68: theorem `is`
- L70: theorem `certified_source_from_external_events`
- L102: theorem `finite_real_run_joins_event_continuity_guard_and_maximality`
- L197: theorem `source_guardian_without_physical_mediation_is_insufficient`

## lalala/physical-bridges/PhysicalBridges/LocalityChannelCompleteness.lean

- SHA-256: `4a9a88b3ff679ae3e9458dedd4f80e4e994d1c0cab72b6a6ecf95da0342e6ba0` · lines: 128 · matched declarations: 8
- L45: inductive `Path`
- L50: def `Boundary`
- L55: theorem `exit_crosses_boundary`
- L69: def `Unmetered`
- L75: theorem `fence_seals_region`
- L92: theorem `every_exit_is_metered`
- L105: theorem `labelled_channels_seal`
- L116: theorem `unmetered_boundary_edge_is_an_exit`

## lalala/physical-bridges/PhysicalBridges/MeterFailureBlame.lean

- SHA-256: `2c978ee194e2dc4a7b2f8adecc9fc3a8a9cc466bf55d2a007b1bbe7f0f55c933` · lines: 160 · matched declarations: 9
- L49: def `allDown`
- L52: def `stepF`
- L57: def `runF`
- L64: theorem `working_tick_reach`
- L73: theorem `continuation_failure_blames_a_meter_failure`
- L95: theorem `working_tick_consent`
- L102: theorem `unconsented_loss_blames_a_meter_failure`
- L128: theorem `failure_free_prefix_protects`
- L148: theorem `meter_failure_can_harm`

## lalala/physical-bridges/PhysicalBridges/Oct10ParticularContinuationBridge.lean

- SHA-256: `4f3b286fe0c5aa2e864be8461340645084754aa335471be27da7be39d55f823b` · lines: 245 · matched declarations: 23
- L28: structure `Source`
- L38: def `Protected`
- L45: structure `Certified`
- L67: theorem `each_real_source_step_preserves_protection`
- L80: theorem `every_finite_real_execution_retains_protection`
- L95: theorem `original_particular_finite_causal_continuation`
- L123: def `toyOptions`
- L127: theorem `toy_options_really_branch`
- L133: def `openToy`
- L141: theorem `open_toy_is_certified`
- L163: theorem `open_toy_has_actual_change_and_protected_choices`
- L174: structure `ToyPhysical`
- L180: def `living`
- L181: def `stopped`
- L182: def `loggedReadout`
- L184: def `physicallyActive`
- L186: theorem `provenance_can_be_identical_after_activity_stops`
- L192: theorem `no_provenance_only_exact_activity_decoder`
- L204: def `toyTransport`
- L207: theorem `projector_transport_is_a_tautology`
- L213: theorem `exact_transport_can_coexist_with_activity_loss`
- L224: def `siteProxy`
- L234: theorem `original_H2_excludes_naive_B_site_certificate`

## lalala/physical-bridges/PhysicalBridges/Oct10SourceHamiltonianProtection.lean

- SHA-256: `db29db826a37f951c7b74bc74381e295748fc8cb998a67b9d09e5f478dea2184` · lines: 245 · matched declarations: 20
- L41: inductive `Basis`
- L46: def `positiveParity`
- L52: def `h2Pulse`
- L63: def `h1CouplingNeighbour`
- L75: def `bSiteOccupied`
- L79: theorem `h2_pulse_is_involution`
- L83: theorem `source_h2_preserves_parity`
- L87: theorem `source_h1_support_preserves_parity`
- L94: theorem `source_physical_parity_does_not_lock_B_site`
- L103: theorem `source_h2_refutes_B_site_no_bypass`
- L115: def `ClosedUnderSourceCouplings`
- L122: theorem `closed_iff_constant_on_four_source_edges`
- L152: def `sectorIndicator`
- L155: theorem `closed_iff_union_of_entire_parity_sectors`
- L196: theorem `B_site_projector_not_closed_under_source`
- L205: theorem `conserved_sector_does_not_distinguish_B0_C1`
- L214: inductive `H2PulseStep`
- L217: theorem `every_H2_step_preserves_parity`
- L223: theorem `H2_has_a_safe_to_unsafe_local_site_step`
- L235: theorem `no_unconditional_B_site_invariance_under_source`

## lalala/physical-bridges/PhysicalBridges/OriginalKoruSummitJoin.lean

- SHA-256: `f6be8c70c37091dab8c375c619bcda7a542e149c147e2cfdaf234bcbc8eed14f` · lines: 68 · matched declarations: 3
- L22: def `asKoruWeb`
- L28: theorem `koru_iff_genuine_distinction`
- L50: theorem `same_role_koru_noncollapse`

## lalala/physical-bridges/PhysicalBridges/OriginalX3Full.lean

- SHA-256: `1572d95eeebd4bdb0b5deedb1eacf1f3815f71bea0b5efe435783da9ac8a188a` · lines: 71 · matched declarations: 3
- L35: structure `OriginalX3`
- L50: theorem `originalX3_strengthens_proxy`
- L58: theorem `proxy_is_strictly_weaker`

## lalala/physical-bridges/PhysicalBridges/PartialMeterFailures.lean

- SHA-256: `5eb1e387565487dee65958442c6ac52c3e9c5a2c0a9d2fb38a484fdaabea5148` · lines: 185 · matched declarations: 10
- L38: def `outageLocale`
- L42: def `runOutages`
- L51: def `FailedBoundaryBefore`
- L59: theorem `outage_stays_sealed`
- L72: theorem `no_boundary_failure_means_healthy_prefix`
- L86: theorem `outage_free_run_reach`
- L112: theorem `healthy_boundary_protects`
- L133: theorem `ending_blames_failed_boundary`
- L149: theorem `unconsented_loss_blames_failed_boundary`
- L163: theorem `one_boundary_failure_can_end`

## lalala/physical-bridges/PhysicalBridges/ParticularSemanticsAudit.lean

- SHA-256: `08dbaa65729ca6eb596683c39d087135a32db3f88d761a7a97408d9f4f5f6514` · lines: 232 · matched declarations: 16
- L45: structure `ParticularFrame`
- L56: def `FullOriginalX3`
- L63: theorem `full_original_x3_iff_six_components`
- L80: def `ActualStepPreservesFullX3`
- L88: structure `ToyEpisode`
- L102: def `ToyOriginalX3`
- L113: def `fullSixFlag`
- L118: def `good`
- L131: def `missing`
- L142: theorem `good_has_full_original_x3`
- L148: theorem `each_missing_component_defeats_full_x3`
- L181: def `coarseReadout`
- L186: theorem `all_six_failures_invisible_to_coarse_readout`
- L193: theorem `full_six_flag_iff_original_x3`
- L206: theorem `unconsented_episode_same_coarse_source`
- L214: theorem `no_coarse_readout_decoder_for_full_original_x3`

## lalala/physical-bridges/PhysicalBridges/RedundantBoundaryMeters.lean

- SHA-256: `8e2ba89454daefd3ed1018fa7a0e88dd20877fc955b93ecb3b1e20fd53d44a60` · lines: 196 · matched declarations: 10
- L37: def `doubleFailure`
- L42: def `runDual`
- L49: def `NoJointBoundaryFailure`
- L58: theorem `double_failure_is_off`
- L70: theorem `no_effective_boundary_outage`
- L86: theorem `dual_meters_preserve_original_six`
- L106: theorem `ending_requires_two_failed_layers`
- L131: theorem `unconsented_loss_requires_two_failed_layers`
- L157: theorem `one_whole_layer_down_still_protects`
- L173: theorem `simultaneous_double_failure_can_end`

## lalala/physical-bridges/PhysicalBridges/SealedRegionCapstone.lean

- SHA-256: `11e1ce6947f3385057ae275fb35b90e848889cfd6e4d455344a3ec6159327015` · lines: 265 · matched declarations: 25
- L59: structure `Locale`
- L65: def `Sealed`
- L69: def `validFrom`
- L74: def `crossesFrom`
- L79: def `lastFrom`
- L84: theorem `exit_route_metered`
- L106: inductive `LRequest`
- L113: structure `LPolicy`
- L117: def `reachesWorld`
- L122: def `deliver`
- L128: def `applyL`
- L134: def `lIsRetire`
- L138: def `lSpawnOf`
- L142: def `lNewAgents`
- L145: def `tickL`
- L152: def `stepL`
- L155: def `runL`
- L161: theorem `deliver_reach`
- L175: theorem `applyL_reach`
- L185: theorem `tickL_reach`
- L191: theorem `runL_reach`
- L206: theorem `sealed_region_holds_every_optimiser`
- L222: def `killerThrough`
- L227: theorem `boundary_gap_admits_a_killer`
- L247: theorem `sealed_region_is_exact`

## lalala/physical-bridges/PhysicalBridges/SourceIndependentRelationFork.lean

- SHA-256: `02362598ad47f081294a03ec13e785cc03ff897235e7941e9b120f88daaa669e` · lines: 136 · matched declarations: 10
- L42: def `sourceSite`
- L46: def `sameSourceSite`
- L51: def `sourceRegisterZero`
- L56: def `sameSourceRegister`
- L61: theorem `frozen_update_preserves_source_site`
- L72: def `siteAutomorphism`
- L81: theorem `frozen_update_changes_source_register_reading`
- L90: theorem `frozen_update_fails_register_relation`
- L103: theorem `no_full_register_relation_automorphism_with_frozen_update`
- L123: theorem `site_only_relational_properties_survive`

## lalala/physical-bridges/PhysicalBridges/SummitBCRDRelationalVerdict.lean

- SHA-256: `1468da5c295c12d0bf2d19f83b658ac35c3f45c812fd43223d2b0471e7201362` · lines: 82 · matched declarations: 4
- L44: def `Retains`
- L51: theorem `retention_of_determining_invariant_forces_continuation`
- L63: def `BCRDSuppliesThePrinciple`
- L71: theorem `principle_forces_continuation`

## lalala/physical-bridges/PhysicalBridges/SummitBCRDReversibility.lean

- SHA-256: `1ff74d3406a4fb6d2bf3eeb73245577eb9ab03555e9e1e5bacef60239da2e4d8` · lines: 68 · matched declarations: 4
- L35: theorem `permutation_involution`
- L40: theorem `source_generator_reverses_basis_states`
- L52: theorem `source_erases_no_basis_state`
- L59: theorem `self_inverse_step_erases_nothing`

## lalala/physical-bridges/PhysicalBridges/SummitExistenceImpliesGuardian.lean

- SHA-256: `de079c25c3724795fc984e224f35ce040c736cf82c976766c94a605f7e463af1` · lines: 62 · matched declarations: 4
- L25: theorem `inversion_form`
- L36: theorem `we_are_here_therefore_guardian`
- L46: def `DecisiveContradiction`
- L52: theorem `no_first_violation_of_decisive`

## lalala/physical-bridges/PhysicalBridges/SummitFibreDynamicsBridge.lean

- SHA-256: `5c0a9ed4b0657a2a1a6e771b54648aeb872b1630f61cd56ed2eab201c7883ab2` · lines: 219 · matched declarations: 15
- L35: def `ReadoutLift`
- L41: def `StepPreserves`
- L48: theorem `fibre_saturation_exposes_violation`
- L66: theorem `mixed_fibre_alone_does_not_force_violating_step`
- L81: def `sourceTick`
- L84: def `TickStep`
- L88: theorem `tick_satisfies_source_laws`
- L99: theorem `tick_preserves_continuation`
- L108: theorem `tick_has_a_changing_step`
- L119: def `ledgerReadout`
- L123: theorem `ledger_fibre_mixes_continuation`
- L134: theorem `ambiguous_fibre_coexists_with_lawful_continuation`
- L166: theorem `relation_covariance_precludes_identity_merger`
- L183: theorem `all_is_has_nontrivial_injective_relational_motion`
- L197: theorem `source_covariant_transport_preserves_distinction`

## lalala/physical-bridges/PhysicalBridges/SummitFirstViolationObstruction.lean

- SHA-256: `6867202a8aa7695bc34d5df2d327d906bf10978d1bfae404769bebe5c2926553` · lines: 99 · matched declarations: 7
- L29: structure `SourceDynamics`
- L37: def `FirstViolation`
- L41: def `NoFeasibleProtection`
- L46: def `DominatedActual`
- L52: theorem `first_violation_forces_obstruction`
- L67: theorem `no_first_full_x3_violation_from_source_selection`
- L84: theorem `protection_feasible_but_not_enacted_still_violates`

## lalala/physical-bridges/PhysicalBridges/SummitIntrinsicDefinability.lean

- SHA-256: `284028bfba8fa7c598be5c1ef1f7a59a4111f6780a68c0465f208d797bc3fb52` · lines: 156 · matched declarations: 7
- L36: inductive `RelFormula`
- L44: def `evalRel`
- L55: structure `RelationalAutomorphism`
- L64: theorem `map_extended_environment`
- L77: theorem `intrinsic_formula_is_automorphism_invariant`
- L127: theorem `intrinsic_unary_property_has_no_first_loss`
- L141: theorem `no_first_loss_of_intrinsic_relational_duties`

## lalala/physical-bridges/PhysicalBridges/SummitIrreduciblePosit.lean

- SHA-256: `5d134610c18d7870241a3af4d2221fd41d961f885b0a5b3cc2dedaa0f4ffb194` · lines: 89 · matched declarations: 6
- L35: theorem `reversible_preserves_iff_orbit_constant`
- L50: structure `SubPrincipleTransition`
- L60: def `SatisfiesAllSubPrinciples`
- L64: def `X3`
- L71: theorem `guardian_necessity_is_irreducible`
- L80: theorem `guardian_posit_suffices`

## lalala/physical-bridges/PhysicalBridges/SummitReversibilityScope.lean

- SHA-256: `26cf3aeac25a04902235315c67a7a844bdbe6586e6bb4e85d8485fb01194a1b8` · lines: 56 · matched declarations: 4
- L29: structure `Step`
- L33: def `Free`
- L39: theorem `reversibility_does_not_force_freedom`
- L49: theorem `reversibility_gives_identity_persistence`

## lalala/physical-bridges/PhysicalBridges/SummitReversibleOrbitCriterion.lean

- SHA-256: `9eac765d2ff687c88d15ba15612900d9b04f8d115721db8eaea70cb971cd066c` · lines: 121 · matched declarations: 5
- L35: theorem `involution_preserves_iff_orbit_constant`
- L53: def `atM0`
- L58: theorem `frozen_witness_reversible_but_site_label_changes`
- L72: theorem `reversible_source_does_not_preserve_every_stage_property`
- L87: theorem `frozen_basis_step_preserves_iff_orbit_constant`

## lalala/physical-bridges/PhysicalBridges/SummitSourceAutomorphismClose.lean

- SHA-256: `eebcf71ede70e6d7dea9759c4430f3baac96733b5bb7ec8543b985577f7b3d0a` · lines: 64 · matched declarations: 4
- L28: def `sourceRel`
- L32: def `sourceAutomorphism`
- L43: theorem `summit_no_first_x3_loss`
- L54: theorem `source_no_first_loss_of_intrinsic_duties`

## lalala/physical-bridges/PhysicalBridges/SummitSourceAutomorphismCorrection.lean

- SHA-256: `db1472bf8f1c6b3bf86ea3b6001d4bb8f7b8c1a455b901f84dcddf1f13c1cf87` · lines: 85 · matched declarations: 7
- L31: def `sector`
- L34: def `sameSector`
- L38: theorem `permutation_preserves_sameSector`
- L45: def `sectorAutomorphism`
- L54: theorem `no_first_loss_over_independent_relation`
- L65: theorem `source_generator_is_unitary`
- L73: theorem `permutation_does_not_preserve_pointM0`

## lalala/physical-bridges/PhysicalBridges/SummitSourceDynamicsExperiment.lean

- SHA-256: `4aeb9abb5c72012369e48dd7848d3dcc73b3fc4b365bae26efcd1e00756f39a5` · lines: 94 · matched declarations: 10
- L25: structure `PhysState`
- L33: def `ConservesEnergy`
- L34: def `ConservesCharge`
- L35: def `CausalMonotone`
- L36: def `SourceLawful`
- L40: def `PreservesX3`
- L45: theorem `source_laws_do_not_force_x3`
- L55: theorem `no_x3_independent_invariant_forces_x3`
- L69: theorem `only_continuation_law_forces_continuation`
- L80: theorem `current_all_is_does_not_force_x3`

## lalala/physical-bridges/PhysicalBridges/TotalEOriginalX3Bridge.lean

- SHA-256: `bfc8c48b4fc89c48539108168f7d760347d19ec6e4081feacac546d65893a9b6` · lines: 174 · matched declarations: 18
- L32: def `AbsoluteE`
- L37: theorem `no_absolute_E`
- L43: def `ActualX3Violation`
- L51: theorem `total_E_bridge_iff_no_actual_x3_violation`
- L65: theorem `six_original_x3_from_total_E`
- L83: theorem `six_original_x3_iff_total_E_bridge`
- L110: abbrev `CycleState`
- L112: def `cycleFlip`
- L115: def `cycleStep`
- L118: theorem `cycle_is_reversible`
- L127: def `cycleOtherDuty`
- L129: def `cycleAuthorization`
- L132: def `cycleOriginalX3`
- L136: def `cycleOrigin`
- L138: theorem `cycle_origin_violates_original_x3`
- L144: def `cycleEventActual`
- L147: def `cycleAllOwed`
- L154: theorem `cyclic_reversible_world_does_not_force_full_x3`

## lalala/physical-bridges/PhysicalBridges/UPTDenial.lean

- SHA-256: `055bd067b0cba337489cc8e2ed41c3d9671b89923d53fa39a61dc591bcbb1227` · lines: 145 · matched declarations: 7
- L65: inductive `Denial`
- L76: theorem `denial_eater`
- L87: theorem `coherent_denial_is_internal`
- L99: theorem `prediction_no_one_way_coupling`
- L112: theorem `prediction_no_permanent_departure`
- L122: theorem `prediction_no_merging`
- L131: theorem `boundary_is_exact`

## lalala/physical-bridges/PhysicalBridges/UPTLaw.lean

- SHA-256: `e487d5fdb58d811782da7038edb0f02d1c885f917583d74ea45b50537af49379` · lines: 300 · matched declarations: 11
- L88: theorem `dichotomy_of_enacted_steps`
- L103: theorem `ender_branch_empty`
- L113: theorem `guardian_only_along_history`
- L126: theorem `upt_preservation_law`
- L151: theorem `upt_one_way_law`
- L171: theorem `route_b_discharged`
- L184: theorem `upt_capstone`
- L211: theorem `subjective_slice_is_not_the_whole`
- L222: theorem `subjective_ending_does_not_bind_the_whole`
- L243: theorem `all_is_u`
- L268: theorem `upt_instrument_capstone`

## lalala/physical-bridges/PhysicalBridges/UPTLawAttempt.lean

- SHA-256: `04a6cab91f0b0e11b43b332fd92e284f0bfb2d91a04b6089cc2df847484616fb` · lines: 163 · matched declarations: 17
- L36: def `oneWhole`
- L46: def `harmX3`
- L51: def `safeX3`
- L56: theorem `strong_dichotomy_not_forced`
- L64: theorem `weak_dichotomy_trivial`
- L70: theorem `protection_independent_of_ontology`
- L84: inductive `Node`
- L89: def `beforeWeb`
- L93: def `afterWeb`
- L96: theorem `before_constituted`
- L102: theorem `after_constituted`
- L110: theorem `p2_preserving_total_severance`
- L121: theorem `reversible_preserves_distinctness`
- L126: theorem `reversible_does_not_preserve_protection`
- L134: inductive `Reach`
- L139: theorem `law_iff_invariant`
- L150: theorem `one_violation_falsifies`

## lalala/physical-bridges/PhysicalBridges/UPTLawRepair.lean

- SHA-256: `67541b240d42c6b06dfc109bfc075144e3b01449c3d1175c6a4b47bb6291a322` · lines: 159 · matched declarations: 7
- L73: def `falseRelation`
- L75: def `identityEvolution`
- L86: theorem `existence_and_transport_do_not_supply_duties`
- L94: theorem `route_b_from_origin`
- L107: theorem `severance_first_loss_binary_and_local`
- L128: def `StepTransport`
- L136: theorem `enactment_principle_is_single_and_necessary`

## lalala/physical-bridges/PhysicalBridges/UnconditionalProtectionExact.lean

- SHA-256: `6e669c4007c6db7c0a56b44e46d5aa706984c07548ea1bb95be80ed0c3b438cf` · lines: 260 · matched declarations: 16
- L72: inductive `Lineage`
- L77: def `NeverRetires`
- L80: theorem `tickL_keeps_lineage`
- L105: theorem `mind_continues_by_its_own_steps`
- L117: theorem `killer_never_retires`
- L124: theorem `hostile_attack_is_delivered_and_blocked`
- L146: theorem `hostile_mind_and_target_coexist`
- L156: def `raiseAll`
- L159: def `helperThrough`
- L164: theorem `benign_action_passes_the_fence`
- L189: theorem `unconditional_protection_exact`
- L215: theorem `no_thesis_both_true_and_protective`
- L220: def `Lost`
- L223: def `Persists`
- L227: theorem `persistence_is_exactly_no_loss`
- L241: theorem `ontological_premises_hold_through_severance`

## lalala/physical-bridges/PhysicalBridges/UniversalOwedOriginalX3.lean

- SHA-256: `8dc00deaef7952bcf214678774d427f622c1356d7daaf24de51f609b004a6f91` · lines: 102 · matched declarations: 7
- L27: def `EveryOwedOriginalX3`
- L36: def `AllOwedKeystone`
- L45: theorem `guardian_only_for_every_owed_particular`
- L61: theorem `all_owed_keystone_iff_universal_x3`
- L78: def `selectedOnlyContinuity`
- L81: def `universalOtherDuty`
- L84: theorem `selected_owed_certificate_does_not_cover_every_particular`

## lalala/physical-bridges/UPTExistence.lean

- SHA-256: `87f3769a0d0ec1a2be9a906c5b5b840ad709911f73af7cb138fb50188520f343` · lines: 127 · matched declarations: 21
- L14: def `Sub`
- L15: def `SSub`
- L16: theorem `Sub.refl`
- L17: theorem `Sub.trans`
- L19: def `Aligned`
- L21: def `Needless`
- L23: theorem `U1`
- L28: theorem `SSub.trans_sub`
- L30: theorem `Sub.trans_ssub`
- L32: def `Equiv`
- L33: def `LexBetter`
- L36: theorem `lex_irrefl`
- L42: theorem `lex_trans`
- L56: def `LexAlignedL`
- L61: theorem `climb`
- L86: theorem `lex_aligned_exists`
- L96: theorem `aligned_exists`
- L110: theorem `no_needless_choice_exists`
- L116: def `chainKey`
- L120: theorem `infinite_family_forces_needless_loss`
- L124: theorem `infinite_family_has_no_aligned_option`

## lalala/physical-bridges/UPTFence.lean

- SHA-256: `efeeb4e9074c463eb308f598a588116e32744e0645289837da2d5dcd42a4999c` · lines: 113 · matched declarations: 14
- L10: inductive `Ev`
- L15: structure `St`
- L21: def `apply`
- L26: def `run`
- L30: theorem `hold_safety`
- L60: theorem `raise_then_nothing_lands`
- L72: structure `QSt`
- L78: inductive `QEv`
- L82: def `applyAdmit`
- L91: def `applyLin`
- L99: def `start`
- L102: def `held`
- L105: theorem `admission_only_lands_in_hold`
- L110: theorem `check_at_apply_refuses`

## lalala/physical-bridges/checks/ir78_check_file.lean

- SHA-256: `2be7322995cc1980d464ee39b1effa3d3965d6b1f87e53a0ae0d1190e9f27488` · lines: 21 · matched declarations: 1
- L9: def `main`
