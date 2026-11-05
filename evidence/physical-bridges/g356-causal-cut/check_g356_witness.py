#!/usr/bin/env python3
"""UPT historical recovery: finite G3/G5/G6 toy witness.

This is a self-contained exhaustive checker of an explicitly idealised
transition system. It is NOT a check of BCRD, a real installation, Lean,
or an unrestricted universal protection theorem.
"""
from itertools import product
from collections import Counter
from collections import deque
from dataclasses import dataclass
import json

SUBJECTS = ('A', 'B', 'C')
TIMES = (3, 4, 5)
FOUNDER_GIFT = 12
FOUNDER_BENEFIT = 16
BUILD_COST = 6
MAINTENANCE = 2
CARE_PER_SUBJECT = 1
GUARDS = frozenset(SUBJECTS)

@dataclass(frozen=True)
class State:
    t: int
    stock: int
    histories: tuple[tuple[int, ...], ...]

def active(t):
    return SUBJECTS[:2] if t == 3 else SUBJECTS

def payoffs(x, y):
    if x and y:
        return (FOUNDER_BENEFIT - FOUNDER_GIFT,) * 2
    return (0, 0)  # assurance escrow refunds unilateral commitments

def founding_equilibria():
    equilibria = []
    for a,b in product((False,True), repeat=2):
        z=payoffs(a,b)
        if z[0] >= payoffs(not a,b)[0] and z[1] >= payoffs(a,not b)[1]:
            equilibria.append((a,b))
    return equilibria

def transition(state, actions, *, shock=False, guards=GUARDS):
    """actions: {subject:(genuine_choice, attacker_kill, coerced_reaction)}.

    Genuine choice is independently authenticated and never sourced from
    attacker_kill or coerced_reaction. A local preinstalled guard rejects
    irreversible attacker effect even if a coerced reaction occurred.
    """
    t=state.t
    assert t in TIMES
    assert set(actions)==set(active(t))
    cost=MAINTENANCE+CARE_PER_SUBJECT*len(active(t))
    assert state.stock>=cost
    stock=state.stock-cost
    histories=list(state.histories)
    deaths=[]
    for person in active(t):
        index=SUBJECTS.index(person)
        choice, attacker_kill, coerced_reaction = actions[person]
        assert all(bit in (0,1) for bit in (choice,attacker_kill,coerced_reaction))
        # 'coerced_reaction' may be a causal parent of the *request*.
        # It is NOT a subject-authorized execution grant.
        harmful_request=bool(attacker_kill or coerced_reaction)
        if harmful_request and (shock or person not in guards):
            deaths.append(person)
        else:
            histories[index]=histories[index]+(choice,)
    return State(t+1,stock,tuple(histories)),tuple(deaths)


def shortest_path(graph, start, end):
    queue=deque([(start,0)])
    seen={start}
    while queue:
        v,d=queue.popleft()
        if v==end:
            return d
        for w in graph[v]:
            if w not in seen:
                seen.add(w)
                queue.append((w,d+1))
    raise AssertionError('no causal path')

def permitted_cut(paths, guardable_edges):
    """Find minimum static cut among *actually installable* guard edges."""
    for size in range(len(guardable_edges)+1):
        for bits in product((0,1),repeat=len(guardable_edges)):
            if sum(bits)!=size:
                continue
            selected={e for e,chosen in zip(guardable_edges,bits) if chosen}
            if all(any((p[i],p[i+1]) in selected for i in range(len(p)-1)) for p in paths):
                return selected
    return None

def validate():
    assert founding_equilibria()==[(False,False),(True,True)]
    # Radius-1 signalling: founders -> hub -> local port, two ticks.
    graph={
        'f1':('hub',),'f2':('hub',),'hub':('f1','f2','A','B','C'),
        'A':('hub','A_attack'),'B':('hub','B_attack'),'C':('hub','C_attack'),
        'A_attack':('A',),'B_attack':('B',),'C_attack':('C',)
    }
    install_delay={p:shortest_path(graph,'f1',p) for p in SUBJECTS}
    assert list(install_delay.values())==[2,2,2]
    assert max(install_delay.values()) < min(TIMES)
    guardable_edges=tuple((f'port_{p}',f'victim_{p}') for p in SUBJECTS)
    threat_paths=[('src',f'attack_{p}',f'port_{p}',f'victim_{p}','sink') for p in SUBJECTS]
    cheapest=permitted_cut(threat_paths,guardable_edges)
    assert cheapest==set(guardable_edges)
    assert BUILD_COST==2*len(cheapest)
    bypass=threat_paths+[('src','attack_C','victim_C','sink')]
    assert permitted_cut(bypass,guardable_edges) is None
    assert payoffs(True,True)==(4,4)
    initial=State(3,2*FOUNDER_GIFT-BUILD_COST,((),(),()))
    states={initial}
    stage=[]
    evaluated=0
    coerced_attacks_blocked=0
    for t in TIMES:
        next_states=set()
        n=len(active(t))
        outcomes=product(list(product((0,1),repeat=3)),repeat=n)
        all_actions=list(outcomes)
        for state in states:
            assert state.t==t
            for bits in all_actions:
                actions=dict(zip(active(t),bits))
                new, deaths=transition(state,actions)
                evaluated+=1
                assert not deaths, (t,actions,deaths)
                # Full protected trace and funds are identical to the
                # counterfactual without either form of attack.
                clean={p:(a[0],0,0) for p,a in actions.items()}
                reference,rd=transition(state,clean)
                assert new==reference and not rd
                if any(k or f for (choice,k,f) in bits):
                    coerced_attacks_blocked+=1
                assert new.stock >= 0
                next_states.add(new)
        stage.append({'t':t,'input_states':len(states), 'action_combinations_per_state':len(all_actions), 'new_states':len(next_states), 'balance_after_step':sorted({s.stock for s in next_states})})
        states=next_states
    assert len(states)==256, len(states) # 2 genuine A/B choices at 3, and 3 at each of 4,5
    assert {s.stock for s in states}=={4}
    # Three decisive negative controls: broken timing, insufficient founding,
    # unguarded outside arrival; plus common-mode fault/authorization bypass.
    dummy=State(3,18,((),(),()))
    all_0={p:(0,0,0) for p in active(3)}
    attack_A={**all_0,'A':(0,1,1)}
    _,early=transition(dummy,attack_A,guards=frozenset({'B','C'}))
    assert early==('A',)
    _,shockdeath=transition(dummy,attack_A,shock=True)
    assert shockdeath==('A',)
    at4=State(4,14,((0,),(0,),()))
    outside={p:(0,0,0) for p in active(4)}
    outside['C']=(0,1,1)
    _,outside_death=transition(at4,outside,guards=frozenset(('A','B')))
    assert outside_death==('C',)
    assert (2*FOUNDER_GIFT-BUILD_COST) - sum(MAINTENANCE+len(active(t)) for t in TIMES)==4
    return {
        'kind':'finite conditional G3/G5/G6 witness, NOT universal',
        'founder_payoffs_when_both_commit':list(payoffs(True,True)),
        'finite_speed_founder_to_port_delay':install_delay,
        'first_adversarial_epoch':3,
        'least_permitted_threat_cut_size':len(cheapest),
        'least_permitted_threat_cut_edges':sorted([list(e) for e in cheapest]),
        'unguardable_new_bypass_has_permitted_cut':False,
        'pure_founder_nash_equilibria':[[int(a),int(b)] for a,b in founding_equilibria()],
        'founding_selected_equilibrium_not_derived':True,
        'escrow_after_both_commit':24,
        'build_cost':BUILD_COST,
        'service_and_care_cost':sum(MAINTENANCE+len(active(t)) for t in TIMES),
        'final_reserve':4,
        'exhaustive_one_step_transitions_checked':evaluated,
        'adversarial_action_cases_noninterfering':coerced_attacks_blocked,
        'reachable_trace_states_at_end':len(states),
        'stages':stage,
        'negative_controls':{'uninstalled_A_at_first_threat':list(early),'common_mode_shock':list(shockdeath),'unguarded_C_arrival':list(outside_death)},
        'risk_illustration':{'declared_conditional_common_shock_upper_per_step':0.001,'three_step_union_upper':0.003,'empirical_measurement':False},
        'status':'PASS - under exact finite transition and declared premises'
    }

if __name__=='__main__':
    result=validate()
    print(json.dumps(result, indent=2))