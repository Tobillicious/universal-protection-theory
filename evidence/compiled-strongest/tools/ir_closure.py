#!/usr/bin/env python3
"""Dependency closure of selected IR modules in evidence/physical-bridges. Usage: ir_closure.py ROOT"""
import os
import re
import sys

root = sys.argv[1]
pb = os.path.join(root, "evidence/physical-bridges")
TARGETS = ["IRSelectedMaximality", "IRProfileAudit", "IRFiniteProfileObstruction",
           "IRInfiniteFinitaryMaximality", "IRTwoStageInfiniteLex", "IRMandatoryBaselineMaximality",
           "IRInfiniteHistoryCompactness", "IRA1NineClassComposition", "IR93GlobalComposition",
           "IR98FeasibleFamilyTransfer", "IR99ResourceImproverCoverage", "IR100PhysicalAccountingWitness",
           "IR113ObservationClassSelection", "IR116CumulativeSubjectDuties",
           "IR118InFlightBacklogBudget", "IR121MeteredResidualEscrow"]


def path(mod):
    for cand in (f"PhysicalBridges/{mod}.lean", f"{mod}.lean"):
        p = os.path.join(pb, cand)
        if os.path.exists(p):
            return p
    return None


seen, order, external = set(), [], set()


def visit(mod):
    if mod in seen:
        return
    seen.add(mod)
    p = path(mod)
    if p is None:
        external.add(mod)
        return
    for imp in re.findall(r"^import (\S+)", open(p).read(), re.M):
        if imp.startswith("PhysicalBridges."):
            visit(imp.split(".", 1)[1])
        elif imp == "Mathlib" or imp.startswith("Mathlib."):
            external.add(imp)
        else:
            visit(imp)
    order.append(mod)


for t in TARGETS:
    visit(t)
print(len(order), "modules in closure")
print(" ".join(order))
print("external/unresolved:", sorted(external))
