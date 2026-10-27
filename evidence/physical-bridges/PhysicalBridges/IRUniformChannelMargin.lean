/-
IR-57: the uniform-coupling repair suggested by the archived
A Lattice Preservation Calculus (Zenodo 23599528) source audit.

Pointwise finite physical influence does NOT imply a common bound
across an unbounded population. A uniformly bounded number of
consequential channels, with uniformly bounded channel impact,
DOES imply a pointwise common margin for every instrument.

Conditional on authentic sample freshness, real physical rise and
complete physical-effect mediation, the inherited IR-2 guarded
post-effect theorem then applies to EVERY instrument. A common
pointwise bound is not a total fleet-wide influence budget.
-/
import PhysicalBridges.IRApplyTimeSampleGuard
import PhysicalBridges.IRAggregateBudget

namespace PhysicalBridges.IRUniformChannelMargin
universe u

/-- A finite list of consequential changes has a sum bounded by its
length times a uniform per-channel physical effect envelope. -/
theorem finite_channels_sum_bound
    (cap : Nat) :
    ∀ (weights : List Nat),
      (∀ w, w ∈ weights → w ≤ cap) →
      weights.sum ≤ weights.length * cap := by
  intro weights
  induction weights with
  | nil =>
      intro _
      simp
  | cons w ws ih =>
      intro hWeights
      have hw : w ≤ cap := hWeights w (by simp)
      have hrest : ∀ z, z ∈ ws → z ≤ cap := by
        intro z hz
        exact hWeights z (by simp [hz])
      have hsum := ih hrest
      simp only [List.sum_cons, List.length_cons, Nat.succ_mul]
      omega

/-- A single physically warranted degree cap and channel cap yield
one instance-independent bound, even if the type of agents is infinite. -/
theorem uniform_local_channel_budget
    {Agent : Type u} (channels : Agent → List Nat)
    (maxDegree maxPerChannel : Nat)
    (hDegree : ∀ a, (channels a).length ≤ maxDegree)
    (hEffect : ∀ a w, w ∈ channels a → w ≤ maxPerChannel) :
    ∀ a, (channels a).sum ≤ maxDegree * maxPerChannel := by
  intro a
  have hPerList :=
    finite_channels_sum_bound maxPerChannel (channels a)
      (hEffect a)
  have hCap := Nat.mul_le_mul_right maxPerChannel (hDegree a)
  omega

/-- Source-level integration of IR-53 authentic reading age,
IR-54 sensor/physical correspondence and IR-2 aggregate post-effect
guard. Every agent is covered without enumerating the population.

Physical assumptions: all real consequential channels are listed;
degree, weights, sensor errors, rate and latency obey the uniform
calibrated bounds; the final effect is actually gated with that margin.
No physical measurements are made in this theorem. -/
theorem every_agent_post_effect_safe_with_uniform_margin
    {Agent : Type u}
    (physical observed : Agent → Nat → Nat)
    (taken : Agent → Nat → Prop)
    (lastSample : Agent → Nat → Nat)
    (channels : Agent → List Nat)
    (actualAfter : Agent → Nat → Nat)
    (threshold : Agent → Nat)
    (maxDegree maxPerChannel maxAge maxRise epsilon external : Nat)
    (hDegree : ∀ a, (channels a).length ≤ maxDegree)
    (hChannel : ∀ a w, w ∈ channels a → w ≤ maxPerChannel)
    (hRecent : ∀ a,
      IRStaleReadingAge.RecentReading
        (taken a) (lastSample a) maxAge)
    (hRise : ∀ a,
      IRStaleReadingAge.SinceLastSampleRise
        (physical a) (lastSample a) maxRise)
    (hSensor : ∀ a s, taken a s →
      physical a s ≤ observed a s + epsilon)
    (hTotalEffect : ∀ a t,
      actualAfter a t ≤ physical a t + external + (channels a).sum)
    (hGate : ∀ a t,
      observed a (lastSample a t) + epsilon +
        (maxAge * maxRise + external) +
        maxDegree * maxPerChannel ≤ threshold a) :
    ∀ a t, actualAfter a t ≤ threshold a := by
  intro a t
  have hBudget :=
    uniform_local_channel_budget channels
      maxDegree maxPerChannel hDegree hChannel a
  have hReading : physical a (lastSample a t) ≤
      observed a (lastSample a t) + epsilon :=
    hSensor a (lastSample a t) (hRecent a t).1
  have hAge := (hRecent a t).2.2
  have hRate := hRise a t
  have hAgeBound :
      (t - lastSample a t) * maxRise ≤ maxAge * maxRise :=
    Nat.mul_le_mul_right maxRise hAge
  have hApplied := hTotalEffect a t
  have hEvolution :
      actualAfter a t ≤ physical a (lastSample a t) +
        (maxAge * maxRise + external) + (channels a).sum + 0 := by
    omega
  exact IRAggregateBudget.aggregate_post_effect_safe
    (channels a) (observed a (lastSample a t))
    epsilon (maxAge * maxRise + external) 0
    (maxDegree * maxPerChannel) (threshold a)
    (physical a (lastSample a t)) (actualAfter a t)
    hBudget hReading hEvolution (by simpa using hGate a t)

/-- A bounded number of channels alone cannot bound effect size:
one channel can have arbitrarily large physical impact. -/
theorem bounded_degree_without_channel_cap_is_insufficient :
    ∀ proposed : Nat,
      ∃ weights : List Nat,
        weights.length = 1 ∧ proposed < weights.sum := by
  intro proposed
  exact ⟨[proposed + 1], rfl, by simp⟩

/-- A per-channel cap alone does not bound aggregate influence if the
number of active consequential channels can grow without limit. -/
theorem per_channel_cap_without_degree_cap_is_insufficient :
    ∀ proposed : Nat,
      ∃ weights : List Nat,
        (∀ w, w ∈ weights → w ≤ 1) ∧
        proposed < weights.sum := by
  intro proposed
  refine ⟨List.replicate (proposed + 1) 1, ?_, ?_⟩
  · intro w hw
    have hOne : w = 1 := by simpa using hw
    omega
  · simp

#print axioms finite_channels_sum_bound
#print axioms uniform_local_channel_budget
#print axioms every_agent_post_effect_safe_with_uniform_margin
#print axioms bounded_degree_without_channel_cap_is_insufficient
#print axioms per_channel_cap_without_degree_cap_is_insufficient
end PhysicalBridges.IRUniformChannelMargin
