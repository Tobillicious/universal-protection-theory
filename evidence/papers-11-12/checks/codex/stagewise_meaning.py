"""Compare exact canonical alignment with stagewise predicates, over all small families."""
from itertools import product
from collections import Counter
import json,sys
sys.dont_write_bytecode=True

def sub(a,b):return a&~b==0
def better(a,b):
    for x,y in zip(a,b):
        if x==y:continue
        return sub(x,y)
    return False

def aligned(family,F,i):return i in F and not any(better(family[i],family[j]) for j in F)

def no_needless(family,F,i,keep_current=True):
    a=family[i]
    for stage in range(len(a)):
        for j in F:
            b=family[j]
            if all(a[k]==b[k] for k in range(stage)):
                if (not keep_current or sub(a[stage],b[stage])) and b[stage]&~a[stage]:return False
    return True

def no_weak_prefix_needless(family,F,i):
    a=family[i]
    for stage in range(len(a)):
        for j in F:
            b=family[j]
            if all(sub(a[k],b[k]) for k in range(stage+1)) and b[stage]&~a[stage]:return False
    return True

def main():
    count=Counter();first=None
    outcomes=tuple(product(range(4),repeat=2))
    for family in product(outcomes,repeat=3):
        for mask in range(8):
            F=tuple(i for i in range(3) if mask>>i&1)
            for i in range(3):
                a=aligned(family,F,i)
                good=(i in F and no_needless(family,F,i))
                assert a==good
                assert a==(i in F and no_weak_prefix_needless(family,F,i))
                count['weak_prefix_equivalences']+=1
                bad=(i in F and no_needless(family,F,i,False))
                count['alignment_equivalences']+=1
                if a!=bad:
                    count['printed_predicate_disagreements']+=1
                    if first is None:first={'family':family,'feasible':F,'chosen':i,'aligned':a,'printed_no_needless':bad}
    # The key incomparable pair: saving another resident while losing one currently kept.
    f=((1,0),(2,0));F=(0,1)
    assert aligned(f,F,0) and aligned(f,F,1)
    assert no_needless(f,F,0) and not no_needless(f,F,0,False)
    assert no_needless(f,(),0) and not aligned(f,(),0)
    result={'persons':2,'stages':2,'options':3,**count,'first_disagreement':first,
      'explicit_incomparable_family':f,
      'scope':'The corrected predicate matches the captured Lean recursion: equal earlier keys, current-key containment and a newly kept individual. Feasibility of the chosen option is retained. This characterises the supplied order; it does not choose the moral order.'}
    if len(sys.argv)>1:
        ok={'omitting_current_containment_preserves_equivalence':count['printed_predicate_disagreements']==0,
            'no_needless_without_feasibility_implies_alignment':aligned(f,(),0)}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(result,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
