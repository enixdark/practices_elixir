defmodule Meter.Coordinator do
  def loop(results \\ [], results_expected) do
    receive do
      {:ok, result} ->
        new_results = [result | results]
        if results_expected == new_results |> Enum.count do
          send self, :exit
        end
        loop(new_results, results_expected)
      :exit ->
        IO.puts(results |> Enum.sort |> Enum.join(", "))
      _ ->
        loop(results, results_expected)
    end
  end
end
