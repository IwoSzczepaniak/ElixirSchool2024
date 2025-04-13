defmodule MyApp.Application do
  use Application

  # =====EXERCISE 5=====
  @impl true
  def start(_type, _args) do
    children = [
      MyApp.Supervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
