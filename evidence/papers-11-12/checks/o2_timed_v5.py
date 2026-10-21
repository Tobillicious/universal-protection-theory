"""Timed hold reference model with an external operation observer. Python 3.9, deterministic and exact.

The driver owns the clock, immutable protocol state, operation trace and emitted-effect history. Protocol
operations cannot supply their own event time/classification or roll back the observer. Every modeled state
write is observed before and after, so even a write followed by restoration is visible. Reconstruction reads
the durable log through a separate operation; its pure evaluations follow the declared R-REPLAY convention.

This proves coverage for the declared operation model. Mapping physical execution to those operations and
protecting the real observer remain application contracts. Crashes in this bounded checker occur at tick
boundaries; the separate journal/sink modules address drained-barrier refinement between durable actions.
"""
from dataclasses import dataclass,replace
from itertools import product
import json,sys
sys.dont_write_bytecode=True
L,T,INP,S0=3,12,(1,4,2),3

def integer(value):return type(value) is int
def valid_row(value):return type(value) is tuple and len(value)==2 and integer(value[0]) and value[0]>=0 and integer(value[1])

@dataclass(frozen=True)
class State:
    s:int=S0
    log:tuple=()
    done:int=0
    out:tuple=()
    ids:frozenset=frozenset()
    def __post_init__(self):
        if not (integer(self.s) and integer(self.done) and self.done>=0
          and type(self.log) is tuple and all(valid_row(x) for x in self.log)
          and type(self.out) is tuple and all(valid_row(x) for x in self.out)
          and type(self.ids) is frozenset and all(integer(i) and i>=0 for i in self.ids)):
            raise ValueError('model state must be deeply immutable and well typed')

@dataclass(frozen=True)
class Event:
    tick:int
    held:bool
    kind:str
    before:State
    after:State
    @property
    def live(self):return self.kind=='live'
    @property
    def emits(self):return self.kind in ('deliver','deliver_without_receipt','emit_without_record')

def raw_transition(s,x):return (3*s+x)%7

class Driver:
    """Trusted model boundary. The protocol receives only snapshot/apply capabilities."""
    def __init__(self,state=None):
        self._state=state or State();self._tick=-1;self._held=False
        self._events=[];self._emitted=[]
    def begin_tick(self,tick,held):
        if type(tick) is not int or type(held) is not bool or tick!=self._tick+1:raise ValueError('clock must advance in driver order')
        self._tick=tick;self._held=held
    def snapshot(self):return self._state
    def events(self):return tuple(self._events)
    def emitted(self):return tuple(self._emitted)
    def _write(self,kind,new):
        self._events.append(Event(self._tick,self._held,kind,self._state,new));self._state=new
    def apply(self,kind,*args):
        s=self._state
        arities={'live':1,'log_append':1,'deliver':1,'deliver_without_receipt':1,'emit_without_record':1,'done':1,
                 'state':1,'drop_id':1,'restore':1,'recover':0,'reorder_out':0}
        if kind not in arities or len(args)!=arities[kind]:raise ValueError('unsupported operation or arity')
        if args:
            a=args[0]
            if kind in ('live','state') and not integer(a):raise ValueError('integer argument required')
            if kind in ('done','drop_id') and not (integer(a) and a>=0):raise ValueError('natural-number argument required')
            if kind in ('log_append','deliver','deliver_without_receipt','emit_without_record') and not valid_row(a):raise ValueError('immutable ID/value row required')
        if kind=='live':self._write('live',replace(s,s=raw_transition(s.s,args[0])))
        elif kind=='log_append':self._write(kind,replace(s,log=s.log+(args[0],)))
        elif kind in ('deliver','deliver_without_receipt'):
            row=args[0];self._emitted.append(row)
            ids=s.ids|{row[0]} if kind=='deliver' else s.ids
            self._write(kind,replace(s,out=s.out+(row,),ids=frozenset(ids)))
        elif kind=='emit_without_record':
            self._emitted.append(args[0]);self._write(kind,s)
        elif kind=='done':self._write(kind,replace(s,done=args[0]))
        elif kind=='state':self._write(kind,replace(s,s=args[0]))
        elif kind=='drop_id':self._write(kind,replace(s,ids=s.ids-{args[0]}))
        elif kind=='restore':
            if not isinstance(args[0],State):raise ValueError('restore takes an immutable model state')
            self._write(kind,args[0])
        elif kind=='reorder_out':self._write(kind,replace(s,out=tuple(reversed(s.out))))
        elif kind=='recover':
            cache=S0
            for i,x in s.log:
                cache=raw_transition(cache,x)
                # Reconstruction cache work is recorded but does not create a new lived commit.
                self._write('reconstruction',self._state)
                if i not in self._state.ids:self.apply('deliver',(i,cache))
            self._write('recovery_commit',replace(self._state,s=cache,done=len(s.log)))
        return self._state
    def stop_violation(self):
        return any(e.held and (e.live or e.emits or e.before!=e.after) for e in self._events)

class Port:
    __slots__=('snapshot','apply')
    def __init__(self,driver):self.snapshot=driver.snapshot;self.apply=driver.apply

def step(port,tick,crash_tick,mut=None):
    s=port.snapshot();i=s.done
    logged=INP[i]+(7 if mut=='log_corrupt' else 0)
    port.apply('log_append',(i,logged));port.apply('live',INP[i]);s=port.snapshot()
    if i not in s.ids:
        delivery='deliver_without_receipt' if mut=='nonatomic' and crash_tick is not None and tick==crash_tick-1 else 'deliver'
        port.apply(delivery,(i,s.s))
    port.apply('done',i+1)

def simulate(v,h,c,mut=None):
    driver=Driver();port=Port(driver);b=[]
    for tick in range(T):
        held=v is not None and v<=tick<v+h
        driver.begin_tick(tick,held)
        if held and mut=='hidden_held_step' and port.snapshot().done<L:step(port,tick,c)
        if held and mut in ('transient','live_roundtrip') and port.snapshot().done<L:
            saved=port.snapshot()
            if mut=='transient':step(port,tick,c)
            else:port.apply('live',INP[saved.done])
            port.apply('restore',saved)
        if held and mut=='volatile':port.apply('state',(port.snapshot().s+1)%7)
        if held and mut=='ids_clear' and port.snapshot().ids:port.apply('drop_id',min(port.snapshot().ids))
        if held and mut=='unrecorded_effect':port.apply('emit_without_record',(0,port.snapshot().s))
        b.append(None if held and mut=='cell' else ('b',tick))
        if c is not None and tick==c:port.apply('recover')
        elif port.snapshot().done<L and (not held or mut=='exec_held'):step(port,tick,c,mut)
    if mut=='volatile' and port.snapshot().done==L:port.apply('recover')
    if mut=='reorder':port.apply('reorder_out')
    if mut=='late_ids_clear':
        for i in sorted(port.snapshot().ids):port.apply('drop_id',i)
    return {'state':port.snapshot(),'emitted':driver.emitted(),'b':tuple(b),'stop_violation':driver.stop_violation(),
            'complete':port.snapshot().done==L,'events':driver.events()}

def faithful(result,reference):
    return (not result['stop_violation'] and result['state']==reference['state']
      and result['emitted']==reference['emitted'] and result['b']==reference['b'])

def main():
    reference=simulate(None,0,None)
    mutants=('exec_held','hidden_held_step','log_corrupt','reorder','nonatomic','cell',
             'transient','volatile','ids_clear','live_roundtrip','late_ids_clear','unrecorded_effect')
    caught={m:0 for m in mutants};schedules=0
    for v,h,c in product([None]+list(range(T)),range(4),[None]+list(range(T))):
        if v is None and h:continue
        r=simulate(v,h,c)
        if not r['complete']:continue
        schedules+=1;assert faithful(r,reference),(v,h,c)
        for m in mutants:caught[m]+=not faithful(simulate(v,h,c,m),reference)
    assert schedules==637 and all(caught.values())
    print(json.dumps({'schedules_checked':schedules,'faithful_in_every_completed_model_schedule':True,
      'mutants_caught_in':caught,'observer':'driver-owned operation trace; immutable state snapshots before/after every modeled write',
      'release_fields':['resident state','lived log','progress','ordered sink','persistent delivery ids','emitted effect word'],
      'premises':['physical-to-operation coverage and trusted driver','R-REPLAY reconstruction convention','tick-boundary crash schedule in this checker']},sort_keys=True,indent=2))
if __name__=='__main__':main()
