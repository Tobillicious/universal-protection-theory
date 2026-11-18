"""Read-only Docker inspect gate for a *proposed* isolated Zelda executor.

This is a static configuration check, NOT a runtime sandbox or an effect
authorization. Does not access Docker, restart containers, inspect volumes,
prove absence of alternate host channels, or establish real-world G3.
"""
import argparse
import json
from pathlib import Path
import re
import sys

MAX_BYTES = 1024 * 1024
SHA = re.compile(r"sha256:[0-9a-f]{64}\Z")


def _object(pairs):
    result = {}
    for k, v in pairs:
        if k in result:
            raise ValueError("duplicate JSON key")
        result[k] = v
    return result


def inspect_executor(config, *, container_name, state_volume, state_mount_destination):
    if type(config) is not dict:
        raise ValueError("Docker inspect container object required")
    if type(container_name) is not str or not container_name:
        raise ValueError("pinned container name required")
    if type(state_volume) is not str or not state_volume:
        raise ValueError("pinned persistent volume required")
    # The independently supplied destination must not be allowed to
    # self-authorize an overlay anywhere below the executable/runtime trees.
    # A correct volume name alone cannot make a code mount safe.
    protected_roots = (
        "/engine", "/usr", "/etc", "/bin", "/sbin", "/lib", "/lib64",
        "/proc", "/sys", "/dev", "/run", "/boot", "/opt",
    )
    if (type(state_mount_destination) is not str or
            not state_mount_destination.startswith("/") or
            any(component in ("", ".", "..") for component in
                state_mount_destination.split("/")[1:]) or
            any(state_mount_destination == root or
                state_mount_destination.startswith(root + "/")
                for root in protected_roots)):
        raise ValueError("explicit non-code absolute state mount destination required")
    gaps = []
    if config.get("Name") != "/" + container_name:
        gaps.append("container_identity_mismatch")
    image = config.get("Image")
    if type(image) is not str or not SHA.fullmatch(image):
        gaps.append("unverified_image_digest")
    c = config.get("Config")
    h = config.get("HostConfig")
    if type(c) is not dict or type(h) is not dict:
        raise ValueError("Config and HostConfig required")
    user = c.get("User")
    if type(user) is not str or not re.fullmatch(r"[1-9][0-9]*(?::[1-9][0-9]*)?", user):
        gaps.append("non_pinned_nonroot_user")
    if h.get("Privileged") is not False:
        gaps.append("privileged_or_unknown")
    if h.get("ReadonlyRootfs") is not True:
        gaps.append("writable_root_filesystem")
    if h.get("NetworkMode") != "none":
        gaps.append("network_not_disabled")
    if h.get("PidMode") not in ("", "private"):
        gaps.append("shared_pid_namespace")
    if h.get("IpcMode") not in ("", "private"):
        gaps.append("shared_ipc_namespace")
    if h.get("UsernsMode") == "host":
        gaps.append("host_user_namespace")
    if h.get("CapAdd") not in (None, []):
        gaps.append("added_linux_capabilities")
    caps = h.get("CapDrop")
    if type(caps) is not list or "ALL" not in caps:
        gaps.append("linux_capabilities_not_dropped")
    sec = h.get("SecurityOpt")
    if type(sec) is not list or "no-new-privileges:true" not in sec:
        gaps.append("new_privileges_not_prohibited")
    if type(sec) is not list:
        gaps.append("security_options_invalid")
    elif any(type(x) is not str or
             "seccomp=unconfined" in x or "apparmor=unconfined" in x
             for x in sec):
        gaps.append("confinement_unconfined")
    if h.get("Devices") not in (None, []):
        gaps.append("host_devices_exposed")
    if h.get("Binds") not in (None, []):
        gaps.append("host_bind_mounts")
    if h.get("PortBindings") not in (None, {}):
        gaps.append("published_ports")
    if c.get("ExposedPorts") not in (None, {}):
        gaps.append("container_exposed_ports")
    if h.get("PidsLimit") is None or type(h.get("PidsLimit")) is not int or not 1 <= h["PidsLimit"] <= 64:
        gaps.append("process_limit_missing")
    if type(h.get("Memory")) is not int or h["Memory"] < 64 * 1024 * 1024:
        gaps.append("memory_limit_missing")
    restart = h.get("RestartPolicy")
    if type(restart) is not dict or restart.get("Name") != "no":
        gaps.append("uncontrolled_restart_policy")
    mounts = config.get("Mounts")
    if type(mounts) is not list:
        raise ValueError("Docker Mounts inventory required")
    expected = [m for m in mounts if type(m) is dict and
                m.get("Type") == "volume" and m.get("Name") == state_volume and
                m.get("RW") is True and
                m.get("Destination") == state_mount_destination]
    if len(expected) != 1 or len(mounts) != 1:
        gaps.append("unexpected_or_missing_persistent_mount")
    if type(c.get("Env")) is not list or not all(type(x) is str for x in c["Env"]):
        gaps.append("environment_unverifiable")
    else:
        if any(x.split("=", 1)[0] in ("DOCKER_HOST", "DOCKER_TLS_VERIFY",
                                      "AWS_SECRET_ACCESS_KEY", "GITHUB_TOKEN")
               for x in c["Env"]):
            gaps.append("docker_or_secret_environment")
    return {
        "status": "RESEARCH_CONFIGURATION_GAPS" if gaps else "RESEARCH_STATIC_REVIEW_REQUIRED",
        "gaps": sorted(set(gaps)),
        "authorizes_start": False,
        "authorizes_effect": False,
        "certified_for_production": False,
        "live_runtime_verified": False,
    }


def inspect_bytes(raw, *, container_name, state_volume, state_mount_destination):
    if type(raw) is not bytes or not 0 < len(raw) <= MAX_BYTES:
        raise ValueError("empty or oversized Docker inspection")
    try:
        packet = json.loads(raw.decode("utf-8"), object_pairs_hook=_object)
    except (UnicodeDecodeError, json.JSONDecodeError) as e:
        raise ValueError("invalid Docker inspect JSON") from e
    if type(packet) is not list or len(packet) != 1:
        raise ValueError("exactly one Docker inspect container required")
    return inspect_executor(packet[0], container_name=container_name,
                            state_volume=state_volume,
                            state_mount_destination=state_mount_destination)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--inspect", required=True, type=Path)
    ap.add_argument("--container", required=True)
    ap.add_argument("--state-volume", required=True)
    ap.add_argument("--state-mount-destination", required=True,
                    help="independently reviewed internal data-only mountpoint")
    args = ap.parse_args()
    try:
        if args.inspect.is_symlink() or args.inspect.stat().st_size > MAX_BYTES:
            raise ValueError("unsafe inspect input")
        result = inspect_bytes(args.inspect.read_bytes(),
                               container_name=args.container,
                               state_volume=args.state_volume,
                               state_mount_destination=args.state_mount_destination)
    except (ValueError, OSError) as err:
        print("Zelda Docker static preflight refused: " + str(err), file=sys.stderr)
        return 1
    print(json.dumps(result, sort_keys=True))
    return 0 if not result["gaps"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
