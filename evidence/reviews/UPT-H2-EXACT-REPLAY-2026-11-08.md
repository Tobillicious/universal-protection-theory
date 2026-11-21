# H2 source algebra: executed replay

Date: 8 November 2026. Source pin: `7c4eb625bce58739ce19c891cc89eb63a92ebe84`.

Read [Oct10SourceHamiltonianProtection.lean](../physical-bridges/PhysicalBridges/Oct10SourceHamiltonianProtection.lean) and [oct10_source_hamiltonian_guard.py](../physical-bridges/checks/oct10_source_hamiltonian_guard.py) in full, then executed the unmodified Python checker using Python 3. It completed with exit code 0 and all assertions passed. This is a fresh checker replay, not a fresh Lean kernel replay.

The Lean module exhausts the six basis cases and characterizes source-invariant diagonal binary predicates as unions of the two parity triples. It carefully distinguishes H1 coupling support from a simultaneously enacted H1 pulse: the two sectors have different coupling amplitudes. H2's pi/2 pulse carries B0 to C1 while preserving parity. Neither site occupancy nor parity is independently authenticated subject identity or original-six X3.

The Python checker goes beyond the diagonal graph calculation. It constructs the full 72-by-36 joint commutator map for the specified H1 and H2 and checks a 34-by-34 minor with exact Fraction arithmetic: determinant 82944. Together with the independent commuting identity and parity matrices, this establishes rank 34 and commutant span_C{I,C} for these matrices. The resulting four orthogonal invariant projectors include zero and identity, as well as the two sector projectors. All 64 diagonal binary candidates are enumerated; four pass.

The pulse matrix uses Python complex coefficients drawn only from Gaussian integers 0, 1 and -i, with small exact products/sums; this is not arbitrary-precision symbolic complex algebra in general. Its checked unitarity and matrix entries are exact for these values. The rank certificate and state/readout calculations use exact rational arithmetic. The supplied full-rank diagonal state's boundary Rz expectation changes from 73/210 to -1/21, a difference of 83/210. Thus that specified boundary readout detects this pulse; the calculation does not establish universal invisibility.

Executed output:

```text
PASS 10OCT: inherited six-dimensional H1/H2 exact integer couplings
PASS 10OCT: exact Gaussian-integer H2(pi/2) pulse is unitary
PASS 10OCT: B0 -> C1, B-site occupancy 1 -> 0 with conserved C=+1
PASS 10OCT: exact commutator rank 34 via 34x34 minor determinant 82944
PASS 10OCT: full commutant span_C{I,C}: only 4 invariant orthogonal projectors
PASS 10OCT: only 4 of 64 binary diagonal source projectors invariant
PASS 10OCT: source boundary Rz detects pulse difference 83/210
STATUS: does not identify a continuing subject or establish X3
```

This corroborates the narrow source-sector distinction in the [symmetry-forcing review](UPT-SYMMETRY-FORCING-FOLLOWUP-2026-11-08.md). It neither refutes a stronger complete-Koru subject-protection theorem nor supplies actual-world correspondence by itself. No theorem source or historical canon changed.
