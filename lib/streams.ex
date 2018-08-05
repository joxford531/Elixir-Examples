defmodule StreamTest do
  def print_index(list) when is_list(list) do
    list |> Stream.with_index |> 
    Enum.each(
      fn {employee, idx} -> IO.puts("#{idx + 1}. #{employee}") end
    )
  end
  def print_index(_), do: {:error, "Not a list"}

  def print_index_filter(list) when is_list(list) do
    Stream.filter(list, &(match?({:ok, _}, &1))) |>
    Stream.map(fn {result, name} -> {result, String.upcase(name)} end) |>
    Stream.with_index |>
    Enum.each(
      fn {{result, name}, index} -> 
        IO.puts("#{index + 1}. result: #{result}, name: #{name}")
      end
    )
  end
end