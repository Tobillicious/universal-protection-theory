#!/usr/bin/env python3
"""Finite process identity audit: visible equality, edge typing, branching symmetry.

The invented carrier edges are stipulated toy inputs, not inferred from BCRD,
from quantum state similarity, from provenance records or from consciousness.
"""
import json
from dataclasses import dataclass
from itertools import product

@dataclass(frozen=True)
class Node:
    key: str
    t: int
    visible: str
    active: bool

@dataclass(frozen=True)
class Edge:
    src: str
    dst: str
    kind: str
    # A certified microscopic process-carrier bridge would require
    # independent physical justification, not this Boolean convention.
    independently_certified: bool = False

nodes={x.key:x for x in (
    Node('original0',0,'record-R',True),
    Node('changed1',1,'state-S',True),
    Node('copy1',1,'state-S',True),
    Node('record1',1,'state-S',False),
    Node('fork_left2',2,'state-T',True),
    Node('fork_right2',2,'state-T',True),
    Node('chain3',3,'state-U',True),
    Node('closed3',3,'state-U',False),
    Node('new2',2,'state-T',True),
)}
edges=(
    Edge('original0','changed1','living-process',True),
    Edge('original0','copy1','record-reproduction',False),
    Edge('original0','record1','archive',False),
    Edge('changed1','fork_left2','living-process',True),
    Edge('changed1','fork_right2','living-process',True),
    Edge('fork_left2','chain3','living-process',True),
    Edge('fork_right2','closed3','termination',False),
    Edge('new2','chain3','unrelated-convergent-observation',False),
)

def successors(x, eligible=lambda e:True):
    return [e.dst for e in edges if e.src==x and eligible(e)]

def reachable(x,steps,eligible):
    out={x}
    for _ in range(steps):
        out={y for z in out for y in successors(z,eligible)}
    return out

def is_certified_living(e):
    return e.kind=='living-process' and e.independently_certified and nodes[e.src].active and nodes[e.dst].active

def symmetric_uniqueness_impossible():
    # Under the exchange automorphism, a selector must be equal on the twins.
    for v0,v1 in product((False,True),repeat=2):
        invariant=(v0==v1)
        exactly_one=int(v0)+int(v1)==1
        assert not(invariant and exactly_one)
    return True

def run():
    assert nodes['changed1'].visible==nodes['copy1'].visible==nodes['record1'].visible
    assert nodes['changed1'].active and nodes['copy1'].active and not nodes['record1'].active
    assert set(successors('original0'))=={'changed1','copy1','record1'}
    assert reachable('original0',1,is_certified_living)=={'changed1'}
    assert reachable('original0',2,is_certified_living)=={'fork_left2','fork_right2'}
    assert reachable('original0',3,is_certified_living)=={'chain3'}
    twins=('fork_left2','fork_right2')
    assert nodes[twins[0]].visible==nodes[twins[1]].visible
    assert all(e.independently_certified for e in edges if e.src=='changed1' and e.dst in twins)
    assert symmetric_uniqueness_impossible()
    assert len(reachable('original0',1,is_certified_living))==1
    assert len(reachable('fork_left2',1,is_certified_living))==1
    assert set(e.src for e in edges if e.dst=='chain3')=={'fork_left2','new2'}
    assert nodes['chain3'].visible==nodes['closed3'].visible
    # Alphabetic tie-break selects one label but is NOT independent physical identity.
    assert min(twins)=='fork_left2'
    assert nodes['fork_left2'].active==nodes['fork_right2'].active
    return {
      'status':'PASS identity-criterion countermodels; finite invented graph only',
      'nodes':len(nodes),'edges':len(edges),
      'same_visible_output_can_be_active_or_archived':True,
      'ancestry_only_accepts_record_copy':True,
      'continuous_living_edge_requires_independently_justified_physics':True,
      'two_certified_fork_successors_from_same_parent':True,
      'symmetric_exactly_one_selector_impossible':True,
      'nonbranching_subchain_has_unique_conditional_successor':True,
      'convergent_history_has_multiple_predecessors':True,
      'physical_BCRD_consciousness_identity_derived':False,
      'universal_X3_established':False,
    }

if __name__=='__main__':
    print(json.dumps(run(),indent=2,sort_keys=True))
