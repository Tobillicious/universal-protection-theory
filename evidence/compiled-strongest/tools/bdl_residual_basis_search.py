#!/usr/bin/env python3
"""Exact GF(2) basis search for the source-derived BDL residual dual factor graph.

Every candidate differs only by invertible parity-row operations from
the COMPLETE original syndrome relation space. No full-code relation
is removed or added. Width measurements are replayed and verified.

The test scales are algebraic ell=3,5 only; no all-L width claim.
"""
from random import Random

from bdl_replacement_chain import seed, replace_x, replace_z, edge, vertex
from bdl_local_spheres import sphere_blocks
from bdl_frontier_audit import error_columns, dependency_basis
from bdl_residual_junction_audit import minfill_order
from bdl_residual_order_search import certify_order, search_order


def mask(indices):
    result=0
    for i in indices:
        result |= 1<<i
    return result


def basis_rank(rows):
    piv={}
    for original in rows:
        v=original
        while v:
            p=v.bit_length()-1
            if p in piv:
                v ^= piv[p]
            else:
                piv[p]=v
                break
    return len(piv)


def source_problem(L):
    before=replace_x(seed(),L)
    after=replace_z(before.tanner,L)
    sites=tuple(after.x)
    where={x:i for i,x in enumerate(sites)}
    blocks=[mask(where[x] for x in row) for row in sphere_blocks(before,L)]
    for x in before.x:
        vertical=edge((0,vertex(x)),(1,vertex(x)))
        row={("zv",x,0),("zv",x,1)} | {
            ("qe",q,vertical) for q in before.tanner.xq[x]
        }
        blocks.append(mask(where[y] for y in row))
    covered=0
    for block in blocks:
        assert block and not (covered&block)
        covered |= block
    cols,rows=error_columns(after,"Z")
    assert tuple(rows)==sites
    original=[mask(row) for row in dependency_basis(cols,sites,after.q)]
    r=32*L*L+48*L+10
    d=16*L*L+24*L+4
    assert len(original)==r and len(blocks)==r-d
    assert basis_rank(blocks+original)==r
    return len(sites),blocks,original,d


def minimize_mod_blocks(row,blocks):
    for b in blocks:
        if 2*(row&b).bit_count()>b.bit_count():
            row ^= b
    return row


def pick_complement(blocks,original,criterion,seed):
    rng=Random(seed)
    rows=list(original)
    if criterion=="original":
        pass
    elif criterion=="weight":
        rows.sort(key=lambda v:(v.bit_count(),v))
    elif criterion=="coset":
        rows.sort(key=lambda v:(minimize_mod_blocks(v,blocks).bit_count(),v.bit_count(),v))
    elif criterion=="random":
        rng.shuffle(rows)
    else:
        raise ValueError(criterion)

    piv={}
    selected=[]
    for raw in blocks+rows:
        v=raw
        while v:
            p=v.bit_length()-1
            if p not in piv:
                piv[p]=v
                selected.append(raw)
                break
            v ^= piv[p]
    assert len(selected)==len(original)
    assert selected[:len(blocks)]==blocks
    return [minimize_mod_blocks(v,blocks) for v in selected[len(blocks):]]


def sparsify_rows(rows,blocks,seed):
    """Independent elementary residual-row XORs, strictly reducing weight."""
    rng=Random(seed)
    rows=list(rows)
    n=len(rows)
    for sweep in range(7):
        changed=0
        order=list(range(n))
        rng.shuffle(order)
        for i in order:
            current=rows[i]
            best=current
            for j in order:
                if i==j:
                    continue
                trial=current ^ rows[j]
                if trial.bit_count()<best.bit_count():
                    best=trial
            best=minimize_mod_blocks(best,blocks)
            if best.bit_count()<current.bit_count():
                rows[i]=best
                changed+=1
        if not changed:
            break
    return rows


def dual_factor_graph(m,blocks,residual):
    d=len(residual)
    col=[0]*m
    for j,row in enumerate(residual):
        v=row
        while v:
            bit=v&-v
            col[bit.bit_length()-1] |= 1<<j
            v-=bit
    covered=0
    scopes=[]
    for block in blocks:
        covered |= block
        scope=0
        v=block
        while v:
            bit=v&-v
            scope |= col[bit.bit_length()-1]
            v-=bit
        if scope:
            scopes.append(scope)
    for i in range(m):
        if not ((covered>>i)&1) and col[i]:
            scopes.append(col[i])
    graph=[0]*d
    for scope in scopes:
        v=scope
        while v:
            bit=v&-v
            j=bit.bit_length()-1
            graph[j] |= scope&~bit
            v-=bit
    assert all(((graph[i]>>j)&1)==((graph[j]>>i)&1)
               for i in range(d) for j in range(d))
    return graph,scopes


def audit():
    results=[]
    for L in (1,2):
        m,blocks,original,d=source_problem(L)
        baseline=pick_complement(blocks,original,"original",0)
        assert len(baseline)==d and basis_rank(blocks+baseline)==len(original)
        graph,_=dual_factor_graph(m,blocks,baseline)
        base_order=minfill_order(graph)
        base=certify_order(graph,base_order)
        assert base["width"] == {1:16,2:30}[L]
        best=(base["width"],base["table_entries"],"base",0,False)
        best_sparsity=sum(r.bit_count() for r in baseline)
        best_graph=graph
        tested=0
        for criterion in ("original","weight","coset","random"):
            for seed in range(4):
                selected=pick_complement(blocks,original,criterion,seed)
                for use_xor in (False,True):
                    residual=sparsify_rows(selected,blocks,seed) if use_xor else selected
                    assert len(residual)==d
                    assert basis_rank(blocks+residual)==len(original)
                    g,scopes=dual_factor_graph(m,blocks,residual)
                    orders=[("minfill",0,minfill_order(g))]
                    for rnd in range(3):
                        orders.append(("degree",rnd,search_order(g,"degree",rnd)))
                    for method,order_seed,order in orders:
                        candidate=certify_order(g,order)
                        tested+=1
                        if (candidate["width"],candidate["table_entries"])<best[:2]:
                            best=(candidate["width"],candidate["table_entries"],
                                  criterion,seed,use_xor,method,order_seed)
                            best_sparsity=sum(r.bit_count() for r in residual)
                            best_graph=g
        assert best[0]<=base["width"]
        result={"L":L,"m":m,"d":d,"baseline_width":base["width"],
                "baseline_entries":base["table_entries"],"best_width":best[0],
                "best_entries":best[1],"method":best[2:],
                "best_row_total_weight":best_sparsity,
                "tested_order_basis_pairs":tested,
                "best_graph_degrees":(min(x.bit_count() for x in best_graph),
                                      max(x.bit_count() for x in best_graph))}
        results.append(result)
        print(result)
    print("BDL full-parity GF2 row-equivalent dual graph basis search: PASS")
    return results


if __name__=="__main__":
    audit()
