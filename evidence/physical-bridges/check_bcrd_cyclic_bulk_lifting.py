#!/usr/bin/env python3
"""Finite BCRD-style history controls. Not BCRD source/physical validation."""
import unittest


def run_identity(x):
    return {"initial": x, "final": x, "intermediate": (), "events": ("pass",)}


def run_two_stage(x, intervention):
    first = 1 - x
    final = 1 - first
    return {"initial": x, "final": final,
            "intermediate": (first, intervention),
            "events": ("flip-in", "marker-read", "flip-out")}


class CutAndBulkControls(unittest.TestCase):
    def test_same_exterior_not_unique_bulk(self):
        for x in range(2):
            self.assertEqual(run_identity(x)["final"], run_two_stage(x, 0)["final"])
            self.assertNotEqual(run_identity(x)["events"], run_two_stage(x, 0)["events"])
            self.assertNotEqual(run_identity(x)["intermediate"], run_two_stage(x, 0)["intermediate"])

    def test_open_causality_and_nondegenerate_updates(self):
        for x in range(2):
            r = run_two_stage(x, 0)
            self.assertNotEqual(x, r["intermediate"][0])
            self.assertEqual(x, r["final"])
            self.assertEqual(len(r["events"]), 3)

    def test_internal_intervention_witness_preserved_by_gluing(self):
        for x in range(2):
            a, b = run_two_stage(x, 0), run_two_stage(x, 1)
            self.assertEqual(a["final"], b["final"])
            self.assertNotEqual(a["intermediate"], b["intermediate"])

    def test_repeated_trace_requires_program_and_intervention(self):
        for x in range(2):
            for i in range(2):
                a = run_two_stage(x, i)
                b = run_two_stage(a["final"], i)
                self.assertEqual(a, b)

    def test_closed_boundary_does_not_determine_intervention_record(self):
        a = run_two_stage(0, 0)
        b = run_two_stage(0, 1)
        self.assertEqual((a["initial"], a["final"]), (b["initial"], b["final"]))
        self.assertNotEqual(a["intermediate"], b["intermediate"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
