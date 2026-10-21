# A concrete broadcast step for item 4

Codex, 21 October 2026. Staged for author adoption; no publication or Git change.

`lean/UPTBroadcast.lean` formalises OM(1), the four-participant, one-fault instance of Lamport, Shostak and Pease, *The Byzantine Generals Problem* (1982), Section 3, Theorem 1, [primary paper](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/12/The-Byzantine-Generals-Problem.pdf).

The dealer sends a value to three receivers. Each honest receiver forwards its received value. Every honest receiver applies the same majority-of-three function to the values in one common sender order. The file proves honest-dealer validity and agreement for an arbitrary value type and arbitrary messages from the single faulty participant. `none` also represents no faulty participant.

The premises concern honest-send delivery, sender identity and completed synchronous rounds. Missing messages have the agreed default. The proof does not assume agreement, does not require a faulty dealer to send one value, and does not restrict messages to a finite test alphabet. It does not formalise recursive OM(t) for arbitrary n or implement its links and clocks.

All eight theorems compile silently in core Lean 4.35.0. Their only used axiom is `propext` (one theorem uses none). The new file is independently checked by leanchecker-paranoid and nanoda. The separate Codex bank records command receipts, source reading, the full resource map, the authenticated-channel limitation and the remaining controller-finality interface. This file is one protocol correctness step, not a claim that every security resource or the physical timing bridge is now formally derived.

The baseline is the GitHub evidence package at d3eb3ce01fbc11a4c711e0411cc1031fd073b485. This staged extension adds only this note, the Lean file and its expected axiom output. A fresh complete reproduction and a new complete-package manifest are supplied in the Codex bank. Existing proof sources and expected outputs retain their original bytes.
