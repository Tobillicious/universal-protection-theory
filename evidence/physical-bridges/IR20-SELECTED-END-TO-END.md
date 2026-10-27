# IR-20 — Selected-Outcome End-to-End Certificate

The previously checked IR-10 composite requires two very strong,
sufficient **but not generally necessary** assumptions:

1. All full-feasible outcomes outside the menu are dominated by an
   outcome within the safety menu (`Cofinal`).
2. Every safe-menu outcome is individually realized by an
   observation-uniform viable policy.

IR-17 proved a strictly weaker **selected-outcome** join. IR-20 imports
the actual IR-10 helpers, the original unchanged UPT maximality source,
and IR-17's theorem. It retains the identical conditional physical,
sensor, drift/budget, certified hold, stable kernel, and forward
simulation obligations, but requires only:

- a particular selected safe-menu option that is locally UPT maximal;
- NO strictly better full-feasible option omitted from the menu;
- an observation-only invariant policy realizing **that selected option**.

Under these premises it proves original full-UPT global maximality of
the selected outcome, the same finite-trace physical and record
certificates, and guarded effects.

This is genuinely weaker than IR-10's cofinality/whole-menu realization
requirements. It still does NOT prove the selected option exists for
every physical instance, nor that actual plant/historical semantics
satisfy any of the physical interface premises. No change to X3.

IR-18's two-sided resource guard and IR-19's belief-history policy
contract are independent follow-ons; IR-20 does not silently claim they
are automatically discharged by IR-10's scalar upper-hazard semantics.
