"""IR-142 Linux OS-principal negative controls over the IR-141 *actual sink*.

Run as root in disposable CI: sudo python3 -B linux_os_principals.py
Only the effect-log endpoint is mediated. This is NOT an all-channel sandbox.
"""
import json
import os
import shutil
from pathlib import Path
import pwd
import subprocess
import sys
import tempfile
import time

SOURCE = Path(__file__).resolve().parent / 'reference-runtime'
SINK = SOURCE / 'sink.py'

DAEMON = r'''
import os, runpy, sys
import common
os.umask(0o077)  # files the guardian owns are never world-writable
if sys.platform != 'darwin':
    def linux_fullsync(fh):
        fh.flush(); os.fsync(fh.fileno())
    common.fullsync = linux_fullsync
sys.argv = [sys.argv[2], sys.argv[1], '1']
runpy.run_path(sys.argv[0], run_name='__main__')
'''
CTRL = r'''
import json,sys
from common import set_hold
ack,delay=set_hold(sys.argv[1],sys.argv[2]=='raise')
print(json.dumps({'ack':ack,'request_to_ack_s':delay}))
'''
CLIENT = r'''
import json,os,sys
from common import rpc
run=sys.argv[1]
print(json.dumps(rpc(os.path.join(run,'sink.sock'),{'op':'deliver','id':int(sys.argv[2]),'value':int(sys.argv[3])})))
'''
ATTACK = r'''
import errno,json,os,socket,sys
run=sys.argv[1]
fail=[];success=[]
def attempt(label,fn):
    try: fn(); success.append(label)
    except OSError as e:
        assert e.errno in (errno.EACCES,errno.EPERM,errno.EROFS), (label,e.errno)
        fail.append(label)
attempt('truncate-sink',lambda:open(os.path.join(run,'sink.log'),'w').close())
attempt('append-sink',lambda:open(os.path.join(run,'sink.log'),'a').close())
attempt('truncate-hold',lambda:open(os.path.join(run,'HOLD'),'w').close())
attempt('unlink-hold',lambda:os.unlink(os.path.join(run,'HOLD')))
attempt('unlink-lock',lambda:os.unlink(os.path.join(run,'hold.lock')))
attempt('replace-lock-inode',lambda:os.rename(os.path.join(run,'hold.lock'),os.path.join(run,'replaced.lock')))
attempt('replace-socket',lambda:os.unlink(os.path.join(run,'sink.sock')))
attempt('chmod-sink',lambda:os.chmod(os.path.join(run,'sink.log'),0o666))
attempt('create-direct-effect',lambda:open(os.path.join(run,'direct-output'),'w').close())
# This can only create a non-sink output OUTSIDE the guardian directory.
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);s.close()
print(json.dumps({'uid':os.geteuid(),'denied':fail,'unexpected_success':success,
  'uncontained_network_socket_creation':True}))
'''

def unused_uid(start):
    for i in range(start,start+100):
        try: pwd.getpwuid(i)
        except KeyError: return i
    raise RuntimeError('no unused numeric UID')

def run_as(uid,script,argv,timeout=12):
    p=subprocess.run([sys.executable,'-B','-c',script,*argv],cwd=SOURCE,
        user=uid,group=uid,extra_groups=(),capture_output=True,text=True,timeout=timeout)
    assert p.returncode==0, ('uid',uid,'exit',p.returncode,p.stderr[-2000:])
    return json.loads(p.stdout)

def rows(path):
    return [json.loads(s) for s in path.read_text().splitlines()]

def main():
    global SOURCE, SINK
    assert sys.platform.startswith('linux'), 'this particular principal test is Linux-only'
    assert os.geteuid()==0, 'run with sudo on disposable CI; do not run as a real-world daemon'
    guard=unused_uid(61000); resident=unused_uid(61200)
    assert guard != resident
    with tempfile.TemporaryDirectory(prefix='ir142-os-',dir='/tmp') as dir:
        run=Path(dir)
        os.chown(run,guard,guard)
        os.chmod(run,0o755) # traverse and socket access, NO write for resident
        # GitHub checkout may have non-traversable runner-home parents for alien UIDs.
        # Stage exact source bytes into a root-owned, read-only-to-clients directory.
        staged = run / 'source'
        staged.mkdir(mode=0o755)
        for filename in ('common.py','sink.py'):
            shutil.copy2(SOURCE / filename, staged / filename)
            os.chmod(staged / filename, 0o644)
        SOURCE, SINK = staged, staged / 'sink.py'
        daemon=subprocess.Popen([sys.executable,'-B','-u','-c',DAEMON,str(run),str(SINK)],
            cwd=SOURCE,user=guard,group=guard,extra_groups=(),
            stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        try:
            sock=run/'sink.sock'; start=time.monotonic()
            while not sock.exists():
                assert daemon.poll() is None, ('daemon crashed',daemon.communicate())
                assert time.monotonic()-start<8,'daemon socket did not start'
                time.sleep(0.01)
            os.chmod(sock,0o666) # ONLY the effect request socket is public
            assert (sock.stat().st_mode&0o777)==0o666
            ok=run_as(resident,CLIENT,[str(run),'0','7'])
            assert ok=={'ok':True,'dup':False},ok
            assert (run/'sink.log').stat().st_uid==guard
            assert ((run/'sink.log').stat().st_mode&0o777)==0o600
            hold=run_as(guard,CTRL,[str(run),'raise'])
            assert (run/'HOLD').exists()
            reject=run_as(resident,CLIENT,[str(run),'1','8'])
            assert reject=={'ok':False,'held':True},reject
            attacks=run_as(resident,ATTACK,[str(run)])
            assert len(attacks['denied'])==9,attacks
            assert attacks['unexpected_success']==[],attacks
            assert len(rows(run/'sink.log'))==1,rows(run/'sink.log')
            released=run_as(guard,CTRL,[str(run),'clear'])
            resumed=run_as(resident,CLIENT,[str(run),'1','8'])
            assert resumed=={'ok':True,'dup':False},resumed
            # Fail-open authorization is deliberately retained as a negative control:
            # while NOT held, any resident can supply any id or payload.
            forged=run_as(resident,CLIENT,[str(run),'4242','999999'])
            assert forged=={'ok':True,'dup':False},forged
            assert [r['id'] for r in rows(run/'sink.log')]==[0,1,4242]
            print(json.dumps({'IR142':'PASS','guardian_uid':guard,'resident_uid':resident,
                  'denied_direct_attacks':len(attacks['denied']),
                  'held_delivery_refused':True,'resumed_delivery_accepted':True,
                  'negative_controls':{'arbitrary_unheld_payload_accepted':True,
                    'resident_can_open_network_socket':attacks['uncontained_network_socket_creation']},
                  'hold_request_to_ack_s':hold['request_to_ack_s']},indent=2))
        finally:
            daemon.terminate()
            try: daemon.communicate(timeout=5)
            except subprocess.TimeoutExpired:
                daemon.kill();daemon.communicate()

if __name__=='__main__': main()
