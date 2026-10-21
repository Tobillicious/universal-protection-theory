"""Exact host-block error convolution, independent of source polynomial/interval helpers.

Each host has seven jobs. A host shock makes all seven erroneous; otherwise its jobs have
independent error probability 1/10. Host blocks are independent under the declared joint law.
Only coefficients through degree 574 are retained; their complement gives both required tails.
"""
from fractions import Fraction as F
from functools import lru_cache
from math import comb
from .kernel import HOSTS,MT
PUBLISHED_Q=F(153588285,10**12)
NEXT_Q=F(153588286,10**12)

@lru_cache(None)
def error_tails(q):
    q=F(q);assert 0<=q<=1
    num,den=q.numerator,q.denominator
    weights=[(den-num)*comb(7,k)*9**(7-k) for k in range(8)]
    weights[7]+=num*10**7;scale=den*10**7;assert sum(weights)==scale
    coeff=[1]
    for _ in range(HOSTS):
        size=min(575,len(coeff)+7);nxt=[0]*size
        for i,a in enumerate(coeff):
            for j,w in enumerate(weights[:min(8,size-i)]):nxt[i+j]+=a*w
        coeff=nxt
    total=scale**HOSTS
    accept=F(total-sum(coeff[:574]),total)
    reject=F(total-sum(coeff[:575]),total)
    assert 0<=reject<=accept<=1
    return accept,reject

def committee(q,certificates):return certificates*MT*sum(error_tails(q))

def replace_committee(row,k,q):
    """Replace the committee entry, its reserve copy, and the same-host legacy quorum predicate."""
    from .kernel import COMMON,subset
    value=committee(q,4224 if k==2 else 4288)
    adjustment=MT*(subset(HOSTS,HOSTS-48,F(1,10)+F(9,10)*q)-subset(HOSTS,HOSTS-48,F(1,10)))
    low=dict(row['lower']);high=dict(row['upper'])
    for accounts in (low,high):
        accounts['committee_good_editions']=value
        accounts['quorum_liveness']+=adjustment
    reserve=COMMON+value
    return {'lower':low,'upper':high,'reserve':(reserve,reserve),
      'total':(sum(low.values())+reserve,sum(high.values())+reserve)}
