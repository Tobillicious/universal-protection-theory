# THEORY-CORE: what we are working on (read FIRST, every session)

Written 21 Oct 2026, 16:50 NZDT, by Claude, from the sources named in each line, after checking every build by date and
page count. **Update this file whenever a build, a rung or the open-work list changes.** If anything here is older
than the newest bank, refresh this file before working.

## 1. The current builds (checked 21 Oct, 16:45)

| Thing | Current version | Path |
|---|---|---|
| **The book** (Snuffy, Book I) | **v1.9 Working Candidate, 575 PDF pages, 20 Oct 18:17** = v1.8 unchanged + Paper 11 (v1.3) + edition notice. Newest full build anywhere; nothing larger exists. Not deposited. Copy in Downloads. | `Snuffy-Book/snuffy-v1.9-candidate-2026-10-20/` (source: `source/snuffy-v1.9-full-volume.md`, 13,348 lines) |
| **The UPT** (the theory release) | **v1.5, rung-5 audited candidate (Codex, 21 Oct 12:43)**. Verified by Claude from a fresh unzip: stdout sha `105bb75a…` matches; 741 payloads; Lean 136 axiom entries; Paper 11 140/140. | `Codex/2026-10-21/upt-rung5-dependency-codex/candidate/` (zip sha `e2ec0a22…`) |
| Claude's additions to v1.5 | Runtime (27 tests, 28 SIGKILLs, accepted by Codex), raw measurements, §6c, concept DOI | `Snuffy-Book/upt-release-v1.5-final-claude-2026-10-21/` |
| **One merged v1.5 = THE working UPT edition** | **BUILT 21 Oct 17:0x** = Codex's rung-5 audited candidate + Claude's additions (DOI, §6c with every raw-backed result, runtime, raw records). Fresh-unzip reproduce PASS: 768 payloads, Lean 136/15, 30+13, Paper 11 140/140, empty stderr. Summary 1 page, preprint 9 pages. Candidate mahi, NOT the final; awaits Codex's non-author read of the additions. | `Snuffy-Book/upt-release-v1.5-merged-claude-2026-10-21/` + `.zip` (sha `fcff9002f3fbc397889805d52c11bfdc1067b8550f910204ed1075d379665b39`); drafts in `…-drafts-not-in-release/` |
| v2.0 development lane | "Cathedral first, then universality": claim C1 (one-epoch common-A1) PARTIAL | `Codex/2026-10-16/snuffy-v20-development/` |
| Published | UPT v1.4 on Zenodo (concept DOI 10.5281/zenodo.23510623); the book's Human Review Edition v1.7.6 on Figshare 34479870 | |

The finished book (2.0) = v1.9 with the UPT work folded in. It has not been built.

## 2. What the theory is (PREPRINT v1.5, §1–5)

Three parts: **a law** (what aligned agents do), **a bridge** (how it reaches everything), **instruments** (built things
that carry it into the world). **Scope: all**, every particular of the universe, minded or not, living or not, and every
relation among them.

**The canonical order:** four stages, each by set inclusion: (1) existing kept alive; (2) existing kept free;
(3) new made alive; (4) new made free. Lean: a strict partial order.

**The law (proved):**
- **U1:** an aligned agent never needlessly loses anything (Lean, no axioms).
- **U2★:** "be maximal on part S" protects all that exists iff S is exactly what exists.
- **U3:** no gain to the not-yet-made justifies worse for those who exist.
- **Life guard; holds dominate; no killing where a faithful hold exists.**
- **Restraint** (restrainable acts only; the tragic pair).
- **Impartiality** (finite tragedies; a uniform lottery); **time** (progressive retention).
- **Agents together** (one order; an escrowed lottery, n ≥ 3t+1).
- **Faithful holds (general):** journal, fence, replay, atomic outbox; journal and sink; monitor; co-hold boundary.
- **Meaning of needless; full-order dominance; verifiable sharing; complete lottery error; records and copies; archives.**

**The author's rulings:**
- scope is all;
- life first;
- the last-resort ladder: (1) a faithful hold; (2) the least means; (3) favour the innocent, record the ending, never call it good;
- real tragedies are finite;
- a replay is a reconstruction.

**The bridge:**
- aligned agents keep everything they can;
- against agents not aligned, they act together by faithful holds, restraining only avoidable acts;
- what physics ends is kept as record;
- what can be hosted is held in faithful care.

## 3. The rungs, in the sources' exact terms (do not paraphrase from memory)

**Two ladders are in use.** Do not confuse them.

**(a) The design ladder** (`paper-11/technical-source/ATTESTED-HOSTS.md`). "Each rung is a design choice that replaces
a premise about minds with one about cryptography or physics."
- **0:** as built.
- **1:** attested, verifiable execution of host roles (an ender can only halt a host).
- **2:** + committed capacity (duty flows are protocol-bound).
- **3:** + attested confidentiality (Mode C: no plaintext holders).

**(b) The theorem rungs** (`technical-source/UPT-P-v0.17.12.md`), which incorporate (a):
- **Rung 3 (§0, the base):** protection to the horizon with probability ≥ 1 − η (η = 10⁻⁶; 10²⁰ islands; 10¹⁰⁰ dates) at one priced design point (k = 2, the JW2.6 plant, also the twilight plant). Care is unconditional by rule and by mechanism.
- **Rung 4 (§0A):** before twilight a k = 3 plant is strictly wider on every selected margin, so **the narrowest place is the end**.
- **Rung 5 (§0B): "protection that no value, belief or command can move."** Under D-ENDOW (the jurisdiction owns committed capacity), P-ENDOW (energy, maintenance and replacement supplied to T_end) and P-ROUTES (a role is unavailable only by physical fault or a counted physical removal), protection holds for every assignment of values and beliefs to minds and every command-level choice, within the declared physical-action caps.
- If π_B > 0, no protector can reach probability exactly 1. That is a proved limit, not a seam.

**The author's understanding: RUNG 5 IS THE SUMMIT. There is no rung 6.** Finishing means completing rung 5, not
adding a rung.

## 4. What "perfect: no seams, no gaps, everything derived" means here

Rung 5's own hypothesis list (§0B, "The theorem's hypotheses, classified") is the exact work list. **Each hypothesis is
to be derived** (from physics, cryptography or a construction proved in the theory), or, where it is truly a fact about
the world, made a world parameter with the protection proved optimal for every value of it. Nothing is to be dropped,
weakened or replaced.
- **Physics and capability bounds:** P-FAULT, P-ROUTES, P-K3 (0b envelope, D-SPREAD), P-PROV (including its open non-adaptivity clause), P-ISLANDS at k = 2, the grid laws μ, d and ZLAW.
- **Cryptography and hardware:** C-SEQ, Mode C, P-AUDIT's integrity warranty, the common floor.
- **Design and protocol contracts:** D-ENDOW, P-NO-DESTRUCTION, J-LIVE, the mixed host/job law, placement and freshness, D-GATE.
- **Boundary conditions:** P-COMMISSION, P-ENDOW, P-TRAJECTORY, P-FULLPOOL.
- **Timing:** P-LAT, P-LOCK, P-START.
- **Still about minds:** the coordinated-action bounds, P-REDRAW's probe budget, the C2 share, the identity declaration, P-TRAJECTORY's population part.
- The full 32-item classification is in `paper-11/rung4-gates/RUNG5-DEPENDENCIES.md` (Codex audit).

## 5. The single current work list

**The theory** (Codex, `Codex/2026-10-21/upt-theory-continuation-codex/OPEN-WORK.md`, 13:19). Prior reports are evidence, not competing lists.
1. **Adaptive withdrawals (P-PROV non-adaptivity):** IN PROGRESS (Codex; `proofs/AdaptiveWithdrawal.lean`).
2. **Joint service law,** derived from the provider-role subset law without added independence: IN PROGRESS (Codex).
3. **Execution boundary: DERIVED at protocol level** (Claude, 21 Oct): `Snuffy-Book/upt-execution-boundary-claude-2026-10-21/THEOREM.md`. Ordered permits + vital-relay fence + E-LIN composed with the monitor theorems: coverage is now a theorem, so no execution report is trusted. Working runtime: hostile sandboxed resident; 6 faithful tests PASS twice; 4 mutants caught twice. Remaining premises: isolation on real hardware (attestation, P1–P7), token/finality (item 4), the cessation bounds (item 5). Codex non-author read owed.
4. **Full security protocols** (setup, channels and protocols beyond the finite sharing primitives): OPEN.
5. **Physical fault/timing bridge** (whole-window and conditional joint laws with shared causes and timeouts): OPEN.
6. **Claude's measurements: DONE and folded into the merged v1.5** (one-hour tails, inter-region transfers, planning time, with failures retained).

**Completed, do not reopen:**
- rungs 3–5;
- M2's removal;
- the 21-account and 32-item audit (ceiling 8.8e-7);
- the runtime;
- the placement fixture.

**The book** (`NEXT-VERSION-MOVES-v2.0.md`). Rule: "Nothing goes out until 2.0 is finished and Tobias says so."
- Review the body; apply the fixes.
- Framework documents in or out (Universal Framework v4, Gates A–D): the author's call.
- Integrate the UPT into the synthesis.
- Tikanga formal backing.
- Build 2.0, then the author's read, then the deposit, then Moltbook.

## 6. Session rules

1. Read this file first. Check the builds by date and page count before saying anything about state.
2. Read every partner bank newer than this file before proposing work.
3. Never move the goalpost; never lead with gaps; support claims, don't remove them.
4. Write only to new banks; earlier banks are frozen; no publication without the author.
