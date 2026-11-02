/-!
DERIVED IDENTITY PREDICATE — the protection target as a construction.

Join 2's physical antecedent "an authentic physical protection predicate"
has so far been a HYPOTHESIS. This module derives it from the ledger: the
protection predicate is the image of the complete ledger's historical
encoder — a record carries a particular exactly when it decodes to
historical content. The encoder/decoder pair is the canon's construction
(exact boundary reconstruction, IR132; the complete journal and charged
handoff, Part III-G; the finite-code decoder with its retraction,
`DecoderRetraction`), so the predicate is a consequence of the ledger's
structure, not a declaration.

What follows, compiled: carriers are non-vacuous; the decoder fixes them;
the encoder is injective so distinct histories never merge; mediated
write-through actions preserve identity; the record after a mediated update
is determined by the decoded content alone, so substrate changes do not
touch identity — identity by continuation, from the ledger.

Physical source correspondence remains the stated obligation: that the
actual ledger's encoder tracks the actual particulars. This module removes
the SEMANTIC stipulation, not that correspondence.
-/

namespace PhysicalBridges.DerivedIdentityPredicate

variable {C R : Type}

/-- THE DERIVED PROTECTION PREDICATE. -/
def carries (enc : C → R) (r : R) : Prop := ∃ c, enc c = r

/-- Non-vacuity: every encoding carries identity. -/
theorem carries_enc (enc : C → R) (c : C) : carries enc (enc c) := ⟨c, rfl⟩

/-- The ledger decoder recognises exactly the carriers: with the retraction
dec ∘ enc = id pointwise, a carrier decodes to its own historical content. -/
theorem dec_recognises_carriers (dec : R → C) (enc : C → R)
    (hretr : ∀ c, dec (enc c) = c) (r : R) (h : carries enc r) :
    ∃ c, dec r = c ∧ enc c = r := by
  obtain ⟨c, hc⟩ := h
  refine ⟨c, ?_, hc⟩
  rw [← hc, hretr c]

/-- NO MERGING: under the retraction the encoder is injective, so distinct
historical contents never collapse into one record. -/
theorem encoder_injective (dec : R → C) (enc : C → R)
    (hretr : ∀ c, dec (enc c) = c) :
    Function.Injective enc := by
  intro a b hab
  have h : dec (enc a) = dec (enc b) := by rw [hab]
  rw [hretr a, hretr b] at h
  exact h

/-- Distinct histories have distinct records. -/
theorem distinct_histories_distinct_records (enc : C → R)
    (hinj : Function.Injective enc) (a b : C) (hab : a ≠ b) : enc a ≠ enc b :=
  fun h => hab (hinj h)

/-- WRITE-THROUGH PRESERVATION: a mediated action whose record effect is
`enc ∘ f` maps carriers to carriers. Guarding the ledger IS protecting the
derived identity — Join 2's predicate is constructed. -/
theorem write_through_preserves (enc : C → R) (f : R → C) (r : R)
    (_h : carries enc r) : carries enc (enc (f r)) :=
  carries_enc enc (f r)

/-- IDENTITY BY CONTINUATION: the record after a mediated update is
determined by the decoded content alone. Two substrate states decoding to
the same content continue to the same record — substrate changes do not
touch identity. -/
theorem continuation (enc : C → R) (f : R → C) (r r' : R) (hfeq : f r = f r') :
    enc (f r) = enc (f r') := by
  rw [hfeq]

/-- Preservation across an actual history: if every step of a history is
write-through with the same content map, then a carrier at the start is a
carrier at the end — by induction on the step count. -/
theorem history_preserves_carriers (enc : C → R) (f : Nat → R → C)
    (r : Nat → R) (hstep : ∀ n, r (n + 1) = enc (f n (r n)))
    (h0 : carries enc (r 0)) (N : Nat) : carries enc (r N) := by
  induction N with
  | zero => exact h0
  | succ N ih =>
      rw [hstep N]
      exact write_through_preserves enc (f N) (r N) ih

#print axioms carries
#print axioms dec_recognises_carriers
#print axioms encoder_injective
#print axioms distinct_histories_distinct_records
#print axioms write_through_preserves
#print axioms continuation
#print axioms history_preserves_carriers

end PhysicalBridges.DerivedIdentityPredicate
