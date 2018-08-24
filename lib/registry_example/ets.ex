defmodule EtsSimpleRegistry do
  use GenServer
  @mod __MODULE__

  def start_link() do
    GenServer.start_link(@mod, %{}, name: @mod)
  end

  def init(_) do
    Process.flag(:trap_exit, true)
    :ets.new(@mod, [:named_table, :public, write_concurrency: true])
    {:ok, nil}
  end

  def register(name) do
    Process.link(Process.whereis(@mod))
    case :ets.insert_new(@mod, {name, self()}) do
      true -> :ok
      false -> :error
    end
  end

  def whereis(name) do
    case :ets.lookup(@mod, name) do
      [{^name, value}] -> value
      [] -> nil
    end
  end

  def handle_info({:EXIT, pid, _reason}, state) do
    :ets.match_object(@mod, {:_, pid})
    |> Enum.each(fn {k, _v} -> :ets.delete(@mod, k) end)
    {:noreply, state}
  end

  def handle_info(other, state) do
    super(other, state)
  end

end
