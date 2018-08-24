defmodule SimpleRegistry do
  use GenServer
  @mod __MODULE__

  def start_link() do
    GenServer.start_link(@mod, %{}, name: @mod)
  end

  def init(process_registry) do
    Process.flag(:trap_exit, true)
    {:ok, process_registry}
  end

  def register(name) do
    GenServer.call(@mod, {:register, name})
  end

  def whereis(name) do
    GenServer.call(@mod, {:whereis, name})
  end

  def handle_call({:register, name}, {from, _}, process_registry) do
    case Map.get(process_registry, name) do
      nil ->
        Process.link(from)
        {:reply, :ok, Map.put(process_registry, name, from)}
      _ -> {:reply, :error, process_registry}
    end
  end

  def handle_call({:whereis, name}, _from, process_registry) do
    {:reply, Map.get(process_registry, name), process_registry}
  end

  def handle_info({:EXIT, pid, _reason}, process_registry) do
    {:noreply, deregister_pid(pid, process_registry)}
  end

  def handle_info(other, process_registry) do
    super(other, process_registry)
  end

  defp deregister_pid(pid, process_registry) do
    Stream.filter(process_registry, fn {_k, v} -> pid != v end)
    |> Enum.into(%{}, fn {k, v} -> {k, v} end)
  end

end
