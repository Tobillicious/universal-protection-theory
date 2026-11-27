"""Independent exhaustive check of the finite abstraction, not ProB output."""
from itertools import permutations
from collections import deque
from fractions import Fraction
D = (1 << 6) - 1
AUTH = 1 << 1
swap = (0, 2, 1, 3)
local = (0, 0, 1, 1)

def check_graph(mutant=False):
    init=(2,0,False); todo=deque([init]); seen={init}; edges=0; bad=None
    parent={init:None}
    while todo:
        s=todo.popleft(); cell, mask, committed=s
        if committed and mask != D and bad is None:
            bad=s
        nxt=[(f'Stage({d})',(cell,d,False)) for d in range(64)] + [('Hold',s)]
        if mask == (D ^ AUTH if mutant else D):
            nxt.append(('Commit',(swap[cell],mask,True)))
        for op,t in nxt:
            edges+=1
            if t not in seen:
                seen.add(t); parent[t]=(s,op); todo.append(t)
    trace=[]
    if bad is not None:
        t=bad
        while parent[t] is not None:
            t0,op=parent[t]; trace.append((op,t)); t=t0
        trace.reverse()
    return len(seen),edges,bad,trace

safe=check_graph(); mutant=check_graph(True)
assert safe[2] is None and mutant[2] is not None
print('SAFE reachable states, edges, violation:',safe[:3])
print('MUTANT reachable states, edges, violation:',mutant[:3])
print('MUTANT shortest trace:',mutant[3])
# All 4x4 permutation unitaries, tested exactly on classical basis records.
# A system bit is recoverable from the first output bit iff disjoint images
# of the two input-bit classes are observable.
ps=list(permutations(range(4)))
local_ok=0
for p in ps:
    assert len(set(p))==4
    a={local[p[i]] for i in (0,1)}
    b={local[p[i]] for i in (2,3)}
    local_ok+=not bool(a&b)
assert local_ok==8
print('Permutation unitaries:',len(ps),'; local bit recoverable:',local_ok,'; local loss:',len(ps)-local_ok)
# Explicit classical input pairs |00> and |10> with environment |0>.
assert swap[0]!=swap[2] and local[swap[0]]==local[swap[2]]
print('SWAP: globally distinct, locally identical')
print('PASS (Python finite abstraction only; not a Lean or ProB replay)')
