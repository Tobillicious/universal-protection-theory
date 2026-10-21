"""Bound a recovery tail without deleting the lived journal; exact reachable-state exploration."""
from dataclasses import dataclass,replace
from collections import deque,Counter
import json,sys
sys.dont_write_bytecode=True
from durable_protocol import Machine,ideal,fold

@dataclass(frozen=True)
class State:
    log:tuple=()
    out:tuple=()
    anchor:int=0
    anchor_state:int=0
    pc:int=0
    cache:int=0

def invariant(m,c,B):
    n,k=len(c.log),len(c.out)
    return (k<=n<=k+1 and c.log==ideal(m,n).log and c.out==ideal(m,k).out
      and 0<=c.anchor<=c.pc<=n<=c.anchor+B
      and c.anchor_state==fold(m,c.log[:c.anchor]) and c.cache==fold(m,c.log[:c.pc])
      and all(i==j for i,(j,_) in enumerate(c.out)))

def transition(m,c,a,held,limit,B):
    n,k=len(c.log),len(c.out)
    if a=='record' and not held and n==k and n<limit and n<c.anchor+B:
        return replace(c,log=c.log+(m.g(c.out),)),('live_commit',n)
    if a=='reconstruct' and c.pc<n:
        return replace(c,pc=c.pc+1,cache=m.f(c.cache,c.log[c.pc])),('reconstruction',c.pc)
    if a=='deliver' and not held and k+1==n and c.pc==n:
        return replace(c,out=c.out+((k,m.eff(c.cache)),)),('effect_commit',k)
    if a=='checkpoint' and not held and n==k and c.pc==n:
        return replace(c,anchor=n,anchor_state=c.cache),('checkpoint',n)
    if a=='crash':
        return replace(c,pc=c.anchor,cache=c.anchor_state),('load_anchor',c.anchor)
    return c,('idle',)

def release(m,c,limit,B):
    # Explicit load from the durable anchor, followed by at most B resident evaluations and one sink append.
    c,_=transition(m,c,'crash',False,limit,B);evaluations=deliveries=0
    while c.pc<len(c.log):
        c,_=transition(m,c,'reconstruct',False,limit,B);evaluations+=1
    if len(c.out)<len(c.log):
        c,_=transition(m,c,'deliver',False,limit,B);deliveries+=1
    i=ideal(m,len(c.log))
    assert (c.log,c.out,c.pc,c.cache)==(i.log,i.out,i.pc,i.cache)
    assert evaluations<=B and deliveries<=1
    return c,evaluations,deliveries

def main():
    actions=('record','reconstruct','deliver','checkpoint','crash','idle')
    total=Counter();cases=[];max_tail=0;blocked=0
    for kind in range(3):
        m=Machine(kind,kind)
        for B in range(1,5):
            for limit in range(13):
                start=State(anchor_state=m.s0,cache=m.s0)
                seen={start};todo=deque([start]);edges=0
                while todo:
                    c=todo.popleft();assert invariant(m,c,B)
                    d,e,k=release(m,c,limit,B);assert invariant(m,d,B)
                    max_tail=max(max_tail,e)
                    if len(c.log)==c.anchor+B and len(c.log)<limit and len(c.out)==len(c.log):
                        same,_=transition(m,c,'record',False,limit,B);assert same==c;blocked+=1
                    for action in actions:
                        for held in (False,True):
                            d,event=transition(m,c,action,held,limit,B);edges+=1
                            assert invariant(m,d,B)
                            assert len(d.log)>=len(c.log) and len(d.out)>=len(c.out)
                            assert d.log[:len(c.log)]==c.log and d.out[:len(c.out)]==c.out
                            if held:
                                assert (d.log,d.out,d.anchor,d.anchor_state)==(c.log,c.out,c.anchor,c.anchor_state)
                                assert event[0] not in ('live_commit','effect_commit','checkpoint')
                            if d not in seen:seen.add(d);todo.append(d)
                total['states']+=len(seen);total['transitions']+=edges
                cases.append({'machine':kind,'window':B,'limit':limit,'states':len(seen),'transitions':edges})
    # Ignoring the record window defeats the bound even with correct, fully retained history.
    m=Machine(0,0);i=ideal(m,5)
    overrun=State(i.log,i.out,0,m.s0,0,m.s0)
    assert not invariant(m,overrun,2) and len(overrun.log)-overrun.anchor==5
    # A forged anchor value is rejected by the invariant, not silently treated as a trusted ideal state.
    good=State(i.log,i.out,5,i.cache,5,i.cache)
    forged=replace(good,anchor_state=(i.cache+1)%11)
    assert invariant(m,good,2) and not invariant(m,forged,2)
    # Numeric certificate: caller-supplied time bounds, with no physical unit silently assigned.
    load,eval_cost,sink,B=3,5,7,4
    certificate=load+B*eval_cost+sink
    assert certificate==30
    out={'machine_instances':3,'windows':[1,2,3,4],'program_limits':list(range(13)),
      'graph_states':total['states'],'graph_transitions':total['transitions'],
      'cases':cases,'max_tail_evaluations':max_tail,'record_window_gates_checked':blocked,
      'journal_retained_in_full':True,'all_held_committed_fields_unchanged':True,
      'release_matches_ideal_resident_log_and_ordered_sink':True,
      'overrun_and_forged_anchor_rejected':True,
      'example_supplied_cost_certificate':{'load':load,'evaluation':eval_cost,'sink':sink,'window':B,'total':certificate},
      'scope':'Checkpoint is an atomic durable verified-prefix record; the full journal remains. The scheduler must eventually run recovery and delivery. A B-evaluation tail does not imply constant-time loading for arbitrary states, physical timing, closure, identity or corruption tolerance.'}
    if len(sys.argv)>1:
        ok={'a_checkpoint_without_a_record_gate_bounds_the_tail':len(overrun.log)-overrun.anchor<=2,
            'arbitrary_checkpoint_values_preserve_replay':invariant(m,forged,2)}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(out,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
