defmodule VitalSigns.Repo.Migrations.CreateTypeSpecialists do
  use Ecto.Migration

  def change do
    create table(:type_specialists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :description, :string

      timestamps()
    end
    create unique_index(:type_specialists, :description)
  end
end
