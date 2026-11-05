#!/usr/bin/env python3
"""Exact finite test of BCRD identity-descent/holonomy source candidate.

Not a physical BCRD proof, an instrument certification or original-X3
continuity theorem. Only finite graph/cut labels and exact bijections.
"""
from itertools import permutations, combinations, product
from collections import Counter, deque


def inverse(p):
    q = [None] * len(p)
    for i, j in enumerate(p):
        q[j] = i
    return tuple(q)


def compose(f, g):
    """g o f"""
    return tuple(g[f[i]] for i in range(len(f)))


def connected(n, edges):
    neighbors = [[] for _ in range(n)]
    for a, b in edges:
        neighbors[a].append(b)
        neighbors[b].append(a)
    reached, stack = {0}, [0]
    while stack:
        for v in neighbors[stack.pop()]:
            if v not in reached:
                reached.add(v)
                stack.append(v)
    return len(reached) == n


def analyze(n, k, edges, perms):
    step = {}
    for (u, v), f in zip(edges, perms):
        step[(u, v)] = f
        step[(v, u)] = inverse(f)
    adjacent = [[] for _ in range(n)]
    for u, v in edges:
        adjacent[u].append(v)
        adjacent[v].append(u)
    for a in adjacent:
        a.sort()
    identity = tuple(range(k))
    tree_potential = {0: identity}
    parent = {0: None}
    bfs = deque([0])
    tree_edges = set()
    while bfs:
        u = bfs.popleft()
        for v in adjacent[u]:
            if v in parent:
                continue
            parent[v] = u
            tree_potential[v] = compose(tree_potential[u], step[(u, v)])
            tree_edges.add(tuple(sorted((u, v))))
            bfs.append(v)
    assert len(parent) == n
    assert len(tree_edges) == n - 1
    chords = [e for e in edges if e not in tree_edges]
    assert len(chords) == len(edges) - n + 1
    holonomy = {}
    for u, v in chords:
        holonomy[(u,v)] = compose(
            compose(tree_potential[u], step[(u,v)]),
            inverse(tree_potential[v]))
    fixed = {x for x in range(k)
             if all(H[x] == x for H in holonomy.values())}
    for x in range(k):
        section = [tree_potential[v][x] for v in range(n)]
        coherent = all(step[(u, v)][section[u]] == section[v]
                       for u, v in edges)
        assert coherent == (x in fixed), (n, k, edges, x)
    flat = all(H == identity for H in holonomy.values())
    assert flat == (len(fixed) == k)
    assert flat == all(
        step[(u, v)] ==
            compose(inverse(tree_potential[u]), tree_potential[v])
        for u, v in edges)
    return len(chords), flat, len(fixed), len(fixed)==0, 0 < len(fixed) < k


def extra_controls():
    # Coarse boundary can fail to notice a historical identity twist.
    H = (0,2,1)
    readout = (0,1,1)
    assert H != tuple(range(3))
    assert all(readout[H[x]] == readout[x] for x in range(3))
    assert len(set(readout)) < 3
    for k in range(1,5):
        for H in permutations(range(k)):
            for readout in product(range(k), repeat=k):
                if len(set(readout)) == k and all(
                    readout[H[x]] == readout[x] for x in range(k)):
                    assert H == tuple(range(k))
    # A root-cut relabeling conjugates cycle holonomy and retains
    # exactly the relabeled fixed points.
    for k in range(1,5):
        for H in permutations(range(k)):
            for g in permutations(range(k)):
                Hnew = compose(compose(inverse(g),H),g)
                assert Hnew == tuple(g[H[inverse(g)[x]]]
                                     for x in range(k))
                assert {g[x] for x in range(k) if H[x]==x} == {
                    x for x in range(k) if Hnew[x]==x}
                assert (H == tuple(range(k))) == (
                    Hnew == tuple(range(k)))
    # Every independently relabeled 3-cut hostile triangle has
    # the same conjugate (not necessarily equal) holonomy.
    f = {(0,1):(0,1,2), (1,2):(0,1,2), (0,2):(0,2,1)}
    gauges = list(permutations(range(3)))
    num_gauges=0
    for loc in product(gauges, repeat=3):
        new={}
        for (u,v),old in f.items():
            new[(u,v)] = compose(
                compose(inverse(loc[u]),old),loc[v])
        Hnew = compose(
            compose(new[(0,1)],new[(1,2)]),
            inverse(new[(0,2)]))
        Hexpected=compose(compose(
            inverse(loc[0]),(0,2,1)),loc[0])
        assert Hnew == Hexpected
        num_gauges+=1
    assert num_gauges == 216
    # If sizes strictly increase along an injective finite seam,
    # no injective return map to the original smaller fibre exists.
    for a,b in ((1,2),(2,3),(3,4)):
        assert a < b
        assert not any(len(set(f)) == b
                       for f in product(range(a),repeat=b))


def run():
    counts=Counter()
    for n in range(1,5):
        all_edges=list(combinations(range(n),2))
        for bits in product((0,1), repeat=len(all_edges)):
            edges=[e for e,b in zip(all_edges,bits) if b]
            if not connected(n,edges):
                continue
            counts['connected_graphs']+=1
            for k in (1,2,3):
                ps=list(permutations(range(k)))
                for perms in product(ps,repeat=len(edges)):
                    chords,flat,nfixed,nofixed,partial=analyze(
                        n,k,edges,perms)
                    counts['systems']+=1
                    counts['labels_checked']+=k
                    counts['fundamental_chord_checks']+=chords
                    counts['flat']+=flat
                    counts['fixed_labels']+=nfixed
                    counts['no_global_sections']+=nofixed
                    counts['partial_global_sections']+=partial
                    if chords and not flat:
                        counts['nontrivial_holonomy']+=1
    expected={
        'connected_graphs':44,'systems':117230,
        'labels_checked':350955,
        'fundamental_chord_checks':253791,
        'flat':8726,'fixed_labels':51795,
        'no_global_sections':82476,
        'partial_global_sections':26028,
        'nontrivial_holonomy':108504
    }
    assert counts == expected, (counts,expected)
    transposition=(0,2,1)
    triangle=analyze(3,3,[(0,1),(0,2),(1,2)],
                     [tuple(range(3)),transposition,tuple(range(3))])
    assert triangle == (1,False,1,False,True),triangle
    for p in permutations(range(3)):
        assert analyze(3,3,[(0,1),(1,2)],[p,p])[1:3] == (True,3)
    extra_controls()
    print("PASS",dict(counts))
    print("PASS: one original identity fixed, two twisted around same triangle")
    print("PASS: gauge conjugation and 216 independently relabelled cycles")
    print("PASS: coarse readout can hide nontrivial holonomy; separating cannot")
    print("PASS: finite closed-injection cardinality obstruction")
    print("LIMIT: physical BCRD source completeness, same-particular X3 unproved")


if __name__=="__main__":
    run()
