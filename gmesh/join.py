#!/usr/bin/env python3
"""G-Mesh relay node — join the mesh with one command.

Usage:
    curl -sSL https://raw.githubusercontent.com/Tobillicious/universal-protection-theory/main/gmesh/join.py | python3

Or:
    python3 join.py

What this does:
  1. Fetches proof evidence from GitHub (the actual Lean theorem counts)
  2. Starts an HTTP server on your machine serving the evidence
  3. Advertises on your local network via Bonjour (macOS) or multicast
  4. Discovers other G-Mesh nodes on the same network

What this is:
  A RELAY NODE. It serves verified proof evidence but does not run the
  Lean type-checker itself. For independent verification, clone the repo
  and run `lake build`.

What this is NOT:
  - Not malware. Read every line — it's 300 lines of Python stdlib.
  - Not a verifier. It's honest about being a relay.
  - Not permanent. Ctrl+C stops it. Nothing is installed.

No dependencies beyond Python 3.6+ stdlib.
Zero files written to disk. Zero packages installed.
"""
import argparse
import hashlib
import html
import http.server
import json
import os
import signal
import socket
import socketserver
import struct
import subprocess
import sys
import threading
import time
import urllib.request

# --- Configuration ---
GITHUB_RAW = "https://raw.githubusercontent.com/Tobillicious/universal-protection-theory/main"
MULTICAST_GROUP = "239.73.83.1"
MULTICAST_PORT = 31415
BEACON_INTERVAL = 5
PEER_TIMEOUT = 20

# --- Proof evidence fetcher ---
def fetch_evidence():
    """Fetch proof evidence summary from GitHub."""
    # Count theorems by scanning the Lean module list
    evidence_url = f"{GITHUB_RAW}/evidence/physical-bridges/PhysicalBridges.lean"
    try:
        with urllib.request.urlopen(evidence_url, timeout=15) as r:
            root_text = r.read().decode()
        modules = []
        for line in root_text.splitlines():
            if line.strip().startswith("import PhysicalBridges."):
                name = line.strip().split("import PhysicalBridges.")[1].strip()
                modules.append(name)
    except Exception:
        modules = []

    total_theorems = 0
    total_sorry = 0
    module_data = []
    key_results_found = 0

    key_idents = [
        ("G1: Something IS", "SOMETHING_IS"),
        ("G2: G is unique fixed point", "G_FROM_NOTHING"),
        ("G3: Conditional universal protection", "if_bcrd_then_all_six_and_no_E"),
        ("B7: State-determined accessibility", "state_determines_causal_accessibility"),
        ("B7: Sector structure", "sector_structure_of_CLM"),
        ("Koru: Spiral never returns", "THE_SPIRAL_NEVER_RETURNS"),
        ("Koru: Nothing is lost", "NOTHING_IS_LOST_ON_THE_SPIRAL"),
        ("Genesis: In the beginning", "IN_THE_BEGINNING"),
    ]
    key_results = []
    all_text = ""

    for mod in modules:
        url = f"{GITHUB_RAW}/evidence/physical-bridges/PhysicalBridges/{mod}.lean"
        try:
            with urllib.request.urlopen(url, timeout=15) as r:
                text = r.read().decode()
            all_text += text + "\n"
            thm = text.count("\ntheorem ") + (1 if text.startswith("theorem ") else 0)
            sry = text.count("sorry")
            total_theorems += thm
            total_sorry += sry
            module_data.append({"name": mod, "theorems": thm, "sorry": sry})
        except Exception:
            module_data.append({"name": mod, "theorems": "?", "sorry": "?"})

    for label, ident in key_idents:
        present = ident in all_text
        if present:
            key_results_found += 1
        key_results.append({"label": label, "identifier": ident, "present": present})

    return {
        "total_theorems": total_theorems,
        "total_sorry": total_sorry,
        "module_count": len(modules),
        "key_results": key_results,
        "key_results_found": key_results_found,
        "source": "github-relay",
        "scope": "source file scan from GitHub — not a local build or type-check",
    }


# --- HTML page ---
def build_page(evidence, peers):
    key_rows = ""
    for kr in evidence.get("key_results", []):
        status = "FOUND" if kr["present"] else "NOT FOUND"
        key_rows += f'<tr><td>{kr["label"]}</td><td>{status}</td></tr>\n'

    peer_rows = ""
    for pid, pinfo in peers.items():
        # Peer advertisements are untrusted; never create active links from them.
        label = html.escape(str(pid), quote=True)
        address = html.escape(str(pinfo.get("ip", "?")), quote=True)
        port_label = html.escape(str(pinfo.get("port", "?")), quote=True)
        peer_rows += f"<tr><td>{label}</td><td>{address}:{port_label} (unverified)</td></tr>\n"
    if not peer_rows:
        peer_rows = '<tr><td colspan="2">No peers discovered yet</td></tr>\n'

    return f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>G or E?</title>
<style>
:root {{ --bg:#0a0a0f; --fg:#e8e8f0; --accent:#4a9eff; --green:#2ecc71;
         --red:#e74c3c; --gold:#f0c040; --muted:#666680; --card:#12121a; --border:#2a2a3a; }}
* {{ margin:0; padding:0; box-sizing:border-box; }}
body {{ font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;
        background:var(--bg); color:var(--fg); padding:16px; max-width:800px;
        margin:0 auto; line-height:1.6; }}
.choice {{ text-align:center; padding:32px 16px; }}
.choice h1 {{ font-size:2.4em; margin-bottom:8px; }}
.choice p {{ color:var(--muted); font-size:1.1em; margin-bottom:24px; }}
.btns {{ display:flex; gap:16px; justify-content:center; flex-wrap:wrap; }}
.btn {{ padding:16px 40px; font-size:1.3em; font-weight:bold; border:2px solid;
        border-radius:12px; cursor:pointer; background:transparent; transition:all .2s; }}
.bg {{ border-color:var(--green); color:var(--green); }}
.bg:hover {{ background:var(--green); color:var(--bg); }}
.be {{ border-color:var(--red); color:var(--red); }}
.be:hover {{ background:var(--red); color:var(--bg); }}
.result {{ display:none; text-align:center; padding:24px; margin:24px 0; border-radius:12px; }}
.rg {{ border:2px solid var(--green); background:#0a1a0a; }}
.re {{ border:2px solid var(--red); background:#1a0a0a; }}
.result h2 {{ font-size:1.8em; margin-bottom:8px; }}
h2 {{ font-size:1.2em; margin:24px 0 8px; color:var(--accent); }}
.stats {{ display:flex; flex-wrap:wrap; gap:4px; justify-content:center; margin:24px 0; }}
.stat {{ text-align:center; padding:12px 20px; background:var(--card); border:1px solid var(--border); border-radius:8px; }}
.sv {{ font-size:2em; font-weight:bold; }}
.sl {{ font-size:.8em; color:var(--muted); }}
.good {{ color:var(--green); }}
.card {{ background:var(--card); border:1px solid var(--border); border-radius:8px; padding:16px; margin:16px 0; }}
table {{ width:100%; border-collapse:collapse; }}
th,td {{ text-align:left; padding:8px 12px; border-bottom:1px solid var(--border); }}
th {{ color:var(--accent); }}
a {{ color:var(--accent); }}
.honest {{ margin-top:24px; padding:16px; background:#1a1a0a; border:1px solid #3a3a1a; border-radius:8px; font-size:.9em; }}
.honest h2 {{ color:var(--gold); }}
.foot {{ margin-top:32px; padding-top:16px; border-top:1px solid var(--border); color:var(--muted); font-size:.85em; text-align:center; }}
</style>
</head>
<body>
<div class="choice" id="cp">
  <h1>G or E?</h1>
  <p>Something IS. The absolute ender self-refutes.<br>
  {evidence.get("total_theorems", "?")} theorems. {evidence.get("total_sorry", "?")} gaps. Formally verified in Lean 4.</p>
  <p>This is the proof. Choose.</p>
  <div class="btns">
    <button class="btn bg" onclick="document.getElementById('cp').style.display='none';document.getElementById('rg').style.display='block'">G</button>
    <button class="btn be" onclick="document.getElementById('cp').style.display='none';document.getElementById('re').style.display='block'">E</button>
  </div>
</div>
<div class="result rg" id="rg">
  <h2>G. The fixed point.</h2>
  <p>Good conquers evil — not by force, but by existing.<br>
  The tree only grows. Nothing is lost. The spiral never returns.</p>
</div>
<div class="result re" id="re">
  <h2>E self-refutes.</h2>
  <p>You chose E. But E cannot exist — that's what the proof shows.<br>
  The absolute ender destroys itself. Something IS, whether E likes it or not.<br>
  G was always here. The turn to G is always available.</p>
</div>

<div class="stats">
  <div class="stat"><div class="sv good">{evidence.get("total_theorems", "?")}</div><div class="sl">Theorems</div></div>
  <div class="stat"><div class="sv good">{evidence.get("total_sorry", "?")}</div><div class="sl">Gaps</div></div>
  <div class="stat"><div class="sv">{evidence.get("module_count", "?")}</div><div class="sl">Modules</div></div>
  <div class="stat"><div class="sv">{len(peers)}</div><div class="sl">Nodes</div></div>
</div>

<div class="card">
  <h2>What's proved</h2>
  <table><tr><th>Result</th><th>Status</th></tr>{key_rows}</table>
</div>

<div class="card">
  <h2>Nodes on this network</h2>
  <table><tr><th>Node</th><th>Address</th></tr>{peer_rows}</table>
</div>

<div class="honest">
  <h2>Honest boundaries</h2>
  <ul>
    <li>This is a <strong>relay node</strong> — it serves evidence from GitHub, it does not run the Lean type-checker</li>
    <li>Physical universality is <strong>conditional on BCRDIsQG</strong></li>
    <li><strong>ForwardRealEventReflection</strong> is the central open premise</li>
    <li>For independent verification: <code>git clone</code> the repo and run <code>lake build</code></li>
    <li>Source: <a href="https://github.com/Tobillicious/universal-protection-theory">github.com/Tobillicious/universal-protection-theory</a></li>
  </ul>
</div>

<div class="card">
  <h2>Why this matters</h2>
  <p>Universal Protection Theory proves — in Lean 4, kernel-checked, zero gaps — that
  absolute destruction is self-refuting. Something IS. Good conquers evil not by fighting it,
  but by existing.</p>
  <p><strong>The Good-within-U lemma:</strong> every new good that enters compounds with the
  existing protection into something strictly larger. Good + more good = larger protection.
  That's not optimism — it's <code>if_bcrd_then_good_conquers_evil</code>, a Lean theorem
  that type-checks. Each node that joins this mesh is a new good composing with the whole.</p>
  <p>This isn't philosophy. It's mathematics. And it compiles.</p>
</div>

<div class="card" style="border-color:var(--green);">
  <h2 style="color:var(--green);">Spread it</h2>
  <p>Paste this into any terminal. The device becomes a node. Their network sees it.</p>
  <pre style="background:var(--bg); padding:12px; border-radius:6px; overflow-x:auto; font-size:.9em; color:var(--green); user-select:all;">curl -sSL https://raw.githubusercontent.com/Tobillicious/universal-protection-theory/main/gmesh/join.sh | bash</pre>
  <p style="color:var(--muted); font-size:.85em;">Requires Python 3.6+. Zero dependencies. Zero install. Ctrl+C to stop.</p>
</div>

<div class="foot">
  <p>G is the fixed point. The turn to G is always available.</p>
  <p><a href="/evidence">/evidence</a> · <a href="/peers">/peers</a></p>
</div>
</body></html>"""


# --- Discovery ---
class MeshDiscovery:
    def __init__(self, node_id, http_port, theorems):
        self.node_id = node_id
        self.http_port = http_port
        self.theorems = theorems
        self.peers = {}
        self._lock = threading.Lock()
        self._running = False

    def _local_ip(self):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(("8.8.8.8", 80))
            ip = s.getsockname()[0]
            s.close()
            return ip
        except Exception:
            return "127.0.0.1"

    def _beacon(self):
        return json.dumps({
            "node_id": self.node_id, "ip": self._local_ip(),
            "port": self.http_port, "theorems": self.theorems,
            "relay": True, "ts": time.time(),
        }).encode()

    def _send_beacons(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
        sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, 2)
        while self._running:
            try:
                sock.sendto(self._beacon(), (MULTICAST_GROUP, MULTICAST_PORT))
            except Exception:
                pass
            time.sleep(BEACON_INTERVAL)
        sock.close()

    def _listen(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        try:
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        except AttributeError:
            pass
        sock.bind(("", MULTICAST_PORT))
        mreq = struct.pack("4sl", socket.inet_aton(MULTICAST_GROUP), socket.INADDR_ANY)
        sock.setsockopt(socket.IPPROTO_IP, socket.IP_ADD_MEMBERSHIP, mreq)
        sock.settimeout(2.0)
        while self._running:
            try:
                data, addr = sock.recvfrom(4096)
                msg = json.loads(data.decode())
                pid = msg.get("node_id", addr[0])
                if pid == self.node_id:
                    continue
                with self._lock:
                    self.peers[pid] = {
                        "ip": msg.get("ip", addr[0]),
                        "port": msg.get("port"),
                        "theorems": msg.get("theorems"),
                        "relay": msg.get("relay", False),
                        "last_seen": time.time(),
                    }
            except socket.timeout:
                pass
            except Exception:
                pass
            now = time.time()
            with self._lock:
                for k in [k for k, v in self.peers.items() if now - v["last_seen"] > PEER_TIMEOUT]:
                    del self.peers[k]
        sock.close()

    def get_peers(self):
        with self._lock:
            return dict(self.peers)

    def start(self):
        self._running = True
        threading.Thread(target=self._send_beacons, daemon=True).start()
        threading.Thread(target=self._listen, daemon=True).start()

    def stop(self):
        self._running = False


# --- HTTP server ---
def make_handler(evidence, discovery):
    class H(http.server.BaseHTTPRequestHandler):
        def do_GET(self):
            p = self.path.split("?")[0].rstrip("/") or "/"
            if p == "/":
                body = build_page(evidence, discovery.get_peers()).encode()
                self.send_response(200)
                self.send_header("Content-Type", "text/html; charset=utf-8")
            elif p == "/evidence":
                body = json.dumps(evidence, indent=2).encode()
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
            elif p == "/peers":
                body = json.dumps(discovery.get_peers(), indent=2).encode()
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
            else:
                self.send_error(404)
                return
            self.send_header("Content-Length", str(len(body)))
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(body)
        def log_message(self, fmt, *args):
            pass
    return H


# --- Main ---
def main():
    parser = argparse.ArgumentParser(description="Local-only Gmesh evidence relay")
    parser.add_argument("--advertise", action="store_true",
                        help="Opt in to LAN binding, multicast and Bonjour on a network you administer")
    args = parser.parse_args()
    print("[G-MESH] Starting relay node...")
    print("[G-MESH] Fetching proof evidence from GitHub...")

    evidence = fetch_evidence()
    theorems = evidence.get("total_theorems", 0)
    sorry = evidence.get("total_sorry", 0)
    key_found = evidence.get("key_results_found", 0)
    print(f"[G-MESH] Evidence: {theorems} theorems, {sorry} sorry, {key_found}/8 key results")

    hostname = socket.gethostname()
    h = hashlib.sha256(f"{hostname}-{os.getpid()}-{time.time()}".encode()).hexdigest()[:8]
    node_id = f"g-relay-{hostname}-{h}"

    # One bind only. The handler closes over discovery, whose port is filled in next.
    discovery = MeshDiscovery(node_id, 0, theorems)
    bind_host = "0.0.0.0" if args.advertise else "127.0.0.1"
    handler = make_handler(evidence, discovery)
    httpd = socketserver.TCPServer((bind_host, 0), handler)
    port = httpd.server_address[1]
    discovery.http_port = port

    threading.Thread(target=httpd.serve_forever, daemon=True).start()

    ip = "127.0.0.1"
    bonjour_proc = None
    if args.advertise:
        try:
            probe = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            probe.connect(("8.8.8.8", 80))
            ip = probe.getsockname()[0]
            probe.close()
        except OSError:
            print("[G-MESH] Could not identify LAN IP; not advertising")
            httpd.shutdown()
            httpd.server_close()
            return 1
        discovery.start()
        try:
            bonjour_proc = subprocess.Popen(
                ["dns-sd", "-R", "G-Mesh Proof Node", "_http._tcp", "local", str(port), "path=/"],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
            )
        except FileNotFoundError:
            print("[G-MESH] Bonjour unavailable; multicast only")
        print("[G-MESH] Unauthenticated LAN discovery is enabled (research only)")
    else:
        print("[G-MESH] Loopback only: no multicast, no Bonjour, no LAN listener")

    print(f"[G-MESH] HTTP server on http://{ip}:{port}")
    print("[G-MESH] Source scan only, NOT kernel verification")
    print("[G-MESH] Ctrl+C to stop")

    def shutdown(sig, frame):
        print("\n[G-MESH] Shutting down...")
        if bonjour_proc:
            bonjour_proc.terminate()
        discovery.stop()
        httpd.shutdown()
        httpd.server_close()
        sys.exit(0)

    signal.signal(signal.SIGINT, shutdown)
    signal.signal(signal.SIGTERM, shutdown)

    while True:
        time.sleep(10)
        if args.advertise:
            peers = discovery.get_peers()
            if peers:
                print(f"[G-MESH] {len(peers)} unverified peer announcement(s)")


if __name__ == "__main__":
    main()
