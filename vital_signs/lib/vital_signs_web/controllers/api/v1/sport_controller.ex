defmodule VitalSignsWeb.API.V1.SportController do
  use VitalSignsWeb, :controller

  alias Ecto.Changeset
  alias VitalSignsWeb.ErrorHelpers

  alias VitalSigns.Sports


  def create(conn, params) do
    case Sports.create_routine(params) do
      {:ok, _rountine} ->
        json(conn, %{data: %{status: 200, message: "The routine was saved"}})

      {:error, %Ecto.Changeset{} = changeset} ->
          errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

          conn
          |> put_status(500)
          |> json(%{error: %{status: 500, message: "Couldn't create the solicitude", errors: errors}})
    end
  end

  

end
