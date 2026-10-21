import UPTHold

namespace CodexDrain
open UPTHold
universe u v w
variable {S : Type u} {X : Type v} {Y : Type w}

/-- Durable input journal and append-only, ordered sink record. Cursor/IDs are derived from the sink prefix. -/
structure Durable (X : Type v) (Y : Type w) where
  log : List X
  out : List Y

/-- Concrete durable transitions separate logging from delivery. The pure replay computation may be realised
    incrementally; it is not declared a new lived commit under the source's reconstruction convention. -/
inductive Step (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) :
    Bool → Durable X Y → Durable X Y → Prop
  | idle (held) (c) : Step f eff g s0 held c c
  | record (c) (ready : c.log.length = c.out.length) :
      Step f eff g s0 false c ⟨c.log ++ [g c.out],c.out⟩
  | deliver (c) (pending : c.log.length = c.out.length + 1) :
      Step f eff g s0 false c ⟨c.log,c.out ++ [eff (replay f s0 c.log)]⟩

def Rep (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (c : Durable X Y) (n k : Nat) : Prop :=
  c.log = (ideal f eff g s0 n).log ∧ c.out = (ideal f eff g s0 k).out ∧ (n = k ∨ n = k+1)

theorem represented_lengths (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (c : Durable X Y) (n k : Nat) (h : Rep f eff g s0 c n k) :
    c.log.length = n ∧ c.out.length = k := by
  rw [h.1,h.2.1]
  exact ⟨(ideal_lengths f eff g s0 n).2,(ideal_lengths f eff g s0 k).1⟩

theorem step_preserves (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (held : Bool) (c d : Durable X Y) (n k : Nat)
    (h : Rep f eff g s0 c n k) (hs : Step f eff g s0 held c d) :
    ∃ n' k', Rep f eff g s0 d n' k' := by
  have lengths := represented_lengths f eff g s0 c n k h
  cases hs with
  | idle => exact ⟨n,k,h⟩
  | record c ready =>
    have nk : n = k := by omega
    subst n
    refine ⟨k+1,k,?_,h.2.1,Or.inr rfl⟩
    change c.log ++ [g c.out] = (ideal f eff g s0 (k+1)).log
    rw [h.1,h.2.1]
    rfl
  | deliver c pending =>
    have nk : n = k+1 := by omega
    subst n
    refine ⟨k+1,k+1,h.1,?_,Or.inl rfl⟩
    change c.out ++ [eff (replay f s0 c.log)] = (ideal f eff g s0 (k+1)).out
    rw [h.2.1,h.1,replay_ideal f eff g s0 (k+1)]
    rfl

inductive Run (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) :
    Durable X Y → Durable X Y → Prop
  | nil (c) : Run f eff g s0 c c
  | cons (a b c) (held) : Step f eff g s0 held a b → Run f eff g s0 b c → Run f eff g s0 a c

theorem run_preserves (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (a b : Durable X Y) (hr : Run f eff g s0 a b) :
    ∀ n k, Rep f eff g s0 a n k → ∃ n' k', Rep f eff g s0 b n' k' := by
  induction hr with
  | nil c => intro n k h; exact ⟨n,k,h⟩
  | cons a b c held hs _ ih =>
    intro n k h
    obtain ⟨n1,k1,h1⟩ := step_preserves f eff g s0 held a b n k h hs
    exact ih n1 k1 h1

theorem held_step_changes_no_durable_field (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (a b : Durable X Y) (h : Step f eff g s0 true a b) : b = a := by cases h; rfl

def abstraction (f : S → X → S) (s0 : S) (c : Durable X Y) : Cfg S X Y :=
  ⟨replay f s0 c.log,c.log,c.out⟩

/-- At a drained release barrier the durable implementation represents the exact source ideal state/log/out. -/
theorem drained_refinement (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (c : Durable X Y) (n k : Nat) (h : Rep f eff g s0 c n k)
    (drained : c.log.length = c.out.length) : abstraction f s0 c = ideal f eff g s0 n := by
  have lengths := represented_lengths f eff g s0 c n k h
  have nk : k = n := by omega
  subst k
  unfold abstraction
  rw [h.1,h.2.1,replay_ideal f eff g s0 n]

/-- Every represented durable state can be drained by at most one delivery transition. This is a logical
    action count, not a bound on replay computation time or a physical deadline. -/
theorem can_drain (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (c : Durable X Y) (n k : Nat) (h : Rep f eff g s0 c n k) :
    ∃ d, Step f eff g s0 false c d ∧ d.log.length = d.out.length ∧ abstraction f s0 d = ideal f eff g s0 n := by
  have lengths := represented_lengths f eff g s0 c n k h
  cases h.2.2 with
  | inl nk =>
    have ready : c.log.length = c.out.length := by omega
    exact ⟨c,Step.idle false c,ready,drained_refinement f eff g s0 c n k h ready⟩
  | inr nk =>
    let d : Durable X Y := ⟨c.log,c.out ++ [eff (replay f s0 c.log)]⟩
    have pending : c.log.length = c.out.length + 1 := by omega
    have hd : Step f eff g s0 false c d := Step.deliver c pending
    obtain ⟨n',k',hr⟩ := step_preserves f eff g s0 false c d n k h hd
    have hn : n' = n := by
      have ll := (represented_lengths f eff g s0 d n' k' hr).1
      change c.log.length = n' at ll
      omega
    have ready : d.log.length = d.out.length := by
      change c.log.length = (c.out ++ [eff (replay f s0 c.log)]).length
      rw [List.length_append]
      simpa using pending
    refine ⟨d,hd,ready,?_⟩
    rw [← hn]
    exact drained_refinement f eff g s0 d n' k' hr ready


/-- A volatile cache is a reconstructed prefix of the durable journal, not independent lived state. -/
def CacheGood (f : S → X → S) (s0 : S) (log : List X) (pc : Nat) (s : S) : Prop :=
  ∃ pre tail, log = pre ++ tail ∧ pc = pre.length ∧ s = replay f s0 pre

theorem cache_reset (f : S → X → S) (s0 : S) (log : List X) : CacheGood f s0 log 0 s0 :=
  ⟨[],log,rfl,rfl,rfl⟩

theorem cache_survives_record (f : S → X → S) (s0 : S) (log : List X) (pc : Nat) (s : S)
    (h : CacheGood f s0 log pc s) (x : X) : CacheGood f s0 (log ++ [x]) pc s := by
  obtain ⟨pre,tail,hl,hpc,hs⟩ := h
  refine ⟨pre,tail ++ [x],?_,hpc,hs⟩
  rw [hl,List.append_assoc]

theorem cache_advance (f : S → X → S) (s0 : S) (pre tail : List X) (x : X) :
    CacheGood f s0 (pre ++ x :: tail) (pre.length+1) (f (replay f s0 pre) x) := by
  refine ⟨pre ++ [x],tail,?_,?_,?_⟩
  · rw [List.append_assoc]
    rfl
  · simp only [List.length_append,List.length_singleton]
  · unfold replay
    rw [List.foldl_append]
    rfl

theorem cache_complete (f : S → X → S) (s0 : S) (log : List X) (pc : Nat) (s : S)
    (h : CacheGood f s0 log pc s) (complete : pc = log.length) : s = replay f s0 log := by
  obtain ⟨pre,tail,hl,hpc,hs⟩ := h
  have zero : tail.length = 0 := by
    rw [hl,List.length_append] at complete
    omega
  cases tail with
  | nil => rw [hl,List.append_nil]; exact hs
  | cons x xs => simp at zero

#print axioms step_preserves
#print axioms run_preserves
#print axioms held_step_changes_no_durable_field
#print axioms drained_refinement
#print axioms can_drain
#print axioms cache_reset
#print axioms cache_survives_record
#print axioms cache_advance
#print axioms cache_complete
end CodexDrain
