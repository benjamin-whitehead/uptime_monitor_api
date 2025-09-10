defmodule Uptime.Repo.Migrations.CreateMonitorStatus do
  use Ecto.Migration

  def change do
    create table(:monitor_status) do
      add :status, :string
      add :monitor_id, references(:monitors, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:monitor_status, [:monitor_id])
  end
end
