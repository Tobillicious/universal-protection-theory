"""IR-140: joint maximality does not imply worldwise maximality. Exact finite check."""

WORLDS = ("w0", "w1")
STAGES = range(4)
POLICIES = ("left", "right")
OUTCOMES = {
    "left": {(0, "w0", "a")},
    "right": {(0, "w1", "b")},
}


def stage_projection(outcome, stage, world=None):
    return {
        (w, p) for k, w, p in outcome
        if k == stage and (world is None or w == world)
    }


def lex_better(challenger, incumbent, world=None):
    """Lean LexBetter orientation: challenger first differs by strict superset."""
    for k in STAGES:
        s = stage_projection(incumbent, k, world)
        t = stage_projection(challenger, k, world)
        if s == t:
            continue
        return s < t
    return False


def verify():
    # Neither jointly realised fact-set has a strict feasible improvement.
    for q in POLICIES:
        assert not any(
            lex_better(OUTCOMES[rival], OUTCOMES[q])
            for rival in POLICIES
        )

    # Each has a world in which another feasible policy strictly improves it.
    assert lex_better(OUTCOMES["right"], OUTCOMES["left"], "w1")
    assert lex_better(OUTCOMES["left"], OUTCOMES["right"], "w0")
    assert all(
        any(lex_better(OUTCOMES[rival], OUTCOMES[q], w)
            for rival in POLICIES)
        for q in POLICIES
        for w in WORLDS
        if (q, w) in (("left", "w1"), ("right", "w0"))
    )

    # The top-policy theorem's stronger union closure cannot be assumed.
    union = OUTCOMES["left"] | OUTCOMES["right"]
    assert not any(union <= OUTCOMES[q] for q in POLICIES)

    # Decision observations are identical; the policy cannot reveal the world.
    observations = {"w0": "?", "w1": "?"}
    assert len(set(observations.values())) == 1

    # Discrete finite policy space is compact, and every subset is closed.
    # Empty baseline and no freedom-stage facts satisfy prerequisites.
    assert not any(k in (1, 3) for o in OUTCOMES.values()
                   for k, _, _ in o)
    print("IR-140 PASS: 2 worlds, 2 policies, 4-stage exact negative control")


if __name__ == "__main__":
    verify()

