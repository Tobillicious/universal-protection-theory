"""O-4 finite existence and O-5 coordination protocol — exact, exhaustive (Python 3.9, Fractions, no randomness).
O-4  In every finite feasible family, for every standby option s there is an option maximal among those keeping
     everything s keeps; by guard_maximal_above (Lean) it is aligned and keeps all s keeps.
O-5  Joint choice among incomparable jointly maximal profiles M (|M| = m):
     commit-reveal lottery. Each of n agents commits to a k-bit value, then reveals; r = XOR of all values;
     accept r if r < m*floor(2^k/m), choose M[r mod m]; else repeat (rejection sampling).
     P1 If at least one agent's value is uniform and independent of the others (fixed in advance by
        commitment), r is exactly uniform whatever the others choose.
     P2 Conditional on acceptance, every profile in M has probability exactly 1/m (E1, impartial), and only
        jointly maximal profiles are ever chosen (U1).
     P3 Acceptance probability per round >= 1/2, so the protocol ends with probability 1.
     CONTROL Without commitment, a last revealer who sees the others can force any profile."""
from fractions import Fraction as F
from itertools import combinations, product
import json, sys
sys.dont_write_bytecode = True


def subsets(xs):
    xs = sorted(xs); return [frozenset(c) for r in range(len(xs) + 1) for c in combinations(xs, r)]


def o4():
    n = 0
    for size in (1, 2, 3):
        opts = subsets(range(size))
        for k in range(1, len(opts) + 1):
            for fam in combinations(opts, k):
                for s in fam:
                    above = [o for o in fam if o >= s]
                    m = [o for o in above if not any(p > o for p in above)]
                    assert m and all(not any(p > x for p in fam) and x >= s for x in m)
                    n += 1
    return {'family_standby_pairs': n, 'maximal_above_standby_exists_and_aligned': True}


def o5():
    rows = []; forced = 0
    for n_agents in (2, 3):
        for kbits in (2, 3):
            N = 2 ** kbits
            for honest in range(n_agents):
                for others in product(range(N), repeat=n_agents - 1):
                    counts = [0] * N
                    for v in range(N):                       # honest agent's uniform value
                        vals = list(others); vals.insert(honest, v)
                        r = 0
                        for x in vals: r ^= x
                        counts[r] += 1
                    assert all(c == 1 for c in counts)       # P1 exactly uniform
            for m in range(1, N + 1):
                cut = m * (N // m)
                probs = [F(sum(1 for r in range(cut) if r % m == j), cut) for j in range(m)]
                assert all(p == F(1, m) for p in probs)      # P2 exact impartiality
                assert F(cut, N) >= F(1, 2)                  # P3 acceptance >= 1/2
                # CONTROL: a last revealer without commitment picks its value after seeing the others
                for target in range(m):
                    for others in product(range(N), repeat=n_agents - 1):
                        acc = 0
                        for x in others: acc ^= x
                        assert any(((acc ^ v) < cut) and ((acc ^ v) % m == target) for v in range(N))
                        forced += 1
            rows.append({'agents': n_agents, 'bits': kbits})
    return {'settings': rows, 'P1_one_honest_agent_makes_draw_uniform': True,
            'P2_exact_1_over_m_among_jointly_maximal': True, 'P3_acceptance_at_least_half': True,
            'control_last_revealer_can_force_without_commitment': forced}


if __name__ == '__main__':
    print(json.dumps({'O4': o4(), 'O5': o5()}, sort_keys=True, indent=2))
