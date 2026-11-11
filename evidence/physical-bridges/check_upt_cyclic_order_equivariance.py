#!/usr/bin/env python3
"""UPT four-stage orientation equivariance: finite exact diagnostic, not cosmology."""
from itertools import product

def subsets(domain):
    return tuple(frozenset(x for i, x in enumerate(domain) if mask & (1 << i))
                 for mask in range(1 << len(domain)))

def stages(domain):
    return tuple((life, free) for life in subsets(domain)
                 for free in subsets(domain) if free <= life)

def strictly_better(a, b):
    """True iff b strictly improves a in the first unequal UPT stage."""
    for x, y in zip(a, b):
        if x != y:
            return x < y
    return False

def relabel(o, swap_existing, swap_new):
    def rho(x):
        if swap_existing and x in (0, 1):
            return 1 - x
        if swap_new and x in (2, 3):
            return 5 - x
        return x
    return tuple(frozenset(map(rho, stage)) for stage in o)

def verify():
    options = tuple((*a, *b) for a, b in product(stages((0, 1)), stages((2, 3))))
    assert len(options) == 81
    checked = 0
    for sw_e, sw_n in product((False, True), repeat=2):
        converted = {o: relabel(o, sw_e, sw_n) for o in options}
        assert len(set(converted.values())) == 81
        for a, b in product(options, repeat=2):
            ca, cb = converted[a], converted[b]
            assert strictly_better(a, b) == strictly_better(ca, cb)
            assert strictly_better(b, a) == strictly_better(cb, ca)
            checked += 1
    assert checked == 26244

    # Distinguish exterior cyclic closure from the selection of protection.
    # This is only a finite logical independence example.
    def circuit(action):
        x = 0
        y = 1 - x
        z = 1 - y
        continued = frozenset({'a'}) if action == 'keep' else frozenset()
        return (x, y, z), continued
    keeper, alive = circuit('keep')
    eraser, ended = circuit('end')
    assert keeper == eraser == (0, 1, 0)
    assert ended < alive
    assert eraser[0] == eraser[2]
    print(f"PASS: {checked} orientation/order comparisons, 81 outcomes and 4 relabelings")
    print("PASS: finite cyclic exterior does not alone force protection-aligned action")
    print("LIMIT: not a source-derived physical BCRD seam, selection law or cosmic proof")

if __name__ == "__main__":
    verify()
