/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTBroadcast.lean`, sha256 `4f7aeb625eb7cb7b1625b94b96794c11b63a57674bcc7462a6d0085c25e3246e`).
Namespace `UPTBroadcast` renamed to `Snuffy.Book.UPTBroadcast` for the canon's joint audit; statements and proofs unchanged. -/

/-
One concrete security-protocol step: the four-participant OM(1) broadcast
of Lamport, Shostak and Pease (1982), Section 3, Theorem 1.

There is a dealer and three receivers. `fault` names at most one faulty
participant; `none` covers an entirely honest execution. Values and faulty
messages are arbitrary, not restricted to a finite test alphabet.

Round 1 delivers the dealer's value to each honest receiver. In round 2
each honest receiver forwards its round-1 value. `ChannelRules` states
exactly these honest-send/delivery properties. It assumes authenticated
sender identities, delivery within the designated round, and a completed
round (a missing message has already been replaced by the agreed default).
It does not assume agreement or that a faulty sender sends one value.

Each honest receiver uses its own direct value plus the other two forwarded
values, in one common sender order. `output` is the actual OM(1) decision
function, with the same fallback at all receivers. We prove validity with
an honest dealer and agreement even with a faulty dealer.

Scope: this is the n=4, t=1 instance, not the recursive OM(t) theorem for
all n, the implementation of authenticated links, or a wall-clock theorem.
No Mathlib, custom axioms, sorry, or native_decide.
-/
namespace Snuffy.Book.UPTBroadcast

inductive Receiver where
  | a | b | c
  deriving DecidableEq

inductive Participant where
  | dealer
  | receiver (id : Receiver)
  deriving DecidableEq

def loyal (fault : Option Participant) (p : Participant) : Prop :=
  fault ≠ some p

def majority {α : Type} [DecidableEq α] (fallback x y z : α) : α :=
  if x = y ∨ x = z then x else if y = z then y else fallback

theorem majority_left {α : Type} [DecidableEq α] (fallback x z : α) :
    majority fallback x x z = x := by simp [majority]

theorem majority_outer {α : Type} [DecidableEq α] (fallback x y : α) :
    majority fallback x y x = x := by simp [majority]

theorem majority_right {α : Type} [DecidableEq α] (fallback x y : α) :
    majority fallback x y y = y := by
  by_cases h : x = y
  · subst x; simp [majority]
  · simp [majority, h]

def entry {α : Type} (direct : Receiver → α)
    (forward : Receiver → Receiver → α) (recipient sender : Receiver) : α :=
  if recipient = sender then direct sender else forward sender recipient

def output {α : Type} [DecidableEq α] (fallback : α)
    (direct : Receiver → α) (forward : Receiver → Receiver → α)
    (recipient : Receiver) : α :=
  majority fallback (entry direct forward recipient .a)
    (entry direct forward recipient .b) (entry direct forward recipient .c)

def ChannelRules {α : Type} (fault : Option Participant) (sent : α)
    (direct : Receiver → α) (forward : Receiver → Receiver → α) : Prop :=
  (loyal fault .dealer → ∀ i, loyal fault (.receiver i) → direct i = sent) ∧
  (∀ i j, loyal fault (.receiver i) → loyal fault (.receiver j) →
    forward i j = direct i)

theorem entry_from_loyal {α : Type} (fault : Option Participant) (sent : α)
    (direct : Receiver → α) (forward : Receiver → Receiver → α)
    (recipient sender : Receiver) (rules : ChannelRules fault sent direct forward)
    (hr : loyal fault (.receiver recipient)) (hs : loyal fault (.receiver sender)) :
    entry direct forward recipient sender = direct sender := by
  unfold entry
  split
  · rfl
  · exact rules.2 sender recipient hs hr

/-- IC2: every honest receiver decides the honest dealer's value. -/
theorem honest_dealer_validity {α : Type} [DecidableEq α]
    (fault : Option Participant) (sent fallback : α)
    (direct : Receiver → α) (forward : Receiver → Receiver → α)
    (recipient : Receiver) (rules : ChannelRules fault sent direct forward)
    (hd : loyal fault .dealer) (hr : loyal fault (.receiver recipient)) :
    output fallback direct forward recipient = sent := by
  have he (sender : Receiver) (hs : loyal fault (.receiver sender)) :
      entry direct forward recipient sender = sent :=
    (entry_from_loyal fault sent direct forward recipient sender rules hr hs).trans
      (rules.1 hd sender hs)
  cases fault with
  | none =>
    unfold output
    rw [he .a (by simp [loyal]), he .b (by simp [loyal]), he .c (by simp [loyal])]
    exact majority_left fallback sent sent
  | some p =>
    cases p with
    | dealer => exact False.elim (hd rfl)
    | receiver bad =>
      cases bad with
      | a =>
        unfold output
        rw [he .b (by simp [loyal]), he .c (by simp [loyal])]
        exact majority_right fallback _ sent
      | b =>
        unfold output
        rw [he .a (by simp [loyal]), he .c (by simp [loyal])]
        exact majority_outer fallback sent _
      | c =>
        unfold output
        rw [he .a (by simp [loyal]), he .b (by simp [loyal])]
        exact majority_left fallback sent _

/-- With a faulty dealer, the other three participants are honest and
therefore all honest receivers have exactly the same ordered decision vector. -/
theorem faulty_dealer_vector {α : Type} (sent : α)
    (direct : Receiver → α) (forward : Receiver → Receiver → α)
    (rules : ChannelRules (some .dealer) sent direct forward)
    (recipient sender : Receiver) :
    entry direct forward recipient sender = direct sender := by
  apply entry_from_loyal (some .dealer) sent direct forward recipient sender rules
  · simp [loyal]
  · simp [loyal]

/-- IC1: all honest receivers decide one value, with at most one faulty participant. -/
theorem agreement {α : Type} [DecidableEq α]
    (fault : Option Participant) (sent fallback : α)
    (direct : Receiver → α) (forward : Receiver → Receiver → α)
    (i j : Receiver) (rules : ChannelRules fault sent direct forward)
    (hi : loyal fault (.receiver i)) (hj : loyal fault (.receiver j)) :
    output fallback direct forward i = output fallback direct forward j := by
  by_cases hd : fault = some .dealer
  · subst fault
    unfold output
    rw [faulty_dealer_vector sent direct forward rules i .a,
      faulty_dealer_vector sent direct forward rules i .b,
      faulty_dealer_vector sent direct forward rules i .c,
      faulty_dealer_vector sent direct forward rules j .a,
      faulty_dealer_vector sent direct forward rules j .b,
      faulty_dealer_vector sent direct forward rules j .c]
  · exact (honest_dealer_validity fault sent fallback direct forward i rules hd hi).trans
      (honest_dealer_validity fault sent fallback direct forward j rules hd hj).symm

/-- The four-participant, one-fault OM(1) broadcast has both interactive
consistency properties, under precisely the stated honest-channel rules. -/
theorem om1_broadcast {α : Type} [DecidableEq α]
    (fault : Option Participant) (sent fallback : α)
    (direct : Receiver → α) (forward : Receiver → Receiver → α)
    (rules : ChannelRules fault sent direct forward) :
    (∀ i j, loyal fault (.receiver i) → loyal fault (.receiver j) →
      output fallback direct forward i = output fallback direct forward j) ∧
    (loyal fault .dealer → ∀ i, loyal fault (.receiver i) →
      output fallback direct forward i = sent) := by
  constructor
  · intro i j hi hj
    exact agreement fault sent fallback direct forward i j rules hi hj
  · intro hd i hi
    exact honest_dealer_validity fault sent fallback direct forward i rules hd hi

end Snuffy.Book.UPTBroadcast
