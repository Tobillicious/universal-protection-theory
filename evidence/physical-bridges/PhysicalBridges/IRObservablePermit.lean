/-
IR-3: Largest robustly safe one-step permission relation under an observation.
A nondeterministic transition relation represents all modelled successors.
This assumes that the physical observation/transition/identity model is sound
and complete for its stated purpose; it does not establish that assumption.
-/
namespace PhysicalBridges.IRObservablePermit

universe u v w
variable {S : Type u} {O : Type v} {A : Type w}

/-- An action is robustly permitted at an observation if it is safe for
EVERY currently safe, observation-compatible physical state and EVERY
successor allowed by the transition relation. -/
def Robust (observe : S → O) (next : S → A → S → Prop)
    (safe : S → Prop) (o : O) (a : A) : Prop :=
  ∀ s, safe s → observe s = o → ∀ t, next s a t → safe t

/-- A general controller permits actions based only on observed state. -/
def SoundPermit (observe : S → O) (next : S → A → S → Prop)
    (safe : S → Prop) (permit : O → A → Prop) : Prop :=
  ∀ s a t, safe s → permit (observe s) a → next s a t → safe t

/-- The robust permission relation is the greatest SOUND relation: every
sound observation-based controller is a subset of it, and conversely. -/
theorem sound_iff_below_robust
    (observe : S → O) (next : S → A → S → Prop)
    (safe : S → Prop) (permit : O → A → Prop) :
    SoundPermit observe next safe permit ↔
      ∀ o a, permit o a → Robust observe next safe o a := by
  constructor
  · intro h o a hp s hs he t ht
    have hp' : permit (observe s) a := by simpa [he] using hp
    exact h s a t hs hp' ht
  · intro h s a t hs hp ht
    exact h (observe s) a hp s hs rfl t ht

theorem robust_controller_sound
    (observe : S → O) (next : S → A → S → Prop)
    (safe : S → Prop) :
    SoundPermit observe next safe (Robust observe next safe) := by
  exact (sound_iff_below_robust observe next safe _).2 (fun _ _ h => h)

/-- Even when an action is safe at one compatible state it can be unsafe
at another state with the same observation. -/
def coarseObserve (_ : Nat) : Unit := ()
def toySafe (s : Nat) : Prop := s ≤ 1
def toyNext (s : Nat) (a : Bool) (t : Nat) : Prop :=
  t = (if a then s + 1 else s)

theorem coarse_observation_counterexample :
    toySafe 0 ∧ toyNext 0 true 1 ∧ toySafe 1 ∧
    ¬ Robust coarseObserve toyNext toySafe () true := by
  refine ⟨(by unfold toySafe; omega), (by unfold toyNext; rfl),
    (by unfold toySafe; omega), ?_⟩
  intro h
  have bad : toySafe 2 := h 1 (by unfold toySafe; omega) rfl 2
    (by unfold toyNext; rfl)
  have impossible : ¬ toySafe 2 := by
    unfold toySafe
    omega
  exact impossible bad

#print axioms sound_iff_below_robust
#print axioms robust_controller_sound
#print axioms coarse_observation_counterexample
end PhysicalBridges.IRObservablePermit
