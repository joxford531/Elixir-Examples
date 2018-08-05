defmodule KeyValueStore do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__) #register a singleton process
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def stop() do
    GenServer.call(__MODULE__, {:stop})
  end

  @impl true
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)} # async handler
  end

  @impl true
  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state} # synchronous handler
  end

  @impl true
  def handle_call({:stop}, _, _) do
    GenServer.stop(__MODULE__, :normal, 5000) # handle stop request
  end

end
