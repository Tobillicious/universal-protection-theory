"""Conservative exact-source freeze for the two G3 fixed-workload entrypoints.

This forbids adding unreviewed executable effects *anywhere* in the two entrypoint
modules while retaining the #572 structural source checks and #573 direct
dependency pins. A deliberate source change requires review and updated pins.
It is not a proof of effects, Python/runtime behavior, kernel isolation, or
the complete transitive dependency closure.
"""
import stat
from pathlib import Path

from koru_fixed_workload_contract import verify_checkout as verify_original_contract
from koru_pinned_security_dependencies import (
    ROOT, git_blob_sha, verify_checkout as verify_direct_dependencies,
)

REVIEWED_ENTRYPOINT_BLOBS = {
    "koru_authority_owned_marker_service.py":
        "3b183a64b1f523eb01c84c2f09293e4c2e723010",
    # Re-pinned for the reviewed -I -S + HOME child launch change (was 7a62825d).
    "koru_no_inherited_fd_executor.py":
        "e04fce79dc12a4c92761c383021aae1bbcad52fb",
}


def verify_entrypoint_sources(sources):
    """Reject all source edits, including otherwise invisible side effects."""
    if set(sources) != set(REVIEWED_ENTRYPOINT_BLOBS):
        raise ValueError("fixed entrypoint set changed")
    for name, expected in REVIEWED_ENTRYPOINT_BLOBS.items():
        data = sources[name]
        if type(data) is not bytes or git_blob_sha(data) != expected:
            raise ValueError("unreviewed fixed entrypoint drift: " + name)
    return True


def _read_exact(root, filename):
    path = root / filename
    if path.is_symlink() or not stat.S_ISREG(path.stat().st_mode):
        raise ValueError("fixed entrypoint must be regular, not symlink")
    return path.read_bytes()


def verify_checkout(root=ROOT):
    root = Path(root)
    verify_entrypoint_sources({
        name: _read_exact(root, name)
        for name in REVIEWED_ENTRYPOINT_BLOBS
    })
    verify_direct_dependencies(root)
    if root == ROOT:
        verify_original_contract()
    return True


if __name__ == "__main__":
    verify_checkout()
    print("reviewed G3 entrypoint source freeze verified")
