defmodule Exercises.Exercise2 do
  @doc """
   Spawn a new process and register it under :hello name
   input: none
   returns: pid

  hint: take care of process lifetime

  to test run:
    mix test --only test2
  """
  def create_registered_process() do
    pid = spawn(fn ->
      Process.register(self(), :hello)
      Process.sleep(1000)
    end)
    pid
  end
end
