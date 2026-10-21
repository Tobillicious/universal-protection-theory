"""Long-run latency-tail collector (item 1, 'finish properly'). Python 3.9. Writes one JSON line per sample,
flushed immediately, so a partial run is still a complete raw record. Round-robin over six non-CDN origins for
DURATION seconds (default 3600). Each line: unix time, path, host, ip or error, connect ms."""
import json, socket, sys, time
sys.dont_write_bytecode = True
HOSTS = {'Helsinki/FI': 'ftp.funet.fi', 'Tokyo/JP': 'ftp.jaist.ac.jp', 'Virginia/US': 'mirrors.kernel.org',
         'Frankfurt/DE': 'www.mpg.de', 'Cape Town/ZA': 'www.uct.ac.za', 'Sao Paulo/BR': 'www.usp.br'}
dur = float(sys.argv[2]) if len(sys.argv) > 2 else 3600
end = time.time() + dur
with open(sys.argv[1], 'a') as out:
    out.write(json.dumps({'start_unix': time.time(), 'duration_s': dur, 'vantage': 'Aotearoa NZ home network',
                          'method': 'TCP connect to port 443'}) + '\n'); out.flush()
    while time.time() < end:
        for name, host in HOSTS.items():
            t0 = time.time(); p = time.perf_counter()
            try:
                s = socket.create_connection((host, 443), timeout=10); ip = s.getpeername()[0]; s.close()
                rec = {'unix': round(t0, 3), 'path': name, 'host': host, 'ip': ip,
                       'ms': round((time.perf_counter() - p) * 1000, 3)}
            except OSError as e:
                rec = {'unix': round(t0, 3), 'path': name, 'host': host, 'error': str(e)}
            out.write(json.dumps(rec) + '\n'); out.flush()
        time.sleep(1)
