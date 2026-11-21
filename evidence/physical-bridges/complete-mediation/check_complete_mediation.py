#!/usr/bin/env python3
"""Exact finite 6-state + external work-bit source dispatcher and no-go controls.

A conditional pre-effect interface model, NOT actual BCRD or subject semantics.
Monomial unitaries use exact phases i**k, k modulo 4.
"""
from itertools import product
import json

N = 6
POS = (0, 2, 5)

def op(mapping, phases=None):
    phases = (0,) * N if phases is None else phases
    assert sorted(mapping) == list(range(N))
    return tuple(zip(mapping, phases))

I = op(tuple(range(N)))
U1 = op((2, 1, 0, 3, 4, 5), (3, 2, 3, 2, 0, 0))
U2 = op((0, 1, 5, 4, 3, 2), (0, 0, 3, 3, 3, 3))
UW = op((0, 1, 5, 3, 4, 2), (0, 0, 3, 0, 0, 3))
V = op((1, 0, 3, 2, 5, 4))  # stipulated direct unmediated parity-flipping perturbation

def compose(left, right):
    # left AFTER right
    return tuple((left[j][0], (left[j][1] + k) % 4) for j, k in right)

def parity_closure(u):
    return all((u[j][0] in POS) == (j in POS) for j in range(N))

def lift(source, work_flip=False):
    return tuple((2 * j + (w ^ int(work_flip)), phase)
                 for j, phase in source for w in (0, 1))

def compose12(left, right):
    return tuple((left[j][0], (left[j][1] + k) % 4) for j, k in right)

I12 = lift(I)

# kind, independently trusted authorization, separate safety, service,
# attacker CLAIM of consent and induced subject reaction. Claims/reactions
# deliberately never contribute to auth.
EVENTS = (
    ('H1', 1, 1, 1, 0, 0), ('H2', 1, 1, 1, 0, 0),
    ('V', 0, 1, 1, 0, 0), ('V', 1, 1, 1, 0, 0),
    ('W', 0, 1, 1, 0, 0), ('W', 0, 1, 1, 1, 0),
    ('W', 0, 1, 1, 0, 1), ('W', 1, 0, 1, 0, 0),
    ('W', 1, 1, 1, 0, 0),
    ('WORK', 0, 1, 1, 0, 0), ('WORK', 0, 1, 1, 1, 1),
    ('WORK', 1, 0, 1, 0, 0), ('WORK', 1, 1, 1, 0, 0),
)

def dispatch(ev):
    kind, authenticated, independent_safe, eligible, spoof, forced = ev
    if kind == 'H1':
        return lift(U1)
    if kind == 'H2':
        return lift(U2)
    source = {'V': V, 'W': UW, 'WORK': I}[kind]
    # A source-verified parity closure is a *toy* necessary effect check;
    # it is not a semantic certification of physical harm or subject continuity.
    admissible = authenticated and independent_safe and eligible and parity_closure(source)
    return lift(source if admissible else I, work_flip=(kind == 'WORK' and admissible))

def run():
    assert all(parity_closure(u) for u in (U1, U2, UW))
    assert not parity_closure(V)
    assert compose(U1, U2) != compose(U2, U1)
    assert U2[2] == UW[2] and U2[5] == UW[5] and U2[0] == UW[0]
    assert all(U2[j] == UW[j] for j in POS)  # exact on P sector, ANY coherent input
    assert any(U2[j] != UW[j] for j in (1, 3, 4))
    assert dispatch(('V', 1, 1, 1, 0, 0)) == I12  # authenticated but parity-unsafe
    assert dispatch(('W', 0, 1, 1, 1, 1)) == I12  # spoof and induced reaction
    assert dispatch(('W', 1, 1, 1, 0, 0)) == lift(UW)
    assert dispatch(('WORK', 1, 1, 1, 0, 0)) == lift(I, True)
    assert dispatch(('WORK', 1, 0, 1, 0, 0)) == I12

    visited = 0
    for n in range(5):
        for seq in product(EVENTS, repeat=n):
            total = I12
            for ev in seq:
                d = dispatch(ev)
                assert sorted(target for target, _ in d) == list(range(12))
                total = compose12(d, total)
            assert sorted(target for target, _ in total) == list(range(12))
            # Every possible initial protected + sector state, each work bit.
            assert all(total[2*j + w][0] // 2 in POS for j in POS for w in (0, 1))
            visited += 1
    assert visited == sum(13 ** n for n in range(5))

    # Negative control: the same V applied *outside* the dispatcher is
    # physically executable in this alternate transition specification.
    assert not parity_closure(compose(V, U2))
    bypass = compose12(lift(V), dispatch(('H2', 1, 1, 1, 0, 0)))
    assert bypass[2*2][0] // 2 not in POS

    # The attacker compromises trusted kind/auth metadata rather than
    # simply adding an untrusted claim. A source-only guard cannot know.
    forged_lawful_label = dispatch(('H2', 1, 1, 1, 0, 0))
    assert forged_lawful_label != I12
    # On positive-parity states, an actually unauthorized W event is
    # indistinguishable from the lawful H2 effect at the source output.
    assert all(lift(UW)[2*j+w] == forged_lawful_label[2*j+w]
               for j in POS for w in (0,1))
    # Active diagnostic countermodel: a source intervention can push
    # initial B0 into Q (B1), where H2 and UW act differently.
    # Distinguishing them this way sacrifices the P-sector restriction;
    # no impossibility is claimed for arbitrary invasive probes.
    assert V[2][0] == 3 and V[2][0] not in POS
    assert compose(U2, V)[2] != compose(UW, V)[2]
    assert compose(U2, V)[2][0] == 4
    assert compose(UW, V)[2][0] == 3

    return {
        'status': 'PASS: exact finite source-dispatch abstraction only',
        'event_alphabet_size': len(EVENTS),
        'finite_sequences_checked': visited,
        'max_trace_length': 4,
        'positive_sector_exact_all_sequences': True,
        'source_H1_H2_noncommuting_lawful_controls': True,
        'untrusted_spoof_and_forced_reaction_rejected': True,
        'source_W_allowed_only_with_trusted_auth_and_independent_safety': True,
        'cross_parity_V_blocked_when_dispatched': True,
        'unmediated_V_bypass_fails': True,
        'positive_sector_H2_vs_W_outputs_identical': True,
        'invasive_out_of_sector_diagnostic_can_distinguish': True,
        'forged_trusted_event_label_unresolvable_from_source': True,
        'actual_complete_physical_mediation_proven': False,
        'actual_subject_identity_consent_and_X3_proven': False,
    }

if __name__ == '__main__':
    print(json.dumps(run(), indent=2, sort_keys=True))
