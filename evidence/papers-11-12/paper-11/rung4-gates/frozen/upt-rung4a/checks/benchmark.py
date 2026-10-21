"""Explicit model-date schedule and TW-1 benchmark; all closure flags stay false."""
from fractions import Fraction as F
from math import ceil
from itertools import combinations
import json,sys
sys.dont_write_bytecode=True
from common import encode,baseline
import k3_screen

def calculate():
    c,j,(a,q)=baseline();pre=k3_screen.calculate()
    T=10**100;epoch=10**6;Pmax=10**20//400
    Fend=epoch;Gend=59*epoch;Tstart=T-58*epoch
    assert Gend<Tstart
    growth=[min(2**(r+1),Pmax) for r in range(58)]
    twilight=[ceil(F(Pmax,2**(r+1))) for r in range(58)]
    assert growth[-1]==Pmax and twilight[-1]==1
    exposures={'founding':epoch,'growth':sum(growth)*epoch,
      'maturity':Pmax*(Tstart-Gend),'twilight':sum(twilight)*epoch}
    assert sum(exposures.values())<=Pmax*T
    pricenew=pre['prices']['total_stock_per_island']
    ref=a['with_certificate_reserve'];new=pre['all21_screen']['with_reserve']
    # The algebraic certificate uses inherited GF16 code; all exposure/erasure
    # and release-interface assumptions remain separate.
    gf,inv=j.prior.gf,j.prior.inv
    determinants=[];tests=0
    for xs in combinations(range(1,8),3):
        d=1
        for x in xs:d=gf(d,x)
        for x,y in combinations(xs,2):d=gf(d,x^y)
        assert d and gf(d,inv(d))==1;determinants.append(d)
    for secret in (0,1,0x1234,65535):
        for aa,bb,cc in ((0,0,0),(1,2,3),(65535,0x6789,0xaaaa)):
            shares={x:secret^gf(aa,x)^gf(bb,gf(x,x))^gf(cc,gf(x,gf(x,x))) for x in range(1,8)}
            for xs in combinations(range(1,8),4):
                got=0
                for x in xs:
                    w=1
                    for y in xs:
                        if y!=x:w=gf(w,gf(y,inv(x^y)))
                    got^=gf(w,shares[x])
                assert got==secret;tests+=1
    return {'rung4_established':False,'benchmark_is_a_design_scenario_not_a_cosmological_prediction':True,
      'TW1':{'reference':'Frozen JW2.6 adjacent k2 plant, full400-island pool, model dates',
        'islands_per_pool':400,'minds_per_island':1032,'providers_per_island':288,
        'energy_margin':q['energy_margin'],'energy_flow':q['energy_flow'],
        'memory_use':q['memory_required'],'memory_cap':4512,
        'interconnect_use':q['interconnect_activity'],'interconnect_cap':F(93,4),
        'care':q['care_deadline'],'provider':q['provider_deadline'],'checkpoint':q['checkpoint_bound'],
        'whole_island_cap':2,'full_failure_bound':ref,
        'repair_byte_work_dates':q['reseed_completion_dates_after_stable_return'],
        'repair_auth_work_dates':q['repair_auth_completion_dates'],
        'common_account':F(1,10**7),'certificate_reserve_distinct_from_common':a['with_certificate_reserve']-a['sum'],
        'physical_p':F(1,500),'whole_host_shock_q':F(0)},
      'schedule':{'unit':'model date; no seconds or USD conversion',
        'protected_start':0,'horizon_end':T,
        'founding':[0,Fend],'growth':[Fend,Gend],'maturity':[Gend,Tstart],'twilight':[Tstart,T],
        'growth_epoch_dates':epoch,'growth_pools_per_epoch':growth,'twilight_pools_per_epoch':twilight,
        'exposure_pool_dates':exposures,'total_pool_dates':sum(exposures.values()),
        'maximum_world_pool_dates':Pmax*T,'maximum_world_islands':10**20,
        'population_fade_equals_capacity_fade_only_if_exits_natural_or_authorized':True,
        'jurisdiction_does_not_include_unprotected_preactivation_history':True,
        'preactivation_care_established':False,
        'availability_of_phase_specific_plant_is_an_extra_premise':True},
      'founding':{'route':'Commission one complete pool before activation; grow by complete pools',
        'seed_islands':400,'identities':400*1032,'providers':400*288,
        'TW1_seed_stock':400*j.STOCK,'proposed_k3_seed_stock':400*pricenew,
        'proposed_k3_world_stock_upper_endowment':10**20*pricenew,
        'full_founder_construction_proved':False,
        'open':['Source and custody of seed capital','Metered construction and commissioning',
          'Care before activation if required','Any pre-twilight transfer from the active k2 plant']},
      'margin_comparison':pre['benchmark_comparison'],
      'risk_composition_screens':{'four_phase_full_horizon_union':3*new+ref,
        'four_phase_union_fits_1e6':3*new+ref<=F(1,10**6),
        'joint_common_once_if_warranted':3*new+ref-3*F(1,10**7),
        'does_not_require_independence':True,
        'common_time_uniformity_does_not_follow_from_a_horizon_bound':True,
        'all_new_interface_predicates_must_first_be_validated':True},
      'proved_sublemmas':{'degree3_three_share_secrecy_nonzero_determinants':len(determinants),
        'four_share_reconstruction_cases':tests,
        'Hall_source_read_cap19':True,
        'secret_placement_or_trusted_hardware_realization_proved':False},
      'next_gate':'Prove the concurrent recovery and phase-transition interfaces before treating the static screen as a joint witness.'}

if __name__=='__main__':
    assert not sys.argv[1:]
    print(json.dumps(encode(calculate()),sort_keys=True,indent=2))
