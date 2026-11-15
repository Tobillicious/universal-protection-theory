"""Bounded G3 host preflight must inspect the resources actually in use.

Tests run as the regular nonroot GitHub Actions writer, never against live
machines. A positive result still has certified=False.
"""
import os
from pathlib import Path
import tempfile
import unittest

from g3_bound_host_server import (
    PreflightedSignedFencedServer, verify_live_writer_host,
)
from test_g3_signed_bridge import SignedBridgeTests


class LiveHostBindingTests(unittest.TestCase):
    setUp = SignedBridgeTests.setUp
    tearDown = SignedBridgeTests.tearDown

    def config(self):
        return dict(output_dir=str(self.out),
                    writer_db=str(self.root/'writer.sqlite'),
                    fence_file=str(self.root/'fence.lock'),
                    gate_db=str(self.root/'g3.sqlite'),
                    mesh_db=str(self.root/'mesh.sqlite'))

    def private_resources(self):
        for name in ('writer.sqlite', 'fence.lock', 'g3.sqlite',
                     'mesh.sqlite'):
            (self.root/name).chmod(0o600)
        self.out.chmod(0o700)

    @unittest.skipIf(os.geteuid() == 0, 'positive gate requires nonroot writer')
    def test_live_resource_binding_accepts_only_actual_private_resources(self):
        self.private_resources()
        checked = verify_live_writer_host(self.writer, **self.config())
        self.assertTrue(checked['ok'], checked)
        self.assertFalse(checked['certified'])
        self.assertFalse(checked['all_capabilities_mediated'])
        sock=str(self.root/'bounded.sock')
        server=PreflightedSignedFencedServer(
            sock,self.writer,{65534},**self.config())
        try:
            self.assertTrue(Path(sock).exists())
        finally:
            server.server_close()

    @unittest.skipIf(os.geteuid() == 0, 'requires nonroot owner')
    def test_safe_but_unrelated_writer_db_is_rejected(self):
        self.private_resources()
        decoy=self.root/'decoy.sqlite'
        decoy.write_bytes(b'safe-looking decoy')
        decoy.chmod(0o600)
        kw=self.config()
        kw['writer_db']=str(decoy)
        result=verify_live_writer_host(self.writer,**kw)
        self.assertEqual(result['code'],'live_writer_binding_mismatch')
        with self.assertRaises(PermissionError):
            PreflightedSignedFencedServer(
                str(self.root/'denied.sock'),self.writer,{65534},**kw)
        self.assertFalse((self.root/'denied.sock').exists())

    @unittest.skipIf(os.geteuid() == 0, 'requires nonroot owner')
    def test_wrong_effect_root_rejected(self):
        self.private_resources()
        other=self.root/'other-effect'
        other.mkdir(mode=0o700)
        kw=self.config()
        kw['output_dir']=str(other)
        self.assertEqual(verify_live_writer_host(
            self.writer,**kw)['code'],'live_writer_binding_mismatch')

    @unittest.skipIf(os.geteuid() == 0, 'requires nonroot owner')
    def test_replaced_database_inode_rejected_after_connection_open(self):
        self.private_resources()
        original=self.root/'writer.sqlite'
        saved=self.root/'original-writer.sqlite'
        original.rename(saved)
        # Another regular private file now sits at the expected pathname.
        # SQLite still has the original inode open, so pathname-only checks
        # are insufficient.
        original.write_bytes(b'decoy-not-sqlite')
        original.chmod(0o600)
        self.assertEqual(verify_live_writer_host(
            self.writer,**self.config())['code'],
            'live_writer_binding_mismatch')

    @unittest.skipIf(os.geteuid() == 0, 'requires nonroot owner')
    def test_swapped_fence_inode_rejected(self):
        self.private_resources()
        p=self.root/'fence.lock'
        renamed=self.root/'original-fence.lock'
        p.rename(renamed)
        p.write_bytes(b'lookalike')
        p.chmod(0o600)
        self.assertEqual(verify_live_writer_host(
            self.writer,**self.config())['code'],
            'live_writer_binding_mismatch')

    def test_root_process_does_not_pass(self):
        if os.geteuid() == 0:
            self.assertEqual(verify_live_writer_host(
                self.writer,**self.config())['code'],
                'root_writer_forbidden')
        else:
            self.private_resources()
            self.assertTrue(verify_live_writer_host(
                self.writer,**self.config())['ok'])


if __name__=='__main__':
    unittest.main()
