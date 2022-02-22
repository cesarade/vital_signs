defmodule VitalSigns.Specialists.Client do
  use Ecto.Schema
  import Ecto.Changeset

  alias VitalSigns.Specialists.{Specialist, ClientSpecialist}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "clients" do
      field :firt_name, :string
      field :last_name, :string
      field :genre, :string
      field :user_name, :string
      field :email, :string
      field :image_url, :string

      many_to_many :specialists, Specialist, join_through: ClientSpecialist

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, [:firt_name, :last_name, :genre, :user_name, :email, :image_url])
    |> validate_required([:firt_name, :last_name, :genre, :user_name, :email, :image_url])
    |> validate_length(:firt_name, min: 3)
    |> validate_length(:last_name, min: 3)
    |> validate_length(:user_name, min: 3)
    |> unique_constraint(:user_name)
  end

end
