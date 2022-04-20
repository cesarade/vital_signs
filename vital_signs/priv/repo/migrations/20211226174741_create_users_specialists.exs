defmodule VitalSigns.Repo.Migrations.CreateUsersSpecialists do
  use Ecto.Migration

  def change do
    create table(:clients_specialists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :pending_approval, :integer, default: 0
      add :specialist_id, references(:specialists, on_delete: :nothing, type: :uuid)
      add :client_id, references(:clients, on_delete: :nothing, type: :uuid)

      timestamps()
    end
    create index(:clients_specialists, :specialist_id)
    create index(:clients_specialists, :client_id)
    create unique_index(:clients_specialists, [:client_id, :specialist_id])
  end

end
