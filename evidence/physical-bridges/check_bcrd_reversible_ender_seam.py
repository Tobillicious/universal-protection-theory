#!/usr/bin/env python3
"""Finite BCRD-style source checks; not a proof of BCRD B7 cosmology or UPT.

Two-site classical relational cut: activity bits and exactly conserved ledger
charge. Physical transitions are action-labelled mathematical maps.
"""
from itertools import product
from collections import Counter

S = tuple(product((0,1), repeat=3))  # x-active, y-active, ledger charge
A = ('idle','halt_x','halt_y','flip_x','flip_y','relay')

def step(s,a):
    x,y,q=s
    if a=='idle': return s
    if a=='halt_x': return (0,y,q)
    if a=='halt_y': return (x,0,q)
    if a=='flip_x': return (1-x,y,q)
    if a=='flip_y': return (x,1-y,q)
    if a=='relay': return (x, y*(1-x),q)
    raise ValueError(a)

def run(s,word):
    for a in word:s=step(s,a)
    return s

def read_cut(s): return s
def reconstructed_ledger(s): return read_cut(s)[2]
def response_graph(s):
    # Operational source graph, derived from intervention response.
    return {(0,1)} if step(s,'relay')!=step(s,'idle') else set()

checks=Counter()
for s in S:
    # B1 analogue: exact boundary state determines every future word.
    for n in range(5):
        for word in product(A,repeat=n):
            assert run(s,word)==run(read_cut(s),word)
            checks['future_word_sufficiency']+=1
    # B2: the conserved charge is transported in each full cut.
    assert reconstructed_ledger(s)==s[2]
    for a in A:
        assert step(s,a)[2]==s[2]
        checks['ledger_step']+=1
    # B3: causal effect is computed from fixed action response.
    assert response_graph(s)==({(0,1)} if s[0] and s[1] else set())
    # B4: no hidden physical distinction escapes the full cut.
    assert all(read_cut(s)!=read_cut(t) for t in S if t!=s)
    checks['cut_separation']+=1
    # B5: associative exact sequential process composition.
    for a,b,c in product(A,repeat=3):
        assert step(step(step(s,a),b),c)==run(s,(a,b,c))
        checks['composition_triples']+=1
    # B6: only independent events are required to commute.
    for a in ('halt_x','flip_x'):
        for b in ('halt_y','flip_y'):
            assert run(s,(a,b))==run(s,(b,a))
            checks['independent_diamonds']+=1
    # A reversible source transformation need not preserve activity.
    assert run(s,('flip_x','flip_x'))==s
    assert run(s,('flip_y','flip_y'))==s
    checks['reversible_steps']+=2

assert response_graph((1,1,0))=={(0,1)}
assert response_graph((0,1,0))==set()
assert response_graph((1,0,0))==set()
assert len(set(repr(response_graph(s)) for s in S))==2

original=(1,1,1)
result=step(original,'flip_x')
assert result==(0,1,1) and result!=original
assert step(result,'flip_x')==original
assert read_cut(result)!=read_cut(original)
history=(('initial',original),('flip_x',result))
assert history[0][1][0]==1 and history[1][1][0]==0
assert history[0] in history
assert step(original,'halt_x')==result
assert step(result,'halt_x')==result

def active_x(s):return s[0]==1
bad_edges=[(s,a,step(s,a)) for s in S for a in A
           if active_x(s) and not active_x(step(s,a))]
assert bad_edges and any(a=='flip_x' for _,a,_ in bad_edges)
checks['live_violation_edges']=len(bad_edges)

# Exact finite theorem: every P-initial reachable state has P
# iff each actual source edge is P-preserving, for EVERY P subset.
for truth in product((0,1),repeat=len(S)):
    P=dict(zip(S,truth))
    step_closed=all(not P[s] or P[step(s,a)] for s in S for a in A)
    all_reachable=True
    for s in S:
        if not P[s]:continue
        reached={s}; frontier={s}
        while frontier:
            nxt={step(t,a) for t in frontier for a in A}-reached
            reached.update(nxt);frontier=nxt
        if any(not P[t] for t in reached):
            all_reachable=False;break
    assert step_closed==all_reachable
    checks['all_source_predicates']+=1

expected={
    'future_word_sufficiency':8*sum(6**i for i in range(5)),
    'ledger_step':48, 'cut_separation':8,
    'composition_triples':8*6**3, 'independent_diamonds':8*4,
    'reversible_steps':16, 'live_violation_edges':len(bad_edges),
    'all_source_predicates':256
}
assert dict(checks)==expected,(dict(checks),expected)
print('PASS',dict(checks))
print('PASS: cut distinguishes all states, charge conserved, source composition exact')
print('PASS: B1-B6 finite operational analogues and state-dependent response graph')
print('PASS: reversible source map ends a toy activity flag without logical contradiction')
print('PASS: one-step closure iff all finite histories preserve every tested predicate')
print('LIMIT: no fully validated BCRD B7 gravitational source or physical-X3 proof')
