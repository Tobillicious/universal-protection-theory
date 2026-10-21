import CanonicalDominance

namespace CodexSplice
open UPT CodexCanonical
universe u v w

def splice {Ω : Type u} {O : Type v} (cut : Ω → Bool) (a hold : Ω → O) : Ω → O :=
  fun ω => if cut ω then hold ω else a ω

/-- Replace only branches with a strict life-set improvement. Branch selection is supplied; its
    observability and the resulting policy's feasibility do not follow from a nonlethal hold. -/
theorem repair_statewise {Ω : Type u} {O : Type v} {α : Type w}
    (life : O → α → Prop) (tail : List (O → α → Prop))
    (cut : Ω → Bool) (a hold : Ω → O)
    (gain : ∀ ω, cut ω = true → SSub (life (a ω)) (life (hold ω))) :
    ∀ ω, LexLE (life :: tail) (a ω) (splice cut a hold ω) := by
  intro ω
  cases hc : cut ω with
  | false => simpa [splice,hc] using le_refl (life :: tail) (a ω)
  | true => exact Or.inl (by simpa [splice,hc] using gain ω hc)

theorem life_gain_excludes_reverse {O : Type v} {α : Type w}
    (life : O → α → Prop) (tail : List (O → α → Prop)) (a b : O)
    (gain : SSub (life a) (life b)) : ¬ LexLE (life :: tail) b a := by
  intro reverse
  cases reverse with
  | inl h => exact gain.2 h.1
  | inr h => exact gain.2 h.1.1

theorem repaired_upward_events {Ω : Type u} {O : Type v} {α : Type w}
    (life : O → α → Prop) (tail : List (O → α → Prop))
    (cut : Ω → Bool) (a hold : Ω → O)
    (gain : ∀ ω, cut ω = true → SSub (life (a ω)) (life (hold ω))) :
    ∀ U, Upward (life :: tail) U → ∀ ω, U (a ω) → U (splice cut a hold ω) :=
  (all_events_iff_statewise (life :: tail) a (splice cut a hold)).mpr
    (repair_statewise life tail cut a hold gain)

/-- A changed branch has a principal upward event which separates its original and repaired outcomes. -/
theorem strict_event_witness {Ω : Type u} {O : Type v} {α : Type w}
    (life : O → α → Prop) (tail : List (O → α → Prop))
    (cut : Ω → Bool) (a hold : Ω → O) (ω : Ω) (hc : cut ω = true)
    (gain : SSub (life (a ω)) (life (hold ω))) :
    ∃ U, Upward (life :: tail) U ∧ ¬ U (a ω) ∧ U (splice cut a hold ω) := by
  refine ⟨fun z => LexLE (life :: tail) (splice cut a hold ω) z, ?_, ?_, le_refl _ _⟩
  · exact fun x y hxy hx => le_trans _ _ x y hx hxy
  · simpa [splice,hc] using life_gain_excludes_reverse life tail (a ω) (hold ω) gain

/-- Positive weight on a separating branch makes a monotone event's finite mass strictly increase. -/
theorem mass_lt_of_hit {Ω O : Type} (a b : Ω → O) (U : O → Bool)
    (mono : ∀ ω, U (a ω) = true → U (b ω) = true) :
    ∀ ws, (∃ ω n, (ω,n) ∈ ws ∧ 0<n ∧ U (a ω)=false ∧ U (b ω)=true) →
      mass a U ws < mass b U ws
  | [], hit => by obtain ⟨ω,n,hm,_,_,_⟩ := hit; cases hm
  | (ω,n) :: ws, hit => by
    obtain ⟨ω0,n0,hm,positive,ha,hb⟩ := hit
    cases List.mem_cons.mp hm with
    | inl he =>
      cases he
      have rest := mass_mono a b U mono ws
      simp only [mass,ha,hb,Bool.false_eq_true,ite_false,ite_true,Nat.zero_add]
      omega
    | inr hm =>
      have rest := mass_lt_of_hit a b U mono ws ⟨ω0,n0,hm,positive,ha,hb⟩
      have head : (if U (a ω) then n else 0) ≤ (if U (b ω) then n else 0) := by
        cases h : U (a ω) with
        | false => simp
        | true => simp [mono ω h]
      change (if U (a ω) then n else 0) + mass a U ws < (if U (b ω) then n else 0) + mass b U ws
      omega

#print axioms repair_statewise
#print axioms life_gain_excludes_reverse
#print axioms repaired_upward_events
#print axioms strict_event_witness
#print axioms mass_lt_of_hit
end CodexSplice
