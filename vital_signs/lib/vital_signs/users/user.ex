defmodule VitalSigns.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :role, :string, null: false, default: "user"
    field :status, :integer, virtual: true
    pow_user_fields()

    timestamps()
  end

  @spec changeset(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(user specialist))
    |> pow_changeset(attrs)
  end

end
