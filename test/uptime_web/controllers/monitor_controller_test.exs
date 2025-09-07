defmodule UptimeWeb.MonitorControllerTest do
  use UptimeWeb.ConnCase

  import Uptime.MonitorsFixtures
  alias Uptime.Monitors.Monitor

  @create_attrs %{
    url: "some url"
  }
  @update_attrs %{
    url: "some updated url"
  }
  @invalid_attrs %{url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all monitors", %{conn: conn} do
      conn = get(conn, ~p"/api/monitors")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create monitor" do
    test "renders monitor when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/monitors", monitor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/monitors/#{id}")

      assert %{
               "id" => ^id,
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/monitors", monitor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update monitor" do
    setup [:create_monitor]

    test "renders monitor when data is valid", %{conn: conn, monitor: %Monitor{id: id} = monitor} do
      conn = put(conn, ~p"/api/monitors/#{monitor}", monitor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/monitors/#{id}")

      assert %{
               "id" => ^id,
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, monitor: monitor} do
      conn = put(conn, ~p"/api/monitors/#{monitor}", monitor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete monitor" do
    setup [:create_monitor]

    test "deletes chosen monitor", %{conn: conn, monitor: monitor} do
      conn = delete(conn, ~p"/api/monitors/#{monitor}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/monitors/#{monitor}")
      end
    end
  end

  defp create_monitor(_) do
    monitor = monitor_fixture()

    %{monitor: monitor}
  end
end
