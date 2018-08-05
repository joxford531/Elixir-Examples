defmodule Boss do
  def start() do
    Supervisor.start_link([Worker, GenWorker], strategy: :one_for_one)
  end
end
