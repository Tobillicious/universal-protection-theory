#!/usr/bin/env python3
"""Exact/elementary checks for Bridges 1-2 (research witnesses, not physical proof)."""
import math
import unittest
from fractions import Fraction

class BridgeChecks(unittest.TestCase):
    def test_false_intermediate_bound(self):
        d = 0.1
        alleged_lower = (math.sqrt(1-d*d)-d)**2
        intended_lower = 1-4*d*d
        self.assertLess(alleged_lower, intended_lower)

    def test_correct_invariant_capacity_example(self):
        # P=|p><p|, p=(cos a,sin a); R=|0><0|;
        # U(t)=diag(1,exp(-it)), [U,R]=0; ||P-R||=sin a.
        for a in (0.05, 0.1, 0.3):
            c, s = math.cos(a), math.sin(a)
            floor = 1-4*s*s
            for t in (0, math.pi/2, math.pi, 13*math.pi, 1234.5):
                capacity = abs(c*c+s*s*complex(math.cos(t),-math.sin(t)))**2
                self.assertGreaterEqual(capacity+1e-12, floor)

    @staticmethod
    def memory_reduced(psi):
        return tuple(tuple(sum(psi[2*a+r]*psi[2*b+r].conjugate()
                               for r in range(2))
                           for b in range(2)) for a in range(2))

    @staticmethod
    def cnot(psi):
        return (psi[0],psi[1],psi[3],psi[2])

    def test_qnd_basis_readout_not_arbitrary_state_preservation(self):
        root = math.sqrt(.5)
        for sign in (1,-1):
            initial = (root,0,sign*root,0)
            outcome = self.cnot(initial)
            reduced = self.memory_reduced(outcome)
            self.assertAlmostEqual(reduced[0][0], .5)
            self.assertAlmostEqual(reduced[1][1], .5)
            self.assertAlmostEqual(abs(reduced[0][1]), 0)
            self.assertAlmostEqual(abs(reduced[1][0]), 0)
        for bit in (0,1):
            psi = [0j]*4
            psi[2*bit] = 1+0j
            reduced = self.memory_reduced(self.cnot(psi))
            self.assertAlmostEqual(reduced[bit][bit],1)
            self.assertAlmostEqual(reduced[1-bit][1-bit],0)

    def test_control_cost_not_necessarily_optimal(self):
        costs=(10,0)
        selected_by_memory=0
        self.assertGreater(costs[selected_by_memory], min(costs))

    def test_norm_does_not_imply_metabolic_threshold(self):
        delta=Fraction(1)
        theta=Fraction(1,5)
        ctrl_norm=Fraction(2,5)
        ctrl_expectation=Fraction(2,5)
        self.assertLess(ctrl_norm,delta/2)
        self.assertGreater(ctrl_expectation,theta*delta)

    def test_three_gate_conditions_do_not_imply_six(self):
        trusted_grant=True
        current_history=True
        enough_battery=True
        self.assertTrue(trusted_grant and current_history and enough_battery)
        held=True
        full_permit=(trusted_grant and current_history and enough_battery
                     and not held)
        self.assertFalse(full_permit)

    def test_energy_exchange_with_memory_label_unchanged(self):
        j=0.8
        for t in (0,math.pi/(4*j),math.pi/(2*j)):
            battery=math.cos(j*t)**2
            target=math.sin(j*t)**2
            memory_label_capacity=1
            self.assertAlmostEqual(battery+target,1)
            self.assertEqual(memory_label_capacity,1)
        self.assertAlmostEqual(math.sin(j*math.pi/(2*j))**2,1)

if __name__ == '__main__':
    unittest.main(verbosity=2)
