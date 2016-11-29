defmodule Spawn4 do
  def greet do
    receive do
      {sender, message} ->
        send sender, {:ok, "Hello, #{message}"}
        greet
    end
  end

end

pid = spawn(Spawn4, :greet, [])
send pid, {self, "World!"}

receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self, "fuck!"}

receive do
  {:ok, message} ->
    IO.puts message
  after 400 ->
    IO.puts "greeter has gone away"
end


