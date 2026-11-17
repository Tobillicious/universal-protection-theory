"""Strict allowlist for the Lean compiler's declaration-level axiom reports.

Logical theorem parameters are not axioms. This audit does not discharge them.
The report must contain exactly the registered declarations, once each.
"""
import re

ALLOWED_AXIOMS = frozenset({"propext", "Classical.choice", "Quot.sound"})
REPORT = re.compile(
    r"'([^'\n]+)' (?:does not depend on any axioms|"
    r"depends on axioms:\s*\[([^\]]*)\])"
)


def verify_axiom_reports(output, expected):
    expected = list(expected)
    if len(set(expected)) != len(expected):
        raise ValueError("Duplicate declaration in audit registry")
    reports = {}
    for match in REPORT.finditer(output):
        name = match.group(1)
        if name in reports:
            raise ValueError("Duplicate compiler report: " + name)
        axioms = frozenset(
            a.strip() for a in (match.group(2) or "").split(",") if a.strip()
        )
        unexpected = axioms - ALLOWED_AXIOMS
        if unexpected:
            raise ValueError("Unexpected axiom dependency in " + name + ": " +
                             ", ".join(sorted(unexpected)))
        reports[name] = sorted(axioms)
    missing = set(expected) - set(reports)
    extra = set(reports) - set(expected)
    if missing or extra:
        raise ValueError("Audit declaration mismatch: missing=" +
                         repr(sorted(missing)) + " extra=" + repr(sorted(extra)))
    if not reports:
        raise ValueError("No compiler axiom reports")
    return reports
