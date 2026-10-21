"""Item 3, the cryptographic part of an attestation, measured on this Mac (Python 3.9, cryptography 46.0.3).
Per-operation timings, every one saved: 5,000 signs and 5,000 verifies each for ECDSA P-256 (SHA-256) and Ed25519,
over a 64-byte quote-sized message; plus SHA-256 over 64 MiB of state, 20 times. The hardware quote itself
(TPM or TEE) is NOT measurable here."""
import hashlib, json, os, statistics, sys, time
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import ec, ed25519
sys.dont_write_bytecode = True
out = open(sys.argv[1], 'a')
def w(r): out.write(json.dumps(r) + '\n'); out.flush()
msg = os.urandom(64); N = 5000
def run(name, sign, verify):
    sigs, ts, tv = [], [], []
    for _ in range(N):
        t = time.perf_counter(); s = sign(); ts.append((time.perf_counter() - t) * 1e6); sigs.append(s)
    for s in sigs:
        t = time.perf_counter(); verify(s); tv.append((time.perf_counter() - t) * 1e6)
    w({'scheme': name, 'sign_us': [round(x, 2) for x in ts], 'verify_us': [round(x, 2) for x in tv]})
    for k, v in (('sign', ts), ('verify', tv)):
        v = sorted(v); w({'scheme': name, 'op': k, 'n': N, 'median_us': round(statistics.median(v), 2),
                          'p99_us': round(v[int(0.99 * (N - 1))], 2), 'max_us': round(v[-1], 2)})
w({'start_unix': time.time(), 'library': 'cryptography 46.0.3', 'message_bytes': 64})
k = ec.generate_private_key(ec.SECP256R1()); pub = k.public_key()
run('ECDSA-P256-SHA256', lambda: k.sign(msg, ec.ECDSA(hashes.SHA256())),
    lambda s: pub.verify(s, msg, ec.ECDSA(hashes.SHA256())))
e = ed25519.Ed25519PrivateKey.generate(); epub = e.public_key()
run('Ed25519', lambda: e.sign(msg), lambda s: epub.verify(s, msg))
blob = os.urandom(64 << 20); hs = []
for _ in range(20):
    t = time.perf_counter(); hashlib.sha256(blob).digest(); hs.append(time.perf_counter() - t)
w({'sha256_64MiB_s': [round(x, 4) for x in hs], 'sha256_MB_per_s_median': round(64 * 1.048576 / statistics.median(hs), 1)})
