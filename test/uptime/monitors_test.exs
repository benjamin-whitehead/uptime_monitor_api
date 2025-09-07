defmodule Uptime.MonitorsTest do
  use Uptime.DataCase

  alias Uptime.Monitors

  describe "monitors" do
    alias Uptime.Monitors.Monitor

    import Uptime.MonitorsFixtures

    @invalid_attrs %{url: nil}

    test "list_monitors/0 returns all monitors" do
      monitor = monitor_fixture()
      assert Monitors.list_monitors() == [monitor]
    end

    test "get_monitor!/1 returns the monitor with given id" do
      monitor = monitor_fixture()
      assert Monitors.get_monitor!(monitor.id) == monitor
    end

    test "create_monitor/1 with valid data creates a monitor" do
      valid_attrs = %{url: "some url"}

      assert {:ok, %Monitor{} = monitor} = Monitors.create_monitor(valid_attrs)
      assert monitor.url == "some url"
    end

    test "create_monitor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitors.create_monitor(@invalid_attrs)
    end

    test "update_monitor/2 with valid data updates the monitor" do
      monitor = monitor_fixture()
      update_attrs = %{url: "some updated url"}

      assert {:ok, %Monitor{} = monitor} = Monitors.update_monitor(monitor, update_attrs)
      assert monitor.url == "some updated url"
    end

    test "update_monitor/2 with invalid data returns error changeset" do
      monitor = monitor_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitors.update_monitor(monitor, @invalid_attrs)
      assert monitor == Monitors.get_monitor!(monitor.id)
    end

    test "delete_monitor/1 deletes the monitor" do
      monitor = monitor_fixture()
      assert {:ok, %Monitor{}} = Monitors.delete_monitor(monitor)
      assert_raise Ecto.NoResultsError, fn -> Monitors.get_monitor!(monitor.id) end
    end

    test "change_monitor/1 returns a monitor changeset" do
      monitor = monitor_fixture()
      assert %Ecto.Changeset{} = Monitors.change_monitor(monitor)
    end
  end
end
