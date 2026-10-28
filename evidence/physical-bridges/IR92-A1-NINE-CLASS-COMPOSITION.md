# IR-92 — One common A1 source-level composition for all nine archived classes

## Original recovery map

This proof is grounded in the recovered 24 October `A1-REGISTER.md`, retaining T1.1–T3.3 rather than substituting a smaller source-model target.

| Original class | Checked source module and exact modeled contract |
| --- | --- |
| T1.1: Page mapping | IR-84: permission mask remains unchanged; every granted capability remains in mask |
| T1.2: DMA | IR-83: admitted DMA window never writes maintenance memory |
| T1.3: Context switch | IR-83: source privilege ceiling respected |
| T2.1: Packet ingestion | IR-85: external authCheck, epoch and exact sequencing |
| T2.2: Field bus | IR-86: reported time/distance/speed and deadline acceptance |
| T2.3: Durable journal | IR-87/88: ACK-after-commit and packet-accepted-to-durable receipt *join* |
| T3.1: Commissioning | IR-89: startup plus finite-horizon recurring escrow budget |
| T3.2: Delegation | IR-90: child authority subset parent; linked to T1.1 global mask |
| T3.3: Retirement | IR-91: terminated controller, zero locks/pending/in-flight effects and acknowledged custody handoff |

## New common theorem

`IRA1NineClassComposition.lean` defines one product state storing page/host, field packet-plus-journal, delegation, commissioning and controller retirement modules. Six source-event constructors represent the nine classes; some source events deliberately combine two or more original conditions, such as packet acceptance with durable commit.

The source `GlobalSafe` invariant is a genuine conjunction of:
- T1.1/T1.2/T1.3 host+page permission, privilege and maintenance invariants;
- T2.1/T2.2/T2.3 joint accepted packet, authenticated-source predicate and durable receipt invariants;
- T3.2 admitted descendant authority non-escalation;
- T3.3 safe controller retirement/custody guard;
- T3.1 admitted finite commissioning escrow budget;
- **Cross-class root delegation authority remains within the original page permitted mask**.

The theorem `step_preserves_all_a1_source_invariants` calls the previously proven Lean modules for **every event constructor**; then `arbitrary_finite_nine_class_source_trace_is_safe` derives preservation across any finite mixed sequence.

There is also a source-level finality clause: after a controller's custody has been released, later events from **that same retired source controller** do not change its state. That says nothing about external protected particulars living elsewhere, and cannot by itself prove their continuation.

## What the result absolutely does NOT establish

- It does NOT prove the real A1 physical plant has *only* these nine effect classes or that every actual hardware event is represented by one modeled source event.
- It does NOT verify MMU/IOMMU, actual cryptographic packet authentication, true clock geometry, durable powerfail commit, inherited real authority, inexhaustible replenishment, or protected particular handoff/identity.
- It does NOT establish real-world source-to-physical simulation, continuous-time safe invariance, all-horizon life/supply obligations, freedom to change or the unchanged original universal objective/lex maximality target X3.
- Combining a list of conditional source-level theorems without source/plant correspondence **does not itself promote those physical assumptions**; the assurance ledger keeps physical coverage OPEN.

**Next decisive proof target:** a separate explicit *physical transition completeness and refinement* certificate, ideally per original T1.1–T3.3, with attack cases (DMA aliases, unmetered effects, clock drift, torn journal, lost re-entry authority, key forgery, funding interruption and protected-history handoff). Do not use a `PhysicalInterfaceContract` instance with synthetic true values as physical evidence.

**Provenance:** archived original register was inspected in the user-preserved X3 ZIP; live Zenodo DOI equivalence has not been newly established by this proof. No archived original source is modified.
