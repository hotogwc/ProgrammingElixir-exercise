defmodule Sequence.Stash do
  use GenServer

  def start_link(current_list) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_list)
  end

  def save_value(pid, value) do
    GenServer.cast pid, {:save_value, value}
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  ## GenServer implementation

  def handle_call(:get_value, _from, current_list) do
    {:reply, current_list, current_list}
  end

  def handle_cast({:save_value, value}, _current_list) do
    {:noreply, value}
  end
end 
