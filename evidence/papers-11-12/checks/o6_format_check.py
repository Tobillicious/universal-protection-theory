"""O-6 repaired (Codex N4): a COMPLETE self-delimiting binary archive format. Exact, exhaustive (Python 3.9).
Chunks are fixed-width c-bit codes; the chunk alphabet MUST have size <= 2^c (checked).
Integers n >= 0 are written as Elias-gamma(n+1) (prefix-free).
archive(R) = mode bit + gamma(#records) + gamma(len) per record + payload, where
   mode 0 (separate):   every chunk of every record, c bits each;
   mode 1 (dictionary): gamma(u), the u distinct chunks (sorted) c bits each, then each reference in
                        b = max(1, ceil(log2 u)) bits.
The encoder picks the cheaper mode; the mode bit makes BOTH choices one decodable code.
Checks over every record set in each domain: F1 exact round trip (order, repetition, duplicates, positions);
F2 prefix-free (no codeword is a prefix of another), so F3 the Kraft sum is <= 1 (exact);
F4 exact length = 1 + header + min(separate payload, dictionary payload), every bit counted."""
from fractions import Fraction as F
from itertools import product
import json, sys
sys.dont_write_bytecode = True


def gamma(n):                       # n >= 1
    b = format(n, 'b'); return '0' * (len(b) - 1) + b


def ungamma(s, i):
    z = 0
    while s[i] == '0': z += 1; i += 1
    return int(s[i:i + z + 1], 2), i + z + 1


def bw(u): return max(1, (u - 1).bit_length()) if u > 1 else 1


def encode(R, c, mode=None):
    hdr = gamma(len(R) + 1) + ''.join(gamma(len(r) + 1) for r in R)
    sep = ''.join(format(x, '0%db' % c) for r in R for x in r)
    store = sorted({x for r in R for x in r}); u = len(store); b = bw(u)
    idx = {x: k for k, x in enumerate(store)}
    dic = gamma(u + 1) + ''.join(format(x, '0%db' % c) for x in store) + \
        ''.join(format(idx[x], '0%db' % b) for r in R for x in r)
    if mode is None: mode = 0 if len(sep) <= len(dic) else 1
    return ('0' + hdr + sep) if mode == 0 else ('1' + hdr + dic), len(hdr), len(sep), len(dic)


def decode(s, c):
    mode = s[0]; i = 1
    n, i = ungamma(s, i); n -= 1
    lens = []
    for _ in range(n):
        l, i = ungamma(s, i); lens.append(l - 1)
    if mode == '0':
        R = []
        for l in lens:
            R.append(tuple(int(s[i + k * c:i + (k + 1) * c], 2) for k in range(l))); i += l * c
        return R, i
    u, i = ungamma(s, i); u -= 1
    store = [int(s[i + k * c:i + (k + 1) * c], 2) for k in range(u)]; i += u * c; b = bw(u)
    R = []
    for l in lens:
        R.append(tuple(store[int(s[i + k * b:i + (k + 1) * b], 2)] for k in range(l))); i += l * b
    return R, i


def domain(alpha, maxlen, maxrec):
    recs = [tuple(t) for l in range(maxlen + 1) for t in product(range(alpha), repeat=l)]
    for n in range(maxrec + 1):
        for R in product(recs, repeat=n): yield list(R)


if __name__ == '__main__':
    out = {}
    for c, alpha, maxlen, maxrec in ((2, 4, 3, 2), (3, 5, 2, 2), (1, 2, 3, 2)):
        assert alpha <= 2 ** c                                            # alphabet fits the chunk code
        words = []; joint_cheaper = 0
        for R in domain(alpha, maxlen, maxrec):
            s, h, ls, ld = encode(R, c)
            R2, end = decode(s, c)
            assert R2 == R and end == len(s)                              # F1
            assert len(s) == 1 + h + min(ls, ld)                          # F4
            if ld < ls: joint_cheaper += 1
            words.append(s)
        ws = sorted(words)
        assert len(set(ws)) == len(ws)
        assert all(not ws[k + 1].startswith(ws[k]) for k in range(len(ws) - 1))   # F2
        kraft = sum(F(1, 2 ** len(w)) for w in ws); assert kraft <= 1     # F3
        out['c%d_alpha%d' % (c, alpha)] = {'record_sets': len(ws), 'dictionary_chosen': joint_cheaper,
                                           'kraft_sum_leq_1': True}
    print(json.dumps({'domains': out, 'F1_exact_round_trip': True, 'F2_prefix_free': True,
                      'F3_kraft': True, 'F4_every_bit_counted': True}, sort_keys=True, indent=2))
