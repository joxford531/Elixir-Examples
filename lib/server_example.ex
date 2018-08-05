defmodule Example.Gen do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil)
  end

  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  def crash(pid) do
    GenServer.call(pid, {:crash})
  end

  @impl GenServer
  def handle_call({:crash}, _, state) do
    spawn_link(fn -> throw("error") end)

    {:reply, :foo, state}
  end
end
