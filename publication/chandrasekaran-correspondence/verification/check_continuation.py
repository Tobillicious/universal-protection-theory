from itertools import product
from collections import deque

# Greatest fixed point of safe, serial, universally closed states.
def greatest(states, step, safe):
    X=set(states); sizes=[len(X)]
    while True:
        Y={s for s in states if safe(s) and step(s) and set(step(s)) <= X}
        sizes.append(len(Y))
        if Y==X: return X,sizes
        assert Y<=X
        X=Y

states=list(product(range(2),range(2),range(3),range(2))) # history, initial, phase, policy
initials={(h,h,0,0) for h in range(2)}
def step(s, mutant=False):
    h,i,p,g=s
    return {(h,i,p,1), ((0 if mutant and p==2 else h),i,(p+1)%3,g)}
def safe(s): return s[0]==s[1]
def reachable(mutant):
    seen=set(initials); q=deque(initials); edges=0
    while q:
        s=q.popleft()
        for t in step(s,mutant):
            edges+=1
            if t not in seen: seen.add(t);q.append(t)
    return seen,edges
for mutant in (False,True):
    G,sizes=greatest(states,lambda s: step(s,mutant),safe)
    R,e=reachable(mutant); bad={s for s in R if not safe(s)}
    print(f"{'erasure mutant' if mutant else 'guarded'}: G sizes {sizes}; reachable={len(R)}; edges={e}; violations={len(bad)}; initial in G={len(initials&G)}/{len(initials)}")
    assert bool(bad)==mutant
    assert len(initials&G)==(1 if mutant else 2)
    if not mutant:
        assert any(s[0]==0 for s in G) and any(s[0]==1 for s in G)
# reversible global permutation that enters a geometry labelled collapsed
S=list(product(range(2),range(2))) # history, geometry (0 expanded, 1 collapsed)
T=lambda s:(s[0],1-s[1])
assert len({T(s) for s in S})==len(S)
assert all(T(T(s))==s for s in S)
assert T((1,0))==(1,1)
G,sizes=greatest(S,lambda s:{T(s)},lambda s:s[1]==0)
assert not G
print('reversible geometry control: bijective; collapsed label reachable; greatest expanded-only invariant is empty')
# Approximate reversible-chain distance obstruction by exact Hamming distances.
D=lambda a,b:sum(x!=y for x,y in zip(a,b))
for a,b in product(S,repeat=2):
    assert D(T(a),T(b))==D(a,b)
    for c in S: assert D(a,b)<=D(T(a),c)+D(T(b),c)
print('all 16 pairs / 64 center triples: exact distance preservation and no-common-center bound PASS')
