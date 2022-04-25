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
    field :specialist_date, :date
    field :start_date, :utc_datetime, default: nil
    field :end_date, :utc_datetime, default: nil
    field :terminate, :boolean
    field :details, :string

    field :sport, :string, virtual: true

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:specialist_date, :start_date, :end_date, :terminate, :details, :type_sport_id, :client_id, :specialist_id])
    |> validate_required([:specialist_date, :terminate, :details, :type_sport_id, :client_id, :specialist_id])
    |> cast_assoc(:type_sport)
    |> cast_assoc(:client)
    |> cast_assoc(:specialist)
    |> unique_constraint([:type_sport_id, :client_id, :specialist_id])
  end
end
