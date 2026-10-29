import Snuffy.FIFOWorkload
import Snuffy.R17AQueueFinality

/-!
R17-WC: carry-in and whole-path workload certificates (23 October 2026, ZCode).

Mechanises the four targets of the received `LEAN-TARGETS.md`, on top of the
compiled FIFO lane (`FIFOWorkload`) and the compiled R17-A application machine
(`R17AQueueFinality`), in Lean core only.

WC1  Carry-in: a prefix holding W remaining units at checkpoint t finishes by t+u
     whenever the stage service contract delivers beta u units over every interval
     from t during which the prefix is still backlogged. The contract is quantified
     from the checkpoint, never from time zero. The affine curve of WORK.md,
     beta u = R·[u − T]⁺, gives the integer certificate t + T + ⌈W/R⌉.
WC2  Serial stages: an execution C over the resident/stage grid that respects each
     stage's head-of-line service contract satisfies C i k ≤ U i k for the max-plus
     envelope U. C is a free function constrained by hypotheses; it is not defined
     to be U. Every resident's deadline then follows from U i K ≤ d i.
WC3  Tail admission leaves every earlier envelope cell unchanged, so prior
     certificates survive and only the new row needs checking.
WC4  An effect actually applied at its stage-K completion is both timely and carries
     a current R17-A permit witness; a timely but revoked ticket is refused, which is
     safe refusal and not delivery.

What this file does not do: it does not price any WorkConcrete operation, does not
assert that two named stages are distinct physical servers, does not supply the
service contracts, and does not infer acceptance from completion. Those are the
blank rows of the typed ledger and the held whole-plant allocation.
-/
namespace SnuffyWC

/-! ## WC1: carry-in on one FIFO prefix -/

/-- Cumulative useful service delivered to one FIFO target prefix, by absolute time. -/
structure Lane where
  served : Nat → Nat
  mono : ∀ s, served s ≤ served (s+1)

theorem Lane.mono_le (L : Lane) {a b : Nat} (h : a ≤ b) : L.served a ≤ L.served b := by
  induction h with
  | refl => exact Nat.le_refl _
  | step _ ih => exact Nat.le_trans ih (L.mono _)

/-- The prefix that held W remaining units at checkpoint t is finished at time s. -/
def Finished (L : Lane) (t W s : Nat) : Prop := W ≤ L.served s - L.served t

/-- FIFO work conservation: a prefix still unfinished at t+u was unfinished, hence
    backlogged, at every time from t to t+u. This is what lets a service contract
    stated "while backlogged" be applied over the whole interval. -/
theorem unfinished_before (L : Lane) (t W u v : Nat) (hv : v ≤ u)
    (h : ¬ Finished L t W (t+u)) : ¬ Finished L t W (t+v) := by
  intro hf
  apply h
  unfold Finished at *
  have := L.mono_le (Nat.add_le_add_left hv t)
  omega

/-- **WC1 (carry-in completion).** The service contract is quantified from the
    checkpoint t: over any [t, t+v] throughout which the prefix is still unfinished,
    at least beta v useful units reach it. Then beta u ≥ W finishes it by t+u. -/
theorem carry_in_completion (L : Lane) (t W u : Nat) (beta : Nat → Nat)
    (contract : ∀ v, v ≤ u → (∀ s, s ≤ v → ¬ Finished L t W (t+s)) →
        beta v ≤ L.served (t+v) - L.served t)
    (enough : W ≤ beta u) : Finished L t W (t+u) := by
  apply Classical.byContradiction
  intro h
  have busy : ∀ s, s ≤ u → ¬ Finished L t W (t+s) :=
    fun s hs => unfinished_before L t W u s hs h
  have delivered := contract u (Nat.le_refl u) busy
  exact h (by unfold Finished; omega)

/-- The affine residual curve of WORK.md: R units per date after latency T, truncated. -/
def affine (R T : Nat) (u : Nat) : Nat := R * (u - T)

/-- Integer dates are purchased whole: ⌈W/R⌉ dates at rate R cover W units. -/
theorem ceil_div_covers (W R : Nat) (hR : 0 < R) : W ≤ R * ((W + R - 1) / R) := by
  have hdm := Nat.div_add_mod (W + R - 1) R
  have hlt := Nat.mod_lt (W + R - 1) hR
  omega

/-- **WC1, affine form.** With rate R > 0 and latency T, the prefix finishes by
    t + T + ⌈W/R⌉. This is the inverse response bound tau(w) = T + ⌈w/R⌉ of the
    proof candidate, in integer dates. -/
theorem carry_in_affine (L : Lane) (t W R T : Nat) (hR : 0 < R)
    (contract : ∀ v, v ≤ T + (W + R - 1) / R → (∀ s, s ≤ v → ¬ Finished L t W (t+s)) →
        affine R T v ≤ L.served (t+v) - L.served t) :
    Finished L t W (t + (T + (W + R - 1) / R)) := by
  apply carry_in_completion L t W _ (affine R T) contract
  unfold affine
  rw [Nat.add_sub_cancel_left]
  exact ceil_div_covers W R hR

/-- Control: the service contract is load-bearing. With no delivery guarantee the
    prefix may never finish, whatever beta promises on paper. -/
theorem no_service_no_completion (t W u : Nat) (hW : 0 < W) :
    ¬ Finished ⟨fun _ => 0, fun _ => Nat.le_refl 0⟩ t W (t+u) := by
  unfold Finished; simp; omega

/-! ## WC2: serial stages, max-plus envelope -/

/-- Row i of the envelope, given the previous resident's row `prev` as the
    busy-until bound of each stage, this resident's release, and its per-stage
    complete work. Stage k+1 starts when both this resident's stage k and the
    previous resident's stage k+1 are done. -/
def row (tau : Nat → Nat → Nat) (prev : Nat → Nat) (release : Nat) (work : Nat → Nat) :
    Nat → Nat
  | 0 => release
  | k+1 => max (row tau prev release work k) (prev (k+1)) + tau (k+1) (work (k+1))

/-- The max-plus envelope. Row 0 is the inherited busy-until bound h of each stage
    at the checkpoint; column 0 is each resident's release r. -/
def U (r h : Nat → Nat) (tau : Nat → Nat → Nat) (b : Nat → Nat → Nat) : Nat → Nat → Nat
  | 0 => h
  | i+1 => row tau (U r h tau b i) (r (i+1)) (b (i+1))

theorem U_succ_succ (r h : Nat → Nat) (tau : Nat → Nat → Nat) (b : Nat → Nat → Nat)
    (i k : Nat) :
    U r h tau b (i+1) (k+1) =
      max (U r h tau b (i+1) k) (U r h tau b i (k+1)) + tau (k+1) (b (i+1) (k+1)) := rfl

/-- **WC2 (max-plus stage domination).** C is any execution: completion time of
    resident i at stage k. Hypotheses: inherited stage state is bounded by h; a
    resident's stage-0 "completion" is its release; and each stage keeps its
    head-of-line contract, finishing within tau of the moment both predecessors
    are done. Then C never exceeds the envelope. Double induction on (i, k). -/
theorem exec_le_envelope (C : Nat → Nat → Nat) (r h : Nat → Nat)
    (tau : Nat → Nat → Nat) (b : Nat → Nat → Nat)
    (inherited : ∀ k, C 0 k ≤ h k)
    (released : ∀ i, C (i+1) 0 ≤ r (i+1))
    (contract : ∀ i k,
      C (i+1) (k+1) ≤ max (C (i+1) k) (C i (k+1)) + tau (k+1) (b (i+1) (k+1))) :
    ∀ i k, C i k ≤ U r h tau b i k := by
  intro i
  induction i with
  | zero => intro k; exact inherited k
  | succ i ih =>
    intro k
    induction k with
    | zero => exact released i
    | succ k ihk =>
      have h2 := ih (k+1)
      have hc := contract i k
      rw [U_succ_succ]
      omega

/-- **WC2 (deadlines).** Checking every resident's envelope cell at the final stage
    certifies every resident's actual completion. -/
theorem deadlines_met (C : Nat → Nat → Nat) (r h : Nat → Nat)
    (tau : Nat → Nat → Nat) (b : Nat → Nat → Nat) (K : Nat) (d : Nat → Nat)
    (inherited : ∀ k, C 0 k ≤ h k)
    (released : ∀ i, C (i+1) 0 ≤ r (i+1))
    (contract : ∀ i k,
      C (i+1) (k+1) ≤ max (C (i+1) k) (C i (k+1)) + tau (k+1) (b (i+1) (k+1)))
    (certified : ∀ i, U r h tau b (i+1) K ≤ d (i+1)) :
    ∀ i, C (i+1) K ≤ d (i+1) :=
  fun i => Nat.le_trans
    (exec_le_envelope C r h tau b inherited released contract (i+1) K) (certified i)

/-! ## WC3: tail admission preserves earlier cells -/

theorem row_congr (tau : Nat → Nat → Nat) (p p' : Nat → Nat) (release : Nat)
    (w w' : Nat → Nat) (hp : ∀ k, p k = p' k) (hw : ∀ k, w k = w' k) :
    ∀ k, row tau p release w k = row tau p' release w' k := by
  intro k
  induction k with
  | zero => rfl
  | succ k ih => simp only [row, ih, hp, hw]

/-- **WC3 (tail invariant).** Two admission orders that agree on residents 1..n
    have identical envelope rows 1..n, whatever is appended after. -/
theorem tail_admission_invariant (r r' h : Nat → Nat) (tau : Nat → Nat → Nat)
    (b b' : Nat → Nat → Nat) (n : Nat)
    (hr : ∀ i, i ≤ n → r i = r' i) (hb : ∀ i, i ≤ n → ∀ k, b i k = b' i k) :
    ∀ i, i ≤ n → ∀ k, U r h tau b i k = U r' h tau b' i k := by
  intro i
  induction i with
  | zero => intro _ k; rfl
  | succ i ih =>
    intro hi k
    have hprev := ih (Nat.le_of_succ_le hi)
    show row tau (U r h tau b i) (r (i+1)) (b (i+1)) k =
      row tau (U r' h tau b' i) (r' (i+1)) (b' (i+1)) k
    rw [hr (i+1) hi]
    exact row_congr tau _ _ _ _ _ hprev (hb (i+1) hi) k

/-- Admitting resident n+1 at the tail keeps every earlier certificate; only the
    new row is checked. Insertion ahead of others is outside this theorem. -/
theorem tail_admission_preserves_certificates (r r' h : Nat → Nat)
    (tau : Nat → Nat → Nat) (b b' : Nat → Nat → Nat) (n K : Nat) (d : Nat → Nat)
    (hr : ∀ i, i ≤ n → r i = r' i) (hb : ∀ i, i ≤ n → ∀ k, b i k = b' i k)
    (before : ∀ i, i ≤ n → U r h tau b i K ≤ d i) :
    ∀ i, i ≤ n → U r' h tau b' i K ≤ d i := by
  intro i hi
  rw [← tail_admission_invariant r r' h tau b b' n hr hb i hi K]
  exact before i hi

/-! ## WC4: the join to R17-A at application time -/

/-- **WC4.** If an effect is actually applied at resident i's stage-K completion,
    that completion is within the certified deadline and the application carries
    a current R17-A permit witness. Acceptance is never inferred from timing. -/
theorem applied_stage_effect_is_timely_and_authorized
    (C : Nat → Nat → Nat) (r h : Nat → Nat) (tau : Nat → Nat → Nat)
    (b : Nat → Nat → Nat) (K : Nat) (d : Nat → Nat) (i : Nat)
    (inherited : ∀ k, C 0 k ≤ h k)
    (released : ∀ i, C (i+1) 0 ≤ r (i+1))
    (contract : ∀ i k,
      C (i+1) (k+1) ≤ max (C (i+1) k) (C i (k+1)) + tau (k+1) (b (i+1) (k+1)))
    (certified : U r h tau b (i+1) K ≤ d (i+1))
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine)
    (ticket : Nat) (e : UPTR12A.Effect)
    (hnow : s.now = C (i+1) K)
    (happend : (UPTR17A.applyOne registry s ticket e).applied ≠ s.applied) :
    s.now ≤ d (i+1) ∧
      ∃ p, registry ticket = some p ∧ UPTR17A.Ready s ticket e p := by
  constructor
  · rw [hnow]
    exact Nat.le_trans
      (exec_le_envelope C r h tau b inherited released contract (i+1) K) certified
  · exact UPTR17A.new_effect_has_current_permit registry s ticket e happend

/-- **Control (v).** A timely completion with a revoked ticket is refused: safe
    refusal under R17-A, and therefore not delivered care. Timing certificates do
    not establish delivery. -/
theorem timely_but_revoked_is_not_delivery
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine)
    (ticket : Nat) (e : UPTR12A.Effect) (deadline : Nat)
    (_timely : s.now ≤ deadline) (revoked : ticket ∈ s.revoked) :
    (UPTR17A.applyOne registry s ticket e).applied = s.applied :=
  UPTR17A.revoked_refuses registry s ticket e revoked

/-! ## Adversarial controls, on the actual envelope -/

/-- Control (i): head-of-line blocking. Eight inherited units, then an urgent one-unit
    job released at 1 with deadline 3: it completes at 9. -/
example : U (fun _ => 1) (fun _ => 8) (fun _ w => w) (fun _ _ => 1) 1 1 = 9 := by decide
example : ¬ (U (fun _ => 1) (fun _ => 8) (fun _ w => w) (fun _ _ => 1) 1 1 ≤ 3) := by decide

/-- Control (ii): Gemini's filled bounds in twentieths, 2+1+8+4+2+5 = 22 > 20. -/
example : ¬ (2 + 1 + 8 + 4 + 2 + 5 ≤ 20) := by decide

/-- Control (iii): a missing application stage. One stage of nine units meets a
    deadline of ten; adding the two-unit physical application stage gives eleven. -/
example : U (fun _ => 0) (fun _ => 0) (fun _ w => w) (fun _ _ => 9) 1 1 = 9 := by decide
example : U (fun _ => 0) (fun _ => 0) (fun _ w => w)
    (fun _ k => if k = 1 then 9 else 2) 1 2 = 11 := by decide

/-- Control (iv): the last resident's deadline does not certify earlier residents.
    Two residents released at 0 with work 5 and 1; the second meets 10, the first
    misses 3. -/
example : U (fun _ => 0) (fun _ => 0) (fun _ w => w)
    (fun i _ => if i = 1 then 5 else 1) 2 1 = 6 := by decide
example : ¬ (U (fun _ => 0) (fun _ => 0) (fun _ w => w)
    (fun i _ => if i = 1 then 5 else 1) 1 1 ≤ 3) := by decide

/-- Control (v′): aliased stages. Two one-unit operations per resident treated as two
    independent stages give the second resident completion 3; coalesced onto the one
    real server they take 4. Separate stages need separate reserved capacity. -/
example : U (fun _ => 0) (fun _ => 0) (fun _ w => w) (fun _ _ => 1) 2 2 = 3 := by decide
example : SnuffyFIFO.finish 0 [⟨0, 2, 10⟩, ⟨0, 2, 10⟩] (fun j => j.budget) = 4 := by decide

end SnuffyWC

