import UPTImpartiality
import UPTLotteryMenu
/-
Codex's additive adequacy repair, 22 October 2026; neither author tree edited.
It connects weight bounds to actual saveable beings in an inhabited disjoint
family, and supplies controls for the menu's probability interpretation.
It does not define general leximin or prove general existence/uniqueness.
-/
namespace UPTImpartialAdequacy
universe u v

def chance {O : Type u} {B : Type v} (M : List O) (p : O → Rat)
    (keeps : O → B → Bool) (i : B) : Rat := ((M.filter (fun o => keeps o i)).map p).sum

def Saveable {O : Type u} {B : Type v} (M : List O) (keeps : O → B → Bool) (i : B) : Prop :=
  ∃ o, o ∈ M ∧ keeps o i = true

/-- A singleton keeper list supplies an actual saveable-being witness. -/
theorem singleton_keeper_saveable {O : Type u} {B : Type v} (M : List O)
    (keeps : O → B → Bool) (o : O) (i : B)
    (h : M.filter (fun a => keeps a i) = [o]) : Saveable M keeps i := by
  have hm : o ∈ M.filter (fun a => keeps a i) := by rw [h]; simp
  exact ⟨o, (List.mem_filter.mp hm).1, (List.mem_filter.mp hm).2⟩

/-- The disjointness bridge is explicit, rather than hidden in the name of a weight. -/
theorem singleton_keeper_chance {O : Type u} {B : Type v} (M : List O)
    (p : O → Rat) (keeps : O → B → Bool) (o : O) (i : B)
    (h : M.filter (fun a => keeps a i) = [o]) : chance M p keeps i = p o := by
  simp [chance, h, Rat.add_zero]

/-- A nonempty disjoint family, every outcome inhabited, has a being at chance <= 1/m. -/
theorem some_being_at_most {O : Type u} {B : Type v} (M : List O) (hne : M ≠ [])
    (p : O → Rat) (keeps : O → B → Bool) (hsum : (M.map p).sum = 1)
    (witness : ∀ o, o ∈ M → ∃ i, M.filter (fun a => keeps a i) = [o]) :
    ∃ i, Saveable M keeps i ∧ chance M p keeps i ≤ 1 / (M.length : Rat) := by
  have hmap : M.map p ≠ [] := by simpa using hne
  obtain ⟨w, hw, hle⟩ := UPTImpartial.some_chance_at_most (M.map p) hmap hsum
  obtain ⟨o, ho, heq⟩ := List.mem_map.mp hw
  obtain ⟨i, hi⟩ := witness o ho
  refine ⟨i, singleton_keeper_saveable M keeps o i hi, ?_⟩
  rw [singleton_keeper_chance M p keeps o i hi, heq]
  simpa using hle

/-- If all saveable beings reach 1/m, all outcome weights are 1/m (same witness premise). -/
theorem being_floor_forces_uniform {O : Type u} {B : Type v} (M : List O) (hne : M ≠ [])
    (p : O → Rat) (keeps : O → B → Bool) (hsum : (M.map p).sum = 1)
    (witness : ∀ o, o ∈ M → ∃ i, M.filter (fun a => keeps a i) = [o])
    (floor : ∀ i, Saveable M keeps i → 1 / (M.length : Rat) ≤ chance M p keeps i) :
    ∀ o, o ∈ M → p o = 1 / (M.length : Rat) := by
  have hmap : M.map p ≠ [] := by simpa using hne
  have hf : ∀ w, w ∈ M.map p → 1 / ((M.map p).length : Rat) ≤ w := by
    intro w hw
    obtain ⟨o, ho, heq⟩ := List.mem_map.mp hw
    obtain ⟨i, hi⟩ := witness o ho
    have h := floor i (singleton_keeper_saveable M keeps o i hi)
    rw [singleton_keeper_chance M p keeps o i hi, heq] at h
    simpa using h
  intro o ho
  have h := UPTImpartial.everyone_at_least_only_if_uniform (M.map p) hmap hsum hf (p o) (List.mem_map_of_mem ho)
  simpa using h

/-- Uniform weights attain the floor for a being kept by exactly one outcome. -/
theorem uniform_attains {O : Type u} {B : Type v} (M : List O) (keeps : O → B → Bool)
    (i : B) (o : O) (hi : M.filter (fun a => keeps a i) = [o]) :
    chance M (fun _ => 1 / (M.length : Rat)) keeps i = 1 / (M.length : Rat) :=
  singleton_keeper_chance M _ keeps o i hi

/-- A nonempty action menu alone does not make the original denominator positive. -/
theorem empty_universe_control :
    UPTLotteryMenu.classes ([] : List Bool) (fun b : Bool => b) [true] = 0 ∧
    UPTLotteryMenu.weight (fun b : Bool => b) [true] true = 1 := by decide

/-- Incomplete U assigns two distinct offered outcomes unit mass (total two). -/
theorem incomplete_universe_control :
    UPTLotteryMenu.classes [true] (fun b : Bool => b) [true, false] = 1 ∧
    UPTLotteryMenu.weight (fun b : Bool => b) [true, false] true = 1 ∧
    UPTLotteryMenu.weight (fun b : Bool => b) [true, false] false = 1 := by decide

/-- Duplicated U counts three classes for two outcomes (total probability 2/3). -/
theorem duplicate_universe_control :
    UPTLotteryMenu.classes [true, true, false] (fun b : Bool => b) [true, false] = 3 := by decide

inductive Being | a | b | c | d deriving DecidableEq
inductive Outcome | x | y | z | w deriving DecidableEq

def keeps : Outcome → Being → Bool
  | .x, i => i == .a || i == .b
  | .y, i => i == .a || i == .c
  | .z, i => i == .b || i == .c
  | .w, i => i == .d

/-- Five agreed equiprobable tickets implement the overlap lottery, giving everyone 2/5. -/
theorem overlap_five_ticket_chances : ∀ i : Being,
    chance [Outcome.x, .y, .z, .w, .w] (fun _ => (1/5 : Rat)) keeps i = 2/5 := by
  intro i; cases i <;> simp [chance, keeps] <;> grind

/-- Different lotteries over four distinct outcomes can give identical prospects. -/
theorem prospects_do_not_identify_lottery :
    let M := [Outcome.x, .y, .z, .w]
    let k : Outcome → Being → Bool := fun o i => match o with
      | .x => i == .a || i == .b
      | .y => i == .c || i == .d
      | .z => i == .a || i == .c
      | .w => i == .b || i == .d
    let p : Outcome → Rat := fun o => if o == .x || o == .y then 1/2 else 0
    let q : Outcome → Rat := fun o => if o == .z || o == .w then 1/2 else 0
    (M.map p).sum = 1 ∧ (M.map q).sum = 1 ∧ p Outcome.x ≠ q Outcome.x ∧
      (∀ i, chance M p k i = 1/2 ∧ chance M q k i = 1/2) := by
  dsimp
  refine ⟨?_, ?_, ?_, ?_⟩
  · simp; grind
  · simp; grind
  · grind
  · intro i; cases i <;> simp [chance] <;> grind
end UPTImpartialAdequacy
