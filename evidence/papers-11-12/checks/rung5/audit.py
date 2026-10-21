"""Focused rung-5 dependency audit. All decisions are exact; decimal strings are display only."""
from pathlib import Path
from fractions import Fraction as F
from decimal import Decimal,localcontext,ROUND_FLOOR
from itertools import product
import json
from . import kernel as k,mixed,source_oracle as source
from .intervals import I,power,exp_interval
ROOT=Path(__file__).resolve().parents[2]
CUTS={F(r):v for r,v in json.loads((Path(__file__).parent/'INPUTS.json').read_text())['d_cut'].items()}
CLAIMS=('legacy_incentive_filter_covers_all_values','marginal_service_probability_certifies_pool_tail',
 'host_shock_marginals_certify_independent_committee','adaptive_withdrawals_preserve_fixed_set_bound',
 'mixed_ledger_keeps_baseline_8p24e_7')

def display(x):
    with localcontext() as ctx:
        ctx.prec=24;ctx.rounding=ROUND_FLOOR
        return str(Decimal(x.numerator)/Decimal(x.denominator))

def same_accounts(a,b):return a.keys()==b.keys() and all(a[n]['accounts']==b[n]['accounts'] and a[n]['reserve']==b[n]['reserve'] for n in a)

def quick_controls():
    # At zero valuation the old row filter removes every row, although the physical laws are unchanged.
    legacy=source.rows(2,pc=F(499,500),valuation=F(0),legacy_filter=True)
    clean=source.rows(2,pc=F(499,500),valuation=F(0))
    fixed_failure=adaptive_failure=F(0)
    for a,b in product((0,1),repeat=2):
        fixed_failure+=F(not b,4)
        # Remove a performing role when possible: a survivor performs only if both originally perform.
        adaptive_failure+=F(not(a and b),4)
    assert fixed_failure==F(1,2) and adaptive_failure==F(3,4)
    p=k.P_ROLE;q=mixed.PUBLISHED_Q
    assert p>p*p and q>F(1,10**6)
    return {'legacy_filter_drops_all_zero_valuation_rows':legacy is None and len(clean)==10,
      'marginal_service_common_outage_probability':str(p),'two_role_failure_moment':str(p),
      'permitted_product_moment_under_joint_contract':str(p*p),
      'common_host_shock_can_exceed_whole_budget':q>F(1,10**6),
      'fixed_withdrawal_failure':str(fixed_failure),'adaptive_withdrawal_failure':str(adaptive_failure)}

def arithmetic_checks():
    cases=0
    for a,b,n in product(range(5),range(1,6),range(10)):
        x=F(a,b);lo,hi=(power(x,n)).fractions();assert lo<=x**n<=hi;cases+=1
    assert exp_interval(F(0)).fractions()==(F(1),F(1))
    for a,b in product((F(0),F(1,10),F(1,2),F(3)),repeat=2):
        lo,hi=exp_interval(a+b).fractions();l2,h2=(exp_interval(a)*exp_interval(b)).fractions()
        assert max(lo,l2)<=min(hi,h2);cases+=1
    return cases+1

def frozen_match(base):
    tw=source.BASE_ACCOUNTS['rows'];screen=json.loads((source.FROZEN/'K3-SCREEN.json').read_text())['all21_screen']['rows']
    comparisons=0
    for plant,expected in ((2,tw),(3,screen)):
        assert set(base[plant])==set(expected)
        for name,row in base[plant].items():
            for account in k.NAMES:
                val=expected[name]['accounts'][account]
                val=F(val['exact']) if isinstance(val,dict) else val
                assert row['accounts'][account]==val,(plant,name,account);comparisons+=1
    return comparisons

def run(detailed=False):
    primitive_checks=arithmetic_checks()
    assert source.old.VACANCY_CAPS==k.MU and source.m.MT==k.MT and source.m.PD==k.PD
    assert tuple(source.m.prior.ZS)==k.CHANNEL_Z and tuple(source.old.D_ZS)==k.DOWN_Z
    for r,d in CUTS.items():
        lo,hi=k.down_tail(d+1,k.MU[r]);prev_lo,prev_hi=k.down_tail(d,k.MU[r])
        assert k.PD*hi<=F(1,10**10)<k.PD*prev_lo
    base={p:source.rows(p) for p in (2,3)};phys={p:source.rows(p,pc=1-k.P_ROLE) for p in (2,3)}
    baseline_cells=frozen_match(base)
    controls=quick_controls();assert controls['legacy_filter_drops_all_zero_valuation_rows']
    economics=0
    for plant in (2,3):
        for valuation,cost in ((F(0),F(1000)),(F(-7),F(0)),(F(10**6),F(10**3))):
            changed=source.rows(plant,pc=1-k.P_ROLE,valuation=valuation,cost=cost)
            assert same_accounts(phys[plant],changed);economics+=len(changed)*len(k.NAMES)
    # Prove the sensitivity check can actually see an economic dependency inserted into an account.
    tainted0=source.rows(2,pc=1-k.P_ROLE,valuation=F(0),mutate_account=True)
    tainted1=source.rows(2,pc=1-k.P_ROLE,valuation=F(1),mutate_account=True)
    assert not same_accounts(tainted0,tainted1)
    for q in (F(0),mixed.PUBLISHED_Q,mixed.NEXT_Q):assert mixed.committee(q,4224)==source.exact_mixed_committee(q)
    comparisons=0;data=[];maximum={};minimum={};reference_maximum={}
    for law in ('independent_jobs','mixed_hosts'):
        for plant in (2,3):
            original=base[plant] if law=='independent_jobs' else source.mixed_rows(base[plant],plant,mixed.PUBLISHED_Q)
            physical=phys[plant] if law=='independent_jobs' else source.mixed_rows(phys[plant],plant,mixed.PUBLISHED_Q)
            old_upper=[];new_upper=[];new_lower=[]
            assert set(original)==set(physical)=={rd+':'+str(r) for rd in k.READINGS for r in k.MU}
            for name,ref in original.items():
                r=ref['r'];reading=ref['reading'];before=k.ledger(plant,k.old_service(r,reading),k.MU[r],CUTS[r])
                after=k.ledger(plant,1-k.P_ROLE,k.MU[r],CUTS[r])
                assert 1-k.P_ROLE>=k.old_service(r,reading)
                if law=='mixed_hosts':
                    before=mixed.replace_committee(before,plant,mixed.PUBLISHED_Q);after=mixed.replace_committee(after,plant,mixed.PUBLISHED_Q)
                assert set(before['upper'])==set(after['upper'])==set(k.NAMES)
                for version,own,src in (('before',before,ref),('after',after,physical[name])):
                    assert own['reserve'][1]<=src['reserve']
                    for account in k.NAMES:
                        assert own['lower'][account]<=own['upper'][account]<=src['accounts'][account],(law,plant,name,account)
                        comparisons+=1
                assert after['total'][1]<=before['total'][1]
                for account in k.NAMES:
                    if account not in ('ordinary_holding_channel','ordinary_rescue_channel','coordinated_load_channels'):
                        assert ref['accounts'][account]==physical[name]['accounts'][account]
                old_upper.append(before['total'][1]);new_upper.append(after['total'][1]);new_lower.append(after['total'][0])
                row={'law':law,'plant':plant,'row':name,'pc_before':str(k.old_service(r,reading)),
                     'pc_after':str(1-k.P_ROLE),'mu':str(k.MU[r]),'d_cut':CUTS[r],
                     'before_bound_upper_display':display(before['total'][1]),'after_bound_upper_display':display(after['total'][1]),
                     'all_21_terms_compared':True}
                if detailed:
                    row['after_analytical_bound_enclosures']={n:[str(after['lower'][n]),str(after['upper'][n])] for n in k.NAMES}
                    row['after_reserve']=list(map(str,after['reserve']))
                data.append(row)
            maximum[law,plant]=max(new_upper);minimum[law,plant]=max(new_lower);reference_maximum[law,plant]=max(x['with_reserve'] for x in original.values())
            assert maximum[law,plant]<=reference_maximum[law,plant]<=F(21,10**8)
        assert maximum[law,3]<minimum[law,2]
    phase={law:3*maximum[law,3]+maximum[law,2] for law in ('independent_jobs','mixed_hosts')}
    phase_lower=3*minimum['mixed_hosts',3]+minimum['mixed_hosts',2]
    assert F(824,10**9)<phase_lower<=phase['mixed_hosts']<=F(84,10**8)<F(1,10**6)
    c2=phase['mixed_hosts']+4*F(1,10**8);assert c2<=F(88,10**8)<F(1,10**6)
    # A sufficient witness that the full-budget site-fault certificate remains wider for k3.
    # This is a sensitivity family, not a change to the theorem's p_site=p_role=.002 design point.
    stress={plant:mixed.replace_committee(k.ledger(plant,F(997,1000),k.MU[F(9,10)],CUTS[F(9,10)],site_p=F(23,10000)),plant,mixed.PUBLISHED_Q) for plant in (2,3)}
    assert stress[3]['total'][1]<F(1,10**6)<stress[2]['total'][0]

    result={'status':'PASS: rung-5 dependency step under stated joint physical/protocol contracts',
      'independent_account_comparisons':comparisons,'frozen_baseline_cells_match':baseline_cells,
      'economics_changed_account_cells_unchanged':economics,'injected_economic_dependency_detected':True,
      'primitive_arithmetic_checks':primitive_checks,'adjacent_vacancy_cuts_checked':len(CUTS),
      'plants':2,'rows_per_plant':10,'accounts_per_row':21,'physical_service_probability':str(1-k.P_ROLE),
      'mixed_host_q':str(mixed.PUBLISHED_Q),'exact_mixed_oracle_points':3,
      'max_bounds':{law:{'k2':display(maximum[law,2]),'k3':display(maximum[law,3])} for law in ('independent_jobs','mixed_hosts')},
      'four_phase_upper_display':{law:display(v) for law,v in phase.items()},
      'mixed_four_phase_ceiling':'21/25000000','mixed_plus_c2_each_phase_ceiling':'11/12500000',
      'all_below_horizon_budget':True,'full_budget_fault_certificate_wider_witness':{'site_p':'23/10000','service_lower':'997/1000','k3_upper':display(stress[3]['total'][1]),'k2_analytical_lower':display(stress[2]['total'][0]),'not_a_true_risk_lower_bound':True},'controls':controls,
      'scope':'Intervals enclose analytical union-bound expressions, not lower and upper measurements of true risk. Marginal fault rates, signal travel time and endowment existence are not certified.'}
    if detailed:result['rows']=data
    return result

def false_claim(name):
    assert name in CLAIMS
    if name=='mixed_ledger_keeps_baseline_8p24e_7':
        lows={}
        for plant in (2,3):
            lows[plant]=max(mixed.replace_committee(k.ledger(plant,1-k.P_ROLE,k.MU[r],CUTS[r]),plant,mixed.PUBLISHED_Q)['total'][0] for r in k.MU)
        return 3*lows[3]+lows[2]<=F(824,10**9)
    controls=quick_controls()
    if name=='legacy_incentive_filter_covers_all_values':return not controls['legacy_filter_drops_all_zero_valuation_rows']
    if name=='marginal_service_probability_certifies_pool_tail':return F(controls['two_role_failure_moment'])<=F(controls['permitted_product_moment_under_joint_contract'])
    if name=='host_shock_marginals_certify_independent_committee':return not controls['common_host_shock_can_exceed_whole_budget']
    return F(controls['adaptive_withdrawal_failure'])<=F(controls['fixed_withdrawal_failure'])
