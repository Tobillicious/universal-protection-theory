"""Research-only R5 forest evidence-gap checker. NEVER authorizes an effect.

The caller must supply an independently audited inventory of in-scope paths;
a finite list alone is not evidence of complete host or real-world coverage.
No runtime authority, HOLD state, or original-X3 theorem is modified.
"""
from collections.abc import Mapping

SIX = (
    "historicalContinuity", "authorization", "freedom",
    "restraint", "maximality", "provenance",
)

def audit_forest_scope(*, declared_paths, observed_paths, owed_subjects,
                       subject_evidence, external_inventory_verified=False,
                       independent_observer_verified=False):
    """Return a fail-closed research receipt; does not establish authorization.

    Missing independent inventory/observer evidence always prevents PASS.
    subject_evidence maps each owed subject to six independently sourced
    booleans. True flags remain *assertions by caller*, not verified ethics.
    """
    if (not isinstance(declared_paths, (set, frozenset))
        or not isinstance(observed_paths, (set, frozenset))
        or not isinstance(owed_subjects, (set, frozenset))
        or not isinstance(subject_evidence, Mapping)
        or any(type(x) is not str or not x for x in
               declared_paths | observed_paths | owed_subjects)
        or type(external_inventory_verified) is not bool
        or type(independent_observer_verified) is not bool):
        raise ValueError("invalid independently scoped research inventory")

    gaps = []
    if not declared_paths:
        gaps.append("empty_declared_effect_path_scope")
    if not owed_subjects:
        gaps.append("empty_owed_subject_scope")
    if not external_inventory_verified:
        gaps.append("external_effect_path_inventory_unverified")
    if not independent_observer_verified:
        gaps.append("independent_effect_observer_unverified")

    for path in sorted(observed_paths - declared_paths):
        gaps.append("unexpected_effect_path:" + path)
    for path in sorted(declared_paths - observed_paths):
        gaps.append("declared_path_not_observed:" + path)
    for subject in sorted(owed_subjects):
        evidence = subject_evidence.get(subject)
        if not isinstance(evidence, Mapping):
            gaps.append("missing_subject_evidence:" + subject)
            continue
        for field in SIX:
            if evidence.get(field) is not True:
                gaps.append("unresolved:" + subject + ":" + field)

    # Never emit 'G3 PASS': coverage over a supplied finite manifest is
    # neither a proof of complete mediation nor an authentic-subject witness.
    return {
        "status": "RESEARCH_GAPS" if gaps else "RESEARCH_SCOPE_REVIEW_REQUIRED",
        "authorizes_effect": False,
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "unresolved": gaps,
    }
