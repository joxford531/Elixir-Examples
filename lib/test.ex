defmodule Test do
  alias IO, as: MyIO

  def test(x) when is_number(x) and x < 0, do: :negative

  def test(0), do: :zero

  def test(x) when is_number(x) and x > 0, do: :positive

  def smallest(list) when length(list) > 0, do: Enum.min(list)

  def smallest(_), do: {:error, :invalid_argument}

  def empty?([]), do: true

  def empty?([_|_]), do: false

  def range_match(1..n), do: 1..n

end
