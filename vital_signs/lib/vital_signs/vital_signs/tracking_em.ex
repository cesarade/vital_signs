defmodule VitalSigns.VitalSigns.TrackingEm do
  use Ecto.Schema

  embedded_schema do
    field :vital_sign_id, :binary_id
    field :vital_sign, :string
    field :date, :utc_datetime
    field :value, :decimal
  end

end
