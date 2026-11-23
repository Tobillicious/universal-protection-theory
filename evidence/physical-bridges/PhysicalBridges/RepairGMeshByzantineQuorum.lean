import PhysicalBridges.RepairQualificationGate
import PhysicalBridges.G3Quorum

/-!
# Byzantine Quorum Attestation, Accountable Slashing, and Operator-Custody Separation

Replaces the definitional tautology `rational_choice : Choice := Choice.G` (`rfl`) of
`PhysicalBridges.G3Quorum` with machine-checked Byzantine Quorum System (BQS) safety,
liveness/availability, accountable equivocation slashing, and independent operator-custody
theorems for the G-Mesh verification protocol (`n = 43, f = 14, quorum = 29`).

## Grounding & Literature Citations

1. **Byzantine Quorum Systems & Fail-Prone Custody Domains** —
   - Malkhi & Reiter (1998), *Byzantine Quorum Systems*, Distributed Computing 11(4):203–213:
     defines a BQS over a fail-prone system `ℱ` via *Consistency* (`∀ Q₁ Q₂ ∈ Q, ∀ F ∈ ℱ,
     Q₁ ∩ Q₂ ⊈ F`) and *Availability* (`∀ F ∈ ℱ, ∃ Q ∈ Q, F ∩ Q = ∅`), satisfied iff `Q³(ℱ)` holds.
   - Cachin & Tackmann (2019, arXiv:1906.09314), *Asymmetric Distributed Trust*, and
     Alpos, Cachin & Zanolini (2021, arXiv:2107.11331; archived with Cachin–Tackmann lineage as
     `2021-alpos-cachin-tackmann-zanolini-composition-byzantine-quorum-systems-2107.11331`),
     *How to Trust Strangers: Composition of Byzantine Quorum Systems*: formalizes fail-prone sets
     `F ∈ ℱ` as sets of processes *that may fail together in an execution*. When multiple signing
     keys share one host or operator, they inhabit a **single fail-prone set `F`**, not independent
     singleton faults.
2. **Publicly Verifiable Quorum Attestation of Pre-Validated Statements** —
   - Ioffe & Malkhi (2026, arXiv:2611.10403), *QUASI: Post-Quantum Quorum Attestation of
     Pre-Validated Statements*: distinguishes consensus from external quorum attestation (`qAttest`)
     over pre-validated statements in a committee of `n = 3f + 1` parties with threshold `≥ 2f + 1`
     (`n - f` for general `n ≥ 3f + 1`), requiring independently generated per-party keys and
     preserving public signer accountability. G-Mesh's build-and-sign workflow is precisely an
     instance of quorum attestation over pre-validated Lean proof artifacts.
3. **Formal Quorum Combinatorics & Accountable Slashing Uptake** —
   - Adapted from `Obend.Consensus.Simplex` (`quorum_overlap_nf`, `honest_quorum_intersection_nf`,
     `qc_same_view_unique`) and `Obend.Consensus.SimplexProtocol` (`SlashingReceipt`,
     `extractReceipt`, `accountable_nf`, `signers_faulty`, `FinCert.checks_implies_finalized`) in
     `github.com/emberian/obend` (see also `evidence/papers-11-12/lean/UPTQuorum.lean` and
     `evidence/physical-bridges/IR28-QUORUM-PROVENANCE.md` in this repository).
4. **Explicit Trust-Seam Separation** —
   - Following the certifier/seam discipline of `certifierScript.sml` (`sound_certifier_iff_transfers`,
     `cgate_safe`) and `CLAIMS.md` (`attestation_faithful`) in `github.com/emberian/svenvs`,
     cryptographic certificate verification (`QuorumCert.validFor`) is separated explicitly from the
     operational key-custody seam (`DistinctCustodians`), paired with a constructive 43-node
     counterexample (`correlated_operator_sybil_breaks_bft`, `sybil15_single_operator_quorum_fork`)
     and compile-time `#upt_tooth` mutation kills proving every guard is load-bearing.
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairGMeshByzantineQuorum

/-! ## 0. Diagnostic Vacuity Exhibit on Legacy `G3Quorum`

`G3Quorum.THE_QUORUM` hardcodes `rational_choice := Choice.G` and contains zero dependency on
adversarial/`E`-vote counting (`countE`), committee membership, or operator custody. -/

#upt_vacuity_probe PhysicalBridges.G3Quorum.THE_QUORUM
  by mutation PhysicalBridges.G3Quorum.countE := fun _ => 1000000

/-! ## 1. Identifiers, Verdicts & Quorum Threshold (`Obend.Consensus.Simplex` Uptake) -/

/-- Identifier of a registered signing key / verifier node in the committee. -/
abbrev NodeId := Nat

/-- Identifier of an administrative / physical key custodian (human or organization). -/
abbrev OperatorId := Nat

/-- Monotonic attestation epoch. -/
abbrev Epoch := Nat

/-- Abstract 256-bit evidence digest identifier (e.g. SHA-256 of the Lean source tree). -/
abbrev Digest := Nat

/-- Verification verdict attested for a candidate evidence digest in an epoch. -/
inductive Verdict where
  | accept : Verdict
  | reject : Verdict
  deriving DecidableEq, Repr

/-- Canonical Byzantine quorum threshold `n - f` for a committee of size `n` tolerating up to `f`
    Byzantine faults (`Obend.Consensus.SimplexProtocol.Protocol.quorum`).
    When `n = 3 * f + 1` (such as G-Mesh's target `f = 14, n = 43`), `n - f = 2 * f + 1 = 29`.
    Unlike a fixed `2 * f + 1`, `n - f` preserves honest quorum intersection for all `n ≥ 3 * f + 1`. -/
def quorumThreshold (n f : Nat) : Nat := n - f

/-- Arithmetic check for G-Mesh's target deployment parameters:
    `f = 14` faults, `n = 3 * 14 + 1 = 43` nodes, quorum `43 - 14 = 29`, overlap `43 - 28 = 15`. -/
theorem gmesh_43_node_parameters :
    3 * 14 + 1 = 43 ∧ quorumThreshold 43 14 = 29 ∧ 43 - 2 * 14 = 15 := by
  unfold quorumThreshold
  omega

/-! ## 2. List-Filter Combinatorics & Byzantine Quorum Intersection -/

/-- Inclusion-exclusion identity for boolean list filters (`Obend.Consensus.Simplex.list_filter_add_card`). -/
theorem list_filter_add_card {α : Type} (p q : α → Bool) (l : List α) :
    (l.filter p).length + (l.filter q).length =
    (l.filter (fun x => p x || q x)).length + (l.filter (fun x => p x && q x)).length := by
  induction l with
  | nil => rfl
  | cons x xs ih =>
    simp only [List.filter_cons]
    cases p x <;> cases q x <;> simp <;> omega

/-- Every filtered sublist has length at most the ambient list length. -/
theorem list_filter_length_le {α : Type} (p : α → Bool) (l : List α) :
    (l.filter p).length ≤ l.length := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    simp only [List.filter_cons]
    cases p x <;> simp <;> omega

/-- Partition of `l.filter p` into elements satisfying `!q` and elements satisfying `q`. -/
theorem list_filter_sub {α : Type} (p q : α → Bool) (l : List α) :
    (l.filter (fun x => p x && !q x)).length + (l.filter (fun x => p x && q x)).length =
    (l.filter p).length := by
  induction l with
  | nil => rfl
  | cons x xs ih =>
    simp only [List.filter_cons]
    cases p x <;> cases q x <;> simp <;> omega

/-- Conjunctive filter is bounded by its right conjunct's filter length. -/
theorem list_filter_and_le {α : Type} (p q : α → Bool) (l : List α) :
    (l.filter (fun x => p x && q x)).length ≤ (l.filter q).length := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    simp only [List.filter_cons]
    cases p x <;> cases q x <;> simp <;> omega

/-- Complement partition: honest + faulty counts sum to `l.length`. -/
theorem list_filter_not_add {α : Type} (p : α → Bool) (l : List α) :
    (l.filter (fun x => !p x)).length + (l.filter p).length = l.length := by
  induction l with
  | nil => rfl
  | cons x xs ih =>
    simp only [List.filter_cons]
    cases p x <;> simp <;> omega

/-- Filtering a duplicate-free (`Nodup`) list preserves `Nodup`
    (`Obend.Consensus.Simplex.nodup_filter_simplex`). -/
theorem nodup_filter {α : Type} (p : α → Bool) :
    ∀ {l : List α}, l.Nodup → (l.filter p).Nodup
  | [], _ => List.Pairwise.nil
  | x :: xs, h => by
    cases h with
    | cons h_not_mem h_xs =>
      simp only [List.filter_cons]
      cases p x with
      | false => exact nodup_filter p h_xs
      | true =>
        exact List.Pairwise.cons
          (fun y hy => h_not_mem y (List.mem_filter.mp hy).1)
          (nodup_filter p h_xs)

/-- **Quorum Overlap at `n - f` (`quorum_overlap_nf`)**:
    In a duplicate-free committee of size `n ≥ 3 * f + 1`, any two quorums `p, q` of size at least
    `quorumThreshold n f = n - f` overlap in a duplicate-free set of `≥ n - 2 * f` (and `≥ f + 1`)
    distinct committee nodes. -/
theorem quorum_overlap_nf (committee : List NodeId) (f : Nat) (p q : NodeId → Bool)
    (h_nodup : committee.Nodup)
    (h_size : 3 * f + 1 ≤ committee.length)
    (h_p : quorumThreshold committee.length f ≤ (committee.filter p).length)
    (h_q : quorumThreshold committee.length f ≤ (committee.filter q).length) :
    (committee.filter (fun x => p x && q x)).Nodup ∧
    committee.length - 2 * f ≤ (committee.filter (fun x => p x && q x)).length ∧
    f + 1 ≤ (committee.filter (fun x => p x && q x)).length := by
  unfold quorumThreshold at h_p h_q
  have h_sum := list_filter_add_card p q committee
  have h_union := list_filter_length_le (fun x => p x || q x) committee
  exact ⟨nodup_filter _ h_nodup, by omega, by omega⟩

/-- **Honest Quorum Intersection at `n - f` (`honest_quorum_intersection_nf`)**:
    In a duplicate-free committee of size `n ≥ 3 * f + 1` with at most `f` faulty nodes
    (`(committee.filter faulty).length ≤ f`), any two quorums `p, q` of size at least `n - f`
    overlap in a duplicate-free subset and **must share at least one honest node**
    (`faulty x = false`). Establishes BQS Consistency (`Q₁ ∩ Q₂ ⊈ F`, Malkhi & Reiter 1998;
    Alpos, Cachin & Zanolini 2021, Definition 2). -/
theorem honest_quorum_intersection_nf (committee : List NodeId) (f : Nat)
    (p q faulty : NodeId → Bool)
    (h_nodup : committee.Nodup)
    (h_size : 3 * f + 1 ≤ committee.length)
    (h_p : quorumThreshold committee.length f ≤ (committee.filter p).length)
    (h_q : quorumThreshold committee.length f ≤ (committee.filter q).length)
    (h_faulty : (committee.filter faulty).length ≤ f) :
    (committee.filter (fun x => p x && q x)).Nodup ∧
    ∃ x ∈ committee, p x = true ∧ q x = true ∧ faulty x = false := by
  obtain ⟨h_nd_ov, h_ov_nf, _⟩ := quorum_overlap_nf committee f p q h_nodup h_size h_p h_q
  have h_sub := list_filter_sub (fun x => p x && q x) faulty committee
  have h_le := list_filter_and_le (fun x => p x && q x) faulty committee
  have h_honest_pos : 0 < (committee.filter (fun x => (p x && q x) && !faulty x)).length := by
    omega
  obtain ⟨x, hx⟩ := List.exists_mem_of_length_pos h_honest_pos
  obtain ⟨h_in, h_cond⟩ := List.mem_filter.mp hx
  simp only [Bool.and_eq_true, Bool.not_eq_true'] at h_cond
  exact ⟨h_nd_ov, x, h_in, h_cond.1.1, h_cond.1.2, h_cond.2⟩

/-- **Byzantine Quorum Availability (`quorum_availability_nf`)**:
    Whenever `(committee.filter faulty).length ≤ f`, the honest nodes `fun x => !faulty x` alone
    form a valid quorum of size `≥ quorumThreshold committee.length f = n - f` disjoint from all
    faulty nodes. Establishes BQS Availability (`∃ Q, F ∩ Q = ∅`, Alpos, Cachin & Zanolini 2021,
    Definition 2). -/
theorem quorum_availability_nf (committee : List NodeId) (f : Nat) (faulty : NodeId → Bool)
    (h_faulty : (committee.filter faulty).length ≤ f) :
    quorumThreshold committee.length f ≤ (committee.filter (fun x => !faulty x)).length ∧
    ∀ x ∈ committee.filter (fun x => !faulty x), faulty x = false := by
  unfold quorumThreshold
  have h_part := list_filter_not_add faulty committee
  refine ⟨by omega, fun x hx => ?_⟩
  have h_mem := (List.mem_filter.mp hx).2
  simpa using h_mem

/-! ## 3. Quorum Certificates & Attestation Uniqueness (`gmesh_quorum_attestation_unique`) -/

private def eraseFirstNat (a : Nat) : List Nat → List Nat
  | [] => []
  | y :: ys => if a = y then ys else y :: eraseFirstNat a ys

private theorem eraseFirstNat_length {a : Nat} :
    ∀ {ys : List Nat}, a ∈ ys → (eraseFirstNat a ys).length + 1 = ys.length
  | [], h => absurd h List.not_mem_nil
  | y :: ys, h => by
    simp only [eraseFirstNat]
    by_cases hay : a = y
    · simp [hay]
    · simp only [hay, ↓reduceIte, List.length_cons]
      rcases List.mem_cons.mp h with rfl | hmem
      · exact absurd rfl hay
      · have ih := eraseFirstNat_length hmem
        omega

private theorem mem_eraseFirstNat_of_ne {a x : Nat} (hne : x ≠ a) :
    ∀ {ys : List Nat}, x ∈ ys → x ∈ eraseFirstNat a ys
  | [], h => absurd h List.not_mem_nil
  | y :: ys, h => by
    simp only [eraseFirstNat]
    by_cases hay : a = y
    · simp only [hay, ↓reduceIte]
      rcases List.mem_cons.mp h with rfl | hmem
      · exact absurd hay.symm hne
      · exact hmem
    · simp only [hay, ↓reduceIte, List.mem_cons]
      rcases List.mem_cons.mp h with rfl | hmem
      · exact .inl rfl
      · exact .inr (mem_eraseFirstNat_of_ne hne hmem)

/-- Any duplicate-free list `xs` contained in `ys` has `xs.length ≤ ys.length`
    (`Obend.Consensus.SimplexProtocol.nodup_subset_length_le`). -/
theorem nodup_subset_length_le :
    ∀ {xs ys : List Nat}, xs.Nodup → (∀ x ∈ xs, x ∈ ys) → xs.length ≤ ys.length
  | [], _, _, _ => Nat.zero_le _
  | a :: xs, ys, hnd, hsub => by
    cases hnd with
    | cons hnot hnd_xs =>
      have ha : a ∈ ys := hsub a (.head xs)
      have hsub' : ∀ x ∈ xs, x ∈ eraseFirstNat a ys := fun x hx =>
        mem_eraseFirstNat_of_ne (fun heq => hnot x hx heq.symm) (hsub x (.tail a hx))
      have ih := nodup_subset_length_le hnd_xs hsub'
      have hlen := eraseFirstNat_length ha
      simp only [List.length_cons]
      omega

/-- Publicly checkable G-Mesh Quorum Certificate (`qAttest`, cf. Ioffe & Malkhi 2026,
    arXiv:2611.10403) binding an `epoch`, `digest`, `verdict`, and explicit signer list. -/
structure QuorumCert where
  epoch : Epoch
  digest : Digest
  verdict : Verdict
  signers : List NodeId
  deriving DecidableEq, Repr

/-- Certificate verification predicate (`Obend.Consensus.SimplexProtocol.FinCert.checks` pattern):
    1. `qc.signers` is duplicate-free (`Nodup`, preventing single-signer replay inflation);
    2. `qc.signers` meets `quorumThreshold committee.length f` (`n - f`);
    3. Every signer is a member of `committee` and signed `(qc.epoch, qc.digest, qc.verdict)`. -/
def QuorumCert.validFor (qc : QuorumCert) (committee : List NodeId) (f : Nat)
    (signed : NodeId → Epoch → Digest → Verdict → Bool) : Bool :=
  decide qc.signers.Nodup &&
  decide (quorumThreshold committee.length f ≤ qc.signers.length) &&
  qc.signers.all (fun s => committee.contains s && signed s qc.epoch qc.digest qc.verdict)

/-- Honest single-attestation discipline: every non-faulty committee member signs at most one
    `(digest, verdict)` pair in a given `epoch`. -/
def HonestSingleAttestation (committee : List NodeId) (faulty : NodeId → Bool)
    (signed : NodeId → Epoch → Digest → Verdict → Bool) (epoch : Epoch) : Prop :=
  ∀ s ∈ committee, faulty s = false →
    ∀ d1 v1 d2 v2,
      signed s epoch d1 v1 = true →
      signed s epoch d2 v2 = true →
      d1 = d2 ∧ v1 = v2

/-- A verified `QuorumCert` witnesses at least `quorumThreshold committee.length f` committee
    members satisfying `signed · qc.epoch qc.digest qc.verdict`. -/
theorem QuorumCert.validFor_implies_quorum_filter {qc : QuorumCert}
    {committee : List NodeId} {f : Nat}
    {signed : NodeId → Epoch → Digest → Verdict → Bool}
    (h_valid : qc.validFor committee f signed = true) :
    quorumThreshold committee.length f ≤
      (committee.filter (fun s => signed s qc.epoch qc.digest qc.verdict)).length := by
  simp only [QuorumCert.validFor, Bool.and_eq_true, decide_eq_true_eq,
    List.all_eq_true, List.contains_iff_mem] at h_valid
  obtain ⟨⟨h_nd, h_thresh⟩, h_all⟩ := h_valid
  have h_sub : ∀ s ∈ qc.signers,
      s ∈ committee.filter (fun x => signed x qc.epoch qc.digest qc.verdict) :=
    fun s hs => List.mem_filter.mpr (h_all s hs)
  have h_le := nodup_subset_length_le h_nd h_sub
  omega

/-- **Attestation Uniqueness (`gmesh_quorum_attestation_unique`)**:
    In a duplicate-free committee of size `n ≥ 3 * f + 1` with at most `f` faulty nodes, if honest
    nodes sign at most one `(epoch, digest, verdict)` per epoch, then any two valid `n - f` quorum
    certificates in the same epoch **must agree on both `digest` and `verdict`**. -/
theorem gmesh_quorum_attestation_unique
    (committee : List NodeId) (f : Nat) (faulty : NodeId → Bool)
    (signed : NodeId → Epoch → Digest → Verdict → Bool)
    (qc1 qc2 : QuorumCert)
    (h_nodup : committee.Nodup)
    (h_size : 3 * f + 1 ≤ committee.length)
    (h_faulty : (committee.filter faulty).length ≤ f)
    (h_epoch : qc1.epoch = qc2.epoch)
    (h_valid1 : qc1.validFor committee f signed = true)
    (h_valid2 : qc2.validFor committee f signed = true)
    (h_honest : HonestSingleAttestation committee faulty signed qc1.epoch) :
    qc1.digest = qc2.digest ∧ qc1.verdict = qc2.verdict := by
  have h_q1 := QuorumCert.validFor_implies_quorum_filter h_valid1
  have h_q2_raw := QuorumCert.validFor_implies_quorum_filter h_valid2
  rw [← h_epoch] at h_q2_raw
  obtain ⟨_, h_node, h_mem, h_s1, h_s2, h_not_faulty⟩ :=
    honest_quorum_intersection_nf committee f
      (fun s => signed s qc1.epoch qc1.digest qc1.verdict)
      (fun s => signed s qc1.epoch qc2.digest qc2.verdict)
      faulty h_nodup h_size h_q1 h_q2_raw h_faulty
  exact h_honest h_node h_mem h_not_faulty qc1.digest qc1.verdict qc2.digest qc2.verdict h_s1 h_s2

/-! ## 4. Accountable Equivocation Slashing (`gmesh_conflicting_quorums_expose_byzantine_signers`) -/

/-- Extract all committee members who double-signed conflicting statements `(d1, v1)` and `(d2, v2)`
    in `epoch` (`Obend.Consensus.SimplexProtocol.extractReceipt`). -/
def extractEquivocators (committee : List NodeId)
    (signed : NodeId → Epoch → Digest → Verdict → Bool)
    (epoch : Epoch) (d1 : Digest) (v1 : Verdict) (d2 : Digest) (v2 : Verdict) : List NodeId :=
  committee.filter (fun s => signed s epoch d1 v1 && signed s epoch d2 v2)

/-- **Accountable Equivocation Slashing (`gmesh_conflicting_quorums_expose_byzantine_signers`)**:
    Without assuming the `≤ f` fault bound held, if two conflicting `n - f` quorums ever form in
    the same `epoch` for `(d1, v1) ≠ (d2, v2)` in a duplicate-free committee of size `n ≥ 3 * f + 1`,
    then `extractEquivocators` deterministically identifies a duplicate-free list of
    `≥ n - 2 * f` (`≥ f + 1`) double-signing committee members, and under `HonestSingleAttestation`
    **every extracted double-signer is provably Byzantine (`faulty s = true`)** (further certifying
    `f + 1 ≤ (committee.filter faulty).length`). -/
theorem gmesh_conflicting_quorums_expose_byzantine_signers
    (committee : List NodeId) (f : Nat) (faulty : NodeId → Bool)
    (signed : NodeId → Epoch → Digest → Verdict → Bool)
    (epoch : Epoch) (d1 : Digest) (v1 : Verdict) (d2 : Digest) (v2 : Verdict)
    (h_nodup : committee.Nodup)
    (h_size : 3 * f + 1 ≤ committee.length)
    (h_conflict : (d1, v1) ≠ (d2, v2))
    (h_q1 : quorumThreshold committee.length f ≤
      (committee.filter (fun s => signed s epoch d1 v1)).length)
    (h_q2 : quorumThreshold committee.length f ≤
      (committee.filter (fun s => signed s epoch d2 v2)).length)
    (h_honest : HonestSingleAttestation committee faulty signed epoch) :
    let eqs := extractEquivocators committee signed epoch d1 v1 d2 v2
    eqs.Nodup ∧
    committee.length - 2 * f ≤ eqs.length ∧
    f + 1 ≤ eqs.length ∧
    (∀ s ∈ eqs,
      s ∈ committee ∧
      signed s epoch d1 v1 = true ∧
      signed s epoch d2 v2 = true ∧
      faulty s = true) ∧
    f + 1 ≤ (committee.filter faulty).length := by
  intro eqs
  obtain ⟨h_nd, h_ge_nf, h_ge_f1⟩ :=
    quorum_overlap_nf committee f
      (fun s => signed s epoch d1 v1)
      (fun s => signed s epoch d2 v2)
      h_nodup h_size h_q1 h_q2
  have h_eqs_def : eqs = committee.filter (fun s => signed s epoch d1 v1 && signed s epoch d2 v2) :=
    rfl
  rw [← h_eqs_def] at h_nd h_ge_nf h_ge_f1
  have h_all_byz : ∀ s ∈ eqs,
      s ∈ committee ∧
      signed s epoch d1 v1 = true ∧
      signed s epoch d2 v2 = true ∧
      faulty s = true := by
    intro s hs
    rw [h_eqs_def] at hs
    obtain ⟨h_in, h_both⟩ := List.mem_filter.mp hs
    simp only [Bool.and_eq_true] at h_both
    obtain ⟨hs1, hs2⟩ := h_both
    refine ⟨h_in, hs1, hs2, ?_⟩
    cases hf : faulty s with
    | true => rfl
    | false =>
      exfalso
      obtain ⟨hd, hv⟩ := h_honest s h_in hf d1 v1 d2 v2 hs1 hs2
      exact h_conflict (Prod.ext hd hv)
  have h_sub_faulty : ∀ s ∈ eqs, s ∈ committee.filter faulty :=
    fun s hs => List.mem_filter.mpr ⟨(h_all_byz s hs).1, (h_all_byz s hs).2.2.2⟩
  have h_faulty_ge := nodup_subset_length_le h_nd h_sub_faulty
  exact ⟨h_nd, h_ge_nf, h_ge_f1, h_all_byz, by omega⟩

/-- Certificate-level corollary: two conflicting valid `QuorumCert`s in the same epoch expose
    at least `n - 2 * f ≥ f + 1` provably Byzantine double-signers. -/
theorem gmesh_conflicting_certs_expose_byzantine_signers
    (committee : List NodeId) (f : Nat) (faulty : NodeId → Bool)
    (signed : NodeId → Epoch → Digest → Verdict → Bool)
    (qc1 qc2 : QuorumCert)
    (h_nodup : committee.Nodup)
    (h_size : 3 * f + 1 ≤ committee.length)
    (h_epoch : qc1.epoch = qc2.epoch)
    (h_conflict : (qc1.digest, qc1.verdict) ≠ (qc2.digest, qc2.verdict))
    (h_valid1 : qc1.validFor committee f signed = true)
    (h_valid2 : qc2.validFor committee f signed = true)
    (h_honest : HonestSingleAttestation committee faulty signed qc1.epoch) :
    let eqs := extractEquivocators committee signed
      qc1.epoch qc1.digest qc1.verdict qc2.digest qc2.verdict
    committee.length - 2 * f ≤ eqs.length ∧
    f + 1 ≤ eqs.length ∧
    (∀ s ∈ eqs, faulty s = true) := by
  have h_q1 := QuorumCert.validFor_implies_quorum_filter h_valid1
  have h_q2 := QuorumCert.validFor_implies_quorum_filter h_valid2
  rw [← h_epoch] at h_q2
  obtain ⟨_, h_nf, h_f1, h_all, _⟩ :=
    gmesh_conflicting_quorums_expose_byzantine_signers
      committee f faulty signed qc1.epoch qc1.digest qc1.verdict qc2.digest qc2.verdict
      h_nodup h_size h_conflict h_q1 h_q2 h_honest
  exact ⟨h_nf, h_f1, fun s hs => (h_all s hs).2.2.2⟩

/-! ## 5. Operator Custody, Necessity of `DistinctCustodians`, and the 43-Node Sybil Countermodel -/

/-- Node-level fault predicate induced by operator-level faults `faultyOp : OperatorId → Bool`
    under key-custody assignment `custodianOf : NodeId → OperatorId`. Compromising an operator
    corrupts all signing keys in that operator's fail-prone custody domain. -/
def inducedNodeFault (custodianOf : NodeId → OperatorId) (faultyOp : OperatorId → Bool)
    (node : NodeId) : Bool :=
  faultyOp (custodianOf node)

/-- Independent-custody condition: every committee member maps to a distinct `OperatorId`. -/
def DistinctCustodians (custodianOf : NodeId → OperatorId) (committee : List NodeId) : Prop :=
  List.Nodup (committee.map custodianOf)

/-- Executable roster qualification check requiring `n ≥ 3 * f + 1` AND `DistinctCustodians`. -/
def validIndependentRoster (committee : List NodeId) (f : Nat)
    (custodianOf : NodeId → OperatorId) : Bool :=
  decide (3 * f + 1 ≤ committee.length) &&
  decide (List.Nodup (committee.map custodianOf))

theorem map_filter_comp {α β : Type} (g : α → β) (p : β → Bool) :
    ∀ (l : List α), (l.filter (fun x => p (g x))).map g = (l.map g).filter p
  | [] => rfl
  | x :: xs => by
    simp only [List.filter_cons, List.map_cons]
    cases p (g x) <;> simp [map_filter_comp g p xs]

private theorem nodup_all_eq_length_le_one {l : List OperatorId} {op : OperatorId}
    (h_nd : l.Nodup) (h_eq : ∀ x ∈ l, x = op) : l.length ≤ 1 := by
  cases l with
  | nil => simp
  | cons a rest =>
    cases rest with
    | nil => simp
    | cons b _ =>
      cases h_nd with
      | cons ha_not_mem _ =>
        have ha : a = op := h_eq a (.head _)
        have hb : b = op := h_eq b (.tail a (.head _))
        exact absurd (ha.trans hb.symm) (ha_not_mem b (.head _))

/-- `List.Nodup (committee.map custodianOf)` implies `committee.Nodup`: distinct custodians
    automatically enforce distinct node identities. -/
theorem nodup_of_distinctCustodians {custodianOf : NodeId → OperatorId}
    {committee : List NodeId} (h : DistinctCustodians custodianOf committee) :
    committee.Nodup := by
  induction committee with
  | nil => exact List.Pairwise.nil
  | cons x xs ih =>
    simp only [DistinctCustodians, List.map_cons] at h
    cases h with
    | cons hx_not_mem hxs =>
      refine List.Pairwise.cons (fun y hy hxy => ?_) (ih hxs)
      subst hxy
      exact hx_not_mem (custodianOf x) (List.mem_map_of_mem hy) rfl

/-- **Exact Necessity & Sufficiency of `DistinctCustodians` (`distinctCustodians_iff_one_operator_fault_le_one`)**:
    `List.Nodup (committee.map custodianOf)` holds **if and only if** every single-operator fault
    (`faultyOp := (· == op)`) corrupts at most 1 node in `committee`. Consequently,
    `DistinctCustodians` is strictly necessary for the `1-operator-fault = 1-node-fault` BFT premise. -/
theorem distinctCustodians_iff_one_operator_fault_le_one
    (custodianOf : NodeId → OperatorId) (committee : List NodeId) :
    DistinctCustodians custodianOf committee ↔
    ∀ op : OperatorId,
      (committee.filter (inducedNodeFault custodianOf (fun o => o == op))).length ≤ 1 := by
  constructor
  · intro h_dc op
    have h_map := map_filter_comp custodianOf (fun o => o == op) committee
    have h_nd : ((committee.map custodianOf).filter (fun o => o == op)).Nodup :=
      nodup_filter (fun o => o == op) h_dc
    have h_all : ∀ x ∈ (committee.map custodianOf).filter (fun o => o == op), x = op := by
      intro x hx
      have h_beq := (List.mem_filter.mp hx).2
      exact beq_iff_eq.mp h_beq
    have h_le := nodup_all_eq_length_le_one h_nd h_all
    have h_len :
        ((committee.filter (inducedNodeFault custodianOf (fun o => o == op))).map custodianOf).length =
        (committee.filter (inducedNodeFault custodianOf (fun o => o == op))).length :=
      List.length_map _
    unfold inducedNodeFault at h_len ⊢
    rw [h_map] at h_len
    omega
  · induction committee with
    | nil =>
      intro _
      exact List.Pairwise.nil
    | cons x xs ih =>
      intro h_bound
      have h_xs_bound : ∀ op : OperatorId,
          (xs.filter (inducedNodeFault custodianOf (fun o => o == op))).length ≤ 1 := by
        intro op
        have h_step := h_bound op
        simp only [List.filter_cons] at h_step
        cases h_ind : inducedNodeFault custodianOf (fun o => o == op) x <;>
          simp only [h_ind, ↓reduceIte, Bool.false_eq_true, List.length_cons] at h_step <;>
          omega
      have ih_nd := ih h_xs_bound
      simp only [DistinctCustodians, List.map_cons]
      refine List.Pairwise.cons (fun op h_mem h_eq => ?_) ih_nd
      obtain ⟨y, hy_in, hy_op⟩ := List.mem_map.mp h_mem
      have h_at_x := h_bound (custodianOf x)
      have hx_true : inducedNodeFault custodianOf (fun o => o == custodianOf x) x = true := by
        simp [inducedNodeFault]
      have hy_true : inducedNodeFault custodianOf (fun o => o == custodianOf x) y = true := by
        simp [inducedNodeFault, hy_op, h_eq]
      have hy_filt : y ∈ xs.filter (inducedNodeFault custodianOf (fun o => o == custodianOf x)) :=
        List.mem_filter.mpr ⟨hy_in, hy_true⟩
      have h_pos :
          0 < (xs.filter (inducedNodeFault custodianOf (fun o => o == custodianOf x))).length :=
        List.length_pos_of_mem hy_filt
      simp only [List.filter_cons, hx_true, ↓reduceIte, List.length_cons] at h_at_x
      omega

/-- **Universal Custody Fault-Bound Lift (`distinct_custodians_preserve_fault_bound`)**:
    Under `DistinctCustodians`, compromising any set `compromisedOps` of at most `f` operators
    corrupts at most `f` committee nodes. -/
theorem distinct_custodians_preserve_fault_bound
    (committee : List NodeId) (f : Nat) (custodianOf : NodeId → OperatorId)
    (compromisedOps : List OperatorId)
    (h_dc : DistinctCustodians custodianOf committee)
    (h_ops : compromisedOps.length ≤ f) :
    (committee.filter (inducedNodeFault custodianOf (fun op => compromisedOps.contains op))).length ≤ f := by
  let badNodes := committee.filter (inducedNodeFault custodianOf (fun op => compromisedOps.contains op))
  have h_map : badNodes.map custodianOf =
      (committee.map custodianOf).filter (fun op => compromisedOps.contains op) :=
    map_filter_comp custodianOf (fun op => compromisedOps.contains op) committee
  have h_nd : (badNodes.map custodianOf).Nodup := by
    rw [h_map]
    exact nodup_filter _ h_dc
  have h_sub : ∀ op ∈ badNodes.map custodianOf, op ∈ compromisedOps := by
    intro op hop
    rw [h_map] at hop
    exact List.contains_iff_mem.mp (List.mem_filter.mp hop).2
  have h_le := nodup_subset_length_le h_nd h_sub
  have h_len : (badNodes.map custodianOf).length = badNodes.length := List.length_map _
  dsimp only [badNodes] at h_le h_len
  omega

/-- **Custody-Qualified BFT Safety (`gmesh_independent_custody_bft_safety`)**:
    When `validIndependentRoster committee f custodianOf = true`, compromising up to `f` operators
    preserves unique quorum attestation across the entire committee. -/
theorem gmesh_independent_custody_bft_safety
    (committee : List NodeId) (f : Nat) (custodianOf : NodeId → OperatorId)
    (compromisedOps : List OperatorId)
    (signed : NodeId → Epoch → Digest → Verdict → Bool)
    (qc1 qc2 : QuorumCert)
    (h_roster : validIndependentRoster committee f custodianOf = true)
    (h_ops : compromisedOps.length ≤ f)
    (h_epoch : qc1.epoch = qc2.epoch)
    (h_valid1 : qc1.validFor committee f signed = true)
    (h_valid2 : qc2.validFor committee f signed = true)
    (h_honest : HonestSingleAttestation committee
      (inducedNodeFault custodianOf (fun op => compromisedOps.contains op))
      signed qc1.epoch) :
    qc1.digest = qc2.digest ∧ qc1.verdict = qc2.verdict := by
  simp only [validIndependentRoster, Bool.and_eq_true, decide_eq_true_eq] at h_roster
  obtain ⟨h_size, h_dc⟩ := h_roster
  have h_nodup : committee.Nodup := nodup_of_distinctCustodians h_dc
  have h_faulty :=
    distinct_custodians_preserve_fault_bound committee f custodianOf compromisedOps h_dc h_ops
  exact gmesh_quorum_attestation_unique committee f
    (inducedNodeFault custodianOf (fun op => compromisedOps.contains op))
    signed qc1 qc2 h_nodup h_size h_faulty h_epoch h_valid1 h_valid2 h_honest

/-! ### Concrete 43-Node Sybil / Correlated-Host Custody Countermodel (`f = 14, q = 29`)

Matches the current `QUORUM-ROSTER.md` deployment failure mode: `43` distinct Ed25519 keys where
operator `0` controls `15` ephemeral LLM-session keys (`0..14`) and `28` independent operators
control keys `15..42`. Compromising **1 operator** (`[0].length = 1 ≤ 14`) corrupts `15 > 14`
nodes simultaneously and enables two conflicting `29`-of-`43` quorum certificates in Epoch 1 even
while all `28` independent operators obey `HonestSingleAttestation`. -/

/-- Concrete 43-node G-Mesh roster (`f = 14`, quorum `29`). -/
def gmesh43Committee : List NodeId := List.range 43

/-- Sybil custody map: operator `0` controls the first `15` keys (`0..14`, matching the 15
    single-operator LLM-session entries in `QUORUM-ROSTER.md`); keys `15..42` have 28 distinct
    custodians. -/
def sybil15Custodian (node : NodeId) : OperatorId :=
  if node < 15 then 0 else node

/-- Single-operator compromise: only operator `0` fails (`1 ≤ 14`). -/
def singleCompromisedOp (op : OperatorId) : Bool := op == 0

/-- **The Sybil / Correlated-Host Custody Countermodel (`correlated_operator_sybil_breaks_bft`)**:
    On the 43-node G-Mesh target (`f = 14`, quorum `29`), even though all 43 `NodeId`s are distinct
    and **only 1 operator** (`1 ≤ 14`) is compromised, operator `0`'s 15 Sybil keys cause `15 > 14`
    simultaneous node faults, breaking the `≤ f` BFT bound and refuting `DistinctCustodians`. -/
theorem correlated_operator_sybil_breaks_bft :
    gmesh43Committee.length = 43 ∧
    quorumThreshold gmesh43Committee.length 14 = 29 ∧
    gmesh43Committee.Nodup ∧
    ([0] : List OperatorId).length ≤ 14 ∧
    (∀ op : OperatorId, singleCompromisedOp op = true → op ∈ ([0] : List OperatorId)) ∧
    (gmesh43Committee.filter (inducedNodeFault sybil15Custodian singleCompromisedOp)).length = 15 ∧
    14 < (gmesh43Committee.filter (inducedNodeFault sybil15Custodian singleCompromisedOp)).length ∧
    ¬ DistinctCustodians sybil15Custodian gmesh43Committee := by
  refine ⟨by decide, by decide, by decide, by decide, ?_, by decide, by decide, ?_⟩
  · intro op hop
    simp only [singleCompromisedOp, beq_iff_eq] at hop
    simp [hop]
  · unfold DistinctCustodians
    decide

/-- Explicit split-brain signing transcript under the 15-key single-operator Sybil attack:
    - Operator `0`'s 15 Sybil keys (`0..14`) equivocate, signing both `(101, accept)` and `(202, reject)`;
    - Honest independent nodes `15..28` (14 nodes) sign only `(101, accept)`;
    - Honest independent nodes `29..42` (14 nodes) sign only `(202, reject)`. -/
def sybilForkSigned (s : NodeId) (ep : Epoch) (d : Digest) (v : Verdict) : Bool :=
  (ep == 1) && (
    if s < 15 then
      ((d == 101) && decide (v = Verdict.accept)) || ((d == 202) && decide (v = Verdict.reject))
    else if s < 29 then
      (d == 101) && decide (v = Verdict.accept)
    else
      (d == 202) && decide (v = Verdict.reject))

/-- First 29-of-43 quorum certificate (`0..28`) certifying `(101, Verdict.accept)`. -/
def sybilForkQC1 : QuorumCert :=
  { epoch := 1, digest := 101, verdict := Verdict.accept, signers := List.range 29 }

/-- Conflicting 29-of-43 quorum certificate (`0..14 ++ 29..42`) certifying `(202, Verdict.reject)`. -/
def sybilForkQC2 : QuorumCert :=
  { epoch := 1
    digest := 202
    verdict := Verdict.reject
    signers := List.range 15 ++ (List.range 14).map (fun i => 29 + i) }

/-- **Constructive 29-of-43 Quorum Fork from 1 Compromised Operator (`sybil15_single_operator_quorum_fork`)**:
    With 15 single-operator Sybil keys in a 43-node roster, compromising **1 operator** (`0`)
    produces two valid, conflicting `29`-of-`43` quorum certificates in Epoch 1 while every
    uncompromised operator strictly obeys `HonestSingleAttestation`, and `extractEquivocators`
    recovers the exact 15 Sybil keys `List.range 15`. -/
theorem sybil15_single_operator_quorum_fork :
    sybilForkQC1.validFor gmesh43Committee 14 sybilForkSigned = true ∧
    sybilForkQC2.validFor gmesh43Committee 14 sybilForkSigned = true ∧
    sybilForkQC1.epoch = sybilForkQC2.epoch ∧
    (sybilForkQC1.digest, sybilForkQC1.verdict) ≠ (sybilForkQC2.digest, sybilForkQC2.verdict) ∧
    HonestSingleAttestation gmesh43Committee
      (inducedNodeFault sybil15Custodian singleCompromisedOp) sybilForkSigned 1 ∧
    extractEquivocators gmesh43Committee sybilForkSigned
      1 101 Verdict.accept 202 Verdict.reject = List.range 15 := by
  refine ⟨by decide, by decide, rfl, by decide, ?_, by decide⟩
  intro s _ h_not_faulty d1 v1 d2 v2 hs1 hs2
  have h_ge15 : ¬ (s < 15) := by
    intro hlt
    simp [inducedNodeFault, sybil15Custodian, singleCompromisedOp, hlt] at h_not_faulty
  by_cases h_lt29 : s < 29
  · simp [sybilForkSigned, h_ge15, h_lt29] at hs1 hs2
    exact ⟨hs1.1.trans hs2.1.symm, hs1.2.trans hs2.2.symm⟩
  · simp [sybilForkSigned, h_ge15, h_lt29] at hs1 hs2
    exact ⟨hs1.1.trans hs2.1.symm, hs1.2.trans hs2.2.symm⟩

/-! ## 6. Qualification Gate: `#upt_tooth` Mutation Kills, `#upt_census`, and Axiom Audit -/

-- Tooth 1: Mutating `quorumThreshold` from `n - f` to `f` MUST be rejected by the Lean kernel
-- in `honest_quorum_intersection_nf` (at threshold `f`, two quorums can be disjoint or wholly faulty):
#upt_tooth honest_quorum_intersection_nf
  by mutation quorumThreshold := fun _n f => f

-- Tooth 2: Mutating `QuorumCert.validFor` to omit signer deduplication (`qc.signers.Nodup`) MUST
-- be rejected by the Lean kernel in `gmesh_quorum_attestation_unique` (otherwise one Byzantine key
-- repeated `n - f` times could forge a quorum certificate):
#upt_tooth gmesh_quorum_attestation_unique
  by mutation QuorumCert.validFor := fun qc committee f signed =>
    decide (quorumThreshold committee.length f ≤ qc.signers.length) &&
    qc.signers.all (fun s => committee.contains s && signed s qc.epoch qc.digest qc.verdict)

-- Tooth 3: Mutating `extractEquivocators` to ignore the second conflicting signature MUST be
-- rejected by the Lean kernel in `gmesh_conflicting_quorums_expose_byzantine_signers` (otherwise
-- honest voters for `(d1, v1)` would be falsely slashed as Byzantine):
#upt_tooth gmesh_conflicting_quorums_expose_byzantine_signers
  by mutation extractEquivocators := fun committee signed epoch d1 v1 _d2 _v2 =>
    committee.filter (fun s => signed s epoch d1 v1)

-- Tooth 4: Mutating `validIndependentRoster` to drop the `List.Nodup (committee.map custodianOf)`
-- check MUST be rejected by the Lean kernel in `gmesh_independent_custody_bft_safety` (as witnessed
-- concretely by `correlated_operator_sybil_breaks_bft` and `sybil15_single_operator_quorum_fork`):
#upt_tooth gmesh_independent_custody_bft_safety
  by mutation validIndependentRoster := fun committee f _custodianOf =>
    decide (3 * f + 1 ≤ committee.length)

#upt_census PhysicalBridges.RepairGMeshByzantineQuorum

#print axioms quorum_overlap_nf
#print axioms honest_quorum_intersection_nf
#print axioms quorum_availability_nf
#print axioms gmesh_quorum_attestation_unique
#print axioms gmesh_conflicting_quorums_expose_byzantine_signers
#print axioms gmesh_conflicting_certs_expose_byzantine_signers
#print axioms distinctCustodians_iff_one_operator_fault_le_one
#print axioms distinct_custodians_preserve_fault_bound
#print axioms gmesh_independent_custody_bft_safety
#print axioms correlated_operator_sybil_breaks_bft
#print axioms sybil15_single_operator_quorum_fork

end PhysicalBridges.RepairGMeshByzantineQuorum
