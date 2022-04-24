defmodule VitalSigns.Sports.TypeSport do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "type_sports" do
    field :name, :string, null: false
    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

end
