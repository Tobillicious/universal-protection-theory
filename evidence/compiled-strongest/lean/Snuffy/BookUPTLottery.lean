/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTLottery.lean`, sha256 `be2b5e7b440559911310b6e2569b1eb9e77e78c7f58628fa5cae4aecd58db295`).
Namespace `UPTLottery` renamed to `Snuffy.Book.UPTLottery` for the canon's joint audit; statements and proofs unchanged. -/

/-
Item 4 (full security protocols): the reduction for the escrowed lottery (Paper 12, "Agents together";
proof note VSS-SCOPE.md). Contributions are combined by addition modulo m.
- Fairness: if the other contributions' combined value c is fixed before the honest value is revealed, every
  outcome comes from exactly one honest value, so a uniform honest value gives a uniform outcome.
- Binding is necessary: a party that may choose after seeing the honest value can force any outcome.
- Consistent opening is necessary: different openings give different outcomes.
- Robust decoding from distance: if distinct codewords agree in at most t of n positions and n ≥ 3t + 1,
  no received word lies within t corruptions of two different codewords.
The cryptographic resources (hiding/binding commitment, authenticated consistent broadcast, private delivery,
fresh entropy) stay named premises; this file proves what follows from them, and that each is needed.
-/
namespace Snuffy.Book.UPTLottery

/-- Every outcome `r < m` arises from some honest value `x < m`, whatever the fixed combined value `c`. -/
theorem outcome_reachable (m c r : Nat) (hm : 0 < m) (hr : r < m) : ∃ x, x < m ∧ (x + c) % m = r := by
  refine ⟨(r + (m - c % m)) % m, Nat.mod_lt _ hm, ?_⟩
  have hc : c % m < m := Nat.mod_lt _ hm
  have hdiv : c % m + m * (c / m) = c := Nat.mod_add_div c m
  rw [Nat.mod_add_mod]
  have : r + (m - c % m) + c = r + m * (c / m + 1) := by
    have : m - c % m + c % m = m := Nat.sub_add_cancel (Nat.le_of_lt hc)
    rw [Nat.mul_add, Nat.mul_one]; omega
  rw [this, Nat.add_mul_mod_self_left, Nat.mod_eq_of_lt hr]

/-- ... and from only one: for a fixed combined value, distinct honest values give distinct outcomes. -/
theorem outcome_unique (m c x y : Nat) (hx : x < m) (hy : y < m) (h : (x + c) % m = (y + c) % m) : x = y := by
  have hm : 0 < m := Nat.lt_of_le_of_lt (Nat.zero_le x) hx
  have hc : c % m < m := Nat.mod_lt _ hm
  have ex : (x + c) % m = (x + c % m) % m := by rw [Nat.add_mod, Nat.mod_eq_of_lt hx]
  have ey : (y + c) % m = (y + c % m) % m := by rw [Nat.add_mod, Nat.mod_eq_of_lt hy]
  rw [ex, ey] at h
  have reduce : ∀ z, z < m → (z + c % m) % m = if z + c % m < m then z + c % m else z + c % m - m := by
    intro z hz
    by_cases hlt : z + c % m < m
    · simp [hlt, Nat.mod_eq_of_lt hlt]
    · rw [Nat.mod_eq_sub_mod (Nat.le_of_not_lt hlt), Nat.mod_eq_of_lt (by omega)]; simp [hlt]
  rw [reduce x hx, reduce y hy] at h
  split at h <;> split at h <;> omega

/-- **Fairness.** With the others' combined value fixed before reveal, each outcome comes from exactly one
honest value: a uniform honest value on `0, …, m - 1` therefore gives a uniform outcome. -/
theorem fair_when_bound_before_reveal (m c r : Nat) (hm : 0 < m) (hr : r < m) :
    ∃ x, x < m ∧ (x + c) % m = r ∧ ∀ y, y < m → (y + c) % m = r → y = x := by
  obtain ⟨x, hx, hxr⟩ := outcome_reachable m c r hm hr
  exact ⟨x, hx, hxr, fun y hy hyr => outcome_unique m c y x hy hx (hyr.trans hxr.symm)⟩

/-- **Binding is necessary.** If a party may choose its contribution after seeing the honest value, it can
force any outcome `r < m`, whatever the honest value is. -/
theorem choosing_after_reveal_forces_any_outcome (m r : Nat) (hr : r < m) :
    ∃ cheat : Nat → Nat, ∀ x, x < m → (x + cheat x) % m = r := by
  refine ⟨fun x => r + (m - x), fun x hx => ?_⟩
  have : x + (r + (m - x)) = r + m := by omega
  rw [this, Nat.add_mod_right, Nat.mod_eq_of_lt hr]

/-- **Consistent opening is necessary.** Two honest parties who receive different openings of the others'
combined value (both below `m`) compute different outcomes from the same honest value. -/
theorem inconsistent_openings_disagree (m x c₁ c₂ : Nat) (h₁ : c₁ < m) (h₂ : c₂ < m) (hne : c₁ ≠ c₂) :
    (x + c₁) % m ≠ (x + c₂) % m := by
  intro h
  apply hne
  have h' : (c₁ + x) % m = (c₂ + x) % m := by rw [Nat.add_comm c₁, Nat.add_comm c₂]; exact h
  exact outcome_unique m x c₁ c₂ h₁ h₂ h'

/-! ### Robust decoding from minimum distance -/

/-- Number of positions in `L` satisfying `p`. -/
def cnt {ι : Type} (p : ι → Prop) [DecidablePred p] (L : List ι) : Nat := (L.filter (fun i => decide (p i))).length

theorem cnt_or_le {ι : Type} (a b c : ι → Prop) [DecidablePred a] [DecidablePred b] [DecidablePred c]
    (L : List ι) (h : ∀ i, a i → b i ∨ c i) : cnt a L ≤ cnt b L + cnt c L := by
  induction L with
  | nil => simp [cnt]
  | cons i L ih =>
    simp only [cnt, List.filter_cons] at ih ⊢
    by_cases ha : a i <;> by_cases hb : b i <;> by_cases hc : c i <;> simp [ha, hb, hc] <;> try omega
    exact absurd (h i ha) (by simp [hb, hc])

theorem cnt_compl {ι : Type} (p : ι → Prop) [DecidablePred p] (L : List ι) :
    cnt p L + cnt (fun i => ¬ p i) L = L.length := by
  induction L with
  | nil => simp [cnt]
  | cons i L ih =>
    simp only [cnt, List.filter_cons, List.length_cons, decide_not] at ih ⊢
    by_cases hp : p i <;> simp [hp] <;> omega

/-- **Unique decoding.** Over positions `L` (n of them), let codewords `u, v` agree in at most `t` positions,
and let a received word `w` differ from each in at most `t` positions. Then n ≤ 3t. Hence when n ≥ 3t + 1,
no received word is within `t` corruptions of two distinct codewords. -/
theorem decoding_radius {ι α : Type} [DecidableEq α] (L : List ι) (u v w : ι → α) (t : Nat)
    (hagree : cnt (fun i => u i = v i) L ≤ t)
    (hu : cnt (fun i => w i ≠ u i) L ≤ t) (hv : cnt (fun i => w i ≠ v i) L ≤ t) : L.length ≤ 3 * t := by
  have hcover : cnt (fun i => ¬ (u i = v i)) L ≤ cnt (fun i => w i ≠ u i) L + cnt (fun i => w i ≠ v i) L := by
    apply cnt_or_le
    intro i hne
    by_cases h1 : w i = u i
    · right; intro h2; exact hne (h1.symm.trans h2)
    · left; exact h1
  have htot := cnt_compl (fun i => u i = v i) L
  simp only [cnt] at htot hcover hagree hu hv ⊢
  omega

theorem unique_decoding {ι α : Type} [DecidableEq α] (L : List ι) (u v w : ι → α) (t : Nat)
    (hn : 3 * t + 1 ≤ L.length) (hagree : cnt (fun i => u i = v i) L ≤ t) (hu : cnt (fun i => w i ≠ u i) L ≤ t) :
    ¬ cnt (fun i => w i ≠ v i) L ≤ t := by
  intro hv
  have := decoding_radius L u v w t hagree hu hv
  omega

end Snuffy.Book.UPTLottery
