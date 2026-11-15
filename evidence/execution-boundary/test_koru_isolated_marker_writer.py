"""Negative controls for non-deploying marker-writer prototype.

These checks deliberately do NOT claim to prove an independently authorized
multi-UID signed effect path. The future integration suite must do that.
"""
import os
import tempfile
import unittest

from koru_isolated_marker_writer import (
    IsolatedMarkerWriter, WriterConfigurationError, marker_name,
)


class IsolatedWriterPrototypeTests(unittest.TestCase):
    def test_event_identity_is_hash_derived_and_no_path(self):
        value = marker_name("test-event-1")
        self.assertEqual(len(value), 71)
        self.assertTrue(value.endswith(".marker"))
        self.assertNotIn("/", value)
        self.assertNotEqual(marker_name("test-event-2"), value)

    def test_bad_event_id_rejected(self):
        for bad in ("", None, 42, [], "a" * 513):
            with self.subTest(bad=str(bad)[:25]):
                with self.assertRaises(ValueError):
                    marker_name(bad)

    def test_root_or_same_uid_writer_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            # Root is prohibited regardless of broker UID; for a non-root
            # runner the identical UID violates principal separation.
            broker_uid = os.geteuid() if os.geteuid() != 0 else 65534
            with self.assertRaises(WriterConfigurationError):
                IsolatedMarkerWriter(
                    os.path.join(tmp, "writer.sock"), tmp,
                    broker_uid=broker_uid)
            self.assertFalse(os.path.exists(os.path.join(tmp, "writer.sock")))

    def test_invalid_broker_uids_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            for bad in (0, -1, True, None):
                with self.subTest(bad=bad):
                    with self.assertRaises(WriterConfigurationError):
                        IsolatedMarkerWriter(
                            os.path.join(tmp, "writer.sock"), tmp,
                            broker_uid=bad)

    def test_hash_identity_does_not_expose_request_string(self):
        self.assertNotIn("secret", marker_name("secret/source/identity"))


if __name__ == "__main__":
    unittest.main()
