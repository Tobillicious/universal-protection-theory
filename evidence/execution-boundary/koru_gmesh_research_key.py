"""G-Mesh research transport key loader; NOT an independent quorum identity.

Reject default/shared committed secrets. This symmetric HMAC is only suitable
for explicitly scoped research tests, not production authentication or
per-member Ed25519 identities. A genuine G3 federation requires independent
key custody, replay prevention, real effects and original-six verification.
"""
import os


def load_research_key(value=None):
    raw = value if value is not None else os.environ.get("UPT_GMESH_RESEARCH_HMAC_KEY_HEX")
    if type(raw) is not str or len(raw) < 64 or len(raw) % 2:
        raise ValueError("missing/invalid explicitly provisioned research key")
    try:
        key = bytes.fromhex(raw)
    except ValueError as exc:
        raise ValueError("invalid research key encoding") from exc
    if not 32 <= len(key) <= 128 or not any(key):
        raise ValueError("invalid research key material")
    return key
