"""Encrypted G-Mesh telemetry wrapper (ChaCha20-Poly1305)."""
import json
import os

from cryptography.hazmat.primitives.ciphers.aead import ChaCha20Poly1305


class GMeshTelemetryEncryptor:
    def __init__(self, pre_shared_key=None):
        self.key = pre_shared_key or ChaCha20Poly1305.generate_key()
        self.cipher = ChaCha20Poly1305(self.key)

    def pack_payload(self, node_id, epoch, state_hash, metrics):
        payload = {
            "node_id": node_id,
            "epoch": epoch,
            "state_hash": state_hash,
            "metrics": metrics,
        }
        plaintext = json.dumps(payload).encode("utf-8")
        nonce = os.urandom(12)
        ciphertext = self.cipher.encrypt(nonce, plaintext, associated_data=b"g-mesh-v3")
        return nonce + ciphertext

    def unpack_payload(self, encrypted_packet):
        nonce = encrypted_packet[:12]
        ciphertext = encrypted_packet[12:]
        plaintext = self.cipher.decrypt(nonce, ciphertext, associated_data=b"g-mesh-v3")
        return json.loads(plaintext.decode("utf-8"))
