"""Bind a bounded G3 host preflight to the *live* signed writer handles.

Research deployment gate only. All paths are trusted local configuration,
not client-provided values. An apparently safe but unrelated set of files
must never satisfy the preflight of a different, active writer.

Does not provide immutable mounts, race-free path pinning throughout service
lifetime, complete Linux capability mediation or actual-world X3 evidence.
"""
import os
from pathlib import Path
import stat

from g3_host_preflight import inspect_writer_host
from g3_secure_socket import SignedFencedServer


def _same_open_inode(fd, path):
    """Compare the already-open actual inode with an inspected path."""
    a = os.fstat(fd)
    b = os.stat(path, follow_symlinks=False)
    return (a.st_dev, a.st_ino) == (b.st_dev, b.st_ino)


def _db_matches_open_connection(db, path):
    """Check the main database pathname reported by the live connection.

    SQLite does not expose its main database FD through this Python API;
    this is NOT proof that a pathname cannot be replaced concurrently.
    """
    entries = db.execute("PRAGMA database_list").fetchall()
    main = [entry[2] for entry in entries if entry[1] == 'main']
    if len(main) != 1 or not main[0]:
        return False
    source = Path(main[0])
    target = Path(path)
    # Bind the configured name to the connection-reported main DB path.
    # The separate host preflight checks the current on-disk inode.
    if source.absolute() != target.absolute():
        return False
    return os.path.samefile(source, target)


def verify_live_writer_host(writer, *, output_dir, writer_db, fence_file,
                            gate_db, mesh_db):
    """Check a non-root writer and binding to exactly the inspected resources."""
    result = inspect_writer_host(output_dir=output_dir,
                                 writer_db=writer_db, fence_file=fence_file,
                                 gate_db=gate_db, mesh_db=mesh_db)
    if not result['ok']:
        return result
    try:
        bindings = (
            _same_open_inode(writer.dirfd, output_dir) and
            _same_open_inode(writer.fence.fd, fence_file) and
            _db_matches_open_connection(writer.db, writer_db) and
            _db_matches_open_connection(writer.gate.db, gate_db) and
            _db_matches_open_connection(writer.mesh.db, mesh_db)
        )
    except (AttributeError, OSError, ValueError, TypeError):
        return {'ok': False, 'code': 'live_writer_binding_unavailable'}
    if not bindings:
        return {'ok': False, 'code': 'live_writer_binding_mismatch'}
    return {'ok': True, 'code': 'bounded_host_binding_checked',
            'certified': False, 'all_capabilities_mediated': False}


class PreflightedSignedFencedServer(SignedFencedServer):
    """Opt-in research entrypoint: reject mismatched host configuration first."""
    def __init__(self, socket_path, writer, allowed_uids, *,
                 output_dir, writer_db, fence_file, gate_db, mesh_db):
        checked = verify_live_writer_host(
            writer, output_dir=output_dir, writer_db=writer_db,
            fence_file=fence_file, gate_db=gate_db, mesh_db=mesh_db)
        if not checked['ok']:
            raise PermissionError('G3 host binding refused: ' + checked['code'])
        # SignedFencedServer enforces distinct UID, signed/fenced writer,
        # fresh-lease configuration and protected socket pathname.
        super().__init__(socket_path, writer, allowed_uids)
