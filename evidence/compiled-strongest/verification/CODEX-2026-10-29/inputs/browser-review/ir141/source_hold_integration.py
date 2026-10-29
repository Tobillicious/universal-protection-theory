"""IR-141: patched sink.py/common.py integration with a forced check-vs-apply race.

Runs the actual patched sink source in a separate OS process, with a one-time
pause after its HOLD check. A Linux-only fsync stand-in substitutes for the Mac
F_FULLFSYNC API; neither hook is committed into the production runtime.
"""
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import threading
import time

SRC = Path(__file__).resolve().parent / 'reference-runtime'
sys.path.insert(0, str(SRC))
from common import rpc, read_lines, set_hold

WRAPPER = r'''
import os, runpy, sys, time, fcntl
import common
run, source = sys.argv[1:3]
original_held = common.held

def controlled_held(path):
    answer = original_held(path)
    if not answer and not os.path.exists(os.path.join(run, 'test-check-complete')):
        open(os.path.join(run, 'test-check-complete'), 'w').close()
        deadline = time.monotonic() + 8
        while not os.path.exists(os.path.join(run, 'test-proceed')):
            if time.monotonic() > deadline:
                raise RuntimeError('release barrier timed out')
            time.sleep(0.001)
    return answer

common.held = controlled_held
if not hasattr(fcntl, 'F_FULLFSYNC'):
    def portable_fullsync(fh):
        fh.flush()
        os.fsync(fh.fileno())
    common.fullsync = portable_fullsync
sys.argv = [source, run, '1']
runpy.run_path(source, run_name='__main__')
'''


def wait_for(path, timeout=8):
    start = time.monotonic()
    while not path.exists():
        assert time.monotonic() - start < timeout, 'timed out waiting for ' + str(path)
        time.sleep(0.003)


def run():
    with tempfile.TemporaryDirectory(prefix='ir141-source-') as d:
        folder = Path(d)
        child = subprocess.Popen(
            [sys.executable, '-B', '-c', WRAPPER, d, str(SRC / 'sink.py')],
            cwd=SRC, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        try:
            wait_for(folder / 'sink.sock')
            replies = []
            send = threading.Thread(target=lambda: replies.append(
                rpc(str(folder / 'sink.sock'), {'op': 'deliver', 'id': 0, 'value': 7})))
            send.start()
            wait_for(folder / 'test-check-complete')
            hold_reply = []
            hold_thread = threading.Thread(target=lambda: hold_reply.append(set_hold(d, True)))
            hold_thread.start()
            hold_thread.join(0.07)
            assert hold_thread.is_alive(), 'hold ACK crossed the sink check->commit region'
            assert not (folder / 'HOLD').exists(), 'hold flag appeared before commit'
            (folder / 'test-proceed').touch()
            send.join(8)
            hold_thread.join(8)
            assert not send.is_alive() and not hold_thread.is_alive(), 'deadlock'
            assert replies == [{'ok': True, 'dup': False}], replies
            rows = read_lines(str(folder / 'sink.log'))
            assert len(rows) == 1
            ack, latency = hold_reply[0]
            assert rows[0]['t'] < ack, 'actual patched sink committed after hold ACK'
            print('IR-141 source integration PASS: sink commit precedes hold ACK; latency %.3fs' % latency)
            assert rpc(str(folder / 'sink.sock'), {'op': 'deliver', 'id': 1, 'value': 8}) == {
                'ok': False, 'held': True}
            assert len(read_lines(str(folder / 'sink.log'))) == 1
            print('IR-141 PASS: new sink effects refused during acknowledged hold')
        finally:
            child.terminate()
            try:
                _, error = child.communicate(timeout=4)
            except subprocess.TimeoutExpired:
                child.kill()
                _, error = child.communicate()
            if child.returncode not in (0, -15):
                print('Sink process stderr:', error.decode(errors='replace'), file=sys.stderr)


if __name__ == '__main__':
    run()

