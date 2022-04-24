defmodule VitalSigns.Repo.Migrations.CreateTypeSport do
  use Ecto.Migration

  def change do
      create table(:type_sports, primary_key: false) do
        add :id, :uuid, primary_key: true
        add :name, :string

        timestamps()
      end
      create unique_index(:type_sports, :name)
  end

end
