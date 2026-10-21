"""Selective life repair works when the branch policy is feasible; information cells can prevent it."""
from itertools import product
from fractions import Fraction as F
import json,sys
sys.dont_write_bytecode=True
from dominance import OUT,le,key,law,dom,UPS

def partitions(n):
    if n==0:yield ();return
    for p in partitions(n-1):
        for label in range(max(p,default=-1)+2):yield p+(label,)

def patch(a,h):
    return tuple(y if key(x)[0]<key(y)[0] else x for x,y in zip(a,h))

def main():
    pairs=0;strict=0
    weights=(F(1,3),)*3
    for a in product(OUT,repeat=2):
        for h in product(OUT,repeat=2):
            if not all(key(x)[0]<=key(y)[0] for x,y in zip(a,h)):continue
            b=patch(a,h);assert all(le(x,y) for x,y in zip(a,b))
            A,B=law(a,(F(1,2),)*2),law(b,(F(1,2),)*2)
            assert dom(B,A)
            if b!=a:
                assert not dom(A,B);strict+=1
            pairs+=1
    H=((2,2),(2,1),(2,1));A=((2,2),(2,2),(2,0));B=patch(A,H)
    assert B==((2,2),(2,2),(2,1))
    assert dom(law(B,weights),law(A,weights)) and not dom(law(A,weights),law(B,weights))
    assert not dom(law(H,weights),law(A,weights))
    rows=[]
    for p in partitions(3):
        policies=[]
        for choices in product((False,True),repeat=max(p)+1):
            b=tuple(H[i] if choices[p[i]] else A[i] for i in range(3));policies.append(b)
        dominating=[b for b in policies if dom(law(b,weights),law(A,weights)) and not dom(law(A,weights),law(b,weights))]
        rows.append({'information_cells':p,'policies':len(policies),'strict_improvement_exists':bool(dominating),'exact_patch_available':B in policies})
    assert len(rows)==5
    coarse=next(r for r in rows if r['information_cells']==(0,1,1))
    full=next(r for r in rows if r['information_cells']==(0,1,2))
    assert not coarse['strict_improvement_exists'] and full['strict_improvement_exists']
    result={'two_world_life_top_pairs':pairs,'strict_repaired_pairs':strict,
      'example':{'A':A,'H':H,'repaired':B,'weights':list(map(str,weights))},
      'all_three_world_information_partitions':rows,
      'scope':'Feasible observable branch repair is a sufficient alternative to one globally dominating hold. A state-contingent mathematical splice is not automatically an implementable policy. Strict stochastic improvement uses positive branch probability; null lethal branches do not force strict dominance.'}
    if len(sys.argv)>1:
        ok={'nonlethal_hold_alone_makes_the_patch_feasible':coarse['exact_patch_available'],
            'full_information_still_cannot_repair_this_family':not full['strict_improvement_exists']}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(result,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
