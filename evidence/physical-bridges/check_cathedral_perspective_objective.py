#!/usr/bin/env python3
"""Independent finite check: local cut truth is not whole-state reconstruction.

Synthetic controls only. Does not certify actual BCRD physics or physical X3.
"""
from itertools import product


def exact_decoder_exists(cut, label):
    fibres = {}
    for state, view in enumerate(cut):
        value = label[state]
        if view in fibres and fibres[view] != value:
            return False
        fibres[view] = value
    return True


def check_fibres():
    cases = 0
    blind = 0
    for n in range(1, 5):
        for cut in product(range(n), repeat=n):
            for label in product((False, True), repeat=n):
                expected = all(
                    cut[s] != cut[t] or label[s] == label[t]
                    for s in range(n) for t in range(n)
                )
                assert exact_decoder_exists(cut, label) == expected
                if not expected:
                    blind += 1
                    assert any(
                        cut[s] == cut[t] and label[s] != label[t]
                        for s in range(n) for t in range(n)
                    )
                cases += 1
            if any(cut[s] == cut[t] and s != t
                   for s in range(n) for t in range(n)):
                # A lossy cut cannot decode the complete source identity.
                assert not exact_decoder_exists(cut, tuple(range(n)))
            else:
                assert exact_decoder_exists(cut, tuple(range(n)))
    return cases, blind


def check_source_continuity():
    # X={0,1}, Y={0,1,2}: certified live embedding of a toggling source.
    source_gen = (1, 0)
    target_gen = (1, 0, 2)
    embedding = (0, 1)
    source_live = (True, True)
    target_live = (True, True, False)
    blind_cut = (0, 0, 0)
    assert len(set(embedding)) == len(embedding)
    for x in range(2):
        assert target_live[embedding[x]]
        assert embedding[source_gen[x]] == target_gen[embedding[x]]
        assert source_live[source_gen[x]]
        state = embedding[x]
        for _ in range(300):
            assert target_live[state]
            state = target_gen[state]
    assert blind_cut[embedding[0]] == blind_cut[2]
    assert not target_live[2]
    assert not exact_decoder_exists(blind_cut, target_live)
    # Negative control: without retained-live, the preserved orbit fails.
    broken_target_live = (True, False, False)
    assert not all(broken_target_live[embedding[x]] for x in range(2))
    # Negative control: a full-information cut can decide liveness.
    exact_cut = (0, 1, 2)
    assert exact_decoder_exists(exact_cut, target_live)


def check_x3_join():
    # Actual run uses 0->1; alternative 2 is a DIFFERENT candidate physical
    # state with the same observer readout and fails original-X3 predicate.
    actual_edges = {(0, 1), (1, 0)}
    model_edges = actual_edges | {(2, 2)}
    sector = (True, True, False)
    x3 = (True, True, False)
    view = (0, 0, 0)
    assert actual_edges.issubset(model_edges)
    assert all(not sector[a] or sector[b] for a, b in model_edges)
    assert all(not sector[s] or x3[s] for s in range(3))
    assert (0, 1) in actual_edges and sector[0] and x3[1]
    assert view[1] == view[2] and not x3[2]
    assert not exact_decoder_exists(view, x3)
    # Negative control: if sector entails original X3 is dropped, protection
    # cannot be inferred from membership in an otherwise closed sector.
    counter_x3 = (True, False, False)
    assert sector[1] and not counter_x3[1]
    assert all(not sector[a] or sector[b] for a, b in model_edges)


if __name__ == "__main__":
    cases, blind = check_fibres()
    check_source_continuity()
    check_x3_join()
    print(f"PASS: {cases} exact observation/label cases; {blind} lossy-label cases")
    print("PASS: represented live orbit, blind-cut X3 and hostile controls")
