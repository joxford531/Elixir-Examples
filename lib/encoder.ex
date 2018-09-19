defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    do_encode("", 1, String.split(string, "", trim: true))
  end

  defp do_encode(acc, _sum, []), do: acc

  defp do_encode(acc, sum, [head | tail]) do
    if tail != [] && hd(tail) == head do
      sum = sum + 1
      do_encode(acc, sum, tail)
    else
      acc = acc <> encode_sum(head, sum)
      do_encode(acc, 1, tail)
    end
  end

  defp encode_sum(letter, count) do
    cond do
      count > 1 -> Integer.to_string(count) <> letter
      true -> letter
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    do_decode("", String.split(string, "", trim: true))
  end

  defp do_decode(acc, []), do: acc

  defp do_decode(acc, [head | tail]) do
    if tail != [] do
      acc = acc <> expander(head, hd(tail))
      do_decode(acc, tail)
    end
  end

  defp expander(char, letter) do
    case Integer.parse(char) do
      {num, _} -> Enum.into(1..num, "", fn _ -> letter end)
      :error -> letter
    end
  end
end
