defmodule Exercises.Exercise6 do
  @doc """
   - Spawn a new process,
     - register it under :world name,
     - start monitoring :hello process by :world process,
     - after 1 second send :bad_msg to :hello process
     - wait for down msg from :hello process and send it to :test process
     - wait for next message
   - spawn a new unregistered process,
      - wait 1500ms
      - print ":world is alive!" if process :world is alive
      - print ":world is dead!" otherwise
   - explain why :world process is alive or dead
   input: none
   returns: pid


  to test run in console:
    mix test --only test6
  """
  def process_monitor() do
    _hello =
      spawn(fn ->
        Process.register(self(), :hello)

        receive do
          :bad_msg -> raise("error")
          :die_normally -> :ok
        end
      end)

    _world = spawn(fn ->
      Process.register(self(), :world)
      pid_hello = Process.whereis(:hello)
      Process.monitor(pid_hello)
      Process.sleep(1000)
      send(:hello, :bad_msg)
      receive do
        down_msg = {:DOWN, _ref, :process, _pid, _reason} ->
          send(:test, down_msg)
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

      receive do
        _msg -> :ok
      end
    end)

    unregistered
  end
end
