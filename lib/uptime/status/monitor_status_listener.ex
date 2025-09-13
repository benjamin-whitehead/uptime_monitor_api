defmodule Uptime.Status.MonitorStatusListener do
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(_args) do
    Phoenix.PubSub.subscribe(Uptime.PubSub, "monitor_status")
    Logger.info("monitor_status_listener: started")

    {:ok, %{}}
  end

  @impl true
  def handle_info({:monitor_down, monitor_id}, state) do
    Logger.emergency("monitor_status_listener: monitor #{monitor_id} down")
    {:noreply, state}
  end
end
