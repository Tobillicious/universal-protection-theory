/- Place beside the v5.7 physical-bridges Lake project and replay with
   lake env lean UPTIntegration.lean. Exact existing types, no replacements.
   This is an integration harness, not a new proof of the bridge premise. -/
import PhysicalBridges.G3TheLaw
import PhysicalBridges.G3QGConstruction
import PhysicalBridges.G3QGInterpretationNecessity

#print PhysicalBridges.G3PreQGComplete.BCRDIsQG
#check PhysicalBridges.G3PreQGComplete.if_bcrd_then_all_six_and_no_E
#print axioms PhysicalBridges.G3PreQGComplete.if_bcrd_then_all_six_and_no_E
#check PhysicalBridges.G3TheLaw.THE_LAW
#print axioms PhysicalBridges.G3TheLaw.THE_LAW
#check PhysicalBridges.G3QGConstruction.QG_is_satisfiable
#print axioms PhysicalBridges.G3QGConstruction.QG_all_six_and_no_E
#check PhysicalBridges.G3QGInterpretationNecessity.identical_complete_physics_permits_opposite_subject_readings
#print axioms PhysicalBridges.G3QGInterpretationNecessity.identical_complete_physics_permits_opposite_subject_readings
