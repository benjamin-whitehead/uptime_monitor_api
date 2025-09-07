defmodule Uptime.Monitors.MonitorRunner do
  use GenServer
  require Logger

  def start_link(monitor) do
    GenServer.start_link(__MODULE__, monitor)
  end

  @impl true
  def init(_args) do
    Phoenix.PubSub.subscribe(Uptime.PubSub, "monitors")
    Logger.info("monitor_runner: started")

    {:ok, %{}}
  end

  @impl true
  def handle_info({:monitor_created, monitor}, state) do
    Logger.info("monitor_runner: received monitor_created: #{monitor.id}")

    {:noreply, state}
  end

  @impl true
  def handle_info(msg, state) do
    Logger.info("monitor_runner: received unknown message: #{inspect(msg)}")
    {:noreply, state}
  end
end
