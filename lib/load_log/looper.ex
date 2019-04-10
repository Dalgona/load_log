defmodule LoadLog.Looper do
  @moduledoc false

  alias LoadLog.Data

  def start_link() do
    pid = spawn_link fn ->
      do_loop()
    end
    {:ok, pid}
  end

  defp do_loop() do
    Data.update()
    :timer.sleep(Application.get_env(:load_log, :interval))
    do_loop()
  end
end
