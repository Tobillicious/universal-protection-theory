import PhysicalBridges.IR100PhysicalAccountingWitness

/-!
IR-102: separates dynamics coverage from semantic protection.
Closure of the sector under model transitions alone is insufficient.
-/
namespace PhysicalBridges.IR102

universe u
variable {S : Type u}

inductive Reach (step : S → S → Prop) : S → S → Prop where
  | refl (s : S) : Reach step s s
  | tail {s t v : S} : Reach step s t → step t v → Reach step s v

theorem physical_sector_semantic_bridge
    (physicalStep modelStep : S → S → Prop)
    (sector x3 : S → Prop)
    (complete : ∀ s t, physicalStep s t → modelStep s t)
    (sectorClosed : ∀ s t, sector s → modelStep s t → sector t)
    (sectorEntailsX3 : ∀ s, sector s → x3 s)
    {s t : S} (execution : Reach physicalStep s t)
    (initial : sector s) : x3 t := by
  have hSector : ∀ {a b : S}, Reach physicalStep a b →
      sector a → sector b := by
    intro a b h
    induction h with
    | refl => intro ha; exact ha
    | tail earlier edge ih =>
        intro ha
        exact sectorClosed _ _ (ih ha) (complete _ _ edge)
  exact sectorEntailsX3 t (hSector execution initial)

/-- A closed sector need not imply any independently defined X3 duty. -/
theorem sector_closure_alone_insufficient :
    ∃ (step : Bool → Bool → Prop) (sector x3 : Bool → Prop),
      (∀ s t, sector s → step s t → sector t) ∧
      (∃ s, sector s ∧ ¬ x3 s) := by
  refine ⟨(fun a b => a = b), (fun _ => True),
    (fun b => b = true), ?_, ?_⟩
  · intro s t _ _; trivial
  · exact ⟨false, trivial, by decide⟩

end PhysicalBridges.IR102
