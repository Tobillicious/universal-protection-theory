"""Bounded client-owned, single-use challenge verification for G3 HOLD receipts.

In-memory research component only. It is NOT an authenticated transport, host
attestation, or authorization to enact effects. Missing/invalid responses fail
closed; an attempted response consumes the challenge even when verification fails.
"""
import secrets
import threading
import time

from koru_signed_hold_receipt import verify_complete_receipt


class HoldReceiptChallengeClient:
    def __init__(self, public_key, *, issuer, max_pending=64, ttl_seconds=30):
        if type(issuer) is not str or not issuer or not issuer.isascii():
            raise ValueError("issuer must be a pinned ASCII identity")
        if type(max_pending) is not int or not 1 <= max_pending <= 1024:
            raise ValueError("invalid pending capacity")
        if type(ttl_seconds) not in (int, float) or not 0 < ttl_seconds <= 300:
            raise ValueError("invalid challenge lifetime")
        self._key = public_key
        self._issuer = issuer
        self._limit = max_pending
        self._ttl = ttl_seconds
        self._pending = {}
        self._lock = threading.Lock()

    def begin(self, *, event_id, authority_ref, minimum_generation):
        """Return nonce only; keep expected identity/generation client-side."""
        if (type(event_id) is not str or not event_id or
                type(authority_ref) is not str or not authority_ref or
                type(minimum_generation) is not int or minimum_generation < 1):
            raise ValueError("invalid query context")
        with self._lock:
            now = time.monotonic()
            self._pending = {k: v for k, v in self._pending.items()
                             if now < v[0]}
            if len(self._pending) >= self._limit:
                raise RuntimeError("too many outstanding HOLD challenges")
            nonce = secrets.token_hex(32)
            while nonce in self._pending:
                nonce = secrets.token_hex(32)
            self._pending[nonce] = (
                now + self._ttl, event_id, authority_ref, minimum_generation)
            return nonce

    def accept(self, nonce, receipt):
        """Consume challenge atomically BEFORE cryptographic verification.

        A broker-controlled response, including None or malformed data, cannot
        leave the same challenge valid for retry. Start a fresh query instead.
        """
        with self._lock:
            if type(nonce) is not str:
                return False
            pending = self._pending.pop(nonce, None)
        if pending is None:
            return False
        expiry, event_id, authority_ref, generation = pending
        if time.monotonic() >= expiry:
            return False
        return verify_complete_receipt(
            self._key, receipt, issuer=self._issuer, nonce=nonce,
            event_id=event_id, authority_ref=authority_ref,
            minimum_generation=generation)

    def cancel(self, nonce):
        """Forget an abandoned request; cancellation never re-enables effects."""
        with self._lock:
            return self._pending.pop(nonce, None) is not None
