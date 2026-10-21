"""O-5 repaired (Codex N1): a joint lottery that a selective aborter cannot bias or stall. Exact, exhaustive.
Three agents, field Z_5. Each agent i draws a secret r_i and SECRET-SHARES it (Shamir, degree 1: f_i(x) = r_i + a_i x,
share f_i(j) to agent j) before anything is revealed. The draw is R = r_1 + r_2 + r_3 mod 5.
If any agent withholds its reveal, the other two reconstruct its secret from their shares (honest majority).
Checks:
 S1 secrecy  - one agent's share of an honest secret is uniform whatever the secret is;
 S2 recovery - any two shares reconstruct the secret (Lagrange over Z_5);
 S3 no bias  - for EVERY view the single adversary can hold (its shares of both honest secrets), the honest sum
               r_1 + r_2 is exactly uniform, so ANY adversary choice of r_3 (any function of its view) leaves R uniform;
 S4 no stall - a withheld reveal is reconstructed, so the output is the same as with full reveal (selective abort
               after seeing reveals changes nothing: R was fixed at sharing time);
 S5 choice   - with fresh secrets each round, rejection sampling gives each of m <= 5 options exactly 1/m;
 S6 agreement- options are indexed by ONE canonical sort; Codex's reversed-enumeration failure is reproduced and
               the canonical index removes it.
Two-party case: no protocol can be fully fair against aborts without an honest majority (Cleve 1986); cited, not
re-proved here."""
from itertools import product
from fractions import Fraction as F
import json, sys
sys.dont_write_bytecode = True
P = 5


def inv(a): return pow(a, P - 2, P)


def recon(x1, y1, x2, y2):                     # value at 0 of the line through (x1,y1),(x2,y2)
    return (y1 * x2 * inv((x2 - x1) % P) + y2 * x1 * inv((x1 - x2) % P)) % P


if __name__ == '__main__':
    for r in range(P):                                                       # S1
        for j in (1, 2, 3):
            counts = [0] * P
            for a in range(P): counts[(r + a * j) % P] += 1
            assert counts == [1] * P
    for r, a in product(range(P), repeat=2):                                 # S2
        f = lambda x: (r + a * x) % P
        for x1, x2 in ((1, 2), (1, 3), (2, 3)): assert recon(x1, f(x1), x2, f(x2)) == r
    views = {}
    for r1, a1, r2, a2 in product(range(P), repeat=4):                       # S3 (adversary = agent 3)
        v = ((r1 + 3 * a1) % P, (r2 + 3 * a2) % P)
        views.setdefault(v, [0] * P)[(r1 + r2) % P] += 1
    assert all(len(set(c)) == 1 for c in views.values())
    for r1, a1, r2, a2, r3, a3 in product(range(P), repeat=6):               # S4
        full = (r1 + r2 + r3) % P
        rec3 = recon(1, (r3 + a3) % P, 2, (r3 + 2 * a3) % P)
        assert (r1 + r2 + rec3) % P == full
    for m in range(1, P + 1):                                                # S5
        cut = m * (P // m)
        probs = [F(sum(1 for R in range(cut) if R % m == k), cut) for k in range(m)]
        assert all(q == F(1, m) for q in probs) and F(cut, P) >= F(1, 2)
    M = [(1, 1), (0, 0)]                                                     # S6 two jointly maximal profiles
    a_view, b_view = M, list(reversed(M))
    bad = (a_view[0][0], b_view[0][1])
    assert bad not in M                                                      # mismatched enumerations fail
    canon = sorted(M); assert (canon[0][0], sorted(M)[0][1]) in M            # one canonical sort agrees
    print(json.dumps({'S1_share_secrecy': True, 'S2_two_share_recovery': True,
                      'S3_no_bias_any_adversary_view': len(views), 'S4_withheld_reveal_reconstructed': True,
                      'S5_exact_1_over_m_fresh_rounds': True, 'S6_canonical_enumeration_agreement': True,
                      'two_party_fairness_limit': 'Cleve 1986 (cited)'}, sort_keys=True, indent=2))
