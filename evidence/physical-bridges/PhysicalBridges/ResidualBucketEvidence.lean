import PhysicalBridges.ResidualJunctionTree

/-!
BDL RESIDUAL BUCKET ELIMINATION: exact factor-step theorem (2026-11-03).

The entire finite factor list is part of the input. "Outside" factors
must be genuinely independent of the eliminated Boolean variable.
The theorem is exact over Rat, including cancellation of signed factors
introduced by evidence in Fourier-dual parity inference.

No graph width, source-specific family bound, or physical preparation is
postulated or derived by this module. The exact bucket-step is the
mathematical induction component needed for a later certified junction
tree implementation. No proof placeholders or new axioms.
-/
namespace PhysicalBridges.ResidualBucketEvidence

open PhysicalBridges.ResidualJunctionTree

/-- A source-complete list of rational factors evaluated at an assignment. -/
def joint (factors : List (List Bool → Rat)) (bits : List Bool) : Rat :=
  (factors.map (fun f => f bits)).prod

/-- Factor multiplication is exactly list concatenation; no dropped term. -/
theorem joint_append (inside outside : List (List Bool → Rat)) (bits : List Bool) :
    joint (inside ++ outside) bits =
      joint inside bits * joint outside bits := by
  induction inside with
  | nil =>
      change joint outside bits = (1 : Rat) * joint outside bits
      exact (Rat.one_mul _).symm
  | cons f fs ih =>
      change f bits * joint (fs ++ outside) bits =
        (f bits * joint fs bits) * joint outside bits
      rw [ih]
      exact (Rat.mul_assoc _ _ _).symm

/-- Every outside factor is genuinely independent of the eliminated bit. -/
def OutsideIndependent (outside : List (List Bool → Rat)) : Prop :=
  ∀ f, f ∈ outside → ∀ xs, f (true :: xs) = f (false :: xs)

/-- Independence of each factor lifts to the exact product over all factors. -/
theorem joint_outside_independent
    (outside : List (List Bool → Rat))
    (h : OutsideIndependent outside) (xs : List Bool) :
    joint outside (true :: xs) = joint outside (false :: xs) := by
  induction outside with
  | nil => simp [joint]
  | cons f fs ih =>
      have hf : f (true :: xs) = f (false :: xs) :=
        h f (by simp) xs
      have hrest : OutsideIndependent fs := by
        intro g hg tail
        exact h g (by simp [hg]) tail
      have ih' := ih hrest
      change f (true :: xs) * joint fs (true :: xs) =
        f (false :: xs) * joint fs (false :: xs)
      rw [hf, ih']

/-- Bucket factor after EXACTLY summing over the eliminated Boolean bit. -/
def bucket (inside : List (List Bool → Rat)) (tail : List Bool) : Rat :=
  joint inside (false :: tail) + joint inside (true :: tail)

/-- Local exact elimination: multiply all touched factors, sum the bit,
and carry every untouched factor through. No probabilistic or numerical
approximation is used; negative rational entries are permitted. -/
theorem bucket_step_pointwise
    (inside outside : List (List Bool → Rat))
    (h : OutsideIndependent outside) (xs : List Bool) :
    joint (inside ++ outside) (false :: xs) +
    joint (inside ++ outside) (true :: xs) =
      bucket inside xs * joint outside (false :: xs) := by
  rw [joint_append, joint_append]
  rw [joint_outside_independent outside h xs]
  exact (Rat.add_mul _ _ _).symm

/-- Partition is additive in its weight function: finite exact sum. -/
theorem partition_add (n : Nat)
    (f g : List Bool → Rat) :
    partition n (fun xs => f xs + g xs) = partition n f + partition n g := by
  change ((assignments n).map (fun xs => f xs + g xs)).sum =
    ((assignments n).map f).sum + ((assignments n).map g).sum
  induction assignments n with
  | nil =>
      change (0 : Rat) = 0 + 0
      exact (Rat.zero_add _).symm
  | cons a xs ih =>
      simp [ih, Rat.add_assoc, Rat.add_left_comm]

/-- FULL source-factor partition is exactly preserved by one bucket step.
This is the pointwise lemma plus the finite Boolean partition recursion;
unlike a bare distributivity identity it relates complete normalizers. -/
theorem bucket_partition_correct (n : Nat)
    (inside outside : List (List Bool → Rat))
    (h : OutsideIndependent outside) :
    partition (n + 1) (joint (inside ++ outside)) =
      partition n (fun xs => bucket inside xs * joint outside (false :: xs)) := by
  calc
    partition (n + 1) (joint (inside ++ outside)) =
        partition n (fun xs => joint (inside ++ outside) (false :: xs)) +
        partition n (fun xs => joint (inside ++ outside) (true :: xs)) :=
      partition_split n _
    _ = partition n (fun xs =>
        joint (inside ++ outside) (false :: xs) +
        joint (inside ++ outside) (true :: xs)) := by
      exact (partition_add n _ _).symm
    _ = partition n (fun xs => bucket inside xs * joint outside (false :: xs)) := by
      congr 1
      funext xs
      exact bucket_step_pointwise inside outside h xs

/-- Source-independent exact complete marginalisation by recursively
summing the leading bit, without any width claim. -/
def eliminateAll : (n : Nat) → (List Bool → Rat) → Rat
  | 0, weight => weight []
  | n + 1, weight =>
      eliminateAll n (fun xs => weight (false :: xs) + weight (true :: xs))

/-- Complete finite recursion equals exhaustive rational partition. -/
theorem eliminateAll_correct (n : Nat) (weight : List Bool → Rat) :
    eliminateAll n weight = partition n weight := by
  induction n generalizing weight with
  | zero =>
      change weight [] = weight [] + (0 : Rat)
      exact (Rat.add_zero _).symm
  | succ n ih =>
      change eliminateAll n (fun xs =>
        weight (false :: xs) + weight (true :: xs)) =
        partition (n + 1) weight
      rw [ih]
      rw [partition_split]
      exact partition_add n _ _

#print axioms joint_append
#print axioms joint_outside_independent
#print axioms bucket_step_pointwise
#print axioms partition_add
#print axioms bucket_partition_correct
#print axioms eliminateAll_correct

end PhysicalBridges.ResidualBucketEvidence
