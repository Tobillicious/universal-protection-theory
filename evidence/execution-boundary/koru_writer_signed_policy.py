"""Writer-side signed authorization adapter for the disposable G3 marker pilot.

No signing key, service launcher, mutable authority or default-allow path.
The caller-supplied event/permit pair is untrusted; the trusted store callback
must independently verify current state under an enactment-wide critical
section also held through the corresponding physical effect. This adapter
alone does NOT provide cross-process locking or physical atomicity.
"""
import time

from koru_ed25519_permit import verify_ed25519


class SignedWriterPolicy:
    """Composable predicate; does not issue permits or grant capabilities."""

    def __init__(self, *, public_key, issuer, current_state_check,
                 clock=None):
        if type(issuer) is not str or not issuer:
            raise ValueError("issuer required")
        if not callable(current_state_check):
            raise ValueError("independent state-check callback required")
        if clock is not None and not callable(clock):
            raise ValueError("trusted clock callback required")
        self.public_key = public_key
        self.issuer = issuer
        self.current_state_check = current_state_check
        self.clock = clock if clock is not None else lambda: int(time.time())

    def __call__(self, event, permit):
        try:
            if type(event) is not dict or type(permit) is not dict:
                return False
            now = self.clock()
            if type(now) is not int or now < 0:
                return False
            if not verify_ed25519(
                self.public_key, permit, issuer=self.issuer,
                event=event, now=now
            ):
                return False
            # Trusted state inspection must include generation, live
            # revocation/hold, admission, recovery and exact event identity.
            # True ONLY; errors and falsey substitutes deny.
            return self.current_state_check(event, permit, now) is True
        except Exception:
            return False
