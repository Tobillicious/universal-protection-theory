"""Exact conditioning/error bounds, sharp witnesses and adversarial stopping calculations."""
from fractions import Fraction as F
from itertools import product
import json,sys
sys.dont_write_bytecode=True

def compositions(n,k):
    if k==1:yield(n,);return
    for i in range(n+1):
        for rest in compositions(n-i,k-1):yield(i,)+rest

def tv(a,b):return sum(abs(x-y) for x,y in zip(a,b))/2

def conditional_options(p,m):
    q=len(p);cut=m*(q//m);acc=sum(p[:cut],F(0))
    return None if not acc else tuple(sum(p[k:cut:m],F(0))/acc for k in range(m))

def main():
    scans=[];count=0
    for q,N,ms in ((3,12,(2,3)),(5,20,(2,3,4,5)),(7,7,(3,4,5,7))):
        laws=list(compositions(N,q));checked=0;sharp=0
        Q=(F(1,q),)*q
        for p0 in laws:
            p=tuple(F(z,N) for z in p0);eps=tv(p,Q)
            for m in ms:
                option=conditional_options(p,m)
                if option is None:continue
                a=F(m*(q//m),q);delta=tv(option,(F(1,m),)*m)
                bound=min(F(m-1,m),eps/a)
                assert delta<=bound,(q,p,m,delta,bound)
                sharp+=delta==bound;checked+=1
        scans.append({'q':q,'denominator':N,'raw_laws':len(laws),'option_laws_checked':checked,'bound_equalities':sharp});count+=checked
    # A sharp family: move epsilon of raw probability from accepted residue 1 to accepted residue 0.
    epsilon=F(1,100);a=F(3,5)
    P=[F(1,5)]*5;P[0]+=epsilon;P[1]-=epsilon
    law=conditional_options(P,3)
    assert law==(F(7,20),F(19,60),F(1,3)) and tv(law,(F(1,3),)*3)==epsilon/a==F(1,60)
    # At the larger endpoint the cap 1-1/m is attained exactly.
    P=[F(1,5)]*5;P[0]+=F(2,5);P[1]=P[2]=F(0)
    assert conditional_options(P,3)==(F(1),F(0),F(0)) and tv(P,(F(1,5),)*5)==F(2,5)
    # All denominator-20 raw laws at TV <=1/20: dynamic history-dependent strategies cannot beat
    # max P(accepted-in-B)/P(accepted). This fixed point is a super-solution of every Bellman step.
    Q=(F(1,5),)*5;eps=F(1,20)
    admissible=[tuple(F(x,20) for x in z) for z in compositions(20,5) if tv(tuple(F(x,20) for x in z),Q)<=eps]
    assert len(admissible)==21
    adaptive=[]
    for Bmask in range(1,7):
        B={j for j in range(3) if Bmask>>j&1}
        ratios=[sum((p[j] for j in B),F(0))/sum(p[:3],F(0)) for p in admissible]
        upper=max(ratios);lower=min(ratios);uniform=F(len(B),3)
        assert upper-uniform<=eps/a and uniform-lower<=eps/a
        v=F(0)
        for _ in range(24):v=max(sum((p[j] for j in B),F(0))+(p[3]+p[4])*v for p in admissible)
        assert v<=upper and upper-v<=max(p[3]+p[4] for p in admissible)**24
        adaptive.append({'event':sorted(B),'min_eventual':str(lower),'max_eventual':str(upper),'uniform':str(uniform),'upper_minus_24_round_mass':str(upper-v)})
    target=F(1,1000);per_round=a*target;contributors=4;per_call=per_round/contributors
    assert per_call==F(3,20000) and contributors*per_call/a==target
    # Summable schedule is a separate sufficient route when guarantees are expressed as failure events.
    first16=sum((target/F(2**r) for r in range(1,17)),F(0));remaining=target/F(2**16)
    assert first16+remaining==target
    # A call can have no incorrect output and still not return: the waiting state is a fixed point.
    waiting_step=lambda state:state
    terminal=lambda state:state=='returned'
    state='waiting'
    assert waiting_step(state)==state and not terminal(state)
    # Two explicit finite-cap contracts. Abort remains a reported output, not hidden by conditioning.
    cap_target=F(1,1000);cap_eps=a*cap_target/2
    rejection_bound=1-a+cap_eps;N=1
    while rejection_bound**N>cap_target/2:N+=1
    assert N==9 and cap_eps/a+rejection_bound**N<=cap_target
    # Alternatively couple all calls to an ideal resource: at most N*n failure events and ideal abort tail.
    ideal_abort=(1-a)**N
    cap_per_call=(cap_target-ideal_abort)/(N*contributors)
    assert cap_per_call>0 and N*contributors*cap_per_call+ideal_abort==cap_target
    out={'conditioning_scans':scans,'conditional_laws_checked':count,
      'sharp_bound':'min(1-1/m, epsilon/a), a=m*floor(q/m)/q',
      'sharp_small_error':{'per_round_tv':str(epsilon),'acceptance':str(a),'eventual_law':list(map(str,law)),'eventual_tv':str(epsilon/a)},
      'adversarial_raw_laws':len(admissible),'adaptive_event_bounds':adaptive,
      'constant_budget_candidate':{'desired_complete_tv':str(target),'per_round_tv_budget':str(per_round),'contributors':contributors,'per_call_failure_budget':str(per_call)},
      'summable_budget':{'first16':str(first16),'remaining':str(remaining),'total':str(target)},
      'safety_without_call_termination_witness':{'initial_state':state,'successor':waiting_step(state),'has_incorrect_output':False,'has_returned':terminal(state)},
      'finite_cap_candidate':{'attempt_cap':N,'complete_error_target':str(cap_target),'conditional_raw_tv_budget':str(cap_eps),
        'rejection_abort_bound':str(rejection_bound**N),'extended_output_tv_bound':str(cap_eps/a+rejection_bound**N),
        'alternative_coupling_per_call_failure_budget':str(cap_per_call),'ideal_abort_probability':str(ideal_abort),
        'scope':'An extended output alphabet reports abort. Every attempt or call needs a supplied finite time bound; timeout failure is charged rather than silently conditioned away.'},
      'termination_assumption':'Every attempt returns a well-typed field value; conditional per-round TV <=epsilon<a implies acceptance >=a-epsilon at every history and almost-sure geometric termination.',
      'scope':'The theorem bounds permitted error, not an attack on an implemented VSS protocol. Conditional-on-history guarantees and call termination are explicit premises.'}
    if len(sys.argv)>1:
        ok={'raw_round_error_survives_conditioning_unamplified':epsilon/a<=epsilon,
            'output_correctness_alone_proves_call_termination':terminal(waiting_step(state))}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(out,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
