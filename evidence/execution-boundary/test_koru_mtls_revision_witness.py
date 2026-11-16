"""Mutual TLS loopback integration, synthetic G3 revision witness only.

Certificates are test-generated. No off-host administrative separation.
"""
import datetime
import hashlib
import os
import ssl
import tempfile
import threading
import unittest
from pathlib import Path

from cryptography import x509
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import ed25519, rsa
from cryptography.x509.oid import NameOID, ExtendedKeyUsageOID

from koru_mtls_revision_witness import (
    LoopbackMTLSRevisionWitness, request_mtls_witness)
from koru_monotonic_revision_witness import MonotonicRevisionWitness


def pem_key(key):
    return key.private_bytes(
        serialization.Encoding.PEM, serialization.PrivateFormat.PKCS8,
        serialization.NoEncryption())


def certificate_pair(ca_key, ca_cert, name, *, server=False):
    key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    subject = x509.Name([x509.NameAttribute(NameOID.COMMON_NAME, name)])
    now = datetime.datetime.now(datetime.timezone.utc)
    builder = (x509.CertificateBuilder().subject_name(subject)
        .issuer_name(ca_cert.subject).public_key(key.public_key())
        .serial_number(x509.random_serial_number())
        .not_valid_before(now - datetime.timedelta(minutes=1))
        .not_valid_after(now + datetime.timedelta(days=1))
        .add_extension(x509.BasicConstraints(ca=False, path_length=None),
                       critical=True)
        .add_extension(x509.SubjectKeyIdentifier.from_public_key(
            key.public_key()), critical=False)
        .add_extension(x509.AuthorityKeyIdentifier.from_issuer_public_key(
            ca_key.public_key()), critical=False)
        .add_extension(x509.KeyUsage(
            digital_signature=True, content_commitment=False,
            key_encipherment=True, data_encipherment=False,
            key_agreement=False, key_cert_sign=False, crl_sign=False,
            encipher_only=False, decipher_only=False), critical=True)
        .add_extension(x509.ExtendedKeyUsage([
            ExtendedKeyUsageOID.SERVER_AUTH if server
            else ExtendedKeyUsageOID.CLIENT_AUTH]), critical=False))
    if server:
        builder = builder.add_extension(
            x509.SubjectAlternativeName([x509.DNSName("localhost")]),
            critical=False)
    cert = builder.sign(ca_key, hashes.SHA256())
    return key, cert


class MTLSRevisionWitnessTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-mtls-")
        self.root = Path(self.temp.name)
        self.base = dict(generation=4, held=False, event_id="fixture",
                         authority_ref="ref", pending_ids=[])
        self.receipt_key = ed25519.Ed25519PrivateKey.generate()
        self.witness = MonotonicRevisionWitness.provision(
            str(self.root / "journal.db"), self.receipt_key, self.base)
        self.receipt_public = self.receipt_key.public_key()
        now = datetime.datetime.now(datetime.timezone.utc)
        self.ca_key = rsa.generate_private_key(
            public_exponent=65537, key_size=2048)
        name = x509.Name([x509.NameAttribute(NameOID.COMMON_NAME,
                                             "g3-disposable-test-ca")])
        self.ca_cert = (x509.CertificateBuilder().subject_name(name)
            .issuer_name(name).public_key(self.ca_key.public_key())
            .serial_number(x509.random_serial_number())
            .not_valid_before(now-datetime.timedelta(minutes=1))
            .not_valid_after(now+datetime.timedelta(days=1))
            .add_extension(x509.BasicConstraints(ca=True,path_length=None),
                           critical=True)
            .add_extension(x509.SubjectKeyIdentifier.from_public_key(
                self.ca_key.public_key()), critical=False)
            .add_extension(x509.AuthorityKeyIdentifier.from_issuer_public_key(
                self.ca_key.public_key()), critical=False)
            .add_extension(x509.KeyUsage(
                digital_signature=False, content_commitment=False,
                key_encipherment=False, data_encipherment=False,
                key_agreement=False, key_cert_sign=True, crl_sign=True,
                encipher_only=False, decipher_only=False), critical=True)
            .sign(self.ca_key, hashes.SHA256()))
        self.ca_path=self._write("ca.pem",self.ca_cert.public_bytes(
            serialization.Encoding.PEM))
        serverkey,servercert=certificate_pair(
            self.ca_key,self.ca_cert,"localhost",server=True)
        clientkey,clientcert=certificate_pair(
            self.ca_key,self.ca_cert,"client")
        roguekey,roguecert=certificate_pair(
            self.ca_key,self.ca_cert,"rogue")
        self.server_key=self._write("server.key",pem_key(serverkey))
        self.server_cert=self._write("server.pem",servercert.public_bytes(
            serialization.Encoding.PEM))
        self.client_key=self._write("client.key",pem_key(clientkey))
        self.client_cert=self._write("client.pem",clientcert.public_bytes(
            serialization.Encoding.PEM))
        self.rogue_key=self._write("rogue.key",pem_key(roguekey))
        self.rogue_cert=self._write("rogue.pem",roguecert.public_bytes(
            serialization.Encoding.PEM))
        self.server_pin=hashlib.sha256(servercert.public_bytes(
            serialization.Encoding.DER)).hexdigest()
        self.client_pin=hashlib.sha256(clientcert.public_bytes(
            serialization.Encoding.DER)).hexdigest()
        self.server_context=ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
        self.server_context.minimum_version=ssl.TLSVersion.TLSv1_2
        self.server_context.verify_mode=ssl.CERT_REQUIRED
        self.server_context.load_verify_locations(cafile=self.ca_path)
        self.server_context.load_cert_chain(self.server_cert,self.server_key)
        self.client_context=self._client_context(
            self.client_cert,self.client_key)
        self.rogue_context=self._client_context(
            self.rogue_cert,self.rogue_key)
        self.server=LoopbackMTLSRevisionWitness(
            self.witness,self.server_context,
            allowed_client_fingerprint=self.client_pin)
        self.thread=threading.Thread(
            target=self.server.serve_forever,daemon=True)
        self.thread.start()

    def _write(self,name,contents):
        path=self.root/name
        path.write_bytes(contents)
        return str(path)

    def _client_context(self,cert,key):
        ctx=ssl.create_default_context(
            ssl.Purpose.SERVER_AUTH,cafile=self.ca_path)
        ctx.minimum_version=ssl.TLSVersion.TLSv1_2
        ctx.check_hostname=True
        ctx.load_cert_chain(cert,key)
        return ctx

    def tearDown(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=3)
        self.temp.cleanup()

    def ask(self,query,*,context=None,hostname="localhost",pin=None):
        return request_mtls_witness(
            self.server.server_address,query,
            context=self.client_context if context is None else context,
            hostname=hostname,
            server_fingerprint=self.server_pin if pin is None else pin,
            public_key=self.receipt_public)

    def advance(self,state,receipt):
        return self.ask(dict(op="advance",snapshot=state,
                             revision=receipt["revision"],
                             digest=receipt["digest"]))

    def test_authorized_mtls_read_signed_not_permit(self):
        response=self.ask({"op":"read"})
        self.assertEqual(response["code"],"snapshot_only")
        self.assertEqual(response["receipt"]["revision"],0)

    def test_authenticated_hold_commit_and_stale_replay(self):
        first=self.ask({"op":"read"})["receipt"]
        held=dict(self.base,held=True)
        result=self.advance(held,first)
        self.assertEqual(result["code"],"revision_committed")
        self.assertEqual(result["receipt"]["revision"],1)
        stale=self.advance(held,first)
        self.assertEqual(stale["code"],"stale_revision")
        self.assertEqual(self.ask({"op":"read"})["receipt"]["revision"],1)

    def test_authenticated_client_cannot_clear_hold(self):
        first=self.ask({"op":"read"})["receipt"]
        self.assertTrue(self.advance(dict(self.base,held=True),first)["ok"])
        current=self.ask({"op":"read"})["receipt"]
        denial=self.advance(self.base,current)
        self.assertEqual(denial["code"],"protection_regression_denied")
        self.assertEqual(self.ask({"op":"read"})["receipt"],current)

    def test_ca_valid_but_unpinned_client_denied(self):
        result=self.ask({"op":"read"},context=self.rogue_context)
        self.assertEqual(result,{"ok":False,"code":"peer_denied"})

    def test_no_client_certificate_fails_handshake(self):
        anonymous=ssl.create_default_context(
            ssl.Purpose.SERVER_AUTH,cafile=self.ca_path)
        with self.assertRaises((ssl.SSLError,OSError)):
            self.ask({"op":"read"},context=anonymous)

    def test_pinned_server_certificate_required(self):
        with self.assertRaises(PermissionError):
            self.ask({"op":"read"},pin="0"*64)

    def test_server_hostname_mismatch_denied(self):
        with self.assertRaises(ssl.CertificateError):
            self.ask({"op":"read"},hostname="not-localhost.test")

    def test_uncertain_ack_after_commit_requires_fresh_read(self):
        old=self.witness.advance
        def committed_but_lost(*args,**kwargs):
            old(*args,**kwargs)
            raise ConnectionResetError("simulated loss after commit")
        self.witness.advance=committed_but_lost
        first=self.ask({"op":"read"})["receipt"]
        state=dict(self.base,pending_ids=["op"])
        try:
            uncertain=self.advance(state,first)
            self.assertEqual(uncertain["code"],
                             "witness_unavailable_or_uncertain")
        finally:
            self.witness.advance=old
        latest=self.ask({"op":"read"})["receipt"]
        self.assertEqual(latest["revision"],1)
        self.assertEqual(self.advance(state,first)["code"],
                         "stale_revision")

    def test_unreachable_server_fails_closed(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=3)
        # The listening port may be reused by another process; authenticated
        # TLS/fingerprint checking still prevents a positive result.
        with self.assertRaises((OSError,ssl.SSLError,ValueError)):
            self.ask({"op":"read"})


if __name__=="__main__":
    unittest.main()
