# Exact formal anchor and proposed interpretations
Pinned source revision a3e067e18c3e18566adba8306ebb73d0f79bc971.
OriginalX3Full.lean defines OriginalX3 with six parameters continues authorized free restrained maximal provenanced : S → S → P → Prop, and six fields historicalContinuity, authorization, freedom, restraint, maximality, provenance. Each field applies its relation to s t x. This is the exact interface, not a definition of the underlying semantics.
Source anchors named in that file:
- ContinuationSubject.LaterStage, copy_not_laterStage: identity-through-history.
- IR104.SubjectAuthorized, IR105: authorization distinct from accounting.
- G2Freedom / FreeStage: future options.
- BookUPTRestraint.Restrainable: appropriate restraint.
- StagedMaximality.StageMax: maximality over feasible outcomes.
- IR119: provenance.
These underlying definitions have not been extracted or replayed in this pack. Do not substitute the English glosses for them.
originalX3_strengthens_proxy proves full six implies continues ∧ authorized. proxy_is_strictly_weaker supplies a Unit countermodel with restraint false and the other five true.
FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E requires hCoverage : CompleteWEventCoverage and hReflection : ForwardRealEventReflection. These are not discharged by the assembly itself.
Source paths: evidence/physical-bridges/PhysicalBridges/{OriginalX3Full,FullPhysicalDomainGuardianAssembly}.lean.
