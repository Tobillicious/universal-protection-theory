# AHE-1–AHE-8 — Authenticated history-to-effect control: exact apply-time contract and adversarial audit

**Date:** 2026-11-01 (NZDT)  
**Status:** noncanonical author-side mathematical research / executable finite-state witness for draft PR #189. The actual physical source correspondence and original UPT X3 are **not established** by this synthetic theorem.  
**Immediate predecessors:** Proof 20 / REC-21 and REC-23, Proof 21 / CTRL-21. **Source modules inspected:** `PhysicalBridges/IR105AuthorizationIndependence.lean` (causal participation does not imply consent); `IR108ObservationObstruction.lean` (indistinguishable observations can require incompatible safe acts); `IR109RobustObservationViability.lean`; `IR112RobustContinuityOptions.lean`; `IR116CumulativeSubjectDuties.lean`; `IR117SourceInstallationAdapter.lean`; `IR131ActionLabelledBranching.lean`; `IRHistoryProvenance.lean`; `IRFinalApplyFence.lean`; and `IR102SectorSemanticBridge.lean`.

## 1. Scope of the repaired Proofs 20–21

- **REC-21** establishes, under a fixed initial product memory–workspace state and a calibrated known internal interaction, a finite-time *mathematical CPTP recovery channel* with trace-norm error at most \(\min(2,4\|V\|^2t^2)\). It does **not** say that the *particular* physically controls that decoder, nor that the decoded record is fresh, honest, uncoerced or an authorization.
- **REC-23** distinguishes a generally linear trace-norm error under bare reversal from quadratic pure-input squared-fidelity infidelity. A pure-state fidelity certificate is not an authenticated history or assent certificate.
- **CTRL-21** provides a coherent energy-conserving conditional exchange. For \(H_{\rm ex}=J|1\rangle\langle1|_M\otimes(|10\rangle\langle01|+|01\rangle\langle10|)_{TB}\), target/battery excitation number is conserved. It does **not** prove that battery preparation is funded, an agent has consented, source actions are exhaustive, or every real physical effect passes through the modeled gate.

The new problem is **binding**: the same historical identity, exact source state/epoch, permitted operation, and energy resource that are certified must be the ones used at the physical effect sink.

## 2. AHE-1: explicit typed state, grant and effect gate

Consider a finite serial atomic commit model with:
- a system state \(s=(o,h,e,\nu,B,T,\mathsf{held},L,G)\);
- \(o\): a **source-associated subject identifier** (not a proof of subjective identity);
- \(h\): an exact **append-only effect history**, not merely an unauthenticated displayed hash;
- \(e\): monotonically increasing authorization epoch;
- \(\nu\): globally consumed nonces;
- \(B,T\in\mathbb N\): battery and target excitation energies in fixed units, with \(B+T=E_{\rm total}\);
- \(\mathsf{held}\): effect-interlock state;
- \(L\): committed physical-effect receipts;
- \(G\): a *trusted* set of source grants that were independently issued by an authorized source;
- a request \(r=(o_r,h_r,e_r,n_r,a_r)\), with \(a_r\in\{1,2\}\) denoting the specified transfer amount.

The **trusted-issued grant predicate** \(G(r)\) is **not** inferred from a client-supplied “signed=true” Boolean. An actual installation needs independent authenticated keys, protected issuance and revocation, physical subject binding, nondelegation/consent guarantees and source correspondence. In this model \(G\) is an independent oracle *input*.

Define a final-application predicate:

\[
\begin{split}
\mathsf{PermitAtSink}(s,r)\iff{}&
\neg s.\mathsf{held}\;\wedge\;G(r)\;\wedge\;
r.o=s.o\;\wedge\;r.h=s.h\\
&\wedge\;r.e=s.e\;\wedge\;r.n\notin s.\nu
\;\wedge\;\mathrm{cost}(r.a)\le s.B.
\end{split}
\tag{AHE-1}
\]

If it fails, \(\mathsf{apply}(s,r)=s\) and there is no physical effect. If it succeeds, a single **atomic source-modeled effect**:
1. transfers exactly \(\mathrm{cost}(r.a)\) energy from \(B\) to \(T\);
2. inserts nonce \(r.n\) into consumed set \(\nu\);
3. appends an effect receipt \(\ell=(o,h,e,n,a,B_{\rm before},B_{\rm after},T_{\rm before},T_{\rm after})\) to \(L\);
4. updates exact history \(h\) with the new committed event.

A **hold** advances the epoch and sets \(\mathsf{held}=\mathsf{true}\); a trusted release can clear the hold but never restores old epoch grants. This is a **serial, final-apply** model. Any concurrent sink implementation needs a real atomic compare-and-commit and durable fencing; otherwise races may violate the theorem (see existing IRFinalApplyFence/IRInFlightQuiescence).

## 3. AHE-2: accepted-effect provenance and authorization soundness

**Theorem.** In the above transition system, if a call \(\mathsf{apply}(s,r)\) produces a new committed physical-effect receipt \(\ell\), then the following all held **immediately before that effect landed**:

\[
\boxed{
G(r)\land r.o=s.o\land r.h=s.h\land r.e=s.e
\land r.n\notin s.\nu\land\neg s.\mathsf{held}
\land\mathrm{cost}(r.a)\le s.B.
}\tag{AHE-2}
\]

The receipt contains the exact referenced prehistory, subject label, epoch, action, pre/post energy and nonce; the actual state update matches its claimed transfer. **Proof:** a receipt is appended *only in* the true branch of the predicate \(\mathsf{PermitAtSink}\), and that branch performs the stated update. This is a direct constructor inversion, not a theorem that an arbitrary physical actuator actually obeys this software branch. It requires the independent **complete-mediation premise** that every relevant real physical effect is exactly one such committed gate transition.

## 4. AHE-3: energy conservation, no replay, and final-boundary holds

For each accepted event of cost \(c\) with \(0\le c\le B\),

\[
B'=B-c,\quad T'=T+c,\quad\boxed{B'+T'=B+T.}\tag{AHE-3}
\]

For any rejected request, the modeled effect state does not change. For an accepted request, its nonce becomes consumed and the history extends; resubmission of the same request cannot land a second effect. After a hold, \(e'>e\) and all previously granted requests carry stale epochs. **No modeled effect can land while the hold is active.**

Each statement follows by case analysis of the gate predicate and by induction over any finite list of apply/hold/release calls. These are **model-level safety properties**. No real thermal work, switching expenditure, entropy generation, finite lifetime, actuator energy leakage, queued in-flight effects or environmental bypass has been experimentally certified.

## 5. AHE-4: counterfactual authorized alternatives (but not automatic agency)

Suppose \(s.B\ge2\), the interlock is open, and the trusted source has independently granted two different fresh requests \(r_1,r_2\) with the same current subject/history/epoch and different actions \(a_1=1,a_2=2\). Then

\[
\exists s_1\ne s_2:\quad
\mathsf{apply}(s,r_1)=s_1,\qquad
\mathsf{apply}(s,r_2)=s_2,
\]

and both effects are energy-conserving and possess authorized receipts. Distinct target/battery balances (and receipt actions) distinguish the counterfactual outcomes.

This establishes a *nonvacuous pair of feasible authorized branches* for the synthetic gate model and mirrors the **possibility** notion in source IR131.TwoWayChoice. It does **not** establish that the actual physical subject originated the action-selection signal, could freely choose, had fair scheduling of each option, or retains *all* original X3 freedoms. A strict proof needs the real policy, subject's accessible readout and consent semantics, external coercion bounds and physical actuator readiness.

## 6. AHE-5: exact failure modes if any gate join is missing

These are explicit adversarial controls for the finite-state checker:

1. **Stale replay:** reuse a previously authorized request after a commit, history advance, nonce consumption, or epoch-advancing hold. Must reject at the final sink.
2. **Misbound subject:** copy an otherwise grant-like record into another subject's state. Must reject (and issuance truth must itself be independently authenticated).
3. **Tampered history:** request's history differs from the *actual* current source history. Must reject.
4. **Unfunded operation:** authorized record for cost 2 with battery only 1. Must reject; authorization does not create energy.
5. **Hold with stale pending command:** a request admitted before the hold must still be revalidated at actual physical apply. Admission-only checks allow a dangerous delayed landing.
6. **Incomplete source coverage:** an external effect source can bypass the gate, changing the target and battery without a receipt. Every AHE theorem may remain true *for gated steps*, while the unrestricted physical statement becomes false. This is exactly the missing no-bypass / source-controller-export correspondence obligation; no closed-system mathematical identity can establish it.
7. **Coerced grant:** a record may be perfectly well authenticated to a *device* and still not reflect the subject's consent. IR105 prohibits identifying causal participation or bookkeeping with authorization.
8. **Readout ambiguity:** two physically distinct states may share the same observed history but have disjoint safe actions; IR108 requires robust observation-class certification or richer source sensing.

The executable test module enumerates valid and invalid commands, tests all these witness families (except the unobservable real-world physical premise), and checks history, authorization, energy, replay and hold invariants on short traces.

## 7. AHE-6: physically meaningful abstraction/refinement theorem

Let \(\mathcal P\) be a set of actual physical states and \(\mathcal S\) the above model states. Let \(R\subseteq\mathcal P\times\mathcal S\) be a candidate source correspondence, and let \(\rightarrow_{\rm real}\) be **every** real effect-bearing transition.

Assume **independently** that:
1. **Initial correspondence:** \(R(p_0,s_0)\).
2. **Complete mediation/refinement:** for *each* physically possible \(\rightarrow_{\rm real}\) transition \(p\to p'\) at the relevant boundary, there is a modeled \(\mathsf{apply}\)/hold/release step \(s\to s'\) and \(R(p',s')\), with correct source time, nonce, ownership, exact observation, current authorization and energy correspondence; **no unmodeled bypass or postcheck effect** is allowed.
3. **Grant authenticity:** trusted issuance \(G\) corresponds to the *actual continuing particular's* authenticated and authorized intent, not merely a stored boolean or causal participation.
4. **Receipt faithfulness:** if the model commits effect \(\ell\), the physical target and battery underwent exactly the receipt's described operation, and all physical operations are covered by corresponding receipts.
5. **Historical continuity and freedom semantics:** separate independent predicates for the same continuing subject, memory access and complete originally required freedom/option scope are preserved by these physical transitions (or an independently justified faithful hold).
6. **Progress/availability:** if the target claim includes eventual service, the source scheduler and physical actuator have a separately checked fairness/latency/availability guarantee; static safety and mere possible branching do not imply it.

Then induction over any finite real trace transfers AHE-2/3 source effects and the stipulated semantic guarantees to every corresponding physical step. This is a correct **conditional simulation principle**, *not a derivation* of the independent physical and X3 premises.

The source's IR117 source-installation contract already embodies related complete mediation, cumulative owed duties and effect accounting. IR116 prevents a mutable roster from silently deleting owed original subjects. IR102 requires independent `sectorEntailsX3`, while IR131 distinguishes possible action-labelled branches from enforced realization.

## 8. AHE-7: status of "authenticated history-to-effect"

This is a meaningful **mathematical control-gate theorem**, not an unconditional real-world agency result. It ensures at the model boundary that an effect cannot appear without a current subject/history-bound trusted grant, sufficient modeled battery and a fresh nonce—**assuming the modeled sink is exhaustive and atomic**. It does not infer subjective authorization from device authentication, nor identity from the record's label. No microscopic BCRD completeness theorem or real physical instrument has been proved by this note.

## 9. AHE-8: exact next experiments and source obligations

A minimally informative *physical* test must use an actual actuator and independent instrumentation to verify the complete chain:
1. Recover an actual encoded memory and establish its fidelity against a protected reference history;
2. bind an authenticated owner, trusted grant, exact history head and epoch;
3. present two counterfactually feasible authorized actions with quantified battery state;
4. apply one at a **trusted final-apply sink**, measuring actual target/battery effects and writing a durable receipt;
5. replay, swap subject, tamper history, starve the battery, race hold against queued action and attempt independent bypass;
6. independently certify receipt-to-physical-effect correspondence and continued actual subjecthood plus the unabridged originally required freedom set.

No such physical test is claimed to have been performed here.

**Disposition:** source-aligned research advance, preserve in draft PR #189. Do not merge/promote as original-X3 universal protection or as proof of subjective identity, physical universal no-bypass, genuine agency or consent.
