defmodule SimpleRegistry do
  use GenServer
  @mod __MODULE__

  def start_link() do
    GenServer.start_link(@mod, %{}, name: @mod)
  end

  def init(state) do
    Process.flag(:trap_exit, true)
    {:ok, state}
  end

  def register(name) do
    GenServer.call(@mod, {:register, name})
  end

  def whereis(name) do
    GenServer.call(@mod, {:whereis, name})
  end

  def handle_call({:register, name}, {from, _}, state) do
    case Map.get(state, name) do
      nil ->
        Process.link(from)
        {:reply, :ok, Map.put(state, name, from)}
      _ -> {:reply, :error, state}
    end
  end

  def handle_call({:whereis, name}, _from, state) do
    {:reply, Map.get(state, name), state}
  end

  def handle_info({:EXIT, pid, _reason}, state) do
    state = Stream.filter(state, fn {_k, v} -> pid != v end)
    |> Enum.into(%{}, fn {k, v} -> {k, v} end)
    {:noreply, state}
  end

end
