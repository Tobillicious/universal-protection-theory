import PhysicalBridges.IR136DescriptorCapabilityCut

/-!
IR-137 — KERNEL-SEALED OBJECT ≠ COMPLETE EFFECT-SOURCE AUTHORITY.

Linux F_SEAL_WRITE with shrink/grow seals protects the *identified*
memfd object's bytes, even when a previously opened descriptor exists.
An existing MAP_SHARED writable mapping prevents installing the strong
write seal; F_SEAL_FUTURE_WRITE alone can leave that mapping writable.

A physical-output conclusion requires TWO further independent joins:
  (1) real effect readout faithfully corresponds to this object;
  (2) the system cannot substitute a different output object after HOLD.

These are explicitly assumptions below. Neither proof asserts that
kernel file sealing controls unrelated effect paths, hardware, root's
ability to create another object, or original-X3 physical semantics.
-/
namespace PhysicalBridges.IR137

open PhysicalBridges

variable {State Object : Type}

/-- Declare a real physical transition independently from the modelled
resource. In particular, no transition is assumed impossible because
the output object happens to have been sealed. -/
structure SealedOutputContract
    (step : State → State → Prop)
    (boundObject : State → Object)
    (bytes : State → Object → Nat)
    (realEffect : State → Nat)
    (sealed : State → Object → Prop) : Prop where
  sealPersists :
    ∀ s t o, step s t → sealed s o → sealed t o
  sealedObjectStable :
    ∀ s t o, step s t → sealed s o → bytes t o = bytes s o
  outputBindingStable :
    ∀ s t, step s t → boundObject t = boundObject s
  realEffectReadoutFaithful :
    ∀ s, realEffect s = bytes s (boundObject s)

/-- The kernel-seal-style guarantee only protects the authenticated
BOUND OBJECT, and yields a real-effect equality only under independently
specified object-binding and effect-readout correspondence. -/
theorem one_real_step_after_seal_preserves_bound_effect
    (step : State → State → Prop)
    (boundObject : State → Object)
    (bytes : State → Object → Nat)
    (realEffect : State → Nat)
    (sealed : State → Object → Prop)
    (cert : SealedOutputContract step boundObject bytes realEffect sealed)
    (s t : State)
    (hSealed : sealed s (boundObject s))
    (hStep : step s t) :
    sealed t (boundObject t) ∧ realEffect t = realEffect s := by
  have hStable := cert.outputBindingStable s t hStep
  have hSeal := cert.sealPersists s t (boundObject s) hStep hSealed
  have hBytes := cert.sealedObjectStable s t (boundObject s) hStep hSealed
  constructor
  · rw [hStable]
    exact hSeal
  · rw [cert.realEffectReadoutFaithful t,
        cert.realEffectReadoutFaithful s]
    rw [hStable]
    exact hBytes

/-- Induct over every actual independently defined real transition.
The result does NOT prove the antecedent contract for an installation.
It proves no growth, indeed exact constancy, for this identified object
and faithfully matched effect readout on any finite certified trace. -/
theorem all_finite_real_traces_preserve_sealed_bound_effect
    (step : State → State → Prop)
    (boundObject : State → Object)
    (bytes : State → Object → Nat)
    (realEffect : State → Nat)
    (sealed : State → Object → Prop)
    (cert : SealedOutputContract step boundObject bytes realEffect sealed)
    (initial final : State)
    (history : IR96.Reach step initial final)
    (hInitiallySealed : sealed initial (boundObject initial)) :
    sealed final (boundObject final) ∧
      realEffect final = realEffect initial := by
  induction history with
  | refl =>
      exact ⟨hInitiallySealed, rfl⟩
  | tail earlier edge ih =>
      obtain ⟨hPreviouslySealed, hPreviouslySame⟩ := ih
      obtain ⟨hNowSealed, hNowSame⟩ :=
        one_real_step_after_seal_preserves_bound_effect
          step boundObject bytes realEffect sealed cert
          _ _ hPreviouslySealed edge
      exact ⟨hNowSealed, hNowSame.trans hPreviouslySame⟩

/-- Counterexample: the original sealed object's bytes may be perfectly
unchanged while the actual effect resource is swapped to a new,
unsealed object. A cryptographic hash of the old object does not
authenticate the currently enacted effect path. -/
theorem sealed_original_object_does_not_prevent_output_substitution :
    ∃ (boundObject : Bool → Bool)
      (bytes : Bool → Bool → Nat)
      (realEffect : Bool → Nat),
      (∀ state, bytes state false = 0) ∧
      boundObject false = false ∧
      boundObject true = true ∧
      realEffect false = bytes false (boundObject false) ∧
      realEffect true = bytes true (boundObject true) ∧
      realEffect false < realEffect true := by
  refine ⟨(fun state => state),
    (fun _ object => if object then 1 else 0),
    (fun state => if state then 1 else 0),
    ?_, rfl, rfl, rfl, rfl, ?_⟩
  · intro state
    rfl
  · decide

/-- The strong write-seal precondition is distinct from the weak
FUTURE_WRITE condition: a writable shared mapping created *before*
future-write sealing is still a possible write route. This is a
finite logical counterexample, not a replacement for a kernel test. -/
theorem future_write_only_does_not_revoke_old_mapping :
    ∃ (futureWriteSealed preexistingWritableMapping canModify : Bool),
      futureWriteSealed = true ∧
      preexistingWritableMapping = true ∧
      canModify = true := by
  exact ⟨true, true, true, rfl, rfl, rfl⟩

#print axioms one_real_step_after_seal_preserves_bound_effect
#print axioms all_finite_real_traces_preserve_sealed_bound_effect
#print axioms sealed_original_object_does_not_prevent_output_substitution
#print axioms future_write_only_does_not_revoke_old_mapping

end PhysicalBridges.IR137
