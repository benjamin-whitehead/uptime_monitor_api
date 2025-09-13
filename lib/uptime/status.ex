defmodule Uptime.Status do
  @moduledoc """
  The Status context.
  """

  import Ecto.Query, warn: false
  alias Uptime.Repo

  alias Uptime.Status.MonitorStatus

  def add_status_for_monitor(status, monitor_id) do
    create_monitor_status(%{status: status, monitor_id: monitor_id})
  end

  @doc """
  Get's the last status for a given monitor_id.
  """
  def get_last_status_for_monitor(monitor_id) do
    MonitorStatus
    |> where([m], m.monitor_id == ^monitor_id)
    |> order_by([h], desc: h.id)
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Returns the list of monitor_status.

  ## Examples

      iex> list_monitor_status()
      [%MonitorStatus{}, ...]

  """
  def list_monitor_status do
    Repo.all(MonitorStatus)
  end

  @doc """
  Gets a single monitor_status.

  Raises `Ecto.NoResultsError` if the Monitor status does not exist.

  ## Examples

      iex> get_monitor_status!(123)
      %MonitorStatus{}

      iex> get_monitor_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_monitor_status!(id), do: Repo.get!(MonitorStatus, id)

  @doc """
  Creates a monitor_status.

  ## Examples

      iex> create_monitor_status(%{field: value})
      {:ok, %MonitorStatus{}}

      iex> create_monitor_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_monitor_status(attrs) do
    %MonitorStatus{}
    |> MonitorStatus.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a monitor_status.

  ## Examples

      iex> update_monitor_status(monitor_status, %{field: new_value})
      {:ok, %MonitorStatus{}}

      iex> update_monitor_status(monitor_status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_monitor_status(%MonitorStatus{} = monitor_status, attrs) do
    monitor_status
    |> MonitorStatus.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a monitor_status.

  ## Examples

      iex> delete_monitor_status(monitor_status)
      {:ok, %MonitorStatus{}}

      iex> delete_monitor_status(monitor_status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_monitor_status(%MonitorStatus{} = monitor_status) do
    Repo.delete(monitor_status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking monitor_status changes.

  ## Examples

      iex> change_monitor_status(monitor_status)
      %Ecto.Changeset{data: %MonitorStatus{}}

  """
  def change_monitor_status(%MonitorStatus{} = monitor_status, attrs \\ %{}) do
    MonitorStatus.changeset(monitor_status, attrs)
  end
end
