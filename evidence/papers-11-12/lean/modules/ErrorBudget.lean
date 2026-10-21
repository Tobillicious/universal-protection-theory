namespace CodexBudget
universe u v

def score (b : Bool) (n : Nat) : Nat := if b then n else 0

def mass {Ω : Type u} (p : Ω → Bool) : List (Ω × Nat) → Nat
  | [] => 0
  | (ω,n) :: ws => score (p ω) n + mass p ws

theorem score_mono (p q : Bool) (n : Nat) (h : p = true → q = true) : score p n ≤ score q n := by
  cases p with
  | false => exact Nat.zero_le _
  | true =>
    cases q with
    | false => have bad : false = true := h rfl; cases bad
    | true => exact Nat.le_refl _

theorem mass_mono {Ω : Type u} (p q : Ω → Bool) (h : ∀ ω, p ω = true → q ω = true) :
    ∀ ws, mass p ws ≤ mass q ws
  | [] => Nat.le_refl _
  | (ω,n) :: ws => Nat.add_le_add (score_mono _ _ n (h ω)) (mass_mono p q h ws)

theorem score_or_le (p q : Bool) (n : Nat) : score (p || q) n ≤ score p n + score q n := by
  cases p <;> cases q <;> simp only [score, Bool.false_or, Bool.true_or, Bool.false_eq_true, ite_false, ite_true]
  all_goals omega

theorem mass_or_le {Ω : Type u} (p q : Ω → Bool) :
    ∀ ws, mass (fun ω => p ω || q ω) ws ≤ mass p ws + mass q ws
  | [] => Nat.le_refl _
  | (ω,n) :: ws => by
    have hh := score_or_le (p ω) (q ω) n
    have ht := mass_or_le p q ws
    change score (p ω || q ω) n + mass (fun ω => p ω || q ω) ws ≤
      (score (p ω) n + mass p ws) + (score (q ω) n + mass q ws)
    omega

theorem mass_false {Ω : Type u} : ∀ (ws : List (Ω × Nat)), mass (fun _ => false) ws = 0
  | [] => rfl
  | (_,_) :: ws => by simpa only [mass, score, Bool.false_eq_true, ite_false, Nat.zero_add] using mass_false ws

def anyFailure {Ω : Type u} : List (Ω → Bool) → Ω → Bool
  | [], _ => false
  | p :: ps, ω => p ω || anyFailure ps ω

/-- Finite union bound with arbitrary natural atomic weights. -/
theorem union_bound {Ω : Type u} (ws : List (Ω × Nat)) :
    ∀ ps, mass (anyFailure ps) ws ≤ (ps.map (fun p => mass p ws)).sum
  | [] => by
    change mass (fun _ => false) ws ≤ 0
    rw [mass_false]
    exact Nat.le_refl _
  | p :: ps => by
    exact Nat.le_trans (mass_or_le p (anyFailure ps) ws) (Nat.add_le_add_left (union_bound ws ps) _)

/-- A common coupling failing only on bad outcomes bounds every output event's discrepancy. -/
theorem event_error_bound {Ω : Type u} {O : Type v}
    (actual ideal : Ω → O) (bad : Ω → Bool)
    (same : ∀ ω, bad ω = false → actual ω = ideal ω) (U : O → Bool) (ws : List (Ω × Nat)) :
    mass (fun ω => U (actual ω)) ws ≤ mass (fun ω => U (ideal ω)) ws + mass bad ws := by
  have h : ∀ ω, U (actual ω) = true → (U (ideal ω) || bad ω) = true := by
    intro ω ha
    cases hb : bad ω with
    | false =>
      rw [same ω hb] at ha
      simpa only [Bool.or_false] using ha
    | true => simp
  exact Nat.le_trans (mass_mono _ _ h ws) (mass_or_le _ _ ws)

theorem two_sided_event_error {Ω : Type u} {O : Type v}
    (actual ideal : Ω → O) (bad : Ω → Bool)
    (same : ∀ ω, bad ω = false → actual ω = ideal ω) (U : O → Bool) (ws : List (Ω × Nat)) :
    (mass (fun ω => U (actual ω)) ws ≤ mass (fun ω => U (ideal ω)) ws + mass bad ws) ∧
    (mass (fun ω => U (ideal ω)) ws ≤ mass (fun ω => U (actual ω)) ws + mass bad ws) :=
  ⟨event_error_bound actual ideal bad same U ws,
   event_error_bound ideal actual bad (fun ω h => (same ω h).symm) U ws⟩

/-- A caller-supplied total failure budget composes; this does not derive the component guarantees. -/
theorem composed_event_budget {Ω : Type u} {O : Type v}
    (actual ideal : Ω → O) (ps : List (Ω → Bool))
    (same : ∀ ω, anyFailure ps ω = false → actual ω = ideal ω)
    (U : O → Bool) (ws : List (Ω × Nat)) (B : Nat)
    (budget : (ps.map (fun p => mass p ws)).sum ≤ B) :
    mass (fun ω => U (actual ω)) ws ≤ mass (fun ω => U (ideal ω)) ws + B := by
  have h1 := event_error_bound actual ideal (anyFailure ps) same U ws
  have h2 := union_bound ws ps
  omega

#print axioms mass_mono
#print axioms union_bound
#print axioms event_error_bound
#print axioms two_sided_event_error
#print axioms composed_event_budget
end CodexBudget
