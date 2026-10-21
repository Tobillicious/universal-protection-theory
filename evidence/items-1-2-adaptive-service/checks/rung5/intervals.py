"""Independent exact binary interval arithmetic; no floating point or source bound helpers.

An interval (l,h,e) denotes [l*2**e,h*2**e]. Every normalisation rounds outwards.
Positive rational powers use binary multiplication. exp(x) uses a rational Taylor enclosure after
scaling x to [0,1/2], followed by squaring. The optional tiny upper cap is an arithmetic ceiling,
not a positive physical failure floor.
"""
from dataclasses import dataclass
from fractions import Fraction as F
from functools import lru_cache
P=512
TINY=F(1,2**4096)

def _ceil_div(n,d):return -(-n//d)

@dataclass(frozen=True)
class I:
    l:int
    h:int
    e:int
    def __post_init__(self):assert 0<=self.l<=self.h
    @classmethod
    def bounds(cls,lo,hi=None):
        lo=F(lo);hi=lo if hi is None else F(hi);assert 0<=lo<=hi
        if hi==0:return cls(0,0,0)
        e=hi.numerator.bit_length()-hi.denominator.bit_length()-P+1
        def ratio(x):return (x.numerator,x.denominator<<e) if e>=0 else (x.numerator<<(-e),x.denominator)
        a,b=ratio(lo);c,d=ratio(hi)
        return cls(a//b,_ceil_div(c,d),e)
    def __mul__(self,other):
        l,h,e=self.l*other.l,self.h*other.h,self.e+other.e
        if not h:return I(0,0,0)
        shift=max(0,h.bit_length()-P)
        return I(l>>shift,_ceil_div(h,1<<shift),e+shift)
    def __pow__(self,n):
        assert type(n) is int and n>=0
        acc=I.bounds(1);base=self
        while n:
            if n&1:acc=acc*base
            n//=2
            if n:base=base*base
        return acc
    def fractions(self):
        if self.e>=0:return F(self.l<<self.e),F(self.h<<self.e)
        return F(self.l,1<<(-self.e)),F(self.h,1<<(-self.e))
    def probability_bounds(self):
        # Keep tiny analytical tails manageable without ever rounding an upper bound down to zero.
        if self.h==0:return F(0),F(0)
        if self.h.bit_length()-1+self.e < -4096:return F(0),TINY
        lo,hi=self.fractions();return min(F(1),lo),min(F(1),hi)

@lru_cache(None)
def power(x,n):return I.bounds(x)**n

@lru_cache(None)
def exp_interval(x):
    x=F(x);assert x>=0
    shift=0;y=x
    while y>F(1,2):y/=2;shift+=1
    term=total=F(1);terms=144
    for k in range(1,terms+1):term=term*y/k;total+=term
    omitted=term*y/(terms+1)
    tail=omitted/(1-y/F(terms+2))
    return I.bounds(total,total+tail)**(1<<shift)

def probability_product(*terms):
    value=I.bounds(1)
    for x in terms:value=value*x
    return value.probability_bounds()
