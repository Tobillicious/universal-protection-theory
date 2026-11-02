#!/usr/bin/env python3
"""Full finite metacheck and basis-invariant frontier audit for BDL test scales.

No full-family polynomial-time guarantee follows from four measured instances.
"""
from collections import defaultdict, deque
from bdl_replacement_chain import seed, replace_x, replace_z, summary


def error_columns(c, sector):
    if sector == "X":
        return c.d1, c.z  # X errors measured by Z checks
    if sector == "Z":
        reversed_d0 = defaultdict(set)
        for x, qs in c.d0.items():
            for q in qs:
                reversed_d0[q].add(x)
        return reversed_d0, c.x
    raise ValueError(sector)


def dependency_basis(colmap, syndrome, qubits):
    qi = {q:i for i,q in enumerate(qubits)}
    rid = {r:i for i,r in enumerate(syndrome)}
    checks = [0 for _ in syndrome]
    for q, rows in colmap.items():
        for r in rows:
            checks[rid[r]] ^= 1 << qi[q]
    piv, relations = {}, []
    for i, word in enumerate(checks):
        v, coefficient = word, 1 << i
        while v:
            pivot = (v & -v).bit_length()-1
            if pivot not in piv:
                piv[pivot] = (v,coefficient)
                break
            a,c = piv[pivot]
            v ^= a
            coefficient ^= c
        if not v:
            relations.append(tuple(j for j in range(len(syndrome))
                                   if coefficient >> j & 1))
    for rel in relations:
        mask = sum(1 << i for i in rel)
        for q, rows in colmap.items():
            assert not sum((mask >> rid[r]) & 1 for r in rows) % 2, (q, rel)
    assert len(relations) == len(syndrome)-len(piv)
    return relations


def row_span_width(relations, ordering):
    loc = {i:k for k,i in enumerate(ordering)}
    d = [0]*(len(ordering)+1)
    for row in relations:
        coords = [loc[j] for j in row]
        if len(coords)>1:
            d[min(coords)+1] += 1
            d[max(coords)+1] -= 1
    live = peak = 0
    for x in d:
        live += x
        peak = max(peak,live)
    return peak


def rank_interface_width(relations, ordering):
    """max rank(A_left)+rank(A_right)-rank(A), invariant under row changes."""
    n, r = len(ordering), len(relations)
    columns = [0]*n
    for j, row in enumerate(relations):
        for i in row:
            columns[i] ^= 1 << j

    def prefixes(indices):
        piv, scores = {}, [0]
        for i in indices:
            v = columns[i]
            while v:
                pivot = v.bit_length()-1
                if pivot in piv:
                    v ^= piv[pivot]
                else:
                    piv[pivot] = v
                    break
            scores.append(len(piv))
        return scores

    left = prefixes(ordering)
    right = list(reversed(prefixes(list(reversed(ordering)))))
    assert left[-1] == r == right[0]
    return max(a+b-r for a,b in zip(left,right))


def source_graph_rcm(rows, n):
    """Deterministic pseudo-peripheral reverse Cuthill-McKee ordering.

    Uses only the standard library on the syndrome-variable/metacheck
    bipartite graph. This is a heuristic, not an optimality proof.
    """
    r = len(rows)
    adjacent = [set() for _ in range(n+r)]
    for j, row in enumerate(rows):
        for i in row:
            adjacent[i].add(n+j)
            adjacent[n+j].add(i)
    remaining = set(range(n+r))
    output = []

    def layers(start):
        visited, levels = {start}, [[start]]
        while True:
            nxt = sorted(
                {u for v in levels[-1] for u in adjacent[v]
                 if u in remaining and u not in visited},
                key=lambda u:(len(adjacent[u]),u)
            )
            if not nxt:
                break
            levels.append(nxt)
            visited.update(nxt)
        return levels

    while remaining:
        seed = min(remaining, key=lambda v:(len(adjacent[v]),v))
        current, lev = seed, layers(seed)
        while True:
            candidate = min(lev[-1],key=lambda v:(len(adjacent[v]),v))
            nxt = layers(candidate)
            if len(nxt) <= len(lev):
                break
            current,lev = candidate,nxt
        visited, queue, bfs = {current}, deque([current]), []
        while queue:
            v = queue.popleft()
            bfs.append(v)
            for u in sorted(
                (u for u in adjacent[v] if u in remaining and u not in visited),
                key=lambda v:(len(adjacent[v]),v)
            ):
                visited.add(u)
                queue.append(u)
        remaining.difference_update(bfs)
        output.extend(reversed(bfs))
    return [v for v in output if v<n]


def record(c, stage, L):
    result = {"ell":2*L+1,"stage":stage,**summary(c)}
    for sector in ("X","Z"):
        cols, syndrome = error_columns(c,sector)
        relations = dependency_basis(cols,syndrome,c.q)
        natural = list(range(len(syndrome)))
        span = row_span_width(relations,natural)
        intrinsic = rank_interface_width(relations,natural)
        assert span >= intrinsic
        result[sector+"_dependency_rows"] = len(relations)
        result[sector+"_row_span_width"] = span
        result[sector+"_cut_interface_rank"] = intrinsic
        result[sector+"_max_relation_weight"] = max(map(len,relations),default=0)
        ordered = source_graph_rcm(relations,len(syndrome))
        result[sector+"_rcm_row_span_width"] = row_span_width(relations,ordered)
        result[sector+"_rcm_cut_interface_rank"] = rank_interface_width(relations,ordered)
    return result


EXPECTED = (
    {"qubits":60, "X_checks":24, "Z_checks":38,
     "X_syndrome_metachecks":3, "Z_syndrome_metachecks":0,
     "X_cut_interface_rank":3, "Z_cut_interface_rank":0},
    {"qubits":1336, "X_checks":840, "Z_checks":588,
     "X_syndrome_metachecks":3, "Z_syndrome_metachecks":90,
     "X_cut_interface_rank":3, "Z_cut_interface_rank":46, "Z_rcm_row_span_width":29, "Z_rcm_cut_interface_rank":29},
    {"qubits":140, "X_checks":60, "Z_checks":82,
     "X_syndrome_metachecks":3, "Z_syndrome_metachecks":0,
     "X_cut_interface_rank":3, "Z_cut_interface_rank":0},
    {"qubits":8144, "X_checks":4760, "Z_checks":3620,
     "X_syndrome_metachecks":3, "Z_syndrome_metachecks":234,
     "X_cut_interface_rank":3, "Z_cut_interface_rank":118, "Z_rcm_row_span_width":41, "Z_rcm_cut_interface_rank":39},
)


def audit():
    output = []
    for L in (1,2):
        first = replace_x(seed(),L)
        second = replace_z(first.tanner,L)
        output.extend((record(first,1,L),record(second,2,L)))
    for row,expected in zip(output,EXPECTED):
        assert row["logical_qubits"] == 1
        for key,value in expected.items():
            assert row[key]==value, (row["ell"],row["stage"],key,row[key],value)
    return output


if __name__ == "__main__":
    import json
    print(json.dumps(audit(),indent=2))
