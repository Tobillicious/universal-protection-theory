"""Cooperating-process signed marker enactment fence (research only).

Serializes the writer-side signature and live-state decision with the effect
callback under one explicitly supplied lock. The controller MUST acquire the
same cross-process lock before mutating revocation/hold state; arbitrary other
processes and external writes are not constrained. No deployment launcher.
"""
import threading


class SignedWriterEnactor:
    def __init__(self, *, signed_policy, shared_lock):
        if not callable(signed_policy):
            raise ValueError("signed policy is required")
        if shared_lock is None or not callable(getattr(shared_lock, "acquire", None)) or not callable(getattr(shared_lock, "release", None)):
            raise ValueError("shared lock required")
        self.signed_policy = signed_policy
        self.shared_lock = shared_lock

    def enact(self, event, permit, write_effect):
        """The live check must occur WHILE holding the lock through the write.

        The lock must be constructed by a trusted operator and shared with
        the controller. Return an uncertain outcome on any write exception:
        a filesystem effect cannot be rolled back merely by releasing a lock.
        """
        if type(event) is not dict or type(permit) is not dict or not callable(write_effect):
            return {"ok": False, "code": "bad_request"}
        try:
            with self.shared_lock:
                try:
                    authorized = self.signed_policy(event, permit) is True
                except Exception:
                    authorized = False
                if not authorized:
                    return {"ok": False, "code": "writer_authorization_denied"}
                try:
                    outcome = write_effect()
                except BaseException:
                    return {"ok": False, "code": "outcome_uncertain"}
                if (type(outcome) is not dict or type(outcome.get("ok")) is not bool):
                    return {"ok": False, "code": "outcome_uncertain"}
                return outcome
        except Exception:
            # Lock acquisition errors must not fall back to an unlocked effect.
            return {"ok": False, "code": "lock_unavailable"}


class ThreadOnlyLock:
    """A testing lock: not acceptable for a cross-process production boundary."""
    def __init__(self):
        self._lock = threading.RLock()

    def __enter__(self):
        self._lock.acquire()
        return self

    def __exit__(self, *_):
        self._lock.release()

    def acquire(self):
        return self._lock.acquire()

    def release(self):
        return self._lock.release()
