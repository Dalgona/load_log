defmodule LoadLog.Load do
  @moduledoc false

  @type data      :: {date_time, load_avg}
  @type date_time :: {date, time}
  @type date      :: {integer, integer, integer}
  @type time      :: {integer, integer, integer}
  @type load_avg  :: {number, number, number}

  @spec get() :: data
  def get(), do: {get_date, get_load}

  @spec get_date() :: date_time
  defp get_date(), do: :calendar.local_time

  @spec get_load() :: load_avg
  defp get_load() do
    [:avg1, :avg5, :avg15]
    |> Enum.map(&(apply(:cpu_sup, &1, []) / 256))
    |> List.to_tuple
  end
end
