/-
IR-75: the X3 archive's compulsory cut-activation bridge.

Archive: X3-DERIVATIONS.md §§5–6; LATEST-SUBMISSION-REVIEW.md §1.
This is a formally checked capacity/side-information/work implication
for EVERY admitted protocol. NOT a derivation that the original
BCRD bath imposes an area-scaling information demand.

The source distinguishes available cut edges from necessarily ACTIVE
edges. A large cut geometry alone cannot force traffic, work or
decoder information gain.

All information quantities are DISCRETE information units. Any
physical application must prove correct units, genuinely complete
side-information inventory, and a uniform recovery converse for all
admitted decoders including quantum coding and external resources.
-/

namespace PhysicalBridges.IRX3CompulsoryCut

/-- Geometric boundary area *index* in dimension d >= 1.
The coefficient is supplied separately. This is a combinatorial
proxy; it is not claimed to characterize a general BCRD lattice. -/
def areaIndex (dimension radius : Nat) : Nat :=
  radius ^ (dimension - 1)

/-- A protocol carries only as much NEW information as it must
after accounting for independently available initial side info. -/
theorem side_information_forces_new_traffic
    (target sideInfo required areaCoefficient area : Nat)
    (hRequirement : sideInfo + areaCoefficient * area ≤ target)
    (hDecoder : target ≤ sideInfo + required) :
    areaCoefficient * area ≤ required := by
  omega

/-- Each active physical cut edge carries at most capacity information
units during the admitted accounting window. If the protocol needs
information, enough active edges must cross the cut. -/
theorem required_traffic_forces_active_edges
    (required active capacity areaCoefficient area : Nat)
    (hInformation : areaCoefficient * area ≤ required)
    (hCapacity : required ≤ active * capacity) :
    areaCoefficient * area ≤ active * capacity := by
  omega

/-- The genuinely compulsory cross-cut area-power implication.
The conclusion is division-free, so zero-capacity cases are covered
without hiding a division by zero. It is useful only when
areaCoefficient > 0, capacity > 0 and edgePower > 0 are warranted
independently for a physical admitted protocol class. -/
theorem compulsory_area_power_bound
    (areaCoefficient area required active capacity edgePower power : Nat)
    (hRequired : areaCoefficient * area ≤ required)
    (hCapacity : required ≤ active * capacity)
    (hEdgePower : active * edgePower ≤ power) :
    (areaCoefficient * area) * edgePower ≤ power * capacity := by
  calc
    (areaCoefficient * area) * edgePower
        ≤ required * edgePower :=
          Nat.mul_le_mul_right edgePower hRequired
    _ ≤ (active * capacity) * edgePower :=
          Nat.mul_le_mul_right edgePower hCapacity
    _ = (active * edgePower) * capacity := by ac_rfl
    _ ≤ power * capacity :=
          Nat.mul_le_mul_right capacity hEdgePower

/-- Integrate the archived side-information-aware recovery argument
with the per-edge communication and power contracts. Nothing
assumes *all available boundary edges* must operate. -/
theorem x3_decoder_converse_to_compulsory_cut_work
    (target sideInfo demand active capacity edgePower power
      areaCoefficient dimension radius : Nat)
    (hRecoveryConverse :
      sideInfo + areaCoefficient * areaIndex dimension radius ≤ target)
    (hDecoderInformation : target ≤ sideInfo + demand)
    (hActiveCapacity : demand ≤ active * capacity)
    (hPaidActivePower : active * edgePower ≤ power) :
    (areaCoefficient * areaIndex dimension radius) * edgePower
      ≤ power * capacity := by
  have hDemand :=
    side_information_forces_new_traffic target sideInfo demand
      areaCoefficient (areaIndex dimension radius)
      hRecoveryConverse hDecoderInformation
  exact compulsory_area_power_bound
    areaCoefficient (areaIndex dimension radius) demand
    active capacity edgePower power
    hDemand hActiveCapacity hPaidActivePower

/-- If each edge can carry at most c information units PER TICK and
the recovery deadline is tau ticks, its total throughput is bounded
by active * c * tau. The deadline is an essential physical resource.
-/
theorem compulsory_active_cut_with_deadline
    (target sideInfo demand active capacityPerTick deadline : Nat)
    (areaCoefficient area : Nat)
    (hTarget : sideInfo + areaCoefficient * area ≤ target)
    (hInformation : target ≤ sideInfo + demand)
    (hFiniteWindow : demand ≤ active * capacityPerTick * deadline) :
    areaCoefficient * area ≤ active * capacityPerTick * deadline := by
  have hNeed := side_information_forces_new_traffic
    target sideInfo demand areaCoefficient area
    hTarget hInformation
  omega

/-- Uniformity over ALL allowed decoders is explicit. Checking
a single chosen recovery algorithm does not establish a physical
minimum-work lower bound over all possible successful protocols. -/
theorem universal_admitted_protocol_cut_work
    {Protocol : Type}
    (target sideInfo demand active power : Protocol → Nat)
    (admitted : Protocol → Prop)
    (areaCoefficient dimension radius capacity edgePower : Nat)
    (hTarget : ∀ p, admitted p →
      sideInfo p + areaCoefficient * areaIndex dimension radius ≤ target p)
    (hInformation : ∀ p, admitted p →
      target p ≤ sideInfo p + demand p)
    (hCapacity : ∀ p, admitted p →
      demand p ≤ active p * capacity)
    (hPower : ∀ p, admitted p →
      active p * edgePower ≤ power p) :
    ∀ p, admitted p →
      (areaCoefficient * areaIndex dimension radius) * edgePower
        ≤ power p * capacity := by
  intro p hp
  exact x3_decoder_converse_to_compulsory_cut_work
    (target p) (sideInfo p) (demand p) (active p)
    capacity edgePower (power p)
    areaCoefficient dimension radius
    (hTarget p hp) (hInformation p hp)
    (hCapacity p hp) (hPower p hp)

/-- Countercontrol: arbitrarily many AVAILABLE edges, but just one
bit of demanded information, one active edge and one unit of work.
There is no required activation of every available edge. -/
theorem large_cut_does_not_force_large_power (radius : Nat)
    (hPositive : 0 < radius) :
    ∃ available active information capacity edgePower power : Nat,
      available = radius + 1 ∧
      active ≤ available ∧
      information ≤ active * capacity ∧
      active * edgePower ≤ power ∧
      power < available := by
  refine ⟨radius + 1, 1, 1, 1, 1, 1, rfl, ?_, ?_, ?_, ?_⟩
  all_goals omega

/-- More strongly: a decoder already possessing a complete correlated
record can need ZERO new cross-cut traffic irrespective of the
geometric cut. A side-information inventory cannot be omitted. -/
theorem complete_side_information_allows_zero_crossing
    (target availableEdges : Nat) :
    ∃ sideInfo demand active : Nat,
      target ≤ sideInfo + demand ∧
      demand ≤ active * availableEdges ∧ active = 0 := by
  exact ⟨target, 0, 0, by omega, by simp, rfl⟩

#print axioms side_information_forces_new_traffic
#print axioms required_traffic_forces_active_edges
#print axioms compulsory_area_power_bound
#print axioms x3_decoder_converse_to_compulsory_cut_work
#print axioms compulsory_active_cut_with_deadline
#print axioms universal_admitted_protocol_cut_work
#print axioms large_cut_does_not_force_large_power
#print axioms complete_side_information_allows_zero_crossing

end PhysicalBridges.IRX3CompulsoryCut
