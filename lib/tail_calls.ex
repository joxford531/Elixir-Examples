defmodule ListHelper do
  def sum(list), do: do_sum(0, list)

  defp do_sum(current_sum, []), do: current_sum

  defp do_sum(current_sum, [head | tail]) do
    new_sum = head + current_sum
    do_sum(new_sum, tail)
  end

  def summer(num), do: do_summer(0, 0, num)

  defp do_summer(current_num, current_sum, max) when current_num <= max do
    new_sum = current_sum + current_num
    do_summer(current_num + 1, new_sum, max)
  end

  defp do_summer(_, current_sum, _), do: current_sum

  def remove_email([head | tail], :email), do: removeatts([head | tail], :email)

  defp removeatts([], attr), do: []

  defp removeatts([head | tail], attr) do
    head = Map.delete(head, attr)
    [head | removeatts(tail, attr)]
  end

  def list_len(list), do: count_list(0, list)

  defp count_list(counter, []), do: counter

  defp count_list(counter, [head | tail]) do
    counter = counter + 1;
    count_list(counter, tail)
  end
end
