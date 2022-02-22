defmodule VitalSigns.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :firt_name, :string, null: false
      add :last_name, :string, null: false
      add :genre, :string, null: false
      add :user_name, :string, null: false
      add :email, :string, null: false
      add :image_url, :string

      timestamps()
    end
    create unique_index(:clients, :email)
    create unique_index(:clients, :user_name)
  end
end
