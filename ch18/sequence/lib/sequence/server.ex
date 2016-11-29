defmodule Sequence.Server do
  use GenServer

  @vsn "0"
  ####
  # External API

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(element) do
    GenServer.cast(__MODULE__, {:push, element})
  end

  def take(quantity) do
    GenServer.cast(__MODULE__, {:take, quantity})
  end

  #####
  # Handle Calls

  def init(stash_pid) do
    current_list = Sequence.Stash.get_value stash_pid
    {:ok, {current_list, stash_pid}}
  end

  def handle_call(:pop, _from, {[], stash_pid}) do
    {:reply, [], {[], stash_pid}}
  end

  def handle_call(:pop, _from, {[head | tail], stash_pid}) do
    {:reply, "the pop is #{inspect head}", {tail, stash_pid}}
  end

  def handle_cast({:push, new_element}, {list, stash_pid}) do
    {:noreply, {[new_element | list], stash_pid}}
  end

  def handle_cast({:take, quantity}, {list, stash_pid}) do
    {:noreply, {Enum.take(list, quantity), stash_pid}}
  end

  def terminate(_reason, {current_list, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_list
  end
end
