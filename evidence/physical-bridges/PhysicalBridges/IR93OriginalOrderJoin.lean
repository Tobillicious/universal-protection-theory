/-! IR-93C: original-order maximality interface. -/
namespace PhysicalBridges.IR93Order

variable {Outcome : Type}

/-- No strictly better feasible outcome is exactly maximality relative
to the supplied strict priority relation. The substantive work is to
derive the certificate for the *original* full feasible set. -/
def Maximal (Feasible : Outcome → Prop)
    (better : Outcome → Outcome → Prop) (chosen : Outcome) : Prop :=
  Feasible chosen ∧ ∀ other, Feasible other → ¬ better other chosen

theorem maximal_of_no_improver
    (Feasible : Outcome → Prop)
    (better : Outcome → Outcome → Prop)
    (chosen : Outcome)
    (feasible : Feasible chosen)
    (noImprover : ∀ other, Feasible other → ¬ better other chosen) :
    Maximal Feasible better chosen :=
  ⟨feasible, noImprover⟩

/-- An improved feasible alternative refutes maximality. -/
theorem omitted_improver_refutes
    (Feasible : Outcome → Prop)
    (better : Outcome → Outcome → Prop)
    (chosen other : Outcome)
    (hother : Feasible other)
    (hbetter : better other chosen) :
    ¬ Maximal Feasible better chosen := by
  intro h
  exact (h.2 other hother) hbetter

end PhysicalBridges.IR93Order
