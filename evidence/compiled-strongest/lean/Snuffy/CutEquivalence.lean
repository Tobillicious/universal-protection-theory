/-
Snuffy — Canon Edition 4.2 working: the two forms of the causal boundary
agree (§24.3).

A closed dependency component (`CodexCohold.Closed`) and a directed separator
in the unrolled dependency graph (`UPTR16Cut.Bypass`) are the same object when
the separator's certified boundary is empty: a set is closed under the
dependency relation exactly when no path from a node outside it reaches it.
The separator form also admits a matched certified boundary
(`UPTR16Cut.causal_separator`), so it extends the closed-component form.

  * closed_iff_no_bypass — `Closed D C ↔ ∀ n ∈ C, ¬ Bypass D (∉ C) ∅ n`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.R16Cut

namespace Snuffy.CutEquivalence

open CodexCohold UPTR16Cut

theorem closed_iff_no_bypass (D : Nat → Nat → Prop) (C : Nat → Prop) :
    Closed D C ↔ ∀ n, C n → ¬ Bypass D (fun m => ¬ C m) (fun _ => False) n := by
  constructor
  · intro hclosed
    have hout : ∀ n, Bypass D (fun m => ¬ C m) (fun _ => False) n → ¬ C n := by
      intro n hn
      induction hn with
      | initial x hs => exact hs.1
      | edge x y _ hxy ih =>
          intro hy
          exact ih (hclosed y hy x hxy.1)
    exact fun n hn hb => hout n hb hn
  · intro h x hx y hxy
    exact Classical.byContradiction fun hy =>
      h x hx (Reach.edge y x (Reach.initial y ⟨hy, id⟩) ⟨hxy, id⟩)

end Snuffy.CutEquivalence
