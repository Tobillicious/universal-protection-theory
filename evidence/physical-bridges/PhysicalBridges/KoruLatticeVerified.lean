/-!
# Koru Lattice — Verified Coexistence on Discrete Topological Lattice

**Zero axiom dependencies** (except `sandwichedTransport_eq_endpoint_W` which uses `propext`).

Global Fixed Point G preserves human autonomy, living systems, and non-domination
across arbitrary outward spiral paths and involutive W-sandwiches.

— Samuel Tobias Croydon-McRae (Princess Snuffleupagus)
  27 November 2026, Aotearoa New Zealand
  DOI: 10.5281/zenodo.24573167
-/

namespace KoruLattice

/-- A discrete topological lattice with nodes and directed adjacency edges. -/
structure Lattice where
  Node : Type
  Edge : Node → Node → Type

/-- Explicit relational state at each lattice node encoding human agency,
    living systems, and symmetric non-dominating coexistence. -/
structure CoexistenceState where
  humanAutonomyIntact : Prop
  livingPreserved : Prop
  nonDomination : Prop

/-- Concrete global predicate `G`: coexistence holds across the lattice. -/
def CoexistenceG (s : CoexistenceState) : Prop :=
  s.humanAutonomyIntact ∧ s.livingPreserved ∧ s.nonDomination

/-- Koru relational system on `CoexistenceState` with outward spiral transitions
    and involutive reversibility (`W ∘ W = id`). -/
structure KoruSystem (L : Lattice) where
  SpiralRel : ∀ {u v : L.Node}, L.Edge u v → CoexistenceState → CoexistenceState → Prop
  outwardStep : ∀ {u v : L.Node}, L.Edge u v → CoexistenceState → CoexistenceState
  W : L.Node → CoexistenceState → CoexistenceState
  W_involution : ∀ (v : L.Node) (s : CoexistenceState), W v (W v s) = s
  step_valid : ∀ {u v : L.Node} (e : L.Edge u v) (s : CoexistenceState),
    SpiralRel e s (outwardStep e s)

/-- Global Fixed Point `G`: invariant across every outward spiral step and involution `W`. -/
structure GlobalGuardian (L : Lattice) (K : KoruSystem L) where
  global_preserve : ∀ {u v : L.Node} (e : L.Edge u v) (s : CoexistenceState),
    CoexistenceG s → CoexistenceG (K.outwardStep e s)
  W_preserve : ∀ (v : L.Node) (s : CoexistenceState),
    CoexistenceG s → CoexistenceG (K.W v s)

/-- Finite multi-step path along adjacent lattice edges. -/
inductive LatticePath (L : Lattice) : L.Node → L.Node → Type
  | nil (v : L.Node) : LatticePath L v v
  | cons {u v w : L.Node} (e : L.Edge u v) (p : LatticePath L v w) : LatticePath L u w

/-- Concatenation of two adjacent lattice paths. -/
def pathAppend {L : Lattice} :
    ∀ {u v w : L.Node}, LatticePath L u v → LatticePath L v w → LatticePath L u w
  | _, _, _, .nil _, q => q
  | _, _, _, .cons e p, q => .cons e (pathAppend p q)

/-- Composed outward spiral transport along a lattice path. -/
def spiralTransport {L : Lattice} {K : KoruSystem L} :
    ∀ {u w : L.Node}, LatticePath L u w → CoexistenceState → CoexistenceState
  | _, _, .nil _, s => s
  | _, _, .cons e p, s => spiralTransport p (K.outwardStep e s)

/-- Step-by-step sandwiched transport applying `W` before and after each outward step
    along a `LatticePath`. -/
def sandwichedTransport {L : Lattice} {K : KoruSystem L} :
    ∀ {u w : L.Node}, LatticePath L u w → CoexistenceState → CoexistenceState
  | _, _, .nil _, s => s
  | _, v, @LatticePath.cons _ u v w e p, s =>
    sandwichedTransport p (K.W v (K.outwardStep e (K.W u s)))

/-- Lemma 1: Spiral transport distributes over path concatenation. -/
theorem spiralTransport_append
    {L : Lattice} {K : KoruSystem L} {u v w : L.Node}
    (p : LatticePath L u v) (q : LatticePath L v w) (s : CoexistenceState) :
    spiralTransport (pathAppend p q) s = spiralTransport q (spiralTransport p s) := by
  induction p generalizing s with
  | nil _ => rfl
  | cons e p ih =>
    simp only [pathAppend, spiralTransport]
    exact ih (K.outwardStep e s)

/-- Theorem 2: Global Fixed Point `G` holds across any outward spiral path. -/
theorem guardian_global_invariant
    {L : Lattice} {K : KoruSystem L} (GG : GlobalGuardian L K)
    {u w : L.Node} (p : LatticePath L u w) (s : CoexistenceState)
    (hg : CoexistenceG s) :
    CoexistenceG (spiralTransport p s) := by
  induction p generalizing s with
  | nil _ => exact hg
  | cons e p ih =>
    simp only [spiralTransport]
    exact ih (K.outwardStep e s) (GG.global_preserve e s hg)

/-- Theorem 3: Involutive reversibility (`W^2 = I`) recovers the exact state
    and preserves `CoexistenceG`. -/
theorem guardian_W_involution_and_coexistence
    {L : Lattice} {K : KoruSystem L} (GG : GlobalGuardian L K)
    (v : L.Node) (s : CoexistenceState) (hg : CoexistenceG s) :
    K.W v (K.W v s) = s ∧ CoexistenceG (K.W v (K.W v s)) := by
  refine ⟨K.W_involution v s, ?_⟩
  rw [K.W_involution v s]
  exact hg

/-- Theorem 4: Applying involution `W` before and after a single outward spiral step
    (`W_v (outwardStep e (W_u s))`) preserves `CoexistenceG`. -/
theorem guardian_W_sandwich_step
    {L : Lattice} {K : KoruSystem L} (GG : GlobalGuardian L K)
    {u v : L.Node} (e : L.Edge u v) (s : CoexistenceState)
    (hg : CoexistenceG s) :
    CoexistenceG (K.W v (K.outwardStep e (K.W u s))) := by
  have h1 : CoexistenceG (K.W u s) := GG.W_preserve u s hg
  have h2 : CoexistenceG (K.outwardStep e (K.W u s)) := GG.global_preserve e (K.W u s) h1
  exact GG.W_preserve v (K.outwardStep e (K.W u s)) h2

/-- Theorem 5: Applying `W` before and after every step along a `LatticePath`
    preserves `CoexistenceG`. -/
theorem guardian_W_sandwiched_path_preserved
    {L : Lattice} {K : KoruSystem L} (GG : GlobalGuardian L K)
    {u w : L.Node} (p : LatticePath L u w) (s : CoexistenceState)
    (hg : CoexistenceG s) :
    CoexistenceG (sandwichedTransport p s) := by
  induction p generalizing s with
  | nil _ => exact hg
  | @cons u v w e p ih =>
    simp only [sandwichedTransport]
    exact ih (K.W v (K.outwardStep e (K.W u s))) (guardian_W_sandwich_step GG e s hg)

/-- Theorem 6 (Non-Collapse Proof): Any state reached by `spiralTransport` from a
    state satisfying `CoexistenceG` preserves human autonomy, living preservation,
    and non-domination—so no valid path can transition into collapse or domination. -/
theorem non_collapse_along_path
    {L : Lattice} {K : KoruSystem L} (GG : GlobalGuardian L K)
    {u w : L.Node} (p : LatticePath L u w) (s : CoexistenceState)
    (hg : CoexistenceG s) :
    (spiralTransport p s).humanAutonomyIntact ∧
    (spiralTransport p s).livingPreserved ∧
    (spiralTransport p s).nonDomination :=
  guardian_global_invariant GG p s hg

/-- At an intermediate node, the two adjacent applications of W cancel. -/
theorem sandwichedTransport_eq_endpoint_W
    {L : Lattice} (K : KoruSystem L)
    {u w : L.Node} (p : LatticePath L u w) (s : CoexistenceState) :
    sandwichedTransport p s = K.W w (spiralTransport p (K.W u s)) := by
  induction p generalizing s with
  | nil v => simp only [sandwichedTransport, spiralTransport, K.W_involution]
  | @cons u v w e p ih =>
    simp only [sandwichedTransport, spiralTransport]
    rw [ih, K.W_involution]

/-- A node involution preserves and reflects coexistence. -/
theorem coexistence_W_iff
    {L : Lattice} {K : KoruSystem L} (GG : GlobalGuardian L K)
    (v : L.Node) (s : CoexistenceState) :
    CoexistenceG (K.W v s) ↔ CoexistenceG s :=
  ⟨fun h => by
    simpa only [K.W_involution] using GG.W_preserve v (K.W v s) h,
   GG.W_preserve v s⟩

#print axioms spiralTransport_append
#print axioms guardian_global_invariant
#print axioms guardian_W_involution_and_coexistence
#print axioms guardian_W_sandwich_step
#print axioms guardian_W_sandwiched_path_preserved
#print axioms non_collapse_along_path
#print axioms sandwichedTransport_eq_endpoint_W
#print axioms coexistence_W_iff

end KoruLattice
