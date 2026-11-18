"""Hostile static Zelda executor configuration tests; no Docker access."""
import copy
import json
import unittest
from g3_zelda_docker_inspect_preflight import inspect_bytes

NAME = "upt-guardian-node"
VOLUME = "upt-guardian-node-state"
DEST = "/var/lib/upt-guardian-node-state"


class DockerPreflightTests(unittest.TestCase):
    def setUp(self):
        self.config = {
            "Name": "/" + NAME,
            "Image": "sha256:" + "a" * 64,
            "Config": {"User": "10001:10001", "Env": ["PYTHONPATH=/engine"],
                       "ExposedPorts": None},
            "HostConfig": {"Privileged": False, "ReadonlyRootfs": True,
                           "NetworkMode": "none", "PidMode": "", "IpcMode": "",
                           "UsernsMode": "", "CapAdd": None, "CapDrop": ["ALL"],
                           "SecurityOpt": ["no-new-privileges:true"],
                           "Devices": None, "Binds": None, "PortBindings": None,
                           "PidsLimit": 32, "Memory": 128 * 1024 * 1024,
                           "RestartPolicy": {"Name": "no"}},
            "Mounts": [{"Type": "volume", "Name": VOLUME, "RW": True,
                        "Destination": DEST}],
        }

    def inspect(self, obj=None):
        return inspect_bytes(json.dumps([self.config if obj is None else obj]).encode(),
                             container_name=NAME, state_volume=VOLUME,
                             state_mount_destination=DEST)

    def test_static_green_never_authorizes_launch_or_protection(self):
        result = self.inspect()
        self.assertEqual(result["status"], "RESEARCH_STATIC_REVIEW_REQUIRED")
        self.assertEqual(result["gaps"], [])
        for flag in ("authorizes_start", "authorizes_effect",
                     "certified_for_production", "live_runtime_verified"):
            self.assertFalse(result[flag])

    def test_hostile_boundary_drifts_fail(self):
        alterations = [
            ("privileged_or_unknown", ("HostConfig", "Privileged"), True),
            ("writable_root_filesystem", ("HostConfig", "ReadonlyRootfs"), False),
            ("network_not_disabled", ("HostConfig", "NetworkMode"), "host"),
            ("shared_pid_namespace", ("HostConfig", "PidMode"), "host"),
            ("shared_ipc_namespace", ("HostConfig", "IpcMode"), "host"),
            ("host_user_namespace", ("HostConfig", "UsernsMode"), "host"),
            ("added_linux_capabilities", ("HostConfig", "CapAdd"), ["SYS_ADMIN"]),
            ("linux_capabilities_not_dropped", ("HostConfig", "CapDrop"), []),
            ("new_privileges_not_prohibited", ("HostConfig", "SecurityOpt"), []),
            ("confinement_unconfined", ("HostConfig", "SecurityOpt"),
             ["no-new-privileges:true", "seccomp=unconfined"]),
            ("host_devices_exposed", ("HostConfig", "Devices"), [{"PathOnHost": "/dev/kvm"}]),
            ("host_bind_mounts", ("HostConfig", "Binds"), ["/var/run/docker.sock:/docker.sock"]),
            ("published_ports", ("HostConfig", "PortBindings"), {"8000/tcp": [{}]}),
            ("container_exposed_ports", ("Config", "ExposedPorts"), {"8000/tcp": {}}),
            ("process_limit_missing", ("HostConfig", "PidsLimit"), None),
            ("memory_limit_missing", ("HostConfig", "Memory"), 0),
            ("uncontrolled_restart_policy", ("HostConfig", "RestartPolicy"), {"Name": "always"}),
            ("non_pinned_nonroot_user", ("Config", "User"), "root"),
            ("docker_or_secret_environment", ("Config", "Env"), ["GITHUB_TOKEN=bad"]),
        ]
        for gap, path, value in alterations:
            with self.subTest(gap=gap):
                c = copy.deepcopy(self.config)
                c[path[0]][path[1]] = value
                self.assertIn(gap, self.inspect(c)["gaps"])

    def test_unexpected_mount_and_volume_mutation_fail(self):
        for mounts in ([], [{"Type": "bind", "Name": VOLUME, "RW": True}],
                       [{"Type": "volume", "Name": VOLUME, "RW": False}],
                       self.config["Mounts"] +
                       [{"Type": "bind", "Source": "/var/run/docker.sock", "RW": True}]):
            with self.subTest(mounts=mounts):
                c = copy.deepcopy(self.config)
                c["Mounts"] = mounts
                self.assertIn("unexpected_or_missing_persistent_mount",
                              self.inspect(c)["gaps"])

    def test_named_volume_over_executable_code_is_rejected(self):
        for destination in ("/engine", "/usr/local/lib/python3.13/site-packages",
                            "/", "/etc", "/var/lib/other-state"):
            with self.subTest(destination=destination):
                modified = copy.deepcopy(self.config)
                modified["Mounts"][0]["Destination"] = destination
                self.assertIn("unexpected_or_missing_persistent_mount",
                              self.inspect(modified)["gaps"])

    def test_missing_mount_destination_rejected(self):
        modified = copy.deepcopy(self.config)
        del modified["Mounts"][0]["Destination"]
        self.assertIn("unexpected_or_missing_persistent_mount",
                      self.inspect(modified)["gaps"])

    def test_invalid_expected_destination_refused(self):
        for destination in ("/", "/engine", "/engine/plugins", "/usr/local/lib",
                            "/etc/agent", "/proc/self", "/dev/shm", "/run/secrets",
                            "/opt/bin", "/tmp/../engine", "relative", "/etc",
                            "/var//lib"):
            with self.subTest(destination=destination):
                with self.assertRaisesRegex(ValueError, "state mount destination"):
                    inspect_bytes(json.dumps([self.config]).encode(),
                                  container_name=NAME, state_volume=VOLUME,
                                  state_mount_destination=destination)

    def test_forged_identity_and_image_fail(self):
        for key, val, gap in (("Name", "/another", "container_identity_mismatch"),
                              ("Image", "untagged", "unverified_image_digest")):
            c = copy.deepcopy(self.config)
            c[key] = val
            self.assertIn(gap, self.inspect(c)["gaps"])

    def test_duplicate_json_keys_and_multiple_containers_rejected(self):
        raw = json.dumps([self.config]).encode()
        duplicate = raw.replace(b'"Name":', b'"Name":"/forged", "Name":', 1)
        with self.assertRaisesRegex(ValueError, "duplicate"):
            inspect_bytes(duplicate, container_name=NAME, state_volume=VOLUME,
                             state_mount_destination=DEST)
        with self.assertRaisesRegex(ValueError, "exactly one"):
            inspect_bytes(json.dumps([self.config, self.config]).encode(),
                          container_name=NAME, state_volume=VOLUME,
                             state_mount_destination=DEST)

    def test_missing_required_configuration_rejected(self):
        c = copy.deepcopy(self.config)
        del c["HostConfig"]
        with self.assertRaisesRegex(ValueError, "HostConfig"):
            self.inspect(c)

    def test_invalid_json_rejected(self):
        with self.assertRaisesRegex(ValueError, "invalid Docker inspect JSON"):
            inspect_bytes(b"\xff", container_name=NAME, state_volume=VOLUME,
                             state_mount_destination=DEST)


if __name__ == "__main__":
    unittest.main()
