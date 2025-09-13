defmodule Uptime.Monitors.MonitorRunner do
  use GenServer
  require Logger

  alias Uptime.Monitors.MonitorWorker
  alias Uptime.Monitors.Monitor
  alias Uptime.Monitors.MonitorSupervisor

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
  def handle_info({:monitor_created, %Monitor{id: monitor_id}}, state) do
    Logger.info("monitor_runner: received monitor_created: #{monitor_id}")

    {:ok, pid} = MonitorSupervisor.start_child(monitor_id)
    MonitorWorker.start(pid)

    {:noreply, state}
  end

  @impl true
  def handle_info(msg, state) do
    Logger.info("monitor_runner: received unknown message: #{inspect(msg)}")
    {:noreply, state}
  end
end
