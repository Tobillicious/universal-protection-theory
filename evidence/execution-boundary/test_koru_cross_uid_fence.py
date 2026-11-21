"""Linux-only cross-UID lock tests. Disposable privileged test harness.

The privileged parent provisions a lock-only group-owned inode; workers drop
to distinct nonroot UIDs and the same dedicated group. The parent never grants
the group access to protected authorization databases or marker directories.
"""
import os
from pathlib import Path
import select
import shutil
import subprocess
import sys
import tempfile
import unittest

LOCK_GID = 65531
WRITER_UID = 65532
CONTROL_UID = 65533

CHILD = r"""
import os,sys
from koru_cross_uid_fence import ProvisionedCrossUidFence
f=ProvisionedCrossUidFence(sys.argv[1], shared_gid=int(sys.argv[2]))
if sys.argv[3]=='holder':
    with f:
        print('LOCKED',flush=True)
        assert sys.stdin.readline().strip()=='release'
elif sys.argv[3]=='waiter':
    print('WAITING',flush=True)
    with f: print('ACQUIRED',flush=True)
else: raise ValueError('bad role')
f.close()
"""

def drop_to(uid):
    def lower():
        os.setgroups([])
        os.setgid(LOCK_GID)
        os.setuid(uid)
    return lower


@unittest.skipUnless(sys.platform == 'linux' and os.geteuid() == 0,
                     'disposable root Linux test runner only')
class CrossUidFenceTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='g3-cross-uid-')
        self.root = Path(self.temp.name)
        self.root.chmod(0o755)  # Python import discovery needs listing; no untrusted writes
        self.shared = self.root / 'root-owned-lock'
        self.shared.mkdir(mode=0o700)
        os.chown(self.shared, 0, LOCK_GID)
        self.shared.chmod(0o710)
        self.lock = self.shared / 'effect.lock'
        self.lock.write_bytes(b'')
        os.chown(self.lock, 0, LOCK_GID)
        self.lock.chmod(0o660)
        # Dropped UIDs may not traverse GitHub runner checkout ancestors.
        # Stage only the tested lock module inside the disposable fixture.
        staged = self.root / 'koru_cross_uid_fence.py'
        shutil.copyfile(Path(__file__).with_name('koru_cross_uid_fence.py'), staged)
        staged.chmod(0o644)  # independent UIDs must be able to import it
        self.children = []

    def tearDown(self):
        for p in self.children:
            if p.poll() is None:
                try: p.stdin.write('release\n'); p.stdin.flush()
                except (OSError, ValueError): pass
                try: p.terminate()
                except ProcessLookupError: pass
            try: p.communicate(timeout=3)
            except subprocess.TimeoutExpired:
                p.kill()
                p.communicate(timeout=3)
        self.temp.cleanup()

    def start(self, uid, role):
        p = subprocess.Popen(
            [sys.executable, '-B', '-c', CHILD,
             str(self.lock), str(LOCK_GID), role],
            stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True, bufsize=1,
            env=dict(os.environ, PYTHONPATH=str(self.root)),
            preexec_fn=drop_to(uid))
        self.children.append(p)
        return p

    def line(self, p):
        ready, _, _ = select.select([p.stdout], [], [], 5)
        self.assertTrue(ready, 'child blocked unexpectedly')
        line = p.stdout.readline().strip()
        self.assertTrue(line, p.stderr.read() if p.poll() is not None else '')
        return line

    def test_cross_uid_lock_blocks_controller_until_writer_releases(self):
        a = self.start(WRITER_UID, 'holder')
        self.assertEqual(self.line(a), 'LOCKED')
        b = self.start(CONTROL_UID, 'waiter')
        self.assertEqual(self.line(b), 'WAITING')
        ready, _, _ = select.select([b.stdout], [], [], 0.3)
        self.assertFalse(ready, 'different UID bypassed exclusive lock')
        a.stdin.write('release\n')
        a.stdin.flush()
        self.assertEqual(self.line(b), 'ACQUIRED')
        self.assertEqual(a.wait(timeout=5), 0)
        self.assertEqual(b.wait(timeout=5), 0)

    def test_shared_group_cannot_replace_trusted_lock_inode(self):
        script = 'import os,sys;os.unlink(sys.argv[1])'
        for uid in (WRITER_UID, CONTROL_UID):
            result = subprocess.run(
                [sys.executable, '-B', '-c', script, str(self.lock)],
                preexec_fn=drop_to(uid), capture_output=True,
                text=True, timeout=5)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('PermissionError', result.stderr)
        self.assertTrue(self.lock.is_file())

    def test_replaced_inode_fails_closed(self):
        from koru_cross_uid_fence import ProvisionedCrossUidFence
        fence = ProvisionedCrossUidFence(str(self.lock), shared_gid=LOCK_GID)
        try:
            self.lock.unlink()
            self.lock.write_bytes(b'')
            os.chown(self.lock, 0, LOCK_GID)
            self.lock.chmod(0o660)
            with self.assertRaises(PermissionError):
                with fence:
                    self.fail('replaced inode must never be accepted')
        finally:
            fence.close()


if __name__ == '__main__':
    unittest.main()
