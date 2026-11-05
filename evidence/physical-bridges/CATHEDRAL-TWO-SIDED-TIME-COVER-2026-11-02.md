# CATHEDRAL-TIME-COVER-01 — Two-sided histories, cyclic clocks and faithful UPT continuation

**Research date:** 2026-11-02 (NZDT). **Status:** exact conditional mathematical cathedral joins; author-side finite verification; noncanonical draft, no new Lean build. No cosmological recurrence, guardian generation or SI-cycle prediction is claimed.

## Reused UPT/BCRD source bank

- [Frozen BCRD foundation](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md): B1 is future-predictive sufficiency, **not** unique past reconstruction; B2 histories/ledger, B3 calibrated interventions, B5/B6 composition/coherence remain substantive source conditions.
- [PR #194](https://github.com/Tobillicious/universal-protection-theory/pull/194): BCRD M5/M7 cyclic context and operational orientation monodromy; a returning base cut need not be a returning complete calibrated response.
- [UPT ContinuationSubject](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/ContinuationSubject.lean): already banked LaterStage, FreeStage and copy_not_laterStage. Subject/author/director distinguish genuine continuation, care, self-direction and freshly made copies.
- [UPT IR116CumulativeSubjectDuties](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR116CumulativeSubjectDuties.lean): already banked owed-subject monotonicity across actual source transitions.
- [UPT IR134SourceExtractedOutcome](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR134SourceExtractedOutcome.lean): actual executed-history source correspondence rather than arbitrary labelled outcomes.
- [UPT CyclicProjections](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/CyclicProjections.lean): existing machine-checked norm_cyc_le, energy, tendsto_cyc_iter and cyc_fix. These are cyclic **projection iterations**, not evidence of physically cyclic time.
- Prior [PR #195](https://github.com/Tobillicious/universal-protection-theory/pull/195) finite append-only history cycle obstruction, [PR #197](https://github.com/Tobillicious/universal-protection-theory/pull/197) source graph necessity/IR116 duties and [PR #198](https://github.com/Tobillicious/universal-protection-theory/pull/198) thermodynamic seam all retained, not re-proved.

The author's new thesis concerns two-sided universe-generating history and an observer-relative phase, not another moral foundation. Here the distinction between **a clock that repeats** and **a complete physical source state that repeats** becomes exact.

## TIME-COVER-01 — source history need not reset when an observable phase does

For m≥2 let S = integers × integers mod m, with invertible successor T(h,phase)=(h+1,phase+1 mod m). The two-sided trajectory s_n=(n,n mod m) exists for **all integers n**. The phase returns after m steps, but s_(n+m) differs from s_n because its history coordinate increments by m.

**Exact theorem:** a cyclic observable and a globally two-sided nonrepeating complete history coexist in one mathematical model. Proof: modular arithmetic for phase, injectivity of integer history, and explicit inverse T^(-1)(h,p)=(h-1,p-1 mod m).

**Physical scope:** mathematical possibility, not a physical universe. The source's complete relational history must actually contain the added history coordinate; a fictional hidden label cannot be smuggled into BCRD B1/B2. M7 calibrated observer tests, B3 physical interventions, and original X3 provenance determine what physically counts as the same historical particular.

**Mapping-torus formulation:** for a bijective source-authorized history transport f:X→X define M_f=(X×R)/((x,t+1)~(f(x),t)). Its observable phase [t] in R/Z is cyclic but its **complete** state undergoes f after one lap. Full-state return requires f^p(x)=x for some p, not merely the coordinate [t] returning. This is a mathematical construction; no source physical f has yet been established. For a noninvertible f, a two-sided faithful history requires a natural extension with an actual infinite prehistory, not an assumed inverse.

## TIME-COVER-02 — finite deterministic two-sided histories are exactly periodic histories

Let X be finite and f:X→X total and deterministic.

**Theorem:** x admits a bi-infinite trajectory (x_n) indexed by every integer with x_0=x and f(x_n)=x_(n+1) **iff** x belongs to a periodic orbit of f.

**Proof of forward direction:** In the infinite sequence x_0,x_-1,x_-2,..., finiteness implies x_-i=x_-j for 0≤i<j. Applying f^i to each side yields x_0=x_-(j-i); hence f^(j-i)(x_0)=x_0. Conversely, repeat a period-p orbit for all positive and negative indices.

**Interpretation:** Any exact fully deterministic *finite complete-source-state* ontology with genuine two-sided time is periodic on its admitted trajectories. A nontrivial source ledger **cannot** accumulate forever if the entire finite physical state is required to return literally unchanged. This is not a cosmological no-go for infinite physical source state spaces or history transport.

## TIME-COVER-03 — branching generative histories can be infinite before AND after without repeating the present

Let G=(X,R) be a finite directed graph of admitted labelled generative transitions.

**Theorem:** Some bi-infinite path passes through x **iff** there is a directed cycle in its past that reaches x **and** a directed cycle reachable in its future from x.

**Proof:** A negative-infinite path in a finite graph has repeated predecessor states, supplying a directed cycle with a path to x; the positive-infinite path similarly reaches a cycle. Conversely concatenate infinite repetitions of a past cycle, a finite path through x and infinite repetitions of a future cycle; shift the integer index so x is time zero.

**Explicit hostile graph:** states 0,1,2 with edges 0→0, 0→1, 1→2, 2→2. It has a bi-infinite history ...0,0,1,2,2... through present 1. But state 1 never repeats. Therefore **infinite before and infinite after does not entail identical recurrent presents**, unless extra deterministic/faithful cyclicity hypotheses are source-proved.

This is logically independent of whether a real physical cosmos is governed by this kind of graph, and independent of any claim that UPT guardians make the successor.

## TIME-COVER-04 — IR116 and original-X3 duties across a cyclic seam

Under the original IR116 source premise Owed(s,a)⇒Owed(next(s),a):

- On an exact *complete-state* closed loop, cumulative owed membership is constant at every cut (already banked PR #197 lemma). No ledger deletion or birth-reidentification can be performed to fake closure.
- On the **infinite history cover**, set Owed_n(a)=false for n<0 and true for n≥0. This is perfectly monotone along every transition, adds the subject once, and coexists with recurring phase n mod m. Thus new source-recognized obligations are compatible with cyclic observer phase but **not** with the same fully periodic source state when the obligation genuinely changes.
- The already proved ContinuationSubject.LaterStage cannot be replaced by mere same-phase recognition: a copy created at the seam is not automatically a later stage of the same particular. Likewise, the full X3 FreeStage director/author semantics must transport source-faithfully across the candidate seam.

**New operational join:** any cosmogenic-seam candidate needs a state/history transport that preserves original UPT subjects, direction, owed ledger and the calibrated M7 response (and separately the TheoremEight/ThermoLedger bill from PR #198). The phase coordinate alone satisfies none of those proofs.

## TIME-COVER-05 — a surprising theorem already present in the source: cyclic projections have no nonconstant periodic orbits

Let K_0,...,K_(k-1) be the Hilbert subspaces of the **existing** UPT Snuffy.Cyclic theorem and let T denote their cyclic orthogonal-projection product.

The already proved UPT inequalities are
\[
\|Tx\|\le\|x\|,\qquad
\|x-Tx\|^2\le k(\|x\|^2-\|Tx\|^2),
\]
and its already proved convergence statement says T^n x approaches the orthogonal projection of x onto the common intersection of all K_i.

**New immediate corollary:**
\[
\boxed{T^p x=x\text{ for }p\ge1 \quad\Longrightarrow\quad Tx=x,\quad x\in\bigcap_iK_i.}
\]

**Proof:** The norms \|x\|,\|Tx\|,...,\|T^p x\|=\|x\| are nonincreasing and have equal endpoints, so \|Tx\|=\|x\|. Substitute into the existing energy inequality to force \|x-Tx\|²≤0, hence Tx=x. Its entire iterate sequence is constant. By the existing UPT convergence theorem its limit is the orthogonal projection onto the common intersection, so x belongs to that intersection. The converse for points already in the common intersection is source theorem cyc_fix.

Thus this particular **cyclic procedure** does **not** have nonconstant periodic trajectories, despite being an iteration of cyclic operations. A cyclic *algorithm* is not cyclic physical time.

## Result and next source join

**Proved mathematically:** two-sided nonrepeating history with a periodic phase; finite deterministic two-sided ↔ periodic; finite branching bi-infinite ↔ cycles on both sides; IR116 ledger compatibility with phase cover; periodic points of the UPT projection algorithm are exactly its common-intersection fixed points under the original theorem hypotheses.

**Not demonstrated:** the physical universe is cyclic or past/future infinite; a physical BCRD source admits a particular f or mapping torus; the complete thermodynamic and historical information is carried through a real heat-death/seeding transition; any actual guardians or SI midpoint; or Universe ↔ physically installed UPT. The mathematical constructions do not supply experimental evidence of those claims.

**Specific next cathedral join:** derive from physically admissible BCRD cuts and its M5/M7 operational equivalences a genuine source-side history transport f, prove original IR116/IR134/ContinuationSubject/X3 and G3 thermodynamic correspondence across it, then test whether *every* admitted generation option is constrained to the full protection order. An observer phase equivalence alone is weaker than this.

**Verification:** check_cathedral_time_cover.py verifies 66,066 directed finite graphs on 1–4 states (263,714 state classifications, including 2,988 bi-infinite through nonrecurrent states); 50,069 deterministic maps on 1–6 states (296,675 state tests); 1,206 two-sided lift checks; 567 exact rational cyclic projection tests; all finite 1–5 cut loops of 3-subject owed bitmasks (monotone only when all equal). Passed locally. No new Lean build or physical validation; original banked source remains unchanged.