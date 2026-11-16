"""Two distinct pinned mTLS services and retained history floor, end to end.

All components run over 127.0.0.1 in one disposable test process.
Each witness gets a DIFFERENT root CA, server cert, client cert, Ed25519
receipt-signing key and SQLite file. No real host/administrator separation.
"""
import datetime
import hashlib
import shutil
import ssl
import threading
import unittest
import tempfile
from pathlib import Path

from cryptography import x509
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import ed25519, rsa
from cryptography.x509.oid import NameOID

from koru_client_revision_floor import ClientRevisionFloor
from koru_monotonic_revision_witness import MonotonicRevisionWitness
from koru_mtls_revision_witness import (
    LoopbackMTLSRevisionWitness, request_mtls_witness)
from koru_two_witness_agreement import (
    TwoWitnessAgreement, observe_two_mtls_witnesses)
from test_koru_mtls_revision_witness import certificate_pair, pem_key


def _new_ca(name):
    key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    now = datetime.datetime.now(datetime.timezone.utc)
    principal = x509.Name([x509.NameAttribute(NameOID.COMMON_NAME,name)])
    cert = (x509.CertificateBuilder()
        .subject_name(principal).issuer_name(principal)
        .public_key(key.public_key())
        .serial_number(x509.random_serial_number())
        .not_valid_before(now-datetime.timedelta(minutes=1))
        .not_valid_after(now+datetime.timedelta(days=1))
        .add_extension(x509.BasicConstraints(ca=True,path_length=None),
                       critical=True)
        .add_extension(x509.SubjectKeyIdentifier.from_public_key(
            key.public_key()),critical=False)
        .add_extension(x509.AuthorityKeyIdentifier.from_issuer_public_key(
            key.public_key()),critical=False)
        .add_extension(x509.KeyUsage(
            digital_signature=False, content_commitment=False,
            key_encipherment=False, data_encipherment=False,
            key_agreement=False, key_cert_sign=True, crl_sign=True,
            encipher_only=False, decipher_only=False),critical=True)
        .sign(key,hashes.SHA256()))
    return key, cert


class TwoLiveMTLSEndpointTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix="g3-two-mtls-")
        self.root=Path(self.temp.name)
        self.base=dict(generation=4, held=False, event_id="fixture",
                       authority_ref="ref",pending_ids=[])
        self.services=[]
        self.a=self._service("a")
        self.b=self._service("b")
        self.floor=ClientRevisionFloor.provision(
            str(self.root/"observer.sqlite"),self.a["public"],
            self.a["witness"].read())
        self.agreement=TwoWitnessAgreement(self.floor,self.b["public"])

    def tearDown(self):
        for service in self.services:
            service["server"].shutdown()
            service["server"].server_close()
            service["thread"].join(timeout=3)
        self.temp.cleanup()

    def _write(self,name,data):
        path=self.root/name
        path.write_bytes(data)
        return str(path)

    def _service(self,prefix):
        ca_key,ca_cert=_new_ca(prefix+"-test-ca")
        ca_path=self._write(prefix+"-ca.pem",
                            ca_cert.public_bytes(serialization.Encoding.PEM))
        server_key,server_cert=certificate_pair(
            ca_key,ca_cert,"localhost",server=True)
        client_key,client_cert=certificate_pair(
            ca_key,ca_cert,prefix+"-client")
        sk_path=self._write(prefix+"-server.key",pem_key(server_key))
        sc_path=self._write(prefix+"-server.pem",
            server_cert.public_bytes(serialization.Encoding.PEM))
        ck_path=self._write(prefix+"-client.key",pem_key(client_key))
        cc_path=self._write(prefix+"-client.pem",
            client_cert.public_bytes(serialization.Encoding.PEM))
        server_ctx=ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
        server_ctx.minimum_version=ssl.TLSVersion.TLSv1_2
        server_ctx.verify_mode=ssl.CERT_REQUIRED
        server_ctx.load_verify_locations(cafile=ca_path)
        server_ctx.load_cert_chain(sc_path,sk_path)
        client_ctx=ssl.create_default_context(
            ssl.Purpose.SERVER_AUTH,cafile=ca_path)
        client_ctx.minimum_version=ssl.TLSVersion.TLSv1_2
        client_ctx.check_hostname=True
        client_ctx.load_cert_chain(cc_path,ck_path)
        receipt_key=ed25519.Ed25519PrivateKey.generate()
        witness=MonotonicRevisionWitness.provision(
            str(self.root/(prefix+"-journal.sqlite")),receipt_key,self.base)
        server=LoopbackMTLSRevisionWitness(
            witness,server_ctx,
            allowed_client_fingerprint=hashlib.sha256(
                client_cert.public_bytes(serialization.Encoding.DER)
            ).hexdigest())
        thread=threading.Thread(target=server.serve_forever,daemon=True)
        thread.start()
        details=dict(witness=witness,public=receipt_key.public_key(),
                     address=server.server_address,context=client_ctx,
                     server_pin=hashlib.sha256(
                         server_cert.public_bytes(serialization.Encoding.DER)
                     ).hexdigest(),server=server,thread=thread)
        self.services.append(details)
        return details

    def _call(self,service,query,*,context=None,pin=None):
        return request_mtls_witness(
            service["address"],query,
            context=service["context"] if context is None else context,
            hostname="localhost",
            server_fingerprint=(service["server_pin"] if pin is None else pin),
            public_key=service["public"])

    def _advance(self,service,state):
        prior=self._call(service,{"op":"read"})["receipt"]
        result=self._call(service,{
            "op":"advance","snapshot":state,
            "revision":prior["revision"],"digest":prior["digest"]})
        self.assertEqual(result["code"],"revision_committed")
        return result["receipt"]

    def _observe(self):
        # Real network socket read for BOTH independently configured services.
        return observe_two_mtls_witnesses(
            lambda:self._call(self.a,{"op":"read"}),
            lambda:self._call(self.b,{"op":"read"}),
            agreement=self.agreement)

    def test_two_independent_tls_services_observe_genesis(self):
        self.assertNotEqual(self.a["address"],self.b["address"])
        self.assertNotEqual(self.a["server_pin"],self.b["server_pin"])
        self.assertEqual(self._observe()["revision"],0)

    def test_both_services_commit_hold_then_observer_advances(self):
        held=dict(self.base,held=True)
        self._advance(self.a,held)
        self._advance(self.b,held)
        self.assertEqual(self._observe()["floor_result"],"observed_next")
        self.assertEqual(self.floor.read_floor()[0],1)

    def test_one_service_commits_first_denies_then_reconciles(self):
        held=dict(self.base,held=True)
        self._advance(self.a,held)
        with self.assertRaisesRegex(PermissionError,"disagree"):
            self._observe()
        self.assertEqual(self.floor.read_floor()[0],0)
        # Reconciliation is safe only because the other journal advances with
        # the exact same checkpoint. No silent quorum downgrade to one.
        self._advance(self.b,held)
        self.assertEqual(self._observe()["revision"],1)

    def test_divergent_signed_mtls_states_denied(self):
        self._advance(self.a,dict(self.base,held=True))
        self._advance(self.b,dict(self.base,pending_ids=["unresolved"]))
        with self.assertRaisesRegex(PermissionError,"disagree"):
            self._observe()
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_secondary_service_outage_denies(self):
        self.b["server"].shutdown()
        self.b["server"].server_close()
        self.b["thread"].join(timeout=3)
        with self.assertRaises((OSError,ssl.SSLError,ValueError)):
            self._observe()
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_wrong_secondary_server_certificate_pin_denied(self):
        with self.assertRaises(PermissionError):
            observe_two_mtls_witnesses(
                lambda:self._call(self.a,{"op":"read"}),
                lambda:self._call(self.b,{"op":"read"},
                                  pin=self.a["server_pin"]),
                agreement=self.agreement)
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_cross_root_client_certificate_rejected(self):
        # Client A certificate is not issued by the independent B CA.
        with self.assertRaises((ssl.SSLError,OSError,PermissionError)):
            self._call(self.b,{"op":"read"},context=self.a["context"])
        self.assertEqual(self.floor.read_floor()[0],0)

    def test_rewind_both_service_databases_observer_floor_survives(self):
        old_a=str(self.root/"old-a.sqlite")
        old_b=str(self.root/"old-b.sqlite")
        shutil.copyfile(self.a["witness"].path,old_a)
        shutil.copyfile(self.b["witness"].path,old_b)
        held=dict(self.base,held=True)
        self._advance(self.a,held)
        self._advance(self.b,held)
        self._observe()
        shutil.copyfile(old_a,self.a["witness"].path)
        shutil.copyfile(old_b,self.b["witness"].path)
        with self.assertRaisesRegex(PermissionError,"rollback"):
            self._observe()
        self.assertEqual(self.floor.read_floor()[0],1)

    def test_rewind_all_three_files_still_undetectable(self):
        copies=[]
        for name,path in [
            ("a",self.a["witness"].path),
            ("b",self.b["witness"].path),
            ("floor",self.floor.path)]:
            copy=str(self.root/(name+"-backup.sqlite"))
            shutil.copyfile(path,copy)
            copies.append((copy,path))
        held=dict(self.base,held=True)
        self._advance(self.a,held)
        self._advance(self.b,held)
        self._observe()
        for source,target in copies:
            shutil.copyfile(source,target)
        # A known unprotected case; independent hosts/admins are still needed.
        self.assertEqual(self._observe()["revision"],0)


if __name__=="__main__":
    unittest.main()
