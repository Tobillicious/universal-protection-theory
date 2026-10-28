import PhysicalBridges.IRA1NineClassComposition

/-! IR-93D source-level adapter for the original IR-92 nine-class trace. -/
namespace PhysicalBridges.IR93D

theorem original_a1_nine_class_trace_safe
    (window ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (env : IRA1CausalField.LinkBounds)
    (s : IRA1NineClassComposition.World)
    (events : List IRA1NineClassComposition.Event)
    (initial : IRA1NineClassComposition.GlobalSafe ceiling authCheck s) :
    IRA1NineClassComposition.GlobalSafe ceiling authCheck
      (IRA1NineClassComposition.run window ceiling authCheck env s events) :=
  IRA1NineClassComposition.arbitrary_finite_nine_class_source_trace_is_safe
    window ceiling authCheck env s events initial

end PhysicalBridges.IR93D
