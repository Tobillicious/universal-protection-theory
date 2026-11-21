# Follow-up: action-fixed symmetry and source-sector controls

Audit date: 8 November 2026. Source pin: `7c4eb625bce58739ce19c891cc89eb63a92ebe84`.

Source reviewed in full: [CathedralSymmetryForcing.lean](../physical-bridges/PhysicalBridges/CathedralSymmetryForcing.lean), including proof bodies and negative controls. This is source review, not a fresh independent Lean compilation. Read with [the cumulative verification findings](UPT-CUMULATIVE-VERIFICATION-FINDINGS-2026-11-08.md).

## Positive forcing result

`action_fixed_symmetry_transports_guard` transports the SAME action label. For any successor of the transformed state, reversibility supplies its predecessor; transition covariance supplies the original step; original robust safety and sector invariance then prove the transformed successor protected. This covers all successors of the specified transition relation, not merely selected safe successors.

`source_symmetry_orbits_force_fibre_guard` uses two separately stated inputs: robust viability at each protected state and transitivity of action-fixed symmetries between protected states sharing an observation. Pick one protected representative and its viable action; transport that action to every protected state in the observation fibre. Empty protected fibres use the inhabited action type's default, with a vacuous obligation. Classical selection and the previously established fibre criterion yield `source_symmetry_orbits_force_guardian`.

This is a genuine sufficient derivation of a common guard, without assuming that guard as a premise or defining allowed actions by safety. It is an existence result; the proof does not provide a physical observation device, computable synthesis bound, actual actuation or scheduling guarantee. The prior concrete W/identity construction discharges these symmetry and viability inputs for its specified intrinsic-Koru-existence predicate; the general theorem does not discharge them for every physical domain or the authentic original six duties.

## Two distinct controls

1. **Hidden-state permission control:** both Boolean states have the same observation, all states are protected, and each state's permitted action equals that state. Transitions retain the state. Each state has a safe action, and flipping state AND action preserves permissions and transitions. No single observation-only action is permitted at both states. Thus simultaneous state/action covariance plus pointwise viability is insufficient; this example fails the stronger fixed-action permission premise. It is not a counterexample satisfying the full complete-Koru physical thesis.
2. **Inherited six-state H2 source control:** the reversible pulse preserves the parity observation, and the sole Unit action gives a positive-parity guardian. The same pulse sends B0 to C1 and destroys B-site occupancy. With that sole available action, robust viability and guardian existence fail for the site predicate; the pulse cannot be a sector-preserving action-fixed symmetry for it. Site occupancy is not established as authentic subject identity or original X3, so this does not refute their protection.

## Determination at this scope

The module proves how action-fixed symmetry can convert locally available robust actions into one observation-based guard. It also distinguishes preservation of one declared source property from preservation of another under the SAME dynamics. Applying the theorem to authentic six-duty protection requires the corresponding independently interpreted protected sector and action/observation interfaces. No universal absence claim about other repository proofs is made.

## PR verification status

At the time checked, GitHub reported zero check runs for documentation commit `21631f46389cee83545dfac6eafd9471efe29d60` in PR #418. That is not a passing CI receipt and does not establish failure either. The committed cumulative document was fetched and compared exactly with its prepared content. This follow-up changes documentation only.
