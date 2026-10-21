"""Rational bounds for clustered corruption occupancy, not Poisson shape.

Life L=28+Geom(1/2) has mean30. Each individual broadcasts at rate s
while alive. A broadcast creates Binomial(A,1/A) recruits. A=1 is ordinary
one-at-a-time recruitment. Root immigration has intensity lambda.

For a whole immigrant family, let T be progeny and W its total person-time.
The family's active duration is <=W; pessimistically retain all T members
for W dates. Poisson immigrant families then give a compound-Poisson
stationary upper process with Levy weights lambda E[W;T=k]. An edition
window adds two dates: weights lambda E[W+2;T=k]. Starting empty is smaller.
Dwass's cyclic lemma gives the finite coefficients below, including the
correlation of lifetime with offspring. No float or independent-Poisson
occupancy approximation is used in this bound.
"""
from fractions import Fraction as F
from functools import lru_cache
from math import comb, factorial

K=25
LAMBDA=F(1,500000)
DEN=1<<640


def outward(lo,hi=None):
    if hi is None:hi=lo
    low=(F(lo)*DEN).numerator//(F(lo)*DEN).denominator
    v=F(hi)*DEN
    high=-(-v.numerator//v.denominator)
    return F(low,DEN),F(high,DEN)


@lru_cache(None)
def moments(k,n):
    # W=sum_{i=1}^k L_i =29k + NB(k,1/2) failures. Its falling-factorial
    # moments are rising(k,r); convert through Stirling numbers.
    stir=[[0]*(n+1) for _ in range(n+1)]
    stir[0][0]=1
    for j in range(1,n+1):
        for r in range(1,j+1):stir[j][r]=stir[j-1][r-1]+r*stir[j-1][r]
    rising=[1]
    for r in range(1,n+1):rising.append(rising[-1]*(k+r-1))
    raw_y=[sum(stir[j][r]*rising[r] for r in range(j+1)) for j in range(n+1)]
    return tuple(sum(comb(j,r)*(29*k)**(j-r)*raw_y[r] for r in range(j+1)) for j in range(n+1))


@lru_cache(None)
def batch_coefficients(A):
    q=F(1,A)
    g=[F(comb(A,j))*q**j*(1-q)**(A-j) if j<=A else F(0) for j in range(K)]
    g0=g[0]
    g[0]=F(0)
    polys=[[F(1)]+[F(0)]*(K-1)]
    for b in range(1,K):
        prev=polys[-1]
        polys.append([sum(prev[j-i]*g[i] for i in range(1,j+1)) for j in range(K)])
    return g0,tuple(tuple(p) for p in polys)


def exp_negative_interval(x,n=48):
    assert x>=0 and n%2==0
    term=F(1);total=term
    for j in range(1,n+1):
        term*=-x/j;total+=term
    lower=total+term*(-x)/(n+1)
    return outward(max(F(0),lower),min(F(1),total))


@lru_cache(None)
def family_coefficients(s,A=1):
    s=F(s)
    assert 0<=30*s<1
    g0,polys=batch_coefficients(A)
    a=s*(1-g0)
    order=8 if s<F(1,10**20) else 40
    powers=[F(1)]
    for j in range(1,order+2):powers.append(powers[-1]*(-a)/j)
    # P(T=k)=(1/k) P(sum offspring of k virtual individuals=k-1).
    # E[W;T=k]=(1/k) E[W 1(sum offspring=k-1)]. Both lifetimes and
    # compound-Poisson count marks are cyclically exchangeable.
    pp=[(F(0),F(0))]
    ww=[(F(0),F(0))]
    for k in range(1,K):
        raw=moments(k,k+order+2)
        def mixed(r):
            up=sum(powers[j]*raw[r+j] for j in range(order+1))
            lo=up+powers[order+1]*raw[r+order+1]
            return max(F(0),lo),min(F(raw[r]),up)
        pl=pu=wl=wu=F(0)
        for b in range(k):
            coef=polys[b][k-1]
            if not coef:continue
            multiplier=coef*s**b/factorial(b)/k
            l,u=mixed(b);pl+=multiplier*l;pu+=multiplier*u
            l,u=mixed(b+1);wl+=multiplier*l;wu+=multiplier*u
        pp.append(outward(pl,min(F(1),pu)))
        ww.append(outward(wl,wu))
    family_tail=(max(F(0),1-sum(p[1] for p in pp)),min(F(1),1-sum(p[0] for p in pp)))
    return tuple(pp),tuple(ww),family_tail


def compound_tails(total_rate,weights):
    # Exactly P(Y>=c)=1-exp(-nu_total)*sum_{j<c} coefficient_j exp(sum nu_k z^k).
    # The tail includes every k>=25 without needing their individual weights.
    tl,tu=outward(total_rate)
    el=exp_negative_interval(tu)[0]
    eu=exp_negative_interval(tl)[1]
    cl=[F(1)];cu=[F(1)]
    for j in range(1,K):
        l=sum(k*weights[k][0]*cl[j-k] for k in range(1,j+1))/j
        u=sum(k*weights[k][1]*cu[j-k] for k in range(1,j+1))/j
        l,u=outward(l,u)
        cl.append(l);cu.append(u)
    tails=[(F(1),F(1))]
    sl=su=F(0)
    for c in range(1,K+1):
        sl+=cl[c-1];su+=cu[c-1]
        tails.append((max(F(0),1-eu*su),min(F(1),max(F(0),1-el*sl))))
    return tuple(tails)


@lru_cache(None)
def law(s,A=1,scale=1):
    s=F(s)
    pp,ww,family_tail=family_coefficients(s,A)
    lam=scale*LAMBDA
    mean_life_family=F(30)/(1-30*s)
    weights=[(F(0),F(0))]+[outward(lam*l,lam*u) for l,u in ww[1:]]
    edition=[(F(0),F(0))]+[outward(lam*(ww[k][0]+2*pp[k][0]),lam*(ww[k][1]+2*pp[k][1])) for k in range(1,K)]
    current=compound_tails(lam*mean_life_family,weights)
    boundary=compound_tails(lam*(mean_life_family+2),edition)
    return {'current':current,'edition':boundary,'family_tail':family_tail,
            'mean_actual':lam*30/(1-30*s),'edition_mean_actual':lam*32/(1-30*s),
            'dominating_cluster_rate':lam*mean_life_family,
            'dominating_edition_cluster_rate':lam*(mean_life_family+2)}


def poisson_comparison(s,scale=1):
    f=1/(1-30*F(s))
    return ((scale*30*LAMBDA*f)**25/factorial(25),
            (scale*32*LAMBDA*f)**25/factorial(25))
