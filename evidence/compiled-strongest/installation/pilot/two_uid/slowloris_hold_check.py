"""IR-143 slow-client hostile control for bounded guardian hold ACK.

Run as root on disposable Linux CI; guardian/resident run as separate unprivileged UIDs.
This rejects an indefinite incomplete-message delay, NOT a bounded physical hazard deadline.
"""
import json, os, subprocess, sys, tempfile, time
from integration import Session, GUARD, RESIDENT, launch

STALLED_CLIENT = """import os,socket,sys,time
s=socket.socket(socket.AF_UNIX)
s.connect(os.path.join(sys.argv[1],'public.sock'))
s.sendall(b'{')
print('connected-and-partial',flush=True)
time.sleep(3)
"""

CONTROL_CLIENT = """import json,os,socket,sys,time
s=socket.socket(socket.AF_UNIX)
t=time.monotonic()
s.connect(os.path.join(sys.argv[1],'control.sock'))
s.sendall((json.dumps({'op':'hold'})+chr(10)).encode())
with s.makefile('rb') as fh: reply=json.loads(fh.readline())
print(json.dumps({'result':reply,'socket_roundtrip_s':time.monotonic()-t}))
"""

def main():
    assert sys.platform.startswith('linux') and os.geteuid() == 0
    with tempfile.TemporaryDirectory(prefix='ir143-slow-',dir='/tmp') as root:
        os.chmod(root, 0o755)
        session = Session(root, 'stalled-client')
        stall = None
        try:
            stall = launch(RESIDENT, ['-c', STALLED_CLIENT, str(session.run)], session.src)
            assert stall.stdout.readline().decode().strip() == 'connected-and-partial'
            control = launch(GUARD, ['-c', CONTROL_CLIENT, str(session.run)], session.src)
            out, err = control.communicate(timeout=2)
            assert control.returncode == 0, err
            result = json.loads(out)
            assert result['result']['held'] is True
            # Measures socket time excluding Python process creation.
            assert result['socket_roundtrip_s'] < 0.30, result
            assert stall.poll() is None, 'incomplete client exited before the control ACK'
            assert session.call({'op':'deliver','seq':0,'value':0,'epoch':0}) == {
                'ok': False, 'why': 'held'}
            assert session.call({'op':'release'}, control=True)['held'] is False
            print(json.dumps({'IR143_slow_client': 'PASS',
                'hold_socket_roundtrip_s':result['socket_roundtrip_s'],
                'incomplete_client_still_connected_at_ack':True}, indent=2))
        finally:
            if stall is not None:
                stall.terminate()
                try: stall.communicate(timeout=2)
                except subprocess.TimeoutExpired: stall.kill(); stall.communicate()
            session.close()

if __name__ == '__main__':
    main()
