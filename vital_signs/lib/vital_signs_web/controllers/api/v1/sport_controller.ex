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


  def get_rutine(conn, params) do
    routine = Sports.get_rutine(params["id"])
    result = RoutineView.render("routine.json", %{routine: routine})
    json(conn, %{data: %{routine: result}})
  end

  def start_routine(conn, params) do
    routine = Sports.get_rutine(params["id"])
    case Sports.update_start_date(routine, params) do
      {:ok, _routine} ->
        json(conn, %{data: %{status: 200, message: "The routine was started"}})

      {:error, %Ecto.Changeset{} = changeset} ->
          errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

          conn
          |> put_status(404)
          |> json(%{error: %{status: 404, message: "Couldn't update the routine", errors: errors}})
    end
  end

  def termine_routine(conn, params) do
    routine = Sports.get_rutine(params["id"])
    if routine != nil do
      case Sports.update_terminate_date(routine, params) do
        {:ok, _routine} ->
          json(conn, %{data: %{status: 200, message: "The routine was started"}})

        {:error, %Ecto.Changeset{} = changeset} ->
            errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

            conn
            |> put_status(404)
            |> json(%{error: %{status: 404, message: "Couldn't update the routine", errors: errors}})
      end

    else
      conn
      |> put_status(404)
      |> json(%{error: %{status: 404, message: "Not found routine"}})
    end

  end


end
