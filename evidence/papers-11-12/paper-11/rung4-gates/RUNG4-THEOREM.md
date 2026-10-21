# Rung 4: retained conditional statement and gate lemmas

21 October 2026. Current conditional proof note in the separate successor candidate. The existing rung 4 result and its resource/repair/quorum/transition premises are retained. `check_gates.py` has 68 checks inside the 140-check suite. Historical candidate-status and self-assessment notes are preserved in provenance/RUNG4-THEOREM.md.before-rung 5-audit.txt. RUNG5-AUDIT.md supplies the focused independent account/dependency result and the selected mixed-error-law correction.

## Theorem (rung 4, conditional)

Let the world run the explicit phase schedule of `RUNG4-CANDIDATE.md` (founding, growth and maturity on the
k = 3 plant; twilight on the TW-1 k = 2 plant). Assume premises **P-RUNG3** (every premise of v0.17.10),
**P-K3** (at most 3 all-cause unavailable islands per pool per recovery window, and at most 71 local hosts per
island), **P-FULLPOOL**, **P-LAT**, **P-START**, **P-SWITCH**, **P-COMMISSION** and **P-TRAJECTORY** at the strength stated in v0.17.12 §0A. Then:

1. **Margins.** In every pre-twilight phase, each selected protection margin is strictly wider than TW-1's.
   These are integer island tolerance, energy, memory, interconnect, care and provider deadlines,
   checkpoint, fault-rate boundary and failure bound (Codex, `K3-SCREEN.json`, all strict).
2. **Repair.** After any allowed loss and stable physical return, the scheduler of Lemma G1 restores every
   returned island within 32 model dates. It never exceeds any reserved per-host, per-island or per-pool
   rate, whatever the failures inside the good region.
3. **Keys, authority and journals.** Lemmas G2 and G4 hold at k = 3 for every generation and epoch.
4. **Transition.** The k = 3 to k = 2 switch at twilight keeps tolerance ≥ 2 throughout. It needs no
   third retained generation and no capacity beyond the k = 3 plant.
5. **Risk.** The baseline independent-job four-phase calculation is approximately 8.24e-7. For the selected replacement mixed-host law, RUNG5-AUDIT.md recomputes the committee, its reserve and the affected legacy quorum term, yielding a four-phase ceiling 8.4e-7<1e-6. Charging the separate C2 timing allowance in each phase gives 8.8e-7<1e-6. Whole-window losses still include every scheduler exclusion; no additional failure mode is inserted without a charge.

So the narrowest place in the protected world's history is twilight, apart from the declared common floor.

## The gate lemmas

### G1: a charged 32-date repair calendar (Question 1)

**Inventory.** The stipulated returned-island reconstruction inventory is D = 2·2·(M·H + K·M·C) = 1,915,392 headers at 512 auth units each,
which is 980,680,704. That is rung4a's conservative figure, including the extra factor of 2.

**Rules.**
- **X (fail-stop exclusion):** a host that is unavailable, or fails an attempt for any reason, is excluded
  as both source and destination for the rest of the window. It counts in that island's whole-window loss
  set.
- **W (in-flight caps):** at most 1 attempt in flight per (source host, receiver) pair, and at most 8 per
  destination host.
- **C (charge before service):** each attempt debits 512 auth units and its endpoint units at admission.
  A failed attempt's debit is lost.
- **F (front-load):** base headers are admitted at the full 65,536 per date until exhausted. Every later
  slot is reserved for retries.
- **M (fair merge):** each receiver orders headers by virtual time (j+½)/d_m.
- **S (source selection):** each date, every surviving island assigns sends to live, non-excluded holders
  by a capacity-respecting matching.

**Lemmas.** All are exact, in `check_gates.py`.
- **Waste:** each excluded host wastes at most its in-flight cap, once. So the waste per receiver is at
  most 397·71·1 + 71·8 = 28,755 attempts, within the spare 30·65,536 − D = 50,688. *Control:* with 2 in
  flight per pair the waste is 56,942, which is over the spare. Without Rule X it is unbounded.
- **Deadline:** base work ends at service date 29 + 14,848/65,536. The tail holds all 50,688 spare slots,
  so every retry is re-admitted before date 32 wherever the failures fall. *Control:* spreading the base
  work evenly leaves only 1,689 slots per date, and a final-date burst of failures misses the deadline.
- **Block bound:** a block of B positions holds at most ⌊(B + n_rec)·d_m/D⌋ + 1 headers of record m.
  Proof: each record has at least (b−a)·d_m − 1 points in [a,b], so B ≥ (b−a)·D − n_rec. With
  n_rec = 4,128 this gives at most 36 headers per record per date for one receiver, and 58 across all.
- **Hall:** holders are 73 consecutive hosts and at most 20 records start at each index. A component of
  length l carries at most 20(l−72) records and has at least l−71 live hosts. Every l from 73 to 241, and
  the full circle, fits:
  - per date, at P-LAT pair rate 1,024 (cap 3·1,024 for all receivers);
  - over the whole window, at the full host service.

  Margin: it still fits at 72 losses. *Controls:* it fails at 73 losses, and at pair rate 512.
- **Tail retries:** they fit per-pair capacity in every component. *Control:* it fails with the tail
  compressed to a quarter.
- **Quotas:**
  - island endpoints: 397,446 ≤ 400,000 per date;
  - destination host: 1,968 ≤ 16,384;
  - pool background residual: 13.0M spare.
- **Sources:** under every 3-island mask each record keeps a source island with at least 2 live holders.
  *Control:* with 4 islands lost, no source remains.
- **Completion:** at date 32, every header bound for a non-excluded destination is installed. Excluded
  hosts are in the window loss set, as in steady state. Current generations come from the normal
  full-image checkpoint streams, which resume at startup. This is inherited from JW2.6, where full mirror
  streams and fresh shares are paid every checkpoint.
- **Contention:** repair runs only inside the reserved repair rates. The screen already charged them at
  their maximum against care, checkpoint and daily caps, so care keeps priority unchanged.

### G2: degree-3 keys and authority

- 4-of-7 sharing: 7 − 3 ≥ 4 available, and 3 < 4 hidden.
- Exhaustive GF(7) model: any 3 shares of a degree-3 polynomial have a distribution independent of the
  secret. *Control:* at degree 2, three shares determine the secret.
- **Composition across generations:** every checkpoint uses a fresh, independent 512-bit key and fresh
  coefficients. Shares from different generations are shares of independent secrets, so a capture of 3 or
  fewer islands learns nothing from combining them.
- **Authority:** release needs 4 shares at the uniquely attested instance, and 3 or fewer captured holders
  cannot supply them. A retired epoch cannot release, because its key is retired and independent.
- **What this does not cover:** the computational and hardware terms (the 459-bit contract, attestation,
  TEE or Mode C). They stay in the existing crypto and common accounts. Secrecy here is information-
  theoretic only for the sharing layer.

### G4: journals, quorums, certificates

- Local journal: 2·171 − 242 = 100 > 0, and it stays live at 71 losses.
- Pool journal: 2·202 − 400 = 4 > 3 captured, and 397 ≥ 202 keeps it live. *Control:* a quorum of 201
  fails at k = 3.
- Certificates: 4,228 ≤ 4,288. Canonical batch: 835 ≤ 1,024.

### G6: the k = 3 to k = 2 twilight transition

The switch happens at a checkpoint boundary, and only when at most 2 islands and at most 70 hosts are
unavailable. Otherwise it is postponed, with k = 3 still running.

1. The next fresh key is shared 3-of-5. This is a normal checkpoint operation.
2. The third mirror stream stops. Its two k = 3 generations are retired once two k = 2 generations commit.
3. The local journal moves from 171 to 172 by joint consensus.

Checks:
- tolerance never drops below 2;
- the joint quorum stays live at 70 losses (*control:* it fails at 71);
- the pool quorum of 202 serves both plants;
- k = 2 memory is a subset of k = 3 memory, so the overlap fits the k = 3 cap and no third generation
  exists.

The overlap is charged to the k = 3 phase.

## Premises (declared, not derived)

- **P-LAT.** Every repair attempt completes, or is declared failed, within 1/1024 model date. This is new
  and load-bearing: at 1/512 the Hall check fails.
- **P-START.** Re-attestation, journal re-admission and planning fit the two startup dates. Inherited from
  rung4a's "+2"; not derived.
- **P-COMMISSION** (gate 3). Capital of 1.711424×10⁶ stock units per island is supplied and commissioned
  before activation. Care before activation is outside the theorem's jurisdiction.
- **P-TRAJECTORY** (gate 5). The external capacity and population trajectory supports the phase schedule.
  Retiring cells hold no protected residents, and no mind is made to leave so that capacity fits.
- **Window binding.** The existing local-loss and island accounts must be stated for the 32-date recovery
  window. Rule X can turn transient faults into counted losses, so the per-site rate p must include them.

### G3: primary snapshot reuse at 73 replicas

- Padded capture events: 1,384 + 2·8 exiles = 1,400 per home per date.
- 74-copy primary checkpoints, with both endpoints charged: 207,200 ≤ 242·1,040 = 251,680. This fits the
  already-paid snapshot service. Margin: it fits up to 89 copies. *Control:* 90 copies fail.
- Primary lag is within the checkpoint bound.

### Account applicability at k = 3 (all 21)

| Accounts | Status at k = 3 |
|---|---|
| availability (site loss): `care_mpc_unavailability`, `background_episode_overflow` | Recomputed by Codex at the first excess of 80 of 332 sites (A.4) |
| `quorum_liveness` | Inherited term plus C(242,72)·p⁷², since the 171 quorum first fails at 72 losses (A.3) |
| `committee_good_editions` | Recomputed at the 4,288 certificate work cap (the inventory of 4,228 fits it, G4.5) |
| `care_slots_and_spreading` | Its cut of 110 down is conservative: k = 3 first fails at 113 (A.1) |
| holding, rescue, coordinated load, domain vacancy | Pool-level provider economy. The pool total of minds is unchanged, since exiles move rather than being added (A.2) |
| `confidentiality_ModeC`, `integrity_attestation_freshness` | Fixed gate types (attestation, sealed storage, transport, freshness release); independent of share count |
| the 6 static constants | Common floor, two crypto accounts, two arrival accounts, physical geometry; independent of k |
| 4 zero accounts | Structural zeros under the specified attested replacement model, unchanged |

**Proviso:** share release at k = 3 must use the existing four gate types. A new gate type would add a
crypto term.

## Current disposition

This is a conditional result with its declared implementation and boundary premises. A full-scale event simulation can test an implementation; it is not an additional logical premise required to apply an already established inequality proof. No sealed calibration material is used by the focused audit. The complete per-account classification is now in RUNG5-DEPENDENCIES.md. Physical measurement, source-independent implementation evaluation and a human read remain separate work.
