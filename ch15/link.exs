defmodule Link3 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Link3, :sad_function, [])
    case res do
      {_, ref} -> IO.puts inspect ref
    end
    receive do
      msg -> IO.puts "msg received: #{inspect msg}"
    after 1000 -> IO.puts "Nothing happend"
    end
  end
end
