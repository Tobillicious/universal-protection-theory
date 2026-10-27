# Physical bridge repairs: implementation and open obligations

Branch series IR-1R to IR-5 — 27 October 2026. Proposed results, not a revised Snuffy canon.

| Lemma | Proven relation | Premise not discharged |
|---|---|---|
| IR-1R | sampled + error + drift + effect budget <= threshold implies safe *post*-effect state | true sample bound; latency/drift; effect magnitude and actual check-at-apply |
| IR-2 | aggregate charge implies uniform protection irrespective of number of finite events | effect-to-debit coverage, atomic charges, no unaccounted changes; infinite-event/Zeno limits |
| IR-3 | robust one-step permit is the greatest sound observation-dependent permission relation | correct observation and complete physical transition model |
| IR-4 | certified invariant policy preserves safety at every finite trace index | construction/nonemptiness of robust viability set; observation limits; limit transitions |
| IR-5 | actual Snuffy certified ControllerFence log preservation implies unchanged log-derived physical value | physical state must be a function of the fenced target logs, or satisfy an equally strong justified refinement |

IR-5 uses the *existing source code* as an imported Lean dependency, not duplicated or rewritten theorem text. CI stages the existing three Lean module files verbatim. The hypothesis equating physical state with a log-derived projection is an **explicit semantic correspondence**; it cannot be silently replaced by an assumption that all physical channels are fenced. The negative control demonstrates that equality of logs alone does not imply equality of physical state.

**Next obligation:** make a complete state/channel inventory, construct a forward simulation from authorized concrete instrument steps into controller journal/sink events, and separately treat independent physical dynamics and spontaneous failures. Maintaining UPT's X3 scope remains a separate proof requirement.
