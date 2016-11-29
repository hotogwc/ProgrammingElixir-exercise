defmodule Exercise345 do
  import :timer, only: [sleep: 1]
  def response3 do
    send self, "hello"
    exit(:boom)
  end

  def response4 do
    send self, "hello"
    raise "error"
  end

  def exercise do
    spawn_monitor(Exercise345, :response3, [])

    sleep 500
    receive do
      msg -> IO.puts inspect msg
    end
  
  end
end
