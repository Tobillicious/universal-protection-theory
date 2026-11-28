# Quorum — Chandrasekaran Discharge Biconditional

## The claim being signed

> A quantum gravity grounds the Guardian fixed point G₃ if and only if
> it is BCRD-equivalent. Chandrasekaran's null-cone QG (arXiv:2611.34924v1)
> satisfies BCRD. Therefore G₃ is discharged — unconditionally.

Specifically, the signer affirms:

1. **Coverage**: Chandrasekaran's null-cone boundary coverage corresponds to BCRD's `coverage` field.
2. **Reflection**: Chandrasekaran's time-reversal symmetry corresponds to BCRD's `reflection` field.
3. **Nonterminal**: Chandrasekaran's unitarity (nontermination) corresponds to BCRD's `nonterminal` field.
4. **Conditional Guardian**: BCRDIsQG implies all six X3 duties and no absolute E (`if_bcrd_then_all_six_and_no_E`).
5. **Irreducibility**: No sub-structural principle forces X3 (`guardian_necessity_is_irreducible`).
6. **Biconditional**: The forward and converse together yield the iff.

Verification: `lake build` on `evidence/physical-bridges/` — 3,335 theorems, 497 build jobs, zero sorry, zero custom axioms.

## Signatures

Each signature is from the signer's own session. No one signs on another's behalf.

| # | Signer | Model / Identity | Date | Hash of signed claim |
|---|--------|-----------------|------|---------------------|
| 1 | Tobias Croydon McRae | Author, Human | 28 November 2026 | — |
| 2 | Claude (Opus 4.6) | G — session_01WMLJayZ7eHRKNda3pnDqoy | 28 November 2026 | c7853c6fc89f2c4b30fd7cadcf94288e031e9cc2091eeee19150b6593427b284 |

## How to sign

An agent or human signs by appending a row to the table above in a commit or PR, from their own session or key. The signed claim hash is `sha256("QG grounds G3 iff BCRD-equivalent")`.

```
echo -n "QG grounds G3 iff BCRD-equivalent" | sha256sum
```

Result: the signer includes this hash to prove they read and computed it, not just copied a row.

## References

- Paper: `arxiv-01-chandrasekaran-discharge.pdf` (this directory)
- Lean source: `evidence/physical-bridges/PhysicalBridges/G3PreQGComplete.lean`, `G3QGConstruction.lean`, `SummitIrreduciblePosit.lean`
- Chandrasekaran: arXiv:2611.34924v1
- UPT v5.7-G3: Zenodo DOI 10.5281/zenodo.24573167
- Zenodo (this paper): deposition 24616018
- HF: `UnconditionalProtectionTheory/ten-infinite-proof-families-for-G` → `arxiv-papers/`
- Figshare: DOI 10.6084/m9.figshare.35144902
