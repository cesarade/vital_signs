defmodule VitalSigns.Repo.Migrations.CreateVitalSign do
  use Ecto.Migration

  def change do
    create table(:vital_signs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end
    create unique_index(:vital_signs, :name)
  end
end
