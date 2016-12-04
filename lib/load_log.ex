defmodule LoadLog do
  @moduledoc """
  This module defines LoadLog application.

  LoadLog is a simple OTP application that records CPU load average data.

  ## Configuration

  You can customize some settings by modifying `config/config.exs` file:

  ```
  config :load_log, max_items: 1440
  config :load_log, interval: 60000
  ```

  * `max_items`

      The maximum number of items this application can hold. If the number of
      logged data exceeds this upper limit, the oldest data will be trimmed.

  * `interval`

      A peroid of time between each data in milliseconds.
  """

  use Application

  alias LoadLog.Data
  alias LoadLog.Looper

  @doc """
  Starts the `LoadLog` application.
  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Data, []),
      worker(Looper, [])
    ]

    opts = [strategy: :one_for_one, name: LoadLog.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
