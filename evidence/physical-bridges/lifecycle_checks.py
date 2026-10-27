#!/usr/bin/env python3
"""Independent bounded replay and negative controls for IR-31..IR-34.

These small synthetic transition models test implementation intent.
They do not certify actual sensors, epochs, queues, clocks, actuators,
continuous physical effects, or historical/subjective continuation.
"""
from dataclasses import dataclass, replace
from itertools import product


@dataclass(frozen=True)
class Plant:
    floor: int = 0
    durable: int = 0
    closed: bool = False
    flight: tuple = ()
    pending: tuple = ()
    landed: int = 0


def close(s, generation):
    return replace(s, floor=max(s.floor, generation + 1), closed=True)


def send(s, impact):
    return s if s.closed else replace(s, flight=s.flight + (impact,))


def arrive(s):
    if not s.flight:
        return s
    return replace(s, flight=s.flight[1:], pending=(s.flight[0],) + s.pending)


def deliver(s):
    if not s.pending:
        return s
    return replace(s, pending=s.pending[1:], landed=s.landed + s.pending[0])


COMMANDS = ("close", "send", "arrive", "deliver")


def step(s, command):
    return {
        "close": lambda: close(s, 0),
        "send": lambda: send(s, 1),
        "arrive": lambda: arrive(s),
        "deliver": lambda: deliver(s),
    }[command]()


def run(s, commands):
    for command in commands:
        s = step(s, command)
    return s


def held_no_effect_checks():
    tests = 0
    # A complete quiescent barrier stays closed after all modeled interleavings.
    for start_floor in (0, 1, 2):
        for length in range(6):
            for history in product(COMMANDS, repeat=length):
                initial = Plant(floor=start_floor, closed=True, landed=5)
                final = run(initial, history)
                assert final.closed and not final.flight and not final.pending
                assert final.landed == initial.landed
                tests += 1
    # In-flight work passes an empty pending-queue check but later lands.
    incomplete = Plant(closed=True, flight=(2,))
    assert not incomplete.pending
    assert run(incomplete, ("arrive", "deliver")).landed == 2
    # Completely empty backlogs do NOT prevent a new admission if open.
    open_plant = Plant()
    assert run(open_plant, ("send", "arrive", "deliver")).landed == 1
    # Closed admission with previously accepted pending work is insufficient.
    assert deliver(Plant(closed=True, pending=(3,))).landed == 3
    return tests


@dataclass(frozen=True)
class Epoch:
    durable: int
    live: int
    pending: tuple
    landed: int = 0


def committed_hold(s, g):
    return replace(s, durable=max(s.durable, g + 1),
                   live=max(s.live, g + 1))


def volatile_hold(s, g):
    return replace(s, live=max(s.live, g + 1))


def restart(s):
    return replace(s, live=s.durable)


def effect_apply(s):
    if not s.pending:
        return s
    token, impact = s.pending[0]
    return replace(s, pending=s.pending[1:],
                   landed=s.landed + (impact if s.live <= token else 0))


def epoch_step(s, command):
    if command == "hold":
        return committed_hold(s, 1)
    if command == "restart":
        return restart(s)
    return effect_apply(s)


def durable_epoch_checks():
    tests = 0
    for generation in (0, 1):
        for old_tokens in ((), (0,), (0, 0), (generation,), (generation, 0)):
            pending = tuple((token, 2) for token in old_tokens)
            start = committed_hold(Epoch(durable=0, live=0, pending=pending),
                                   generation)
            for length in range(6):
                for commands in product(("hold", "restart", "deliver"),
                                        repeat=length):
                    state = start
                    for command in commands:
                        state = epoch_step(state, command)
                    assert state.landed == 0
                    assert state.live >= generation + 1
                    assert state.durable >= generation + 1
                    tests += 1
    # Without durable persistence, restart can revive a disallowed token.
    faulty = volatile_hold(Epoch(durable=0, live=0, pending=((0, 2),)), 0)
    assert effect_apply(faulty).landed == 0
    assert effect_apply(restart(faulty)).landed == 2
    # With final-apply check, a queued old token is rejected after a hold.
    safe = committed_hold(Epoch(durable=0, live=0, pending=((0, 2),)), 0)
    assert effect_apply(safe).landed == 0
    return tests


if __name__ == "__main__":
    quiescent = held_no_effect_checks()
    epochs = durable_epoch_checks()
    assert quiescent > 3000 and epochs > 3000
    print(f"PASS: {quiescent} interleaved actuator/barrier traces; "
          f"{epochs} recovery/epoch traces; 5 physical-finality negative controls")
