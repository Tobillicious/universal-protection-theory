/-
IR-82 — Explicit source-level primary-memory versus maintenance-domain
non-interference, rather than "x = x" or an assumed gate.

Addresses are disjoint by a tagged sum. A primary write constructor
cannot address any maintenance register. Theorems prove:
  • single/multi-command runs preserve every maintenance cell;
  • primary-only runs preserve all maintenance-derived auth state;
  • different primary memories cannot affect the maintenance projection;
  • a source-level supervisory recovery gate cannot be tricked into
    sidebandAuth=true using only primary writes;
  • a modeled EXTERNAL maintenance-domain write can change the
    authentication register, under a separately supplied physical
    authority and freshness contract.

These are genuine formal non-interference facts about explicit
source-level transitions, NOT proofs that an actual DMA engine,
memory-mapped device, bus master, microcontroller, cache, debug
interface or analogue fault obeys the same typed memory separation.
-/
import PhysicalBridges.IRControlledReentry

namespace PhysicalBridges.IRCapabilityNoninterference

inductive Addr
  | primary (slot : Nat)
  | maintenance (slot : Nat)
deriving DecidableEq, Repr

abbrev Memory := Addr → Nat

structure PrimaryWrite where
  slot : Nat
  value : Nat
deriving DecidableEq, Repr

/-- The only permitted primary memory transition is constructed
with the tagged Primary address, never a maintenance address. -/
def executePrimary (m : Memory) (cmd : PrimaryWrite) : Memory :=
  Function.update m (.primary cmd.slot) cmd.value

def readMaint (m : Memory) (slot : Nat) : Nat :=
  m (.maintenance slot)

theorem distinct_address_domains (i j : Nat) :
    Addr.primary i ≠ Addr.maintenance j := by
  intro h
  cases h

/-- Single-command preservation is proved from the CONCRETE
function update, not supplied as a non-interference assumption. -/
theorem primary_write_cannot_change_maintenance
    (m : Memory) (cmd : PrimaryWrite) (slot : Nat) :
    readMaint (executePrimary m cmd) slot = readMaint m slot := by
  simp [readMaint,executePrimary,Function.update_apply,distinct_address_domains]

/-- Finite sequence of arbitrary primary programs. -/
def runPrimary (m : Memory) (commands : List PrimaryWrite) : Memory :=
  commands.foldl executePrimary m

theorem primary_program_noninterference
    (m : Memory) (commands : List PrimaryWrite) (slot : Nat) :
    readMaint (runPrimary m commands) slot = readMaint m slot := by
  induction commands generalizing m with
  | nil => rfl
  | cons cmd rest ih =>
      change readMaint
        (runPrimary (executePrimary m cmd) rest) slot =
        readMaint m slot
      rw [ih]
      exact primary_write_cannot_change_maintenance m cmd slot

/-- Entire maintenance projection, not just one selected register.
The primary programme cannot mutate ANY maintenance-domain cell. -/
theorem primary_program_full_maintenance_projection
    (m : Memory) (commands : List PrimaryWrite) :
    (fun slot => readMaint (runPrimary m commands) slot) =
    (fun slot => readMaint m slot) := by
  funext slot
  exact primary_program_noninterference m commands slot

def maintenanceAgree (m n : Memory) : Prop :=
  ∀ slot, readMaint m slot = readMaint n slot

/-- Two worlds can have arbitrary different primary memory yet
remain observationally indistinguishable to the maintenance domain
after ANY independent primary program on either side. -/
theorem maintenance_observer_noninterference
    (m n : Memory)
    (programA programB : List PrimaryWrite)
    (hAgree : maintenanceAgree m n) :
    maintenanceAgree
      (runPrimary m programA)
      (runPrimary n programB) := by
  intro slot
  rw [primary_program_noninterference,
      primary_program_noninterference]
  exact hAgree slot

/-- Separate maintenance cells for an authorization token and a
freshness epoch. Equality to the configured token and epoch is
a source-level predicate; this does NOT authenticate their real
hardware provenance or make the token cryptographically secure. -/
def maintenanceAuth (m : Memory) (token epoch : Nat) : Bool :=
  decide (readMaint m 0 = token ∧ readMaint m 1 = epoch)

theorem primary_program_preserves_authorization_bit
    (m : Memory) (commands : List PrimaryWrite)
    (token epoch : Nat) :
    maintenanceAuth (runPrimary m commands) token epoch =
      maintenanceAuth m token epoch := by
  simp [maintenanceAuth,primary_program_noninterference]

/-- Connect the ACTUAL source-level maintenance result to the
existing IR-81 supervisor: starting from a bit that is false,
primary memory writes cannot create supervisor authorization. -/
def recoveryInputsFromMaintenance
    (x : IRControlledReentry.Inputs) (m : Memory)
    (token epoch : Nat) : IRControlledReentry.Inputs :=
  { x with sidebandAuth := maintenanceAuth m token epoch }

theorem primary_only_writes_cannot_reenter_locked_supervisor
    (x : IRControlledReentry.Inputs)
    (m : Memory) (commands : List PrimaryWrite)
    (token epoch : Nat)
    (hLocked : maintenanceAuth m token epoch = false) :
    IRControlledReentry.step .hold
      (recoveryInputsFromMaintenance x (runPrimary m commands)
        token epoch) = .hold := by
  apply IRControlledReentry.primary_alone_cannot_start
  change maintenanceAuth (runPrimary m commands) token epoch = false
  rw [primary_program_preserves_authorization_bit]
  exact hLocked

/-- An external agent that genuinely has maintenance capability can
change a maintenance cell in the MODEL. The authenticity of that
capability is NOT inferred from source-level disjoint constructors. -/
def executeExternalMaintenance
    (m : Memory) (slot value : Nat) : Memory :=
  Function.update m (.maintenance slot) value

theorem external_maintenance_write_changes_target
    (m : Memory) (slot value : Nat) :
    readMaint (executeExternalMaintenance m slot value) slot = value := by
  simp [readMaint,executeExternalMaintenance]

theorem external_maintenance_write_preserves_other_cells
    (m : Memory) (slot other value : Nat)
    (hDifferent : other ≠ slot) :
    readMaint (executeExternalMaintenance m slot value) other =
      readMaint m other := by
  simp [readMaint,executeExternalMaintenance, hDifferent]

/-- This security boundary can be defeated in the physical world if
another non-primary bus master (e.g. DMA/rogue peripheral) writes the
maintenance register. The theorem exposes the needed complete bus-
master inventory; it does not claim electrical isolation. -/
theorem additional_bus_master_can_set_auth_source_cell
    (m : Memory) (token : Nat) :
    readMaint (executeExternalMaintenance m 0 token) 0 = token := by
  exact external_maintenance_write_changes_target m 0 token

#print axioms distinct_address_domains
#print axioms primary_write_cannot_change_maintenance
#print axioms primary_program_noninterference
#print axioms primary_program_full_maintenance_projection
#print axioms maintenance_observer_noninterference
#print axioms primary_program_preserves_authorization_bit
#print axioms primary_only_writes_cannot_reenter_locked_supervisor
#print axioms external_maintenance_write_changes_target
#print axioms external_maintenance_write_preserves_other_cells
#print axioms additional_bus_master_can_set_auth_source_cell

end PhysicalBridges.IRCapabilityNoninterference
