import DurableDrain

namespace CodexCheckpoint
open UPTHold CodexDrain
universe u v

/-- A durable anchor records a correct reconstructed prefix. The complete lived journal is retained. -/
def AnchorGood {S : Type u} {X : Type v} (f : S → X → S) (s0 : S)
    (log : List X) (index : Nat) (value : S) : Prop := CacheGood f s0 log index value

theorem install_from_complete_cache {S : Type u} {X : Type v}
    (f : S → X → S) (s0 : S) (log : List X) (pc : Nat) (s : S)
    (good : CacheGood f s0 log pc s) (complete : pc = log.length) :
    AnchorGood f s0 log log.length s := by
  rw [← complete]
  exact good

theorem anchor_survives_record {S : Type u} {X : Type v}
    (f : S → X → S) (s0 : S) (log : List X) (index : Nat) (s : S) (x : X)
    (good : AnchorGood f s0 log index s) : AnchorGood f s0 (log ++ [x]) index s :=
  cache_survives_record f s0 log index s good x

theorem loaded_anchor_is_correct {S : Type u} {X : Type v}
    (f : S → X → S) (s0 : S) (log : List X) (index : Nat) (s : S)
    (good : AnchorGood f s0 log index s) : CacheGood f s0 log index s := good

/-- Loading a verified prefix and evaluating the suffix produces the same replay state. -/
theorem suffix_reconstruction {S : Type u} {X : Type v}
    (f : S → X → S) (s0 : S) (pre tail : List X) :
    tail.foldl f (replay f s0 pre) = replay f s0 (pre ++ tail) := by
  unfold replay
  rw [List.foldl_append]

theorem tail_bound (n anchor window : Nat) (h : n ≤ anchor + window) : n - anchor ≤ window := by omega

theorem gated_record_preserves_window (n anchor window : Nat) (gate : n < anchor + window) :
    n + 1 ≤ anchor + window := by omega

/-- The expression is a certificate only when loading, each evaluation and the sink append have these
    time bounds and the recovery scheduler supplies service. Those premises are not discharged here. -/
theorem supplied_cost_bound (tail window load evaluation sink : Nat) (h : tail ≤ window) :
    load + tail * evaluation + sink ≤ load + window * evaluation + sink := by
  exact Nat.add_le_add_right (Nat.add_le_add_left (Nat.mul_le_mul_right evaluation h) load) sink

#print axioms install_from_complete_cache
#print axioms anchor_survives_record
#print axioms loaded_anchor_is_correct
#print axioms suffix_reconstruction
#print axioms tail_bound
#print axioms gated_record_preserves_window
#print axioms supplied_cost_bound
end CodexCheckpoint
