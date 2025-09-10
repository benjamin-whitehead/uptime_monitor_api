defmodule Uptime.Status.MonitorStatus do
  use Ecto.Schema
  import Ecto.Changeset

  schema "monitor_status" do
    field :status, :string
    field :monitor_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(monitor_status, attrs) do
    monitor_status
    |> cast(attrs, [:status, :monitor_id])
    |> validate_required([:status, :monitor_id])
  end
end
