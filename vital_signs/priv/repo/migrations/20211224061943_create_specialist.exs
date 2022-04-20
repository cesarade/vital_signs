defmodule VitalSigns.Repo.Migrations.CreateSpecialist do
  use Ecto.Migration

  def change do
    create table(:specialists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :firt_name, :string, null: false
      add :last_name, :string, null: false
      add :genre, :string, null: false
      add :user_name, :string, null: false
      add :email, :string, null: false
      add :description, :text, null: false
      add :image_url, :string
      add :type_specialist_id, references(:type_specialists, on_delete: :nothing, type: :uuid)

      timestamps()
    end
    create unique_index(:specialists, :email)
    create unique_index(:specialists, :user_name)
  end
end
