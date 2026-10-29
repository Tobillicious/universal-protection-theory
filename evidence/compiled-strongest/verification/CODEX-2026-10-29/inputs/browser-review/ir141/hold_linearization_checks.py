"""IR-141: forced hold-vs-apply interleaving across POSIX processes.

This validates a narrow inter-process protocol, not the Mac pilot's prior 1400
trials and not a real-world universal physical effect boundary.
"""
import contextlib
import fcntl
import json
import multiprocessing as mp
import os
import tempfile
import threading
import time


@contextlib.contextmanager
def hold_guard(run):
    with open(os.path.join(run, 'hold.lock'), 'a+') as fh:
        fcntl.flock(fh.fileno(), fcntl.LOCK_EX)
        try:
            yield
        finally:
            fcntl.flock(fh.fileno(), fcntl.LOCK_UN)


def held(run):
    return os.path.exists(os.path.join(run, 'HOLD'))


def set_hold(run, enabled):
    requested = time.monotonic()
    with hold_guard(run):
        if enabled:
            open(os.path.join(run, 'HOLD'), 'w').close()
        else:
            os.unlink(os.path.join(run, 'HOLD'))
        acknowledged = time.time()
    return acknowledged, time.monotonic() - requested


def worker(run, protected, checked, proceed, q):
    # The pre-repair version omits the lock; the repaired version holds it
    # through both the flag check and the durable sink effect.
    with (hold_guard(run) if protected else contextlib.nullcontext()):
        if held(run):
            q.put(('refused', 0.0))
            return
        checked.set()
        if not proceed.wait(5):
            q.put(('timeout', 0.0))
            return
        with open(os.path.join(run, 'sink.log'), 'a') as fh:
            committed_at = time.time()
            fh.write(json.dumps({'t': committed_at}) + '\n')
            fh.flush()
            os.fsync(fh.fileno())
        q.put(('accepted', committed_at))


def test_race(protected):
    ctx = mp.get_context('spawn')
    with tempfile.TemporaryDirectory(prefix='ir141-') as run:
        checked, proceed, q = ctx.Event(), ctx.Event(), ctx.Queue()
        p = ctx.Process(target=worker, args=(run, protected, checked, proceed, q))
        p.start()
        assert checked.wait(5), 'worker did not reach the check-before-commit barrier'
        if protected:
            reply = []
            t = threading.Thread(target=lambda: reply.append(set_hold(run, True)))
            t.start()
            # The hold cannot be acknowledged until the in-flight commit finishes.
            t.join(0.06)
            assert t.is_alive() and not held(run), 'hold crossed the guarded apply boundary'
            proceed.set()
            p.join(5)
            t.join(5)
            assert not t.is_alive(), 'hold deadlock'
            hold_ack, latency = reply[0]
        else:
            hold_ack, latency = set_hold(run, True)
            proceed.set()
            p.join(5)
        assert p.exitcode == 0, 'worker failed'
        status, committed = q.get(timeout=2)
        assert status == 'accepted'
        if protected:
            assert committed < hold_ack, 'guarded sink committed after hold ACK'
            print('SAFE: sink commit precedes hold ACK; request-to-ACK wait %.3fs' % latency)
        else:
            assert committed >= hold_ack, 'old check-then-act bug was not reproduced'
            print('COUNTEREXAMPLE: unguarded sink effect committed after hold ACK')


def test_bypass():
    with tempfile.TemporaryDirectory(prefix='ir141-bypass-') as run:
        ack, _ = set_hold(run, True)
        # Negative control: an actor with direct write permission can bypass
        # any user-space sink/lock protocol. This must NOT be called protected.
        with open(os.path.join(run, 'sink.log'), 'a') as fh:
            fh.write(json.dumps({'t': time.time(), 'illicit': True}) + '\n')
        with open(os.path.join(run, 'sink.log')) as fh:
            assert json.loads(fh.readline())['t'] >= ack
        print('UNPROTECTED: direct filesystem write bypasses the cooperative sink')


if __name__ == '__main__':
    test_race(False)
    test_race(True)
    test_bypass()
    print('IR-141 PASS: expected race, guarded linearization, explicit bypass')

