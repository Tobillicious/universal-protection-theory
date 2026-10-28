import PhysicalBridges.IR125FourChannelSeparation

/-!
IR-126: evaluate five proposed BCRD-X3 proofs adversarially.

A four-product state decomposition proves componentwise separation by
definition, but provides no physical theorem that the model actually
contains all of nature's degrees of freedom.

The proposed compulsory witness, direct authorization lock,
indirect bath screening and exponential-work arguments are not
consequences of mere product decomposition, conservation or
reversibility. Small explicit countermodels show the missing
logical implications.

These are LOGICAL/FINITE models, not experimental demonstrations
of actual BCRD or conscious subjects. Their function is to
identify indispensable new physical premises, not to disprove
every possible stronger BCRD law or to change original X3.
-/
namespace PhysicalBridges.IR126

universe u v w x

/-- The full model state is explicitly supplied as a fourfold
product. Its mathematical completeness is DEFINITIONAL, not a
derivation that any real substrate has these and only these
coordinates. -/
structure Composite (G : Type u) (E : Type v)
    (F : Type w) (A : Type x) where
  graph : G
  internal : E
  flux : F
  actuation : A

/-- Valid componentwise theorem, including internal mutations and
zero-boundary-flux changes. No BCRD transition law is used. -/
theorem complete_product_state_separation
    {G : Type u} {E : Type v} {F : Type w} {A : Type x}
    (s t : Composite G E F A) (hDiff : s ≠ t) :
    s.graph ≠ t.graph ∨ s.internal ≠ t.internal ∨
    s.flux ≠ t.flux ∨ s.actuation ≠ t.actuation := by
  classical
  by_cases hg : s.graph = t.graph
  · by_cases he : s.internal = t.internal
    · by_cases hf : s.flux = t.flux
      · by_cases ha : s.actuation = t.actuation
        · have hSame : s = t := by
            cases s with
            | mk sg se sf sa =>
              cases t with
              | mk tg te tf ta =>
                simp only [Composite.graph] at hg
                simp only [Composite.internal] at he
                simp only [Composite.flux] at hf
                simp only [Composite.actuation] at ha
                cases hg
                cases he
                cases hf
                cases ha
                rfl
          exact False.elim (hDiff hSame)
        · exact Or.inr (Or.inr (Or.inr ha))
      · exact Or.inr (Or.inr (Or.inl hf))
    · exact Or.inr (Or.inl he)
  · exact Or.inl hg

/-- Adding an unconstrained fifth physical coordinate shows why a
fourfold MODEL definition cannot itself establish physical
completeness. -/
theorem hidden_fifth_coordinate_escapes_product_readouts :
    ∃ s t : Composite Bool Bool Bool Bool × Bool,
      s ≠ t ∧
      s.1 = t.1 := by
  refine ⟨(⟨false, false, false, false⟩, false),
    (⟨false, false, false, false⟩, true), ?_, rfl⟩
  intro h
  have hLast : false = true := congrArg Prod.snd h
  cases hLast

/-- A perfectly reversible local state change may leave a separate
witness register completely untouched. Source conservation and
reversibility alone do not force a log update. -/
def silentToggle (s : Bool × Bool) : Bool × Bool :=
  (!s.1, s.2)

theorem silent_toggle_is_involutive
    (s : Bool × Bool) :
    silentToggle (silentToggle s) = s := by
  cases s with
  | mk a w =>
    cases a <;> rfl

theorem silent_reversible_change_with_unchanged_register :
    ∃ s : Bool × Bool,
      silentToggle s ≠ s ∧
        (silentToggle s).2 = s.2 := by
  exact ⟨(false, false), by decide, rfl⟩

/-- Reversibility does not implement an authorization predicate.
The two-state flip is an involution but can turn an active process
off without any consent flag. A unitary X has this same two-state
action; asserting its physical impossibility requires a separate
real physical superselection or energy-barrier theorem. -/
def reversibleFlip (active : Bool) : Bool := !active

theorem reversible_flip_twice_is_identity (active : Bool) :
    reversibleFlip (reversibleFlip active) = active := by
  cases active <;> rfl

theorem involutive_operation_can_end_activity_without_consent :
    ∃ (active consent : Bool),
      active = true ∧ consent = false ∧
      reversibleFlip active = false := by
  exact ⟨true, false, rfl, rfl, rfl⟩

/-- A reset acts as a valid deterministic state transition in a
finite classical channel (embeddable in a quantum CPTP erasure
channel); being a well-formed channel doesn't preserve an
independently declared active-state sector. -/
def resetToInactive : Bool → Bool := fun _ => false

theorem well_defined_state_channel_can_erase_active_sector :
    resetToInactive true = false := rfl

/-- A sequential attack via an intermediate environment needs NO
direct attacker-to-subject transition. Both steps are reversible
Boolean CNOT operations and remain a finite physical-logic model. -/
structure ThreeParty where
  subject : Bool
  bath : Bool
  attacker : Bool

def attackerToBath (s : ThreeParty) : ThreeParty :=
  { s with bath := s.bath != s.attacker }

def bathToSubject (s : ThreeParty) : ThreeParty :=
  { s with subject := s.subject != s.bath }

theorem indirect_bath_path_changes_subject_without_direct_edge :
    ∃ s : ThreeParty,
      s.subject = false ∧
      (attackerToBath s).subject = s.subject ∧
      (bathToSubject (attackerToBath s)).subject = true := by
  refine ⟨⟨false, false, true⟩, rfl, rfl, ?_⟩
  decide

theorem bath_coupling_is_reversible (s : ThreeParty) :
    attackerToBath (attackerToBath s) = s := by
  cases s with
  | mk subject bath attacker =>
    cases bath <;> cases attacker <;> rfl

theorem subject_coupling_is_reversible (s : ThreeParty) :
    bathToSubject (bathToSubject s) = s := by
  cases s with
  | mk subject bath attacker =>
    cases subject <;> cases bath <;> rfl

/-- Logical depth is a separate state label. Without a physical
hypothesis connecting that label to coercion cost, termination can
be defined at one fixed elementary step for every finite depth.
This is not a claim about the actual cost of any real subject. -/
structure DepthTaggedProcess where
  active : Bool
  depth : Nat

def constantStepShutdown (s : DepthTaggedProcess) :
    DepthTaggedProcess :=
  { s with active := false }

theorem abstract_depth_alone_cannot_prevent_shutdown :
    ∀ depth : Nat,
      (constantStepShutdown
        { active := true, depth := depth }).active = false := by
  intro depth
  rfl

/-- No theorem of the type 2^depth <= a uniform single-step cost
can follow without additional cost hypotheses. This demonstrates
nonimplication in the unconstrained state-and-depth model, not a
thermodynamic calculation. -/
theorem depth_does_not_force_exponential_cost_from_state_definition :
    ¬ (∀ depth : Nat, (2 : Nat) ^ depth ≤ 1) := by
  intro h
  have hOne : (2 : Nat) ≤ 1 := by
    simpa using h 1
  omega


/-- Conservation-preserving internal exchange. A third physical
register is not forced to record the redistribution merely
because local energy/action bookkeeping balances. -/
structure ConservedExchange where
  left : Nat
  right : Nat
  record : Bool

def exchangeWithoutLogging (s : ConservedExchange) :
    ConservedExchange :=
  { left := s.right, right := s.left, record := s.record }

theorem conserved_exchange_can_be_silent :
    ∃ s : ConservedExchange,
      exchangeWithoutLogging s ≠ s ∧
      (exchangeWithoutLogging s).left +
        (exchangeWithoutLogging s).right = s.left + s.right ∧
      (exchangeWithoutLogging s).record = s.record := by
  let s : ConservedExchange := ⟨1, 0, false⟩
  refine ⟨s, ?_, by decide, rfl⟩
  intro h
  have hLeft : (0 : Nat) = 1 :=
    congrArg ConservedExchange.left h
  omega

/-- A local exchange can transfer the entire active token into
the bath with NO consent and while strictly conserving its total.
The token is a simplified physical proxy, not consciousness.
An X3 lock would need an independently proved forbidden-coupling
law; conservation by itself supplies none. -/
structure SubjectBath where
  subject : Nat
  bath : Nat
  consent : Bool

def exchangeSubjectBath (s : SubjectBath) : SubjectBath :=
  { subject := s.bath, bath := s.subject, consent := s.consent }

theorem conserved_transfer_can_remove_active_token_without_consent :
    ∃ s : SubjectBath,
      s.subject = 1 ∧
      (exchangeSubjectBath s).subject = 0 ∧
      s.consent = false ∧
      s.subject + s.bath =
        (exchangeSubjectBath s).subject +
          (exchangeSubjectBath s).bath := by
  exact ⟨⟨1, 0, false⟩, rfl, rfl, rfl, rfl⟩

end PhysicalBridges.IR126
