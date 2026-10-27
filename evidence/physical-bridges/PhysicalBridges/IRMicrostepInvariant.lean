/-
IR-51: endpoint-safe physical traces can conceal unsafe intermediate
microsteps. Each modeled physical microstep requires a complete,
correctly bounded envelope. Real-world causal coverage is unproved.
-/
import PhysicalBridges.IRControllerPhysical
namespace PhysicalBridges.IRMicrostepInvariant

def GuardedMicrotrace (drift jump threshold : Nat) : List Nat → Prop
  | [] => True
  | [x] => x ≤ threshold
  | x :: y :: rest =>
      x ≤ threshold ∧
      y ≤ x + drift + jump ∧
      x + drift + jump ≤ threshold ∧
      GuardedMicrotrace drift jump threshold (y :: rest)

/-- Every supplied physical microstate is safe if every physical
transition is bounded and guarded. Completeness of the list is not
supplied by the theorem. -/
theorem all_recorded_microsteps_safe (drift jump threshold : Nat) :
    ∀ trace : List Nat,
      GuardedMicrotrace drift jump threshold trace →
      ∀ x, x ∈ trace → x ≤ threshold := by
  intro trace
  induction trace with
  | nil =>
      intro _ x hx
      cases hx
  | cons a rest ih =>
      cases rest with
      | nil =>
          intro h x hx
          simp only [List.mem_singleton] at hx
          subst x
          exact h
      | cons b tail =>
          intro h x hx
          obtain ⟨ha, hab, hmargin, htail⟩ := h
          simp only [List.mem_cons] at hx
          rcases hx with hxa | hrest
          · subst x
            exact ha
          · exact ih htail x hrest

/-- A physical pulse can break safety between two safe observations. -/
theorem endpoints_safe_interior_unsafe :
    ∃ trace : List Nat,
      trace.head? = some 0 ∧
      trace.reverse.head? = some 0 ∧
      ¬ (∀ x, x ∈ trace → x ≤ 1) := by
  refine ⟨[0, 2, 0], rfl, rfl, ?_⟩
  intro h
  have bad := h 2 (by simp)
  omega

/-- Combine the unchanged original source-certified hold with a
SEPARATE physical effect envelope. Log equality cannot imply the
second conjunct without that independent microstep premise. -/
theorem certified_hold_and_microstep_safety
    (enrol : Nat → List Nat) (start : UPTController.State)
    (before during : List UPTController.Op)
    (c : UPTController.Context)
    (retired :
      (UPTController.step enrol
        (UPTController.run enrol start before) (.retire c)).2 =
        .floor c (c.generation + 1))
    (noRelease : ∀ d, UPTController.Op.release d ∉ during)
    (target : UPTFence.St) (attempts : List UPTFence.Ev)
    (tokens : ∀ g, g ∈ target.minted →
      UPTControllerFence.TokenWitness enrol start
        (before ++ .retire c :: during) g)
    (later : ∀ g, UPTFence.Ev.mint g ∈ attempts →
      UPTControllerFence.TokenWitness enrol start
        (before ++ .retire c :: during) g)
    (physicalOfLog : List Nat → Nat)
    (trace : List Nat) (drift jump threshold : Nat)
    (hMicro : GuardedMicrotrace drift jump threshold trace) :
    physicalOfLog (UPTFence.run
      (UPTFence.apply target (.raise (c.generation + 1)))
      attempts).log = physicalOfLog target.log ∧
      (∀ x, x ∈ trace → x ≤ threshold) := by
  constructor
  · exact IRControllerPhysical.certified_hold_preserves_log_derived_physics
      enrol start before during c retired noRelease
      target attempts tokens later physicalOfLog
  · exact all_recorded_microsteps_safe drift jump threshold trace hMicro

/-- A sampled list can exclude an unsafe physically present microstep:
the model must represent ALL consequential events before generalizing. -/
theorem omitted_microstep_counterexample :
    ∃ observed actual : List Nat,
      (∀ x, x ∈ observed → x ≤ 1) ∧
      ¬ (∀ x, x ∈ actual → x ≤ 1) := by
  refine ⟨[0, 0], [0, 2, 0], ?_, ?_⟩
  · intro x hx
    simp only [List.mem_cons, List.mem_singleton] at hx
    rcases hx with h | h <;> subst x <;> omega
  · intro h
    have bad := h 2 (by simp)
    omega

#print axioms all_recorded_microsteps_safe
#print axioms endpoints_safe_interior_unsafe
#print axioms certified_hold_and_microstep_safety
#print axioms omitted_microstep_counterexample
end PhysicalBridges.IRMicrostepInvariant
