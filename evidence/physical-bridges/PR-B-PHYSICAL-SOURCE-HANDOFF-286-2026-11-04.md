# PR B phase 2 handoff — PR A (#286) to actual particulars

**4 November 2026; PR A inspected at immutable SHA `7aca6af546a0b33d35d786088ede0107222aeba0` (successful proof-check). PR B baseline: #285.**

This is a **prospective typed join specification**, not a claim that the physical-to-subject semantics are already established. Do not import an unmerged PR A into PR B and break independent CI.

## 1. What #286 actually exports

`PhysicalBridges.BCRDActualRelationalFrame` defines:

- `SourceState := Index → Int` with `Index := Fin 6`;
- `SourceEvent.mSectorSwap`;
- `Transport := FrozenBCRDEvents.permutation`;
- `step s i := s (Transport i)`;
- `ActualStep s e t := (t = step s)`;
- `RelationBefore s x y := s x = s y`;
- `RelationAfter t x y := t x = t y`.

`relational_covariance` is proved for these types, as are site covariance, fixed-register counterexample and nonvacuous same-value relation movement. `evolve_realises_event` confirms `evolve densityBefore = densityAfter` on the named basis-density witness. It does NOT yet establish that every arbitrary integer-valued configuration `s` is faithfully represented by an actual physical density evolved under `evolve`; the review comment on #286 requests the exact diagonal representation theorem.

**Never treat an index `Fin 6` or a conserved site relation as the identity of a conscious, continuing subject.** Nor should `Index → Int` silently stand for a complete physical history, consent mechanism or executable action set.

## 2. Exact first typed adapter once PR A is integrated

With PR A imported, the deliberately narrow source-step adapter should be:

```lean
def sourceRealStep
    (s t : BCRDActualRelationalFrame.SourceState) : Prop :=
  BCRDActualRelationalFrame.ActualStep s
    .mSectorSwap t
```

Use this as `ParticularFrame.realStep`. Introduce a new, independently justified `Particular` type and `Owed : SourceState → Particular → Prop`. None of the six component fields should default to `True` or to the frame's covariance condition.

This instantiation gives a bona fide source *transition index* for PR B, not the semantic X3 proof.

## 3. What PR B still needs independently of the finite frame

For each owed `p` and source event `s→t`:

| Component | Acceptable external semantic/source bridge | Explicit negative control |
|---|---|---|
| historical continuity | Actual continuing process plus source-authenticated causal history, including every within-event stage (`Oct10Continuity.preserveActive/preserveLineage`) | Same stored origin and operator endpoints, original process stops |
| authorization | Authentic subject-authorized action/consent decision; identify the decision's agent, authority and time (`IR104/IR105`) | Accounting and nonzero causal participation with authorization false |
| freedom | Legitimate executable next choices and real future agency (`IR131`, `IR112`) | "Two nominal options" that cannot actually be enacted |
| restraint | Applied lawful restraint preserving protected interests (`BookUPTRestraint`) | A physically stable but unauthorized restraint |
| maximality | Actual original full feasible family and dominance relation (`IR98`, `StagedMaximality`) | Winner only among a restricted subset of feasible candidates |
| provenance | Independently faithful physical history and causal event receipts (`IR119`) | Copied origin/journal with inactive original |

Because `SourceState` only stores six integers, **there is no source-native mind identifier or experience predicate in PR A**. Either give a justified source-to-subject reconstruction map from richer unchanged BCRD history data, or keep a separate physical/semantic extension whose fidelity is an explicit externally demonstrated obligation. Do not invent these data inside a proof to make the bridge typecheck.

## 4. Exact PR B acceptance theorem and where it would be circular

Target after the source and semantics are fixed:

```lean
theorem originalX3_of_source_event
  (F : ParticularFrame SourceState Particular)
  (hLink : F.realStep = sourceRealStep)
  (... independent six semantic bridge proofs ...)
  (s t : SourceState) (p : Particular)
  (hStep : sourceRealStep s t) (hOwed : F.owed s p) :
  FullOriginalX3 F s t p
```

**Proof-term inventory required:** for each of the six fields, the proof term must come from an actual source theorem or a separately validated physical/semantic certificate. Supplying `∀ realStep owed, FullOriginalX3` (or six pointwise equivalents) as an unvalidated input is not a derivation of X3 necessity. Demonstrating the exact logical implication under supplied independently measured premises is still a useful engineering theorem, but must be labelled conditional.

Before PR C, require at least one **positive actual-source event witness** where all semantic correspondence proofs are supplied from a justified real process/history, and six **adversarial rejected witnesses** that share physical source readouts but violate one X3 component (if such semantic histories are physically/source-admissible).

## 5. Explicit remaining status

- **Verified:** the six-component target and readout countermodels (#285), the finite source relation frame (#286), and CI at frozen commits.
- **Not proved:** a physical same-subject model, authentic consent, all six component correspondences on an actual BCRD event, continuous within-event X3, or universal forcing.
- **Next compatible changes:** integrate #286 into the PR B branch **only after** it merges or via an explicit isolated tested integration branch, without rewriting Hilzy's work; then add the `sourceRealStep` adapter and the strongest honest source/semantic obstruction or positive proof obtainable.

**No canonical manuscript or publication modifications. No claim weakening.**