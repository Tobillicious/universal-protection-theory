import Mathlib

/-!
# Founding without coordination (compiled edition, Part XI.5)

Book I §9.16‴: a provision-point campaign with refunds and anchor-posted
failure bonuses. Others' actual pledged funds are `Y`; provision point `B`;
a funder's pledge `c > 0`. Contribute minus abstain is the failure bonus `β`
when the pool fails either way, the pivotal benefit minus the pledge when this
pledge creates provision, and the already-funded benefit minus the pledge when
others fund the pool alone (§9.16‴, table of three comparisons).

* `contribution_advantage_pos` — with `β > 0` and both benefits above the
  pledge, contributing is strictly better in every state of the others' pledges:
  contribution is strictly dominant (Proposition 9.16‴.1).
* `no_abstention_equilibrium` — in particular the profile in which every
  funder abstains is not an equilibrium: an abstaining funder facing others'
  abstention strictly gains by contributing. The no-founding equilibrium of
  the coordination game is removed.
-/

namespace Snuffy.FoundingDominance

/-- Contribute minus abstain, as a function of others' pledged funds `Y`. -/
noncomputable def advantage (B c β bpiv bfund Y : ℝ) : ℝ :=
  if Y + c < B then β else if Y < B then bpiv - c else bfund - c

theorem contribution_advantage_pos (B c β bpiv bfund Y : ℝ)
    (hβ : 0 < β) (hpiv : c < bpiv) (hfund : c < bfund) :
    0 < advantage B c β bpiv bfund Y := by
  unfold advantage
  split_ifs <;> linarith

/-- Strict dominance at every profile of the others' pledges. -/
theorem contribution_strictly_dominant (B c β bpiv bfund : ℝ)
    (hβ : 0 < β) (hpiv : c < bpiv) (hfund : c < bfund) :
    ∀ Y, 0 < advantage B c β bpiv bfund Y :=
  fun Y => contribution_advantage_pos B c β bpiv bfund Y hβ hpiv hfund

/-- All-abstain is not an equilibrium: with others pledging nothing, a funder
gains by contributing (bonus on failure, or pivotal benefit if its own pledge
reaches the provision point). -/
theorem no_abstention_equilibrium (B c β bpiv bfund : ℝ)
    (hβ : 0 < β) (hpiv : c < bpiv) (hfund : c < bfund) :
    0 < advantage B c β bpiv bfund 0 :=
  contribution_advantage_pos B c β bpiv bfund 0 hβ hpiv hfund

end Snuffy.FoundingDominance
