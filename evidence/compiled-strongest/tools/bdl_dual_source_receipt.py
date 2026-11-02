#!/usr/bin/env python3
"""Source-matched exact residual-dual Gibbs receipt for the finite BDL level 2.

Builds the COMPLETE physical syndrome parity kernel, not merely the
sphere/endpoint approximation; verifies an exact rational Z and a physical
bit marginal at fixed z=1/3. L=2 width measured but exact 2^31 table
materialization is deliberately NOT attempted.
"""
from fractions import Fraction
from hashlib import sha256

from bdl_replacement_chain import seed, replace_x, replace_z, edge, vertex
from bdl_local_spheres import sphere_blocks
from bdl_frontier_audit import error_columns, dependency_basis
from bdl_dual_bucket_exact import (
    validate, build_exact_factors, primal_graph, minfill_order,
    exact_bucket_sum, evidence_partition
)
from bdl_residual_junction_audit import measured_dual_graph, eliminated_width


def source_model(L):
    before = replace_x(seed(), L)
    after = replace_z(before.tanner, L)
    sites = tuple(after.x)
    where = {x: i for i, x in enumerate(sites)}
    blocks = [
        sum(1 << where[x] for x in row)
        for row in sphere_blocks(before, L)
    ]
    for x in before.x:
        vertical = edge((0, vertex(x)), (1, vertex(x)))
        row = {("zv",x,0), ("zv",x,1)} | {
            ("qe",q,vertical) for q in before.tanner.xq[x]
        }
        blocks.append(sum(1 << where[y] for y in row))
    cols, _ = error_columns(after, "Z")
    full = dependency_basis(cols, sites, after.q)
    full_masks = [sum(1 << i for i in row) for row in full]

    pivots = {}
    def retain(v):
        while v:
            p = v.bit_length() - 1
            if p in pivots:
                v ^= pivots[p]
            else:
                pivots[p] = v
                return True
        return False

    assert all(retain(b) for b in blocks)
    residual = [v for v in full_masks if retain(v)]
    for j, row in enumerate(residual):
        for b in blocks:
            if 2 * (row & b).bit_count() > b.bit_count():
                row ^= b
        residual[j] = row
    assert len(residual) == 16*L*L + 24*L + 4
    validate(len(sites), blocks, residual)
    return sites, blocks, residual


def digest(f):
    return sha256(f"{f.numerator}/{f.denominator}".encode()).hexdigest()


def audit():
    z = Fraction(1, 3)
    for L in (1, 2):
        sites, blocks, residual = source_model(L)
        factors, d = build_exact_factors(len(sites), blocks, residual, z)
        order = minfill_order(primal_graph(factors, d))
        actual = eliminated_width(primal_graph(factors, d), order)
        assert actual == {1: 16, 2: 30}[L]
        assert len(sites) == {1: 840, 2: 4760}[L]
        assert d == {1: 44, 2: 116}[L]

        if L == 1:
            total, width, entries = exact_bucket_sum(
                factors, d, order, max_width=16
            )
            Z = total / (1 << d)
            assert width == 16 and entries == 357758, (width,entries)
            assert digest(Z) == (
                "82311cad726376c992a38fe99c7bace54f9b1fd10c694590dacd7dd1360daaca"
            )
            Z1, _, _ = evidence_partition(
                len(sites), blocks, residual, z, {0: 1},
                order=order, max_width=16
            )
            Z0, _, _ = evidence_partition(
                len(sites), blocks, residual, z, {0: 0},
                order=order, max_width=16
            )
            assert Z0 + Z1 == Z
            p = Z1 / Z
            assert digest(p) == (
                "f7162bc6c26ae696ac4e8cc3fc6725914567950ac762dfd7dfa94e60312e4805"
            )
            print("L1 complete full-syndrome exact rational partition:"
                  " bits=840 metachecks=90 width=16"
                  f" table_entries={entries} Z_sha256={digest(Z)}"
                  f" P(sigma_0=1)={float(p):.12f}"
                  " EXACT P0+P1=1 PASS")
        else:
            # The verified width 30 implies a table with up to 2^31
            # entries. Don't imply this graph has been exactly summed.
            print("L2 source-verified complete dual graph:"
                  f" physical_bits={len(sites)} residual={d}"
                  f" width={actual} Z_NOT_EVALUATED")

    print("BDL finite source exact full Gibbs Z and conditional marginal: PASS")


if __name__ == "__main__":
    audit()
