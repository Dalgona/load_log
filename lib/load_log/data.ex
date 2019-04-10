defmodule LoadLog.Data do
  @moduledoc """
  This module defines a generic server that holds and manipulates a list of
  load average data.
  """

  use GenServer

  alias LoadLog.Load

  # Client

  @doc """
  Starts `LoadLog.Data` GenServer and initialize the data with an empty list.
  """
  @spec start_link() :: {:ok, pid}
  def start_link() do
    GenServer.start_link(__MODULE__, %{data: [], count: 0}, name: __MODULE__)
  end

  @impl true
  def init(args) do
    {:ok, args}
  end

  @doc """
  Clears logged data.
  """
  @spec clear() :: :ok
  def clear() do
    GenServer.call(__MODULE__, :clear)
  end

  @doc """
  Appends the current load average data to the data list.

  If the number of data exceeds the upper limit specified in
  `config/config.exs`, the oldest data will be trimmed.
  """
  @spec update() :: :ok
  def update() do
    GenServer.call(__MODULE__, :update)
  end

  @doc """
  Returns a list of all load average data.
  """
  @spec all() :: [Load.data]
  def all() do
    GenServer.call(__MODULE__, :all)
  end

  # Server

  @doc false
  @spec handle_call(term, {pid, term}, term) :: {:reply, term, term}
  def handle_call(:clear, _from, _state) do
    {:reply, :ok, %{data: [], count: 0}}
  end

  @impl true
  def handle_call(:update, _from, %{data: data, count: count}) do
    [first|rest] = data ++ [Load.get()]
    if count == Application.get_env(:load_log, :max_items) do
      {:reply, :ok, %{data: rest, count: count}}
    else
      {:reply, :ok, %{data: [first|rest], count: count + 1}}
    end
  end

  @impl true
  def handle_call(:all, _from, state) do
    %{data: data} = state
    {:reply, data, state}
  end
end
