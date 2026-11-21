#!/usr/bin/env python3
"""AHE-1..5: finite-state final-apply history/authorization/energy witness.

Standard library only. This is a SYNTHETIC MODEL with a TRUSTED GRANT
REGISTRY as an independent input. Passing the checks does NOT establish
cryptographic authentication, subject consent, hardware no-bypass,
realtime atomicity, physical installation or UPT X3.

Run: python3 check_authenticated_history_to_effect.py
"""
from dataclasses import dataclass, replace

@dataclass(frozen=True)
class Request:
    subject: str
    history: tuple[tuple[int, int], ...]
    epoch: int
    nonce: int
    amount: int

@dataclass(frozen=True)
class Receipt:
    request: Request
    battery_before: int
    battery_after: int
    target_before: int
    target_after: int

@dataclass(frozen=True)
class State:
    subject: str
    history: tuple[tuple[int, int], ...]
    epoch: int
    held: bool
    battery: int
    target: int
    used: frozenset[int]
    receipts: tuple[Receipt, ...]
    grants: frozenset[Request]

def initial(subject: str, battery: int, held: bool = False, epoch: int = 0) -> State:
    return State(subject, (), epoch, held, battery, 0, frozenset(), (), frozenset())

def trusted_issue(s: State, r: Request) -> State:
    """TRUSTED SIDE: assumes independent source issuance already happened.

    This function models adding an independently granted record. It does
    not perform real cryptographic signature checks or verify consent.
    """
    return replace(s, grants=s.grants | {r})

def permit_at_sink(s: State, r: Request) -> bool:
    return (not s.held and
            r in s.grants and
            r.subject == s.subject and
            r.history == s.history and
            r.epoch == s.epoch and
            r.nonce not in s.used and
            r.amount in (1, 2) and
            r.amount <= s.battery)

def apply(s: State, r: Request) -> tuple[State, bool]:
    """Serial atomic final-apply: only this trusted function moves energy."""
    if not permit_at_sink(s, r):
        return s, False
    receipt = Receipt(r, s.battery, s.battery-r.amount,
                      s.target, s.target+r.amount)
    return (replace(s, battery=s.battery-r.amount,
                    target=s.target+r.amount,
                    used=s.used | {r.nonce},
                    history=s.history+((r.nonce,r.amount),),
                    receipts=s.receipts+(receipt,)), True)

def hold(s: State) -> State:
    return replace(s, epoch=s.epoch+1, held=True)

def release(s: State) -> State:
    """TRUSTED SIDE: a release alone cannot reinstate stale grants."""
    return replace(s, held=False)

def check_invariants(initial_state: State, s: State) -> None:
    assert s.subject == initial_state.subject
    assert s.battery >= 0 and s.target >= 0
    assert s.battery+s.target == initial_state.battery+initial_state.target
    assert s.epoch >= initial_state.epoch
    assert s.history == tuple((r.request.nonce, r.request.amount)
                              for r in s.receipts)
    assert s.used == frozenset(r.request.nonce for r in s.receipts)
    assert len(s.used) == len(s.receipts)
    for r in s.receipts:
        assert r.request.subject == s.subject
        assert r.request.amount in (1,2)
        assert r.battery_before-r.battery_after == r.request.amount
        assert r.target_after-r.target_before == r.request.amount
    for i in range(1, len(s.receipts)):
        assert s.receipts[i-1].battery_after == s.receipts[i].battery_before
        assert s.receipts[i-1].target_after == s.receipts[i].target_before

def request(s: State, nonce: int, amount: int) -> Request:
    return Request(s.subject, s.history, s.epoch, nonce, amount)

def check_one(s: State, r: Request) -> bool:
    """AHE-2: in a landed transition all gate premises held in PRE-state."""
    start = s
    p = permit_at_sink(s, r)
    t, landed = apply(s, r)
    assert landed == p
    if landed:
        assert r in start.grants and not start.held
        assert r.subject == start.subject and r.history == start.history
        assert r.epoch == start.epoch and r.nonce not in start.used
        assert r.amount <= start.battery
        assert t.history == start.history + ((r.nonce,r.amount),)
        assert t.receipts[-1].request == r
    else:
        assert t == start
    return landed

def exhaustive_short_cases() -> int:
    tested=0
    for who in ('a','b'):
        for battery in range(4):
            for blocked in (False,True):
                for epoch in (0,1):
                    z=initial(who,battery,blocked,epoch)
                    check_invariants(z,z)
                    for amount in (1,2):
                        r=request(z,11,amount)
                        z1=trusted_issue(z,r)
                        invalid=[
                            replace(r,subject=('b' if who=='a' else 'a')),
                            replace(r,history=((42,1),)),
                            replace(r,epoch=epoch+1),
                            replace(r,nonce=12),
                            replace(r,amount=(2 if amount==1 else 1)),
                        ]
                        for bad in invalid:
                            assert not check_one(z1,bad)
                            tested+=1
                        expected=(not blocked and battery>=amount)
                        assert check_one(z1,r)==expected
                        t,landed=apply(z1,r)
                        assert landed==expected
                        check_invariants(z,t)
                        if landed:
                            assert not check_one(t,r) # consumed and stale history
                            check_invariants(z,apply(t,r)[0])
                        h=hold(z1)
                        assert not check_one(h,r)
                        assert not check_one(release(h),r) # old epoch
                        check_invariants(z,h)
                        tested+=4
    return tested

def check_nonvacuous_alternatives() -> None:
    s=initial('particular',3)
    r1=request(s,101,1)
    r2=request(s,102,2)
    both=trusted_issue(trusted_issue(s,r1),r2)
    o1,ok1=apply(both,r1)
    o2,ok2=apply(both,r2)
    assert ok1 and ok2
    assert o1!=o2 and o1.target==1 and o2.target==2
    check_invariants(s,o1)
    check_invariants(s,o2)
    assert not apply(o1,r2)[1] # old history head; reissue required

def check_bypass_countermodel() -> None:
    """Energy conservation does not imply complete mediated receipt coverage."""
    s=initial('particular',2)
    bypass=replace(s,battery=1,target=1)
    assert bypass.battery+bypass.target == s.battery+s.target
    assert bypass.receipts == s.receipts
    assert bypass.target != s.target
    # Complete mediation would prohibit this physical event; the Python gate
    # alone does not and cannot prove that nature has no bypass.

if __name__=='__main__':
    count=exhaustive_short_cases()
    check_nonvacuous_alternatives()
    check_bypass_countermodel()
    print(f'PASS: {count} exhaustive short authorization/replay/hold cases')
    print('PASS: every modeled landed effect has a fresh source grant, funded battery and matching history')
    print('PASS: exact modeled energy conservation, serial nonce uniqueness and hold fencing')
    print('PASS: two independently granted counterfactual branches have distinct feasible outcomes')
    print('PASS: modeled bypass counterexample exhibits the remaining real-world completeness obligation')
    print('NOTE: test code is not a Lean proof, cryptographic implementation or physical/X3 certification')
