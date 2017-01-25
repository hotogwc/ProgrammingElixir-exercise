defmodule My do
  defmacro macro(param) do
    quote do: IO.inspect unquote(param)
  end
end

defmodule Test do
  require My
  My.macro(IO.puts("hello"))
end
