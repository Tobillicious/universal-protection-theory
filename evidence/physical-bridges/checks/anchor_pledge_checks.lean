import PhysicalBridges.AnchorPledgeForfeiture

open PhysicalBridges.AnchorPledgeForfeiture

def requireCheck (label : String) (ok : Bool) : IO Unit :=
  if ok then pure () else throw (IO.userError label)

def tickets : List Claim :=
  [⟨10, 5, 2, 1⟩, ⟨20, 7, 2, 3⟩, ⟨30, 11, 2, 2⟩]

def requestTraces : Nat → List (List Request)
  | 0 => [[]]
  | n + 1 => [Request.idle, .withdrawFree, .breach].flatMap
      (fun r => (requestTraces n).map (fun rs => r :: rs))

def tracePolicy (rs : List Request) (n : Nat) (_s : State) : Request :=
  (rs[n]?).getD .idle

def main : IO Unit := do
  let some start := commit 50 9 tickets | throw (IO.userError "funded commitment rejected")
  requireCheck "incomplete cash/work budget admitted" (commit 43 9 tickets).isNone
  requireCheck "initial complete ledger" (stock start == 50)
  requireCheck "all fixed finite request traces" ((requestTraces 3).length == 27)
  for rs in requestTraces 3 do
    let finish := run (tracePolicy rs) start 3
    requireCheck "refund/bonus queue stalled" finish.pending.isEmpty
    requireCheck "ticket identity, amount or order changed" (decide (finish.paid = tickets))
    requireCheck "complete ledger changed" (stock finish == 50)
    requireCheck "refund total" (refundTotal finish.paid == 23)
    requireCheck "bonus total" (bonusTotal finish.paid == 6)
    requireCheck "complete service charge" (workTotal finish.paid == 6)
    requireCheck "work reserve left unpaid" (finish.workReserve == 0)
    requireCheck "cash reserve left unpaid" (finish.cashReserve == 0)
    requireCheck "terminal epoch is not quiescent" (decide (tick .breach finish = finish))
  let hostile := run (tracePolicy [.withdrawFree, .breach, .breach]) start 3
  requireCheck "free withdrawal did not remain separate" (hostile.withdrawn == 6)
  requireCheck "repeated breach created a second bond" (hostile.forfeited == 9)
  requireCheck "breach did not consume the bond" (hostile.bond == 0)
  -- Negative fixture: funded refunds/bonuses alone do not authorize a missing
  -- service charge. The source stops rather than doing unpaid work.
  let missingWork := { start with workReserve := 5 }
  let stopped := run (fun _ _ => .idle) missingWork 3
  requireCheck "unfunded final service executed" (stopped.pending.length == 1)
  requireCheck "unfunded service was recorded as paid" (stopped.paid.length == 2)
  requireCheck "negative fixture changed conserved stock" (stock stopped == stock missingWork)
  IO.println "PASS: 27 request traces; full tickets/refunds/bonuses/service costs; forfeiture, quiescence and underfunded rejection."
