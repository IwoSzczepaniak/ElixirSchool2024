defmodule Exercises.Exercise4 do
  @doc """
   Spawn a new process, register it under :hello name,
   wait for :ping message and send a :timeout msg to :test process after 500ms.
   input: none
   returns: pid

  to test run in console:
    mix test --only test4
  """
  def send_timeout() do
    pid = spawn(fn ->
      Process.register(self(), :hello)
      receive do
        :ping ->
          Process.sleep(500)
          send(:test, :timeout)
      end
    end)
    send(pid, :ping)
    pid
  end
end
