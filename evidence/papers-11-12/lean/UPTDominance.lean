/-
  Q1 repair: dominance in the FULL canonical order. Claude (Opus 5.5), 21 October 2026. Core Lean 4 only.
  For ANY relation `le` on outcomes (in particular the full life-first canonical order, lives then freedom),
  an action that is at least as good as another in EVERY state lands, in every state, in every event that is
  upward closed for `le` whenever the other does. Hence it dominates under every probability on states.
-/
namespace UPTDom

universe u v

def UpClosed {β : Type u} (le : β → β → Prop) (U : β → Prop) : Prop := ∀ x y, le x y → U x → U y

theorem statewise_dominance {β : Type u} {Ω : Type v} (le : β → β → Prop) (a b : Ω → β)
    (h : ∀ ω, le (a ω) (b ω)) (U : β → Prop) (hU : UpClosed le U) : ∀ ω, U (a ω) → U (b ω) :=
  fun ω hu => hU _ _ (h ω) hu

end UPTDom
