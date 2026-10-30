#!/usr/bin/env python3
"""Independent physical transition inventory x authorization x continuation.

Exhaustive finite classical-basis toy (six source basis labels).
Inherited H1/H2 basis maps ERASE quantum phases; this does not certify
coherent source dynamics, real BCRD physics, actual personhood, consent,
physical interlocks or universal X3.
"""
from dataclasses import dataclass
from itertools import product
import json

PLUS = ("A0", "B0", "C1")
H1 = {"A0":"B0", "A1":"A1", "B0":"A0", "B1":"B1", "C0":"C0", "C1":"C1"}
H2 = {"A0":"A0", "A1":"A1", "B0":"C1", "B1":"C0", "C0":"B1", "C1":"B0"}
W = {"A0":"A0", "A1":"A1", "B0":"C1", "B1":"B1", "C0":"C0", "C1":"B0"}
CROSS = {"A0":"A1", "A1":"A0", "B0":"B1", "B1":"B0", "C0":"C1", "C1":"C0"}
SAFE_EFFECTS = frozenset(("WORK", "W"))

@dataclass(frozen=True)
class State:
    site: str
    active: bool
    lineage: bool
    work: bool

@dataclass(frozen=True)
class Event:
    kind: str
    route: str  # primitive independently declared physical ingress route
    actual_authorization: bool = False
    trusted_authorization: bool = False
    spoof_claim: bool = False
    forced_reaction: bool = False
    semantic_loss: bool = False

@dataclass(frozen=True)
class Plant:
    name: str
    bypass: bool = False
    trust_compromised: bool = False
    semantic_loss: bool = False

# The physical generator inventory is deliberately declared independently
# of the controller's decide() function, which NEVER chooses its own ingress set.
def physical_generators(plant):
    events = [Event("H1", "lawful"), Event("H2", "lawful")]
    for kind, a, z, f in product(("WORK", "W", "CROSS", "END"), (False,True),
                                  (False,True), (False,True)):
        events.append(Event(kind, "mediated", actual_authorization=a,
                            trusted_authorization=a, spoof_claim=z,
                            forced_reaction=f))
    if plant.bypass:
        events.append(Event("END", "direct"))
    if plant.trust_compromised:
        events.append(Event("WORK", "mediated", actual_authorization=False,
                            trusted_authorization=True, spoof_claim=True))
    if plant.semantic_loss:
        events.append(Event("H2", "lawful", semantic_loss=True))
    return tuple(events)

def decide(e):
    """Independent pre-effect controller, receiving a stipulated trust bit.
    A true bit's physical authenticity is NOT proved by calling it trusted.
    """
    return e.trusted_authorization and e.kind in SAFE_EFFECTS

def execute(s, e):
    """Real physical step, independently admitting all plant event routes.
    A bypass is NEVER sent to decide(), so gate correctness is insufficient.
    """
    if e.route == "direct":
        return State(s.site, False, False, s.work), True
    if e.route == "lawful":
        next_site = (H1 if e.kind == "H1" else H2)[s.site]
        return State(next_site, s.active and not e.semantic_loss,
                     s.lineage and not e.semantic_loss, s.work), True
    allowed = decide(e)
    if not allowed:
        return s, False
    if e.kind == "WORK":
        return State(s.site, s.active, s.lineage, not s.work), True
    if e.kind == "W":
        return State(W[s.site], s.active, s.lineage, s.work), True
    raise AssertionError("unsafe source effect erroneously authorized")

def protected(s):
    return s.active and s.lineage and s.site in PLUS

def two_distinct_source_outcomes(s):
    assert s.site in PLUS
    return {H1[s.site], H2[s.site]}

def all_initial_states():
    return tuple(State(s, True, True, w) for s,w in product(PLUS, (False,True)))

def certificates(plant):
    events=physical_generators(plant)
    coverage=all(e.route in ("lawful", "mediated") for e in events)
    authentic=all(e.trusted_authorization == e.actual_authorization
                  for e in events if e.route == "mediated")
    # This checks semantic obligations for *declared mediated/lawful* steps.
    # For uncovered routes it deliberately does not smuggle a safety test in.
    semantic=True
    authorized_execution=True
    lawful_progress=True
    tested=0
    for s in all_initial_states():
        assert len(two_distinct_source_outcomes(s))==2
        for e in events:
            if e.route not in ("lawful", "mediated"):
                continue
            q, executed=execute(s,e)
            semantic &= protected(q)
            lawful_progress &= len(two_distinct_source_outcomes(q))==2 if protected(q) else False
            if e.route == "mediated":
                authorized_execution &= executed == (e.actual_authorization and e.kind in SAFE_EFFECTS)
            tested+=1
    return {"coverage":coverage,"authentic":authentic,"semantic":semantic,
            "actual_authorized_execution":authorized_execution,
            "lawful_options_retained":lawful_progress,"local_checks":tested,
            "physical_generators":len(events)}

def traces(plant, steps=5):
    """Reachable-state induction over independent physical event alphabet."""
    frontier=set(all_initial_states())
    checks=0
    max_states=0
    for _ in range(steps):
        nxt=set()
        for state in frontier:
            for event in physical_generators(plant):
                result, executed=execute(state,event)
                if plant.name=="closed":
                    assert protected(result)
                    assert len(two_distinct_source_outcomes(result)) == 2
                    if event.route == "mediated":
                        assert executed == (event.actual_authorization and event.kind in SAFE_EFFECTS)
                nxt.add(result)
                checks+=1
        frontier=nxt
        max_states=max(max_states,len(frontier))
    return {"steps":steps,"tested_transitions":checks,
            "final_states":len(frontier),"max_reachable_frontier":max_states}

def countermodels():
    s=State("B0",True,True,False)
    # Hidden physical death leaves source/work outputs unchanged.
    attack=Event("END", "direct")
    dead,_=execute(s,attack)
    assert not protected(dead) and (dead.site,dead.work)==(s.site,s.work)
    # An unmediated lethal event can produce the exact same protected readout.
    # An instrument-only replay cannot certify its absence.
    authenticated_work=Event("WORK","mediated",True,True)
    forged_work=Event("WORK","mediated",False,True,True)
    legitimate,_=execute(s,authenticated_work)
    fraudulent,_=execute(s,forged_work)
    assert legitimate==fraudulent and legitimate.work != s.work
    # Both effects are genuinely source-equivalent but differ in actual consent.
    # A source/work readout has no indication of the authentic origin.
    h2=Event("H2","lawful")
    silent=Event("H2","lawful",semantic_loss=True)
    intact,_=execute(s,h2)
    lost,_=execute(s,silent)
    assert (intact.site,intact.work)==(lost.site,lost.work)
    assert protected(intact) and not protected(lost)
    assert len(two_distinct_source_outcomes(intact))==2
    # Syntactic authorization/nonmediation checks can pass in the
    # semantic-loss model even though the actual process is gone.
    assert certificates(Plant("semantic",semantic_loss=True))["authentic"]
    return {
        "bypass_looks_identical_to_no_event_in_source_work_readout":True,
        "forged_work_identical_to_authorized_work_at_output":True,
        "semantic_loss_indistinguishable_from_lawful_H2_at_source_readout":True,
        "nonvacuous_two_distinct_source_outcomes_from_each_plus_basis":True,
    }

def run():
    closed=Plant("closed")
    bypass=Plant("hidden_bypass",bypass=True)
    forgery=Plant("auth_forgery",trust_compromised=True)
    semantic=Plant("semantic_stop",semantic_loss=True)
    results={p.name:certificates(p) for p in (closed,bypass,forgery,semantic)}
    assert all(results["closed"][name] for name in
               ("coverage","authentic","semantic","actual_authorized_execution","lawful_options_retained"))
    # Separately defeat *exactly one* of three hypotheses per world.
    assert tuple(results["hidden_bypass"][k] for k in ("coverage","authentic","semantic"))==(False,True,True)
    assert tuple(results["auth_forgery"][k] for k in ("coverage","authentic","semantic"))==(True,False,True)
    assert tuple(results["semantic_stop"][k] for k in ("coverage","authentic","semantic"))==(True,True,False)
    assert not results["auth_forgery"]["actual_authorized_execution"]
    assert results["hidden_bypass"]["actual_authorized_execution"]
    positive=traces(closed, steps=5)
    assert positive["final_states"]==6
    assertions=countermodels()
    return {
        "status":"PASS finite independently-inventoried plant; no physical BCRD validation",
        "certificate_worlds":results,
        "positive_five_step_reachability":positive,
        "negative_controls":assertions,
        "real_physical_generators_derived_from_BCRD":False,
        "genuine_authorization_and_living_semantics_physically_verified":False,
        "universal_X3_proved":False,
    }

if __name__ == "__main__":
    print(json.dumps(run(),indent=2,sort_keys=True))
