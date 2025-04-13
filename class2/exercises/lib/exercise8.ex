defmodule Exercises.Exercise8 do
  @doc """
   - Modify exercise7 by adding trap_exit to world process.
   - handle exit signal
    - send exit message to :test process
   - explain why :world process is alive or dead

   input: none
   returns: pid


  to test run in console:
     mix test --only test8
  """
  def process_link() do
    pid_hello =
      spawn(fn ->
        receive do
          :bad_msg -> raise("error")
          :die_normally -> :ok
        end
      end)

    Process.register(pid_hello, :hello)

    _world = spawn(fn ->
      Process.register(self(), :world)
      Process.flag(:trap_exit, true)
      Process.link(pid_hello)
      Process.sleep(1000)
      send(pid_hello, :bad_msg)

      receive do
        exit = {:EXIT, _pid, _reason} ->
          send(:test, exit)
      end

      receive do
        _msg -> :ok
      end
      end)

    unregistered = spawn(fn ->
      pid_world = Process.whereis(:world)
      Process.sleep(1500)

      if Process.alive?(pid_world) do
        send(:test, ":world is alive!")
      else
        send(:test, ":world is dead!")
      end
    end)

    unregistered
  end
end
