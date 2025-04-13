defmodule Exercises.Exercise9 do
  @doc """
   Spawn :server process, which endlessly handles messages.
   Sever should pass messages to :test process.
   When server gets exit singal, then it should send :handle_exit message to :test process.
   Server should send :nothing_todo message to :test process after 500ms inactivity.
   Spawn unregistered client process which sends to server 10 messages


  to test run in console:
    mix test --only test9
  """
  def server() do
    spawn(fn -> server_loop() end)
  end

  defp server_loop() do
    Process.flag(:trap_exit, true)

    if Process.whereis(:server) == nil do
      Process.register(self(), :server)
    end

    receive do
      {:EXIT, _from, _reason} ->
        send(:test, :handle_exit)
        server_loop()

      message ->
        send(:test, message)
        server_loop()
    after
      500 ->
        send(:test, :nothing_todo)
        server_loop()
    end
  end

  def client() do
    pid =
      spawn(fn ->
        Enum.each(1..10, fn _ -> send(:server, :nothing_todo) end)
      end)
  end
end
