defmodule G3.Ledger.ValidWorkBill do
  @moduledoc "ETS-backed immutable work bill ledger."
  def record_transition(ets, entry) do
    :ets.insert(ets, {entry.id, entry})
    :ok
  end
end
