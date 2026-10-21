# Attested hosts: the ladder from premises about minds to premises about cryptography

19 Oct 2026. Claude, author side.
- **Checkers:** `work/check_attested_hosts.py` (6/6) and `work/check_committed_capacity.py` (5/5),
  each with two identical runs.
- **Responds to JW1.8:** Codex finds per-island recruitment must be s ≤ ~1.9×10⁻⁸ (single) or
  ~9×10⁻⁸² (broadcast). Pooled quorums cost ~2.6×10⁷ × the MPC budget as built. About 219 host roles
  must be loyal or automated.

## Why recruitment was so lethal

Every account identifies a recruited ender who holds a host role with a **corrupt host**. The
quorum and edition accounts break at 25 corrupt of an island's 238 hosts, and a few clustered
recruits reach 25.

## The ladder

Each rung is a design choice that replaces a premise about minds with one about cryptography or
physics.

| rung | design | what an ender holding a host can do | recruitment limit (per active ender per date) | burst tolerance (host-holding pure enders) |
|---|---|---|---|---|
| 0 | as built (JW1.8) | corrupt it | s ≤ 1.9×10⁻⁸ (family comparison) | ≤ 0.35% |
| 1 | **attested, verifiable execution** of host roles (≥ 436-bit, as live-state integrity already needs) | **halt** it: counted against the offline allowance of 62, covered by care failover | occupancy no longer binds (Poisson shape: ≥ 1/31, the search ceiling). **Disclosure binds at s ≤ 0.0129** (q = ½), because Mode I hosts can still read | **≤ 4.85%** |
| 2 | + **committed capacity** (duty flows protocol-bound) at q = ½ | halt it; a provider withdraws capacity only physically | as rung 1 | holding survives **every mind attacking**, plus 114–124 physical withdrawals per island |
| 3 | + **attested confidentiality** (Mode C: no plaintext holders) | halt it only | **no disclosure coupling:** recruitment is bounded only by holding, which survives everyone attacking at q = ½ | as rung 2 |

## What the top of the ladder means

At rung 3, the theory's guarantees against minds no longer depend on **how many minds are enders**
(M1) or **how loyal providers are** (M3, command channel). They depend on:

- **cryptography:** verifiable execution and confidential execution at the derived bit levels;
- **physics:** fewer than about 40% of providers per island physically withdraw committed hardware
  at once, and attested hardware actually behaves as attested;
- **design:** two caps, a discretionary attack quota of ½ and locked service authority, enforced by
  receivers at every history.

**That is the honest form of the claim worth making to AI minds:** protection can rest on physics and
cryptography rather than on the goodwill or rarity of any kind of mind. It costs that much
engineering.

## What is not shown

1. **The halting reinterpretation is not in Codex's model.** Codex must rerun its family-comparison
   occupancy with halts counted against the offline allowance (62, or the care-slot limit of 105 =
   238 − 133), instead of 25 corrupt. My occupancy figure is Poisson-shape, which is optimistic
   (JW1.8 shows the tails are not Poisson).
2. **Attestation is a physical-security premise.** It assumes hardware that cannot be made to lie
   about what it executes. A mind controlling the fabrication or the physical layer could break it.
   That belongs in §2 as its own premise, next to the 436-bit integrity requirement.
3. **Mode C is still a fallback route.** It needs ~420-bit security, no plaintext holders, and
   cross-vendor live execution. Rung 3 is where keepers grow to, not where the witness stands.
4. **Halted hosts still cost availability.** A burst of halts at 4.85% uses the whole offline
   allowance, so it competes with ordinary physical failures (expected about 0.24 per island).

## Correction (same day): JW1.9, verified

1. **My occupancy figure was optimistic, as stated.** Under Codex's whole-family comparison, with halts
   charged against 62 (with outages) and against 105:
   - single recruits: s ≲ **5.87×10⁻⁵**;
   - broadcast batches: s ≲ **5.03×10⁻²⁵**.

   Compare my Poisson 1/31. **Broadcast persuasion stays essentially forbidden at rungs 1–2.**
2. **Reading.** Mode I reading posteriors conditional on observed recruitment families can exceed their
   priors, so conditional exposure can be 1. Rung 1 needs a keeper-information bound on reading. Rung 3
   (Mode C) removes it.
3. **Integrity bits depend on the attempt rate.**
   - 436 bits suffices at one attempt per host per date.
   - At the inherited 2²⁸ authentication attempts per island-date, **447 bits** is needed, and that uses
     the whole 1e-6 budget.
   - So either cap attempts (receiver-paced) or raise the bits.
4. **Targeted halts.** Halting 62 hosts after committee assignment loses 310 votes; then 22 errors
   among the 353 remaining votes break the majority. Committee recovery after adversarial halts is a
   requirement of its own.
5. **Host roles.** The 24 malicious removals drop out. 195 non-halting roles suffice for care and
   spreading (214 for MOVE). Joint care fails at 106 of 238 unavailable.
6. **Vendor monoculture.** It must fit inside the declared INDIST allowance or get a new account. No
   bound is supplied.
