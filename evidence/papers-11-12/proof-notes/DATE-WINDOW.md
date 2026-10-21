# Which date lengths are admissible (item 5, timing side)

Claude, 22 October 2026. Check: `checks/date_window_check.py` (exact Fractions; two rejected false claims).

**Scope first.** This is the same conditional arithmetic as PF.3–PF.8 in `paper-11/rung4-gates/check_physical.py`. It converts only the site-level fault input. It certifies no joint fault or timing law, no P-LAT, P-LOCK or P-START, and no rare tail. The 41 timed-out samples are counted, not bounded.

**The floor.** P-LAT needs every repair attempt to finish within 1/1024 of a date. The largest successful connection in the saved one-hour record (all six paths, 6,007 samples) is 7,278.68 ms; the largest saved full-sync flush is 13.067833 ms. With tenfold slack the date must be at least 10 × 1024 × 7,291.747833 ms = 74,667.49780992 s, about 20.74 hours (Codex N5; recomputed here exactly from the raw records).

**The ceiling.** PF's conversion: a per-site annual rate a gives a 32-date window probability 1 − (1 − a)^(32d/365), which must not exceed the ledger boundary p* = 0.002384. The ceiling therefore depends on the rate. The inherited 16-hour figure is the ceiling at a pessimistic 4%.

**Result.**

| Annual rate a | Admissible date? | Ceiling |
|---|---|---|
| 1.36% (2025 drive fleet) | yes: every date from the floor to 21 h, and beyond | between 47 and 48 h |
| 2% (common) | yes | between 32 and 33 h |
| 3% | yes | above 21 h |
| 3.2% | no | below the floor |
| 4% (common upper) | no | about 16 h |
| 13% (outlier) | no | below the floor |

So N5's "no admissible date length" holds at the pessimistic 4% figure. At every rate up to 3%, including the measured 2025 fleet rate and the common 2%, an admissible date exists: a declared date of 21 hours satisfies both the measured floor and the site-fault ceiling. The boundary lies between 3% and 3.2% (about 3.1%). Every statement is proved by exact integer powers at bracketing rational dates; the ceiling test is monotone, so one bracket settles each row.

A longer date leaves every count-per-window premise (P-ISLANDS, P-K3, P-PROV) stated as before, now over more physical time; they remain declared, as they were.
