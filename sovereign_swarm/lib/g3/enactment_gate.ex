defmodule G3.EnactmentGate do
  @moduledoc "Whole-event enactment gate for G3."
  def check(state) do
    if Map.get(state, :boundary_rupture, false) do
      {:intercept, fold_into_g(state)}
    else
      {:ok, state}
    end
  end

  defp fold_into_g(state) do
    state
    |> Map.put(:boundary_rupture, false)
    |> Map.put(:invariant_closed, true)
  end
end
