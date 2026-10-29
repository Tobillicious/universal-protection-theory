/-
Phase A — exact Lean certificates for the corrected shared-controller rows.

Mirrors `checks/controllers.py` (21 October independent bank, replayed 23 October) formula
for formula: strict aggregate stability, delta, rate R, debt A, high-FIFO allocation
charge, total sufficient deadline bound, exact batch bands, pool bills, and the two L2
allocation-undercharge countertraces. All arithmetic is exact rational arithmetic; no
rounding, no floats.

Batch bands are stated as the rational bounds `k ≤ x ∧ x < k+1`, which is exactly
`⌊x⌋₊ = k`; the checker's floor computation is replayed byte-for-byte in
evidence/controllers.stdout alongside these bounds.

Scope: certificates of the declared sufficient-certificate family at the corrected
integer splits. The exhaustive minimality scan (17/22 as the smallest passing capacities)
remains the exact Python checker's finite search, replayed in evidence/. No physical
service lane, authority persistence or whole-plant certification is claimed here.
-/

import Mathlib.Tactic

/-- delta = 9/20 + (m+3)/c : the high-class interference share (controllers.py `delta`). -/
def deltaQ (m c : ℚ) : ℚ := 9/20 + (m+3)/c

/-- rate R = e(1 - delta/20) - m : guaranteed net bulk service rate (`rate`). -/
def rateQ (m c e : ℚ) : ℚ := e*(1 - deltaQ m c/20) - m

/-- debt A = e(1/2 + sigma) + 2m with sigma = delta + delta^2/20 (`debt`). -/
def debtQ (m c e : ℚ) : ℚ := e*(1/2 + deltaQ m c + deltaQ m c*deltaQ m c/20) + 2*m

/-- High-FIFO allocation charge T_alloc = 7/20 + (m+3)/c (the corrected charge). -/
def allocFIFOQ (m c : ℚ) : ℚ := 7/20 + (m+3)/c

/-- Total sufficient deadline bound: 2 + alloc + (A + 3m + m*d + 1)/R. -/
def totalQ (m c e d : ℚ) : ℚ :=
  2 + allocFIFOQ m c + (debtQ m c e + 3*m + m*d + 1)/rateQ m c e

/-- Strict aggregate control stability: 3m/20 + 4m/d < c. -/
def stableQ (m c d : ℚ) : Prop := 3*m/20 + 4*m/d < c

/-! ## Corrected minimal row, three residents: capacity 17 = control 6 + bulk 11, batch 3 -/

theorem stable_min_three : stableQ 3 6 3 := by unfold stableQ; norm_num

theorem delta_min_three : deltaQ 3 6 = 29/20 := by unfold deltaQ; norm_num

theorem rate_min_three : rateQ 3 6 11 = 2881/400 := by unfold rateQ deltaQ; norm_num

theorem debt_min_three : debtQ 3 6 11 = 228851/8000 := by unfold debtQ deltaQ; norm_num

theorem alloc_min_three : allocFIFOQ 3 6 = 27/20 := by unfold allocFIFOQ; norm_num

theorem total_min_three : totalQ 3 6 11 3 = 6673/670 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num

theorem total_min_three_le : totalQ 3 6 11 3 ≤ 10 := by rw [total_min_three]; norm_num

/-- Batch band {3}: `2 ≤ 12/(6−9/20) < 3` gives first = 3, and
`3 ≤ ((8−alloc)·R − A − 10)/3 < 4` gives last = 3. -/
theorem band_min_three :
    ((2:ℚ) ≤ (4*3)/(6 - 3*3/20) ∧ (4*3)/(6 - 3*3/20) < 3)
    ∧ ((3:ℚ) ≤ ((8 - allocFIFOQ 3 6)*rateQ 3 6 11 - debtQ 3 6 11 - 3*3 - 1)/3
       ∧ ((8 - allocFIFOQ 3 6)*rateQ 3 6 11 - debtQ 3 6 11 - 3*3 - 1)/3 < 4) := by
  have h1 : ((4*3)/(6 - 3*3/20) : ℚ) = 240/111 := by norm_num
  have h2 : (((8 - allocFIFOQ 3 6)*rateQ 3 6 11 - debtQ 3 6 11 - 3*3 - 1)/3 : ℚ) = 12387/4000 := by
    unfold allocFIFOQ rateQ debtQ deltaQ; norm_num
  rw [h1, h2]; norm_num

/-! ## Corrected minimal row, four residents: capacity 22 = control 6 + bulk 16, batch 3 -/

theorem stable_min_four : stableQ 4 6 3 := by unfold stableQ; norm_num

theorem delta_min_four : deltaQ 4 6 = 97/60 := by unfold deltaQ; norm_num

theorem rate_min_four : rateQ 4 6 16 = 803/75 := by unfold rateQ deltaQ; norm_num

theorem debt_min_four : debtQ 4 6 16 = 197809/4500 := by unfold debtQ deltaQ; norm_num

theorem alloc_min_four : allocFIFOQ 4 6 = 91/60 := by unfold allocFIFOQ; norm_num

theorem total_min_four : totalQ 4 6 16 3 = 79957/8030 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num

theorem total_min_four_le : totalQ 4 6 16 3 ≤ 10 := by rw [total_min_four]; norm_num

/-- Batch band {3}: first = 3 and last = 3, as exact rational floor bounds. -/
theorem band_min_four :
    ((2:ℚ) ≤ (4*4)/(6 - 3*4/20) ∧ (4*4)/(6 - 3*4/20) < 3)
    ∧ ((3:ℚ) ≤ ((8 - allocFIFOQ 4 6)*rateQ 4 6 16 - debtQ 4 6 16 - 3*4 - 1)/4
       ∧ ((8 - allocFIFOQ 4 6)*rateQ 4 6 16 - debtQ 4 6 16 - 3*4 - 1)/4 < 4) := by
  have h1 : ((4*4)/(6 - 3*4/20) : ℚ) = 80/27 := by norm_num
  have h2 : (((8 - allocFIFOQ 4 6)*rateQ 4 6 16 - debtQ 4 6 16 - 3*4 - 1)/4 : ℚ) = 9343/3000 := by
    unfold allocFIFOQ rateQ debtQ deltaQ; norm_num
  rw [h1, h2]; norm_num

/-! ## Robust rows: three consecutive integer batches 2, 3, 4 -/

theorem stable_rob_three_two : stableQ 3 7 2 := by unfold stableQ; norm_num
theorem stable_rob_three_four : stableQ 3 7 4 := by unfold stableQ; norm_num

theorem total_rob_three_two : totalQ 3 7 11 2 = 1852753/203870 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num
theorem total_rob_three_three : totalQ 3 7 11 3 = 1936753/203870 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num
theorem total_rob_three_four : totalQ 3 7 11 4 = 2020753/203870 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num

theorem total_rob_three_two_le : totalQ 3 7 11 2 ≤ 10 := by rw [total_rob_three_two]; norm_num
theorem total_rob_three_three_le : totalQ 3 7 11 3 ≤ 10 := by rw [total_rob_three_three]; norm_num
theorem total_rob_three_four_le : totalQ 3 7 11 4 ≤ 10 := by rw [total_rob_three_four]; norm_num

/-- Robust three-resident batch band {2,3,4}: first = 2 and last = 4. -/
theorem band_rob_three :
    ((1:ℚ) ≤ (4*3)/(7 - 3*3/20) ∧ (4*3)/(7 - 3*3/20) < 2)
    ∧ ((4:ℚ) ≤ ((8 - allocFIFOQ 3 7)*rateQ 3 7 11 - debtQ 3 7 11 - 3*3 - 1)/3
       ∧ ((8 - allocFIFOQ 3 7)*rateQ 3 7 11 - debtQ 3 7 11 - 3*3 - 1)/3 < 5) := by
  have h1 : ((4*3)/(7 - 3*3/20) : ℚ) = 240/131 := by norm_num
  have h2 : (((8 - allocFIFOQ 3 7)*rateQ 3 7 11 - debtQ 3 7 11 - 3*3 - 1)/3 : ℚ) = 353947/84000 := by
    unfold allocFIFOQ rateQ debtQ deltaQ; norm_num
  rw [h1, h2]; norm_num

theorem stable_rob_four_two : stableQ 4 9 2 := by unfold stableQ; norm_num
theorem stable_rob_four_four : stableQ 4 9 4 := by unfold stableQ; norm_num

theorem total_rob_four_two : totalQ 4 9 14 2 = 1491007/164530 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num
theorem total_rob_four_three : totalQ 4 9 14 3 = 1563007/164530 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num
theorem total_rob_four_four : totalQ 4 9 14 4 = 1635007/164530 := by
  unfold totalQ allocFIFOQ rateQ debtQ deltaQ; norm_num

theorem total_rob_four_two_le : totalQ 4 9 14 2 ≤ 10 := by rw [total_rob_four_two]; norm_num
theorem total_rob_four_three_le : totalQ 4 9 14 3 ≤ 10 := by rw [total_rob_four_three]; norm_num
theorem total_rob_four_four_le : totalQ 4 9 14 4 ≤ 10 := by rw [total_rob_four_four]; norm_num

/-- Robust four-resident batch band {2,3,4}: first = 2 and last = 4. -/
theorem band_rob_four :
    ((1:ℚ) ≤ (4*4)/(9 - 3*4/20) ∧ (4*4)/(9 - 3*4/20) < 2)
    ∧ ((4:ℚ) ≤ ((8 - allocFIFOQ 4 9)*rateQ 4 9 14 - debtQ 4 9 14 - 3*4 - 1)/4
       ∧ ((8 - allocFIFOQ 4 9)*rateQ 4 9 14 - debtQ 4 9 14 - 3*4 - 1)/4 < 5) := by
  have h1 : ((4*4)/(9 - 3*4/20) : ℚ) = 40/21 := by norm_num
  have h2 : (((8 - allocFIFOQ 4 9)*rateQ 4 9 14 - debtQ 4 9 14 - 3*4 - 1)/4 : ℚ) = 99431/24000 := by
    unfold allocFIFOQ rateQ debtQ deltaQ; norm_num
  rw [h1, h2]; norm_num

/-! ## Pool reservation bills (population fixture: 48,000 cells of three, 67,200 of four) -/

theorem pool_bills :
    48000*17 + 67200*22 = 2294400
    ∧ 48000*18 + 67200*23 = 2409600 := by omega

theorem corrected_bill_saving :
    (6604800 : ℚ)/2294400 = 688/239 ∧ 6604800/2409600 = 688/251 := by norm_num

/-! ## L2 allocation-undercharge countertraces (exact) -/

/-- Even an ideal zero-latency server: the actual FIFO delay of allocation behind three
vetoes exceeds the source charge `7/20 + 3/c`, which already includes the declared
1/4 latency. -/
theorem allocation_undercharge_three :
    ((2 - 1/100 + 3 + 1)/7 + 1/10 : ℚ) > 7/20 + 3/7 := by norm_num

theorem allocation_undercharge_four :
    ((2 - 1/100 + 4 + 1)/6 + 1/10 : ℚ) > 7/20 + 3/6 := by norm_num

/-! ## Axiom reports -/

