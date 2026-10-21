import Std

namespace UPTAdaptiveWithdrawal

/-- Each position records potential service and an arbitrary outcome-dependent removal bit. -/
abbrev Trial := List (Bool × Bool)

def potential : Trial → Nat
  | [] => 0
  | (available, _) :: xs => (if available then 1 else 0) + potential xs

def removed : Trial → Nat
  | [] => 0
  | (_, erased) :: xs => (if erased then 1 else 0) + removed xs

def retained : Trial → Nat
  | [] => 0
  | (available, erased) :: xs => (if available && !erased then 1 else 0) + retained xs

/-- Pointwise, hence valid even when every removal bit sees the entire outcome. -/
theorem erasure_count (xs : Trial) : potential xs ≤ retained xs + removed xs := by
  induction xs with
  | nil => simp [potential, retained, removed]
  | cons p xs ih =>
    rcases p with ⟨a, e⟩
    cases a <;> cases e <;> simp_all [potential, retained, removed] <;> omega

/-- A survivor shortage forces a correspondingly shifted potential-service shortage. -/
theorem adaptive_shortage (xs : Trial) (w k : Nat)
    (cap : removed xs ≤ w) (shortage : retained xs < k) :
    potential xs < k + w := by
  have h := erasure_count xs
  omega

/-- Rescue's doubled threshold, with no independence or selection-time premise. -/
theorem adaptive_rescue (xs : Trial) (w n : Nat)
    (cap : removed xs ≤ w) (shortage : 2 * retained xs ≤ n) :
    2 * potential xs ≤ n + 2 * w := by
  have h := erasure_count xs
  omega

/-- Any supplied upper set-event certificate transfers to fully adaptive removals. -/
theorem shortage_event_inclusion (w k : Nat) :
    ∀ xs : Trial, removed xs ≤ w → retained xs < k → potential xs < k + w := by
  intro xs cap shortage
  exact adaptive_shortage xs w k cap shortage

#print axioms erasure_count
#print axioms adaptive_shortage
#print axioms adaptive_rescue
#print axioms shortage_event_inclusion


def faulted : Trial → Nat
  | [] => 0
  | (available, _) :: xs => (if available then 0 else 1) + faulted xs

theorem fault_partition (xs : Trial) : potential xs + faulted xs = xs.length := by
  induction xs with
  | nil => simp [potential, faulted]
  | cons p xs ih =>
    rcases p with ⟨a, e⟩
    cases a <;> cases e <;> simp_all [potential, faulted] <;> omega

/-- No assumption on how removals depend on faults or the complete outcome. -/
theorem adaptive_fault_capacity (xs : Trial) (w f k : Nat)
    (cap : removed xs ≤ w) (fault_cap : faulted xs ≤ f)
    (enough : k + w + f ≤ xs.length) : k ≤ retained xs := by
  have h := erasure_count xs
  have p := fault_partition xs
  omega

theorem shortage_forces_faults (xs : Trial) (w k : Nat)
    (cap : removed xs ≤ w) (shortage : retained xs < k) :
    xs.length + 1 ≤ faulted xs + w + k := by
  have h := erasure_count xs
  have p := fault_partition xs
  omega

/-- The original design point, with a deliberately loose 1000-fault screen. -/
theorem existing_design_capacity (xs : Trial)
    (size : xs.length = 115200) (cap : removed xs ≤ 42800)
    (few_faults : faulted xs < 1000) : 71401 ≤ retained xs := by
  apply adaptive_fault_capacity xs 42800 999 71401 cap
  · omega
  · omega

theorem existing_design_channels (xs : Trial)
    (size : xs.length = 115200) (cap : removed xs ≤ 42800)
    (few_faults : faulted xs < 1000) :
    45743 ≤ retained xs ∧ 115200 < 2 * retained xs := by
  have h := existing_design_capacity xs size cap few_faults
  constructor <;> omega

theorem exact_rescue_fault_threshold (xs : Trial)
    (size : xs.length = 115200) (cap : removed xs ≤ 42800)
    (shortage : 2 * retained xs ≤ 115200) : 14800 ≤ faulted xs := by
  have h := erasure_count xs
  have p := fault_partition xs
  omega

theorem exact_holding_fault_threshold (xs : Trial)
    (size : xs.length = 115200) (cap : removed xs ≤ 42800)
    (shortage : retained xs < 45743) : 26658 ≤ faulted xs := by
  have h := shortage_forces_faults xs 42800 45743 cap shortage
  omega

theorem potential_append (xs ys : Trial) :
    potential (xs ++ ys) = potential xs + potential ys := by
  induction xs with
  | nil => simp [potential]
  | cons p xs ih => cases p with
    | mk a e => simp [potential, ih, Nat.add_assoc]

theorem removed_append (xs ys : Trial) :
    removed (xs ++ ys) = removed xs + removed ys := by
  induction xs with
  | nil => simp [removed]
  | cons p xs ih => cases p with
    | mk a e => simp [removed, ih, Nat.add_assoc]

theorem retained_append (xs ys : Trial) :
    retained (xs ++ ys) = retained xs + retained ys := by
  induction xs with
  | nil => simp [retained]
  | cons p xs ih => cases p with
    | mk a e => simp [retained, ih, Nat.add_assoc]

theorem replicate_counts (n : Nat) (a e : Bool) :
    potential (List.replicate n (a,e)) = n * (if a then 1 else 0) ∧
    removed (List.replicate n (a,e)) = n * (if e then 1 else 0) ∧
    retained (List.replicate n (a,e)) = n * (if a && !e then 1 else 0) := by
  induction n with
  | zero => simp [potential, removed, retained]
  | succ n ih =>
    cases a <;> cases e <;>
      simp_all [List.replicate_succ, potential, removed, retained, Nat.add_comm]

/-- A worst eraser removes successful roles first. This witnesses sharpness for every parameter. -/
def worst (s w f : Nat) : Trial :=
  List.replicate (min s w) (true,true) ++
  List.replicate (s-w) (true,false) ++ List.replicate f (false,false)

theorem worst_counts (s w f : Nat) :
    potential (worst s w f) = s ∧ removed (worst s w f) = min s w ∧
    retained (worst s w f) = s-w := by
  simp only [worst, potential_append, removed_append, retained_append]
  have a := replicate_counts (min s w) true true
  have b := replicate_counts (s-w) true false
  have c := replicate_counts f false false
  simp at a b c
  rcases a with ⟨ap, ar, av⟩
  rcases b with ⟨bp, br, bv⟩
  rcases c with ⟨cp, cr, cv⟩
  rw [ap, ar, av, bp, br, bv, cp, cr, cv]
  omega

/-- Exact optimal pathwise survivor bound; no probability law enters this theorem. -/
theorem sharp_survivor_bound (xs : Trial) (w : Nat) (cap : removed xs ≤ w) :
    potential xs - w ≤ retained xs := by
  have h := erasure_count xs
  omega

#print axioms fault_partition
#print axioms adaptive_fault_capacity
#print axioms shortage_forces_faults
#print axioms existing_design_capacity
#print axioms existing_design_channels
#print axioms exact_rescue_fault_threshold
#print axioms exact_holding_fault_threshold
#print axioms worst_counts
#print axioms sharp_survivor_bound

end UPTAdaptiveWithdrawal
