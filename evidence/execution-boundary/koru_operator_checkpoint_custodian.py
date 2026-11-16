"""Operator-custodied historical floor and challenge signer (research fixture).

The caller CANNOT submit a desired checkpoint for signature. The custodian
signs only its own stored observation, after separately verified two-witness
CAS progression. Separate real administration and unrollbackable hardware/
storage are DEPLOYMENT assumptions, not properties of this Python fixture.
"""
import secrets

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_client_revision_floor import ClientRevisionFloor
from koru_two_witness_agreement import TwoWitnessAgreement, _key_bytes, observe_two_mtls_witnesses
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

    def observe_authenticated_witnesses(self, primary_read, secondary_read):
        """Obtain both histories through custodian-selected trusted transports.

        The operator configures its own two distinct pinned mTLS adapters.
        No caller-proposed digest or revision is accepted; both receipts must
        agree and pass the existing monotone CAS floor before being signed.
        This does not itself establish independent host administration.
        """
        return observe_two_mtls_witnesses(
            primary_read, secondary_read, agreement=self._agreement)

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


class OperatorManagedWitnessReads:
    """Bind two operator-configured history readers once, not per request.

    Construction MUST occur inside the independently administered operator
    service with separately configured/pinned mTLS readers. Possession of
    this Python object is not evidence of independent administration.
    """

    def __init__(self, custodian, primary_read, secondary_read):
        if not isinstance(custodian, OperatorCheckpointCustodian):
            raise TypeError("provisioned operator custodian required")
        if (not callable(primary_read) or not callable(secondary_read) or
                primary_read is secondary_read):
            raise ValueError("two distinct operator-configured readers required")
        self._custodian = custodian
        self._primary_read = primary_read
        self._secondary_read = secondary_read

    def observe(self):
        """Advance only from the previously bound authenticated readers.

        There are deliberately no per-request reader or receipt arguments.
        Both returned signed receipts remain subject to exact key and
        monotone-history verification by the existing two-witness agreement.
        """
        return self._custodian.observe_authenticated_witnesses(
            self._primary_read, self._secondary_read)
