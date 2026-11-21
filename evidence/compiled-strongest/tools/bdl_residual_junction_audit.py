#!/usr/bin/env python3
"""Source-derived residual Fourier-dual factor graph and induced-width receipt.

The 2c vertices are dual CHECK COEFFICIENTS, not original syndrome bits.
RCM trellis cut rank is not primal elimination width. All source data
are inherited from draft PRs #215 → #216 → #218 → #219 → #220.
"""
from bdl_replacement_chain import seed, replace_x, replace_z, edge, vertex
from bdl_frontier_audit import error_columns, dependency_basis
from bdl_local_spheres import sphere_blocks


def extend_basis(rows):
    pivots, selected = {}, []
    for row in rows:
        v = row
        while v:
            p = v.bit_length() - 1
            if p in pivots:
                v ^= pivots[p]
            else:
                pivots[p] = v
                selected.append(row)
                break
    return selected


def measured_dual_graph(L):
    prior = replace_x(seed(), L)
    code = replace_z(prior.tanner, L)
    sites = tuple(code.x)
    site_index = {name:i for i,name in enumerate(sites)}
    spheres = [set(block) for block in sphere_blocks(prior,L)]
    endpoints = []
    for x in prior.x:
        e = edge((0, vertex(x)), (1, vertex(x)))
        endpoints.append({("zv",x,0),("zv",x,1)} |
                         {("qe",q,e) for q in prior.tanner.xq[x]})
    blocks = spheres + endpoints
    block_masks = [sum(1 << site_index[x] for x in b) for b in blocks]
    covered = 0
    for b in block_masks:
        assert b != 0 and not (covered & b)
        covered |= b

    cols, syndrome = error_columns(code,"Z")
    assert list(syndrome) == list(sites)
    full = dependency_basis(cols,syndrome,code.q)
    full_masks = [sum(1 << i for i in row) for row in full]
    basis = extend_basis(block_masks+full_masks)
    assert len(basis) == len(full) == 32*L*L+48*L+10
    assert basis[:len(block_masks)] == block_masks
    residual = basis[len(block_masks):]
    d = 16*L*L+24*L+4
    assert len(residual)==d

    # A different complement representative can have different scopes.
    # Minimize each residual word modulo disjoint true block rows.
    residual = list(residual)
    for j,v in enumerate(residual):
        for b in block_masks:
            if 2*(v&b).bit_count() > b.bit_count():
                v ^= b
        residual[j] = v
    assert len(extend_basis(block_masks+residual))==len(full)

    columns = [0]*len(sites)
    for j,row in enumerate(residual):
        while row:
            low = row & -row
            columns[low.bit_length()-1] |= 1 << j
            row -= low
    scopes = []
    for b in block_masks:
        scope = 0
        while b:
            low = b & -b
            scope |= columns[low.bit_length()-1]
            b -= low
        if scope:
            scopes.append(scope)
    for i in range(len(sites)):
        if not ((covered >> i)&1) and columns[i]:
            scopes.append(columns[i])

    adj = [0]*d
    for scope in scopes:
        v = scope
        while v:
            low = v & -v
            j = low.bit_length()-1
            adj[j] |= scope & ~low
            v -= low
    assert all(((adj[i] >> j)&1)==((adj[j] >> i)&1)
               for i in range(d) for j in range(d))
    return len(sites), d, scopes, adj


def eliminated_width(adj, order):
    n = len(adj)
    assert sorted(order) == list(range(n))
    a = list(adj)
    width = 0
    for i in order:
        neighbours = a[i]
        width = max(width, neighbours.bit_count())
        pending = neighbours
        while pending:
            low = pending & -pending
            j = low.bit_length()-1
            a[j] = (a[j] | (neighbours & ~low)) & ~(1 << i)
            pending -= low
        a[i] = 0
    return width


def minfill_order(adj):
    a, active, result = list(adj), set(range(len(adj))), []
    while active:
        def score(i):
            neighbors = a[i]
            k = neighbors.bit_count()
            duplicate_edges = 0
            v = neighbors
            while v:
                low = v & -v
                j = low.bit_length()-1
                duplicate_edges += (a[j]&neighbors).bit_count()
                v -= low
            return ((k*(k-1)-duplicate_edges)//2,k,i)
        i = min(active,key=score)
        result.append(i)
        neighbors = a[i]
        v = neighbors
        while v:
            low = v & -v
            j = low.bit_length()-1
            a[j] = (a[j] | (neighbors & ~low)) & ~(1 << i)
            v -= low
        a[i] = 0
        active.remove(i)
    return result


def verify():
    # Transfer counterexample: single n-body parity row has parity-trellis
    # cut rank 1, but unsplit primal clique K_n has width n-1.
    for n in (4, 8):
        clique = [((1<<n)-1) ^ (1<<i) for i in range(n)]
        assert eliminated_width(clique,list(range(n))) == n-1

    expected = {1:(840,44,5,17,16),2:(4760,116,5,33,30)}
    for L in (1,2):
        m,d,scopes,adj = measured_dual_graph(L)
        raw = eliminated_width(adj,list(range(d)))
        minfill = eliminated_width(adj,minfill_order(adj))
        measured = (m,d,max(map(int.bit_count,scopes)),raw,minfill)
        assert measured == expected[L], (L,measured)
        assert all(s.bit_count() <= minfill+1 for s in scopes)
        print("L",L,"syndrome_bits",m,"residual_dual_bits",d,
              "factor_count",len(scopes),"max_initial_factor_scope",measured[2],
              "source_basis_order_width",raw,"minfill_induced_width",minfill)
    print("BDL residual dual primal-width audit: PASS")


if __name__ == "__main__":
    verify()
