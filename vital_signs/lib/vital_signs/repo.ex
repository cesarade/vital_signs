defmodule VitalSigns.Repo do
  use Ecto.Repo,
    otp_app: :vital_signs,
    adapter: Ecto.Adapters.Postgres
end
