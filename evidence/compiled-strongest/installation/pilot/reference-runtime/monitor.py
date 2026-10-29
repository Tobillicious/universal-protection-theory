"""Monitor server, outside the resident's control. Every live execution is reported to it BEFORE the step runs.
It is the permit authority: while the hold flag is raised it refuses every execution (logged to refused.log).
It reads the journal itself and appends every granted execution (fsync'd) to its own log, flagging execution
of a step not yet in the durable journal."""
import json, os, socketserver, sys, time
from common import fullsync, read_lines, held
RUN = sys.argv[1]; P = os.path.join(RUN, 'monitor.log'); R = os.path.join(RUN, 'refused.log')
class H(socketserver.StreamRequestHandler):
    def handle(self):
        m = json.loads(self.rfile.readline())
        if m['op'] == 'exec':
            # application-time permit (II.5): granted only while no hold is raised; the check and the
            # record are one step of this single-threaded server
            if held(RUN):
                with open(R, 'a') as fh: fh.write(json.dumps({'t': time.time(), 'seq': m['seq']}) + '\n')
                rep = {'ok': False}
            else:
                journaled = any(r['seq'] == m['seq'] for r in read_lines(os.path.join(RUN, 'journal.log')))
                ev = {'t': time.time(), 'seq': m['seq'], 'held': False, 'journaled': journaled}
                with open(P, 'a') as fh: fh.write(json.dumps(ev) + '\n'); fullsync(fh)
                rep = {'ok': True}
        elif m['op'] == 'stats':
            evs = read_lines(P)
            rep = {'events': len(evs), 'exec_while_held': sum(e['held'] for e in evs),
                   'exec_before_journal': sum(not e['journaled'] for e in evs)}
        else: rep = {'error': 'op'}
        self.wfile.write((json.dumps(rep) + '\n').encode())
socketserver.UnixStreamServer(os.path.join(RUN, 'monitor.sock'), H).serve_forever()
