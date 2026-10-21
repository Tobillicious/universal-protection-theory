"""O-5 escrow, round 3 (Codex R4). Exact, exhaustive, Python 3.9, field Z_5, degree-1 Shamir (t = 1 cheater).
ROBUST RECOVERY at n = 3t + 1 = 4: shares at x = 1..4. For every secret and every polynomial, and for EVERY single
corrupted share (any position, any wrong value), there is exactly ONE degree-1 polynomial agreeing with >= 3 of the
4 shares, and it is the true one (unique decoding, as in Reed-Solomon / Berlekamp-Welch). Every opening is checked
against the decoded secret, so a false opening (Codex's attack: open -(r+s)) is rejected, not trusted.
CONTROL at n = 3 (honest majority only): with one corrupted share, two different polynomials each agree with 2 of
3 shares, so exact robust recovery is not determined (Codex's ambiguity), whence n >= 3t+1 for exact, or a stated
statistical error budget delta (Rabin-Ben-Or): the drawn option's distribution is then within total variation delta.
PRIVACY: one share of an honest secret is uniform whatever the secret.
TERMINATION: rejection sampling ends almost surely (geometric), not within a fixed number of rounds."""
from itertools import product
from fractions import Fraction as F
import json, sys
sys.dont_write_bytecode = True
P = 5


def poly(r, a, x): return (r + a * x) % P


def decode(shares, need):
    return [(r, a) for r, a in product(range(P), repeat=2)
            if sum(poly(r, a, x) == y for x, y in shares) >= need]


if __name__ == '__main__':
    cases4 = 0
    for r, a in product(range(P), repeat=2):
        true = [(x, poly(r, a, x)) for x in (1, 2, 3, 4)]
        assert decode(true, 3) == [(r, a)]
        for j in range(4):
            for w in range(P):
                if w == true[j][1]: continue
                bad = list(true); bad[j] = (bad[j][0], w)
                assert decode(bad, 3) == [(r, a)]                       # unique and correct
                cases4 += 1
                assert all(op == r for op in [decode(bad, 3)[0][0]])
    # a false opening is rejected: the decoded value differs from any false claim
    rejected = sum(1 for r, a in product(range(P), repeat=2) for false_open in range(P)
                   if false_open != r and decode([(x, poly(r, a, x)) for x in (1, 2, 3, 4)], 3)[0][0] != false_open)
    ambiguous3 = 0
    for r, a in product(range(P), repeat=2):
        true = [(x, poly(r, a, x)) for x in (1, 2, 3)]
        for j in range(3):
            for w in range(P):
                if w == true[j][1]: continue
                bad = list(true); bad[j] = (bad[j][0], w)
                if len(decode(bad, 2)) > 1: ambiguous3 += 1
    assert ambiguous3 > 0
    for s in range(P):                                                    # privacy of one share
        for x in (1, 2, 3, 4):
            cnt = [0] * P
            for a in range(P): cnt[poly(s, a, x)] += 1
            assert cnt == [1] * P
    m = 3; acc = F(m * (P // m), P); pend8 = (1 - acc) ** 8
    print(json.dumps({'n4_single_corruption_cases': cases4, 'n4_unique_correct_decoding': True,
                      'false_openings_rejected': rejected, 'n3_ambiguous_cases': ambiguous3,
                      'one_share_private': True, 'pending_after_8_rounds_m3': str(pend8),
                      'termination': 'almost sure, geometric; not bounded'}, sort_keys=True, indent=2))
