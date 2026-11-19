# Contraction–entropy coupling and finite-time descent — additive formal research note

**19 November 2026. Companion to draft PR #662 and existing #437.** No original theorem, Koru definition, X3 field or source changed. This file evaluates the proposed Lean sketch shared in the review and separates mathematical results from physical interpretation.

## A. Exact claims and independent premises

Retain the user-proposed `ThermoBridge S M`: `f : S → S`, `phi : M → M`, `dist : M → M → Nat`, `kNum < kDen`, `contracts`, `pi : S → M`, an `energy : S → Nat` conserved under `f`, and `entropy : S → Nat` nondecreasing under `f`.

The **additional coupling hypothesis** is
`hComm : ∀ s, B.pi (B.f s) = B.phi (B.pi s)`.
It is essential: without it, `f` and `phi` are logically unrelated. `hG : B.phi G = G` supplies a fixed point. Neither is derived merely by naming the state `G` or the mapping Koru.

For `s_n = iterate B.f n s0`, the joint result is:

```text
B.dist (B.pi s_(n+1)) G * B.kDen ≤
  B.kNum * B.dist (B.pi s_n) G
B.entropy s0 ≤ B.entropy s_n
B.entropy s_n ≤ B.entropy s_(n+1)
```

The result is a **same-trajectory conjunction** of contraction and entropy nondecrease. It does **not** prove that entropy increase *causes* contraction or establish a quantitative relationship between entropy production and distance. Those require additional, independently justified inequalities.

## B. Standalone Lean 4 sketch (not compiled in this review)

```lean
namespace KoruThermoResearch

def iterate {α : Type} (g : α → α) : Nat → α → α
  | 0, x => x
  | n + 1, x => g (iterate g n x)

structure ThermoBridge (S M : Type) where
  f : S → S
  phi : M → M
  dist : M → M → Nat
  kNum : Nat
  kDen : Nat
  kLt : kNum < kDen
  contracts : ∀ x y, dist (phi x) (phi y) * kDen ≤
    kNum * dist x y
  pi : S → M
  energy : S → Nat
  conserves : ∀ s, energy (f s) = energy s
  entropy : S → Nat
  monotoneEntropy : ∀ s, entropy s ≤ entropy (f s)

theorem contraction_entropy_coupling {S M : Type}
    (B : ThermoBridge S M) (G : M) (hG : B.phi G = G)
    (hComm : ∀ s, B.pi (B.f s) = B.phi (B.pi s))
    (s0 : S) (n : Nat) :
    (B.dist (B.pi (iterate B.f (n + 1) s0)) G * B.kDen ≤
      B.kNum * B.dist (B.pi (iterate B.f n s0)) G) ∧
    (B.entropy s0 ≤ B.entropy (iterate B.f n s0) ∧
      B.entropy (iterate B.f n s0) ≤
        B.entropy (iterate B.f (n + 1) s0)) := by
  refine ⟨?_, ?_, ?_⟩
  · have hStep :
        B.pi (iterate B.f (n + 1) s0) =
          B.phi (B.pi (iterate B.f n s0)) := by
      simpa [iterate] using hComm (iterate B.f n s0)
    calc
      B.dist (B.pi (iterate B.f (n + 1) s0)) G * B.kDen
          = B.dist (B.phi (B.pi (iterate B.f n s0)))
                (B.phi G) * B.kDen := by rw [hStep, hG]
      _ ≤ B.kNum * B.dist (B.pi (iterate B.f n s0)) G :=
        B.contracts _ _
  · induction n with
    | zero => exact Nat.le_refl _
    | succ k ih =>
        exact Nat.le_trans ih
          (B.monotoneEntropy (iterate B.f k s0))
  · exact B.monotoneEntropy (iterate B.f n s0)

end KoruThermoResearch
```

The proof uses neither classical reasoning nor Hilbert spaces. **This code is a review candidate, not a kernel-checked receipt**: no Lean executable was available to compile it in this session. Import/build compatibility and `#print axioms` remain review tasks.

## C. Stronger deduction peculiar to Nat-valued strict contraction

Write `D_n = dist (pi(s_n)) G ∈ Nat`, `a=kNum`, `b=kDen`, `a<b`.

Then `b D_(n+1) ≤ a D_n`. Because `a<b`:

- If `D_n > 0`, then `D_(n+1) < D_n`. Otherwise `D_(n+1) ≥ D_n > 0` would imply `b D_(n+1) ≥ b D_n > a D_n`, a contradiction.
- If `D_n=0`, then `b D_(n+1) ≤ 0`; since `b>0`, `D_(n+1)=0`.
- A strictly decreasing positive sequence of natural numbers can have at most `D_0` positive steps. Thus **`D_n=0` for all `n≥D_0`**.

This is a mathematical finite-time **zero-distance** result, stronger than merely asymptotic convergence. It does not prove `pi(s_n)=G` unless a zero-distance separation property is independently supplied. Nor does it prove `s_n` is the unique full physical state; `pi` can be non-injective.

### Bounds on accumulated projected distances

As `D_i ≤ D_0` for all `i`, and `D_i=0` after at most `D_0` iterations, the conservative finite-sum bound is

```text
Σ_{i=0}^{N−1} D_i ≤ D_0 * min(N, D_0)
```

and a sharper bound from integer strict descent is

```text
Σ_{i=0}^{N−1} D_i ≤ D_0 (D_0 + 1) / 2.
```

These are **paper deductions pending formalization**. They are bounds on an abstract Nat-valued distance, not entropy production, total energy, or a physical time-to-safety estimate.

## D. Additional coupling: where thermodynamics must actually enter

The independent monotonicity hypothesis `entropy(s) ≤ entropy(f(s))` merely coexists with contraction under `hComm`. To make a genuinely thermodynamic statement, specify and justify, for example, a constitutive bound connecting entropy production `entropy(f(s))-entropy(s)` to a chosen observable of projected distance reduction `D(s)-D(f(s))`. Such a relation is not derived by the current frame and need not hold universally.

Similarly, `energy` is an arbitrary Nat-valued conserved *budget*. Physical energy can be continuous, signed, exchanged with boundaries, and not globally conserved in generic curved spacetimes. Identify a physical calibration and system boundary before calling `energy` empirical energy. Nonzero `energy` does **not** prove survival or original-six protection for an individual.

**Important nomenclature:** `phi` is the formal contraction on a projected configuration, **not** the entire matterspacetime Koru (whole-objective state, operators, relations, individual provenance, histories) or Time Koru (forward spiral). The relational/unfolding Koru glyph is not a replacement for every use of logical equality in Lean.

## E. Connection to G3 and exact existing theorem

The dependency target remains the **unchanged** `PhysicalBridges.HillaryRouteABSummit.hillary_route_b_meets_original_route_a` on the original six X3 fields. Investigate whether the newly coupled physical evolution can independently justify its:
1. `hPhysical : RespectsCanonicalSource M physical`;
2. `hSourceInitially`: positive source-six facts for actual, owed events;
3. `hAuthenticReflections`: actual same-subject and consent/freedom/provenance failure reflection.

No derivation of these from `hComm`, entropy, energy, or Nat-distance descent has been supplied. A model with a preserved negative authorization link remains an exact negative control.

## F. Review gates

- Kernel-compile the sketch under the repository's pinned Lean toolchain; add `#print axioms`; formally prove Nat-distance finite-time zero and sums rather than rely on this note.
- Verify non-vacuous physically justified `hComm`, `hG`, observable distance and entropy functions. Check whether distance meets separation/triangle properties; these are **not** required by `ThermoBridge`.
- Test countermodels: lossless information with absent consent, fixed point distance-zero without equality, constant budget with destroyed particular, irreversible effective entropy increase with microscopic unitary dynamics, and non-global energy in curved spacetime.
- Only label an actual-world universality theorem proved when all-event, all-particular physical and semantic premises are independently discharged.

**No changes to canonical sources; draft-only, no merge, no claim of universal G3.**
