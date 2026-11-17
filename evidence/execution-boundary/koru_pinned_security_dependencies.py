"""Pinned direct security dependencies for the G3 fixed-marker research workload.

This detects direct-dependency source drift; it is NOT complete mediation,
a proof of dependency semantics, or a transitive dependency closure.
New reviews must update fingerprints and add adversarial tests explicitly.
"""
import ast
import hashlib
import stat
from pathlib import Path

from koru_fixed_workload_contract import verify_checkout as verify_source_contract

ROOT = Path(__file__).resolve().parent
# Git blob fingerprints from the reviewed PR #572 stacked checkout.
# Git blob SHA-1 binds exact bytes including comments/formatting.
PINNED = {
    "koru_seccomp_fd_receive_fence.py": "5ae5d10ed095e84a7c96df40a0045cc396fbe435",
    "koru_landlock_write_fence.py": "e520662ab97414601e6f157cfe0bed3aa59e0916",
    "koru_executor_fd_startup_audit.py": "cf1295d20b213e9b5a97dd7d5800d7b3125c419c",
    "koru_authority_admission_journal.py": "fd9fc9a34c533965ca816febd2b30fdfe0d3ded7",
    "koru_authority_effect_time_fence.py": "75a93ee0f52eba98bfccffe4912915091abb3d11",
    "koru_transactional_hold_witness.py": "5125f7992e6c18e72efbc50c1f90fb0789ad2422",
    "koru_bounded_server.py": "fbad1843590704fd2bc20bd9baafb7cda3df2684",
    "koru_authority_reserved_workers.py": "597533bc641ea873e163a52fdb35d26a6ecc3945",
    "koru_emergency_hold_endpoint.py": "d85f7c0da56c5576dc4180704e1572eed47f6626",
}
DIRECT_IMPORTS = {
    "koru_no_inherited_fd_executor.py": {
        ("koru_seccomp_fd_receive_fence", "SECCOMP_CHILD_CODE"),
        ("koru_landlock_write_fence", "LANDLOCK_CHILD_CODE"),
        ("koru_executor_fd_startup_audit", "FD_AUDIT_CHILD_CODE"),
    },
    "koru_emergency_hold_endpoint.py": {
        ("koru_bounded_server", "read_framed_request"),
        ("koru_authority_reserved_workers", "ReservedAuthorityThreadingMixIn"),
    },
    "koru_authority_owned_marker_service.py": {
        ("koru_authority_admission_journal", "AuthorityAdmissionJournal"),
        ("koru_authority_effect_time_fence", "AuthorityEffectTimeFence"),
        ("koru_transactional_hold_witness", "TransactionalHoldWitness"),
        ("koru_bounded_server", "read_framed_request"),
        ("koru_authority_reserved_workers", "ReservedAuthorityThreadingMixIn"),
    },
}


def git_blob_sha(data):
    """Hash exact file bytes using Git's standard blob-object framing."""
    return hashlib.sha1(b"blob " + str(len(data)).encode("ascii") +
                        b"\0" + data).hexdigest()


def _local_imports(source):
    imports = []
    for node in ast.walk(ast.parse(source)):
        if isinstance(node, ast.ImportFrom) and node.module and node.module.startswith("koru_"):
            if node.level or len(node.names) != 1 or node.names[0].asname:
                raise ValueError("local import shape changed")
            imports.append((node.module, node.names[0].name))
        elif isinstance(node, ast.Import):
            for alias in node.names:
                if alias.name.startswith("koru_"):
                    raise ValueError("unreviewed local import")
    return imports


def verify_dependency_sources(dependencies, entrypoints):
    """Reject changes to any reviewed direct security import or its binding."""
    if set(dependencies) != set(PINNED):
        raise ValueError("dependency file set changed")
    if set(entrypoints) != set(DIRECT_IMPORTS):
        raise ValueError("entrypoint file set changed")
    for name, digest in PINNED.items():
        data = dependencies[name]
        if type(data) is not bytes or git_blob_sha(data) != digest:
            raise ValueError("security dependency drift: " + name)
    for name, expected in DIRECT_IMPORTS.items():
        source = entrypoints[name]
        if type(source) is not str:
            raise ValueError("entrypoint must be Python source: " + name)
        actual = _local_imports(source)
        if len(actual) != len(expected) or set(actual) != expected:
            # Import names and bindings, not harmless source-order changes, are pinned.
            raise ValueError("security dependency import drift: " + name)
    return True


def _read_regular_file(root, filename):
    path = root / filename
    if path.is_symlink():
        raise ValueError("security file symlink forbidden: " + filename)
    mode = path.stat().st_mode
    if not stat.S_ISREG(mode):
        raise ValueError("security file must be regular: " + filename)
    return path.read_bytes()


def verify_checkout(root=ROOT):
    root = Path(root)
    dependencies = {name: _read_regular_file(root, name) for name in PINNED}
    entrypoints = {
        name: _read_regular_file(root, name).decode("utf-8")
        for name in DIRECT_IMPORTS
    }
    verify_dependency_sources(dependencies, entrypoints)
    # Existing #572 source contract must continue to pass independently.
    if root == ROOT:
        verify_source_contract()
    return True


if __name__ == "__main__":
    verify_checkout()
    print("direct security dependency source contract verified")
