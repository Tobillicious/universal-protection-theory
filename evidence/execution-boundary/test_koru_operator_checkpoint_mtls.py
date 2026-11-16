"""Actual loopback mTLS operator boundary; no external deployment."""
import hashlib
import ssl
import threading
import unittest

from cryptography.hazmat.primitives import serialization
from koru_operator_checkpoint_mtls import (
    LoopbackOperatorCheckpointService, request_operator_checkpoint)
from test_koru_operator_checkpoint_custodian import OperatorCustodyTests
from test_koru_dual_mtls_endpoints import _new_ca
from test_koru_mtls_revision_witness import certificate_pair, pem_key


class OperatorMTLSTests(OperatorCustodyTests):
    def setUp(self):
        super().setUp()
        ca_key, ca_cert = _new_ca("agent3-operator-root")
        srv_key, srv_cert = certificate_pair(ca_key, ca_cert, "localhost", server=True)
        client_key, client_cert = certificate_pair(ca_key, ca_cert, "operator-client")
        root = __import__("pathlib").Path(self.temp.name)
        def write(name, data):
            p = root / name
            p.write_bytes(data)
            return str(p)
        ca = write("operator-ca.pem", ca_cert.public_bytes(serialization.Encoding.PEM))
        server_cert = write("operator.pem", srv_cert.public_bytes(serialization.Encoding.PEM))
        server_key = write("operator.key", pem_key(srv_key))
        client_cert_path = write("client.pem", client_cert.public_bytes(serialization.Encoding.PEM))
        client_key_path = write("client.key", pem_key(client_key))
        self.server_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
        self.server_context.verify_mode = ssl.CERT_REQUIRED
        self.server_context.load_verify_locations(cafile=ca)
        self.server_context.load_cert_chain(server_cert, server_key)
        self.context = ssl.create_default_context(ssl.Purpose.SERVER_AUTH, cafile=ca)
        self.context.load_cert_chain(client_cert_path, client_key_path)
        self.server_pin = hashlib.sha256(srv_cert.public_bytes(serialization.Encoding.DER)).hexdigest()
        client_pin = hashlib.sha256(client_cert.public_bytes(serialization.Encoding.DER)).hexdigest()
        self.service = LoopbackOperatorCheckpointService(
            self.custodian, self.server_context,
            allowed_client_fingerprint=client_pin)
        self.worker = threading.Thread(target=self.service.serve_forever, daemon=True)
        self.worker.start()

    def tearDown(self):
        self.service.shutdown()
        self.service.server_close()
        self.worker.join(timeout=3)
        super().tearDown()

    def remote(self, nonce, *, pin=None, key=None):
        return request_operator_checkpoint(
            self.service.server_address, nonce, context=self.context,
            hostname="localhost",
            server_fingerprint=self.server_pin if pin is None else pin,
            operator_public_key=self.custodian.public_key if key is None else key)

    def test_remote_signed_read_is_not_effect_permission(self):
        self.create_partial_commit()
        self.custodian.observe_pair(self.a.read(), self.b.read())
        from koru_operator_checkpoint_recovery import recover_with_operator_checkpoint
        p, s = self.reads()
        result = recover_with_operator_checkpoint(
            anchored=self.anchored, primary_read=p, secondary_read=s,
            operator_read=self.remote,
            operator_public_key=self.custodian.public_key)
        self.assertEqual(result["revision"], 1)
        self.assertIs(result["authorizes_effect"], False)

    def test_stale_remote_custodian_refuses_recovery(self):
        self.create_partial_commit()
        from koru_operator_checkpoint_recovery import recover_with_operator_checkpoint
        p, s = self.reads()
        with self.assertRaisesRegex(PermissionError, "differs"):
            recover_with_operator_checkpoint(
                anchored=self.anchored, primary_read=p, secondary_read=s,
                operator_read=self.remote,
                operator_public_key=self.custodian.public_key)
        self.assertEqual(self.floor.read_floor()[0], 0)

    def test_wrong_server_certificate_pin_denied(self):
        with self.assertRaises(PermissionError):
            self.remote("a" * 64, pin="0" * 64)

    def test_wrong_operator_signing_key_denied(self):
        from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
        wrong = Ed25519PrivateKey.generate().public_key()
        with self.assertRaises(PermissionError):
            self.remote("b" * 64, key=wrong)

    def test_malformed_nonce_denied_before_transport(self):
        with self.assertRaises(ValueError):
            self.remote("not-a-nonce")

    def test_operator_unavailable_denies(self):
        self.service.shutdown()
        self.service.server_close()
        self.worker.join(timeout=3)
        with self.assertRaises((OSError, ValueError)):
            self.remote("c" * 64)

    def test_remote_read_does_not_advance_custodian_floor(self):
        self.create_partial_commit()
        packet = self.remote("d" * 64)
        self.assertEqual(packet["revision"], 0)
        self.assertEqual(self.custody_floor.read_floor()[0], 0)


if __name__ == "__main__":
    unittest.main()
