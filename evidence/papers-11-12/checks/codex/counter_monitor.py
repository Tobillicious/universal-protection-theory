"""A protected event counter: exact detection scope, rollback witness, wrap and coverage controls."""
from itertools import product
import json,sys
sys.dont_write_bytecode=True

# Flags: held, new lived commit, new external effect. Reconstruction alone has neither commit flag.
alphabet=tuple(product((False,True),repeat=3))
def forbidden(e):return e[0] and (e[1] or e[2])
def count(word):return sum(forbidden(e) for e in word)
def clean(word):return all(not forbidden(e) for e in word)

def main():
    words=0;bad=0
    for length in range(6):
        for word in product(alphabet,repeat=length):
            k=count(word);assert (k==0)==clean(word)
            assert 17+k>=17 and ((17+k)==17)==clean(word)
            for cut in range(length+1):
                assert count(word[:cut])+count(word[cut:])==k
                assert count(word[:cut])<=k
            words+=1;bad+=not clean(word)
    # A new lived step and rollback can restore every ordinary endpoint field.
    ordinary_states=(0,1,0);events=((True,True,False),(True,False,False))
    assert ordinary_states[0]==ordinary_states[-1] and count(events)==1 and not clean(events)
    wrapped=(count(((True,True,False),)*2)%2==0)
    omitted=clean(()) and not clean(((True,True,False),))
    assert wrapped and omitted
    # A count alone deliberately does not certify the content or order of delivered effects.
    assert len((3,7))==len((7,3)) and (3,7)!=(7,3)
    result={'event_alphabet_size':len(alphabet),'maximum_word_length':5,'event_words':words,'violating_words':bad,
      'exact_no_forbidden_event_certificate':True,'rollback_witness_caught':True,
      'finite_width_wrap_can_hide_violation':wrapped,'incomplete_event_source_can_hide_violation':omitted,
      'scope':'A protected, non-wrapping counter over a complete trusted event trace certifies absence of its named event class. Event granularity and commit classification are supplied premises; content/order integrity, continuation, physical execution and subjective life are separate properties.'}
    if len(sys.argv)>1:
        ok={'wrapping_counter_is_always_complete':not wrapped,
            'incomplete_event_coverage_is_always_complete':not omitted,
            'effect_count_alone_preserves_order':(3,7)==(7,3)}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':ok},sort_keys=True));return 0 if ok else 1
    print(json.dumps(result,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
