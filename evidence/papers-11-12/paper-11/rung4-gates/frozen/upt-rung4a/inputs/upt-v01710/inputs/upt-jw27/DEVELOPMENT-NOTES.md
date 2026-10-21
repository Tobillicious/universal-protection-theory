# Development failures and corrections

These failures are separate from the nine deliberate adverse claims in the final paired replay.

- Initial calculation exited1 on Python3.9 because sys.set_int_max_str_digits is unavailable there. The call is now conditional on hasattr; no probability calculation depended on that API.
- The first relocated replay exited1 after its calculation, controls, rendering and copy-only checks, when its final file comparison rejected the macOS/var ancestor symlink. portable.py now resolves the newly created temporary directory to its real/private/var path before checking files. The symlink/excluded-path guards remain strict. Final portable evidence is supplied only by the later successful run.
- The first draft’s persistent-across-horizon fault example was too broad for a conditional fault premise: observed persistent failures cannot be treated as fresh.002 trials. It was replaced with a fresh-event comparison at the same audited pre-window history, with event timing concentrated inside both nested windows. That example shows the missing start-intensity premise without asserting a complete calibrated temporal fault model.

No earlier bank was edited by these corrections. Final numeric and replay evidence must be regenerated from the corrected files; stale evidence is not accepted by the bank audit.
