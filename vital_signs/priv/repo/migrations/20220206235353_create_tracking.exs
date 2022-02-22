defmodule VitalSigns.Repo.Migrations.CreateTracking do
  use Ecto.Migration

  def change do
    create table(:tracking, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :value, :float
      add :client_id, references(:clients, on_delete: :nothing, type: :uuid)
      add :vital_sign_id, references(:vital_signs, on_delete: :nothing, type: :uuid)

      timestamps()
    end
    create index(:tracking, [:client_id, :inserted_at])
  end
end
