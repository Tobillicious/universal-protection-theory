from fractions import Fraction
import sympy as s
from itertools import product
I=s.eye(2); X=s.Matrix([[0,1],[1,0]]); Y=s.Matrix([[0,-s.I],[s.I,0]]); Z=s.diag(1,-1)
P=[I,X,Y,Z]; K=s.kronecker_product
q=s.Rational(3,4)
weights=[1-3*q/4,q/4,q/4,q/4]
assert sum(weights)==1 and all(w>=0 for w in weights)
def simplify(a): return a.applyfunc(s.simplify)
def channel(a): return simplify(sum((w*K(I,p)*a*K(I,p).H for w,p in zip(weights,P)),s.zeros(4)))
def marginal(a): return s.Matrix(2,2,lambda i,j:sum(a[2*i+k,2*j+k] for k in range(2)))
def target(a): return K(marginal(a),I/2)
# Verify linear identity on the entire complex matrix space, not selected states.
for i,j in product(range(4),repeat=2):
    a=s.zeros(4);a[i,j]=1
    assert channel(a)==(1-q)*a+q*target(a)
    assert marginal(channel(a))==marginal(a)
    assert channel(target(a))==target(a)
    assert channel(channel(a))-target(a)==(1-q)**2*(a-target(a))
print('PASS: exact channel, marginal preservation, fixed-point identity and two-step scaling on all 16 matrix units')
# A four-dimensional classical control implements a global controlled-Pauli unitary.
U=s.diag(*[K(I,p) for p in P]); assert simplify(U.H*U)==s.eye(16)
print('PASS: 16-dimensional controlled-Pauli unitary dilation (fresh classical register)')
# All initial choices and all reachable states of the B abstraction.
def verify(mutant=False):
    initial={(p,w,w,0,0) for p,w in product(range(2),repeat=2)}
    seen=set(initial); todo=list(initial); edges=0; violations=[]
    while todo:
        t=todo.pop();p,i,w,r,u=t
        if not ((u==0 and r==0 and w==i) or (u==1 and w==0 and r==i)): violations.append(t)
        nxt=(p,i,0,0,1) if (u==0 and mutant) else (p,i,r,w,1) if u==0 else t
        edges+=1
        if nxt not in seen: seen.add(nxt);todo.append(nxt)
    return len(seen),edges,violations
safe=verify(); bad=verify(True)
assert safe==(8,8,[]) and len(bad[2])==2
print('PASS: record-preserving model:',safe)
print('PASS: destructive-reset mutant detected:',bad)
