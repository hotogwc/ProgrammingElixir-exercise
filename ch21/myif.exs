defmodule My do
  defmacro if(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _                            -> unquote(do_clause)
      end
    end
  end

  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      My.if unquote(condition) do
        unquote(else_clause)
      else
        unquote(do_clause)
      end
    end
  end

  defmacro times_n(n) do
    name = :"times_#{n}"
    quote do
      def unquote(name)(x), do: x * unquote(n) 
    end
  end
end

defmodule Test do
  require My
  My.times_n(3)
end

IO.puts Test.times_3(4)
