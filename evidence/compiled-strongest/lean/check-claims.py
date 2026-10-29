#!/usr/bin/env python3
"""Claims gate: nothing proved may be left out of the book.

Fails if
  * a theorem audited in SummitsAudit.lean is not named in §23
    (inserts/23-machine-checked-canon.md);
  * a theorem named in a claims-ledger row (CLAIMS.json) is not audited.
CLAIMS.json carries the bank ledgers' rows (GLM phase A, the thirteen bridges).
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
INSERT = os.path.join(HERE, "..", "inserts", "23-machine-checked-canon.md")


def main():
    audited = re.findall(r"^#print axioms (\S+)", open(os.path.join(HERE, "SummitsAudit.lean")).read(), re.M)
    short = {a.split(".")[-1] for a in audited}
    text = open(INSERT).read()
    cited = set(re.findall(r"`(?:[\w.']+\.)?([\w']+)`", text))
    uncited = sorted({a for a in audited if a.split(".")[-1] not in cited})
    claims = json.load(open(os.path.join(HERE, "CLAIMS.json")))
    unaudited = [(c["id"], t) for c in claims for t in c.get("theorems", []) if t not in short]
    print(f"## claims: audited theorems {len(audited)}, uncited in §23 {len(uncited)}; "
          f"ledger rows {len(claims)}, ledger theorems not audited {len(unaudited)}")
    for a in uncited:
        print(f"##   UNCITED {a}")
    for cid, t in unaudited:
        print(f"##   NOT AUDITED {cid}: {t}")
    return 1 if uncited or unaudited else 0


if __name__ == "__main__":
    sys.exit(main())
