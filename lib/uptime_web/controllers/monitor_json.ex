defmodule UptimeWeb.MonitorJSON do
  alias Uptime.Monitors.Monitor

  @doc """
  Renders a list of monitors.
  """
  def index(%{monitors: monitors}) do
    %{data: for(monitor <- monitors, do: data(monitor))}
  end

  @doc """
  Renders a single monitor.
  """
  def show(%{monitor: monitor}) do
    %{data: data(monitor)}
  end

  defp data(%Monitor{} = monitor) do
    %{
      id: monitor.id,
      url: monitor.url
    }
  end
end
