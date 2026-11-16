"""Pin reviewed second-hop local dependencies of the fixed G3 authority path.

This is a conservative source provenance check, not a transitive runtime
attestation or a proof of Python execution or effect mediation.
"""
import ast
from pathlib import Path

from koru_pinned_security_dependencies import ROOT, git_blob_sha
from koru_fixed_entrypoint_freeze import verify_checkout as verify_parent

PINNED_SECOND_HOP = {
    "koru_durable_effect_intent.py": "601d2e2be61f8e10ce2445ffdb0e5aa519d865ef",
    "koru_transaction_scoped_effect.py": "d6f22db5b4178702c55ba65b296325f573b87c96",
}
IMPORT_CONTRACTS = {
    "koru_authority_admission_journal.py": {
        ("koru_durable_effect_intent", "DurableEffectIntentBoundary"),
        ("koru_transaction_scoped_effect", "_exact_unheld"),
        ("koru_transactional_hold_witness", "TransactionalHoldWitness"),
    },
    "koru_authority_effect_time_fence.py": {
        ("koru_authority_admission_journal", "AuthorityAdmissionJournal"),
        ("koru_durable_effect_intent", "DurableEffectIntentBoundary"),
        ("koru_transaction_scoped_effect", "_exact_unheld"),
    },
    "koru_durable_effect_intent.py": {
        ("koru_transaction_scoped_effect", "_exact_unheld"),
        ("koru_transactional_hold_witness", "TransactionalHoldWitness"),
    },
    "koru_transaction_scoped_effect.py": {
        ("koru_transactional_hold_witness", "TransactionalHoldWitness"),
    },
}


def _imports(source):
    tree = ast.parse(source)
    result = []
    for node in ast.walk(tree):
        if isinstance(node, ast.ImportFrom) and node.module and node.module.startswith("koru_"):
            if node.level != 0:
                raise ValueError("relative local import not reviewed")
            for alias in node.names:
                if alias.asname or alias.name == "*":
                    raise ValueError("aliased local import not reviewed")
                result.append((node.module, alias.name))
        elif isinstance(node, ast.Import):
            if any(alias.name.startswith("koru_") for alias in node.names):
                raise ValueError("direct local import not reviewed")
    return result


def verify_second_hop_sources(contents, import_sources):
    if set(contents) != set(PINNED_SECOND_HOP):
        raise ValueError("second-hop dependency set changed")
    if set(import_sources) != set(IMPORT_CONTRACTS):
        raise ValueError("second-hop import-owner set changed")
    for name, expected in PINNED_SECOND_HOP.items():
        data = contents[name]
        if type(data) is not bytes or git_blob_sha(data) != expected:
            raise ValueError("second-hop dependency drift: " + name)
    for name, expected in IMPORT_CONTRACTS.items():
        source = import_sources[name]
        if type(source) is not str:
            raise ValueError("second-hop import source must be text: " + name)
        actual = _imports(source)
        if len(actual) != len(expected) or set(actual) != expected:
            raise ValueError("second-hop import drift: " + name)
    return True


def _read(root, name):
    path = root / name
    if path.is_symlink() or not path.is_file():
        raise ValueError("second-hop source is not a regular non-symlink file: " + name)
    return path.read_bytes()


def verify_checkout(root=ROOT):
    root = Path(root)
    contents = {name: _read(root, name) for name in PINNED_SECOND_HOP}
    owners = {name: _read(root, name).decode("utf-8") for name in IMPORT_CONTRACTS}
    verify_second_hop_sources(contents, owners)
    verify_parent(root)
    return True


if __name__ == "__main__":
    verify_checkout()
    print("second-hop G3 authority security sources verified")
