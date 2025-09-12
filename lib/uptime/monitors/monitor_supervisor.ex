defmodule Uptime.Monitors.MonitorSupervisor do
  use DynamicSupervisor
  require Logger

  alias Uptime.Monitors.MonitorWorker
  alias Uptime.Monitors

  def start_link(init) do
    DynamicSupervisor.start_link(__MODULE__, init, name: __MODULE__)
  end

  def start_existing_monitors do
    Monitors.list_monitors()
    |> Enum.each(fn monitor ->
      case start_child(monitor.id) do
        {:ok, _pid} ->
          Logger.info("monitor_supervisor: started worker for monitor #{monitor.id}")

        {:error, reason} ->
          Logger.error(
            "monitor_supervisor: failed to start worker for monitor #{monitor.id} because #{inspect(reason)}"
          )
      end
    end)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(monitor_id) do
    DynamicSupervisor.start_child(__MODULE__, {MonitorWorker, monitor_id})
  end
end
