"""Basic timing side-channel sanity check (not a full physical audit)."""
import time
import hashlib
import statistics

samples = []
for _ in range(1000):
    start = time.perf_counter()
    # trivial work
    hashlib.sha256(b"test").hexdigest()
    samples.append((time.perf_counter() - start) * 1e6)

mean = statistics.mean(samples)
stdev = statistics.stdev(samples)
print(f"mean={mean:.2f}us stdev={stdev:.2f}us")
if stdev > mean * 0.5:
    print("WARNING: high timing variance; investigate side-channel exposure")
else:
    print("OK: timing variance within basic tolerance")
