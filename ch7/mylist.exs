defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def reduce([], value, _), do: value
  def reduce([head | tail], value, func), do: reduce(tail, func.(head, value), func)

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def mapsum(list, func) do
    list
    |> map(func)
    |> reduce(0, &(&1 + &2))
  end

  def max([]), do: nil
  def max([head | tail]), do: _max(tail, head)

  defp _max([], current), do: current
  defp _max([head | tail], current) when head >= current, do: _max(tail, head)
  defp _max([head | tail], current) when head < current, do: _max(tail, current)

  def caesar([], _n), do: []
  def caesar([head | tail], n) when head + n <= ?z, do: [head + n | caesar(tail, n)]
  def caesar([head | tail], n) when head + n > ?z, do: [head + n - 26 | caesar(tail, n)]

  def span(from, to) when from == to, do: [from]
  def span(from, to), do: [from | span(from + 1, to)]
end

