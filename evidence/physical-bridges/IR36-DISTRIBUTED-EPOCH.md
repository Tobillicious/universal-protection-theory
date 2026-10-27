# IR-36 — Fleet-wide durable physical effect fencing

IR-33/34 prove that a particular modeled actuator rejects pre-hold
physical effects if its apply-time credential floor is authoritative
and durably retained through restart. That result cannot be promoted
to protection of an entire network of actuators without covering
**every** physical effect channel and device.

This module imports the original checked `IRDurableEpoch` theorem
and proves, by induction on a finite device list, that a fleet
protected device-by-device preserves the sum of landed effects across
arbitrary and independently chosen local recovery histories. Another
theorem constructs a committed hold for every listed device and
proves the same result from old-token premises.

Negative controls show:
- ONE unfenced/stale-epoch device can land an effect, despite a
  neighbouring device being perfectly fenced;
- a zero-device fleet makes an all-devices theorem vacuously true.

The fleet representation excludes unknown devices or unauthorized
bypass, so real-world *complete fleet enumeration*, authenticated
generation dissemination, crash persistence on every actuator,
common-mode faults, physical application mediation, and actual
device deployment remain open. This is not evidence of a physical
protection installation or subjective/historical continuity.
