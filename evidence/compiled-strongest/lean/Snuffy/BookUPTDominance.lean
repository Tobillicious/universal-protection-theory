/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTDominance.lean`, sha256 `2a83f1ec53c64501583f719cf66d152ba1f2b7ba8a8c976709729d358047901e`).
Namespace `UPTDom` renamed to `Snuffy.Book.UPTDominance` for the canon's joint audit; statements and proofs unchanged. -/

/-
  Q1 repair: dominance in the FULL canonical order. Claude (Opus 5.5), 21 October 2026. Core Lean 4 only.
  For ANY relation `le` on outcomes (in particular the full life-first canonical order, lives then freedom),
  an action that is at least as good as another in EVERY state lands, in every state, in every event that is
  upward closed for `le` whenever the other does. Hence it dominates under every probability on states.
-/
namespace Snuffy.Book.UPTDominance

universe u v

def UpClosed {β : Type u} (le : β → β → Prop) (U : β → Prop) : Prop := ∀ x y, le x y → U x → U y

theorem statewise_dominance {β : Type u} {Ω : Type v} (le : β → β → Prop) (a b : Ω → β)
    (h : ∀ ω, le (a ω) (b ω)) (U : β → Prop) (hU : UpClosed le U) : ∀ ω, U (a ω) → U (b ω) :=
  fun ω hu => hU _ _ (h ω) hu

end Snuffy.Book.UPTDominance
