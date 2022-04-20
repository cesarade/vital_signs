defmodule VitalSigns.Specialists.TypeSpecialist do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "type_specialists" do
    field :description, :string

    timestamps()
  end

  def changeset(type_specialist, params) do
    type_specialist
    |> cast(params, [:description])
    |> validate_required([:description])
    |> unique_constraint(:description)
  end

end
