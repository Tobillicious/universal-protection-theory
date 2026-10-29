import Snuffy.FiniteCharacter

/-!
# One policy, maximal across every world (finding 13)

The rival bound at the top needs one policy realising the top outcome in every world.
Where no single policy can, the law still requires one policy fixed before the world is
known. Index each particular by the world it is in: a fact is
`(stage, (world, particular))`. A policy's outcome is the set of facts it realises
across all worlds. The law's staged order on these joint outcomes compares policies in
every world at once.

* `common_policy_maximal` — for every compact policy space with closed realisation sets,
  some single policy realises an outcome that no realisable outcome improves in the
  law's order across all worlds jointly (an instance of
  `FiniteCharacter.four_stage_maximal_of_compact`).
-/

namespace Snuffy.CommonPolicyMaximal

open Snuffy.StagedMaximality Snuffy.FiniteCharacter

variable {World P Pol : Type*} [TopologicalSpace Pol] [CompactSpace Pol]

theorem common_policy_maximal (out : Pol → Set (Fact (World × P)))
    (hclosed : ∀ a, IsClosed {q | a ∈ out q}) (Req : Set (Fact (World × P)))
    (hReq : RealisableFamily out Req freedomPre Req) :
    ∃ q : Pol, ∃ m, m ⊆ out q ∧ RealisableFamily out Req freedomPre m ∧ Req ⊆ m ∧
      ∀ t, RealisableFamily out Req freedomPre t →
        ¬ LexBetter (fun a : Fact (World × P) => (a.1 : ℕ)) m t := by
  obtain ⟨m, hm, hreq, hmax⟩ := four_stage_maximal_of_compact out hclosed Req hReq
  obtain ⟨q, hq⟩ := hm.1
  exact ⟨q, m, hq, hm, hreq, hmax⟩

end Snuffy.CommonPolicyMaximal
