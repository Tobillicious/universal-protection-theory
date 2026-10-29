import Snuffy.R14Boundary
/-! Concrete source-level noninterference from the unchanged R14 step.
This is only R14's J/K/outside reference machine, NOT a plant-completeness proof. -/
namespace UPTR16CUTR14
open UPTR14Boundary

theorem journal_projection_step_ext (s t : St) (e : Ev)
    (h : projectJ s = projectJ t) :
    projectJ (step s e) = projectJ (step t e) := by
  rw [journal_commutes, journal_commutes, h]

theorem sink_projection_step_ext (s t : St) (e : Ev)
    (h : projectK s = projectK t) :
    projectK (step s e) = projectK (step t e) := by
  rw [sink_commutes, sink_commutes, h]

theorem outside_projection_step_ext (s t : St) (e : Ev)
    (h : projectOutside s = projectOutside t) :
    projectOutside (step s e) = projectOutside (step t e) := by
  rw [outside_commutes, outside_commutes, h]

/-- Journal and sink operations cannot directly change the outside-care
    coordinate in the declared R14 reference implementation. -/
theorem journal_outside_unchanged (s : St) (g n p : Nat) :
    projectOutside (step s (.journal g n p)) = projectOutside s := by
  rw [outside_commutes]
  rfl

theorem sink_outside_unchanged (s : St) (g n p : Nat) (harmful : Bool) :
    projectOutside (step s (.effect g n p harmful)) = projectOutside s := by
  rw [outside_commutes]
  rfl

end UPTR16CUTR14
