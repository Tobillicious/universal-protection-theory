#!/usr/bin/env python3
"""Fail-closed integrity audit for IR-137: kernel object != real effects."""
import copy
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parent
BASE={
    "schema_version":1,
    "formal_theorem":"PhysicalBridges.IR137.all_finite_real_traces_preserve_sealed_bound_effect",
    "status":"CONDITIONAL_IDENTIFIED_OBJECT",
    "os_scope":"LINUX_ANONYMOUS_VOLATILE_MEMFD_ONE_OBJECT",
    "physical_installation":"NOT_ESTABLISHED",
    "original_x3":"OPEN",
}
OUTCOMES={
    "strong_seal_root_fd":"DENIED",
    "strong_seal_delegated_unprivileged_fd":"DENIED",
    "strong_seal_new_shared_mapping":"DENIED",
    "strong_seal_truncate":"DENIED",
    "strong_seal_old_mapping_installed":"EBUSY",
    "weak_future_write_old_mapping":"WRITABLE",
    "privileged_alternate_output_object":"POSSIBLE",
}
OBLIGATIONS={
    "object_binding","all_effect_source_paths","no_live_mappings_at_seal",
    "trusted_kernel_and_hardware","physical_measurement",
    "original_upt_x3_and_temporal",
}
LEAN_ANCHORS=(
    "SealedOutputContract",
    "sealPersists","sealedObjectStable","outputBindingStable",
    "realEffectReadoutFaithful",
    "one_real_step_after_seal_preserves_bound_effect",
    "all_finite_real_traces_preserve_sealed_bound_effect",
    "sealed_original_object_does_not_prevent_output_substitution",
    "future_write_only_does_not_revoke_old_mapping"
)
OS_ANCHORS=(
    "os.memfd_create","F_SEAL_WRITE","F_SEAL_SHRINK",
    "F_SEAL_GROW","F_SEAL_SEAL","F_SEAL_FUTURE_WRITE",
    "pass_fds","os.setuid","mmap.MAP_SHARED",
    "strongly sealed original object",
    "privileged actor can create different output object"
)

def check(data,lean,probe,prev):
    for name,expected in BASE.items():
        if data.get(name)!=expected:
            raise ValueError("IR137 overpromotion or changed declared scope: "+name)
    if data.get("test_outcomes")!=OUTCOMES:
        raise ValueError("OS negative control erased/overpromoted")
    rows=data.get("obligations")
    if not isinstance(rows,list) or len(rows)!=len(OBLIGATIONS):
        raise ValueError("missing independently required physical join")
    if {r.get("id") for r in rows if isinstance(r,dict)} != OBLIGATIONS:
        raise ValueError("renamed or duplicate physical join")
    if any(r.get("status")!="OPEN_EXTERNAL" or
           not isinstance(r.get("meaning"),str) or not r["meaning"]
           for r in rows):
        raise ValueError("unreviewed physical evidence declared complete")
    for term in LEAN_ANCHORS:
        if term not in lean:
            raise ValueError("missing Lean anchor "+term)
    for term in OS_ANCHORS:
        if term not in probe:
            raise ValueError("missing OS test or negative "+term)
    if prev.get("global_no_bypass_status")!="OPEN_EXTERNAL":
        raise ValueError("inherited descriptor source gap silently closed")
    return len(rows)

def negative_controls(d,lean,probe,prev):
    def reject(value,label,l=lean,p=probe,earlier=prev):
        try: check(value,l,p,earlier)
        except ValueError: return
        raise AssertionError("IR137 fail-open: "+label)
    for key,val in (
        ("status","PROVED_PHYSICAL"),
        ("physical_installation","COMPLETE"),
        ("original_x3","PROVED"),
        ("os_scope","EVERY_ACTUATOR"),
    ):
        v=copy.deepcopy(d);v[key]=val;reject(v,key)
    v=copy.deepcopy(d)
    v["test_outcomes"]["weak_future_write_old_mapping"]="DENIED"
    reject(v,"weak seal misrepresented as strong")
    v=copy.deepcopy(d)
    v["test_outcomes"]["privileged_alternate_output_object"]="IMPOSSIBLE"
    reject(v,"output substitution omitted")
    v=copy.deepcopy(d)
    v["obligations"]=[x for x in v["obligations"] if x["id"]!="object_binding"]
    reject(v,"object binding deleted")
    reject(d,"substitution countermodel deleted",l=lean.replace(
        "sealed_original_object_does_not_prevent_output_substitution","omitted"))
    reject(d,"old writable mmap test deleted",p=probe.replace(
        "mmap.MAP_SHARED","omitted"))

if __name__=="__main__":
    ledger=json.loads((ROOT/"ir137-kernel-seal-ledger.json").read_text())
    prev=json.loads((ROOT/"ir136-descriptor-capability-ledger.json").read_text())
    lean=(ROOT/"PhysicalBridges"/"IR137KernelSealedObject.lean").read_text()
    probe=(ROOT/"check_ir137_kernel_seals.py").read_text()
    n=check(ledger,lean,probe,prev)
    negative_controls(ledger,lean,probe,prev)
    print("IR137 strong seal: only authenticated memfd object, subject to kernel premise")
    print("Original effect authority and all real-world output binding: OPEN_EXTERNAL")
    print("Nine negative evidence/claim promotion controls: PASS")
    print("Open independent physical proof obligations:",n)
