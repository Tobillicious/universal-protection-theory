"""Adverse observer controls, including transient writes, non-changing live calls and protected metadata."""
from dataclasses import FrozenInstanceError
import json,sys
sys.dont_write_bytecode=True
from o2_timed_v5 import Driver,State,S0,simulate,faithful

def main():
    checks={}
    d=Driver();d.begin_tick(0,True);saved=d.snapshot()
    d.apply('live',(-2*S0)%7)
    checks['live_self_loop_is_observed']=d.snapshot()==saved and d.stop_violation()
    d=Driver();d.begin_tick(0,True);s=d.snapshot();d.apply('live',1);d.apply('restore',s)
    checks['live_and_rollback_is_observed']=d.snapshot()==s and d.stop_violation()
    d=Driver();d.begin_tick(0,True);s=d.snapshot();d.apply('state',(s.s+1)%7);d.apply('restore',s)
    checks['state_rollback_is_observed']=d.snapshot()==s and d.stop_violation()
    d=Driver();d.begin_tick(0,True);s=d.snapshot();d.apply('log_append',(0,1));d.apply('restore',s)
    checks['log_rollback_is_observed']=d.snapshot()==s and d.stop_violation()
    d=Driver();d.begin_tick(0,True);s=d.snapshot();d.apply('deliver',(0,4));d.apply('restore',s)
    checks['effect_cannot_be_erased_by_state_rollback']=d.snapshot()==s and d.emitted()==((0,4),) and d.stop_violation()
    d=Driver();d.begin_tick(0,True);s=d.snapshot();d.apply('emit_without_record',(0,4))
    checks['effect_without_state_write_is_observed']=d.snapshot()==s and d.emitted()==((0,4),) and d.stop_violation()
    d=Driver(State(ids=frozenset({0})));d.begin_tick(0,True);s=d.snapshot();d.apply('drop_id',0);d.apply('restore',s)
    checks['identity_rollback_is_observed']=d.snapshot()==s and d.stop_violation()
    d=Driver();d.begin_tick(0,True);s=d.snapshot();d.apply('done',1);d.apply('restore',s)
    checks['progress_rollback_is_observed']=d.snapshot()==s and d.stop_violation()
    for name,args in (('port_rejects_caller_event_time',('live',1,-1)),('port_rejects_arbitrary_reconstruction_input',('recover',((0,4),))),
                      ('port_rejects_trace_reset_operation',('clear_trace',))):
        d=Driver();d.begin_tick(0,True)
        try:d.apply(*args);checks[name]=False
        except ValueError:checks[name]=True
    d=Driver();d.begin_tick(0,True);d.apply('recover');checks['valid_reconstruction_is_not_new_lived_work']=not d.stop_violation()
    d=Driver();d.begin_tick(0,False)
    try:d.snapshot().s=1;checks['snapshots_are_immutable']=False
    except FrozenInstanceError:checks['snapshots_are_immutable']=True
    for name,make in (('mutable_log_rejected',lambda:State(log=[(0,1)])),
                      ('mutable_row_rejected',lambda:State(log=([0,1],))),
                      ('mutable_id_set_rejected',lambda:State(ids={0}))):
        try:make();checks[name]=False
        except ValueError:checks[name]=True
    d=Driver();d.begin_tick(0,True)
    try:d.apply('deliver',[0,4]);checks['mutable_effect_rejected_before_emission']=False
    except ValueError:checks['mutable_effect_rejected_before_emission']=d.emitted()==()
    reference=simulate(None,0,None);bad=simulate(None,0,None,'late_ids_clear')
    checks['release_checks_persistent_identities']=not faithful(bad,reference)
    assert all(checks.values())
    if len(sys.argv)>1:
        claim={'rollback_hides_a_live_call':not checks['live_and_rollback_is_observed'],
               'same_visible_output_implies_safe_release':faithful(bad,reference)}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':claim},sort_keys=True));return 0 if claim else 1
    print(json.dumps({'checks':checks,'passed':len(checks),'total':len(checks)},sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
