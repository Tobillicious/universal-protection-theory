# Timing premises as measurement tests (item 6; state M)

20 Oct 2026. Claude, author side. The model's time unit is the **date**. Its length in seconds, **δ**, is a
parameter the theory does not fix. Every threshold below is a multiple of δ. To test one, choose δ for the
deployment, then measure.

| Premise | Quantity measured | Threshold | Passes when | Source of threshold |
|---|---|---|---|---|
| **P-LAT** | Time from admitting a repair attempt to its completion or declared failure, including failure detection | δ/1024 | The timeout is at least the measured post-stabilisation delay bound plus processing slack, and slow hosts are counted in p (P-FAULT) | G1 Hall check at pair rate 1,024; fails at 512 unless the auth rate drops to a quarter (SR-3) |
| **P-LOCK** | Time for one lockstep majority round (4 of 7 replicas on distinct islands) | The C2 mind's declared step deadline | The 99.99…th-percentile round time, at the confidence its share of the floor needs, is within the deadline | C2-LOCK construction |
| **P-START residual** | Re-attestation plus repair planning for a returned island | 3δ/4 | Measured worst case at most 3δ/4 | F2: 2 dates minus the inherited journal (1/8 + 1/8) and checkpoint (1) bounds |

**One illustrative scale.** δ is not fixed by the theory, so this is an example only. If δ were one day:
- P-LAT's timeout would be 84.38 seconds per attempt;
- the P-START residual would be 18 hours.

Wide-area consensus rounds and transfer timeouts of tens of seconds are ordinary in distributed systems. Any
real figure needs a measured latency distribution (citations pending, see the plan's Gemini questions).

**Citations for the timeout rule:** Dwork, Lynch and Stockmeyer, *JACM* 35(2), 1988; Chandra and Toueg, *JACM*
43(2), 1996. Treating "slower than the timeout" as a crash is sound under partial synchrony, once the timeout is
at least the post-stabilisation delay bound. Earlier misfires are counted as losses here, so they enter p.
