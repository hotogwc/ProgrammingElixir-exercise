defmodule MyEnum do
  def all?([], _expression), do: true
  def all?([head | tail], expression), do: expression.(head) && all?(tail, expression)

#┃ Enum.each(["some", "example"], fn(x) -> IO.puts x end)
#┃ "some"
#┃ "example"
#┃ #=> :ok

  def each([], _expression), do: :ok
  def each([head | tail], expression) do
    expression.(head)
    each(tail, expression)
  end

# “iex> Enum.filter(list, &(&1 > 2))
# ​ 	[3, 4, 5]”

  def filter([], _expression), do: []
  def filter([head | tail], expression) do
    if expression.(head) do
      [head | filter(tail, expression)]
    else
      filter(tail, expression)
    end
  end

#“iex> Enum.split(list, 3)
#​ 	{[1, 2, 3], [4, 5]}”

  def split([], _count), do: {[],[]}
  def split(list, count) when count >= 0, do: _split(list, count, [])

  def _split([head | tail], count, acc) when count > 0, do: _split(tail, count - 1, acc ++ [head])
  def _split(list, 0, acc), do: {acc, list}
  def _split([], _, acc), do: {acc, []}

  def take(list, count) do
    {result, _} = split(list, count)
    result
  end
    
end
