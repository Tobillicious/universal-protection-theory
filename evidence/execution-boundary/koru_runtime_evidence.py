"""CI runtime inventory for the G3 disposable Linux research workload.

Records checked-out source hashes and selected runtime binary hashes; explicitly
NOT remote attestation, a reproducible build, full native dependency closure, or
proof that the spawned cross-UID child used exactly the same environment.
"""
import argparse
import hashlib
import importlib
import importlib.metadata
import json
import os
from pathlib import Path
import platform
import re
import stat
import subprocess
import sys


def digest_regular(path):
    """Require a regular resolved on-disk file, and report its SHA-256."""
    path = Path(path).resolve(strict=True)
    if not stat.S_ISREG(path.stat().st_mode):
        raise ValueError("not regular: " + str(path))
    h = hashlib.sha256()
    with path.open("rb") as inp:
        for block in iter(lambda: inp.read(1024 * 1024), b""):
            h.update(block)
    return {"path": str(path), "sha256": h.hexdigest()}


def source_inventory(directory):
    """Record every source .py in the pinned boundary research directory."""
    directory = Path(directory).resolve(strict=True)
    files = {}
    for path in sorted(directory.glob("*.py")):
        if path.is_symlink():
            raise ValueError("symlink source not approved: " + path.name)
        files[path.name] = digest_regular(path)["sha256"]
    required = {
        "koru_authority_owned_marker_service.py",
        "koru_no_inherited_fd_executor.py",
        "koru_emergency_hold_endpoint.py",
        "koru_authority_admission_journal.py",
        "koru_authority_effect_time_fence.py",
        "koru_fixed_entrypoint_freeze.py",
        "koru_pinned_security_dependencies.py",
    }
    if not required.issubset(files):
        raise ValueError("missing protected sources: " + str(sorted(required - set(files))))
    return files


def verify_checkout_sha(expected, directory):
    """Reject a checkout whose actual Git HEAD differs from CI's expected head."""
    root = Path(directory).resolve(strict=True).parents[1]
    actual = subprocess.run(
        ["git", "-C", str(root), "rev-parse", "--verify", "HEAD"],
        check=True, capture_output=True, text=True,
    ).stdout.strip()
    if not re.fullmatch(r"[0-9a-f]{40}", actual) or actual != expected:
        raise ValueError("checkout SHA mismatch")
    return actual


def runtime_inventory(checkout_sha, directory):
    if not re.fullmatch(r"[0-9a-f]{40}", checkout_sha):
        raise ValueError("exact checkout SHA required")
    verify_checkout_sha(checkout_sha, directory)
    if sys.platform != "linux":
        raise ValueError("Linux runtime required")
    if sys.version_info[:2] != (3, 13):
        raise ValueError("Python 3.13 required")
    version = importlib.metadata.version("cryptography")
    if version != "46.0.4":
        raise ValueError("unexpected cryptography version")
    native_modules = {}
    for name in ("_ssl", "_sqlite3", "cryptography.hazmat.bindings._rust"):
        module = importlib.import_module(name)
        module_path = getattr(module, "__file__", None)
        if not module_path:
            raise ValueError("native module has no file: " + name)
        native_modules[name] = digest_regular(module_path)
    return {
        "schema": "g3-runtime-inventory-v1",
        "claim": "observed CI process environment, not loaded-object attestation",
        "checkout_sha": checkout_sha,
        "python": {
            "version": platform.python_version(),
            "implementation": platform.python_implementation(),
            "executable": digest_regular("/proc/self/exe"),
        },
        "platform": {"system": platform.system(),
                     "release": platform.release(),
                     "machine": platform.machine()},
        "cryptography_version": version,
        "native_modules": native_modules,
        "source_sha256": source_inventory(directory),
    }


def canonical_json(record):
    return (json.dumps(record, sort_keys=True, separators=(",", ":")) + "\n").encode()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--checkout-sha", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    receipt = runtime_inventory(args.checkout_sha, Path(__file__).parent)
    destination = Path(args.output)
    if destination.is_symlink():
        raise ValueError("receipt output symlink refused")
    data = canonical_json(receipt)
    destination.write_bytes(data)
    print("G3 runtime inventory: checkout=" + args.checkout_sha +
          " receipt_sha256=" + hashlib.sha256(data).hexdigest() +
          " source_files=" + str(len(receipt["source_sha256"])))


if __name__ == "__main__":
    main()
