"""Deliberately incorrect continuation claims: each must exit1."""
from fractions import Fraction as F
from math import comb
import sys
sys.dont_write_bytecode=True
import tasks37 as t

def reject(name):
    if name=='k92_at_literal_0p46percent':
        assert t.COSMIC_POOL_EVENTS*t.hypergeom_tail(400,92,t.PHI)<=F(1,10**8), 'literal .46% needs k93 at this exposure/budget; approximately92 is not an exact certificate'
    elif name=='target_k_on_old_provider_wire':
        assert t.cost_screen(93)['same_pool_foreground_provider_projection']<=F(19,20), 'even the provider wire projection exceeds .95 at k93'
    elif name=='arbitrary_scatter_preserves_source_bound':
        assert 399*1032<=2064, 'unbalanced per-identity placement can send399 home groups to one island'
    elif name=='strict_parity_has399_candidate_privacy':
        assert F(1,comb(199,2))<=F(1,comb(399,2)), 'strict parity construction has199 possible foreign islands, not399'
    elif name=='positive_q_retains_point1_joblaw':
        assert F(1,10)+F(9,10)*F(1,100000)<=F(1,10), 'a positive host shock raises each job marginal above .1'
    elif name=='q_00016_meets_2p1e7':
        a,_=t.c.baseline();q=F(16,10**5)
        v=a['with_certificate_reserve']-2*t.j.m.committee(242)['horizon_union']+2*t.exact_committee(q)+t.legacy_quorum(q)-t.legacy_quorum(F(0))
        assert v<=F(21,10**8), 'q=.00016 exceeds the2.1e-7 ledger even with exact count tails'
    elif name=='host_marginals_imply_independent_host_tail':
        # One shared shock can make every host wrong, preserving each host's q.
        assert 4224*10**120*F(1,10**15)<=F(21,10**8), 'per-host q marginals do not rule out a pool-wide common shock'
    elif name=='threshold_key_alone_hides_plaintext_cache':
        assert F(1)<=F(1,comb(199,2)), 'a disclosed plaintext route cache reveals the target pair without reconstructing the threshold key'
    elif name=='budget_k93_strictly_beats_same_reference':
        ref=t.COSMIC_POOL_EVENTS*t.hypergeom_tail(400,93,t.PHI)
        assert ref<=ref/2, 'the budget-minimal reference does not strictly beat itself; unchanged repair needs k94 for the chosen factor2 target'
    else:raise ValueError(name)

if __name__=='__main__':
    sys.excepthook=lambda kind,value,tb:print(kind.__name__+': '+str(value),file=sys.stderr)
    reject(sys.argv[1]);print('INCORRECT CLAIM PASSED')
