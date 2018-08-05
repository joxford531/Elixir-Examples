defmodule Worker do
  def start_link() do
    pid = spawn(fn -> Process.sleep(1_000_00) end)
    IO.puts("Starting Worker process - #{inspect(pid)}")
    {:ok, pid}
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker
    }
  end
end
