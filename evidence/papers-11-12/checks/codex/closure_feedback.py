"""Least co-hold closure when the certified pause duration itself grows with the chosen boundary."""
from itertools import product
import json,sys
sys.dont_write_bytecode=True

def bill(C,cost,base):return base+sum(w for i,w in enumerate(cost) if C>>i&1)
def expand(C,edges,cost,base):
    h=bill(C,cost,base);D=C
    for i,j,tolerance in edges:
        if C>>i&1 and h>tolerance:D|=1<<j
    return D

def solve(seed,edges,cost,base):
    C=seed;trace=[]
    while True:
        D=expand(C,edges,cost,base);trace.append((C,bill(C,cost,base)))
        if D==C:return C,trace
        C=D

def main():
    # All three-node directed graphs with absent/short/long-tolerance edges; all nonempty seeds.
    n=3;pairs=[(i,j) for i in range(n) for j in range(n) if i!=j];cases=0
    for settings in product((-1,1,3),repeat=len(pairs)):
        edges=tuple((i,j,t) for (i,j),t in zip(pairs,settings) if t>=0)
        for cost in ((1,1,1),(1,2,3)):
            for seed in range(1,1<<n):
                C,tr=solve(seed,edges,cost,1)
                assert len(tr)<=n-bin(seed).count('1')+1
                certs=[D for D in range(1<<n) if D&seed==seed and expand(D,edges,cost,1)==D]
                assert certs and all(C&~D==0 and bill(C,cost,1)<=bill(D,cost,1) for D in certs)
                cases+=1
    edges=((0,1,1),(1,2,2),(2,3,3));cost=(1,1,1,1)
    C,tr=solve(1,edges,cost,1)
    assert tr==[(1,2),(3,3),(7,4),(15,5)]
    # Freezing the relation at the seed's duration is not a valid fixed-point calculation.
    fixed_h=bill(1,cost,1);D=1
    while True:
        E=D
        for i,j,t in edges:
            if D>>i&1 and fixed_h>t:E|=1<<j
        if E==D:break
        D=E
    assert D==3 and expand(D,edges,cost,1)!=D
    # Monotone alone need not retain the seed: the constant-empty operator is a counterexample.
    empty=lambda _:0
    assert all(C&~E or empty(C)&~empty(E)==0 for C in range(8) for E in range(8))
    assert empty(1)==0 and empty(empty(1))==0 and 1&~empty(1)!=0
    result={'graph_seed_cost_certificates':cases,'least_self_consistent_boundary':True,
      'cascade_example':{'iterations':[{'boundary_mask':c,'certified_duration':h} for c,h in tr],
                         'seed_frozen_relation_mask':D,'actual_fixed_point_mask':C,'deadline':4,'seed_bound_passes':True,'closure_bound_passes':False},
      'monotone_without_extensiveness_witness':{'seed_mask':1,'stable_iterate_mask':empty(1),'contains_seed':False},
      'scope':'Duration is a caller-supplied monotone certificate bill; tolerances and dependency edges require evidence. Failure of this certificate is not a proof that every physical architecture is infeasible.'}
    if len(sys.argv)>1:
        ok={'one_closure_at_seed_duration_is_self_consistent':expand(D,edges,cost,1)==D}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(result,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
