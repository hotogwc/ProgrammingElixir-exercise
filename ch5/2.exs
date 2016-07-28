
fizzBuzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, _, c -> c
end


prefix = fn first -> (fn second -> first <> " " <> second end) end

IO.puts prefix.("Elixir").("Rocks")

               
