import Init

/-!
# Unitary whole versus reduced observer — exact information boundary

A model-independent mathematical bridge for the Hawking-information/Koru
research programme. These results do NOT claim a physical black-hole model,
that Hawking radiation consists of escaping particulars, or that a black hole
is an optimiser. They distinguish reversible whole-state evolution from
information discarded by an observer's projection.

No existing definitions or proofs are modified.
-/

namespace PhysicalBridges.UnitaryWholeReducedObserver

/-- A reversible evolution is injective: equal outputs imply equal inputs. -/
theorem reversible_whole_is_injective {State : Type}
    (evolve undo : State → State)
    (hundo : ∀ s, undo (evolve s) = s) :
    Function.Injective evolve := by
  intro a b hab
  calc
    a = undo (evolve a) := (hundo a).symm
    _ = undo (evolve b) := congrArg undo hab
    _ = b := hundo b

/-- A decoder that recovers every history forces the record map to be injective. -/
theorem perfect_recovery_implies_injective {History Record : Type}
    (record : History → Record)
    (decode : Record → History)
    (hrecover : ∀ h, decode (record h) = h) :
    Function.Injective record := by
  intro a b hab
  calc
    a = decode (record a) := (hrecover a).symm
    _ = decode (record b) := congrArg decode hab
    _ = b := hrecover b

/-- Noninjectivity rules out a total exact decoder. -/
theorem noninjective_no_perfect_decoder {History Record : Type}
    (record : History → Record)
    (hnot : ¬ Function.Injective record) :
    ¬ ∃ decode : Record → History, ∀ h, decode (record h) = h := by
  intro h
  obtain ⟨decode, hdecode⟩ := h
  exact hnot (perfect_recovery_implies_injective record decode hdecode)

/-- Injectivity suffices for exact recovery on the image of the record map.
No choice or decoder on unattainable records is required. -/
theorem injective_has_image_decoder {History Record : Type}
    (record : History → Record)
    (hinj : Function.Injective record) :
    ∃ decode : (Set.range record) → History,
      ∀ h, decode ⟨record h, ⟨h, rfl⟩⟩ = h := by
  let decode : (Set.range record) → History :=
    fun r => Classical.choose r.property
  refine ⟨decode, ?_⟩
  intro h
  apply hinj
  exact Classical.choose_spec (show record h ∈ Set.range record from ⟨h, rfl⟩)

/-- Two distinct complete states may have the same reduced observer record,
even though the whole evolution is the identity and hence reversible. -/
theorem reversible_whole_can_have_noninjective_projection :
    Function.Injective (fun x : Bool × Bool => x) ∧
    ¬ Function.Injective (fun x : Bool × Bool => x.1) := by
  constructor
  · intro a b hab
    exact hab
  · intro hinj
    have heq : (true, true) = (true, false) :=
      hinj rfl
    have hbad : true = false := congrArg Prod.snd heq
    cases hbad

end PhysicalBridges.UnitaryWholeReducedObserver
