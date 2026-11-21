import PhysicalBridges.IR135PrincipalAuthorityBoundary

/-!
IR-136 — WRITABLE FILE DESCRIPTOR IS AN EFFECT AUTHORITY.

A denied path open does not exclude a previously opened or delegated
writable descriptor. Treat the effect-authorizing capability as part
of an externally verified action boundary, not as a synonym for UID.

Formalizes the three channels: direct path opening, already-open
writable descriptor, and permitted trusted broker application.

The installed experiment is strictly one disposable Linux file and
one dropped unprivileged process. This module DOES NOT assert these
channels exhaust the possible physical sources, devices or effects.
-/

namespace PhysicalBridges.IR136

variable {Principal State : Type}

/-- Actual file-effect channels must be separately inventoried. -/
structure WriteCapabilities (Principal State : Type) where
  pathOpen : Principal → State → Prop
  writableFD : Principal → State → Prop
  brokerPermit : Principal → State → Prop

def CanApply (c : WriteCapabilities Principal State)
    (p : Principal) (s : State) : Prop :=
  c.pathOpen p s ∨ c.writableFD p s ∨ c.brokerPermit p s

/-- A complete three-channel cut needs all THREE channels disabled
for the given applying actor and state. -/
theorem denied_iff_all_channels_denied
    (c : WriteCapabilities Principal State)
    (p : Principal) (s : State) :
    ¬ CanApply c p s ↔
      ¬ c.pathOpen p s ∧
      ¬ c.writableFD p s ∧
      ¬ c.brokerPermit p s := by
  simp [CanApply, not_or]

/-- An independent real-effect relation refines the declared channel
inventory only under this explicit source-to-OS completeness premise.
If every channel is independently denied, there is no such effect. -/
theorem actual_effect_denied_under_complete_channel_cut
    (c : WriteCapabilities Principal State)
    (physicalWrite : Principal → State → State → Prop)
    (hCoverage : ∀ p s t, physicalWrite p s t → CanApply c p s)
    (p : Principal) (s t : State)
    (hNoPath : ¬ c.pathOpen p s)
    (hNoFD : ¬ c.writableFD p s)
    (hNoBroker : ¬ c.brokerPermit p s) :
    ¬ physicalWrite p s t := by
  intro hWrite
  rcases hCoverage p s t hWrite with h | h | h
  · exact hNoPath h
  · exact hNoFD h
  · exact hNoBroker h

/-- Explicit counterexample: at the post-HOLD state the unprivileged
principal cannot open the resource path and has no broker permission,
but still holds a valid write capability handed down earlier.

No theorem may derive no-write from path DAC denial alone. -/
theorem post_hold_path_denial_allows_delegated_fd :
    ∃ (c : WriteCapabilities Bool Bool),
      ¬ c.pathOpen false true ∧
      ¬ c.brokerPermit false true ∧
      c.writableFD false true ∧
      CanApply c false true := by
  let c : WriteCapabilities Bool Bool :=
    { pathOpen := fun _ _ => False,
      writableFD := fun principal state =>
        principal = false ∧ state = true,
      brokerPermit := fun _ _ => False }
  refine ⟨c, ?_, ?_, ?_, ?_⟩
  · intro h
    exact h
  · intro h
    exact h
  · exact ⟨rfl, rfl⟩
  · exact Or.inr (Or.inl ⟨rfl, rfl⟩)

/-- A broker that closes admission cannot revoke an already delegated
write capability merely by changing a *path* permission predicate.
This conclusion concerns the model's capability set only; actual
kernel behavior is separately challenged in Linux CI. -/
theorem revoked_path_does_not_revoke_existing_fd
    (c : WriteCapabilities Principal State)
    (p : Principal) (before after : State)
    (hHeld : c.writableFD p before)
    (hPersists : c.writableFD p before → c.writableFD p after)
    (_hPathRevoked : ¬ c.pathOpen p after) :
    CanApply c p after :=
  Or.inr (Or.inl (hPersists hHeld))

#print axioms denied_iff_all_channels_denied
#print axioms actual_effect_denied_under_complete_channel_cut
#print axioms post_hold_path_denial_allows_delegated_fd
#print axioms revoked_path_does_not_revoke_existing_fd

end PhysicalBridges.IR136
