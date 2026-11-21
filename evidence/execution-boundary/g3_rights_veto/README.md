# Durable rights withdrawal veto — offline research component

This is a small deny-only, persistent local journal to complement the separate research lanes in PR #472 (signed provenance claim) and PR #473 (subject-specific record triage). It does **not** connect to any G3 writer, offer consent, or grant effect authority.

## Intended guarantee under its limited single-controller threat model

- A trusted controller can record an irreversible local withdrawal of a particular record reference, subject, action and exact effect digest.
- Withdrawals and an increasing generation counter are durably written in one SQLite transaction with WAL and synchronous FULL.
- On restart the control state is explicitly halted, and withdrawn references remain denied.
- Requests bearing stale generation information are denied. An unknown record or a missing withdrawal never gives authorization.
- Journal directory and file must be private to the owning user; symlink DB paths are refused.

## Do not treat as a live rights authority

The trusted controller method is deliberately an in-process API; **no public socket, arm operation, allow operation or application permit exists**. This library cannot validate a person's identity, capacity, voluntariness, representation, consent, provenance or the original six X3 duties. If an attacker can edit/delete/rollback SQLite state or its WAL, compromise the controller identity, or run another instance with the same DB unsafely, the protection model fails. The journal's observed generation is not a remote revocation consistency proof.

All query responses carry `authorizes_effect: false`, `authentic_consent_proved: false` and `original_six_x3_proved: false`. A result of `no_local_withdrawal_found_not_authorized` must **never** be converted into allow. The journal is a *veto evidence component*, not a permission gate.

Additional required work: authenticated controller source, atomic integration with effect commit and revocation ordering, rollback-resistant persistent generation, independent audit, complete application-specific rights/consent rules, and real-world six-X3 correspondence. Do not deploy this component as an authority or infer universal physical G3.

Run offline negative controls:

```sh
cd evidence/execution-boundary/g3_rights_veto
python3 -B -m unittest -v test_rights_veto.py
```

## Explicit provisioning and restart semantics (stacked hardening)

The rights journal constructor is now deny-by-default on absent or malformed persistent state:

- Provision a **new** journal explicitly: `RightsVetoJournal(private_path, initialize=True)`. This fails if the path already exists.
- Reopen an existing journal: `RightsVetoJournal(private_path)`. This fails if the file is missing or the control row/schema is absent. It does not auto-create a replacement.
- The trusted deployment controller, not an application or agent, must hold the private directory and decide whether to provision a fresh independent installation. Do **not** use `initialize=True` as recovery from missing or corrupt historical state.

This prevents accidental silent recreation; it **does not** prevent a privileged adversary restoring an older valid snapshot. External trusted generation anchoring and independent attestation remain unresolved.

## Withdrawal coverage integrity check (stacked review)

Every accepted withdrawal consumes exactly one generation, starting at one.
On startup and during inspection, the journal verifies that the stored
withdrawal count, distinct generation count, minimum generation and maximum
generation match the durable control counter. Missing, duplicated or gapped
withdrawal rows fail closed instead of being interpreted as an absence of
withdrawal.

This detects some accidental corruption or incomplete local histories, **not**
malicious rollback to an older self-consistent snapshot or a fully forged
database. Externally anchored state and independent controller authentication
remain required for stronger integrity claims.
