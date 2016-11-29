defmodule Ticker do
  @interval 2000 #2 seconds
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end
  
  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        send pid, {:clients, [pid | clients]}
        generator([pid | clients])
    end
  end
end


defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:clients, clients} ->
        IO.puts "update clients"
        clients
        |> Enum.filter(&(&1 != self))
        |> Enum.take(1)
        |> send_msg
        receiver
      {:message, msg} -> IO.puts msg
    end
  end

  def send_msg([]) do
    IO.puts "no new client except self"
  end

  def send_msg(clients) do
    send hd(clients), {:message, "Hello, I'm #{inspect self}, you are?"}
  end
end
