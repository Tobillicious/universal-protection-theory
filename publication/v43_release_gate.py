"""v4.3 research candidate: validate RO-Crate inventory and lock real binary outputs.

Does not compile Lean, create release artifacts, or publish an archive.
"""
import argparse
import hashlib
import json
import re
from pathlib import Path

HASH_LINE = re.compile(r'^([0-9a-f]{64})  ([^\n]+)$')


def validate_crate(root, manifest):
    root = Path(root).resolve()
    payload = json.loads(Path(manifest).read_text(encoding='utf8'))
    if payload.get('@context') != 'https://w3id.org/ro/crate/1.1/context':
        raise ValueError('RO-Crate context missing')
    graph = payload.get('@graph')
    if type(graph) is not list or len(graph) < 3:
        raise ValueError('invalid RO-Crate graph')
    by_id = {}
    for node in graph:
        if type(node) is not dict or type(node.get('@id')) is not str:
            raise ValueError('invalid node')
        if node['@id'] in by_id:
            raise ValueError('duplicate graph ID')
        by_id[node['@id']] = node
    meta = by_id.get('ro-crate-metadata.json')
    root_node = by_id.get('./')
    if (not meta or meta.get('about') != {'@id': './'} or
            not root_node or 'Dataset' not in root_node.get('@type', [])):
        raise ValueError('missing root dataset and metadata descriptor')
    refs = root_node.get('hasPart', [])
    if not isinstance(refs, list) or not refs:
        raise ValueError('empty hasPart inventory')
    covered = set()
    for item in refs:
        if type(item) is not dict or set(item) != {'@id'}:
            raise ValueError('invalid file reference')
        name = item['@id']
        if (not isinstance(name, str) or name in covered or
                name.startswith(('/', './', '../')) or '\\' in name):
            raise ValueError('invalid or repeated file path')
        covered.add(name)
        if name not in by_id or by_id[name].get('@type') != 'File':
            raise ValueError('missing File node')
        target = root / name
        if (not target.is_file() or target.is_symlink() or
                not target.resolve().is_relative_to(root)):
            raise ValueError(f'missing/unsafe referenced file: {name}')
    return len(covered)



def validate_replay_spec(root, path, *, require_sealed=False):
    """Validate replay declarations, without claiming a container was run."""
    root = Path(root).resolve()
    spec = json.loads(Path(path).read_text(encoding="utf8"))
    required = {"schema", "status", "working_directory", "build_command",
                "toolchain_file", "dependency_lock_file",
                "container_image_digest", "compiled_artifact_sha256_manifest",
                "release_blockers"}
    if type(spec) is not dict or set(spec) != required:
        raise ValueError("invalid container replay schema")
    if spec["schema"] != "upt-v43-container-replay-v1":
        raise ValueError("unsupported replay schema")
    if spec["working_directory"] != "evidence/physical-bridges":
        raise ValueError("unexpected Lean working directory")
    if spec["build_command"] != ["lake", "build"]:
        raise ValueError("unexpected build command")
    for key in ("toolchain_file", "dependency_lock_file"):
        item = spec[key]
        if type(item) is not str or item.startswith(("/", "../", "./")):
            raise ValueError("invalid replay input path")
        full = root / item
        if not full.is_file() or full.is_symlink() or not full.resolve().is_relative_to(root):
            raise ValueError("missing replay input")
    digest = spec["container_image_digest"]
    sealed = (type(digest) is str and
              re.fullmatch(r"sha256:[0-9a-f]{64}", digest) is not None)
    if require_sealed and not sealed:
        raise ValueError("container image is not immutable-digest pinned")
    if not sealed and (spec["status"] != "UNSEALED" or not spec["release_blockers"]):
        raise ValueError("unsealed replay must advertise its blockers")
    return sealed


def files_to_lock(root):
    root = Path(root).resolve()
    if not root.is_dir():
        raise ValueError('artifact directory missing')
    output = []
    for item in sorted(root.rglob('*')):
        if item.is_symlink():
            raise ValueError('symlink inside compiled artifacts')
        if item.is_file() and item.name != 'SHA256SUMS':
            if not item.resolve().is_relative_to(root):
                raise ValueError('outside artifact root')
            output.append(item)
    if not any(p.suffix == '.olean' for p in output):
        raise ValueError('no compiled .olean files; refusing source-only release lock')
    return root, output


def lock(root):
    root, files = files_to_lock(root)
    rows = []
    for item in files:
        digest = hashlib.sha256(item.read_bytes()).hexdigest()
        rows.append(f'{digest}  {item.relative_to(root).as_posix()}')
    (root / 'SHA256SUMS').write_text('\n'.join(rows) + '\n', encoding='ascii')
    return len(rows)


def verify(root):
    root, files = files_to_lock(root)
    manifest = root / 'SHA256SUMS'
    if not manifest.is_file() or manifest.is_symlink():
        raise ValueError('checksum manifest missing')
    expected = {}
    for row in manifest.read_text(encoding='ascii').splitlines():
        m = HASH_LINE.fullmatch(row)
        if m is None or m.group(2) in expected:
            raise ValueError('invalid or duplicate checksum entry')
        expected[m.group(2)] = m.group(1)
    if set(expected) != {p.relative_to(root).as_posix() for p in files}:
        raise ValueError('missing or unexpected compiled artifacts')
    for p in files:
        rel = p.relative_to(root).as_posix()
        if hashlib.sha256(p.read_bytes()).hexdigest() != expected[rel]:
            raise ValueError(f'checksum mismatch: {rel}')
    return len(files)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('action', choices=('crate', 'replay-structure', 'replay-ready', 'lock', 'verify'))
    parser.add_argument('path', help='repo root for crate; compiled artifact root for lock/verify')
    parser.add_argument('--manifest', default='ro-crate-metadata.json')
    args = parser.parse_args()
    if args.action == 'crate':
        print(f'RO-Crate listed files verified: {validate_crate(args.path, Path(args.path) / args.manifest)}')
    elif args.action in ("replay-structure", "replay-ready"):
        path = Path(args.path) / "publication/v43-container-replay.json"
        sealed = validate_replay_spec(
            args.path, path, require_sealed=args.action == "replay-ready")
        print("Container replay image pinned: " + str(sealed))
    elif args.action == 'lock':
        print(f'Compiled artifacts locked: {lock(args.path)}')
    else:
        print(f'Compiled artifacts verified: {verify(args.path)}')


if __name__ == '__main__':
    main()
