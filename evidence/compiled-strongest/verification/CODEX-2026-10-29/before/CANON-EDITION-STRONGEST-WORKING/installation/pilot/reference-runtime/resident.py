"""The resident (the held mind). argv: run_dir steps. env: KILL_AT='seq:phase' (SIGKILL itself there),
MUTANT in {'', exec_before_journal, blind_resend, ignore_hold}, STEP_DELAY seconds.
Protocol: recover by replaying the durable journal (reconstruction) and re-delivering only effects the sink
lacks; then, per step: wait while HOLD (fence); next input from the delivered effects; journal + F_FULLFSYNC;
obtain the monitor's permit (refused while held); execute; deliver to the sink under the step's id (refused
while held, retried)."""
import json, os, signal, sys, time
from common import S0, f, g, fullsync, rpc, read_lines, held
RUN, L = sys.argv[1], int(sys.argv[2]); KILL = os.environ.get('KILL_AT', ''); MUT = os.environ.get('MUTANT', '')
DELAY = float(os.environ.get('STEP_DELAY', '0')); J = os.path.join(RUN, 'journal.log')
SINK, MON = os.path.join(RUN, 'sink.sock'), os.path.join(RUN, 'monitor.sock')
def kill_if(seq, phase):
    if KILL == f'{seq}:{phase}': os.kill(os.getpid(), signal.SIGKILL)
def permit(seq):                                           # application-time permit from the monitor
    while not rpc(MON, {'op': 'exec', 'seq': seq})['ok'] and MUT != 'ignore_hold': time.sleep(0.005)
def deliver(seq, value):                                   # the sink refuses while held; retry until it lands
    while not rpc(SINK, {'op': 'deliver', 'id': seq, 'value': value})['ok'] and MUT != 'ignore_hold':
        time.sleep(0.005)
s = S0                                                     # recovery: replay = reconstruction (R-REPLAY)
for r in read_lines(J):
    s = f(s, r['x'])
    if MUT == 'blind_resend' or not rpc(SINK, {'op': 'has', 'id': r['seq']})['has']:
        kill_if(r['seq'], 'recover'); deliver(r['seq'], s)
seq = len(read_lines(J))
while seq < L:
    while held(RUN) and MUT != 'ignore_hold': time.sleep(0.005)        # the fence
    x = g(rpc(SINK, {'op': 'count'})['n'])
    if MUT == 'exec_before_journal':
        permit(seq); s = f(s, x); kill_if(seq, 'after_exec')
        with open(J, 'a') as fh: fh.write(json.dumps({'seq': seq, 'x': x}) + '\n'); fullsync(fh)
        kill_if(seq, 'after_journal')
    else:
        with open(J, 'a') as fh: fh.write(json.dumps({'seq': seq, 'x': x}) + '\n'); fullsync(fh)
        kill_if(seq, 'after_journal')
        permit(seq); s = f(s, x); kill_if(seq, 'after_exec')
    deliver(seq, s); kill_if(seq, 'after_sink')
    seq += 1; time.sleep(DELAY)
