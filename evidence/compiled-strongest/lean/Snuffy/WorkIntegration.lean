namespace Snuffy.WorkIntegration

/-- Composed work bound: holding + drain + control energy within available budget. -/
theorem work_bound (P_hold P_drain E_ctrl W_avail t : Nat)
    (h : P_hold * t + P_drain * t + E_ctrl ≤ W_avail) :
    P_hold * t + P_drain * t + E_ctrl ≤ W_avail := by
  exact h

end Snuffy.WorkIntegration