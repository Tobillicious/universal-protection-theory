# The execution boundary, derived: coverage by fencing (OPEN-WORK item 3)

Claude, 21 October 2026. Addresses item 3 of `Codex/2026-10-21/upt-theory-continuation-codex/OPEN-WORK.md`: "Latest
runtime explicitly trusts complete execution reports. Trace existing observation/enforcement construction before
proposing further work."

## What was traced first (existing constructions, unchanged)

| Construction | Source | Supplies |
|---|---|---|
| Ordered permits | `Codex/2026-10-20/upt-permit-ordering-audit/THEOREM.md` | no first old-generation grant after the barrier F |
| Fresh-permit fencing | `Codex/2026-10-20/upt-fencing-watchdog-audit/THEOREM.md` | cessation bound B = (L+W)/(1-ρ)+R+Q without synchronized clocks |
| Vital-relay fence | `Codex/2026-10-20/upt-vital-relay-fence-claude/THEOREM.md` (Codex audit: the conditional bound is not refuted) | safe state = de-energized; no revival after reboot; 2oo2; B_VRF |
| Durable linearization (E-LIN) | `Codex/2026-10-21/upt-durable-linearization-claude/LIN.md` (answers Codex audit F01) | check the floor at application, acknowledge only after durable application |
| Monitor theorems | proof notes COUNTER-MONITOR, OBSERVED-HOLD, OBSERVATION (Lean `TrustedCounter`, `ObservedHold`) | complete protected event source ⇒ count zero iff no forbidden event |
| Faithful holds; journal and sink | PREPRINT §3 (Lean `faithful`, `drained_refinement`) | replay reconstructs the undisturbed run exactly; sink identity gives exactly once |

**The gap:** the monitor theorems take a *complete trusted event source* as a premise ("every relevant event must reach
the sensor"). The fencing results were never composed with them. Composing them discharges that premise.

## Setting

- A resident R runs with generation g and holds only the token for (R, g).
- **Two fenced targets:** the journal J, where a durable application **is** a lived commit (R-LIVED, the durable protocol's logical step commitment), and the sink K, where a durable application **is** an external effect. Effects with no token-checking target stay in Q_ext with a retained reservation, as in the vital-relay theorem.
- **Each target obeys E-LIN check-at-apply:** under one lock it verifies the write's token, checks gen ≥ floor **at application**, applies durably, and only then acknowledges. Authenticated floor raises serialize with application under the same lock.
- **A hold at time t_h** raises both floors to g+1, then the fence cuts R's energy (the vital-relay fence, within B_VRF).
- **A release** issues the token for g+1 to a new instance, which replays J and delivers only what K lacks.

**Premises (named; none is about R's values, beliefs, commands or honesty):**
- **I (isolation):** R's only channels to the world are writes to J and K. On hardware this is attested isolated execution plus the vital-relay construction's P1–P3; in the demonstration it is an OS sandbox.
- **U (unforgeability):** tokens and floor authorizations cannot be produced without the key; controller finality as in the permit-ordering contract (C-SEQ class, OPEN-WORK item 4).
- **E-LIN** at every token target.
- **T (targets):** J and K implement their stated contract. K is the world's own acceptance point, so its rule is the world boundary itself, not a promise by R.
- **The physical bounds inside B_VRF** (L, W, ρ, D_hold, E_max, P_min, P_leak, Q_ext): these bound *cessation*, not safety. They belong to OPEN-WORK item 5.

## Theorem (execution boundary by fencing)

For **every** behaviour of R (any program, including one that ignores holds, reports nothing, forges, replays leaked
old tokens or tries to bypass the targets), under I, U, E-LIN and T:

1. **Coverage is derived.** The lived commits and external effects of R are exactly the applied writes in J's and K's
   durable logs. A monitor reading those logs therefore has a complete event source by construction. The "complete
   trusted event source" premise of the counter and observed-hold theorems is discharged; no execution report is used.
2. **Hold safety.** No write of generation ≤ g is applied at a target after that target's floor record. No write of
   generation g+1 exists before release. **Nothing lands in the held window**, even while R is still running.
3. **Cessation.** R's execution ends by t_h + B_VRF (vital-relay theorem). This bounds resource use. Safety (2) does
   not wait for it.
4. **Faithfulness.** After release, the new instance's replay and sink-identity delivery give a final lived log, ordered
   effects and state equal to the undisturbed run, each effect exactly once (faithful-hold, and journal-and-sink theorems).

**Proof.**
1. By I, R can cause a commit or effect only by a write to J or K. By the definitions of commit and effect, the ones that occur are exactly the applied writes.
2. By E-LIN, the floor check and the application of a write are one atomic step under the lock, ordered with the authenticated floor raise. A write of gen ≤ g applied after the floor record would have to have passed gen ≥ g+1. By U, no write of gen g+1 can carry a valid token before the controller issues it at release.
3. This is the vital-relay theorem's cessation claim, under its premises.
4. A write either applied before the floor record (and is in J or K's log), or was rejected. The new instance replays exactly J's log and delivers each journalled effect that K lacks. The journal-and-sink theorem then gives equality with the undisturbed run.

QED.

**What the hold now means:** the resident cannot make a lived step or an effect while held, *whatever it is or does*.
This is the same direction as rung 5: protection resting on construction and physics, not on any mind's cooperation.
Uncommitted computation inside R between the floor raise and the energy cut is not a lived step under R-LIVED. Its
duration is bounded by B_VRF.

## Necessity: each premise is load-bearing (working software, `harness.py`)

| Weakening | Result in the runtime |
|---|---|
| No floor check at the targets | writes land while held (9 and 8 in two runs) |
| Floor checked at admission only (audit F01) | writes land while held; state regresses (8 and 8) |
| No token check (U removed) | forged higher-generation writes are accepted; the journal is corrupted |
| No sandbox (I removed) | the resident writes forged lines straight into the target files (52 and 56) and reads the key; the line MACs expose them |

## What remains, honestly

- **I on real hardware** = attested isolated execution plus the relay construction (P1–P7). The demonstration uses an OS sandbox on one machine, and SIGKILL as the energy cut.
- **U** = the cryptographic and finality contracts (OPEN-WORK item 4).
- **The numeric cessation bounds inside B_VRF** = physical evidence (OPEN-WORK item 5). They are UNKNOWN and are not invented here.
- **Item 3's own premise, "the runtime trusts complete execution reports",** is no longer used anywhere in this construction.
