#!/usr/bin/env python3
"""Reproducible width searches for the ACTUAL finite BDL residual-dual graph.

Improvements are certified by replaying exact bitset-fill permutations and
checking the running-intersection property, not by trusting a heuristic.

All widths are finite upper bounds for this source-derived complement basis.
No uniform O(L) theorem, physical embedding, or poly-time sampler follows.
"""
from collections import Counter
from random import Random
from bdl_residual_junction_audit import measured_dual_graph, minfill_order, eliminated_width


def degree_fill_data(adjacency, active, i):
    neighbors=adjacency[i]
    k=neighbors.bit_count()
    doubled=0
    q=neighbors
    while q:
        bit=q&-q
        j=bit.bit_length()-1
        doubled += (adjacency[j]&neighbors).bit_count()
        q-=bit
    return (k*(k-1)-doubled)//2,k


def search_order(graph, criterion, seed):
    n=len(graph)
    a=list(graph)
    active=set(range(n))
    rng=Random(seed)
    output=[]
    while active:
        costs={}
        for i in active:
            fill,degree=degree_fill_data(a,active,i)
            if criterion=="fill":
                scores=(fill,degree)
            elif criterion=="degree":
                scores=(degree,fill)
            elif criterion=="hybrid":
                scores=(fill+degree,fill)
            elif criterion=="fillplus":
                scores=(2*fill+degree,degree)
            elif criterion=="weighted":
                # Local score adjusts for degree of neighboring vertices.
                neigh_degree=0
                v=a[i]
                while v:
                    bit=v&-v
                    j=bit.bit_length()-1
                    neigh_degree+=a[j].bit_count()
                    v-=bit
                scores=(fill,neigh_degree,degree)
            else:
                raise ValueError(criterion)
            costs[i]=scores
        best=min(costs.values())
        choices=sorted(i for i in active if costs[i]==best)
        i=choices[rng.randrange(len(choices))]
        output.append(i)
        neighbors=a[i]
        todo=neighbors
        while todo:
            bit=todo&-todo
            j=bit.bit_length()-1
            a[j]=(a[j] | (neighbors&~bit)) & ~(1<<i)
            todo-=bit
        a[i]=0
        active.remove(i)
    return output


def certify_order(graph, order):
    n=len(graph)
    if len(order)!=n or sorted(order)!=list(range(n)):
        raise ValueError("not a permutation")
    a=list(graph)
    bags={}
    future={}
    work=0
    width=0
    max_bag=0
    for v in order:
        neighbors=a[v]
        bag=neighbors | (1<<v)
        bags[v]=bag
        future[v]=neighbors
        k=bag.bit_count()
        width=max(width,k-1)
        work+=1<<k
        max_bag=max(max_bag,k)
        t=neighbors
        while t:
            bit=t&-t
            j=bit.bit_length()-1
            a[j]=(a[j] | (neighbors&~bit)) & ~(1<<v)
            t-=bit
        a[v]=0
    assert all(x==0 for x in a)
    assert width==eliminated_width(graph,order)

    # Elimination-tree parent for each bag, with a virtual root for
    # disconnected components. Verify the running-intersection property
    # by checking B_v without v lies inside the parent's later bag.
    pos={v:i for i,v in enumerate(order)}
    parent={}
    for v in order:
        remaining=future[v]
        if remaining==0:
            parent[v]=None
            continue
        candidates=[u for u in range(n) if (remaining>>u)&1]
        p=min(candidates,key=lambda u:pos[u])
        assert pos[p]>pos[v]
        assert remaining & ~bags[p]==0, ("running intersection failed",v,p)
        parent[v]=p
    return {"width":width,"table_entries":work,"max_bag":max_bag,
            "roots":sum(p is None for p in parent.values())}


def connected_components(graph):
    n=len(graph)
    remaining=set(range(n))
    size=[]
    while remaining:
        start=min(remaining)
        remaining.remove(start)
        seen={start}
        work=[start]
        while work:
            v=work.pop()
            for u in list(remaining):
                if (graph[v]>>u)&1:
                    seen.add(u)
                    work.append(u)
                    remaining.remove(u)
        size.append(len(seen))
    return sorted(size,reverse=True)


def audit():
    summaries=[]
    for L in (1,2):
        m,d,scopes,graph=measured_dual_graph(L)
        baseline=minfill_order(graph)
        reference=certify_order(graph,baseline)
        assert reference["width"]=={1:16,2:30}[L]
        assert sum(1 for s in scopes if s.bit_count()>2)>0
        components=connected_components(graph)
        best=(reference["width"],reference["table_entries"],"baseline",0,baseline)
        by_kind=Counter()
        for kind in ("fill","degree","hybrid","fillplus","weighted"):
            for seed in range(32):
                order=search_order(graph,kind,seed)
                receipt=certify_order(graph,order)
                by_kind[(kind,receipt["width"])]+=1
                key=(receipt["width"],receipt["table_entries"],kind,seed,order)
                if key[:2]<best[:2]:
                    best=key
        final=certify_order(graph,best[-1])
        assert final["width"]<=reference["width"]
        summary={"L":L,"m":m,"d":d,"n_factors":len(scopes),
                 "component_sizes":components,
                 "baseline_width":reference["width"],
                 "baseline_table_entries":reference["table_entries"],
                 "best_width":final["width"],
                 "best_table_entries":final["table_entries"],
                 "best_method":best[2],"best_seed":best[3],
                 "elimination_order":best[-1]}
        summaries.append(summary)
        print(f"L={L} m={m} d={d} factors={len(scopes)} components={components}"
              f" baseline_width={reference['width']}"
              f" baseline_entries={reference['table_entries']}"
              f" best_width={final['width']} best_entries={final['table_entries']}"
              f" best_method={best[2]} best_seed={best[3]}")
        print("WIDTH_COUNTS",sorted(by_kind.items()))
    assert all(s["best_width"]<=s["baseline_width"] for s in summaries)
    print("BDL dual exact fill, running intersection, and ordering benchmark: PASS")
    return summaries


if __name__=="__main__":
    audit()
