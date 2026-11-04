# IR-135 — Source HOLD with a declared operating-system effect authority

Date: 2026-11-03. Status: conditional Lean principal refinement and scoped Linux OS permission experiment. NOT universal physical protection, hardware validation, or root no-bypass guarantee.

Parent draft stack: PR #230 (IR-134 actual physical-effect residuals) → #229 (IR-133 captured source/enacted action) → #227 (joined original-X3 finite source obligations).

## 1. A stronger but bounded source-to-effect boundary

The old reference-runtime sink uses a cooperative lock. PR #230 experimentally showed an independent same-UID process bypassing its HOLD and appending to the same temporary source log.

IR-135 builds a different operating-system fixture:

- A root-owned broker holds the only approved file write authority for a root-owned 0600 effect file under a 0700 directory. An unprivileged Linux client can request that broker to append.
- The broker serializes effect application, durably commits each effect with fsync, then acknowledges root-authorized HOLD after previously in-flight work is complete.
- A named unprivileged process (nobody UID in a disposable GitHub Ubuntu/Linux runner) attempts direct append, truncation, chmod and unlink. All should be denied by kernel directory/file permissions both before and after HOLD.
- A deliberately privileged root process directly appends AFTER the HOLD acknowledgement. This must succeed as a NEGATIVE security control. Root and equivalent privileged principals are inside the trusted computing base, not constrained by these file permissions.

This is a single-tempfile, single-UID, ordinary-Linux-DAC test. It cannot constrain root actors, pre-opened forwarded descriptors, unmeasured files and paths, special kernel privileges, other effect channels, physical devices or all possible physical processes. It is not a proof of universal no-bypass.

## 2. Lean proof: effect-APPLYING principal, not requesting client

The new module PhysicalBridges.IR135PrincipalAuthorityBoundary defines a principal-labeled, independently given physicalStep. A client requesting a broker effect does not become the effect-applying principal: the broker is still the privileged writer.

The structure PrincipalEffectAuthority has four independently warranted clauses:

1. untrustedSourceUnchanged: any actual step applied by an untrusted writer leaves the source pipeline unchanged.
2. untrustedEffectUnchanged: the same untrusted writer cannot directly modify the measured effect.
3. trustedStepRefined: every privileged effect application is a valid IR-32 source pipeline command.
4. trustedEffectAccounted: every privileged physical effect increment is bounded by its source landed increment plus a separately measured physical residual.

The theorem held_actual_principal_step_bound derives quiescent source and per-principal physical effect envelope

    E(t) <= E(s) + residual(principal,s,t)

from the complete source HOLD and that effect-applying authority certificate.

The theorem all_finite_principal_scoped_held_traces composes the inequality over any finite sequence of actual labeled physical transitions. If every trusted applying-principal step has externally warranted zero residual, and the untrusted-denial evidence is sound, then the true physical effect cannot grow.

The exact countermodel untrusted_denial_does_not_restrict_trusted_bypass demonstrates that prohibiting every unprivileged write is compatible with a privileged writer changing the true effect. It is an explicit warning against equating Linux DAC with universal physical protection.

The theorem does not derive any certificate premise from BCRD, OS permission bits, an event label, a digital log or a claimed source invariant.

## 3. Reproduce the bounded operating-system experiment

    sudo -n python3 evidence/physical-bridges/check_ir135_os_authority.py

Run only on disposable, isolated Linux CI with root enabled. The GitHub Actions workflow ir135-os-authority.yml executes and archives it; all files are in an automatically removed temporary directory.

It verifies: unprivileged HOLD rejected; unprivileged pre-HOLD broker request accepted; direct outsider appends/truncates/chmod/unlink denied; in-flight broker effect committed before acknowledged HOLD; post-HOLD broker effects refused; direct outsider effects still denied; privileged root bypass deliberately succeeds.

There are no measurements of physical radiation, energy, independent hardware sink, OS root compromise, subject continuation, or quantum memory. The test is evidence only for the named DAC fixture and principal boundaries.

## 4. What remains

The previous source-only cooperative fixture remains bypassable by an independent same-UID process. This different kernel-DAC fixture demonstrates better enforcement against the named unprivileged principal, NOT protection from root or all physical sources.

The machine-readable ir135-os-authority-ledger.json retains complete physical X3 status OPEN and lists unclosed obligations: root/equivalent privileged authority, all real output channels, independent physical effects and residual measurements, real-source coverage, history/subject semantic correspondence, resources and the all-scale 3D warm start.

Original X3, canonical manuscript, physical founding, commissioning, publication and funding remain unchanged. Do not merge as real-world certification.
