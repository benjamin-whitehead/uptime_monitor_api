defmodule Uptime.Monitors.Monitor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "monitors" do
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(monitor, attrs) do
    monitor
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
