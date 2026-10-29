/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTQuorum.lean`, sha256 `b85d82ddf05dd48f36ca50315cf92a41eb348411b588bf44d23acc3f618a4a59`).
Namespace `UPTQuorum` renamed to `Snuffy.Book.UPTQuorum` for the canon's joint audit; statements and proofs unchanged. -/

/-
Plant hardening: the counting behind U5, U6 and U8 (Paper 11), for all parameters, not only the checked ones.
Islands are the positions of a list `L` of length n; a quorum is a set of islands of size at least q; a failed
set has at most f islands (unavailable, or worse: the theorem does not care which).
- Overlap: two quorums share at least 2q - n islands.
- Live overlap: if 2q > n + f, any two quorums share an island outside every failed set of at most f islands.
- Liveness: if at most f are down and q + f ≤ n, the islands still up form a quorum.
- Tightness: if 2q ≤ n + f (and q ≤ n), two quorums exist whose whole overlap fits in a failed set of size f.
  So 2q > n + f is exactly the condition; the plant's control "201 of 400 fails at k = 3" is an instance.
- Instances: U6 (202 of 400, f = 3), U8 lockstep majorities (7 with 3 down; 5 with 2 down), U5 threshold
  counting (4 of 7 survives 3 down and is out of reach of any 3; 3 of 5 likewise with 2).
Hiding by threshold sharing itself is Shamir's theorem and stays cited. Core Lean 4 only.
-/
namespace Snuffy.Book.UPTQuorum

/-- Number of positions of `L` satisfying `p`. -/
def cnt {ι : Type} (p : ι → Prop) [DecidablePred p] (L : List ι) : Nat :=
  (L.filter (fun i => decide (p i))).length

theorem cnt_le {ι : Type} (p : ι → Prop) [DecidablePred p] (L : List ι) : cnt p L ≤ L.length := by
  unfold cnt; exact List.length_filter_le _ _

/-- Inclusion and exclusion. -/
theorem cnt_or_and {ι : Type} (a b : ι → Prop) [DecidablePred a] [DecidablePred b] (L : List ι) :
    cnt (fun i => a i ∨ b i) L + cnt (fun i => a i ∧ b i) L = cnt a L + cnt b L := by
  induction L with
  | nil => simp [cnt]
  | cons i L ih =>
    by_cases ha : a i <;> by_cases hb : b i <;> simp [cnt, ha, hb] at ih ⊢ <;> omega

theorem cnt_split {ι : Type} (a f : ι → Prop) [DecidablePred a] [DecidablePred f] (L : List ι) :
    cnt a L = cnt (fun i => a i ∧ f i) L + cnt (fun i => a i ∧ ¬ f i) L := by
  induction L with
  | nil => simp [cnt]
  | cons i L ih =>
    by_cases ha : a i <;> by_cases hf : f i <;> simp [cnt, ha, hf] at ih ⊢ <;> omega

theorem cnt_mono {ι : Type} (a b : ι → Prop) [DecidablePred a] [DecidablePred b] (L : List ι)
    (h : ∀ i, a i → b i) : cnt a L ≤ cnt b L := by
  induction L with
  | nil => simp [cnt]
  | cons i L ih =>
    by_cases ha : a i <;> by_cases hb : b i <;> simp [cnt, ha, hb] at ih ⊢ <;> try omega
    exact absurd (h i ha) hb

theorem cnt_pos {ι : Type} (a : ι → Prop) [DecidablePred a] (L : List ι) (h : 0 < cnt a L) :
    ∃ i, i ∈ L ∧ a i := by
  induction L with
  | nil => simp [cnt] at h
  | cons j L ih =>
    by_cases ha : a j
    · exact ⟨j, List.mem_cons_self, ha⟩
    · simp only [cnt, List.filter_cons, ha, decide_false] at h
      obtain ⟨i, hi, hai⟩ := ih h
      exact ⟨i, List.mem_cons_of_mem j hi, hai⟩

/-- **Overlap.** Two quorums of size at least q among n islands share at least 2q - n of them. -/
theorem quorum_overlap {ι : Type} (A B : ι → Prop) [DecidablePred A] [DecidablePred B] (L : List ι) (q : Nat)
    (hA : q ≤ cnt A L) (hB : q ≤ cnt B L) : 2 * q ≤ L.length + cnt (fun i => A i ∧ B i) L := by
  have h1 := cnt_or_and A B L
  have h2 := cnt_le (fun i => A i ∨ B i) L
  omega

/-- **Live overlap.** If 2q > n + f, any two quorums share an island outside any failed set of at most f. -/
theorem quorums_share_a_live_island {ι : Type} (A B F : ι → Prop) [DecidablePred A] [DecidablePred B]
    [DecidablePred F] (L : List ι) (q f : Nat) (hq : L.length + f < 2 * q)
    (hA : q ≤ cnt A L) (hB : q ≤ cnt B L) (hF : cnt F L ≤ f) : ∃ i, i ∈ L ∧ A i ∧ B i ∧ ¬ F i := by
  have hov := quorum_overlap A B L q hA hB
  have hs := cnt_split (fun i => A i ∧ B i) F L
  have hm := cnt_mono (fun i => (A i ∧ B i) ∧ F i) F L (fun _ h => h.2)
  obtain ⟨i, hi, ⟨hab, hnf⟩⟩ := cnt_pos (fun i => (A i ∧ B i) ∧ ¬ F i) L (by omega)
  exact ⟨i, hi, hab.1, hab.2, hnf⟩

/-- **Liveness.** With at most f islands down and q + f ≤ n, the islands still up form a quorum. -/
theorem up_islands_form_a_quorum {ι : Type} (D : ι → Prop) [DecidablePred D] (L : List ι) (q f : Nat)
    (hD : cnt D L ≤ f) (hqf : q + f ≤ L.length) : q ≤ cnt (fun i => ¬ D i) L := by
  have hs := cnt_split (fun _ => True) D L
  have ht : cnt (fun _ : ι => True) L = L.length := by unfold cnt; simp
  have h1 : cnt (fun i => True ∧ D i) L = cnt D L := by unfold cnt; simp
  have h2 : cnt (fun i => True ∧ ¬ D i) L = cnt (fun i => ¬ D i) L := by unfold cnt; simp
  omega

/-! ### Tightness: the inequality 2q > n + f cannot be weakened -/

theorem cnt_lt_range (k n : Nat) : cnt (fun i => i < k) (List.range n) = min k n := by
  induction n with
  | zero => simp [cnt]
  | succ n ih =>
    simp only [cnt, List.range_succ, List.filter_append, List.length_append] at ih ⊢
    rw [ih]
    by_cases h : n < k <;> simp [h] <;> omega

theorem cnt_ge_range (k n : Nat) : cnt (fun i => k ≤ i) (List.range n) = n - k := by
  induction n with
  | zero => simp [cnt]
  | succ n ih =>
    simp only [cnt, List.range_succ, List.filter_append, List.length_append] at ih ⊢
    rw [ih]
    by_cases h : k ≤ n <;> simp [h] <;> omega

theorem cnt_band_range (a b n : Nat) : cnt (fun i => a ≤ i ∧ i < b) (List.range n) = min b n - a := by
  induction n with
  | zero => simp [cnt]
  | succ n ih =>
    simp only [cnt, List.range_succ, List.filter_append, List.length_append] at ih ⊢
    rw [ih]
    by_cases h1 : a ≤ n <;> by_cases h2 : n < b <;> simp [h1, h2] <;> omega

/-- **Tightness.** If 2q ≤ n + f and q ≤ n, the first q and the last q islands are two quorums whose whole
overlap is a set of at most f islands; if those fail, the two quorums share no live island. -/
theorem overlap_bound_is_tight (n q f : Nat) (hq : q ≤ n) (hle : 2 * q ≤ n + f) :
    q ≤ cnt (fun i => i < q) (List.range n) ∧ q ≤ cnt (fun i => n - q ≤ i) (List.range n) ∧
      cnt (fun i => n - q ≤ i ∧ i < q) (List.range n) ≤ f := by
  rw [cnt_lt_range, cnt_ge_range, cnt_band_range]
  omega

/-! ### The plant's parameters -/

/-- **U6.** Pool quorums of 202 out of 400 share a live island whenever at most 3 islands fail. -/
theorem U6_pool_quorums {ι : Type} (A B F : ι → Prop) [DecidablePred A] [DecidablePred B] [DecidablePred F]
    (L : List ι) (hn : L.length = 400) (hA : 202 ≤ cnt A L) (hB : 202 ≤ cnt B L) (hF : cnt F L ≤ 3) :
    ∃ i, i ∈ L ∧ A i ∧ B i ∧ ¬ F i :=
  quorums_share_a_live_island A B F L 202 3 (by omega) hA hB hF

/-- **U6 control.** Quorums of 201 out of 400 can overlap in only 2 islands, within a failed set of 3. -/
theorem U6_control_201 :
    201 ≤ cnt (fun i => i < 201) (List.range 400) ∧ 201 ≤ cnt (fun i => 400 - 201 ≤ i) (List.range 400) ∧
      cnt (fun i => 400 - 201 ≤ i ∧ i < 201) (List.range 400) ≤ 3 :=
  overlap_bound_is_tight 400 201 3 (by omega) (by omega)

/-- **U6 liveness.** With at most 3 of 400 islands down, the up islands form a 202-quorum. -/
theorem U6_live {ι : Type} (D : ι → Prop) [DecidablePred D] (L : List ι) (hn : L.length = 400)
    (hD : cnt D L ≤ 3) : 202 ≤ cnt (fun i => ¬ D i) L :=
  up_islands_form_a_quorum D L 202 3 hD (by omega)

/-- **U8.** Seven lockstep replicas with at most three down keep a majority of four (and five with two down
keep three); two majorities always share a live replica. -/
theorem U8_lockstep_majority {ι : Type} (D : ι → Prop) [DecidablePred D] (L : List ι) :
    (L.length = 7 → cnt D L ≤ 3 → 4 ≤ cnt (fun i => ¬ D i) L) ∧
    (L.length = 5 → cnt D L ≤ 2 → 3 ≤ cnt (fun i => ¬ D i) L) :=
  ⟨fun hn hD => up_islands_form_a_quorum D L 4 3 hD (by omega),
   fun hn hD => up_islands_form_a_quorum D L 3 2 hD (by omega)⟩

/-- **U5 counting.** Four-of-seven keys: with at most three islands unavailable, at least four shares remain;
any three islands hold fewer than four. Three-of-five likewise with two. (That fewer than the threshold reveal
nothing is Shamir's theorem, cited.) -/
theorem U5_threshold_counting {ι : Type} (D : ι → Prop) [DecidablePred D] (L : List ι) :
    (L.length = 7 → cnt D L ≤ 3 → 4 ≤ cnt (fun i => ¬ D i) L ∧ cnt D L < 4) ∧
    (L.length = 5 → cnt D L ≤ 2 → 3 ≤ cnt (fun i => ¬ D i) L ∧ cnt D L < 3) :=
  ⟨fun hn hD => ⟨up_islands_form_a_quorum D L 4 3 hD (by omega), by omega⟩,
   fun hn hD => ⟨up_islands_form_a_quorum D L 3 2 hD (by omega), by omega⟩⟩

end Snuffy.Book.UPTQuorum
