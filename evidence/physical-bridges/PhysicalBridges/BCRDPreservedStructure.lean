import PhysicalBridges.FrozenBCRDEvents
import PhysicalBridges.BCRDActualRelationalFrame

/-!
# PR A (addendum) — The preserved structure of the frozen event

This answers the *physical half* of Tenzing's forward question for PR B:

> What independently-established source property determines the continued
> identity and authentic authorization of a particular — with no invented flag?

This module establishes, from the frozen source alone, **exactly what the event
preserves and what it changes**, and the general rule a non-circular identity
carrier must obey. It does NOT interpret any of this as identity, consent,
authorization, subjects or histories — that justified physical-to-particular
interpretation is PR B's task (#285). Here we supply only the invariant substrate
such an interpretation must respect.

The event's transport is the M-sector `2↔3` swap: it moves only positions `2`
and `3` and fixes `{0,1,4,5}`. Its orbit structure (four fixed points, one
2-cycle) is the invariant content.

**The design rule (`covariant_of_respects_orbit`): any label that agrees on the
swapped pair is automatically covariant.** So an identity carrier keyed on
orbit-respecting structure (the `site` partition, where `site 2 = site 3`)
inherits non-circular covariance from the source; one keyed on the mutable frame
(the `register`, where `register 2 ≠ register 3`) does not — and provably can
change (PR A's `register_failure_witness`).
-/
namespace PhysicalBridges.BCRDPreservedStructure

open FrozenBCRDEvents
open BCRDActualRelationalFrame (Transport site register)

/-! ## 1. The event is local: it moves only the M-sector pair -/

/-- The transport fixes every position except the swapped pair `{2,3}`. -/
theorem transport_fixes_off_pair : ∀ x : Index, x ≠ 2 → x ≠ 3 → Transport x = x := by decide

/-- …and on the pair it is the swap. -/
theorem transport_swaps_pair : Transport 2 = 3 ∧ Transport 3 = 2 := by decide

/-! ## 2. The orbit structure is the preserved invariant -/

/-- The orbit equivalence of the event: identity together with the `2↔3` cycle. -/
@[reducible] def OrbitRel (x y : Index) : Prop :=
  x = y ∨ (x = 2 ∧ y = 3) ∨ (x = 3 ∧ y = 2)

/-- The orbit structure is covariant under the transport. -/
theorem orbit_covariant :
    ∀ x y : Index, OrbitRel x y ↔ OrbitRel (Transport x) (Transport y) := by decide

/-! ## 3. The design rule: orbit-respecting labels are automatically covariant

General over the label type — no reference to any particular structure. -/

/-- If a label `c` agrees on the swapped pair, then `c` is constant along the
transport: `c (Transport x) = c x` for every position. (The event moves only
`2` and `3`, which `c` cannot distinguish.) -/
theorem label_const_on_transport {α : Type} (c : Index → α) (h : c 2 = c 3) :
    ∀ x : Index, c (Transport x) = c x := by
  intro x
  rcases Classical.em (x = 2) with h2 | h2
  · subst h2; rw [transport_swaps_pair.1]; exact h.symm
  · rcases Classical.em (x = 3) with h3 | h3
    · subst h3; rw [transport_swaps_pair.2]; exact h
    · rw [transport_fixes_off_pair x h2 h3]

/-- **The design rule.** Any label that agrees on the swapped pair induces a
relation that is covariant under the transport — for free, with no appeal to the
specific structure. This is the non-circularity principle for an identity carrier:
respect the orbit, and covariance is inherited from the source. -/
theorem covariant_of_respects_orbit {α : Type} (c : Index → α) (h : c 2 = c 3) :
    ∀ x y : Index, (c x = c y ↔ c (Transport x) = c (Transport y)) := by
  intro x y
  rw [label_const_on_transport c h x, label_const_on_transport c h y]

/-! ## 4. Site persists, register changes — read through the rule -/

/-- The qutrit-site label agrees on the swapped pair: `site 2 = site 3` (both M). -/
theorem site_respects_orbit : site 2 = site 3 := by decide

/-- Hence the site partition is preserved — now *derived from the design rule*,
making explicit WHY it persists: it does not separate the swapped orbit. -/
theorem site_covariant_via_orbit :
    ∀ x y : Index, (site x = site y ↔ site (Transport x) = site (Transport y)) :=
  covariant_of_respects_orbit site site_respects_orbit

/-- The register label separates the swapped pair: `register 2 ≠ register 3`. This
is precisely why it is the structure that can fail covariance (PR A's
`register_failure_witness` exhibits the failure). -/
theorem register_separates_orbit : register 2 ≠ register 3 := by decide

/-! ## 5. The physical substrate, stated plainly

`persists_while_changing`: across the actual event, the orbit-respecting
structure (`site`) is invariant while the mutable frame (`register`) at the
acting positions flips. This is the physical reading of "something continues
through a real transition" — the substrate, NOT a claim of identity, a subject,
consent, or any OriginalX3 component. The interpretation is PR B's (#285). -/
theorem persists_while_changing :
    -- the acting positions share a site (persistence substrate)…
    (site 2 = site 3)
    -- …yet the event genuinely acts on them (register flips)…
    ∧ (register 2 ≠ register 3)
    -- …and the transport realises exactly that move.
    ∧ (Transport 2 = 3 ∧ Transport 3 = 2) := by
  refine ⟨site_respects_orbit, register_separates_orbit, transport_swaps_pair⟩

end PhysicalBridges.BCRDPreservedStructure
