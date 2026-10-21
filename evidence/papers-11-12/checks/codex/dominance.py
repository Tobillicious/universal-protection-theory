"""Independent exact classification of the canonical stochastic-order boundary."""
from itertools import combinations,product
from fractions import Fraction as F
import json,sys
sys.dont_write_bytecode=True
OUT=tuple(product(range(3),repeat=2))
def key(o):return tuple(frozenset(i for i,x in enumerate(o) if x>=v) for v in (1,2))
def le(a,b):
    for x,y in zip(key(a),key(b)):
        if x!=y:return x<y
    return True
UPS=[frozenset(x) for k in range(10) for x in combinations(OUT,k) if all(b in x for a in x for b in OUT if le(a,b))]
def law(a,p):
    d={}
    for x,w in zip(a,p):d[x]=d.get(x,F(0))+w
    return d

def dom(a,b):return all(sum(a.get(x,F(0)) for x in U)>=sum(b.get(x,F(0)) for x in U) for U in UPS)

def main():
    principal=0
    for a,b in product(OUT,repeat=2):
        by_events=all(a not in U or b in U for U in UPS)
        assert by_events==le(a,b);principal+=1
    worlds=0;fixed_p_without_statewise=0;example=None
    for a,b in product(product(OUT,repeat=2),repeat=2):
        pointwise=all(le(x,y) for x,y in zip(a,b))
        diracs=all(dom(law(b,p),law(a,p)) for p in ((F(1),F(0)),(F(0),F(1))))
        assert diracs==pointwise
        if pointwise:assert dom(law(b,(F(1,2),)*2),law(a,(F(1,2),)*2))
        if not pointwise and dom(law(b,(F(1,2),)*2),law(a,(F(1,2),)*2)):
            fixed_p_without_statewise+=1
            example=example or {'a':a,'b':b}
        worlds+=1
    # An open parameter family, including positive false-alarm mass and both kinds of real-state branch.
    failures=0
    for den in range(3,18):
        for r in range(1,den):
            for s in range(1,den-r):
                q=F(den-r-s,den);pr=F(r,den);ps=F(s,den)
                H=law(((2,2),(2,1),(2,1)),(q,pr,ps))
                A=law(((2,2),(2,2),(2,0)),(q,pr,ps))
                assert not dom(H,A) and not dom(A,H);failures+=1
    # Two-state counterexample if the alternative may kill on a false alarm; H is always nonlethal.
    H=law(((2,2),(2,1)),(F(1,4),F(3,4)))
    A=law(((2,0),(2,2)),(F(1,4),F(3,4)))
    assert not dom(H,A) and not dom(A,H)
    result={'outcomes':len(OUT),'upsets':len(UPS),'event_order_pairs':principal,'two_world_action_pairs':worlds,
      'fixed_half_probability_dominance_without_statewise_order':fixed_p_without_statewise,
      'example_of_fixed_law_nonnecessity':example,'three_world_parameter_counterexamples':failures,
      'general_counterexample_formula':{'probabilities':'q,r,s >=0; q+r+s=1; r,s>0',
        'both_free_probability_H':'q','both_free_probability_A':'q+r','both_alive_probability_H':'1','both_alive_probability_A':'1-s'},
      'two_world_counterexample_with_false_lethality':True,
      'scope':'All-state-distribution guarantees are characterised by full statewise order when all principal upsets and Dirac laws are allowed. A fixed probability can admit other couplings; no physical necessity is claimed.'}
    if len(sys.argv)>1:
        ok={'alive_top_is_universal_full_order_top':dom(H,A),'fixed_probability_dominance_needs_statewise_order':fixed_p_without_statewise==0}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(result,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
