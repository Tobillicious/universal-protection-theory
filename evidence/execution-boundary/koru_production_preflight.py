"""Read-only Linux deployment preflight. Not an enforcement gate or launcher."""
from __future__ import annotations

import os
import stat
import sys
from dataclasses import dataclass
from pathlib import Path


class PreflightError(ValueError):
    """Unsafe or incomplete production identity / directory configuration."""


@dataclass(frozen=True)
class PrincipalPlan:
    issuer_uid: int
    controller_uid: int
    broker_uid: int
    writer_uid: int

    def validate(self) -> None:
        values = (self.issuer_uid, self.controller_uid,
                  self.broker_uid, self.writer_uid)
        if any(type(uid) is not int or uid <= 0 for uid in values):
            raise PreflightError("all four identities must be explicit non-root UIDs")
        if len(set(values)) != 4:
            raise PreflightError("issuer/controller/broker/writer must use distinct UIDs")


def _private_dir(path: str, uid: int, *, label: str) -> Path:
    """Inspect each component without following symlinks. Never create paths."""
    if not isinstance(path, str) or not path or not os.path.isabs(path):
        raise PreflightError(f"{label}: absolute directory required")
    p = Path(path)
    if ".." in p.parts or "." in p.parts:
        raise PreflightError(f"{label}: dot path segments forbidden")
    current = Path("/")
    for part in p.parts[1:]:
        current = current / part
        try:
            info = os.lstat(current)
        except OSError as exc:
            raise PreflightError(f"{label}: component unavailable: {current}") from exc
        if not stat.S_ISDIR(info.st_mode):
            raise PreflightError(f"{label}: non-directory or symlink: {current}")
        if current != p and info.st_mode & 0o022:
            raise PreflightError(f"{label}: writable ancestor: {current}")
    info = os.lstat(p)
    if info.st_uid != uid or (info.st_mode & 0o777) != 0o700:
        raise PreflightError(f"{label}: require owner UID {uid} and mode 0700")
    return p


def check_production_plan(
    principals: PrincipalPlan, *, marker_directory: str, database_directory: str,
) -> dict[str, str]:
    """Validate a planned layout; snapshot only, not race-safe runtime enforcement."""
    if sys.platform != "linux":
        raise PreflightError("Linux required")
    principals.validate()
    marker = _private_dir(marker_directory, principals.writer_uid, label="marker")
    database = _private_dir(database_directory, principals.broker_uid, label="database")
    if marker == database or marker in database.parents or database in marker.parents:
        raise PreflightError("marker and database directories must be disjoint")
    return {"status": "preflight_passed_not_certified",
            "marker_directory": str(marker), "database_directory": str(database)}
