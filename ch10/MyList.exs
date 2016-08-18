defmodule MyList do
  def flatten(list) do
    _flatten(list, [])
  end

  def _flatten([], acc), do: acc
  def _flatten([head | tail], acc) when is_list(head), do: _flatten(head, _flatten(tail, acc))
  def _flatten([head | tail], acc), do: [head | _flatten(tail, acc)]

  def span(from, to) when from == to, do: [from]
  def span(from, to), do: [from | span(from + 1, to)]

  def primes_up_to(n) do
    range = span(2, n)
    not_prime = for x <- range, y <- range, x <= y, x*y <= n, do: x*y
    range -- not_prime
  end

  def add_taxes(taxrates, orders) do
    orders |> Enum.map(&_add_total(&1, taxrates))
  end

  defp _add_total(order = [id: _, ship_to: state, net_amount: net], taxrates) do
    tax_rate = Keyword.get(taxrates, state, 0)
    totaltax = net * (1 + tax_rate)
    Keyword.merge(order, [total_amount: totaltax])
  end
end
