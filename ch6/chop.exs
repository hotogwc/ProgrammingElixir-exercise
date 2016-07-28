defmodule Chop do

    
  def guess(actual, a..b) do
    guess_num = div(a + b, 2)
    IO.puts "Is it #{guess_num}"
    _guess(actual, a..b, guess_num)
  end

  defp _guess(actual, _range, guess_num) when actual == guess_num do
    IO.inspect guess_num
  end

  defp _guess(actual, a.._b, guess_num) when actual < guess_num do
    guess(actual, a..(guess_num - 1 ))
  end

  defp _guess(actual, _a..b, guess_num) when actual > guess_num do
    guess(actual, (guess_num + 1)..b)
  end
end
