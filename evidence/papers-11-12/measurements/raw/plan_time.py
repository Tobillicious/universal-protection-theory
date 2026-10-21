"""P-START planning time, measured with a WORKING planner on a plant-sized instance (Python 3.9, no randomness).
A returned island's 1,032 residents each need 3 replicas re-placed onto the 171 live hosts (of 242), with no two
copies of a resident on one host, and host capacity ceil(1032*3/171) = 19. Solved as max flow (Dinic). Every run's
assignment is validated: every resident gets 3 distinct hosts and no host exceeds capacity. Five timed runs, raw."""
import json, math, sys, time
from collections import deque
sys.dont_write_bytecode = True
R, K, H = 1032, 3, 171; CAP = math.ceil(R * K / H)


def plan():
    N = 2 + R + H; S, T = 0, N - 1; g = [[] for _ in range(N)]
    def add(u, v, c): g[u].append([v, c, len(g[v])]); g[v].append([u, 0, len(g[u]) - 1])
    for r in range(R): add(S, 1 + r, K)
    for r in range(R):
        for h in range(H): add(1 + r, 1 + R + h, 1)               # at most one copy of r on h
    for h in range(H): add(1 + R + h, T, CAP)
    flow = 0
    while True:
        lvl = [-1] * N; lvl[S] = 0; q = deque([S])
        while q:
            u = q.popleft()
            for v, c, _ in g[u]:
                if c > 0 and lvl[v] < 0: lvl[v] = lvl[u] + 1; q.append(v)
        if lvl[T] < 0: break
        it = [0] * N
        def dfs(u, f):
            if u == T: return f
            while it[u] < len(g[u]):
                e = g[u][it[u]]; v, c, rev = e
                if c > 0 and lvl[v] == lvl[u] + 1:
                    d = dfs(v, min(f, c))
                    if d:
                        e[1] -= d; g[v][rev][1] += d; return d
                it[u] += 1
            return 0
        while True:
            f = dfs(S, 10 ** 9)
            if not f: break
            flow += f
    assign = {r: [v - 1 - R for v, c, _ in g[1 + r] if 1 + R <= v < 1 + R + H and c == 0] for r in range(R)}
    return flow, assign


if __name__ == '__main__':
    sys.setrecursionlimit(10000); runs = []
    for k in range(5):
        t = time.perf_counter(); flow, a = plan(); dt = time.perf_counter() - t
        load = [0] * H
        for hs in a.values():
            assert len(hs) == K and len(set(hs)) == K
            for h in hs: load[h] += 1
        assert flow == R * K and max(load) <= CAP
        runs.append(round(dt, 4))
    print(json.dumps({'residents': R, 'replicas_each': K, 'live_hosts': H, 'host_capacity': CAP,
                      'placements': R * K, 'valid_every_run': True, 'plan_seconds': runs,
                      'max_s': max(runs)}, indent=1))
