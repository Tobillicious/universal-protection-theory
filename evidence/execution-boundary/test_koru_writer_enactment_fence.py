"""Deterministic cooperating-controller ordering tests for research writer.

Thread-only tests do not certify multi-UID lock ownership or production use.
"""
import threading
import unittest

from koru_writer_enactment_fence import SignedWriterEnactor, ThreadOnlyLock
from koru_isolated_marker_writer import validate_writer_request


class EnactmentFenceTests(unittest.TestCase):
    def test_denied_never_writes(self):
        called = []
        fence = SignedWriterEnactor(
            signed_policy=lambda *_: False, shared_lock=ThreadOnlyLock())
        result = fence.enact({"event_id": "a"}, {}, lambda: called.append(True))
        self.assertEqual(result["code"], "writer_authorization_denied")
        self.assertEqual(called, [])

    def test_signature_or_state_error_denies(self):
        def throws(*_):
            raise OSError("revocation store down")
        fence = SignedWriterEnactor(
            signed_policy=throws, shared_lock=ThreadOnlyLock())
        self.assertEqual(
            fence.enact({"event_id": "a"}, {}, lambda: {"ok": True})["code"],
            "writer_authorization_denied")

    def test_write_failure_is_uncertain(self):
        def throws():
            raise OSError("fsync failed")
        fence = SignedWriterEnactor(
            signed_policy=lambda *_: True, shared_lock=ThreadOnlyLock())
        self.assertEqual(fence.enact({"event_id": "a"}, {}, throws)["code"],
                         "outcome_uncertain")

    def test_controller_waits_until_effect_finishes(self):
        shared = ThreadOnlyLock()
        started = threading.Event()
        finish = threading.Event()
        revoked = threading.Event()
        results = []
        fence = SignedWriterEnactor(
            signed_policy=lambda *_: not revoked.is_set(),
            shared_lock=shared)

        def write():
            started.set()
            self.assertTrue(finish.wait(timeout=2))
            return {"ok": True, "code": "fixture_applied"}

        def do_effect():
            results.append(fence.enact({"event_id": "a"}, {}, write))

        def revoke():
            with shared:
                revoked.set()

        writer = threading.Thread(target=do_effect)
        controller = threading.Thread(target=revoke)
        writer.start()
        try:
            self.assertTrue(started.wait(timeout=2))
            controller.start()
            # Revoke cannot commit while write holds the shared lock.
            self.assertFalse(revoked.wait(timeout=0.1))
            finish.set()
            writer.join(timeout=2)
            controller.join(timeout=2)
            self.assertFalse(writer.is_alive())
            self.assertFalse(controller.is_alive())
            self.assertEqual(results, [{"ok": True, "code": "fixture_applied"}])
            self.assertTrue(revoked.is_set())
            second = fence.enact({"event_id": "b"}, {}, lambda: {"ok": True})
            self.assertEqual(second["code"], "writer_authorization_denied")
        finally:
            finish.set()
            writer.join(timeout=2)
            if controller.ident is not None:
                controller.join(timeout=2)

    def test_revocation_first_prevents_write(self):
        shared = ThreadOnlyLock()
        revoked = False

        def policy(*_):
            return not revoked

        def revoke():
            nonlocal revoked
            with shared:
                revoked = True

        revoke()
        called = []
        fence = SignedWriterEnactor(
            signed_policy=policy, shared_lock=shared)
        result = fence.enact({"event_id": "b"}, {},
                             lambda: called.append(1))
        self.assertFalse(result["ok"])
        self.assertEqual(called, [])

    def test_requires_lock_and_policy(self):
        with self.assertRaises(ValueError):
            SignedWriterEnactor(signed_policy=None, shared_lock=ThreadOnlyLock())
        with self.assertRaises(ValueError):
            SignedWriterEnactor(signed_policy=lambda *_: True, shared_lock=None)


if __name__ == "__main__":
    unittest.main()
