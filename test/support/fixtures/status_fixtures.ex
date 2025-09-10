defmodule Uptime.StatusFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Uptime.Status` context.
  """

  @doc """
  Generate a monitor_status.
  """
  def monitor_status_fixture(attrs \\ %{}) do
    {:ok, monitor_status} =
      attrs
      |> Enum.into(%{
        status: "some status"
      })
      |> Uptime.Status.create_monitor_status()

    monitor_status
  end
end
