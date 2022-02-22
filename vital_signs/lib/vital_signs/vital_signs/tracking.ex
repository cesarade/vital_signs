defmodule VitalSigns.VitalSigns.Tracking do
  use Ecto.Schema
  import Ecto.Changeset

  alias VitalSigns.Specialists.Client
  alias VitalSigns.VitalSigns.VitalSign

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "tracking" do
    field :value, :float, null: false
    belongs_to :client, Client, type: :binary_id
    belongs_to :vital_sign, VitalSign, type: :binary_id

    field :vital_sign_name, :string, virtual: true

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:value, :client_id, :vital_sign_id])
    |> validate_required([:value, :client_id, :vital_sign_id])
    |> cast_assoc(:client)
    |> cast_assoc(:vital_sign)
  end

end
