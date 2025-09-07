defmodule UptimeWeb.MonitorController do
  use UptimeWeb, :controller

  alias Uptime.Monitors
  alias Uptime.Monitors.Monitor

  action_fallback UptimeWeb.FallbackController

  def index(conn, _params) do
    monitors = Monitors.list_monitors()
    render(conn, :index, monitors: monitors)
  end

  def create(conn, %{"monitor" => monitor_params}) do
    with {:ok, %Monitor{} = monitor} <- Monitors.create_monitor(monitor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/monitors/#{monitor}")
      |> render(:show, monitor: monitor)
    end
  end

  def show(conn, %{"id" => id}) do
    monitor = Monitors.get_monitor!(id)
    render(conn, :show, monitor: monitor)
  end

  def update(conn, %{"id" => id, "monitor" => monitor_params}) do
    monitor = Monitors.get_monitor!(id)

    with {:ok, %Monitor{} = monitor} <- Monitors.update_monitor(monitor, monitor_params) do
      render(conn, :show, monitor: monitor)
    end
  end

  def delete(conn, %{"id" => id}) do
    monitor = Monitors.get_monitor!(id)

    with {:ok, %Monitor{}} <- Monitors.delete_monitor(monitor) do
      send_resp(conn, :no_content, "")
    end
  end
end
