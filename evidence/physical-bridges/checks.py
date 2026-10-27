#!/usr/bin/env python3
"""Tiny independent finite countermodels. Complements; does not replace Lean."""
def guard(obs, eps, drift, jump, threshold):
    return obs + eps + drift + jump <= threshold

def check():
    n = 0
    counter = 0
    for obs in range(5):
        for eps in range(3):
            for drift in range(3):
                for jump in range(4):
                    for threshold in range(13):
                        for actual_sample in range(obs + eps + 1):
                            for actual_after in range(actual_sample + drift + jump + 1):
                                n += 1
                                if guard(obs, eps, drift, jump, threshold):
                                    assert actual_after <= threshold
                                if obs + eps + drift <= threshold < actual_after:
                                    counter += 1
    assert counter > 0
    print(f"PASS: {n} post-effect finite checks; {counter} pre-effect-only counterexamples")

if __name__ == "__main__":
    check()
