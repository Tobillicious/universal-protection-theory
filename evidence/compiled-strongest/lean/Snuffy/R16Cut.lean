import Snuffy.ClosedCohold
import Snuffy.R16Feedback

/-! R16-CUT: a declared dependency graph yields a sufficient causal cut only
when the actual transition is local with respect to that graph. D output input
means the next output may read the current input. Delays must have state nodes.
No theorem here infers a graph's physical completeness from its classification.
-/
namespace UPTR16Cut
open CodexCohold
open UPTR16

def AgreeOn {N V : Type} (C : N → Prop) (s t : N → V) : Prop :=
  ∀ n, C n → s n = t n

def LocalTo {N V E : Type} (D : N → N → Prop)
    (T : (N → V) → E → (N → V)) : Prop :=
  ∀ n s t e, (∀ m, D n m → s m = t m) → T s e n = T t e n

theorem closed_cut_step {N V E : Type} (D : N → N → Prop) (C : N → Prop)
    (T : (N → V) → E → (N → V)) (closed : Closed D C)
    (locality : LocalTo D T) (s t : N → V) (same : AgreeOn C s t) (e : E) :
    AgreeOn C (T s e) (T t e) := by
  intro n hn
  apply locality n s t e
  intro m hnm
  exact same m (closed n hn m hnm)

theorem dependency_closure_step {N V E : Type}
    (D : N → N → Prop) (seed : N → Prop)
    (T : (N → V) → E → (N → V)) (locality : LocalTo D T)
    (s t : N → V) (same : AgreeOn (Reach D seed) s t) (e : E) :
    AgreeOn (Reach D seed) (T s e) (T t e) :=
  closed_cut_step D (Reach D seed) T (reachable_closed D seed) locality s t same e

/-- Paths in the time-unrolled graph that avoid the certified boundary. The
relation reads Pred node predecessor; a finite node index is topological order. -/
def Bypass (Pred : Nat → Nat → Prop) (sources boundary : Nat → Prop) : Nat → Prop :=
  Reach (fun predecessor node => Pred node predecessor ∧ ¬ boundary node)
    (fun node => sources node ∧ ¬ boundary node)

theorem difference_has_bypass {V : Type} (Pred : Nat → Nat → Prop)
    (sources boundary : Nat → Prop) (left right : Nat → V)
    (earlier : ∀ node predecessor, Pred node predecessor → predecessor < node)
    (matchedBoundary : ∀ node, boundary node → left node = right node)
    (determined : ∀ node, ¬ sources node →
      (∀ predecessor, Pred node predecessor → left predecessor = right predecessor) →
      left node = right node) :
    ∀ node, left node ≠ right node → Bypass Pred sources boundary node := by
  classical
  intro node
  induction node using Nat.strongRecOn with
  | ind node ih =>
      intro different
      have notBoundary : ¬ boundary node := fun hb => different (matchedBoundary node hb)
      by_cases source : sources node
      · exact Reach.initial node ⟨source, notBoundary⟩
      · have parent : ∃ predecessor,
            Pred node predecessor ∧ left predecessor ≠ right predecessor := by
          apply Classical.byContradiction
          intro none
          apply different
          apply determined node source
          intro predecessor hp
          apply Classical.byContradiction
          intro hd
          exact none ⟨predecessor, hp, hd⟩
        obtain ⟨predecessor, hp, hd⟩ := parent
        exact Reach.edge predecessor node
          (ih predecessor (earlier node predecessor hp) hd) ⟨hp, notBoundary⟩

/-- A genuine separator, rather than requiring all connected components to be
held together. Reactive decisions and pending effects may be ordinary graph nodes.
All unmatched exogenous inputs must be included among sources. -/
theorem causal_separator {V : Type} (Pred : Nat → Nat → Prop)
    (sources boundary outside : Nat → Prop) (left right : Nat → V)
    (earlier : ∀ node predecessor, Pred node predecessor → predecessor < node)
    (matchedBoundary : ∀ node, boundary node → left node = right node)
    (determined : ∀ node, ¬ sources node →
      (∀ predecessor, Pred node predecessor → left predecessor = right predecessor) →
      left node = right node)
    (separator : ∀ node, outside node → ¬ Bypass Pred sources boundary node) :
    ∀ node, outside node → left node = right node := by
  classical
  intro node ho
  apply Classical.byContradiction
  intro hd
  exact separator node ho
    (difference_has_bypass Pred sources boundary left right earlier matchedBoundary determined node hd)

def cutTick {N V E O : Type} (T : (N → V) → E → (N → V))
    (obs : (N → V) → O) (environment : List O → E)
    (z : (N → V) × List O) : (N → V) × List O :=
  let next := T z.1 (environment z.2)
  (next, z.2 ++ [obs next])

theorem closed_cut_reactive {N V E O : Type}
    (D : N → N → Prop) (C : N → Prop)
    (T : (N → V) → E → (N → V)) (closed : Closed D C)
    (locality : LocalTo D T) (obs : (N → V) → O)
    (observational : ∀ s t, AgreeOn C s t → obs s = obs t)
    (environment : List O → E) (n : Nat) (s t : N → V)
    (same : AgreeOn C s t) (history : List O) :
    AgreeOn C (iterate (cutTick T obs environment) n (s, history)).1
      (iterate (cutTick T obs environment) n (t, history)).1 ∧
    (iterate (cutTick T obs environment) n (s, history)).2 =
      (iterate (cutTick T obs environment) n (t, history)).2 := by
  induction n with
  | zero => exact ⟨same, rfl⟩
  | succ n ih =>
      obtain ⟨hstate, hhistory⟩ := ih
      simp only [iterate, cutTick]
      rw [hhistory]
      have hnext := closed_cut_step D C T closed locality _ _ hstate
        (environment (iterate (cutTick T obs environment) n (t, history)).2)
      refine ⟨hnext, ?_⟩
      rw [observational _ _ hnext]

inductive Node where
  | privateBit | pending | outside
  deriving DecidableEq

def dependency : Node → Node → Prop
  | .privateBit, .privateBit => True
  | .pending, .privateBit => True
  | .outside, .pending => True
  | _, _ => False

def delayedStep (s : Node → Nat) (_ : Unit) : Node → Nat
  | .privateBit => s .privateBit
  | .pending => s .privateBit
  | .outside => s .pending

theorem delayed_locality : LocalTo dependency delayedStep := by
  intro n s t e h
  cases n with
  | privateBit => exact h .privateBit trivial
  | pending => exact h .privateBit trivial
  | outside => exact h .pending trivial

def outsideSeed (n : Node) : Prop := n = .outside

theorem pending_is_in_cut : Reach dependency outsideSeed .pending :=
  Reach.edge Node.outside Node.pending (Reach.initial Node.outside rfl) trivial

theorem private_cause_is_in_cut : Reach dependency outsideSeed .privateBit :=
  Reach.edge Node.pending Node.privateBit pending_is_in_cut trivial

def starts (bit : Nat) : Node → Nat
  | .privateBit => bit
  | _ => 0

theorem delayed_effect_countermodel :
    starts 0 .outside = starts 1 .outside ∧
    delayedStep (starts 0) () .outside = delayedStep (starts 1) () .outside ∧
    delayedStep (delayedStep (starts 0) ()) () .outside ≠
      delayedStep (delayedStep (starts 1) ()) () .outside := by decide

theorem omitted_edge_is_not_local :
    ¬ LocalTo (fun n m => n = m) delayedStep := by
  intro h
  have bad := h .pending (starts 0) (starts 1) () (by
    intro m hm
    rw [← hm]
    rfl)
  change 0 = 1 at bad
  exact Nat.noConfusion bad

end UPTR16Cut

