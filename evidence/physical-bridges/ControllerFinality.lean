/- Core Lean 4.35; no Mathlib. The cryptographic and PBFT premises are arguments,
not axioms. Scope is the exact immutable enrolment vector (domain, resource,
lease, recipient, policy, coverage and bounds); see CONTROLLER-FINALITY.md.
The wire codec, signatures and replica implementation are outside this kernel model. -/
namespace UPTController

def tally {α : Type} (p : α → Bool) : List α → Nat
  | [] => 0
  | x :: xs => (if p x then 1 else 0) + tally p xs

theorem tally_mono {α : Type} (p q : α → Bool) (xs : List α)
    (h : ∀ x, x ∈ xs → p x = true → q x = true) : tally p xs ≤ tally q xs := by
  induction xs with
  | nil => simp [tally]
  | cons x xs ih =>
    have ht := ih (fun y hy => h y (List.mem_cons_of_mem x hy))
    have hx := h x List.mem_cons_self
    cases hp : p x <;> cases hq : q x <;> simp_all [tally] <;> omega

theorem quorum_has_honest {α : Type} (xs : List α) (fault vote : α → Bool) (f : Nat)
    (hf : tally fault xs ≤ f) (hq : f < tally vote xs) :
    ∃ x, x ∈ xs ∧ vote x = true ∧ fault x = false := by
  classical
  apply Classical.byContradiction
  intro hn
  have hle : tally vote xs ≤ tally fault xs := tally_mono vote fault xs (by
    intro x hx hv
    cases hb : fault x
    · exact False.elim (hn ⟨x, hx, hv, hb⟩)
    · rfl)
  omega

theorem two_tallies_bound {α : Type} (xs : List α) (fault a b : α → Bool)
    (h : ∀ x, x ∈ xs → a x = true → b x = true → fault x = true) :
    tally a xs + tally b xs ≤ xs.length + tally fault xs := by
  induction xs with
  | nil => simp [tally]
  | cons x xs ih =>
    have ht := ih (fun y hy => h y (List.mem_cons_of_mem x hy))
    have hx := h x List.mem_cons_self
    cases ha : a x <;> cases hb : b x <;> cases hf : fault x <;>
      simp_all [tally] <;> omega

/-- The general intersection condition is 2q > n+f, not just n >= 3f+1. -/
theorem quorum_intersection {α : Type} (xs : List α) (fault a b : α → Bool) (f q : Nat)
    (hf : tally fault xs ≤ f) (ha : q ≤ tally a xs) (hb : q ≤ tally b xs)
    (size : xs.length + f < 2 * q) :
    ∃ x, x ∈ xs ∧ a x = true ∧ b x = true ∧ fault x = false := by
  classical
  apply Classical.byContradiction
  intro hn
  have bound := two_tallies_bound xs fault a b (by
    intro x hx hax hbx
    cases hfx : fault x
    · exact False.elim (hn ⟨x, hx, hax, hbx, hfx⟩)
    · rfl)
  omega

theorem committee_threshold (f : Nat) : (3 * f + 1) + f < 2 * (2 * f + 1) := by omega

def Prefix {α : Type} (a b : List α) : Prop := ∃ tail, b = a ++ tail

theorem prefix_trans {α : Type} {a b c : List α} (h : Prefix a b) (k : Prefix b c) :
    Prefix a c := by
  obtain ⟨u, rfl⟩ := h
  obtain ⟨v, rfl⟩ := k
  exact ⟨u ++ v, by simp [List.append_assoc]⟩

theorem equal_length_prefixes {α : Type} (a b final : List α)
    (ha : Prefix a final) (hb : Prefix b final) (hlen : a.length = b.length) : a = b := by
  have ea : final.take a.length = a := by
    obtain ⟨tail, rfl⟩ := ha
    simp
  have eb : final.take b.length = b := by
    obtain ⟨tail, rfl⟩ := hb
    simp
  rw [hlen] at ea
  exact ea.symm.trans eb

theorem certificates_do_not_equivocate {α : Type} (roster : List Nat)
    (fault a b : Nat → Bool) (f : Nat) (u v : List α) (durable : Nat → List α)
    (hf : tally fault roster ≤ f) (size : roster.length = 3 * f + 1)
    (qa : 2 * f + 1 ≤ tally a roster) (qb : 2 * f + 1 ≤ tally b roster)
    (authA : ∀ r, r ∈ roster → fault r = false → a r = true → Prefix u (durable r))
    (authB : ∀ r, r ∈ roster → fault r = false → b r = true → Prefix v (durable r))
    (samePosition : u.length = v.length) : u = v := by
  have hs : roster.length + f < 2 * (2 * f + 1) := by rw [size]; omega
  obtain ⟨r, hr, ha, hb, hh⟩ := quorum_intersection roster fault a b f (2*f+1) hf qa qb hs
  exact equal_length_prefixes u v (durable r) (authA r hr hh ha) (authB r hr hh hb) samePosition

/-- Verified distinct signer slots, unforgeability/binding plus the concrete emit rule,
and the cited common-prefix property imply actual inclusion. Votes are counted once
per enrolled roster element; the wire verifier enforces the unique roster. -/
theorem certificate_is_final {α : Type} (roster : List Nat) (fault vote : Nat → Bool)
    (f : Nat) (history final : List α) (durable : Nat → List α)
    (fault_bound : tally fault roster ≤ f) (threshold : 2 * f + 1 ≤ tally vote roster)
    (authenticated_emit : ∀ r, r ∈ roster → fault r = false → vote r = true →
      Prefix history (durable r))
    (ordered_durable : ∀ r, r ∈ roster → fault r = false → Prefix (durable r) final) :
    Prefix history final := by
  have hq : f < tally vote roster := by omega
  obtain ⟨r, hr, hv, hh⟩ := quorum_has_honest roster fault vote f fault_bound hq
  exact prefix_trans (authenticated_emit r hr hh hv) (ordered_durable r hr hh)

/-- The canonical field vector is injective; bytes use its specified bounded inverse. -/
structure Context where
  scope : List Nat
  generation : Nat
  boot : Nat
  sequence : Nat
  nonce : Nat
  deriving DecidableEq, Repr

def contextWords (c : Context) : List Nat :=
  [1, c.generation, c.boot, c.sequence, c.nonce] ++ c.scope

theorem context_words_injective (a b : Context) (h : contextWords a = contextWords b) :
    a = b := by
  cases a; cases b
  simp only [contextWords, List.cons_append, List.nil_append, List.cons.injEq] at h
  rcases h with ⟨_, hg, hb, hs, hn, hc⟩
  simp_all

structure State where
  generation : Nat
  held : Bool
  boot : Nat
  closed : Nat
  pending : Option Context
  deriving DecidableEq, Repr

inductive Op
  | authorize (c : Context)
  | retire (c : Context)
  | release (c : Context)
  | openBoot (b : Nat)
  | close (q : Nat)
  deriving DecidableEq, Repr

inductive Reply
  | rejected
  | grant (c : Context)
  | floor (c : Context) (newFloor : Nat)
  | released
  | booted
  | closed
  deriving DecidableEq, Repr

/-- enrol g is immutable for this resource/lease/generation. ACL dispatch precedes
these method bodies. Retire retains the pending result; it never frees capacity. -/
def step (enrol : Nat → List Nat) (s : State) : Op → State × Reply
  | .authorize c =>
    if c.scope = enrol c.generation ∧ c.generation = s.generation ∧
        s.held = false ∧ c.boot = s.boot then
      match s.pending with
      | some old => if old = c then (s, .grant old) else (s, .rejected)
      | none => if c.sequence = s.closed + 1 then
          ({s with pending := some c}, .grant c) else (s, .rejected)
    else (s, .rejected)
  | .retire c =>
    if c.scope = enrol c.generation ∧ c.generation = s.generation then
      ({s with generation := s.generation + 1, held := true}, .floor c (s.generation + 1))
    else (s, .rejected)
  | .release c =>
    if c.scope = enrol c.generation ∧ c.generation = s.generation ∧
        s.held = true ∧ s.boot < c.boot then
      ({s with held := false, boot := c.boot, closed := 0, pending := none}, .released)
    else (s, .rejected)
  | .openBoot b => if s.boot < b then
      ({s with boot := b, closed := 0, pending := none}, .booted) else (s, .rejected)
  | .close q => match s.pending with
      | some c => if q = c.sequence then
          ({s with closed := max s.closed q, pending := none}, .closed) else (s, .rejected)
      | none => if q ≤ s.closed then (s, .closed) else (s, .rejected)

def run (enrol : Nat → List Nat) (s : State) : List Op → State
  | [] => s
  | op :: rest => run enrol (step enrol s op).1 rest

theorem run_append (enrol : Nat → List Nat) (s : State) (a b : List Op) :
    run enrol s (a ++ b) = run enrol (run enrol s a) b := by
  induction a generalizing s with
  | nil => rfl
  | cons x xs ih => simp only [List.cons_append, run]; exact ih _

theorem step_floor_mono (enrol : Nat → List Nat) (s : State) (op : Op) :
    s.generation ≤ (step enrol s op).1.generation := by
  cases op with
  | authorize c =>
    simp only [step]
    split
    · cases s.pending <;> simp only <;> split <;> simp
    · simp
  | retire c => simp only [step]; split <;> simp <;> omega
  | release c => simp only [step]; split <;> simp
  | openBoot b => simp only [step]; split <;> simp
  | close q => simp only [step]; cases s.pending <;> simp only <;> split <;> simp

theorem run_floor_mono (enrol : Nat → List Nat) (s : State) (ops : List Op) :
    s.generation ≤ (run enrol s ops).generation := by
  induction ops generalizing s with
  | nil => exact Nat.le_refl _
  | cons o os ih => exact Nat.le_trans (step_floor_mono enrol s o) (ih _)

theorem grant_fields (enrol : Nat → List Nat) (s : State) (c : Context)
    (h : (step enrol s (.authorize c)).2 = .grant c) :
    c.scope = enrol c.generation ∧ c.generation = s.generation ∧
      s.held = false ∧ c.boot = s.boot := by
  by_cases guard : c.scope = enrol c.generation ∧ c.generation = s.generation ∧
      s.held = false ∧ c.boot = s.boot
  · exact guard
  · simp [step, guard] at h

theorem floor_fields (enrol : Nat → List Nat) (s : State) (c : Context) (g : Nat)
    (h : (step enrol s (.retire c)).2 = .floor c g) :
    c.scope = enrol c.generation ∧ c.generation = s.generation ∧
      g = c.generation + 1 ∧ (step enrol s (.retire c)).1.held = true := by
  by_cases guard : c.scope = enrol c.generation ∧ c.generation = s.generation
  · have he : (step enrol s (.retire c)).2 = .floor c (s.generation + 1) := by
      simp [step, guard]
    rw [he] at h
    have hg : s.generation + 1 = g := (Reply.floor.inj h).2
    exact ⟨guard.1, guard.2, by omega, by simp [step, guard]⟩
  · simp [step, guard] at h

theorem held_refuses (enrol : Nat → List Nat) (s : State) (c : Context)
    (h : s.held = true) : (step enrol s (.authorize c)).2 = .rejected := by
  simp [step, h]

theorem retired_generation_refuses (enrol : Nat → List Nat) (s : State) (c : Context)
    (retired : c.generation < s.generation) :
    (step enrol s (.authorize c)).2 ≠ .grant c := by
  intro h
  have hg := (grant_fields enrol s c h).2.1
  omega

theorem pending_conflict_refuses (enrol : Nat → List Nat) (s : State) (old c : Context)
    (pending : s.pending = some old) (different : old ≠ c) :
    (step enrol s (.authorize c)).2 = .rejected := by
  simp only [step]
  split <;> simp [pending, different]

theorem closed_sequence_refuses (enrol : Nat → List Nat) (s : State) (c : Context)
    (empty : s.pending = none) (closed : c.sequence ≤ s.closed) :
    (step enrol s (.authorize c)).2 = .rejected := by
  simp only [step]
  split
  · simp only [empty]
    split
    · omega
    · rfl
  · rfl

/-- Successful receipts contain the exact operation, complete replay input and result.
The executable recipient replays this suffix, rather than accepting an asserted success bit. -/
structure Receipt where
  past : List Op
  context : Context
  isFloor : Bool
  deriving DecidableEq, Repr

def namedOp (r : Receipt) : Op := if r.isFloor then .retire r.context else .authorize r.context
def expectedReply (r : Receipt) : Reply :=
  if r.isFloor then .floor r.context (r.context.generation + 1) else .grant r.context
def history (r : Receipt) : List Op := r.past ++ [namedOp r]
def replayOK (enrol : Nat → List Nat) (start : State) (r : Receipt) : Prop :=
  (step enrol (run enrol start r.past) (namedOp r)).2 = expectedReply r

theorem receipt_names_success (enrol : Nat → List Nat) (start : State) (r : Receipt)
    (final : List Op) (hc : Prefix (history r) final) (hr : replayOK enrol start r) :
    ∃ suffix, final = (r.past ++ [namedOp r]) ++ suffix ∧
      (step enrol (run enrol start r.past) (namedOp r)).2 = expectedReply r := by
  obtain ⟨suffix, hs⟩ := hc
  exact ⟨suffix, hs, hr⟩

theorem certified_receipt_names_success (enrol : Nat → List Nat) (start : State)
    (r : Receipt) (roster : List Nat) (fault vote : Nat → Bool) (f : Nat)
    (final : List Op) (durable : Nat → List Op)
    (hf : tally fault roster ≤ f) (hq : 2 * f + 1 ≤ tally vote roster)
    (auth : ∀ x, x ∈ roster → fault x = false → vote x = true →
      Prefix (history r) (durable x))
    (order : ∀ x, x ∈ roster → fault x = false → Prefix (durable x) final)
    (hr : replayOK enrol start r) :
    ∃ suffix, final = (r.past ++ [namedOp r]) ++ suffix ∧
      (step enrol (run enrol start r.past) (namedOp r)).2 = expectedReply r := by
  exact receipt_names_success enrol start r final
    (certificate_is_final roster fault vote f (history r) final durable hf hq auth order) hr

/-- Conflict means incompatible immutable enrolment fields, not two valid challenges. -/
theorem same_generation_no_context_conflict (enrol : Nat → List Nat)
    (s t : State) (a b : Context)
    (ha : (step enrol s (.authorize a)).2 = .grant a)
    (hb : (step enrol t (.authorize b)).2 = .grant b)
    (hg : a.generation = b.generation) : a.scope = b.scope := by
  have aa := (grant_fields enrol s a ha).1
  have bb := (grant_fields enrol t b hb).1
  rw [aa, hg, bb]

theorem checkpoint_replay (enrol : Nat → List Nat) (start : State) (initial suffix : List Op) :
    run enrol (run enrol start initial) suffix = run enrol start (initial ++ suffix) :=
  (run_append enrol start initial suffix).symm

structure Local where
  floor : Nat
  boot : Nat
  ready : Bool
  consumed : Bool
  pending : Option Context
  deriving DecidableEq, Repr

def allows (s : Local) (c : Context) (age limit : Nat) : Prop :=
  s.ready = true ∧ s.consumed = false ∧ s.floor ≤ c.generation ∧
  c.boot = s.boot ∧ s.pending = some c ∧ age < limit

def consume (s : Local) : Local := {s with consumed := true, pending := none}
def restart (s : Local) (checkpointFloor : Nat) : Local :=
  {s with floor := max s.floor checkpointFloor, boot := s.boot + 1, ready := false, consumed := true, pending := none}

theorem consume_once (s : Local) (c : Context) (age limit : Nat) :
    ¬ allows (consume s) c age limit := by simp [allows, consume]

theorem restart_disabled (s : Local) (g : Nat) (c : Context) (age limit : Nat) :
    ¬ allows (restart s g) c age limit := by simp [allows, restart]

theorem retained_floor_refuses (s : Local) (checkpointFloor : Nat) (c : Context)
    (age limit : Nat) (retired : c.generation < checkpointFloor)
    (recovered : Local) (monotone : (restart s checkpointFloor).floor ≤ recovered.floor) :
    ¬ allows recovered c age limit := by
  intro h
  have hh := h.2.2.1
  have hf : checkpointFloor ≤ recovered.floor :=
    Nat.le_trans (Nat.le_max_right _ _) monotone
  omega

theorem old_boot_refuses (s : Local) (c : Context) (age limit : Nat)
    (old : c.boot ≤ s.boot) (recovered : Local)
    (newBoot : (restart s 0).boot ≤ recovered.boot) : ¬ allows recovered c age limit := by
  intro h
  have hb := h.2.2.2.1
  have hn : s.boot + 1 ≤ recovered.boot := newBoot
  omega

theorem deadline_refuses (s : Local) (c : Context) (age limit : Nat)
    (expired : limit ≤ age) : ¬ allows s c age limit := by
  intro h
  have fresh := h.2.2.2.2.2
  omega

def emits (enrol : Nat → List Nat) (s : State) : Op → List Nat
  | .authorize c => if (step enrol s (.authorize c)).2 = .grant c then [c.generation] else []
  | _ => []

def issued (enrol : Nat → List Nat) (s : State) : List Op → List Nat
  | [] => []
  | o :: os => emits enrol s o ++ issued enrol (step enrol s o).1 os

theorem issued_append (enrol : Nat → List Nat) (s : State) (a b : List Op) :
    issued enrol s (a ++ b) = issued enrol s a ++ issued enrol (run enrol s a) b := by
  induction a generalizing s with
  | nil => rfl
  | cons o os ih => simp only [List.cons_append, issued, run, ih, List.append_assoc]

theorem emission_bounded (enrol : Nat → List Nat) (s : State) (o : Op) (g : Nat)
    (h : g ∈ emits enrol s o) : g ≤ s.generation := by
  cases o with
  | authorize c =>
    by_cases hs : (step enrol s (.authorize c)).2 = .grant c
    · simp [emits, hs] at h
      subst g
      exact Nat.le_of_eq (grant_fields enrol s c hs).2.1
    · simp [emits, hs] at h
  | retire c => simp [emits] at h
  | release c => simp [emits] at h
  | openBoot b => simp [emits] at h
  | close q => simp [emits] at h

theorem issues_bounded_by_final_floor (enrol : Nat → List Nat) (s : State) (ops : List Op)
    (g : Nat) (h : g ∈ issued enrol s ops) : g ≤ (run enrol s ops).generation := by
  induction ops generalizing s with
  | nil => simp [issued] at h
  | cons o os ih =>
    simp only [issued, List.mem_append] at h
    cases h with
    | inl he => exact Nat.le_trans (emission_bounded enrol s o g he) (Nat.le_trans (step_floor_mono enrol s o) (run_floor_mono enrol (step enrol s o).1 os))
    | inr ht => exact ih _ ht

theorem step_stays_held (enrol : Nat → List Nat) (s : State) (o : Op)
    (held : s.held = true) (noRelease : ∀ c, o ≠ .release c) :
    (step enrol s o).1.held = true := by
  cases o with
  | authorize c => simp [step, held]
  | retire c => simp only [step]; split <;> simp_all
  | release c => exact False.elim (noRelease c rfl)
  | openBoot b => simp only [step]; split <;> simp_all
  | close q => simp only [step]; cases s.pending <;> simp only <;> split <;> simp_all

theorem held_issues_nothing (enrol : Nat → List Nat) (s : State) (ops : List Op)
    (held : s.held = true) (noRelease : ∀ c, Op.release c ∉ ops) : issued enrol s ops = [] := by
  induction ops generalizing s with
  | nil => rfl
  | cons o os ih =>
    have hn : ∀ c, o ≠ Op.release c := by
      intro c he
      exact noRelease c (by simp [← he])
    have ht : ∀ c, Op.release c ∉ os := fun c hm => noRelease c (List.mem_cons_of_mem o hm)
    have hh := step_stays_held enrol s o held hn
    have he : emits enrol s o = [] := by
      cases o with
      | authorize c => simp [emits, held_refuses enrol s c held]
      | retire c => rfl
      | release c => exact False.elim (hn c rfl)
      | openBoot b => rfl
      | close q => rfl
    simp only [issued, he, List.nil_append]
    exact ih _ hh ht

theorem grant_receipt_is_issued (enrol : Nat → List Nat) (start : State) (r : Receipt)
    (final : List Op) (grant : r.isFloor = false) (hc : Prefix (history r) final)
    (hr : replayOK enrol start r) : r.context.generation ∈ issued enrol start final := by
  obtain ⟨tail, rfl⟩ := hc
  have hs : (step enrol (run enrol start r.past) (.authorize r.context)).2 = .grant r.context := by
    simpa [replayOK, namedOp, expectedReply, grant] using hr
  simp [history, issued_append, namedOp, grant, issued, emits, hs]

/-- All successful grants in a trace ending in a hold are old-generation grants,
including receipts obtained later for earlier operations. No delivery bound is used. -/
theorem hold_bounds_every_issued_grant (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (retired : (step enrol (run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (noRelease : ∀ d, Op.release d ∉ during) (g : Nat)
    (hg : g ∈ issued enrol start (before ++ .retire c :: during)) : g ≤ c.generation := by
  have fields := floor_fields enrol (run enrol start before) c (c.generation + 1) retired
  have empty := held_issues_nothing enrol
    (step enrol (run enrol start before) (.retire c)).1 during fields.2.2.2 noRelease
  simp only [issued_append, issued, emits, empty, List.append_nil] at hg
  have hb := issues_bounded_by_final_floor enrol start before g hg
  omega

end UPTController

/- Axiom probes are appended by the staging script and are part of the module output. -/
