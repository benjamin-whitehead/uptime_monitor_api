defmodule Uptime.Monitors.MonitorWorker do
  use GenServer
  require Logger

  @schedule_interval 60 * 1000

  def start_link(monitor_id) do
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
    {:ok,
     %{
       "monitor_id" => monitor_id,
       "status" => :idle,
       "timer" => nil
     }}
  end

  @impl true
  def handle_call(:start, _from, state) do
    timer = schedule(@schedule_interval)

    Logger.info("monitor_worker: starting monitor")
    {:reply, :ok, %{state | "status" => :started, "timer" => timer}}
  end

  @impl true
  def handle_call(:stop, _from, %{timer: timer} = state) do
    Process.cancel_timer(timer)

    Logger.info("monitor_worker: ending monitor")
    {:reply, :ok, %{state | "status" => :idle, "timer" => nil}}
  end

  @impl true
  def handle_call(:status, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:work, state) do
    Logger.info("monitor_worker: doing work")

    timer = schedule(@schedule_interval)
    {:noreply, %{state | "timer" => timer}}
  end

  defp schedule(interval) do
    Process.send_after(self(), :work, interval)
  end
end
