defmodule MyApp.ShopInventory do
  use GenServer

  # =====EXERCISE 2=====
  # Client API
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def create_item(pid, item) do
    GenServer.cast(pid, {:create_item, item})
  end

  def list_items(pid) do
    GenServer.call(pid, :list_items)
  end

  def delete_item(pid, item) do
    GenServer.cast(pid, {:delete_item, item})
  end

  def get_item_by_name(pid, name) do
    GenServer.call(pid, {:get_item_by_name, name})
  end

  # =====EXERCISE 3=====
  def create_item(_item) do
    # Your code here
  end

  def list_items() do
    # Your code here
  end

  def delete_item(_item) do
    # Your code here
  end

  def get_item_by_name(_name) do
    # Your code here
  end

  # =====EXERCISE 1=====
  # Server API
  @impl true
  def init(items) do
    {:ok, items}
  end

  @impl true
  def handle_call(:list_items, _, state) do
    {:reply, state, state}
  end

  def handle_call({:get_item_by_name, name}, _, state) do
    item = Enum.find(state, fn item -> item.name == name end)
    {:reply, item, state}
  end

  @impl true
  def handle_cast({:create_item, item}, state) do
    {:noreply, [item | state]}
  end

  def handle_cast({:delete_item, item_to_delete}, state) do
    updated_state = Enum.reject(state, fn item -> item == item_to_delete end)
    {:noreply, updated_state}
  end

  # For supervisor testing
  def handle_cast(:crash, _state) do
    throw(:error)
  end
end
