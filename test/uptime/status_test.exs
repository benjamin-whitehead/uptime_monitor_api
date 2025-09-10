defmodule Uptime.StatusTest do
  use Uptime.DataCase

  alias Uptime.Status

  describe "monitor_status" do
    alias Uptime.Status.MonitorStatus

    import Uptime.StatusFixtures

    @invalid_attrs %{status: nil}

    test "list_monitor_status/0 returns all monitor_status" do
      monitor_status = monitor_status_fixture()
      assert Status.list_monitor_status() == [monitor_status]
    end

    test "get_monitor_status!/1 returns the monitor_status with given id" do
      monitor_status = monitor_status_fixture()
      assert Status.get_monitor_status!(monitor_status.id) == monitor_status
    end

    test "create_monitor_status/1 with valid data creates a monitor_status" do
      valid_attrs = %{status: "some status"}

      assert {:ok, %MonitorStatus{} = monitor_status} = Status.create_monitor_status(valid_attrs)
      assert monitor_status.status == "some status"
    end

    test "create_monitor_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Status.create_monitor_status(@invalid_attrs)
    end

    test "update_monitor_status/2 with valid data updates the monitor_status" do
      monitor_status = monitor_status_fixture()
      update_attrs = %{status: "some updated status"}

      assert {:ok, %MonitorStatus{} = monitor_status} = Status.update_monitor_status(monitor_status, update_attrs)
      assert monitor_status.status == "some updated status"
    end

    test "update_monitor_status/2 with invalid data returns error changeset" do
      monitor_status = monitor_status_fixture()
      assert {:error, %Ecto.Changeset{}} = Status.update_monitor_status(monitor_status, @invalid_attrs)
      assert monitor_status == Status.get_monitor_status!(monitor_status.id)
    end

    test "delete_monitor_status/1 deletes the monitor_status" do
      monitor_status = monitor_status_fixture()
      assert {:ok, %MonitorStatus{}} = Status.delete_monitor_status(monitor_status)
      assert_raise Ecto.NoResultsError, fn -> Status.get_monitor_status!(monitor_status.id) end
    end

    test "change_monitor_status/1 returns a monitor_status changeset" do
      monitor_status = monitor_status_fixture()
      assert %Ecto.Changeset{} = Status.change_monitor_status(monitor_status)
    end
  end
end
