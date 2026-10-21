# Prices and founding (items 10 and 8; v0.17.11 follow-up)

20 Oct 2026. Claude, author side. Values are read directly from Codex's frozen `upt-rung4a/K3-SCREEN.json`.
Every price is an **unmeasured joint target** in model stock units, not a dollar figure.

## Item 10: price targets (state: M, measurement)

| Target | Value | Key |
|---|---:|---|
| Stock per island, k = 3 plant | 1711424 | `total_stock_per_island` |
| Incremental stock over TW-1 per island | 514048 | `incremental_stock` |
| Per compute-host upgrade (242 hosts) | 2048 | `per_host_upgrade_stock_target` |
| Per new passive site (10 sites) | 1024 | `per_new_passive_stock_target` |
| Fabric upgrade per island | 8192 | `fabric_upgrade_stock_target` |
| Incremental idle draw per island-date | 10 | `incremental_idle_per_island_date` |
| New idle total per island-date | 11 | `new_idle_total` |

A fully endowed maximum world of 10²⁰ islands needs 1.711424e+26 stock units, which matches Codex's 1.711424×10²⁶.

**The test for "resolved":** each target needs a measured cost for the hardware class it names. It passes when the
measured cost is at most the target. Until then, the plant is a design point, not a costed system.

## Item 8: founding (state: B, boundary condition)

- **P-COMMISSION** is a boundary condition on the theorem's domain, like an initial condition: the theorem says
  what follows *if* the plant is commissioned.
- **The mechanism** (already in the paper): a dominant assurance contract with a lock-in window. Pledges are
  refunded with a bonus if the target is not met, so pledging is attractive. Care is never for sale. This makes
  commissioning attractive to fund. It does not make it certain.
- **The physical floor:** commissioning needs free energy at least the Landauer cost of its irreversible
  operations. That is a necessary condition only.
- **No further claim** is made. Survivorship-style arguments ("anything unfunded fails, so funding happens") are
  rejected: they state a requirement, not a supply.
