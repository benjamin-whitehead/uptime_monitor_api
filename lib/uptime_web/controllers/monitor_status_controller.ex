defmodule UptimeWeb.MonitorStatusController do
  use UptimeWeb, :controller

  alias Uptime.Status

  action_fallback UptimeWeb.FallbackController

  def show(conn, %{"monitor_id" => monitor_id}) do
    last_status = Status.get_last_status_for_monitor(monitor_id)
    render(conn, :show, status: last_status)
  end
end
