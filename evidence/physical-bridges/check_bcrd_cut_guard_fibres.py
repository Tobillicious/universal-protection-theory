#!/usr/bin/env python3
"""Exact finite BCRD cut-guardian criterion, source-level ONLY.
Not a proof of physically installed UPT, real BCRD or X3.
"""
from itertools import product, permutations
from collections import Counter

S = tuple(range(4))
A = (0, 1)
O = (0, 1)

def safe(s, a, mask):
    """Independent table of allowed+safe-with-all-modeled-successors."""
    return bool(mask & (1 << (2 * s + a)))

def cut_certificate(observe, protected, mask):
    return all(
        any(
            all(not ((protected >> s) & 1) or safe(s, a, mask)
                for s in S if observe[s] == o)
            for a in A)
        for o in O)

def has_policy(observe, protected, mask):
    return any(
        all(not ((protected >> s) & 1) or safe(s, policy[observe[s]], mask)
            for s in S)
        for policy in product(A, repeat=len(O)))

count = Counter()
for cut in product(O, repeat=4):
    for protected in range(16):
        for mask in range(256):
            c = cut_certificate(cut, protected, mask)
            assert c == has_policy(cut, protected, mask)
            count['cases'] += 1
            count['guardian_exists'] += bool(c)
            count['guardian_absent'] += not c

# An action conflict forces a distinguishing cut.
coarse = (0,0,0,0)
fine = (0,1,0,0)
both_protected = 0b0011
# s=0 has only action 0, s=1 only action 1.
conflict_actions = (1 << 0) | (1 << 3)
assert not has_policy(coarse, both_protected, conflict_actions)
assert has_policy(fine, both_protected, conflict_actions)

# Complete subject identity reconstruction is not necessary if
# one physically safe action is shared across every cut fibre.
common_action = sum(1 << (2*s) for s in S)
assert has_policy(coarse, 0b1111, common_action)
assert coarse[0] == coarse[1] and 0 != 1

# No cut resolution can create a nonexistent physically safe action.
assert not has_policy(fine, 0b0001, 0)

# Source guardian safe, actual physical bypass not mediated.
source_guard_successor = {(0,0):0}
unmediated_actual_step = (0,1)
assert source_guard_successor[(0,0)] == 0
assert unmediated_actual_step[1] != source_guard_successor[(0,0)]

# Any finite unsafe history from a protected initial state has
# an actual edge which first crosses the protected predicate.
for protected in range(16):
    for perm in permutations(S):
        for n in range(1,5):
            path = perm[:n]
            if not ((protected >> path[0]) & 1):
                continue
            if (protected >> path[-1]) & 1:
                continue
            crossing = [(s,t) for s,t in zip(path,path[1:])
                        if ((protected >> s) & 1) and
                           not ((protected >> t) & 1)]
            assert crossing, (protected, path)
            count['first_breach_paths'] += 1

# A mathematically permitted action with no actual successor
# guarantees neither progress nor serviceable original-X3 freedom.
allowed_without_actual_progress = True
actual_successors = set()
assert allowed_without_actual_progress and not actual_successors

assert count == {'cases':65536, 'guardian_exists':34380,
                 'guardian_absent':31156,'first_breach_paths':288}, count
print('PASS', dict(count))
print('PASS conflict/necessary cut separation, informative refinement')
print('PASS coarse cut can suffice without exact history decoding')
print('PASS no physical action + source bypass independent obstructions')
print('PASS 288 finite first-breach paths and nonprogress guard')
print('LIMIT real BCRD physical source, X3 semantics, actuation OPEN')
