defmodule VitalSigns.Repo.Migrations.CreateRoutine do
  use Ecto.Migration

  def change do
    create table(:routines, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type_sport_id, references(:type_sports, on_delete: :nothing, type: :uuid)
      add :client_id, references(:clients, on_delete: :nothing, type: :uuid)
      add :specialist_id, references(:specialists, on_delete: :nothing, type: :uuid)
      add :init_date, :date
      add :terminate, :boolean
      add :details, :string
      timestamps()
    end
    create index(:tracking, [:client_id])
  end
end
