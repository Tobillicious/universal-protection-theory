"""Raw-record collector for the declared timing premises (UPT v1.5, Paper 11 TIMING-PREMISES). Python 3.9.
Every sample is saved: no summary is written without its raw values. Output: one JSON with all raw data.
R1 long-haul round trips: 20 TCP connects (port 443) to each non-CDN origin; each sample's time, IP, or error.
R2 clock: sntp against time.apple.com at t = 0, 120, 240, 360, 480, 600 s; every raw line and local timestamp.
The vantage is one Mac in Aotearoa New Zealand on a home network."""
import json, socket, subprocess, sys, time
sys.dont_write_bytecode = True
HOSTS = {'Helsinki/FI': 'ftp.funet.fi', 'Tokyo/JP': 'ftp.jaist.ac.jp', 'Virginia/US': 'mirrors.kernel.org',
         'Frankfurt/DE': 'www.mpg.de', 'Cape Town/ZA': 'www.uct.ac.za', 'Sao Paulo/BR': 'www.usp.br'}
rec = {'collector': 'collect.py', 'vantage': 'Aotearoa New Zealand, home network',
       'start_utc': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()), 'rtt': {}, 'sntp': []}
for name, host in HOSTS.items():
    samples = []
    for k in range(20):
        t0 = time.time(); p = time.perf_counter()
        try:
            s = socket.create_connection((host, 443), timeout=10); ip = s.getpeername()[0]; s.close()
            samples.append({'k': k, 'unix': round(t0, 3), 'ip': ip, 'ms': round((time.perf_counter() - p) * 1000, 3)})
        except OSError as e:
            samples.append({'k': k, 'unix': round(t0, 3), 'error': str(e)})
        time.sleep(0.2)
    rec['rtt'][name] = {'host': host, 'samples': samples}
t_start = time.time()
for target in (0, 120, 240, 360, 480, 600):
    while time.time() - t_start < target: time.sleep(1)
    r = subprocess.run(['sntp', 'time.apple.com'], capture_output=True, text=True, timeout=60)
    rec['sntp'].append({'unix': round(time.time(), 3), 'stdout': r.stdout, 'stderr': r.stderr, 'exit': r.returncode})
rec['end_utc'] = time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())
print(json.dumps(rec, indent=1))
