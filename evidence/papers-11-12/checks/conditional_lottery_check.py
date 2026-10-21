"""Exact counterexample to unconditional marginal fairness, plus the explicit-abort finite-cap law."""
from fractions import Fraction as F
from collections import Counter
from itertools import product
import json,sys
sys.dont_write_bytecode=True

def tv(a,b):return sum(abs(x-y) for x,y in zip(a,b))/2

def main():
    q,m=5,3;U=(F(1,5),)*5
    # For every round r, (Z+2*r) mod 5 is uniform; dependence on previous rejections still biases selection.
    for r in range(10):assert Counter((z+2*r)%5 for z in range(5))==Counter(range(5))
    selected=[]
    for z in range(5):
        r=0
        while (z+2*r)%5>=3:r+=1
        assert r<=1;selected.append((z+2*r)%5)
    c=Counter(selected);law=tuple(F(c[k],5) for k in range(m))
    assert law==(F(2,5),F(2,5),F(1,5)) and tv(law,(F(1,3),)*3)==F(2,15)
    conditional=(F(1,2),F(1,2),F(0),F(0),F(0))
    assert tv(conditional,U)==F(3,5)
    # Fresh independent rounds with cap two report rejection as abort, rather than hide it.
    count=Counter()
    for x,y in product(range(q),repeat=2):count[x if x<3 else y if y<3 else 'abort']+=1
    capped=tuple(F(count[k],25) for k in (0,1,2,'abort'))
    ideal=(F(1,3),F(1,3),F(1,3),F(0))
    assert capped==(F(7,25),F(7,25),F(7,25),F(4,25))
    assert tv(capped,ideal)==F(4,25)==(1-F(3,5))**2
    if len(sys.argv)>1:
        claim={'unconditional_round_uniformity_guarantees_fair_stopping':tv(law,(F(1,3),)*3)==0,
               'a_finite_rejection_cap_has_no_abort_mass':count['abort']==0}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':claim},sort_keys=True));return 0 if claim else 1
    print(json.dumps({'correlated_uniform_marginals':True,'eventual_options':list(map(str,law)),
      'eventual_tv':str(tv(law,(F(1,3),)*3)),'second_round_tv_given_first_rejection':str(tv(conditional,U)),
      'fresh_two_attempt_cap_output':list(map(str,capped)),'explicit_abort_mass':'4/25',
      'required_contract':'conditional raw-law error at every reachable history, call termination/time bound, and explicit complete-output abort accounting'},sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
