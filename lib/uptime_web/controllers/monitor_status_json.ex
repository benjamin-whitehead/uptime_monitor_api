defmodule UptimeWeb.MonitorStatusJSON do
  alias Uptime.Status.MonitorStatus

  @doc """
  Renders a single monitor_status.
  """
  def show(%{status: monitor_status}) do
    %{data: data(monitor_status)}
  end

  defp data(%MonitorStatus{status: status, inserted_at: inserted_at}) do
    %{
      status: status,
      inserted_at: inserted_at
    }
  end
end
