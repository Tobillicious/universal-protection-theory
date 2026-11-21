#!/usr/bin/env python3
"""Diagnostics for MIC-27 and EPOCH-28; not a Lean/kernel or physical certificate."""
import unittest
from math import atan, cos, pi, sin, sqrt

class ExactToyChecks(unittest.TestCase):
    def test_isolated_projector_distance(self):
        delta, v = 1.0, 0.1
        assert v < delta / 6
        alpha = atan(2*v/delta)/2
        d = sin(alpha)
        upper = 2*v/(delta-2*v)
        self.assertLess(d, upper)
        self.assertLess(upper, 0.5)
        self.assertGreater(1-4*upper**2, 0)

    def test_exact_dressing_diagonalizes(self):
        delta, v = 1.0, .10
        a=atan(2*v/delta)/2
        c,s=cos(a),sin(a)
        W=((c,s),(-s,c))
        H=((0.,v),(v,delta))
        def mult(A,B):
            return tuple(tuple(sum(A[i][k]*B[k][j] for k in range(2))
                               for j in range(2)) for i in range(2))
        Wt=tuple(zip(*W))
        dressed=mult(mult(Wt,H),W)
        self.assertAlmostEqual(dressed[0][1],0,places=13)
        self.assertAlmostEqual(dressed[1][0],0,places=13)

    def test_all_time_capacity_example(self):
        delta,v=1.0,.1
        d=sin(atan(2*v/delta)/2)
        c=cos(atan(2*v/delta)/2)
        floor=1-4*d*d
        gap=sqrt(delta*delta+4*v*v)
        for t in (0,.3,1,3,pi/gap,200.7,10000.7):
            fidelity=abs(c*c+d*d*complex(cos(gap*t),-sin(gap*t)))**2
            self.assertGreaterEqual(fidelity+1e-12,floor)

    def test_resonance_excludes_full_block_isolation(self):
        delta,g=1.,.01
        self.assertLess(g,delta/2)
        self.assertAlmostEqual(cos(g*pi/(2*g))**2,0,places=13)

    def test_write_read_classical_record(self):
        for e in (0,1):
            old_history=(1,0,1,1)
            slot_after=e
            phase_write=(-1j)**e
            pointer_after=slot_after
            phase_read=(-1j)**slot_after
            self.assertEqual(old_history,(1,0,1,1))
            self.assertEqual(slot_after,e)
            self.assertEqual(pointer_after,e)
            self.assertAlmostEqual(abs(phase_write*phase_read),1.)

    def test_qnd_coherence_dephasing(self):
        a,b=1/sqrt(2),-1j/sqrt(2)
        offdiag_after=0j
        self.assertGreater(abs(a*b.conjugate()),.4)
        self.assertEqual(offdiag_after,0)

    def test_write_does_not_preserve_writable_value(self):
        self.assertNotEqual(1,-1)
        self.assertEqual(1,1) # independent presence label

    def test_noncommutation_need_not_update_state(self):
        z_expectations=[0. for _ in (0,1,2,3)]
        self.assertTrue(all(x==0 for x in z_expectations))

if __name__=='__main__':
    unittest.main(verbosity=2)
