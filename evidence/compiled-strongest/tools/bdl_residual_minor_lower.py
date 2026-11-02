#!/usr/bin/env python3
"""Verified graph-minor minimum-degree lower bounds on BDL residual dual width.

For any graph minor H of primal graph G, treewidth(G)>=treewidth(H)>=
min_degree(H). Every source-graph contraction/deletion is replayed here.
This lower bounds ONLY primal variable elimination for this factor graph,
not all equivalent factorisations or exact samplers.
"""
from itertools import permutations
from random import Random

from bdl_residual_junction_audit import measured_dual_graph, eliminated_width


def initial_graph(adj):
    return {i:{j for j in range(len(adj)) if (adj[i]>>j)&1}
            for i in range(len(adj))}


def verify_graph(g):
    assert all(v not in neighbors and all(v in g[u] for u in neighbors)
               for v,neighbors in g.items())


def minor_step(g, action):
    """Replay one certified vertex deletion or edge contraction."""
    operation,v,u=action
    if operation=="delete":
        assert u is None and v in g
        for x in g[v]:
            g[x].remove(v)
        del g[v]
    elif operation=="contract":
        assert v in g and u in g[v]
        incoming=set(g[v])-{u}
        g[u].remove(v)
        for x in incoming:
            g[x].remove(v)
            g[x].add(u)
            g[u].add(x)
        g[u].discard(u)
        del g[v]
    else:
        raise ValueError(action)
    verify_graph(g)


def find_minor_lower_bound(adj,seed,strategy):
    g=initial_graph(adj)
    verify_graph(g)
    rng=Random(seed)
    best=0
    actions=[]
    witness_size=len(g)
    witness_step=0
    while g:
        mindeg=min(map(len,g.values()))
        if mindeg>best:
            best=mindeg
            witness_size=len(g)
            witness_step=len(actions)
        mins=sorted(v for v in g if len(g[v])==mindeg)
        v=mins[rng.randrange(len(mins))]
        if not g[v]:
            action=("delete",v,None)
        else:
            opts=[]
            for u in sorted(g[v]):
                common=len(g[v] & g[u])
                if strategy=="max_common":
                    score=(-common,len(g[u]))
                elif strategy=="min_degree":
                    score=(len(g[u]),-common)
                elif strategy=="max_degree":
                    score=(-len(g[u]),-common)
                elif strategy=="min_common":
                    score=(common,len(g[u]))
                else:
                    raise ValueError(strategy)
                opts.append((score,u))
            opt=min(s for s,_ in opts)
            tied=sorted(u for s,u in opts if s==opt)
            u=tied[rng.randrange(len(tied))]
            action=("contract",v,u)
        actions.append(action)
        minor_step(g,action)
    return best,witness_size,witness_step,actions


def replay_certificate(adj,actions,claimed_lower,claimed_size,claimed_step):
    g=initial_graph(adj)
    best=0
    before_size=None
    before_step=None
    for step,action in enumerate(actions):
        if g:
            d=min(map(len,g.values()))
            if d>best:
                best=d
                before_size=len(g)
                before_step=step
        minor_step(g,action)
    assert not g
    assert (best,before_size,before_step)==(
        claimed_lower,claimed_size,claimed_step
    ),((best,before_size,before_step),(claimed_lower,claimed_size,claimed_step))
    return best


def small_test():
    # Minor bound is <= exact min elimination width on small graphs.
    fixtures=[
        [0]*5,
        [((1<<6)-1)^(1<<i) for i in range(6)], # K6
        [sum(1<<j for j in range(6) if abs(i-j)==1)
         for i in range(6)], # path
        [sum(1<<j for j in range(6) if (j-i)%6 in (1,5))
         for i in range(6)], # cycle C6
        [sum(1<<j for j in range(6) if (i<3)!=(j<3))
         for i in range(6)], # K3,3
    ]
    for adj in fixtures:
        tw=min(eliminated_width(adj,p) for p in permutations(range(len(adj))))
        for seed in range(4):
            bound,size,step,actions=find_minor_lower_bound(
                adj,seed,"max_common")
            assert replay_certificate(adj,actions,bound,size,step)==bound
            assert bound<=tw,(bound,tw)


def audit():
    small_test()
    for L in (1,2):
        m,d,scopes,adj=measured_dual_graph(L)
        best=(0,None,None,None,None,None)
        for strategy in ("max_common","min_degree","max_degree","min_common"):
            for seed in range(48):
                k,size,step,actions=find_minor_lower_bound(adj,seed,strategy)
                assert replay_certificate(adj,actions,k,size,step)==k
                if k>best[0]:
                    best=(k,size,step,strategy,seed,actions)
        bound,size,step,strategy,seed,actions=best
        assert bound>0 and bound<={1:14,2:28}[L]
        print("L=",L,"dual_variables=",d,
              "certified_minor_treewidth_lower=",bound,
              "best_known_elimination_upper=",{1:14,2:28}[L],
              "witness_minor_vertices=",size,
              "contractions_to_witness=",step,
              "strategy=",strategy,"seed=",seed)
        # Certificate consists of deterministic input graph +
        # (strategy,seed) + replayed full contraction operation sequence.
        assert len(actions)==d
    print("BDL verified minors and exact finite treewidth lower certificates: PASS")


if __name__=="__main__":
    audit()
