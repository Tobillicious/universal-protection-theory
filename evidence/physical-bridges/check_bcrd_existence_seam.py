#!/usr/bin/env python3
"""BCRD-native existence-first structural controls, NOT physical proof.

Checks faithful two-cut history embeddings and the IR132 exact decoder
criterion on small finite cuts; contrasts terminal activity with deletion
of the complete mathematical history.
"""
from itertools import product, permutations

def fiber_constant(boundary, logical):
    return all(
        boundary[i] != boundary[j] or logical[i] == logical[j]
        for i in range(len(boundary))
        for j in range(len(boundary))
    )

def exact_decoder(boundary, logical):
    return any(
        all(decoder[boundary[i]] == logical[i]
            for i in range(len(boundary)))
        for decoder in product((0, 1), repeat=2)
    )

count = {
    "embeddings": 0,
    "old_witnesses": 0,
    "boundary_pairs": 0,
    "decodable": 0,
    "not_decodable": 0
}

for n in range(1, 5):
    for boundary in product((0, 1), repeat=n):
        for logical in product((0, 1), repeat=n):
            correct = fiber_constant(boundary, logical)
            assert exact_decoder(boundary, logical) == correct
            count["boundary_pairs"] += 1
            count["decodable" if correct else "not_decodable"] += 1

# Two certified seam embeddings: H0 (2 events) -> H1 (3) -> H2 (4).
for f in permutations(range(3), 2):
    for g in permutations(range(4), 3):
        composite = tuple(g[f[i]] for i in range(2))
        assert len(set(composite)) == 2
        count["embeddings"] += 1
        for old_event in range(2):
            assert composite[old_event] in range(4)
            count["old_witnesses"] += 1

# Distinguish a mathematically existing record from a continuing process.
complete_history = ("birth", "termination")
activity_before = True
activity_after = False
assert complete_history and activity_before and not activity_after

# An internal map may be perfectly mathematical while noninjective;
# such a map does NOT qualify as an IR128 history-preserving seam.
constant_ender_map = (0, 0)
assert len(set(constant_ender_map)) < len(constant_ender_map)

expected = {
    "embeddings": 144,
    "old_witnesses": 288,
    "boundary_pairs": 340,
    "decodable": 104,
    "not_decodable": 236
}
assert count == expected, count
print("PASS 144 two-cut faithful embeddings and 288 old witnesses")
print("PASS 340 exact boundary/logical pairs: 104 decodable, 236 obstructed")
print("PASS noninjective internal ender control and terminal-activity model")
print("LIMIT no physical BCRD completeness, original-X3 or cosmic UPT proof")
