defmodule VitalSignsWeb.API.V1.SportController do
  use VitalSignsWeb, :controller

  alias Ecto.Changeset
  alias VitalSignsWeb.ErrorHelpers

  alias VitalSigns.Sports
  alias VitalSignsWeb.RoutineView


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

  def list_routines(conn, params) do
    routines = Sports.get_routines_by_client(params["client_id"])
    result = RoutineView.render("routines.json", %{routines: routines})
    json(conn, %{data: %{routines: result.routines}})
  end

  def list_routines_terminate(conn, params) do
    routines = Sports.get_routines_by_client(params["client_id"], params["terminate"])
    result = RoutineView.render("routines.json", %{routines: routines})
    json(conn, %{data: %{routines: result.routines}})
  end

end
