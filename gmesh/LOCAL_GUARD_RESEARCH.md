# Gmesh local file-action gate (research, opt-in)

A minimal **real filesystem** enforcement component, not a simulation and not a network service. It exercises actual file reads and exclusive creates under an explicitly selected local directory. Intended for **trusted orchestration of a restricted agent**, where an external OS sandbox or dedicated UID blocks all other filesystem access.

## Reproduce

From the repository root:

```sh
python3 -m unittest discover -s gmesh -p test_local_guard.py -v
```

Seven tests cover deny-by-default, explicit allow/revoke, scoped read/create, no overwrite, path traversal and symlink rejection, in-process HOLD and JSONL audit evidence. Tests use temporary directories; no peer discovery, HTTP listener, Docker or shared-network traffic.

## Illustrative local use

```python
from gmesh.local_guard import LocalFileGate

with LocalFileGate("/path/to/user-owned/allowed-dir", "/path/to/user-owned/audit.jsonl") as gate:
    gate.allow("create", "example.txt")  # Authorized operator action, not agent self-grant
    gate.create("example.txt", b"hello")
    gate.hold()                           # Prevent further operations by this instance
```

## Explicit security boundary

- **No machine-wide enforcement.** A process that can call `os.open` directly can bypass the gate. Real agents must be confined with a separate OS-level sandbox, dedicated UID and carefully scoped mounts/FDs.
- **No authentication or role separation.** The `allow`, `revoke` and `hold` methods are an operator policy API, not an agent-exposed capability. An untrusted agent must never hold this object or call `allow` itself. Connect it only to a separate trusted authority after review.
- **HOLD and permissions are process-local.** They are not persisted across process restarts. The audit file is not independently protected, signed or WORM.
- **No network access or automatic enrollment.** No discovery, beaconing or deployment is included.
- **Portable scope is limited.** Requires POSIX `dir_fd`, `O_NOFOLLOW` and `O_DIRECTORY`; intended for a disposable Linux test environment. It is not a reviewed security product.
- **No G3 guarantee.** These tests demonstrate bounded file-operation checks only, not subject-level authentic X3 verification, total coverage or physical QG.

### Next gates before deployment

1. Run in an independently sandboxed disposable Linux worker and prove the worker cannot access the directory except through a trusted broker.
2. Replace process-local mutable grants with signed, scope-limited authorization and real revocation by an independently controlled issuer.
3. Test crashes, concurrent restart, TOCTOU, open-fd transfer and fallback system calls under a documented adversarial model.
4. Only then connect authenticated evidence reports to an opt-in Gmesh relay. Avoid executing any unreviewed remote one-line installation scripts.

**Draft-only research component. Do not deploy on shared/public networks or third-party devices.**
