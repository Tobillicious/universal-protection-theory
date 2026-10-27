/-
IR-13: belief-state robust viability for partial observation.
The viable object is a SET OF POSSIBLE STATES, updated after every action
and new observation. This prevents illegal state-by-state clairvoyance.
The transition and observation model, initial belief and stabilisation
remain declared inputs; this is not an installed physical certificate.
-/
namespace PhysicalBridges.IRBeliefViability
universe u v w z
variable {S : Type u} {A : Type v} {D : Type w} {O : Type z}

def Post (next : S → A → D → S) (observe : S → O)
    (B : S → Prop) (a : A) (o : O) : S → Prop :=
  fun t => observe t = o ∧
    ∃ s, B s ∧ ∃ d, next s a d = t

def SafeBelief (safe : S → Prop) (B : S → Prop) : Prop :=
  (∃ s, B s) ∧ ∀ s, B s → safe s

/-- Require one common action for the entire current belief, and successful
continuation for each physically possible next observation. -/
def Prune (next : S → A → D → S) (observe : S → O)
    (K : (S → Prop) → Prop) (B : S → Prop) : Prop :=
  K B ∧ ∃ a : A, ∀ o : O,
    (∃ t, Post next observe B a o t) →
    K (Post next observe B a o)

def Inside (K L : (S → Prop) → Prop) : Prop :=
  ∀ B, K B → L B

theorem prune_inside (next : S → A → D → S) (observe : S → O)
    (K : (S → Prop) → Prop) : Inside (Prune next observe K) K :=
  fun _ h => h.1

theorem prune_monotone (next : S → A → D → S) (observe : S → O)
    (K L : (S → Prop) → Prop) (h : Inside K L) :
    Inside (Prune next observe K) (Prune next observe L) := by
  intro B hB
  obtain ⟨hK, a, hNext⟩ := hB
  exact ⟨h B hK, a, fun o possible => h _ (hNext o possible)⟩

def Approx (next : S → A → D → S) (observe : S → O)
    (initial : (S → Prop) → Prop) : Nat → (S → Prop) → Prop
  | 0 => initial
  | n + 1 => Prune next observe (Approx next observe initial n)

theorem approx_inside_initial (next : S → A → D → S) (observe : S → O)
    (initial : (S → Prop) → Prop) :
    ∀ n, Inside (Approx next observe initial n) initial := by
  intro n
  induction n with
  | zero => exact fun _ h => h
  | succ n ih =>
    exact fun B h => ih B (prune_inside next observe _ B h)

/-- Every robustly invariant belief family survives every pruning round. -/
theorem invariant_beliefs_survive
    (next : S → A → D → S) (observe : S → O)
    (initial I : (S → Prop) → Prop)
    (hInitial : Inside I initial)
    (hInvariant : ∀ B, I B → ∃ a : A, ∀ o : O,
      (∃ t, Post next observe B a o t) →
      I (Post next observe B a o)) :
    ∀ n, Inside I (Approx next observe initial n) := by
  intro n
  induction n with
  | zero => exact hInitial
  | succ n ih =>
    intro B hI
    obtain ⟨a, hNext⟩ := hInvariant B hI
    exact ⟨ih B hI, a, fun o possible => ih _ (hNext o possible)⟩

/-- Greatest model-relative robustly invariant *family of beliefs* at a
verified fixed point. Crucially, this is NOT statewise viability. -/
theorem stable_belief_kernel_is_greatest
    (next : S → A → D → S) (observe : S → O)
    (initial : (S → Prop) → Prop) (k : Nat)
    (stable : ∀ B, Prune next observe (Approx next observe initial k) B ↔
      Approx next observe initial k B) :
    Inside (Approx next observe initial k) initial ∧
    (∀ B, Approx next observe initial k B →
      ∃ a : A, ∀ o : O,
        (∃ t, Post next observe B a o t) →
        Approx next observe initial k (Post next observe B a o)) ∧
    (∀ I : (S → Prop) → Prop, Inside I initial →
      (∀ B, I B → ∃ a : A, ∀ o : O,
        (∃ t, Post next observe B a o t) →
        I (Post next observe B a o)) →
      Inside I (Approx next observe initial k)) := by
  refine ⟨approx_inside_initial next observe initial k, ?_, ?_⟩
  · intro B hK
    exact ((stable B).mpr hK).2
  · intro I hi hinv
    exact invariant_beliefs_survive next observe initial I hi hinv k

/-- A fixed point admits a controller driven by the CURRENT BELIEF (which
encodes prior observations), rather than inaccessible true physical state. -/
theorem stable_belief_has_policy
    (next : S → A → D → S) (observe : S → O)
    (initial : (S → Prop) → Prop) (k : Nat) [Nonempty A]
    (stable : ∀ B, Prune next observe (Approx next observe initial k) B ↔
      Approx next observe initial k B) :
    ∃ policy : (S → Prop) → A, ∀ B,
      Approx next observe initial k B →
      ∀ o : O, (∃ t, Post next observe B (policy B) o t) →
        Approx next observe initial k (Post next observe B (policy B) o) := by
  classical
  have choices : ∀ B, ∃ a : A,
      Approx next observe initial k B →
      ∀ o : O, (∃ t, Post next observe B a o t) →
        Approx next observe initial k (Post next observe B a o) := by
    intro B
    by_cases hB : Approx next observe initial k B
    · obtain ⟨a, ha⟩ := ((stable B).mpr hB).2
      exact ⟨a, fun _ => ha⟩
    · exact ⟨Classical.choice inferInstance, fun hb => False.elim (hB hb)⟩
  exact ⟨fun B => Classical.choose (choices B),
    fun B => Classical.choose_spec (choices B)⟩

theorem real_next_belongs_to_updated_belief
    (next : S → A → D → S) (observe : S → O)
    (B : S → Prop) (s : S) (a : A) (d : D) (hB : B s) :
    Post next observe B a (observe (next s a d)) (next s a d) := by
  exact ⟨rfl, s, hB, d, rfl⟩

/-- A belief-policy chosen from the fixed point keeps the actual next
state safe. The observer must update its belief using the real observation. -/
theorem belief_policy_one_step_sound
    (next : S → A → D → S) (observe : S → O)
    (safe : S → Prop) (initial : (S → Prop) → Prop)
    (k : Nat) [Nonempty A]
    (hInitialSafe : ∀ B, initial B → SafeBelief safe B)
    (stable : ∀ B, Prune next observe (Approx next observe initial k) B ↔
      Approx next observe initial k B) :
    ∃ policy : (S → Prop) → A,
      ∀ B s d, Approx next observe initial k B → B s →
        let a := policy B
        let t := next s a d
        Post next observe B a (observe t) t ∧
        Approx next observe initial k
          (Post next observe B a (observe t)) ∧
        safe t := by
  obtain ⟨policy, hPolicy⟩ :=
    stable_belief_has_policy next observe initial k stable
  refine ⟨policy, ?_⟩
  intro B s d hK hMem
  dsimp
  have hNext : Post next observe B (policy B)
      (observe (next s (policy B) d)) (next s (policy B) d) :=
    real_next_belongs_to_updated_belief next observe B s (policy B) d hMem
  have hNextK := hPolicy B hK _
    ⟨next s (policy B) d, hNext⟩
  have hNextInit :=
    approx_inside_initial next observe initial k _ hNextK
  exact ⟨hNext, hNextK, (hInitialSafe _ hNextInit).2 _ hNext⟩

#print axioms prune_inside
#print axioms prune_monotone
#print axioms invariant_beliefs_survive
#print axioms stable_belief_kernel_is_greatest
#print axioms stable_belief_has_policy
#print axioms real_next_belongs_to_updated_belief
#print axioms belief_policy_one_step_sound
end PhysicalBridges.IRBeliefViability
