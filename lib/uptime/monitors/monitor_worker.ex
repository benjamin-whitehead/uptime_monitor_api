defmodule Uptime.Monitors.MonitorWorker do
  use GenServer
  require Logger

  alias Uptime.Monitors
  alias Uptime.Status

  @schedule_interval 60 * 1000

  def start_link(monitor_id) do
    Logger.debug("TEST")
    GenServer.start_link(__MODULE__, monitor_id)
  end

  def start(worker_pid) do
    GenServer.call(worker_pid, :start)
  end

  def stop(worker_pid) do
    GenServer.call(worker_pid, :stop)
  end

  def status(worker_pid) do
    GenServer.call(worker_pid, :status)
  end

  @impl true
  def init(monitor_id) do
    monitor = Monitors.get_monitor!(monitor_id)

    {:ok,
     %{
       "monitor_id" => monitor_id,
       "monitor_url" => monitor.url,
       "status" => :idle,
       "last_status" => nil,
       "timer" => nil
     }}
  end

  @impl true
  def handle_call(:start, _from, state) do
    timer = schedule(@schedule_interval)

    Logger.info("#{log_prefix(state)} starting monitor")
    {:reply, :ok, %{state | "status" => :started, "timer" => timer}}
  end

  @impl true
  def handle_call(:stop, _from, %{timer: timer} = state) do
    Process.cancel_timer(timer)

    Logger.info("#{log_prefix(state)} ending monitor")
    {:reply, :ok, %{state | "status" => :idle, "timer" => nil}}
  end

  @impl true
  def handle_call(:status, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:work, %{"monitor_url" => monitor_url, "monitor_id" => monitor_id} = state) do
    Logger.info("#{log_prefix(state)} doing work")

    status = ping_url(monitor_url)
    Status.add_status_for_monitor(status, monitor_id)

    timer = schedule(@schedule_interval)
    {:noreply, %{state | "timer" => timer, "last_status" => status}}
  end

  defp ping_url(monitor_url) do
    case HTTPoison.get(monitor_url) do
      {:ok, %{status_code: 200}} -> "up"
      _ -> "down"
    end
  end

  defp schedule(interval) do
    Process.send_after(self(), :work, interval)
  end

  defp log_prefix(%{"monitor_id" => monitor_id}) do
    "monitor_worker [#{monitor_id}]"
  end
end
