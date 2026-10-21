"""Exact boundary witnesses for strictness, observation congruence and the delivery interface."""
from fractions import Fraction as F
import json,sys
sys.dont_write_bytecode=True
from e7_full_check import ge,dom,law

def main():
    H=((2,2),(2,2));A=((2,2),(2,0));null=(F(1),F(0));positive=(F(1,2),F(1,2))
    assert all(ge(h,a) for h,a in zip(H,A))
    assert {k:v for k,v in law(H,null).items() if v}=={k:v for k,v in law(A,null).items() if v}
    assert dom(H,A,null) and dom(A,H,null)
    assert dom(H,A,positive) and not dom(A,H,positive)
    # A distinguishing query is an alternative interface to a persistent per-effect ID in this toy model.
    queried_totals=[]
    for already_done in (False,True):
        resend=not already_done;queried_totals.append(int(already_done)+int(resend))
    assert queried_totals==[1,1]
    # Congruence preserves equal observations under equal actions; it does not freeze the observation.
    observation=lambda s:s[0];step=lambda s,a:(s[0]+a,not s[1])
    states=[(s,cache) for s in range(4) for cache in (False,True)]
    for s in states:
        for t in states:
            if observation(s)==observation(t):
                for a in range(4):assert observation(step(s,a))==observation(step(t,a))
    assert observation(step((0,False),1))!=observation((0,False))
    if len(sys.argv)>1:
        claim={'zero_probability_loss_forces_strict_dominance':not dom(A,H,null),
               'every_sufficient_effect_interface_needs_a_sink_id':any(x!=1 for x in queried_totals)}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':claim},sort_keys=True));return 0 if claim else 1
    print(json.dumps({'null_loss_need_not_be_strict':True,'positive_probability_loss_is_strict_in_witness':True,
      'query_interface_effect_totals':queried_totals,'congruence_does_not_mean_constant_observation':True,
      'scope':'Finite witnesses clarify already-stated premises; they are not universal physical impossibility or hardware claims.'},sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
