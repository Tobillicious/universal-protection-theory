"""Audit pasted closure claims. Assertions check counterexamples, never claimed closure."""
from fractions import Fraction as F
from functools import lru_cache
import json,sys
sys.dont_write_bytecode=True
from common import ROOT,safe,encode

@lru_cache(None)
def calculate():
    phi=F(841,1000);factor=F(23,20);decay=F(4,125)
    trigger=phi*factor
    assert trigger==F(19343,20000)
    twilight_delta=F(21,10)*F(9,10)
    mu_upper=(1-twilight_delta)/2
    assert twilight_delta==F(189,100) and mu_upper==F(-89,200)
    founding_theta=lambda t:F(1,20)+F(t,2000)
    growth_theta=lambda t:F(1,5)+F(39*t,100000)
    fmargin=(F(29,20)-1)*founding_theta(0)
    assert fmargin==F(9,400)<F(9,100)
    assert growth_theta(1200)==F(167,250)>F(11,20)
    # Interpret table ranges literally; interpolation is a transparent illustration,
    # not an inferred model for its undefined moving average.
    crossing=F(301)+(F(98,100)-trigger)/(F(98,100)-F(95,100))*899
    assert crossing==F(411643,600)<1200
    ratio=trigger/(trigger-phi)
    assert ratio==F(23,3)
    expected_lifetime=F(99,100)*F(1,100)+F(1,100)*10000
    assert expected_lifetime>1 and F(99,100)>F(1,10**6)
    # The positive-Delta finance/coalition contradiction is algebraic:
    # K>0 and nonnegative FA force 1-1/Delta>=0, hence Delta>=1.
    # Nonnegative R_coal<R_total*mu, R_total>0, force mu>0,
    # hence Delta<1 under mu<=(1-Delta)/2. Empty intersection.
    finance_at_half=50000*(1-1/F(1,2))
    assert finance_at_half==-50000
    strict_positive_pointwise=[F(1,n) for n in (1,2,10,10**6)]
    assert min(strict_positive_pointwise)>0
    full_attempt_union=10**120*F(2**31,2**256)
    assert full_attempt_union>1
    p=ROOT/'inputs/upt-v01710/inputs/upt-jw27/RESULTS.json'
    canonical=list(json.loads(safe(p).read_text())['baseline_all21_worst'])
    assert len(canonical)==21 and 'common_plus_premise' in canonical
    return {
      'all_five_gaps_closed':False,'rung4_established':False,
      'tested_input':'inputs/proposal-extract.json; attachment inputs/founding-proposal.txt',
      'algebraic_infeasibility':{
        'domain':'Delta>0, K>0, FA_i>=0, R_coal>=0, R_total>0',
        'finance_requires':'Delta>=1',
        'coalition_requires':'Delta<1',
        'joint_feasible_set_empty':True,
        'twilight_minimum_Delta':twilight_delta,'twilight_mu_upper':mu_upper,
        'finance_RHS_at_Delta_half_and_USD50000':finance_at_half},
      'trajectory_checks':{
        'fidelity_trigger':trigger,'linear_unmitigated_decay_trigger_epoch':(1-trigger)/decay,
        'linear_unmitigated_decay_floor_epoch':(1-phi)/decay,
        'growth_fidelity_linear_interpolation_crossing_epoch':crossing,
        'interpolation_and_zero_lag_are_additional_assumptions':True,
        'moving_average_window_supplied':False,
        'growth_threat_at1200':growth_theta(1200),'claimed_growth_threat_ceiling':F(11,20),
        'corrected_growth_slope_if_endpoints301_and1200':F(7,17980),
        'founding_minimum_net_margin':fmargin,'claimed_minimum_net_margin':F(9,100),
        'minimum_target_net_margins':{'founding_at_end':F(9,100),'growth_at_stated_ceiling':F(33,100),'maturity':F(1,5),'twilight':F(99,100)},
        'margin_requirements_imply_earlier_wider_than_twilight':False,
        'MN2_is_a_population_capacity_fade_condition_not_a_numeric_cost':True},
      'probability_and_physics_checks':{
        'ratio_at_trigger_is_finite':ratio,
        'mean_lifetime_counterexample':{'probability_early_failure':F(99,100),'early_time':F(1,100),'late_time':10000,'mean':expected_lifetime,'recovery_deadline':1},
        'all_attack_routes_require_crypto_forgery_and_bit_erasure':False,
        'recovery_formula_bounds_time_to_physical_return':False,
        'exponential_delay_has_finite_deterministic_maximum':False,
        'ORAM_TEE_names_constitute_joint_implementation_proof':False,
        'advantage_energy_denominator_is_dimensionless_as_written':False,
        'existing_attempt_union_with256_substituted_for459':full_attempt_union,
        'union_above_one_is_not_an_actual_failure_probability':True},
      'founding_finance_checks':{
        'abrupt_notice_zero_withdrawal_penalty':F(0),
        'key_rotation_only_F64node_cycle_USD':64*12,
        'USD50000_covers_key_cycles_at64nodes_before_other_costs':F(50000,64*12),
        'key_rotation_only_G1024node_cycle_USD':1024*8,
        'USD250000_covers_key_cycles_at1024nodes_before_other_costs':F(250000,1024*8),
        'cycle_date_second_or_USD_model_conversion_supplied':False,
        'post_failure_penalties_imply_repair_deadline':False,
        'canonical_probability_accounts':canonical,
        'new_financial_accounts_reproduce_canonical21':False,
        'phase_partition_of_failure_accounts_covers_every_phase':False},
      'useful_items_retained':['Four-phase template','Joint all-cause loss accounting objective','Explicit request to meter keys, repair, caches and preactivation care'],
      'all_claimed_closures_rejected':True}

def claim(name):
    d=calculate()
    p=d['trajectory_checks'];v=d['algebraic_infeasibility'];b=d['probability_and_physics_checks']
    claims={
      'twilight_share_is_nonnegative':v['twilight_mu_upper']>=0,
      'growth_curve_respects_ceiling':p['growth_threat_at1200']<=p['claimed_growth_threat_ceiling'],
      'founding_gap_is_point09_at_every_time':p['founding_minimum_net_margin']>=p['claimed_minimum_net_margin'],
      'ratio_diverges_at_trigger':b['ratio_at_trigger_is_finite']>10**6,
      'large_mean_implies_small_failure_tail':b['mean_lifetime_counterexample']['probability_early_failure']<=F(1,10**6),
      'abrupt_withdrawal_penalty_is_positive':d['founding_finance_checks']['abrupt_notice_zero_withdrawal_penalty']>0,
      '256_substitution_preserves_horizon_budget':b['existing_attempt_union_with256_substituted_for459']<=F(1,10**6),
      'FA_labels_reproduce_existing21':d['founding_finance_checks']['new_financial_accounts_reproduce_canonical21'],
      'minimum_phase_targets_widen_before_twilight':p['minimum_target_net_margins']['founding_at_end']>p['minimum_target_net_margins']['twilight']}
    assert name in claims
    print(json.dumps({'claim':name,'holds':claims[name]},sort_keys=True))
    return 0 if claims[name] else 1

if __name__=='__main__':
    if len(sys.argv)==3 and sys.argv[1]=='--claim':sys.exit(claim(sys.argv[2]))
    assert not sys.argv[1:]
    print(json.dumps(encode(calculate()),sort_keys=True,indent=2))
