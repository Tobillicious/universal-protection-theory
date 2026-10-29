import Mathlib

/-!
  R7, timely preservation (Whole Edition 3.5, 23 Oct 2026). Lean 4 with Mathlib.

  Safety refuses unsafe effects; timeliness delivers the indispensable ones. Model: residents i ∈ R (a finite set),
  dates t. Each resident holds a reservation r i of care capacity per date, admitted only while Σ r ≤ the date's
  surviving capacity. Care is scheduled from reservations first; every other request, from any agent, hostile or
  not, in any number, is served only from what is left. A resident's status (running, held, crashed, failing over)
  is not read by the care rule (CARE15).
  * `care_served`: on every date whose surviving capacity covers the reservations, every resident's need up to its
    reservation is served in full, whatever the other requests are and whatever the resident's status.
  * `exhaustion_fails`: no set of other requests reduces any resident's served care.
  * `deadline_met`: a need due by a deadline D, with per-date need within the reservation, is met on every date up
    to D on which capacity covers the reservations; so a deadline can be missed only on a date of capacity shortage.
  * `miss_within_shortage`: the event "some resident misses some care deadline by date H" is contained in the event
    "some date up to H has a capacity shortage", whose probability U15-R bounds (γ + (1 − γ)q per window), summed
    over windows by U14.
-/

namespace UPTTimely

open Finset

variable {R : Type*}

/-- Care served to resident i: its need, capped by its reservation, when the reservations fit the capacity.
    `others` and `status` are inputs the rule never reads. -/
def served (res : Finset R) (r need : R → ℕ) (cap : ℕ) (_others : ℕ) (_status : R → Bool) (i : R) : ℕ :=
  if (∑ j ∈ res, r j) ≤ cap then min (need i) (r i) else 0

theorem care_served (res : Finset R) (r need : R → ℕ) (cap others : ℕ) (status : R → Bool)
    (hcap : (∑ j ∈ res, r j) ≤ cap) (i : R) (hneed : need i ≤ r i) :
    served res r need cap others status i = need i := by
  simp [served, hcap, min_eq_left hneed]

theorem exhaustion_fails (res : Finset R) (r need : R → ℕ) (cap : ℕ) (status status' : R → Bool)
    (o o' : ℕ) (i : R) : served res r need cap o status i = served res r need cap o' status' i := by
  simp [served]

/-- A per-date schedule: capacity, others' requests and statuses vary by date, adversarially. -/
theorem deadline_met (res : Finset R) (r : R → ℕ) (need : ℕ → R → ℕ) (cap others : ℕ → ℕ)
    (status : ℕ → R → Bool) (i : R) (D : ℕ) (hneed : ∀ t ≤ D, need t i ≤ r i)
    (hcap : ∀ t ≤ D, (∑ j ∈ res, r j) ≤ cap t) :
    ∀ t ≤ D, served res r (need t) (cap t) (others t) (status t) i = need t i := by
  intro t ht
  exact care_served res r (need t) (cap t) (others t) (status t) (hcap t ht) i (hneed t ht)

theorem miss_within_shortage (res : Finset R) (r : R → ℕ) (need : ℕ → R → ℕ) (cap others : ℕ → ℕ)
    (status : ℕ → R → Bool) (H : ℕ) (hneed : ∀ t ≤ H, ∀ i, need t i ≤ r i)
    (hmiss : ∃ t ≤ H, ∃ i, served res r (need t) (cap t) (others t) (status t) i ≠ need t i) :
    ∃ t ≤ H, cap t < ∑ j ∈ res, r j := by
  obtain ⟨t, ht, i, hi⟩ := hmiss
  refine ⟨t, ht, ?_⟩
  by_contra hc
  exact hi (care_served res r (need t) (cap t) (others t) (status t) (not_lt.mp hc) i (hneed t ht i))

end UPTTimely
