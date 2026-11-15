# G3 evidence inventory — preparation for independent audit

**Non-enforcing research utility. Not a production certificate.**

This component checks local evidence files against a submitter-provided packet:
- Required categories: signed effect-time enforcement, separate UID isolation, emergency revocation, restart lease fencing, crash recovery, exhaustion resistance, rights/consent review, original-six X3 correspondence, independent security review, rollback/recovery review.
- All evidence files must be ordinary non-symlink files in the chosen directory; traversal and duplicate relative paths are denied.
- SHA-256 file digests and the packet's 64-character source-commit label must match.

**Limitations:** The packet is itself provided by the applicant. Matching hashes demonstrate consistency with that *untrusted packet*, not authenticity. Reviewer labels are free text, not authenticated reviewers. A malicious applicant can submit false content and matching hashes. The utility does not evaluate the substantive claim, fetch CI logs, authenticate consent or independently verify six-X3 physical obligations.

The returned `ready_for_independent_review` flag means only the supplied inventory passed these syntactic and content-integrity checks. It **never** means verified, approved, production ready or universally protective. The output always contains `certified_for_production: false` and `universal_physical_protection_proved: false`.

Run offline:
```sh
cd evidence/execution-boundary/g3_release_evidence
python3 -B -m unittest -v test_release_evidence.py
python3 -B release_evidence.py packet.json evidence-directory/
```

Packet format: top-level `schema` (`g3-evidence-inventory-v1`), `source_commit` (64 lowercase hex), and `evidence` dictionary containing every category in `release_evidence.REQUIRED`. Each evidence entry has `path` (relative file), `sha256` (64 lowercase hex), `reviewer` (unverified informational label), and `reviewed_commit` (same commit as packet).

A separate independently authenticated review and explicit deployment decision remain mandatory. Do not connect this tool to the write or control sockets; it has **no authorization role**.
