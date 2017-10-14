defmodule StudioSuperadmin.Utils do
  def model2map(data = %{}) do
    data
    |> Map.delete(:__struct__)
    |> Map.delete(:__meta__)
    |> Stream.filter(fn({_, v}) -> v != nil end)
    |> Enum.reduce(%{}, fn({k, v}, acc) -> Map.put(acc, k, model2map(v)) end)
  end
  def model2map(some), do: some
end
