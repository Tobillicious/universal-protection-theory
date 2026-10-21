"""Map every load-bearing proposal row/section and checker predicate to source lines."""
import json, sys
sys.dont_write_bytecode = True
from audit import ROOT, safe


def build():
    rows = []
    proposal = 'inputs/author/proposals/glm-0b/derivation.md'
    checker = 'inputs/author/proposals/glm-0b/check_0b.py'

    def add(file, anchor, verdict, finding):
        lines = safe(ROOT / file).read_text().splitlines()
        hits = [i + 1 for i, line in enumerate(lines) if anchor in line]
        assert len(hits) == 1, (anchor, hits)
        rows.append({'source': file, 'line': hits[0], 'anchor': anchor,
                     'verdict': verdict, 'finding': finding})

    specs = [
        ('**Under assumptions A1', 'FAIL', 'Full P-ISLANDS does not follow: no onset-to-clearance bound; search expectation is not impossibility.'),
        ('| D1:', 'PASS', '400 islands is the inherited design size.'),
        ('| D2:', 'FAIL', '64 dates starts after stable return; not a maximum loss lifetime from onset.'),
        ('| D3:', 'FAIL', 'JW26 is adjacent public placement. Secret PRF placement is a conditional JW27 capacity candidate.'),
        ('| D4:', 'PASS-CONDITIONAL', '3-of5 degree2 share algebra passes under fresh coefficient and exposure contracts; full capture/privacy not proved.'),
        ('| D5:', 'PASS-CONDITIONAL', '202/400 and172/242 are inherited contracts; four-island quorum intersection is correct.'),
        ('| D6:', 'PASS-AS-TARGET', '242 hosts,80 passive sites and1171.2 inflow are price targets, not measured defensive energy or attack cost.'),
        ('| D7:', 'PASS-CONDITIONAL', 'Checkpoint/prefetch bounds are inherited; continuous secret redraw is not a realized JW26 fact.'),
        ('| PL1 |', 'FAIL-AS-PHYSICS', 'Conservation alone supplies neither a matched-draw attack floor nor f>=1.'),
        ('| PL2 |', 'OPEN', 'Finite propagation supplies no numerical race bound without distances/timing; prior coordination may avoid live coordination.'),
        ('| A1:', 'ASSUMED', 'Four covert probes/date and their observability/cost are unpriced.'),
        ('| A2:', 'ASSUMED', 'Four-date redraw is unpriced; cannot substitute an expectation test for leakage security.'),
        ('| A3 |', 'ASSUMED', 'Detection and failover realization does not bound physical return time.'),
        ('| A4:', 'ASSUMED', '1756.8 attack cost is an additional lower-cost premise, not conservation.'),
        ('| A5:', 'ASSUMED', 'Coalition share is not derived locally or globally.'),
        ('| A6 |', 'ASSUMED', 'Share-only secrecy holds algebraically; no full-view route or ciphertext privacy proof.'),
        ('| A7:', 'ASSUMED', 'One-date attack duration is not implied by a date-level probability law.'),
        ('| A8 |', 'ASSUMED', 'Loss observations and probes need an explicit conditional information model.'),
        ('| A9 |', 'ASSUMED', 'No stored energy alone does not bound prepared work, borrowed capability or persistent losses.'),
    ]
    specs += [
        ('### 3.0 Calendar', 'FAIL', 'Calendar or rolling arrival bound does not clear outstanding loss debt.'),
        ('### 3.1 Leg 1', 'PASS-PARTIAL', 'Budget floor and strict critical share pass only as an onset-count upper certificate under additional accounting.'),
        ('### 3.2 Leg 2', 'FAIL', 'Mean800/3 probes does not exclude early discovery; 16-probe pair coverage is120/79401.'),
        ('### 3.3 Supporting', 'PASS-PARTIAL', 'Finite-field and intersection arithmetic pass; freshness realization and privacy remain contracts.'),
        ('### 3.4 What', 'FAIL', 'The conjunction is not the all-cause outstanding P-ISLANDS premise. Under strict two-loss cap no third-image erasure needs secret placement.'),
        ('## 4. What is DERIVED', 'MIXED', 'Arithmetic/count form pass; locate implication and full premise derivation fail; doubled-share description is inaccurate.'),
        ('## 5. Dependence', 'PASS-PARTIAL', 'Consistent unit rescaling cancels. It supplies no hazard law or one-date duration lower bound.'),
        ('## 6. Conditions', 'FAIL', 'Iff claim unsupported. Two-member overlap cannot exclude two bad voters; conditional blind excess risk is not a paid horizon term.'),
        ('## 7. Checker', 'REPRODUCIBLE', 'Original checker exits0 twice; that reproduces its predicates rather than validating their labels.'),
    ]
    for spec in specs:
        add(proposal, *spec)
    for symbol, verdict, finding in [
        ('E_dis', 'PASS-AS-ASSUMED', '8784/5 given the assumed cost package; no physical lower bound supplied.'),
        ('E_A', 'PASS-AS-ASSUMED', '915/16 given the assumed coalition envelope.'),
        ('D_max', 'PASS-PARTIAL', 'Budget floor2 is an onset count upper bound, not a complete outstanding-loss cap.'),
        ('ε*', 'PASS-PARTIAL', '9/51200 is the critical share of this count certificate, not a derived global capability bound.'),
    ]:
        add(proposal, '| ' + chr(96) + symbol + chr(96) + ' |', verdict, finding)
    for anchor, verdict, finding in [
        ('| period budget |', 'PASS', 'T times915/16 equals3660.'),
        ('| locate time |', 'FAIL-FORMULA', 'Value200/3 dates agrees with code; prose2(N+1)/(3v) is off by1/6 date.'),
        ('| blind hit |', 'PASS-CONDITIONAL', '1/79401 for ideal full399 candidate pair, one blind attempt only.'),
        ('| quorum overlap |', 'PASS-CONDITIONAL', 'Four total members, at least two honest under bad-voter cap2.'),
    ]:
        add(proposal, anchor, verdict, finding)
    for i in range(1, 11):
        finding = 'Acknowledged limitation remains an unproved premise.'
        if i == 2:
            finding += ' Correction: even a matched-draw floor does not follow from conservation.'
        if i == 3:
            finding += ' Critical onset-budget share does not fix missing outstanding lifetime/all-cause accounting.'
        if i == 7:
            finding += ' Date-level union law does not imply a duration lower bound.'
        add(proposal, '- **G%d ' % i, 'OPEN-ACKNOWLEDGED', finding)
    for anchor, verdict, finding in [
        ('check("COUNT: count race', 'PASS-PARTIAL', 'floor budget ratio2 is correct, not a complete availability proof.'),
        ('check("COUNT: assumed share', 'PASS', 'Critical share9/51200 is correct.'),
        ('check("LOCATE: targeted-erasure', 'FAIL-INFERENCE', 'Only tests mean>4, which coexists with positive early success.'),
        ('check("LOCATE: residual blind', 'PASS-NUMBER-FAIL-PREDICATE', 'Actual1/79401 is correct; one-sided tolerance would also accept1/2.'),
        ('check("KEYSHARE:', 'PASS-CONDITIONAL', 'Determinants are nonzero; independent irreducibility and inverses checked in audit.py.'),
        ('check("QUORUM:', 'PASS-CONDITIONAL', 'Four intersection members minus two bad leaves two honest.'),
        ('control("COUNT doubling', 'PASS-NUMBER-FAIL-LABEL', '1/5120 gives upper3 but is1.6 times baseline, not double. True double gives4.'),
        ('control("LOCATE public adjacent', 'PASS-AS-MODEL', 'Public adjacent three-loss erasure is certain; hard-coded Boolean is not implementation evidence.'),
        ('control("LOCATE 600', 'PASS-PARTIAL', 'Mean comparison is not necessity/sufficiency. Complete recognizable search399/600<4 is independently bounded.'),
        ('control("COUNT shrinking', 'PASS', 'Duration1/8 gives count upper16 under the assumed cost formula.'),
    ]:
        add(checker, anchor, verdict, finding)
    safe(ROOT / 'CLAIMS.json').write_text(json.dumps({'coverage': 'All D1-D7, PL1-PL2, A1-A9, proof sections, G1-G10 and ten checker predicates', 'claims': rows}, sort_keys=True, indent=2) + '\n')
    return len(rows)


if __name__ == '__main__':
    print(json.dumps({'source_claims_mapped': build()}, sort_keys=True))
