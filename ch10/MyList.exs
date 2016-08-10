defmodule MyList do
  def flatten(list) do
    _flatten(list, [])
  end

  def _flatten([], acc), do: acc
  def _flatten([head | tail], acc) when is_list(head), do: _flatten(head, acc) ++ _flatten(tail, acc) ++ acc
  def _flatten([head | tail], acc), do: [head] ++ _flatten(tail, acc) ++ acc
end
