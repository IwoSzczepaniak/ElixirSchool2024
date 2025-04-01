defmodule Exercises.Exercise3 do
  @doc """
   Spawn a new process, register it under :hello name, wait for :ping message and print it out.
   input: none
   returns: pid

  to test run in console:
    mix test --only test3.1
  """
  def wait_and_print() do
    pid = spawn(fn ->
      Process.register(self(), :hello)
      receive do
        :ping -> IO.inspect(:ping)
      end
    end)
    pid
  end

  @doc """
   Spawn a new process, register it under :hello name, wait for :ping message and print it out.
   Spawn another process and after 300ms send :shutdown signal to :hello process to terminate it.
   input: none
   returns: none

  to test run:
    mix test --only test3.2
  """
  def terminate_process() do
    spawn(fn ->
      Process.register(self(), :hello)
      receive do
        :ping -> IO.inspect(:ping)
      end
    end)
    spawn(fn ->
      Process.sleep(300)
      pid = Process.whereis(:hello)
      Process.exit(pid, :shutdown)
    end)
  end
end
