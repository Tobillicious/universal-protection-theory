"""A one-pending-step durable journal/sink construction, with explicit replay cache and drain barrier."""
from dataclasses import dataclass,replace
from collections import deque,Counter
import json,sys
sys.dont_write_bytecode=True

@dataclass(frozen=True)
class State:
    log:tuple=()
    out:tuple=()
    pc:int=0
    cache:int=0

@dataclass(frozen=True)
class Machine:
    s0:int
    kind:int
    def f(self,s,x):return ((2+self.kind)*s+x+self.kind)%11
    def g(self,out):return (sum(y for _,y in out)+3*len(out)+1+self.kind)%7
    def eff(self,s):return (s*(self.kind+1)+self.kind)%13

def ideal(m,n):
    s=m.s0;log=[];out=[]
    for i in range(n):
        x=m.g(tuple(out));log.append(x);s=m.f(s,x);out.append((i,m.eff(s)))
    return State(tuple(log),tuple(out),n,s)

def fold(m,log):
    s=m.s0
    for x in log:s=m.f(s,x)
    return s

def invariant(m,c):
    n,k=len(c.log),len(c.out)
    return (k<=n<=k+1 and c.log==ideal(m,n).log and c.out==ideal(m,k).out
        and 0<=c.pc<=n and c.cache==fold(m,c.log[:c.pc])
        and all(i==j for i,(j,_) in enumerate(c.out)))

def transition(m,c,action,held,limit):
    if action=='record' and not held and len(c.log)==len(c.out) and len(c.log)<limit:
        x=m.g(c.out);return replace(c,log=c.log+(x,)),('live_commit',len(c.log),x)
    if action=='reconstruct' and c.pc<len(c.log):
        return replace(c,pc=c.pc+1,cache=m.f(c.cache,c.log[c.pc])),('reconstruction',c.pc,c.log[c.pc])
    if action=='deliver' and not held and len(c.out)+1==len(c.log) and c.pc==len(c.log):
        row=(len(c.out),m.eff(c.cache));return replace(c,out=c.out+(row,)),('effect_commit',)+row
    if action=='crash':return replace(c,pc=0,cache=m.s0),('crash',)
    return c,('idle',)

def release(m,c,limit):
    work=0
    while c.pc<len(c.log):c,_=transition(m,c,'reconstruct',False,limit);work+=1
    if len(c.out)<len(c.log):c,_=transition(m,c,'deliver',False,limit);work+=1
    assert c==ideal(m,len(c.log))
    return c,work

def main():
    actions=('record','reconstruct','deliver','crash','idle');cases=[];totals=Counter();maxwork=0
    for kind in range(3):
        m=Machine(kind,kind)
        for limit in range(13):
            initial=State(cache=m.s0);seen={initial};queue=deque([initial]);edges=0
            while queue:
                c=queue.popleft();assert invariant(m,c)
                drained,work=release(m,c,limit)
                assert drained==ideal(m,len(c.log)) and work<=len(c.log)-c.pc+1
                maxwork=max(maxwork,work)
                for a in actions:
                    for held in (False,True):
                        d,event=transition(m,c,a,held,limit)
                        assert invariant(m,d)
                        if held:assert d.log==c.log and d.out==c.out and event[0] not in ('live_commit','effect_commit')
                        if a=='crash':assert d.log==c.log and d.out==c.out
                        assert len(c.log)<=len(d.log) and len(c.out)<=len(d.out)
                        if d not in seen:seen.add(d);queue.append(d)
                        edges+=1
            assert len(seen)==(limit+1)*(limit+2)-1
            totals['states']+=len(seen);totals['transitions']+=edges
            cases.append({'machine':kind,'limit':limit,'states':len(seen),'transitions':edges})
    # Failing release certificates: final values alone need not establish the cache/continuation invariant.
    m=Machine(0,0);good=ideal(m,4)
    mutants={
      'wrong_cache':replace(good,cache=(good.cache+1)%11),
      'wrong_cursor':replace(good,pc=3),
      'wrong_lived_input':replace(good,log=(good.log[0]+7,)+good.log[1:]),
      'reversed_effects':replace(good,out=tuple(reversed(good.out))),
      'lost_sink_identity':replace(good,out=((-1,good.out[0][1]),)+good.out[1:])}
    rejected={k:not invariant(m,v) for k,v in mutants.items()};assert all(rejected.values())
    # A drained journal/sink can still need reconstruction before release.
    crashed,_=transition(m,good,'crash',False,4)
    assert crashed.log==good.log and crashed.out==good.out and crashed!=good
    recovered,work=release(m,crashed,4);assert recovered==good and work==4
    # Two logged inputs without waiting for delivery can read stale feedback.
    g=lambda out:len(out)+1
    premature_log=(g(()),g(()));proper_log=(1,2)
    assert premature_log==(1,1) and premature_log!=proper_log
    # A local pending flag cannot distinguish effect-before-crash from no-effect-before-crash.
    recovery_outcomes={}
    for resend in (False,True):
        counts=[int(prior)+int(resend) for prior in (False,True)]
        assert not all(n==1 for n in counts)
        recovery_outcomes[str(resend)]=counts
    out={'machine_instances':3,'program_limits':list(range(13)),'graph_states':totals['states'],'graph_transitions':totals['transitions'],
      'cases':cases,'all_reachable_invariants_preserved':True,'all_held_ticks_preserve_committed_history_and_sink':True,
      'release_matches_full_ideal_state':True,'corruption_certificates_rejected':rejected,
      'max_reconstruction_and_delivery_actions':maxwork,'full_replay_cost_example':{'committed_steps':4,'reconstruction_actions_after_crash':work},
      'stale_feedback_without_one_pending_gate':{'premature_inputs':premature_log,'ideal_inputs':proper_log},
      'unresolved_external_delivery_counts':recovery_outcomes,
      'scope':'Logical construction under durable append-only journal, atomic ordered sink commitment and trusted fence; reconstruction is not a new lived commit. No bound on physical replay cost, deadline, closure or subjective identity is inferred.'}
    if len(sys.argv)>1:
        ok={'uncheckpointed_replay_never_exceeds_two_evaluations':work<=2,'matching_log_and_sink_alone_finishes_release':crashed==good}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(out,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
