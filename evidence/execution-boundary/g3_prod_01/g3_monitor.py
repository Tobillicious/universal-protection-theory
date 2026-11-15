"""G3-PROD-01 bounded local writer reference monitor (Linux prototype).

A carefully scoped demonstration of a single-writer durable commit domain.
Not the existing UPT G3 gate; integration with its G-Mesh, X3 and permit
checks is a mandatory release blocker. No physical-world safety claim.
"""
import argparse
import hashlib
import json
import os
import socket
import socketserver
import sqlite3
import stat
import struct
import threading
import time
from pathlib import Path

MAX_MSG = 8192

def canonical(x):
    return json.dumps(x, sort_keys=True, separators=(',', ':'), allow_nan=False).encode()

def sha(data):
    return hashlib.sha256(data).hexdigest()


def read_request_frame(sock, *, max_bytes=MAX_MSG, total_timeout=1.0):
    """Read a single newline frame under an absolute monotonic deadline.

    Slow-trickle input cannot extend the deadline. The caller must deny
    the request without effect if this returns None.
    """
    deadline = time.monotonic() + total_timeout
    data = bytearray()
    while len(data) <= max_bytes:
        remaining = deadline - time.monotonic()
        if remaining <= 0:
            return None
        sock.settimeout(remaining)
        try:
            chunk = sock.recv(min(1024, max_bytes + 1 - len(data)))
        except (TimeoutError, OSError):
            return None
        if not chunk:
            return None
        data.extend(chunk)
        if b'\n' in chunk:
            if (len(data) > max_bytes or not data.endswith(b'\n')
                    or data.count(b'\n') != 1):
                return None
            return bytes(data)
    return None

class Store:
    def __init__(self, path, output_dir):
        self.output = Path(output_dir)
        self.output.mkdir(mode=0o700, parents=True, exist_ok=True)
        d = os.open(self.output, os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW)
        st = os.fstat(d)
        if st.st_uid != os.geteuid() or st.st_mode & 0o077:
            os.close(d)
            raise PermissionError('output directory must be owned by writer and mode 0700')
        self.dirfd = d
        self.db = sqlite3.connect(path, isolation_level=None, check_same_thread=False)
        self.db.execute('PRAGMA journal_mode=WAL')
        self.db.execute('PRAGMA synchronous=FULL')
        self.db.executescript('''
            CREATE TABLE IF NOT EXISTS authority(id INTEGER PRIMARY KEY CHECK(id=1),epoch INTEGER NOT NULL, halted INTEGER NOT NULL);
            INSERT OR IGNORE INTO authority VALUES(1,0,1);
            CREATE TABLE IF NOT EXISTS effect(id TEXT PRIMARY KEY, digest TEXT NOT NULL, epoch INTEGER NOT NULL, state TEXT NOT NULL);
        ''')
        self.lock = threading.RLock()
        # Restart always disarms: the issuing authority must explicitly re-arm.
        with self.lock:
            self.db.execute('BEGIN IMMEDIATE')
            try:
                self.db.execute('UPDATE authority SET epoch=epoch+1, halted=1 WHERE id=1')
                self.db.execute('COMMIT')
            except BaseException:
                self.db.execute('ROLLBACK'); raise

    def _authority(self):
        return self.db.execute('SELECT epoch, halted FROM authority WHERE id=1').fetchone()

    def arm(self):
        with self.lock:
            self.db.execute('BEGIN IMMEDIATE')
            try:
                self.db.execute('UPDATE authority SET epoch=epoch+1, halted=0 WHERE id=1')
                state = self._authority()
                self.db.execute('COMMIT')
                return {'ok': True, 'epoch':state[0]}
            except BaseException:
                self.db.execute('ROLLBACK'); raise

    def hold(self):
        with self.lock:
            self.db.execute('BEGIN IMMEDIATE')
            try:
                self.db.execute('UPDATE authority SET epoch=epoch+1, halted=1 WHERE id=1')
                self.db.execute('COMMIT')
                return {'ok':True,'code':'held'}
            except BaseException:
                self.db.execute('ROLLBACK'); raise

    def _file(self, name):
        return sha(name.encode()) + '.html'

    def _verify(self, filename, digest):
        try:
            fd = os.open(filename, os.O_RDONLY | os.O_NOFOLLOW, dir_fd=self.dirfd)
        except FileNotFoundError:
            return False
        try:
            st = os.fstat(fd)
            if not stat.S_ISREG(st.st_mode) or st.st_nlink != 1 or st.st_uid != os.geteuid() or st.st_mode & 0o077:
                return False
            h=hashlib.sha256()
            while True:
                b=os.read(fd,65536)
                if not b:break
                h.update(b)
            return h.hexdigest() == digest
        finally:
            os.close(fd)

    def inventory(self):
        with self.lock:
            records = self.db.execute('SELECT id,digest,state FROM effect').fetchall()
            expected = {self._file(i):(i,d,s) for i,d,s in records}
            present = set(os.listdir(self.dirfd))
            unexpected = present-set(expected)
            bad = [f for f in present & set(expected) if not self._verify(f,expected[f][1])]
            pending = [i for f,(i,d,s) in expected.items() if f not in present]
            if unexpected or bad:
                return {'ok':False,'code':'integrity_failure','unknown':len(unexpected),'invalid':len(bad)}
            return {'ok':True,'pending':pending,'committed':len(present)}

    def write(self, msg):
        """Authorized *prototype* command; currently only UID + epoch checked.
        Real integration MUST verify signed G3 permit, fresh mesh lease,
        bound policy, X3 evidence, exact event and human authorization.
        """
        if (type(msg) is not dict or set(msg) != {'op','id','html','epoch'}
                or msg['op'] != 'write'):
            return {'ok':False,'code':'schema'}
        event_id, html, epoch = msg['id'],msg['html'],msg['epoch']
        if type(event_id) is not str or not (1<=len(event_id)<=100) or type(html) is not str or len(html.encode())>4096 or type(epoch) is not int:
            return {'ok':False,'code':'schema'}
        content=html.encode('utf-8'); digest=sha(content)
        filename=self._file(event_id)
        with self.lock:
            status=self.inventory()
            if not status['ok']:return status
            # No unrelated new effects while prior committed intentions are unresolved.
            if any(i != event_id for i in status['pending']):
                return {'ok':False,'code':'unresolved_previous_effect'}
            e,halted = self._authority()
            if halted or e!=epoch:return {'ok':False,'code':'stale_or_halted'}
            row=self.db.execute('SELECT digest,epoch FROM effect WHERE id=?',(event_id,)).fetchone()
            if row and row != (digest,epoch):
                return {'ok':False,'code':'collision'}
            if not row:
                self.db.execute('BEGIN IMMEDIATE')
                try:
                    # Durable intent first; recovery never silently re-executes.
                    self.db.execute('INSERT INTO effect VALUES(?,?,?,?)',(event_id,digest,epoch,'INTENT'))
                    self.db.execute('COMMIT')
                except BaseException:
                    self.db.execute('ROLLBACK');raise
            if not self._verify(filename,digest):
                # Only an absent file may be newly created; malformed existing files fail.
                if filename in os.listdir(self.dirfd):return {'ok':False,'code':'integrity_failure'}
                # Write to an unpredictable private staging inode first.
                # The final name is published only after ALL bytes and the
                # staging inode have been fsynced. Link is no-overwrite.
                stage = '.stage-' + os.urandom(16).hex()
                fd = os.open(stage, os.O_WRONLY | os.O_CREAT | os.O_EXCL |
                             os.O_NOFOLLOW, 0o600, dir_fd=self.dirfd)
                try:
                    with os.fdopen(fd, 'wb', closefd=True) as stream:
                        stream.write(content)
                        stream.flush()
                        os.fsync(stream.fileno())
                    os.link(stage, filename, src_dir_fd=self.dirfd,
                            dst_dir_fd=self.dirfd, follow_symlinks=False)
                    os.fsync(self.dirfd)
                finally:
                    # Unexpected staging remnants after interruption are
                    # flagged by inventory and need trusted recovery review.
                    try:
                        os.unlink(stage, dir_fd=self.dirfd)
                    except FileNotFoundError:
                        pass
                os.fsync(self.dirfd)
            self.db.execute('BEGIN IMMEDIATE')
            try:
                self.db.execute("UPDATE effect SET state='COMMITTED' WHERE id=?",(event_id,))
                self.db.execute('COMMIT')
            except BaseException:
                self.db.execute('ROLLBACK');raise
            return {'ok':True,'code':'committed','epoch':e,'digest':digest}

    def close(self):
        self.db.close();os.close(self.dirfd)

class Handler(socketserver.BaseRequestHandler):
    def handle(self):
        self.request.settimeout(1)
        try:
            uid=struct.unpack('3i',self.request.getsockopt(socket.SOL_SOCKET,socket.SO_PEERCRED,12))[1]
            if uid not in self.server.allowed_uids:
                answer={'ok':False,'code':'peer_denied'}
            else:
                data = read_request_frame(self.request)
                if data is None:
                    answer={'ok':False,'code':'invalid_frame'}
                else:
                    try:
                        msg=json.loads(data)
                        # Only the write method is exposed to application UIDs.
                        answer=self.server.store.write(msg)
                    except (ValueError,TypeError,UnicodeDecodeError):
                        answer={'ok':False,'code':'invalid_request'}
            self.request.sendall(canonical(answer)+b'\n')
        except (TimeoutError,ConnectionError,OSError):pass

class Server(socketserver.ThreadingMixIn,socketserver.UnixStreamServer):
    daemon_threads=True
    def __init__(self,path,store,allowed_uids):
        if not hasattr(socket,'SO_PEERCRED'):raise RuntimeError('Linux required')
        self.store=store
        self.allowed_uids=frozenset(allowed_uids)
        self.semaphore=threading.BoundedSemaphore(8)
        super().__init__(path,Handler)
        os.chmod(path,0o660)
    def process_request(self,request,client_address):
        if not self.semaphore.acquire(blocking=False):
            request.close();return
        try:super().process_request(request,client_address)
        except BaseException:
            self.semaphore.release();raise
    def process_request_thread(self,request,client_address):
        try:super().process_request_thread(request,client_address)
        finally:self.semaphore.release()

def request(path,payload):
    with socket.socket(socket.AF_UNIX) as s:
        s.settimeout(2);s.connect(path);s.sendall(canonical(payload)+b'\n')
        data=b''
        while not data.endswith(b'\n') and len(data)<=MAX_MSG:
            x=s.recv(4096)
            if not x:break
            data+=x
        return json.loads(data)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--db',required=True);p.add_argument('--output',required=True);p.add_argument('--socket',required=True);p.add_argument('--uid',type=int,required=True)
    a=p.parse_args();store=Store(a.db,a.output)
    with Server(a.socket,store,{a.uid}) as server:
        print('DISARMED: arm requires trusted in-process authority; demo CLI cannot arm',flush=True)
        server.serve_forever()
