"""Outward dyadic enclosures, using integers and Fractions only.

Large pooled powers are never evaluated through floating point or logarithms.
Each enclosure is an exact rational inequality. Tiny positive upper bounds are
retained; no risk account is set to zero through numerical underflow.
"""
from fractions import Fraction as F

BITS = 256
UNIT = 1 << BITS
FLOOR_EXPONENT = -2048


def ceildiv(n, d):
    return -(-n // d)


class Bound:
    __slots__ = ('lo', 'hi', 'exponent')

    def __init__(self, lo, hi, exponent=0):
        assert 0 <= lo <= hi
        if hi == 0:
            self.lo = self.hi = self.exponent = 0
            return
        shift = max(0, hi.bit_length() - BITS - 1)
        if shift:
            lo >>= shift
            hi = ceildiv(hi, 1 << shift)
            exponent += shift
        while hi > 2 * UNIT:
            lo //= 2
            hi = ceildiv(hi, 2)
            exponent += 1
        self.lo, self.hi, self.exponent = lo, hi, exponent

    @classmethod
    def of(cls, value):
        value = F(value)
        assert value >= 0
        if value == 0:
            return cls(0, 0)
        e = value.numerator.bit_length() - value.denominator.bit_length()
        # Bring the rational mantissa into [1,2).
        scale = F(1 << e) if e >= 0 else F(1, 1 << -e)
        if value < scale:
            e -= 1
            scale /= 2
        v = value / scale * UNIT
        return cls(v.numerator // v.denominator,
                   ceildiv(v.numerator, v.denominator), e)

    def __mul__(self, other):
        if not isinstance(other, Bound):
            other = Bound.of(other)
        return Bound(self.lo * other.lo // UNIT,
                     ceildiv(self.hi * other.hi, UNIT),
                     self.exponent + other.exponent)

    def __pow__(self, n):
        assert n >= 0
        answer, base = Bound.of(1), self
        while n:
            if n & 1:
                answer = answer * base
            n //= 2
            if n:
                base = base * base
        return answer

    def shift(self, e):
        return Bound(self.lo, self.hi, self.exponent + e)

    def fractions(self):
        if self.hi == 0:
            return F(0), F(0)
        if self.exponent < FLOOR_EXPONENT:
            return F(0), F(1, 1 << (-FLOOR_EXPONENT - 1))
        scale = (F(1 << self.exponent, UNIT) if self.exponent >= 0
                 else F(1, UNIT << -self.exponent))
        return self.lo * scale, self.hi * scale


def power(base, exponent):
    return Bound.of(base) ** exponent


def exp_majorant(x):
    """exp(x) <= (2129/2000)^ceil(16*x), x>=0."""
    x = F(x)
    assert x >= 0
    n = ceildiv(16 * x.numerator, x.denominator)
    return power(F(2129, 2000), n)


def upper(value):
    return value.fractions()[1]


def lower(value):
    return value.fractions()[0]
