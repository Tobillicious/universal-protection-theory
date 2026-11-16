"""Operator-custodied historical floor and challenge signer (research fixture).

The caller CANNOT submit a desired checkpoint for signature. The custodian
signs only its own stored observation, after separately verified two-witness
CAS progression. Separate real administration and unrollbackable hardware/
storage are DEPLOYMENT assumptions, not properties of this Python fixture.
"""
import secrets

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_client_revision_floor import ClientRevisionFloor
from koru_two_witness_agreement import TwoWitnessAgreement, _key_bytes
from koru_operator_checkpoint_recovery import DOMAIN, _encode


class OperatorCheckpointCustodian:
    def __init__(self, operator_key, floor, primary_key, secondary_key):
        if not isinstance(operator_key, Ed25519PrivateKey):
            raise TypeError("custodian private key required")
        if not isinstance(floor, ClientRevisionFloor):
            raise TypeError("operator-owned durable floor required")
        if (_key_bytes(floor.public_key) != _key_bytes(primary_key)):
            raise ValueError("custodian floor must pin primary signer")
        operator_public = operator_key.public_key()
        if _key_bytes(operator_public) in {
                _key_bytes(primary_key), _key_bytes(secondary_key)}:
            raise ValueError("operator key must differ from witness signers")
        self._operator_key = operator_key
        self._agreement = TwoWitnessAgreement(floor, secondary_key)

    def observe_pair(self, primary_receipt, secondary_receipt):
        """Only verified, contiguous both-signed history can advance custody."""
        return self._agreement.accept_pair(primary_receipt, secondary_receipt)

    def respond(self, nonce):
        """Sign a caller challenge over OUR retained floor, never caller state."""
        if (type(nonce) is not str or len(nonce) != 64 or
                any(c not in "0123456789abcdef" for c in nonce)):
            raise ValueError("fresh 256-bit challenge required")
        revision, digest, predecessor = self._agreement.floor.read_floor()
        body = dict(domain=DOMAIN, nonce=nonce, revision=revision,
                    digest=digest, previous_digest=predecessor)
        return dict(body, signature=self._operator_key.sign(_encode(body)).hex())

    @property
    def public_key(self):
        return self._operator_key.public_key()
