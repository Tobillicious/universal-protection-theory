#!/usr/bin/env python3
"""Fail-closed IR136 documentation/claim audit, not physical calibration."""
import copy
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parent
EXPECTED={
    "schema_version":1,
    "formal_module":"PhysicalBridges.IR136",
    "claim_status":"CONDITIONAL_THREE_CHANNEL_MODEL",
    "os_test_scope":"DISPOSABLE_LINUX_ROOT_BROKER_NOBODY_DELEGATED_FD",
    "global_no_bypass_status":"OPEN_EXTERNAL",
    "original_upt_x3":"OPEN",
}
OUTCOMES={
    "post_hold_path_open":"DENIED",
    "post_hold_broker_write":"DENIED",
    "post_hold_delegated_fd_write":"SUCCEEDED_BYPASS",
    "post_hold_no_delegated_fd":"DENIED",
}
LEAN_ANCHORS=(
    "WriteCapabilities","pathOpen","writableFD","brokerPermit",
    "denied_iff_all_channels_denied",
    "actual_effect_denied_under_complete_channel_cut",
    "post_hold_path_denial_allows_delegated_fd",
    "revoked_path_does_not_revoke_existing_fd",
)
TEST_ANCHORS=(
    "pass_fds=","os.setuid","os.setgid",
    "delegated-fd-after-hold","hold_ack_ns","DENIED",
)

def verify(doc,lean,script):
    for field,value in EXPECTED.items():
        if doc.get(field)!=value:
            raise ValueError("scope/physical claim overpromoted: "+field)
    if doc.get("verified_test_outcomes")!=OUTCOMES:
        raise ValueError("inherited FD bypass omitted or revised")
    todo=doc.get("explicitly_unchecked")
    if not isinstance(todo,list) or len(todo)<6 or not all(
        isinstance(x,str) and x for x in todo
    ):
        raise ValueError("undischarged capability/physical obligations removed")
    for term in LEAN_ANCHORS:
        if term not in lean:
            raise ValueError("missing Lean theorem or independent capability: "+term)
    for term in TEST_ANCHORS:
        if term not in script:
            raise ValueError("missing OS probe/negative control: "+term)
    return len(todo)

def test_mutations(doc,lean,script):
    def reject(value,title,l=lean,p=script):
        try:
            verify(value,l,p)
        except ValueError:
            return
        raise AssertionError("claim gate failed open: "+title)
    for field,value in (
        ("global_no_bypass_status","VERIFIED"),
        ("original_upt_x3","PROVED"),
        ("os_test_scope","ALL_PHYSICAL_CHANNELS"),
    ):
        m=copy.deepcopy(doc)
        m[field]=value
        reject(m,field)
    m=copy.deepcopy(doc)
    m["verified_test_outcomes"]["post_hold_delegated_fd_write"]="DENIED"
    reject(m,"false post-HOLD descriptor closure")
    m=copy.deepcopy(doc)
    m["explicitly_unchecked"]=[]
    reject(m,"deleted physical obligations")
    reject(doc,"deleted Lean FD counterexample",l=lean.replace(
        "post_hold_path_denial_allows_delegated_fd","missing"))
    reject(doc,"deleted OS fd transfer",p=script.replace("pass_fds=","removed"))

if __name__=="__main__":
    doc=json.loads((ROOT/"ir136-descriptor-capability-ledger.json").read_text())
    lean=(ROOT/"PhysicalBridges"/"IR136DescriptorCapabilityCut.lean").read_text()
    script=(ROOT/"check_ir136_inherited_fd.py").read_text()
    count=verify(doc,lean,script)
    test_mutations(doc,lean,script)
    print("IR136 OS path denial: TRUE for tested unprivileged UID")
    print("IR136 inherited FD bypass: TRUE for delegated FD after HOLD")
    print("IR136 no-delegation control: outsider direct path still denied")
    print("Global physical/Upt protection: OPEN")
    print("Undischarged scope/physics obligations:",count)
    print("Seven adverse promotion-mutant controls: PASS")
