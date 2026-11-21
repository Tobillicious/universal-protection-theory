/-!
Rung 4 / Lemma F': a source-enforced failure-settlement escrow.

Each queued ticket retains its recipient, full refund, bonus and separately
funded complete service charge. Arbitrary adaptive anchor requests can draw
only free stock; a breach forfeits the posted bond. Every funded source tick
pays the next ticket. The anchor cannot cancel the queue or divert its reserve.

This is an executable controller and source-trace theorem. Actual custody,
complete request/effect mediation, ticket issuance/identity, physical transfers
and the certified complete service charges remain installation correspondences.
No universal voluntary cooperation or zero-cost computation is assumed.
-/

namespace PhysicalBridges.AnchorPledgeForfeiture

structure Claim where
  recipient : Nat
  refund : Nat
  bonus : Nat
  serviceCost : Nat
  deriving DecidableEq, Repr

def refundTotal : List Claim → Nat
  | [] => 0
  | c :: cs => c.refund + refundTotal cs

def bonusTotal : List Claim → Nat
  | [] => 0
  | c :: cs => c.bonus + bonusTotal cs

def workTotal : List Claim → Nat
  | [] => 0
  | c :: cs => c.serviceCost + workTotal cs

def cashTotal (cs : List Claim) : Nat := refundTotal cs + bonusTotal cs

theorem refundTotal_append (xs ys : List Claim) :
    refundTotal (xs ++ ys) = refundTotal xs + refundTotal ys := by
  induction xs with
  | nil => simp only [List.nil_append, refundTotal, Nat.zero_add]
  | cons c cs ih => simp only [List.cons_append, refundTotal, ih]; omega

theorem bonusTotal_append (xs ys : List Claim) :
    bonusTotal (xs ++ ys) = bonusTotal xs + bonusTotal ys := by
  induction xs with
  | nil => simp only [List.nil_append, bonusTotal, Nat.zero_add]
  | cons c cs ih => simp only [List.cons_append, bonusTotal, ih]; omega

theorem workTotal_append (xs ys : List Claim) :
    workTotal (xs ++ ys) = workTotal xs + workTotal ys := by
  induction xs with
  | nil => simp only [List.nil_append, workTotal, Nat.zero_add]
  | cons c cs ih => simp only [List.cons_append, workTotal, ih]; omega

structure State where
  free : Nat
  cashReserve : Nat
  workReserve : Nat
  bond : Nat
  withdrawn : Nat
  forfeited : Nat
  pending : List Claim
  paid : List Claim
  deriving DecidableEq, Repr

def Ready (s : State) : Prop :=
  cashTotal s.pending ≤ s.cashReserve ∧ workTotal s.pending ≤ s.workReserve

/-- Paid transfers and spent service work remain in the complete ledger.
Withdrawal and forfeiture are transfers, not new energy income. -/
def stock (s : State) : Nat :=
  s.free + s.cashReserve + s.workReserve + s.bond + s.withdrawn + s.forfeited +
    refundTotal s.paid + bonusTotal s.paid + workTotal s.paid

/-- A fixed finite command alphabet; no unbounded attacker-supplied numeric
word is hidden inside the per-ticket service-cost bound. -/
inductive Request where
  | idle
  | withdrawFree
  | breach
  deriving DecidableEq, Repr

/-- The command grammar has no operation that releases another ticket's
reserved refund/bonus or service work. Breach consumes the anchor's bond. -/
def respond (request : Request) (s : State) : State :=
  match request with
  | .idle => s
  | .withdrawFree =>
      { s with free := 0, withdrawn := s.withdrawn + s.free }
  | .breach => { s with bond := 0, forfeited := s.forfeited + s.bond }

def settle (s : State) : State :=
  match s.pending with
  | [] => s
  | c :: cs =>
      if c.refund + c.bonus ≤ s.cashReserve ∧ c.serviceCost ≤ s.workReserve then
        { s with
          cashReserve := s.cashReserve - (c.refund + c.bonus)
          workReserve := s.workReserve - c.serviceCost
          pending := cs
          paid := s.paid ++ [c] }
      else s

/-- Settlement is automatic on every nonterminal source tick. A completed
epoch is quiescent; later operations need their own charged source epoch. -/
def tick (request : Request) (s : State) : State :=
  match s.pending with
  | [] => s
  | _ :: _ => settle (respond request s)

def fundedState (available bond : Nat) (claims : List Claim) : State :=
  { free := available - (bond + cashTotal claims + workTotal claims)
    cashReserve := cashTotal claims
    workReserve := workTotal claims
    bond := bond
    withdrawn := 0
    forfeited := 0
    pending := claims
    paid := [] }

def commit (available bond : Nat) (claims : List Claim) : Option State :=
  if bond + cashTotal claims + workTotal claims ≤ available then
    some (fundedState available bond claims)
  else none

theorem fundedState_ready (available bond : Nat) (claims : List Claim) :
    Ready (fundedState available bond claims) := by
  exact ⟨Nat.le_refl _, Nat.le_refl _⟩

theorem fundedState_stock (available bond : Nat) (claims : List Claim)
    (hBudget : bond + cashTotal claims + workTotal claims ≤ available) :
    stock (fundedState available bond claims) = available := by
  simp only [stock, fundedState, refundTotal, bonusTotal, workTotal]
  omega

theorem commit_accepts_funded (available bond : Nat) (claims : List Claim)
    (hBudget : bond + cashTotal claims + workTotal claims ≤ available) :
    commit available bond claims = some (fundedState available bond claims) := by
  simp only [commit, ite_eq_left hBudget]

theorem commit_rejects_unfunded (available bond : Nat) (claims : List Claim)
    (hBudget : available < bond + cashTotal claims + workTotal claims) :
    commit available bond claims = none := by
  simp only [commit, ite_eq_right (Nat.not_le.mpr hBudget)]

/-- The executable admission result supplies readiness and the complete
conservation certificate, without assuming a cooperative anchor. -/
theorem accepted_commit_certificate (available bond : Nat) (claims : List Claim)
    (s : State) (h : commit available bond claims = some s) :
    Ready s ∧ stock s = available ∧ s.pending = claims ∧ s.paid = [] := by
  unfold commit at h
  split at h
  · rename_i hBudget
    have heq := Option.some.inj h
    rw [← heq]
    exact ⟨fundedState_ready available bond claims,
      fundedState_stock available bond claims hBudget, rfl, rfl⟩
  · cases h

theorem respond_ready (request : Request) (s : State) (h : Ready s) :
    Ready (respond request s) := by
  cases request <;> exact h

theorem respond_stock (request : Request) (s : State) :
    stock (respond request s) = stock s := by
  cases request with
  | idle => rfl
  | withdrawFree => simp only [respond, stock]; omega
  | breach => simp only [respond, stock]; omega

theorem respond_inventory (request : Request) (s : State) :
    (respond request s).paid ++ (respond request s).pending = s.paid ++ s.pending := by
  cases request <;> rfl

theorem respond_pending (request : Request) (s : State) :
    (respond request s).pending = s.pending := by
  cases request <;> rfl

theorem respond_forfeiture_monotone (request : Request) (s : State) :
    s.forfeited ≤ (respond request s).forfeited := by
  cases request <;> simp only [respond] <;> omega

theorem settle_ready (s : State) (h : Ready s) : Ready (settle s) := by
  cases hp : s.pending with
  | nil => simpa only [settle, hp] using h
  | cons c cs =>
      have hCash := h.1
      have hWork := h.2
      simp only [hp, cashTotal, refundTotal, bonusTotal, workTotal] at hCash hWork
      have hGate : c.refund + c.bonus ≤ s.cashReserve ∧ c.serviceCost ≤ s.workReserve :=
        ⟨by omega, by omega⟩
      simp only [settle, hp, ite_eq_left hGate, Ready, cashTotal]
      constructor <;> omega

theorem settle_stock (s : State) : stock (settle s) = stock s := by
  cases hp : s.pending with
  | nil => simp only [settle, hp]
  | cons c cs =>
      by_cases hGate : c.refund + c.bonus ≤ s.cashReserve ∧ c.serviceCost ≤ s.workReserve
      · have hCash := hGate.1
        have hWork := hGate.2
        simp only [settle, hp, ite_eq_left hGate, stock, refundTotal_append,
          bonusTotal_append, workTotal_append, refundTotal, bonusTotal, workTotal]
        omega
      · simp only [settle, hp, ite_eq_right hGate]

theorem settle_inventory (s : State) :
    (settle s).paid ++ (settle s).pending = s.paid ++ s.pending := by
  cases hp : s.pending with
  | nil => simp only [settle, hp]
  | cons c cs =>
      by_cases hGate : c.refund + c.bonus ≤ s.cashReserve ∧ c.serviceCost ≤ s.workReserve
      · simp only [settle, hp, ite_eq_left hGate, List.append_assoc, List.singleton_append]
      · simp only [settle, hp, ite_eq_right hGate]

theorem settle_forfeiture (s : State) : (settle s).forfeited = s.forfeited := by
  cases hp : s.pending with
  | nil => simp only [settle, hp]
  | cons c cs =>
      by_cases hGate : c.refund + c.bonus ≤ s.cashReserve ∧ c.serviceCost ≤ s.workReserve
      · simp only [settle, hp, ite_eq_left hGate]
      · simp only [settle, hp, ite_eq_right hGate]

theorem settle_bond (s : State) : (settle s).bond = s.bond := by
  cases hp : s.pending with
  | nil => simp only [settle, hp]
  | cons c cs =>
      by_cases hGate : c.refund + c.bonus ≤ s.cashReserve ∧ c.serviceCost ≤ s.workReserve
      · simp only [settle, hp, ite_eq_left hGate]
      · simp only [settle, hp, ite_eq_right hGate]

theorem settle_pending_length (s : State) (h : Ready s) :
    (settle s).pending.length = s.pending.length - 1 := by
  cases hp : s.pending with
  | nil => simp only [settle, hp, List.length_nil, Nat.zero_sub]
  | cons c cs =>
      have hCash := h.1
      have hWork := h.2
      simp only [hp, cashTotal, refundTotal, bonusTotal, workTotal] at hCash hWork
      have hGate : c.refund + c.bonus ≤ s.cashReserve ∧ c.serviceCost ≤ s.workReserve :=
        ⟨by omega, by omega⟩
      simp only [settle, hp, ite_eq_left hGate, List.length_cons, Nat.add_sub_cancel]

theorem tick_ready (request : Request) (s : State) (h : Ready s) :
    Ready (tick request s) := by
  cases hp : s.pending with
  | nil => simpa only [tick, hp] using h
  | cons c cs =>
      simp only [tick, hp]
      exact settle_ready _ (respond_ready request s h)

theorem tick_stock (request : Request) (s : State) :
    stock (tick request s) = stock s := by
  cases hp : s.pending with
  | nil => simp only [tick, hp]
  | cons c cs => simp only [tick, hp, settle_stock, respond_stock]

theorem tick_inventory (request : Request) (s : State) :
    (tick request s).paid ++ (tick request s).pending = s.paid ++ s.pending := by
  cases hp : s.pending with
  | nil => simp only [tick, hp]
  | cons c cs => simp only [tick, hp, settle_inventory, respond_inventory]

theorem tick_forfeiture_monotone (request : Request) (s : State) :
    s.forfeited ≤ (tick request s).forfeited := by
  cases hp : s.pending with
  | nil => simpa only [tick, hp] using Nat.le_refl s.forfeited
  | cons c cs =>
      simp only [tick, hp, settle_forfeiture]
      exact respond_forfeiture_monotone request s

theorem breach_forfeits_bond (s : State) (h : s.pending ≠ []) :
    (tick .breach s).forfeited = s.forfeited + s.bond := by
  cases hp : s.pending with
  | nil => exact False.elim (h hp)
  | cons c cs => simp only [tick, hp, settle_forfeiture, respond]

theorem breach_zeroes_bond (s : State) (h : s.pending ≠ []) :
    (tick .breach s).bond = 0 := by
  cases hp : s.pending with
  | nil => exact False.elim (h hp)
  | cons c cs => simp only [tick, hp, settle_bond, respond]

theorem tick_pending_length (request : Request) (s : State) (h : Ready s) :
    (tick request s).pending.length = s.pending.length - 1 := by
  cases hp : s.pending with
  | nil => simp only [tick, hp, List.length_nil, Nat.zero_sub]
  | cons c cs =>
      simp only [tick, hp]
      rw [settle_pending_length _ (respond_ready request s h), respond_pending, hp]

/-- Requests may depend on the entire current source state and time. -/
def run (policy : Nat → State → Request) (start : State) : Nat → State
  | 0 => start
  | n + 1 => tick (policy n (run policy start n)) (run policy start n)

theorem run_ready (policy : Nat → State → Request) (start : State)
    (h : Ready start) (n : Nat) : Ready (run policy start n) := by
  induction n with
  | zero => exact h
  | succ n ih => exact tick_ready _ _ ih

theorem run_stock (policy : Nat → State → Request) (start : State) (n : Nat) :
    stock (run policy start n) = stock start := by
  induction n with
  | zero => rfl
  | succ n ih => simpa only [run, tick_stock] using ih

theorem run_inventory (policy : Nat → State → Request) (start : State) (n : Nat) :
    (run policy start n).paid ++ (run policy start n).pending =
      start.paid ++ start.pending := by
  induction n with
  | zero => rfl
  | succ n ih => simpa only [run, tick_inventory] using ih

theorem run_forfeiture_monotone (policy : Nat → State → Request) (start : State)
    (n : Nat) : start.forfeited ≤ (run policy start n).forfeited := by
  induction n with
  | zero => exact Nat.le_refl _
  | succ n ih => exact Nat.le_trans ih (tick_forfeiture_monotone _ _)

/-- A posted forfeiture cannot be withdrawn in any later source prefix. -/
theorem run_forfeiture_never_decreases (policy : Nat → State → Request) (start : State)
    (n m : Nat) :
    (run policy start n).forfeited ≤ (run policy start (n + m)).forfeited := by
  induction m with
  | zero => exact Nat.le_refl _
  | succ m ih =>
      rw [Nat.add_succ, run]
      exact Nat.le_trans ih (tick_forfeiture_monotone _ _)

theorem run_pending_length (policy : Nat → State → Request) (start : State)
    (h : Ready start) (n : Nat) :
    (run policy start n).pending.length = start.pending.length - n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      simp only [run]
      rw [tick_pending_length _ _ (run_ready policy start h n), ih]
      omega

/-- No fairness or anchor-cooperation premise: automatic settlement empties
the queue after exactly its initial length, preserving every full ticket. -/
theorem funded_failure_settles_every_claim
    (policy : Nat → State → Request) (start : State) (h : Ready start) :
    (run policy start start.pending.length).pending = [] ∧
      (run policy start start.pending.length).paid = start.paid ++ start.pending := by
  have hLength := run_pending_length policy start h start.pending.length
  have hEmpty : (run policy start start.pending.length).pending = [] := by
    apply List.length_eq_zero_iff.mp
    omega
  have hPaid := run_inventory policy start start.pending.length
  rw [hEmpty, List.append_nil] at hPaid
  exact ⟨hEmpty, hPaid⟩

end PhysicalBridges.AnchorPledgeForfeiture
