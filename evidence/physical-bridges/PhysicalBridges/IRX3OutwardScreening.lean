/-
IR-76: exact source-level outward packet screening required by
X3-DERIVATIONS.md section 8 and LATEST-SUBMISSION-REVIEW.md section 2.

Under a specified UNIT-SPEED radially outward streaming law, every
packet still within an access radius r at age t must be emitted
at a time >= t-r. This classification can support the original
data-processing recovery-radius argument ONCE the relevant quantum
channel/side-information correspondences are independently proved.

A finite-speed upper bound allows completely stationary retained
information, and a single retained copy defeats the screening
statement. Neither static conserved routing nor the Lindbladian
covariance decay alone proves the outward-output model.

This is NOT a derivation of bath chirality from general BCRD physics.
-/

namespace PhysicalBridges.IRX3OutwardScreening

structure Packet where
  emitted : Nat
  channel : Nat
deriving DecidableEq, Repr

/-- A chosen physical clock/space normalization: the packet travels
one radial unit per clock tick and never returns. The law is part
of the explicit model, not derived from a lattice Hamiltonian. -/
def outwardDistance (age : Nat) (packet : Packet) : Nat :=
  age - packet.emitted

def outwardAccessible (age radius : Nat) (packet : Packet) : Prop :=
  packet.emitted ≤ age ∧ outwardDistance age packet ≤ radius

/-- All old outputs necessarily escape the permitted access ball
in the exact outward-translation model. This is the geometric
ingredient actually required by X3's screening dependency. -/
theorem accessible_outward_packet_is_recent
    (age radius : Nat) (packet : Packet)
    (h : outwardAccessible age radius packet) :
    age ≤ packet.emitted + radius := by
  rcases h with ⟨hIssued,hInside⟩
  unfold outwardDistance at hInside
  omega

/-- Equivalent cutoff formulation, closer to the archived
screening statement: at age t, anything still inside radius r
was emitted NO EARLIER than the cutoff t-r. -/
theorem outward_packet_emitted_after_cutoff
    (age radius : Nat) (packet : Packet)
    (h : outwardAccessible age radius packet) :
    age - radius ≤ packet.emitted := by
  have hr := accessible_outward_packet_is_recent
    age radius packet h
  omega

theorem old_outward_packet_escapes
    (age radius : Nat) (packet : Packet)
    (hOld : packet.emitted + radius < age) :
    ¬ outwardAccessible age radius packet := by
  intro hAccessible
  have hRecent := accessible_outward_packet_is_recent
    age radius packet hAccessible
  omega

/-- Actual decoder resources must account for retained copies
separately from radiating emissions. An internal old record cannot
be treated as if it had escaped merely because bath output streams
have outward geometry. -/
inductive AccessibleSource where
  | outward (packet : Packet)
  | retained (identifier : Nat)
deriving DecidableEq, Repr

def sourceAccessible (age radius : Nat) :
    AccessibleSource → Prop
  | .outward packet => outwardAccessible age radius packet
  | .retained _ => True

def sourceRecent (cutoff : Nat) :
    AccessibleSource → Prop
  | .outward packet => cutoff ≤ packet.emitted
  | .retained _ => False

/-- A complete input inventory, a provable packet motion law,
AND the absence of an uncounted retained source collectively yield
the RECENCY part of screening. This does not yet prove the causal
quantum channel input-output factorization or mutual-information
bound. -/
theorem all_accessible_inputs_recent_if_no_retained_copies
    (age radius : Nat)
    (inventory : AccessibleSource → Prop)
    (hMotion : ∀ packet, inventory (.outward packet) →
      outwardAccessible age radius packet)
    (hNoRetained : ∀ identifier,
      ¬ inventory (.retained identifier)) :
    ∀ source, inventory source →
      sourceRecent (age - radius) source := by
  intro source hIn
  cases source with
  | outward packet =>
      exact outward_packet_emitted_after_cutoff age radius
        packet (hMotion packet hIn)
  | retained identifier =>
      exact False.elim (hNoRetained identifier hIn)

/-- Countermodel: the original physical record may be retained inside
the radius. It stays accessible at all ages yet cannot be classified
as newly emitted from any recent cutoff. Complete source inventories
must account for this case rather than assume it away. -/
theorem retained_historical_copy_defeats_recency
    (age radius identifier : Nat) :
    sourceAccessible age radius (.retained identifier) ∧
      ¬ sourceRecent (age - radius) (.retained identifier) := by
  exact ⟨trivial, fun h => h⟩

/-- An upper propagation-speed constraint does not imply positive
outward radial transport. A stationary packet satisfies the bound
position(t) <= t, but fails the strictly outward lower bound. -/
def stationaryPosition (_age : Nat) : Nat := 0

theorem finite_speed_upper_bound_allows_stationary_information
    (age : Nat) (hAge : 0 < age) :
    (∀ t, stationaryPosition t ≤ t) ∧
    stationaryPosition age < age := by
  constructor
  · intro t
    simp [stationaryPosition]
  · simp [stationaryPosition]
    exact hAge

/-- A packet emitted at time zero remains within radius zero in the
stationary model at EVERY age, including ages strictly past cutoff.
Thus no positive lower outward speed follows from an upper bound. -/
theorem stationary_packet_violates_unit_speed_screening
    (age : Nat) (hAge : 0 < age) :
    stationaryPosition age ≤ 0 ∧ ¬ age ≤ 0 := by
  simp [stationaryPosition]
  omega

/-- A finite collection of emitted packets obeys the same cutoff
screening. The list can have arbitrary length; there is no
assumption that only finitely many original physical records exist
across all times. -/
theorem all_observed_outward_packets_recent
    (age radius : Nat) (packets : List Packet)
    (h : ∀ packet, packet ∈ packets →
      outwardAccessible age radius packet) :
    ∀ packet, packet ∈ packets →
      age - radius ≤ packet.emitted := by
  intro packet hMember
  exact outward_packet_emitted_after_cutoff age radius
    packet (h packet hMember)

#print axioms accessible_outward_packet_is_recent
#print axioms outward_packet_emitted_after_cutoff
#print axioms old_outward_packet_escapes
#print axioms all_accessible_inputs_recent_if_no_retained_copies
#print axioms retained_historical_copy_defeats_recency
#print axioms finite_speed_upper_bound_allows_stationary_information
#print axioms stationary_packet_violates_unit_speed_screening
#print axioms all_observed_outward_packets_recent

end PhysicalBridges.IRX3OutwardScreening
