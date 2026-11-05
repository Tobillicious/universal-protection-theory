#!/usr/bin/env python3
"""Executable IR-133 source/enactment certificate counterchecks.

Independent finite transition, sensor, event, generator and source-action
tables. Mutants must FAIL the precise missing physical premise instead of
allowing a digital record to act as a physics/authorization oracle.

This is a synthetic four-state model. It proves no real sensor captures
actual BCRD or that actual hardware has an unbypassable output path.
"""
from copy import deepcopy

FIELDS = (
    "separates", "dagCaptured", "fluxCaptured", "gaugeCaptured",
    "actuatorCaptured", "neutralCaptured",
    "authenticGenerator", "enforcedAction",
)


def base_fixture():
    return {
        "states": [0,1,2,3],
        "real": {(0,1),(1,2),(2,3),(3,3)},
        "observations": {0:0,1:1,2:0,3:1},
        "readouts": {
            0:(0,0,0,0),
            1:(0,1,0,0),
            2:(1,0,0,0),
            3:(1,1,0,1),
        },
        "captured": {
            (0,1,"act01"),
            (1,2,"environment12"),
            (2,3,"act23"),
            (3,3,"neutral33"),
        },
        # These are a separate source definition, NOT inferred from
        # digital capture or from the selected physical effect.
        "source_generators": {
            (0,1,"act01"),
            (1,2,"environment12"),
            (2,3,"act23"),
            (3,3,"neutral33"),
        },
        "policy": {0:"hold",1:"release"},
        "source_action": {
            (0,"hold",1),
            (1,"release",2),
            (2,"hold",3),
            (3,"release",3),
        },
    }


def requirements(model):
    r = model["readouts"]
    physical = model["real"]
    captured = model["captured"]
    source = model["source_generators"]
    actions = model["source_action"]
    policy = model["policy"]
    observe = model["observations"]

    # Independent equivalence is strict equality in this synthetic
    # model. A real application would need a justified physical
    # equivalence that preserves every protected subject and option.
    separated = all(
        p == q or r[p] != r[q]
        for p,q in physical
    )
    checks = {"separates": separated}
    for j,name in enumerate(FIELDS[1:5]):
        checks[name] = all(
            r[p][j] == r[q] or
            any(x==p and y==q for x,y,_ in captured)
            for p,q in physical
        )
    checks["neutralCaptured"] = all(
        p != q or any(x==p and y==q for x,y,_ in captured)
        for p,q in physical
    )
    checks["authenticGenerator"] = all(
        (p,q,e) in source for p,q,e in captured
    )
    # The choice of source action is determined by the OBSERVED state,
    # not by peeking at the target state or an event that just happened.
    checks["enforcedAction"] = all(
        (p,policy[observe[p]],q) in actions
        for p,q,e in captured
    )
    if set(checks) != set(FIELDS):
        raise AssertionError("incomplete exact theorem interface")
    return checks


def accepted(model):
    checks = requirements(model)
    return all(checks.values()) and all(
        any(x==p and y==q for x,y,_ in model["captured"])
        for p,q in model["real"]
    )


def test():
    good = base_fixture()
    assert set(good["states"]) == set(good["observations"]) == set(good["readouts"])
    checks = requirements(good)
    assert all(checks.values()) and accepted(good),checks

    variants = []

    hidden = deepcopy(good)
    hidden["states"].append(4)
    hidden["readouts"][4] = good["readouts"][0]
    hidden["observations"][4] = good["observations"][0]
    hidden["real"].add((0,4))
    variants.append(("hidden fifth physical coordinate",hidden,"separates"))

    missed = deepcopy(good)
    missed["captured"].remove((0,1,"act01"))
    variants.append(("observable but uncaptured real event",missed,"fluxCaptured"))

    neutral = deepcopy(good)
    neutral["captured"].remove((3,3,"neutral33"))
    variants.append(("unrecorded real neutral step",neutral,"neutralCaptured"))

    forged = deepcopy(good)
    forged["source_generators"].remove((1,2,"environment12"))
    variants.append(("captured event lacking authentic source generator",forged,"authenticGenerator"))

    bypass = deepcopy(good)
    bypass["source_action"].remove((1,"release",2))
    variants.append(("captured and sourced but not actually mediated",bypass,"enforcedAction"))

    wrong_policy = deepcopy(good)
    wrong_policy["policy"][1] = "hold"
    variants.append(("source action exists but was not selected",wrong_policy,"enforcedAction"))

    for title, mutant, expected in variants:
        got = requirements(mutant)
        assert not got[expected],(title,got)
        assert not accepted(mutant),title
        print("REFUSED",title,":",expected)

    print("PASS complete finite source/event/action certificate")
    print("PASS all six independent missing-seam mutation counterchecks")
    print("LIMIT: synthetic finite model, NOT a physical BCRD installation")


if __name__ == "__main__":
    test()
