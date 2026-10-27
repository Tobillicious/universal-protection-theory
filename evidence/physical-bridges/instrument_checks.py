#!/usr/bin/env python3
"""Independent finite model of IR-11's idealized controller/effect register."""
from itertools import product

events = [(kind, g) for kind in ("raise", "mint", "write") for g in (0, 1)]

def step(state, event):
    floor, minted, log, physical = state
    kind, g = event
    if kind == "raise":
        return max(floor, g), minted, log, physical
    if kind == "mint":
        return floor, (g,) + minted, log, physical
    if floor <= g and g in minted:
        return floor, minted, log + (g,), physical + g + 2
    return state

def verify():
    tested = 0
    for floor, have0, have1 in product((0, 1), repeat=3):
        minted = tuple(i for i, flag in enumerate((have0, have1)) if flag)
        for length in range(5):
            for trace in product(events, repeat=length):
                state = (floor, minted, (), 7)
                for event in trace:
                    state = step(state, event)
                    assert state[3] == 7 + sum(i + 2 for i in state[2])
                tested += 1
    assert tested == 12440, tested
    print(f"PASS: {tested} independent instrument/log trace checks")

if __name__ == "__main__":
    verify()
