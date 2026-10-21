"""Each named incorrect claim must fail, with a stable expected exit1."""
import sys
sys.dont_write_bytecode=True
import calculate as c
from fractions import Fraction as F

def reject(name):
    if name=='half_window_implied_by_date_union':
        assert c.P0<=c.P0/2, 'a fresh .002 fault event may lie inside both nested windows; no start-intensity law is supplied'
    elif name=='half_deadline_from_unbounded_CPU':
        assert c.urgent_recovery_requirements()['fixed_serial_care_floor']<F(19,40), 'fixed serial care stages already exceed .475'
    elif name=='serial_reseed32_quota_with_old_energy':
        r=next(r for r in c.reseed_requirements()['rows'] if r['completion_dates']==32)
        assert r['energy_margin_before_new_flow_or_idle_cost']>=0, '32-date global-serial progress quota exceeds existing energy; this does not reject parallel schedules'
    elif name=='reseed16_with_old_authentication':
        r=next(r for r in c.reseed_requirements()['rows'] if r['completion_dates']==16)
        assert r['existing_auth_reserve_fits_lower_bound'], '16-date repair auth alone exceeds the remaining gate reserve'
    elif name=='three_island_founder_at_k2':
        r=c.founding_screen()['screens'][0]
        assert all(r[k] for k in ['five_distinct_key_islands_possible','quorum_interval_nonempty','eight_slots_on_172_hosts_fit']), 'three-island seed fails key diversity, authority and care slots'
    elif name=='56_island_founder_uses_JW26_envelope':
        r=next(r for r in c.founding_screen()['screens'] if r['islands']==56)
        assert r['JW26_six_exile_envelope_fits'], '56-island k2 pool needs39 exiles per survivor, beyond the six-exile point'
    elif name=='79_site_term_dominates_physical_risk':
        assert 2*c.subset(322,79,c.P0)>=c.subset(242,71,c.P0), '71-compute tail dominates the two79-site entries'
    elif name=='uniform_accounting_removes_common_correlation':
        # One shared horizon event of probability1e-7 can break every phase.
        # Dividing its bound by E is bookkeeping, not a smaller event.
        assert F(1,10**7)<=F(1,10**7)/c.EVENTS, 'a common event can affect all dates despite uniform ledger allocation'
    elif name=='MN2_proves_strict_twilight_separation':
        # Stock and capacity both halve. Weak MN2 holds exactly, while the
        # dimensionless energy/protection margin remains1/100 in both phases.
        capacity0,stock0=F(100),F(99)
        capacity1,stock1=capacity0/2,stock0/2
        assert stock1/stock0<=capacity1/capacity0
        pre=(capacity0-stock0)/capacity0
        twilight=(capacity1-stock1)/capacity1
        assert pre>twilight, 'equal proportional fade satisfies weak MN2 but does not give strict separation'
    else:
        raise ValueError(name)

if __name__=='__main__':
    def hook(kind,value,tb):
        print(kind.__name__+': '+str(value),file=sys.stderr)
    sys.excepthook=hook
    reject(sys.argv[1])
    print('INCORRECT CLAIM PASSED')
