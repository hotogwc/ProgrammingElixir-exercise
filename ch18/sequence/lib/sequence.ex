defmodule Sequence do
  use Application

  def start(_type, initial_list) do
    import Supervisor.Spec, warn: false

    {:ok, _pid} = Sequence.Supervisor.start_link(initial_list)
  end
end
