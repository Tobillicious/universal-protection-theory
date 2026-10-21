"""Exact finite obligation closure and independently progressing outside components."""
from itertools import product
import json,sys
sys.dont_write_bytecode=True

def reach(adj,seed):
    c=seed
    while True:
        d=c
        for i,row in enumerate(adj):
            if c>>i&1:d|=row
        if d==c:return c
        c=d

def closed(adj,c):return all(not(c>>i&1) or row&~c==0 for i,row in enumerate(adj))

def main():
    n=4;edges=[(i,j) for i in range(n) for j in range(n) if i!=j];cases=0
    for bits in range(1<<len(edges)):
        adj=[0]*n
        for k,(i,j) in enumerate(edges):
            if bits>>k&1:adj[i]|=1<<j
        closed_sets=[s for s in range(1<<n) if closed(adj,s)]
        for seed in range(1,1<<n):
            C=reach(adj,seed);assert closed(adj,C) and C&seed==seed
            assert all(C&~D==0 for D in closed_sets if seed&~D==0);cases+=1
    histories=0
    f=lambda s:(3*s+1)%11;g=lambda e:(2*e+2)%13
    for T in range(10):
        for word in product((False,True),repeat=T):
            s,e=2,4;outside=[]
            for pause in word:
                if not pause:s=f(s)
                e=g(e);outside.append(e)
            x=2
            for _ in range(word.count(False)):x=f(x)
            y=4;reference=[]
            for _ in range(T):y=g(y);reference.append(y)
            assert s==x and e==y and outside==reference;histories+=1
    # A given obligation graph can make the one-resident plan insufficient; this is illustrative arithmetic.
    adj=[2,4,0];C=reach(adj,1);cost=(2,3,5);bill=sum(cost[i] for i in range(3) if C>>i&1)
    assert C==7 and bill==10 and cost[0]<=7<bill
    # A graph omitting the actual outside dependency can falsely label the seed closed.
    omitted_graph=(0,0);assert closed(omitted_graph,1)
    def coupled(z,held):return (z[0] if held else z[0]+1,z[1]+z[0])
    actual=coupled(coupled((0,0),True),False)[1]
    reference=coupled(coupled((0,0),False),False)[1]
    assert actual==0 and reference==1
    out={'four_node_graph_seed_certificates':cases,'graph_instances':1<<len(edges),
      'factorised_global_histories':histories,'outside_full_trace_unchanged':True,
      'closure_resource_example':{'initial_cost':2,'closed_cost':bill,'budget':7,'initial_passes':True,'closure_passes':False},
      'omitted_dependency_witness':{'held_outside_after_two_ticks':actual,'unheld_outside_after_two_ticks':reference,'declared_graph_labels_seed_closed':True},
      'scope':'Reachability is the least closed set for a GIVEN sound obligation relation. The relation, physical boundary factorisation, resource costs and deadlines still need evidence. No new plant certificate or physical necessity is inferred.'}
    if len(sys.argv)>1:
        ok={'model_relation_alone_prevents_unmodelled_dependency':actual==reference,'single_resident_capacity_covers_its_closure':bill<=7}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(out,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
