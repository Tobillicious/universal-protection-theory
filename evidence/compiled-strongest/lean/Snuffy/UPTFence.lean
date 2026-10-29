/-
The execution boundary by fencing (Chapter 16.5; execution-boundary THEOREM.md), abstract model.
A target keeps a generation floor, the generations whose tokens have been minted, and its durable log.
A write attempt of generation g is applied only if g has been minted (unforgeability: a valid token for g
exists only after the controller mints it) and, checked at application (E-LIN), g is at least the floor.
The writer is arbitrary: any sequence of raise, mint and write events is allowed.
-/
namespace UPTFence

inductive Ev
  | raise (g : Nat)   -- authenticated floor raise
  | mint (g : Nat)    -- the controller issues generation g's token (at release)
  | write (g : Nat)   -- any write attempt claiming generation g

structure St where
  floor : Nat
  minted : List Nat
  log : List Nat

/-- Check-at-apply semantics (E-LIN): the floor and the token are checked when the write is applied. -/
def apply (s : St) : Ev → St
  | .raise g => { s with floor := max s.floor g }
  | .mint g => { s with minted := g :: s.minted }
  | .write g => if s.floor ≤ g ∧ g ∈ s.minted then { s with log := s.log ++ [g] } else s

def run (s : St) (tr : List Ev) : St := tr.foldl apply s

/-- **Hold safety.** If every minted generation is below the floor, and the later events mint no
generation at or above that floor, then no write lands, whatever the writer attempts. -/
theorem hold_safety (s : St) (mid : List Ev)
    (hinv : ∀ h, h ∈ s.minted → h < s.floor)
    (hmid : ∀ h, Ev.mint h ∈ mid → h < s.floor) : (run s mid).log = s.log := by
  induction mid generalizing s with
  | nil => rfl
  | cons e rest ih =>
    simp only [run, List.foldl_cons]
    cases e with
    | raise g =>
      have h1 := ih { s with floor := max s.floor g }
        (fun h hm => Nat.lt_of_lt_of_le (hinv h hm) (Nat.le_max_left _ _))
        (fun h hm => Nat.lt_of_lt_of_le (hmid h (List.mem_cons_of_mem _ hm)) (Nat.le_max_left _ _))
      exact h1
    | mint g =>
      have hg : g < s.floor := hmid g List.mem_cons_self
      have h1 := ih { s with minted := g :: s.minted }
        (fun h hm => by
          cases hm with
          | head => exact hg
          | tail _ hm' => exact hinv h hm')
        (fun h hm => hmid h (List.mem_cons_of_mem _ hm))
      exact h1
    | write g =>
      have hno : ¬ (s.floor ≤ g ∧ g ∈ s.minted) := fun ⟨hle, hmem⟩ => Nat.lt_irrefl _ (Nat.lt_of_lt_of_le (hinv g hmem) hle)
      have happ : apply s (.write g) = s := by simp [apply, hno]
      rw [happ]
      exact ih s hinv (fun h hm => hmid h (List.mem_cons_of_mem _ hm))

/-- **The hold.** Raising the floor above every minted generation starts a window in which nothing
lands, for every later sequence of attempts that mints no new generation. -/
theorem raise_then_nothing_lands (s : St) (g : Nat) (mid : List Ev)
    (hold : ∀ h, h ∈ s.minted → h ≤ g)
    (hmid : ∀ h, Ev.mint h ∈ mid → h ≤ g) :
    (run (apply s (.raise (g + 1))) mid).log = s.log := by
  apply hold_safety
  · intro h hm
    exact Nat.lt_of_lt_of_le (Nat.lt_succ_of_le (hold h hm)) (Nat.le_max_right _ _)
  · intro h hm
    exact Nat.lt_of_lt_of_le (Nat.lt_succ_of_le (hmid h hm)) (Nat.le_max_right _ _)

/-! ### E-LIN is necessary: checking only at admission lets a write land inside the hold. -/

structure QSt where
  floor : Nat
  minted : List Nat
  queue : List Nat
  log : List Nat

inductive QEv
  | raise (g : Nat) | mint (g : Nat) | admit (g : Nat) | commit

/-- Admission-only semantics: the check happens when a write is queued; committing applies it unchecked. -/
def applyAdmit (s : QSt) : QEv → QSt
  | .raise g => { s with floor := max s.floor g }
  | .mint g => { s with minted := g :: s.minted }
  | .admit g => if s.floor ≤ g ∧ g ∈ s.minted then { s with queue := s.queue ++ [g] } else s
  | .commit => match s.queue with
    | [] => s
    | w :: q => { s with queue := q, log := s.log ++ [w] }

/-- Check-at-apply semantics with the same queue: committing re-checks the floor. -/
def applyLin (s : QSt) : QEv → QSt
  | .raise g => { s with floor := max s.floor g }
  | .mint g => { s with minted := g :: s.minted }
  | .admit g => if s.floor ≤ g ∧ g ∈ s.minted then { s with queue := s.queue ++ [g] } else s
  | .commit => match s.queue with
    | [] => s
    | w :: q => if s.floor ≤ w then { s with queue := q, log := s.log ++ [w] } else { s with queue := q }

def start : QSt := ⟨1, [], [], []⟩

/-- The trace: generation 1 is minted and admits a write; the hold raises the floor to 2; then commit. -/
def held : List QEv := [.mint 1, .admit 1, .raise 2]

/-- Under admission-only checking, the write lands after the floor was raised: inside the hold. -/
theorem admission_only_lands_in_hold :
    (held.foldl applyAdmit start).log = [] ∧
    (applyAdmit (held.foldl applyAdmit start) .commit).log = [1] := by decide

/-- Under check-at-apply (E-LIN), the same trace lands nothing inside the hold. -/
theorem check_at_apply_refuses :
    (applyLin (held.foldl applyLin start) .commit).log = [] := by decide

end UPTFence
