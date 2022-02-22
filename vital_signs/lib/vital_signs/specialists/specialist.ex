defmodule VitalSigns.Specialists.Specialist do
  use Ecto.Schema
  import Ecto.Changeset

  alias VitalSigns.Specialists.{TypeSpecialist, Client, ClientSpecialist}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "specialists" do
      field :firt_name, :string
      field :last_name, :string
      field :genre, :string
      field :user_name, :string
      field :email, :string
      field :description, :string, default: ""
      field :image_url, :string

      belongs_to :type_specialist, TypeSpecialist, type: :binary_id
      many_to_many :clients, Client, join_through: ClientSpecialist

      timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, [:firt_name, :last_name, :genre, :user_name, :email, :description, :image_url, :password])
    # |> cast_assoc(:type_specialist)
    |> validate_required([:firt_name, :last_name, :genre, :user_name, :email, :description, :password])
    |> validate_length(:firt_name, min: 3)
    |> validate_length(:last_name, min: 3)
    |> validate_length(:user_name, min: 3)
    |> unique_constraint(:user_name)
  end

end
