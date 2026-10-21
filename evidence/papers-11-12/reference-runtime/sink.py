"""Sink server: the external world. Durable ordered effect store with sink-side identity (exactly once).
argv: run_dir dedup(1|0). Every accepted effect is appended and F_FULLFSYNC'd before the reply."""
import json, os, socketserver, sys
from common import fullsync, read_lines
RUN, DEDUP = sys.argv[1], sys.argv[2] == '1'
P = os.path.join(RUN, 'sink.log')
class H(socketserver.StreamRequestHandler):
    def handle(self):
        m = json.loads(self.rfile.readline()); rows = read_lines(P); ids = {r['id'] for r in rows}
        if m['op'] == 'deliver':
            if DEDUP and m['id'] in ids: rep = {'ok': True, 'dup': True}
            else:
                with open(P, 'a') as fh: fh.write(json.dumps({'id': m['id'], 'value': m['value']}) + '\n'); fullsync(fh)
                rep = {'ok': True, 'dup': False}
        elif m['op'] == 'has': rep = {'has': m['id'] in ids}
        elif m['op'] == 'count': rep = {'n': len(rows)}
        else: rep = {'error': 'op'}
        self.wfile.write((json.dumps(rep) + '\n').encode())
socketserver.UnixStreamServer(os.path.join(RUN, 'sink.sock'), H).serve_forever()
