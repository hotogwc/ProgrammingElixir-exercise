defmodule MyString do
  def is_printable(string) do
    string
    |> Enum.map(&(&1 in 32..255))
    |> Enum.all?(&(&1 == true))
  end

  def anagram?(word1, word2) do
    Enum.sort(word1) == Enum.sort(word2)
  end


  def calculate(expression) do
    expression
    |> Enum.reject(&(&1 == (? )))
    |> Enum.chunk_by(&(&1 in '+-*/'))
    |> Enum.map(&(to_string(&1)))
    |> parse_and_calculate()
  end

  defp parse_and_calculate([num1, op, num2]) do
    number1 = String.to_integer(num1)
    number2 = String.to_integer(num2)
    case op do
      "+" -> number1 + number2
      "-" -> number1 - number2
      "*" -> number1 * number2
      "/" -> number1 / number2
      _ -> raise "illegal operation"
    end  
  end

  defp parse_and_calculate(explist) do
    raise "illegal expression"
  end

  def center(wordlist) do
    column_width = wordlist |> Enum.map(&(String.length(&1))) |> Enum.max

    wordlist
    |> Enum.map(&(String.duplicate(" ",div(column_width - String.length(&1), 2)) <> &1))
    |> Enum.each &IO.puts/1
  end

end
