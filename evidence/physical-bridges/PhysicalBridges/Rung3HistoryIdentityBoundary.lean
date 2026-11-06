/-
RUNG 3 — HISTORICAL IDENTITY: NECESSARY CONTINUATION JOIN (2026-11-03)

DerivedIdentityPredicate proves that ledger records remain in the encoder
image and that a decoder retracts an encoder. These statements are valid,
but carrier-image membership does not itself prove that one and the SAME
historical particular survives. Even a perfectly injective encoder can
encode a destructive update: the output remains a carrier of *something*.

This module supplies (1) an explicit counterexample to that conflation
and (2) a sound history-extension invariant for decoded content.
The step-extension premise is intentionally NOT inserted into the
definition of a carrier: it must be proved from actual source events.
-/
import PhysicalBridges.DerivedIdentityPredicate

namespace PhysicalBridges.Rung3HistoryIdentityBoundary

open DerivedIdentityPredicate

/-- Negative control: a bijective encoder/decoder and a carrier-preserving
write-through can replace content 1 with content 0. Thus encoder-image
membership, injectivity, and write-through alone do NOT imply preservation
of the original historical content. -/
theorem retraction_and_carriers_do_not_force_same_content :
    ∃ (enc dec update : Nat → Nat),
      (∀ c, dec (enc c) = c) ∧
      Function.Injective enc ∧
      carries enc 1 ∧
      carries enc (enc (update 1)) ∧
      dec 1 ≠ dec (enc (update 1)) := by
  refine ⟨(fun n => n), (fun n => n), (fun _ => 0),
    ?_, ?_, ?_, ?_, ?_⟩
  · intro c
    rfl
  · intro a b hab
    exact hab
  · exact carries_enc (fun n : Nat => n) 1
  · exact carries_enc (fun n : Nat => n) 0
  · decide

/-- The precise source-facing historical-continuation relation. A
content-extension relation should be instantiated to mean the original
particular's genuine continuing history, not mere wellformed coding.
It is kept separate from the carrier predicate so no physical
correspondence is smuggled into a definition. -/
theorem decoded_history_extends
    {C R : Type} (enc : C → R) (dec : R → C)
    (hretr : ∀ c, dec (enc c) = c)
    (Extends : C → C → Prop)
    (hRefl : ∀ c, Extends c c)
    (hTrans : ∀ a b c, Extends a b → Extends b c → Extends a c)
    (f : Nat → R → C) (records : Nat → R)
    (hWrite : ∀ n, records (n + 1) = enc (f n (records n)))
    (hSource : ∀ n, Extends (dec (records n)) (f n (records n)))
    (N : Nat) :
    Extends (dec (records 0)) (dec (records N)) := by
  induction N with
  | zero =>
      exact hRefl _
  | succ n ih =>
      apply hTrans _ _ _ ih
      rw [hWrite n, hretr (f n (records n))]
      exact hSource n

/-- Every historical identity tag can be conserved under the weaker
tag-preservation premise, even if the content grows with events.
This is a necessary invariant, not a sufficient test of conscious
or historical continuity. -/
theorem identity_tag_preserved
    {C R I : Type} (enc : C → R) (dec : R → C)
    (hretr : ∀ c, dec (enc c) = c)
    (tag : C → I) (f : Nat → R → C)
    (records : Nat → R)
    (hWrite : ∀ n, records (n + 1) = enc (f n (records n)))
    (hTag : ∀ n, tag (f n (records n)) = tag (dec (records n)))
    (N : Nat) :
    tag (dec (records N)) = tag (dec (records 0)) := by
  induction N with
  | zero =>
      rfl
  | succ n ih =>
      calc
        tag (dec (records (n + 1))) =
            tag (dec (enc (f n (records n)))) := by rw [hWrite n]
        _ = tag (f n (records n)) := by rw [hretr (f n (records n))]
        _ = tag (dec (records n)) := hTag n
        _ = tag (dec (records 0)) := ih

#print axioms retraction_and_carriers_do_not_force_same_content
#print axioms decoded_history_extends
#print axioms identity_tag_preserved

end PhysicalBridges.Rung3HistoryIdentityBoundary
