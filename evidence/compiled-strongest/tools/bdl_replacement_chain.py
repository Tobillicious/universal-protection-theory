#!/usr/bin/env python3
"""Source-derived BDL cellular R_X / R_Z replacements at finite test scales.

arXiv:2605.10943v1 §§2.2, 3.2.1–3.2.6, Eqs. (59)–(73).
The small subdivision values L=1,2 give algebraic test instances
(ell=2L+1=3,5); neither is certified as a geometrically valid
random-embedding parameter for the published physical theorem.
"""
from collections import Counter, defaultdict
from dataclasses import dataclass
from itertools import chain


def edge(a, b):
    assert a != b, (a, b)
    return tuple(sorted((a, b)))


def vertex(u):
    return ("v", u)


def mid(a, b, k, L):
    if k == 0:
        return vertex(a)
    if k == L:
        return vertex(b)
    ab = edge(a, b)
    return ("e", ab, k if a == ab[0] else L-k)


class Cells:
    def __init__(self):
        self.vertices = set()
        self.edges = {}
        self.faces = {}

    def addedge(self, a, b):
        self.vertices.update((a, b))
        e = edge(a, b)
        self.edges[e] = e
        return e

    def addface(self, fid, seq):
        assert len(seq) == 4 and fid not in self.faces
        ee = tuple(self.addedge(seq[i], seq[(i+1) % 4]) for i in range(4))
        self.faces[fid] = (tuple(seq), ee)


def point(f, i, j, L):
    x, q1, z, q2 = f
    if j == 0:
        return mid(x, q1, i, L)
    if i == L:
        return mid(q1, z, j, L)
    if j == L:
        return mid(q2, z, i, L)
    if i == 0:
        return mid(x, q2, j, L)
    return ("sq", f, i, j)


def y_x(old, x, L):
    y = Cells()
    for f in old.faces:
        if f[0] != x:
            continue
        for t in (0, 1):
            for i in range(L):
                for j in range(L):
                    y.addface(("bulk", f, i, j, t), [
                        (t, point(f, i, j, L)),
                        (t, point(f, i+1, j, L)),
                        (t, point(f, i+1, j+1, L)),
                        (t, point(f, i, j+1, L)),
                    ])
        _, q1, z, q2 = f
        for q in (q1, q2):
            for i in range(L):
                a, b = mid(q, z, i, L), mid(q, z, i+1, L)
                y.addface(("seam", f, q, i), [
                    (0, a), (0, b), (1, b), (1, a),
                ])
    return y


def y_q(old, q, L):
    y = Cells()
    for z in old.qz[q]:
        for t in (0, 1):
            for i in range(L):
                y.addedge(
                    (t, mid(q, z, i, L)),
                    (t, mid(q, z, i+1, L)),
                )
        y.addedge((0, vertex(z)), (1, vertex(z)))
    return y


@dataclass
class Tanner:
    xs: tuple
    qs: tuple
    zs: tuple
    faces: tuple  # each: (X-vertex, Q-vertex1, Z-vertex, Q-vertex2)

    def __post_init__(self):
        self.xq = defaultdict(set)
        self.qz = defaultdict(set)
        for x, q1, z, q2 in self.faces:
            assert x in self.xs and z in self.zs
            assert q1 in self.qs and q2 in self.qs and q1 != q2
            for q in (q1, q2):
                self.xq[x].add(q)
                self.qz[q].add(z)
        self.xq = {x: tuple(sorted(self.xq[x])) for x in self.xs}
        self.qz = {q: tuple(sorted(self.qz[q])) for q in self.qs}

    def dual(self):
        return Tanner(self.zs, self.qs, self.xs, tuple(
            (z, q1, x, q2) for x, q1, z, q2 in self.faces))


@dataclass
class Complex:
    x: tuple
    q: tuple
    z: tuple
    d0: dict
    d1: dict
    tanner: Tanner


def replace_x(old: Tanner, L: int):
    if L < 1:
        raise ValueError("L must be positive")
    xcells = {x: y_x(old, x, L) for x in old.xs}
    qcells = {q: y_q(old, q, L) for q in old.qs}
    c0 = [("xv", x, v)
          for x in old.xs for v in sorted(xcells[x].vertices)]
    c1 = [("xe", x, e)
          for x in old.xs for e in sorted(xcells[x].edges)] + [
          ("qv", q, v)
          for q in old.qs for v in sorted(qcells[q].vertices)]
    c2 = [("xf", x, fid)
          for x in old.xs for fid in sorted(xcells[x].faces)] + [
          ("qe", q, e)
          for q in old.qs for e in sorted(qcells[q].edges)] + [
          ("zv", z, t) for z in old.zs for t in (0, 1)]
    return _finish(old, xcells, qcells, c0, c1, c2)


def _finish(old, xc, qc, c0, c1, c2):
    d0 = {a: set() for a in c0}
    d1 = {b: set() for b in c1}
    for x, y in xc.items():
        for e, (u, v) in y.edges.items():
            d0[("xv", x, u)].add(("xe", x, e))
            d0[("xv", x, v)].add(("xe", x, e))
        for fid, (_, edges) in y.faces.items():
            for e in edges:
                d1[("xe", x, e)].add(("xf", x, fid))
        for q in old.xq[x]:
            sy = qc[q]
            for v in sy.vertices:
                assert v in y.vertices, ("restriction vertex absent", x, q, v)
                d0[("xv", x, v)].add(("qv", q, v))
            for e in sy.edges:
                assert e in y.edges, ("restriction edge absent", x, q, e)
                d1[("xe", x, e)].add(("qe", q, e))
    for q, y in qc.items():
        for e, (u, v) in y.edges.items():
            d1[("qv", q, u)].add(("qe", q, e))
            d1[("qv", q, v)].add(("qe", q, e))
        for z in old.qz[q]:
            for t in (0, 1):
                d1[("qv", q, (t, vertex(z)))].add(("zv", z, t))

    s1, s2 = set(c1), set(c2)
    assert all(qset <= s1 for qset in d0.values())
    assert all(zset <= s2 for zset in d1.values())
    for x, qset in d0.items():
        parity = set()
        for q in qset:
            parity.symmetric_difference_update(d1[q])
        assert not parity, ("d1 d0 != 0", x, parity)

    # Derive next Tanner squares from local cell flags, not an arbitrary
    # choice of pairing among overlapping X/Z stabilizers.
    faces = []
    for x, y in xc.items():
        for fid, (verts, edges) in y.faces.items():
            for v in verts:
                incident = [e for e in edges if v in e]
                assert len(incident) == 2
                faces.append((("xv", x, v), ("xe", x, incident[0]),
                              ("xf", x, fid), ("xe", x, incident[1])))
        for q in old.xq[x]:
            sy = qc[q]
            for e, (u, v) in sy.edges.items():
                assert e in y.edges
                for p in (u, v):
                    faces.append((("xv", x, p), ("xe", x, e),
                                  ("qe", q, e), ("qv", q, p)))
    for x, q1, z, q2 in old.faces:
        for t in (0, 1):
            v = (t, vertex(z))
            faces.append((("xv", x, v), ("qv", q1, v),
                          ("zv", z, t), ("qv", q2, v)))

    new = Tanner(tuple(c0), tuple(c1), tuple(c2), tuple(faces))
    assert len(new.faces) == len(set(new.faces))
    used = defaultdict(list)
    for x, q1, z, q2 in faces:
        used[(x, z)].extend((q1, q2))
    ztoqs = defaultdict(set)
    for q, zset in d1.items():
        for z in zset:
            ztoqs[z].add(q)
    for (x, z), qs in used.items():
        intersection = d0[x] & ztoqs[z]
        assert Counter(qs) == Counter(intersection), (
            "Tanner face-incidence coverage failed", x, z)
    for x in c0:
        for z in set(chain.from_iterable(d1[q] for q in d0[x])):
            assert (x, z) in used
    return Complex(tuple(c0), tuple(c1), tuple(c2), d0, d1, new)


def replace_z(old: Tanner, L: int):
    # The dual of the X replacement of the dual CSS cochain complex.
    swapped = replace_x(old.dual(), L)
    xx, qq, zz = swapped.z, swapped.q, swapped.x
    d0, d1 = {x: set() for x in xx}, {q: set() for q in qq}
    for q, xs in swapped.d1.items():
        for x in xs:
            d0[x].add(q)
    for z, qs in swapped.d0.items():
        for q in qs:
            d1[q].add(z)
    out = Complex(xx, qq, zz, d0, d1, swapped.tanner.dual())
    for x in xx:
        parity = set()
        for q in d0[x]:
            parity.symmetric_difference_update(d1[q])
        assert not parity
    return out


def rank(columns, rows):
    idx = {r: i for i, r in enumerate(rows)}
    pivots = {}
    for col in columns:
        v = 0
        for element in col:
            v ^= 1 << idx[element]
        while v:
            pivot = (v & -v).bit_length() - 1
            if pivot not in pivots:
                pivots[pivot] = v
                break
            v ^= pivots[pivot]
    return len(pivots)


def summary(c):
    r0 = rank(c.d0.values(), c.q)
    r1 = rank(c.d1.values(), c.z)
    return {
        "X_checks": len(c.x), "qubits": len(c.q),
        "Z_checks": len(c.z), "Tanner_squares": len(c.tanner.faces),
        "rank_d0": r0, "rank_d1": r1,
        "logical_qubits": len(c.q)-r0-r1,
        "X_syndrome_metachecks": len(c.z)-r1,
        "Z_syndrome_metachecks": len(c.x)-r0,
    }


def seed():
    return Tanner(("x0", "x1"),
                  ("q0", "q1", "q2", "q3", "q4"),
                  ("z0", "z1"),
                  (("x0", "q0", "z0", "q2"),
                   ("x0", "q1", "z1", "q2"),
                   ("x1", "q3", "z0", "q2"),
                   ("x1", "q4", "z1", "q2")))


def run(L=1):
    first = replace_x(seed(), L)
    second = replace_z(first.tanner, L)
    print("ell", 2*L+1, "level1", summary(first))
    print("ell", 2*L+1, "level2", summary(second))
    return first, second


if __name__ == "__main__":
    import sys
    run(int(sys.argv[1]) if len(sys.argv)>1 else 1)
