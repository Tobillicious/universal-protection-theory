"""Item 2, state transfer. Python 3.9. Raw per-chunk / per-transfer records, one JSON line each, flushed.
local:   write 256 chunks of 4 MiB (1 GiB) to a fresh file, timing each write, then one F_FULLFSYNC; report the
         durable sequential throughput; then read it back with F_NOCACHE (uncached) timing each chunk.
network: fetch the first 64 MiB (HTTP Range) of a large file from each far, non-CDN mirror with curl, recording
         curl's own timings and byte counts, three times each."""
import fcntl, json, os, subprocess, sys, tempfile, time
sys.dont_write_bytecode = True
mode, path = sys.argv[1], sys.argv[2]
out = open(path, 'a')
def w(r): out.write(json.dumps(r) + '\n'); out.flush()
if mode == 'local':
    d = tempfile.mkdtemp(dir=os.path.expanduser('~')); p = os.path.join(d, 'state.bin'); buf = os.urandom(4 << 20)
    w({'mode': 'local', 'start_unix': time.time(), 'chunks': 256, 'chunk_bytes': 4 << 20})
    t_all = time.perf_counter()
    with open(p, 'wb') as f:
        for k in range(256):
            t = time.perf_counter(); f.write(buf); w({'write_chunk': k, 'ms': round((time.perf_counter() - t) * 1000, 3)})
        t = time.perf_counter(); f.flush(); fcntl.fcntl(f.fileno(), fcntl.F_FULLFSYNC)
        w({'fullfsync_ms': round((time.perf_counter() - t) * 1000, 3)})
    total = time.perf_counter() - t_all
    w({'durable_write_total_s': round(total, 4), 'durable_MB_per_s': round(1024 / total, 2)})
    fd = os.open(p, os.O_RDONLY); fcntl.fcntl(fd, fcntl.F_NOCACHE, 1); t_all = time.perf_counter()
    for k in range(256):
        t = time.perf_counter(); os.read(fd, 4 << 20); w({'read_chunk': k, 'ms': round((time.perf_counter() - t) * 1000, 3)})
    total = time.perf_counter() - t_all; os.close(fd); os.remove(p); os.rmdir(d)
    w({'uncached_read_total_s': round(total, 4), 'uncached_read_MB_per_s': round(1024 / total, 2)})
else:
    URLS = {'Virginia/US': 'https://mirrors.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz',
            'Tokyo/JP': 'https://ftp.jaist.ac.jp/pub/Linux/kernel.org/linux/kernel/v6.x/linux-6.1.tar.xz',
            'Helsinki/FI': 'https://ftp.funet.fi/pub/mirrors/ftp.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz'}
    w({'mode': 'network', 'start_unix': time.time(), 'range_bytes': 64 << 20})
    for rep in range(3):
        for name, url in URLS.items():
            r = subprocess.run(['curl', '-s', '-o', '/dev/null', '--max-time', '300', '-r', '0-67108863', '-w',
                                '%{http_code} %{size_download} %{time_connect} %{time_starttransfer} %{time_total} %{speed_download} %{remote_ip}', url],
                               capture_output=True, text=True)
            f = r.stdout.split()
            w({'rep': rep, 'path': name, 'url': url, 'exit': r.returncode, 'raw': r.stdout,
               'http': f[0] if f else None, 'bytes': int(f[1]) if len(f) > 1 else None,
               'total_s': float(f[4]) if len(f) > 4 else None,
               'MB_per_s': round(float(f[5]) / 1e6, 3) if len(f) > 5 else None, 'ip': f[6] if len(f) > 6 else None})
