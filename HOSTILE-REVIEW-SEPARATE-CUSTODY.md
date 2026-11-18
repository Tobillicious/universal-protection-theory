# Hostile Review: Separate Custody Evidence (PR main)

## Findings

1. Simulation, not reality: tests use temp directories, not distinct administrators.
2. No cryptographic binding: evidence files are unsigned.
3. No independent witnessing: single process writes both domains.
4. Cross-custody access test only checks file non-existence, not permission enforcement.

## Verdict

The separate custody evidence is a simulation. It does not establish independent administrative control or tamper-resistant custody.

## Recommendation

Deploy nodes under separate administrators, use signed evidence, and submit to external hostile review.
