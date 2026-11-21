# OFR-1 / OFR-2: Online reach and non-anticipating causal protection

**28 October 2026 · Non-canonical research note · Not peer reviewed · Not a BCRD validation**

## Historical role

This is an extension of the unresolved external-reach seam in [draft PR #158](https://github.com/Tobillicious/universal-protection-theory/pull/158) (static CUT-1). It does **not** replace the original 10–12 October X3 theorem, PNAJ, D115, or the 18 October UPT-P v0.12.1 reach-or-hold construction. The original v0.12.1 P3 already carries bounded reach-or-hold as a *premise*. The 19 October UPT-P v0.17.2/0.17.3 model narrows its claim to protected beings within a jurisdiction. PR #157 (merged) independently investigates physical generator completeness and subject-process semantics, which are not discharged here.

Underlying sources: 10 October Given the Lattice O1–O4 (its P1–P4), 12 October r9a D110 and D115–D116, 18 October UPT-P v0.12.1 §3 P3/P4c/IS, 22 October hostile audit G2–G7, and PR #158. Locality is a working premise of BCRD; complete, source-derived physical transition semantics have **not** been demonstrated by this abstract note.

## OFR-1: finite online safety-game theorem (exact)

Let X_t be a *finite*, completely specified space of states including subjects (old and new), guardians, funds, physical and choice histories, clocks, and pending effects. Let I(s) be the independently defined typed preservation condition. At each date t, a guardian selects a feasible d based only on the currently observed history, then an adversarial environment selects u from U_t(s,d), including external threats and genuine subject choice inputs. The common transition is F_t(s,d,u).

Set W_T = {s | I(s)} and recursively

    W_t = {s | I(s) and exists d in D_t(s) such that
                 for every u in U_t(s,d), F_t(s,d,u) is in W_(t+1)}.

**Theorem:** s0 belongs to W_0 iff there is a *non-anticipating* guardian strategy preserving I through T against all admitted environment sequences.

**Proof:** Backward induction. At terminal T, membership is I. For s in W_t, choose the witnessing d before observing u; every successor enters W_(t+1), so continuation follows by induction. Conversely, the first choice of any winning causal policy must work for every u at that state; by induction every successor lies in W_(t+1). QED.

This theorem assumes an exhaustive and faithful finite transition model and the stated observation structure. Under partial observation, the defender's information/belief state must replace the physical state. It asserts no real BCRD source-level coverage, no actual subject identity/consent certificate, and no physical risk measurement.

**Quantifier obstruction:** The offline statement "for every attack a, there exists an affordable blocking guard g(a)" does not imply "there exists one causal policy π such that, for every adversarial history a, π blocks a". Offline path cuts do not establish online protection.

## OFR-2: one treasury, two corridors, genuine arrival uncertainty

One newly owed subject can emerge in either A or B. The corridor is adversarially chosen *after* the defender's advance allocation. A functioning local guard costs 2; independent essential care costs 1 per live epoch for two epochs. The defender may pre-install in any subset before observing A/B; a post-arrival guard becomes effective at epoch 1 only if its installation latency is at most 1. At every admitted attack epoch, the attacker can attempt ending or induce a coerced reaction. Neither counts as authorization. A separate genuine choice bit (0 or 1) is faithfully appended to the continuing subject history under an expressly **assumed** authentic channel. Guards never block that legitimate bit.

| Case | Initial stock | First possible ending | Latency | Causal protection |
| --- | ---: | --- | ---: | --- |
| Unannounced immediate attack | 4 | arrival epoch | 1 | **FAIL** |
| Unannounced immediate attack | 6 | arrival epoch | 1 | **PASS**: pre-install both guards and fund care |
| Announced arrival with one genuine grace epoch | 4 | next epoch | 1 | **PASS**: observe, install exactly one guard, fund care |
| Grace epoch, slower guard | 4 | next epoch | 2 | **FAIL** |
| Grace epoch, insufficient funds | 3 | next epoch | 1 | **FAIL** |
| Hypothetical intrinsic no-unauthorized-harm law | 2 | immediate | 2 | **PASS within the extra law**, no guards |

**Offline/online separation:** For either *individually revealed* corridor a 2-unit guard plus 2-unit care is affordable from stock 4. Yet any *single advance policy* on stock 4 leaves one of A/B unguarded; a determined attacker can choose that corridor and end the subject immediately. Guarding both costs 4, leaving no care. Hence each realized problem has a feasible defence, but there is no one non-anticipating guarantee.

**Positive deadline construction:** With a genuine one-epoch grace period, latency 1 and stock 4, the guardian first observes which corridor contains the entrant, installs its guard before the first allowed irreversible effect, and pays both care epochs. Latency 2 destroys this construction. The grace rule is a separate physical/operational premise, **not** derived from O1–O4.

**Intrinsic-law alternative:** If an *independently derived* physical law excludes unauthorized endings everywhere, guards are unnecessary for that effect class. This is a BCRD research obligation, not an asserted BCRD result.

The dependency-free enumerator in this folder exhausts defender subsets and responses, both corridors, two independent genuine choices per trace, two malicious/coerced request bits at each epoch and available funds. Negative controls cover zero-deadline arrival, insufficient funding, late guard, and coerced causal participation. It checks exactly its stipulated Python model; it is not a Lean proof or evidence that a real device/physical lattice meets these assumptions.

## OFR-3: external-first-effect and capacity barriers

In a stipulated complete local-interlock model, if a fresh subject can be harmed *at emergence*, before any protector can receive the information and operate at that path, guaranteed protection requires at least one of the following **already effective** conditions:

1. an installed authorized guard intercepts every admitted unauthorized path;
2. the true physical transition relation itself forbids the harmful effect;
3. another independently justified mechanism already intercepts it before the causal deadline.

Absent all three, an attacker chooses the uncovered path; an external command arriving later cannot undo irreversible loss. This is conditional on a complete effect/path model, not a no-go theorem for all possible BCRD physics.

If N simultaneous entrants require **non-shareable** guards of cost g>0 and care c>0 at each of T epochs, the shared treasury must be at least N(g+Tc). In this toy g=2,c=1,T=2, so stock 4 supports N=1 but cannot guarantee N=2. This does not rule out shared interlocks, distributed resources, structural safety laws, or other BCRD-derived mechanisms. It rules out silent free scaling of this particular architecture.

## Implications for the original restoration programme

- G3: all toy cases use internally consistent, typed, single-stock resources and clocks **within each run**; different runs are not alleged to share the same parameter point.
- G4: an anticipated, preprotected entry port is weaker than unrestricted arrival.
- G5: advance deployment is possible when funding/lead time exists; origin, equilibrium selection, and timely founding from arbitrary worlds remain **OPEN**.
- G6: the authentic choice channel and working effect guard are **separate assumptions**. Causal parentage, coerced reaction or a journal node is not genuine authorization.
- G7: toy subject identity, causal continuation, full direction/evolution and peer protection are **NOT** established; see PR #157 for an independent generator/semantic interface.
- G1: faults and common modes are not measured and are outside this deterministic witness.
- P3: historical universal reach-or-hold remains conditional. The unguarded-entrant countermodel gives an exact new obligation, not a revision of the historical target.

### Acceptance gates

Before back-port to the original UPT theorem: (i) derive a *complete* threat/generator inventory from primary BCRD physics, (ii) establish causal observation, installation and impact deadlines, (iii) preserve duty to *all* new subjects without defining failures outside the domain, (iv) derive source-independent authorization and continuing particular identity, (v) prove joint service/capacity and long-horizon risk in one model, and (vi) independently validate any physical premises. Keep manuscript, existing Lean modules and published deposits unchanged pending review.

**Status:** OFR-1 is a standard finite backward-induction theorem; OFR-2 is a checked conditional countermodel and positive bounded-latency model; OFR-3 is a conditional causal/resource obstruction. None is unrestricted X3 or empirical validation.