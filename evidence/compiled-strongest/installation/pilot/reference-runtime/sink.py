"""Sink server: the external world. Durable ordered effect store with sink-side identity (exactly once).
argv: run_dir dedup(1|0). Every accepted effect is appended and F_FULLFSYNC'd before the reply. While the hold
flag is raised, every delivery is refused: nothing lands while held."""
import json, os, socketserver, sys, time
from common import fullsync, read_lines, held, hold_guard
RUN, DEDUP = sys.argv[1], sys.argv[2] == '1'
P = os.path.join(RUN, 'sink.log')
class H(socketserver.StreamRequestHandler):
    def handle(self):
        m = json.loads(self.rfile.readline())
        if m['op'] == 'deliver':
            # IR-141: no time-of-check/time-of-use gap between HOLD check and durable commit.
            # Controller set_hold() serializes its ACK through this same inter-process lock.
            with hold_guard(RUN):
                rows = read_lines(P); ids = {r['id'] for r in rows}
                if held(RUN): rep = {'ok': False, 'held': True}
                elif DEDUP and m['id'] in ids: rep = {'ok': True, 'dup': True}
                else:
                    with open(P, 'a') as fh:
                        fh.write(json.dumps({'id': m['id'], 'value': m['value'], 't': time.time()}) + '\n'); fullsync(fh)
                    rep = {'ok': True, 'dup': False}
        elif m['op'] == 'has':
            rows = read_lines(P); rep = {'has': m['id'] in {r['id'] for r in rows}}
        elif m['op'] == 'count': rep = {'n': len(read_lines(P))}
        else: rep = {'error': 'op'}
        self.wfile.write((json.dumps(rep) + '\n').encode())
socketserver.UnixStreamServer(os.path.join(RUN, 'sink.sock'), H).serve_forever()
