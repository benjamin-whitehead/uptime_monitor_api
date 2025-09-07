defmodule Uptime.MonitorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Uptime.Monitors` context.
  """

  @doc """
  Generate a monitor.
  """
  def monitor_fixture(attrs \\ %{}) do
    {:ok, monitor} =
      attrs
      |> Enum.into(%{
        url: "some url"
      })
      |> Uptime.Monitors.create_monitor()

    monitor
  end
end
