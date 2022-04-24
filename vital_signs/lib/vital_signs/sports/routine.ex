defmodule VitalSigns.Sports.Routine do
  use Ecto.Schema
  import Ecto.Changeset

  alias VitalSigns.Specialists.Client
  alias VitalSigns.Specialists.Specialist
  alias VitalSigns.Sports.TypeSport

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "routines" do
    belongs_to :type_sport, TypeSport, type: :binary_id
    belongs_to :client, Client, type: :binary_id
    belongs_to :specialist, Specialist, type: :binary_id
    field :init_date, :utc_datetime
    field :terminate, :boolean
    field :details, :string

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:init_date, :terminate, :detail])
    |> validate_required([:init_date, :terminate, :detail])
    |> cast_assoc(:type_sport)
    |> cast_assoc(:client)
    |> cast_assoc(:specialist)
  end

end
