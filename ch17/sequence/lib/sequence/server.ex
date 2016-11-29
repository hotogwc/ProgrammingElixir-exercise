defmodule Sequence.Server do
  use GenServer

  ####
  # External API

  def start_link(current_list) do
    GenServer.start_link(__MODULE__, current_list, name: __MODULE__)
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

  def handle_call(:pop, _from, []) do
    {:reply, [], []}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, new_element}, list) do
    {:noreply, [new_element | list]}
  end

  def handle_cast({:take, quantity}, list) do
    {:noreply, Enum.take(list, quantity)}
  end
end
