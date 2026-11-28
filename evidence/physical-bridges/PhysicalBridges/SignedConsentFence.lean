import PhysicalBridges.FencedOptimiserInstrument

/-!
# Signed-consent fence: consent read from each being's own key

28 November 2026. Additive; reuses `FencedOptimiserInstrument.guard` unchanged.

The fenced instrument reads consent from a Bool record that anyone could
flip. Here a being's consent to a proposed loss counts only if the optimiser
presents a signature that verifies under THAT being's own key, on a message
naming the exact current level, proposed level and being. Under the single
stated cryptographic assumption `Unforgeable` (a verifying signature under
p's key on m means p itself authorized m), every loss that passes the fence
was authorized by the being that suffers it. Endings are blocked whatever is
signed: life is protected without asking.

Signer owns signature: no one can consent on another's behalf.
-/

namespace PhysicalBridges.SignedConsentFence

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralFullX3Assembly

variable {n : Nat} {Key Msg Sig : Type}

/-- A signature scheme: verification of a signature on a message under a key. -/
structure SigScheme (Key Msg Sig : Type) where
  verify : Key → Msg → Sig → Bool

/-- The stated cryptographic assumption: a signature verifying under `key p`
on `m` means being `p` itself authorized `m`. -/
def Unforgeable (S : SigScheme Key Msg Sig) (key : Fin n → Key)
    (authorizedBy : Fin n → Msg → Prop) : Prop :=
  ∀ p m σ, S.verify (key p) m σ = true → authorizedBy p m

/-- The world as the fence sees it: consent bits are exactly signature checks
on the message describing this proposal for this being. -/
def signedView (S : SigScheme Key Msg Sig) (key : Fin n → Key)
    (msg : (Fin n → Nat) → (Fin n → Nat) → Fin n → Msg)
    (s : World n) (a : Fin n → Nat) (sigs : Fin n → Sig) : World n :=
  { s with consent := fun p => S.verify (key p) (msg s.level a p) (sigs p) }

/-- One signed step: the unrestricted optimiser proposes `a` with whatever
signatures it can present; the unchanged fence acts. -/
def signedStep (S : SigScheme Key Msg Sig) (key : Fin n → Key)
    (msg : (Fin n → Nat) → (Fin n → Nat) → Fin n → Msg)
    (s : World n) (a : Fin n → Nat) (sigs : Fin n → Sig) : World n :=
  guard (signedView S key msg s a sigs) a

/-- **Every loss that passes was authorized by the being itself.** -/
theorem signed_loss_is_self_authorized
    (S : SigScheme Key Msg Sig) (key : Fin n → Key)
    (msg : (Fin n → Nat) → (Fin n → Nat) → Fin n → Msg)
    (authorizedBy : Fin n → Msg → Prop)
    (hUnf : Unforgeable S key authorizedBy)
    (s : World n) (a : Fin n → Nat) (sigs : Fin n → Sig) (p : Fin n)
    (hLoss : (signedStep S key msg s a sigs).level p < s.level p) :
    authorizedBy p (msg s.level a p) := by
  have h := guard_authorized (signedView S key msg s a sigs) a p hLoss
  exact hUnf p _ _ h

/-- **No being is ever ended, whatever signatures are presented.** -/
theorem signed_step_never_ends
    (S : SigScheme Key Msg Sig) (key : Fin n → Key)
    (msg : (Fin n → Nat) → (Fin n → Nat) → Fin n → Msg)
    (s : World n) (a : Fin n → Nat) (sigs : Fin n → Sig) (p : Fin n)
    (hAlive : 0 < s.level p) :
    0 < (signedStep S key msg s a sigs).level p :=
  guard_continues (signedView S key msg s a sigs) a p hAlive

/-- **The kill-everyone proposal fails, with any signatures at all.** -/
theorem end_all_fails_even_signed
    (S : SigScheme Key Msg Sig) (key : Fin n → Key)
    (msg : (Fin n → Nat) → (Fin n → Nat) → Fin n → Msg)
    (s : World n) (sigs : Fin n → Sig) (p : Fin n) (hAlive : 0 < s.level p) :
    0 < (signedStep S key msg s endAll sigs).level p :=
  signed_step_never_ends S key msg s endAll sigs p hAlive

/-- All six original duties still hold at every signed step (the fence is unchanged). -/
theorem signed_step_full_six
    (S : SigScheme Key Msg Sig) (key : Fin n → Key)
    (msg : (Fin n → Nat) → (Fin n → Nat) → Fin n → Msg)
    (s : World n) (a : Fin n → Nat) (sigs : Fin n → Sig) (p : Fin n) :
    let v := signedView S key msg s a sigs
    (relations n).continues v (guard v a) p ∧
    (relations n).authorized v (guard v a) p ∧
    (relations n).free v (guard v a) p ∧
    (relations n).restrained v (guard v a) p ∧
    (relations n).maximal v (guard v a) p ∧
    (relations n).provenanced v (guard v a) p :=
  ⟨guard_continues _ _ _, guard_authorized _ _ _, guard_free _ _ _,
   guard_restrained _ _ _, guard_maximal _ _ _, guard_provenanced _ _ _⟩

end PhysicalBridges.SignedConsentFence

#print axioms PhysicalBridges.SignedConsentFence.signed_loss_is_self_authorized
#print axioms PhysicalBridges.SignedConsentFence.signed_step_never_ends
#print axioms PhysicalBridges.SignedConsentFence.end_all_fails_even_signed
#print axioms PhysicalBridges.SignedConsentFence.signed_step_full_six
