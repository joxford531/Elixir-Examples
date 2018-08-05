defmodule GenWorker do
  use GenServer
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    IO.puts("Starting GenWorker process - #{inspect(self())}")
    {:ok, state}
  end

  # def child_spec(_) do
  #   %{
  #     id: __MODULE__,
  #     start: {__MODULE__, :start_link, []},
  #     type: :worker
  #   }
  # end
end
