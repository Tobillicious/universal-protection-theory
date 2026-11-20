# G3 ethical-grounding and external-rights evidence bridge

**21 November 2026 — source-inspected additive research. Not a physical or universal G3 certificate.**

## Find before build

The existing PR #713 module already derives the exact `FaithfulRead` interface from six observation-and-soundness channels and the existing Four-Cause plant. It also includes an `∃ p, owed p` non-vacuity theorem. The new Lean module **does not duplicate those interfaces**.

The repository has three other bounded, non-authorizing research lanes:

1. `evidence/execution-boundary/g3_authority_evidence/` — pinned-issuer Ed25519 signature verifier. A matching signature means **only the record and claimed identity/digest/scope were cryptographically verified**; its API deliberately returns `authorizes_effect: false`.
2. `evidence/execution-boundary/g3_rights_review/` — independent record-reference based rights triage. Tests identity, scope, delegation, voluntary status and withdrawn/revoked evidence assertions; it does not certify genuine consent and always reports `authorizes_effect: false`.
3. `evidence/execution-boundary/g3_rights_veto/` — persistent deny-only withdrawal journal with restarted-control halt, increasing generations and optional externally pinned signed checkpoint. It does not become an allow decision when no revocation record is found.

**No integration with a live writer or network node is performed.** None of these is an independently verified moral authority. Do not promote their metadata flags into authentic consent or full OriginalX3.

## First bridge: from existence and interests to owed

`G3GroundedOwedRightsBridge.EthicalGrounding` has four *independent* predicates:

- `present p`: subject independently identified as present;
- `interests p`: subject independently assessed to have protectable interests;
- `warrant p`: separately defended moral reason to protect that subject;
- `owed p`: authentic owed-subject status, *not* defined by model positivity.

The bridge requires and names the ethical premise:

```
present p ∧ interests p ∧ warrant p
  --[recognition_grounds_owing, independently justified]--> owed p
```

The theorem `grounded_nonvacuous_six_witness_guardian` composes this premise with PR #713's six independently checked event witnesses and Four-Cause model to yield one nonvacuous protected, owed particular on a real **plant** step. The hostile negative control proves `Unit` inhabitation alone cannot force *every possible* independent `owed` interpretation.

**Interpretation:** this resolves the *formal shape* of nonvacuity, not the normative Hume bridge or actual human/AI personhood. An ethical warrant must be publicly justified and independently contestable. Never classify people as unowed merely because they cannot supply an electronic signature or express interests through a particular protocol.

## Second bridge: signed-record evidence versus authentic authorization

`RightsEvidence` requires separately grounded issuer trust, subject identity, exact scope/purpose, voluntariness and a withdrawal check. `RecordEligible` is not an authorization decision; its logic merely requires every record-level field, including **no withdrawal**.

`withdrawal_blocks_record_eligibility` proves a true withdrawal excludes eligibility regardless of token/issuer success.

`externally_validated_rights_support_authentic_authorization` makes both boundaries explicit:
1. authentic event authorization evidence implies that all record checks are satisfied;
2. an **independently justified** ethical/rights soundness premise establishes that an eligible record reflects actual authorization.

Only then can the existing `SixWitnessChecks.authority_sound` field be discharged in a real application. This is intentionally **not** an implementation that wires a positive signature to an effect writer.

## Independent offline tests to run, without deploying

All tests must use disposable fixtures and no live effects:

```sh
cd evidence/execution-boundary/g3_authority_evidence
python3 -B -m unittest -v test_authority_evidence.py

cd ../g3_rights_review
python3 -B -m unittest -v test_rights_review.py

cd ../g3_rights_veto
python3 -B -m unittest -v test_rights_veto.py test_external_checkpoint.py
```

Adversarial cases that must be present before any future integration:

- A syntactically valid signature under a trusted key **but** an unauthorized issuer, coerced subject or withdrawn permission never produces an allow.
- A permission withdrawal just before a simulated commit denies the effect; restart, stale generation and independently anchored rollback controls also deny.
- The independent receiver observes the actual output and checks exact content digest, subject, time and purpose. A log/receipt alone never proves the effect occurred.
- The absence of a record, missing delegation, a dropped revocation channel, a fifth cause or an unmodeled effect path fails closed.
- Explicitly identify a non-electronically consenting or dependent subject so that the `owed` scope cannot be silently restricted to easy-to-authenticate users.

Any real deployment must additionally demonstrate trusted clock and revocation consistency, race-free enforcement, full effect mediation, independent auditing, rights-governance review and independent measurement of each original-six meaning.

## What remains to prove

1. **Normative:** defend `recognition_grounds_owing` without assuming owed and without excluding nonconsenting/dependent beings.
2. **Physical:** independent evidence that *all* relevant real effects are mediated, with no fifth/unmodeled cause.
3. **Semantic:** independent verification of `*_sound` for all six authentic original duties, not just correct signatures or recorded histories.
4. **Universality/QG:** actual-world source interpretation, not merely positive W model instances.

PR #713's source theorems and original-six definitions are unchanged. This stacked addition should remain draft until Lean and negative tests are independently checked. No physical experiment, merge or publication is authorized by these proofs.
