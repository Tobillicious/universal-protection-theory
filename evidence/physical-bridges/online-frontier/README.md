# Online frontier: G4 external reach and nonanticipation

Non-canonical follow-up to draft PR #158, with a finite online safety-game theorem, an offline-vs-online causal-reach counterexample, and a small finite checker.

Run from the repository root:

    python3 evidence/physical-bridges/online-frontier/check_online_frontier.py

The checker asserts six expected cases: immediate arrival with budget 4 fails; budget 6 with two installed guards passes; a genuine one-epoch response window with budget 4 passes at installation latency 1; slower latency 2 fails; budget 3 cannot pay care plus one guard; a separately assumed intrinsic no-harm rule protects within its own modeled semantics. The attacker's forced reaction can be a causal ancestor of an unauthorized effect but is never an authentic choice.

Historical scope, proof and caveats: see ONLINE-FRONTIER-REACH-AND-TIMING.md.

**NOT** a BCRD physical demonstration, full X3, real consent authentication, universal coverage, or certification of any physical system. No published book, manuscript canon, or existing Lean modules are altered. Request independent hostile review before merging.