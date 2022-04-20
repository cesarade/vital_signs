defmodule VitalSigns.Specialists.ClientSpecialist do
  use Ecto.Schema
  import Ecto.Changeset

  alias VitalSigns.Specialists.{Client, Specialist}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "clients_specialists" do
    belongs_to :client, Client, type: :binary_id
    belongs_to :specialist, Specialist, type: :binary_id
    field :pending_approval, :integer, default: 0

    timestamps()
  end

  def changeset(user_specialist, params) do
    user_specialist
    |> cast(params, [:pending_approval, :client_id, :specialist_id])
    |> cast_assoc(:client)
    |> cast_assoc(:specialist)
    |> unique_constraint([:client_id, :specialist_id])
  end

end
