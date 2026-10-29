/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTImpartiality.lean`, sha256 `35cb7f9f46cbb42a4614513ec6cc7a0f1b39862dc1a8f6fd242c10e58f9b47c3`).
Namespace `UPTImpartial` renamed to `Snuffy.Book.UPTImpartiality` for the canon's joint audit; statements and proofs unchanged. -/

/-
Impartiality in tragic choices: the author's PROVISIONAL ruling of 22 October 2026. In a tragic choice that widening
cannot remove, draw among the maximal outcomes so that each existing being's chance of being kept is as high and as
equal as it can be: first raise the least chance, then the next (leximin over individual chances).
A lottery is a list of nonnegative rational weights summing to one, one weight per maximal outcome; a being's chance
of being kept is the total weight of the outcomes that keep it.
A. Disjoint tragedies (each being kept by exactly one outcome), for every number m of outcomes: whatever the lottery,
   some being's chance is at most 1/m, and every being reaches 1/m only under the uniform draw. So there the ruling IS
   the uniform draw, uniquely: one being against a million gives every being one chance in two.
B. The uniform rule can fail when outcomes overlap; it is not impartial in general. With X = {A, B}, Y = {A, C},
   Z = {B, C} and W = {D}, it gives D one chance in four and A one in two. No lottery gives every being more than 2/5,
   and the lottery (1/5, 1/5, 1/5, 2/5) gives every being exactly 2/5.
C. That lottery is the only one giving every being at least 2/5: no lottery lowers no one's chance and raises someone's.
The principle of priority to the least-favoured is the new, provisional part; these theorems show what it selects.
Core Lean 4 only.
-/
namespace Snuffy.Book.UPTImpartiality

/-! ### A. Disjoint tragedies -/

theorem sum_ge (t : Rat) : ∀ (L : List Rat), (∀ w, w ∈ L → t ≤ w) → (L.length : Rat) * t ≤ L.sum
  | [], _ => by simp
  | w :: L, h => by
    have ih := sum_ge t L (fun v hv => h v (List.mem_cons_of_mem w hv))
    have hw := h w List.mem_cons_self
    simp only [List.length_cons, List.sum_cons]
    push_cast
    grind

theorem sum_gt (t : Rat) : ∀ (L : List Rat), (∀ w, w ∈ L → t ≤ w) → (∃ w, w ∈ L ∧ t < w) → (L.length : Rat) * t < L.sum
  | [], _, ⟨_, hw, _⟩ => absurd hw List.not_mem_nil
  | w :: L, h, ⟨v, hv, hlt⟩ => by
    have hrest := sum_ge t L (fun u hu => h u (List.mem_cons_of_mem w hu))
    have hw := h w List.mem_cons_self
    simp only [List.length_cons, List.sum_cons]
    push_cast
    rcases List.mem_cons.mp hv with rfl | hv
    · grind
    · have ih := sum_gt t L (fun u hu => h u (List.mem_cons_of_mem w hu)) ⟨v, hv, hlt⟩
      grind

theorem len_mul_inv (L : List Rat) (h : L ≠ []) : (L.length : Rat) * (1 / (L.length : Rat)) = 1 := by
  have hpos : (0 : Rat) < (L.length : Rat) := by
    have : 0 < L.length := List.length_pos_iff.mpr h
    exact_mod_cast this
  rw [Rat.div_def, Rat.one_mul]
  exact Rat.mul_inv_cancel _ (by grind)

/-- **Some weight is at most 1/m.** Over m nonempty weights summing to one, some weight is at most 1/m. Read as a
statement about beings it needs a disjoint, inhabited incidence model (UPTImpartialityAdequacy.some_being_at_most). -/
theorem some_chance_at_most (ws : List Rat) (hne : ws ≠ []) (hsum : ws.sum = 1) :
    ∃ w, w ∈ ws ∧ w ≤ 1 / (ws.length : Rat) := by
  apply Classical.byContradiction
  intro hno
  have hall : ∀ w, w ∈ ws → 1 / (ws.length : Rat) < w := fun w hw =>
    Rat.not_le.mp (fun hle => hno ⟨w, hw, hle⟩)
  obtain ⟨w0, hw0⟩ := List.exists_mem_of_ne_nil ws hne
  have := sum_gt (1 / (ws.length : Rat)) ws (fun w hw => Rat.le_of_lt (hall w hw)) ⟨w0, hw0, hall w0 hw0⟩
  rw [len_mul_inv ws hne, hsum] at this
  exact Rat.lt_irrefl this

/-- **A floor on every weight forces uniform weights.** If every weight is at least 1/m, every weight is 1/m. Read for
beings through UPTImpartialityAdequacy.being_floor_forces_uniform. -/
theorem everyone_at_least_only_if_uniform (ws : List Rat) (hne : ws ≠ []) (hsum : ws.sum = 1)
    (h : ∀ w, w ∈ ws → 1 / (ws.length : Rat) ≤ w) : ∀ w, w ∈ ws → w = 1 / (ws.length : Rat) := by
  intro w hw
  apply Classical.byContradiction
  intro hne'
  have hlt : 1 / (ws.length : Rat) < w := Rat.lt_of_le_of_ne (h w hw) (fun e => hne' e.symm)
  have := sum_gt (1 / (ws.length : Rat)) ws h ⟨w, hw, hlt⟩
  rw [len_mul_inv ws hne, hsum] at this
  exact Rat.lt_irrefl this

/-! ### B and C. An overlapping tragedy -/

/-- Chances of A, B, C and D under weights x, y, z, w on X = {A, B}, Y = {A, C}, Z = {B, C}, W = {D}. -/
def chA (x y _z _w : Rat) : Rat := x + y
def chB (x _y z _w : Rat) : Rat := x + z
def chC (_x y z _w : Rat) : Rat := y + z
def chD (_x _y _z w : Rat) : Rat := w

/-- **The uniform draw over outcomes is not fair to beings:** D gets 1/4 while A gets 1/2. -/
theorem uniform_disadvantages_D :
    chD (1/4) (1/4) (1/4) (1/4) = 1/4 ∧ chA (1/4) (1/4) (1/4) (1/4) = 1/2 := by
  unfold chD chA; constructor <;> grind

/-- **No lottery gives every being more than 2/5.** -/
theorem least_chance_at_most_two_fifths (x y z w t : Rat) (hsum : x + y + z + w = 1)
    (hA : t ≤ chA x y z w) (hB : t ≤ chB x y z w) (hC : t ≤ chC x y z w) (hD : t ≤ chD x y z w) : t ≤ 2/5 := by
  unfold chA chB chC chD at *; grind

/-- **The ruling's lottery gives every being 2/5.** -/
theorem ruling_gives_everyone_two_fifths :
    chA (1/5) (1/5) (1/5) (2/5) = 2/5 ∧ chB (1/5) (1/5) (1/5) (2/5) = 2/5 ∧
    chC (1/5) (1/5) (1/5) (2/5) = 2/5 ∧ chD (1/5) (1/5) (1/5) (2/5) = 2/5 := by
  unfold chA chB chC chD; refine ⟨?_, ?_, ?_, ?_⟩ <;> grind

/-- **It is the only lottery giving every being at least 2/5.** So no lottery raises anyone's chance without lowering
someone else's: the ruling's lottery is Pareto-optimal for individual chances, and unique. -/
theorem ruling_is_unique (x y z w : Rat) (hsum : x + y + z + w = 1)
    (hA : 2/5 ≤ chA x y z w) (hB : 2/5 ≤ chB x y z w) (hC : 2/5 ≤ chC x y z w) (hD : 2/5 ≤ chD x y z w) :
    x = 1/5 ∧ y = 1/5 ∧ z = 1/5 ∧ w = 2/5 := by
  unfold chA chB chC chD at *; refine ⟨?_, ?_, ?_, ?_⟩ <;> grind

theorem len_inv_pos {γ : Type} (L : List γ) (h : L ≠ []) : (0 : Rat) < 1 / (L.length : Rat) := by
  have hpos : (0 : Rat) < (L.length : Rat) := by
    have : 0 < L.length := List.length_pos_iff.mpr h
    exact_mod_cast this
  rw [Rat.div_def, Rat.one_mul]; exact Rat.inv_pos.mpr hpos

/-! ### The diagnosis: the uniform draw gives being i the chance d_i / m -/

/-- Total weight `c` over the outcomes of `M` that keep `i` is `c` times the number of such outcomes. -/
theorem weight_of_keepers {β : Type} (i : β) (c : Rat) :
    ∀ (M : List (β → Bool)), (M.map (fun k => if k i = true then c else 0)).sum = ((M.filter (fun k => k i)).length : Rat) * c
  | [] => by simp
  | k :: M => by
    have ih := weight_of_keepers i c M
    by_cases h : k i = true
    · have hf : (k :: M).filter (fun k => k i) = k :: M.filter (fun k => k i) := by simp [h]
      rw [hf, List.map_cons, List.sum_cons, ih, List.length_cons]
      simp only [h, ite_true]
      push_cast; grind
    · have hf : (k :: M).filter (fun k => k i) = M.filter (fun k => k i) := by simp [h]
      rw [hf, List.map_cons, List.sum_cons, ih]
      simp only [h]; grind

/-- **Under the uniform draw over m maximal outcomes, being i survives with chance d_i / m**, where d_i is the number
of those outcomes that keep i. -/
theorem uniform_chance {β : Type} (i : β) (M : List (β → Bool)) :
    (M.map (fun k => if k i = true then 1 / (M.length : Rat) else 0)).sum =
      ((M.filter (fun k => k i)).length : Rat) * (1 / (M.length : Rat)) :=
  weight_of_keepers i _ M

/-- **So the uniform draw gives two beings equal chances exactly when they appear in equally many outcomes.** -/
theorem uniform_equal_iff_equal_counts {β : Type} (i j : β) (M : List (β → Bool)) (hne : M ≠ []) :
    (M.map (fun k => if k i = true then 1 / (M.length : Rat) else 0)).sum =
      (M.map (fun k => if k j = true then 1 / (M.length : Rat) else 0)).sum ↔
    (M.filter (fun k => k i)).length = (M.filter (fun k => k j)).length := by
  rw [uniform_chance, uniform_chance]
  have hpos : (0 : Rat) < 1 / (M.length : Rat) := by
    have h1 := len_inv_pos M hne
    grind
  constructor
  · intro h
    have : ((M.filter (fun k => k i)).length : Rat) = ((M.filter (fun k => k j)).length : Rat) := by
      have hc := Rat.mul_inv_cancel (1 / (M.length : Rat)) (by grind)
      calc ((M.filter (fun k => k i)).length : Rat)
          = ((M.filter (fun k => k i)).length : Rat) * (1 / (M.length : Rat)) * (1 / (M.length : Rat))⁻¹ := by
            rw [Rat.mul_assoc, hc, Rat.mul_one]
        _ = ((M.filter (fun k => k j)).length : Rat) * (1 / (M.length : Rat)) * (1 / (M.length : Rat))⁻¹ := by rw [h]
        _ = ((M.filter (fun k => k j)).length : Rat) := by rw [Rat.mul_assoc, hc, Rat.mul_one]
    exact_mod_cast this
  · intro h; rw [h]

end Snuffy.Book.UPTImpartiality
