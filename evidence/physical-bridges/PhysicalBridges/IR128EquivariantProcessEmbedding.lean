import PhysicalBridges.IR96DisturbanceSimulation

/-!
IR-128 — An actual categorical-style generator preservation theorem.

Unlike a Boolean "generator hook", a process embedding must be
injective on old relational states, preserve causal edges and live
nodes, and COMMUTE with the two process generators.

The commuting square proves that every finite old orbit is carried
to the corresponding new generator orbit. With source closure it
also proves the mapped old orbit remains live in the new graph.
Such embeddings compose. This is a mathematically meaningful
prevention of erasing *represented* old process trajectories.

Counterexamples: a commuting map can collapse distinct states
without injectivity; a total generator can stall forever.
This remains a structural theorem, NOT a proof of real subjective
continuity, consent, physically exhaustive graph dynamics,
actual execution/progress, or maximal X3.
-/
namespace PhysicalBridges.IR128

universe u v w
variable {X : Type u} {Y : Type v} {Z : Type w}

/-- The supplied generator f : V -> V models iterations WITHIN an
existing node set. Genuine fresh-node creation would additionally
require an extension graph (or a coalgebra over graph states). -/
def iterate (f : X → X) : Nat → X → X
  | 0, x => x
  | n + 1, x => f (iterate f n x)

/-- A graph process with a causal parent relation and local generator.
Rooted ancestry, acyclicity and physical meaning are independent. -/
structure Process (X : Type u) where
  live : X → Prop
  parent : X → X → Prop
  generator : X → X

/-- A *monomorphic, equivariant graph-process homomorphism*.
Crucially, an arbitrary "hook present" bit supplies NONE of these
properties, which must be demonstrated by each real rewrite. -/
structure Embedding
    (s : Process X) (t : Process Y) where
  map : X → Y
  injective : Function.Injective map
  retainsLive : ∀ x, s.live x → t.live (map x)
  retainsParent : ∀ a b,
    s.parent a b → t.parent (map a) (map b)
  commutes : ∀ x,
    map (s.generator x) = t.generator (map x)

/-- Generator equivariance extends from ONE iteration to EVERY
finite iterated future state: a genuine induction rather than
assuming preservation of an entire continuation set. -/
theorem maps_every_finite_generator_iterate
    (s : Process X) (t : Process Y)
    (e : Embedding s t) (n : Nat) (x : X) :
    e.map (iterate s.generator n x) =
      iterate t.generator n (e.map x) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change e.map (s.generator (iterate s.generator n x)) =
        t.generator (iterate t.generator n (e.map x))
      rw [e.commutes]
      rw [ih]

/-- If the original generator always stays among living source
nodes, the image of EVERY one of its finite future states remains
a living node in the successor graph. -/
theorem old_living_orbits_remain_represented
    (s : Process X) (t : Process Y)
    (e : Embedding s t)
    (hSourceClosed : ∀ x, s.live x →
      s.live (s.generator x))
    (x : X) (hLive : s.live x) (n : Nat) :
    t.live (iterate t.generator n (e.map x)) := by
  have hOldOrbit :
      ∀ k, s.live (iterate s.generator k x) := by
    intro k
    induction k with
    | zero => exact hLive
    | succ k ih =>
        exact hSourceClosed _ ih
  have hMapped :=
    e.retainsLive (iterate s.generator n x) (hOldOrbit n)
  have hEqual :=
    maps_every_finite_generator_iterate s t e n x
  rw [hEqual] at hMapped
  exact hMapped

/-- A represented old pair of distinct states cannot be IDENTIFIED
by an injective rewriting embedding; this is stronger than merely
storing an origin token or exhibiting a generator callback. -/
theorem distinct_old_states_not_merged
    (s : Process X) (t : Process Y)
    (e : Embedding s t) {a b : X} (hDistinct : a ≠ b) :
    e.map a ≠ e.map b := by
  intro hEq
  exact hDistinct (e.injective hEq)

/-- Identity embeddings make these graph processes into a category-
like structure (composition follows below). -/
def identityEmbedding (s : Process X) : Embedding s s where
  map := id
  injective := by intro a b h; exact h
  retainsLive := by intro x hx; exact hx
  retainsParent := by intro a b hab; exact hab
  commutes := by intro x; rfl

/-- Certified embeddings compose, so arbitrary finite sequences of
accepted rewrites retain each old causal node and generator orbit,
assuming every arrow supplies this certificate. -/
def composeEmbedding
    (s : Process X) (t : Process Y) (v : Process Z)
    (e : Embedding s t) (f : Embedding t v) :
    Embedding s v where
  map := fun x => f.map (e.map x)
  injective := by
    intro a b h
    exact e.injective (f.injective h)
  retainsLive := by
    intro x h
    exact f.retainsLive _ (e.retainsLive x h)
  retainsParent := by
    intro a b h
    exact f.retainsParent _ _ (e.retainsParent a b h)
  commutes := by
    intro x
    change f.map (e.map (s.generator x)) =
      v.generator (f.map (e.map x))
    rw [e.commutes x]
    exact f.commutes (e.map x)

/-- Coherence, even exactly, does NOT suffice without injectivity:
a non-injective map to a singleton commutes with both generators
while collapsing distinguishable old states. -/
theorem commuting_noninjective_map_can_erase_distinctions :
    ∃ (f : Bool → Bool) (g : Unit → Unit)
      (e : Bool → Unit),
      (∀ x, e (f x) = g (e x)) ∧
      (false ≠ true) ∧ e false = e true := by
  exact ⟨id, id, (fun _ => ()),
    (by intro x; rfl), (by decide), rfl⟩

/-- Even perfect algebraic generator structure may be STUCK forever
in a single state. Full X3 requires physical liveness and future
agency, not only safe graph typings. -/
theorem total_generator_can_stutter_forever :
    ∀ n, iterate (fun x : Unit => x) n () = () := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih => simpa [iterate] using ih

end PhysicalBridges.IR128
