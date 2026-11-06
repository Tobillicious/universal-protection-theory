import PhysicalBridges.RouteBComplexKoruFactorization

/-!
# Complex BCRD event provenance is not a function of the terminal whole

This is a new mathematical step toward the full operator- and provenance-
sensitive ∆ (Koru). In the actual source-pinned algebraic-complex BCRD M3d
model, W is a *nontrivial* exact six-carrier update, but applying W twice
recovers ALL initial complex carrier amplitudes. Thus two different
physically source-generated operator histories have the SAME complete
terminal six-carrier readout. No function of that final readout alone
can reconstruct the number of events, the operator word, or the full
ordered source-amplitude history.

A chronological readout containing every intermediate complete
six-carrier source snapshot DOES distinguish those histories, even
though the final state agrees. The difference is produced by actual
banked complex source operators, not a freely asserted subject flag.

This proves the necessity of event-history information for exact
physical-source provenance in this finite model. It does NOT establish
subjective continuation, authentic authorization, freedom or original
six-X3 protection in the real world, nor an actual cosmological cycle.
-/

namespace PhysicalBridges.KoruOperatorHistoryProvenance

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage

/-- All six exact source amplitudes at the END of a specified
sequence of original pinned complex BCRD source-stage operators. -/
def terminalFullAmplitudes (history : List SourceStage) : Index → State :=
  fun origin => runStages history (basis origin)

/-- One exact W update changes at least the M0 basis-origin amplitude
at basis coordinate M0. This is a genuine nontrivial source event. -/
theorem one_exact_W_move_is_not_stasis :
    terminalFullAmplitudes [.endogenousW] ≠
      terminalFullAmplitudes [] := by
  intro h
  have hCoord :
      (terminalFullAmplitudes [.endogenousW] 2) 2 =
        (terminalFullAmplitudes [] 2) 2 :=
    congrFun (congrFun h 2) 2
  have hDifferent :
      (terminalFullAmplitudes [.endogenousW] 2) 2 ≠
        (terminalFullAmplitudes [] 2) 2 := by decide +kernel
  exact hDifferent hCoord

/-- Despite its nontrivial first step, the independently banked
source W involution restores the COMPLETE six-origin complex
amplitude table, not just a selected carrier or a scalar value. -/
theorem two_exact_W_moves_return_every_complex_source_carrier :
    terminalFullAmplitudes [.endogenousW, .endogenousW] =
      terminalFullAmplitudes [] := by
  funext origin coordinate
  have h : ∀ i j : Index,
      (terminalFullAmplitudes [.endogenousW, .endogenousW] i) j =
        (terminalFullAmplitudes [] i) j := by decide +kernel
  exact h origin coordinate

/-- A genuine source-generated two-event cycle has a changed
intermediate whole but the identical terminal whole. -/
theorem nontrivial_operator_loop_is_invisible_to_final_amplitudes :
    terminalFullAmplitudes [.endogenousW] ≠ terminalFullAmplitudes [] ∧
    terminalFullAmplitudes [.endogenousW, .endogenousW] =
      terminalFullAmplitudes [] := by
  exact ⟨one_exact_W_move_is_not_stasis,
    two_exact_W_moves_return_every_complex_source_carrier⟩

/-- Hence no single terminal-complex-amplitude readout can
reconstruct every source operator word, even though it includes
ALL six initial source origins and every terminal coordinate. -/
theorem no_terminal_full_amplitudes_to_exact_operator_word_decoder :
    ¬ ∃ decode : (Index → State) → List SourceStage,
      ∀ history : List SourceStage,
        decode (terminalFullAmplitudes history) = history := by
  rintro ⟨decode, hDecode⟩
  have hSame : ([] : List SourceStage) =
      [.endogenousW, .endogenousW] := by
    calc
      ([] : List SourceStage) =
        decode (terminalFullAmplitudes []) := (hDecode []).symm
      _ = decode (terminalFullAmplitudes [.endogenousW, .endogenousW]) := by
        rw [two_exact_W_moves_return_every_complex_source_carrier]
      _ = [.endogenousW, .endogenousW] := hDecode _
  exact (by decide : ([] : List SourceStage) ≠
    [.endogenousW, .endogenousW]) hSame

/-- An ordered complete physical-SOURCE readout: the all-six-carrier
amplitude table at every event boundary, computed by actual
source operators. No semantic identity/protection bit is inserted. -/
def traceFrom (current : Index → State) :
    List SourceStage → List (Index → State)
  | [] => [current]
  | op :: rest =>
      current :: traceFrom
        (fun origin => matVec (operatorFor op) (current origin)) rest

def completeAmplitudeTrace (history : List SourceStage) :
    List (Index → State) :=
  traceFrom (fun origin => basis origin) history

/-- A complete event-boundary trace has exactly one more snapshot
than actual source-operator updates. This is provenance
information rather than an inferred state label. -/
theorem traceFrom_length (current : Index → State)
    (history : List SourceStage) :
    (traceFrom current history).length = history.length + 1 := by
  induction history generalizing current with
  | nil => rfl
  | cons op rest ih =>
      simp [traceFrom, ih]

theorem complete_trace_records_source_event_count
    (history : List SourceStage) :
    (completeAmplitudeTrace history).length = history.length + 1 :=
  traceFrom_length _ _

/-- These two exact source histories have different chronological
amplitude traces despite the SAME six-origin terminal amplitudes. -/
theorem complete_source_trace_distinguishes_two_W_cycle :
    completeAmplitudeTrace [] ≠
      completeAmplitudeTrace [.endogenousW, .endogenousW] := by
  intro h
  have hLength := congrArg List.length h
  have hEmpty := complete_trace_records_source_event_count
    ([] : List SourceStage)
  have hTwo := complete_trace_records_source_event_count
    ([.endogenousW, .endogenousW] : List SourceStage)
  simp only [List.length_nil, Nat.zero_add] at hEmpty
  have hMismatch :
      ([] : List SourceStage).length + 1 =
        ([.endogenousW, .endogenousW] : List SourceStage).length + 1 := by
    calc
      ([] : List SourceStage).length + 1 =
        (completeAmplitudeTrace []).length := hEmpty.symm
      _ = (completeAmplitudeTrace [.endogenousW, .endogenousW]).length := hLength
      _ = ([.endogenousW, .endogenousW] : List SourceStage).length + 1 :=
        hTwo
  exact (by decide : ([] : List SourceStage).length + 1 ≠
    ([.endogenousW, .endogenousW] : List SourceStage).length + 1) hMismatch

/-- Stronger information impossibility: complete terminal states
are not sufficient to reconstruct complete chronological physical
amplitude histories. The actual W/W example is a nontrivial
source-produced witness of this factorisation failure. -/
theorem no_terminal_full_amplitude_to_complete_trace_decoder :
    ¬ ∃ decode : (Index → State) → List (Index → State),
      ∀ history : List SourceStage,
        decode (terminalFullAmplitudes history) =
          completeAmplitudeTrace history := by
  rintro ⟨decode, hDecode⟩
  apply complete_source_trace_distinguishes_two_W_cycle
  calc
    completeAmplitudeTrace [] =
      decode (terminalFullAmplitudes []) := (hDecode []).symm
    _ = decode (terminalFullAmplitudes [.endogenousW, .endogenousW]) := by
      rw [two_exact_W_moves_return_every_complex_source_carrier]
    _ = completeAmplitudeTrace [.endogenousW, .endogenousW] := hDecode _

/-- An independently proposed enhanced observation that can
decode exact source event counts must distinguish these histories.
This is a checkable information requirement, NOT a premise
that authentic subjective continuity is already encoded. -/
theorem any_event_count_faithful_enrichment_must_separate_W_loop
    {Extra : Type} (extra : List SourceStage → Extra)
    (hDec : ∃ decode : ((Index → State) × Extra) → Nat,
      ∀ history : List SourceStage,
        decode (terminalFullAmplitudes history, extra history) =
          history.length) :
    extra [] ≠ extra [.endogenousW, .endogenousW] := by
  intro hExtra
  obtain ⟨decode, hDecode⟩ := hDec
  have hReading :
      (terminalFullAmplitudes [], extra []) =
        (terminalFullAmplitudes [.endogenousW, .endogenousW],
          extra [.endogenousW, .endogenousW]) := by
    apply Prod.ext
    · exact two_exact_W_moves_return_every_complex_source_carrier.symm
    · exact hExtra
  have hCount : ([] : List SourceStage).length =
      ([.endogenousW, .endogenousW] : List SourceStage).length := by
    calc
      ([] : List SourceStage).length =
        decode (terminalFullAmplitudes [], extra []) := (hDecode []).symm
      _ = decode (terminalFullAmplitudes
            [.endogenousW, .endogenousW],
            extra [.endogenousW, .endogenousW]) := by rw [hReading]
      _ = ([.endogenousW, .endogenousW] : List SourceStage).length :=
        hDecode _
  exact (by decide : ([] : List SourceStage).length ≠
    ([.endogenousW, .endogenousW] : List SourceStage).length) hCount

#print axioms one_exact_W_move_is_not_stasis
#print axioms two_exact_W_moves_return_every_complex_source_carrier
#print axioms no_terminal_full_amplitudes_to_exact_operator_word_decoder
#print axioms complete_trace_records_source_event_count
#print axioms complete_source_trace_distinguishes_two_W_cycle
#print axioms no_terminal_full_amplitude_to_complete_trace_decoder
#print axioms any_event_count_faithful_enrichment_must_separate_W_loop

end PhysicalBridges.KoruOperatorHistoryProvenance
