defmodule MultiProcesses do
  def run do
    receive do
      {sender, msg} ->
        send sender, {:ok, "token is #{msg}"}
    end
  end 
end

#not deterministic

pid1 = spawn(MultiProcesses, :run, [])
pid2 = spawn(MultiProcesses, :run, [])

send pid1, {self, "fred"}
send pid2, {self, "betty"}

receive do
  {:ok, msg} -> IO.puts msg
after 500 -> IO.puts "time out"
end

receive do
  {:ok, msg} -> IO.puts msg
after 500 -> IO.puts "time out"
end

#deterministic

pid3 = spawn(MultiProcesses, :run, [])
pid4 = spawn(MultiProcesses, :run, [])

send pid3, {self, "fred"}

receive do
  {:ok, msg} -> IO.puts "deterministic #{msg}"
  send pid4, {self, "betty"}
end

receive do
  {:ok, msg} -> IO.puts "deterministic #{msg}"
end
