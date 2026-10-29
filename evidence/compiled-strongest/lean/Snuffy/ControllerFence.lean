import Snuffy.UPTFence
import Snuffy.ControllerFinality

/- Composition uses the existing UPTFence definitions and proof verbatim. This
module does not replace check-at-apply, isolation, or the target contract. -/
namespace UPTControllerFence
open UPTController

def TokenWitness (enrol : Nat → List Nat) (start : State) (final : List Op) (g : Nat) : Prop :=
  ∃ r : Receipt, r.isFloor = false ∧ r.context.generation = g ∧
    Prefix (history r) final ∧ replayOK enrol start r

/-- Prefix witnesses are supplied by certificate_is_final, not by a leader signature.
Every token, including a delayed old receipt, is checked against the finalised history.
Held suffixes contain no authorised release. The existing target theorem then applies
to every write attempt, not only to writes which the resident reports. -/
theorem certified_hold_nothing_lands (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (retired : (step enrol (run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (noRelease : ∀ d, Op.release d ∉ during)
    (target : UPTFence.St) (attempts : List UPTFence.Ev)
    (tokens : ∀ g, g ∈ target.minted →
      TokenWitness enrol start (before ++ .retire c :: during) g)
    (later : ∀ g, UPTFence.Ev.mint g ∈ attempts →
      TokenWitness enrol start (before ++ .retire c :: during) g) :
    (UPTFence.run (UPTFence.apply target (.raise (c.generation + 1))) attempts).log = target.log := by
  have bound : ∀ g, TokenWitness enrol start (before ++ .retire c :: during) g →
      g ≤ c.generation := by
    intro g hw
    obtain ⟨r, hf, hg, hp, hr⟩ := hw
    have emitted := grant_receipt_is_issued enrol start r _ hf hp hr
    rw [hg] at emitted
    exact hold_bounds_every_issued_grant enrol start before during c retired noRelease g emitted
  exact UPTFence.raise_then_nothing_lands target c.generation attempts
    (fun g hm => bound g (tokens g hm)) (fun g hm => bound g (later g hm))

/-- Two targets start their common held window after each has durably applied its
floor. A controller certificate alone is deliberately insufficient to start it. -/
theorem both_targets_held (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (retired : (step enrol (run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (noRelease : ∀ d, Op.release d ∉ during)
    (journal sink : UPTFence.St) (jEvents kEvents : List UPTFence.Ev)
    (jTokens : ∀ g, g ∈ journal.minted → TokenWitness enrol start (before ++ .retire c :: during) g)
    (kTokens : ∀ g, g ∈ sink.minted → TokenWitness enrol start (before ++ .retire c :: during) g)
    (jLater : ∀ g, UPTFence.Ev.mint g ∈ jEvents → TokenWitness enrol start (before ++ .retire c :: during) g)
    (kLater : ∀ g, UPTFence.Ev.mint g ∈ kEvents → TokenWitness enrol start (before ++ .retire c :: during) g) :
    (UPTFence.run (UPTFence.apply journal (.raise (c.generation + 1))) jEvents).log = journal.log ∧
    (UPTFence.run (UPTFence.apply sink (.raise (c.generation + 1))) kEvents).log = sink.log := by
  exact ⟨certified_hold_nothing_lands enrol start before during c retired noRelease journal jEvents jTokens jLater,
    certified_hold_nothing_lands enrol start before during c retired noRelease sink kEvents kTokens kLater⟩

end UPTControllerFence
