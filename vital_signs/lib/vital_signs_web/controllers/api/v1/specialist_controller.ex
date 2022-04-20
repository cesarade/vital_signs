defmodule VitalSignsWeb.API.V1.SpecialistController do
  use VitalSignsWeb, :controller

  alias VitalSignsWeb.ErrorHelpers
  alias Ecto.Changeset

  alias VitalSigns.Specialists

  alias VitalSignsWeb.ClientView
  alias VitalSignsWeb.SpecialistView


  def find_clients_by_specialist(%{assigns: %{current_user: current_user}} = conn, _params) do
    clients = Specialists.find_clients_by_specialist(current_user.email)
    result = ClientView.render("clients.json", %{clients: clients})
    json(conn, %{data: %{clients: result.clients}})
  end

  def find_pending_approval_clients(%{assigns: %{current_user: current_user}} = conn, _params) do
    clients = Specialists.find_pending_approval_clients(current_user.email)
    result = ClientView.render("clients.json", %{clients: clients})
    json(conn, %{data: %{clients: result.clients}})
  end

  def pending_approval_by_specialist(conn, params) do
    case Specialists.pending_approval_by_specialist(params) do
      {:ok, _specialist} ->
        json(conn, %{data: %{status: 200, message: "The solicitude is pending approval by specialist"}})

      {:error, %Ecto.Changeset{} = changeset} ->
          errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

          conn
          |> put_status(404)
          |> json(%{error: %{status: 404, message: "Couldn't create the solicitude", errors: errors}})
    end
  end

  def list_specialist(conn, _params) do
     result = SpecialistView.render("specialists.json", %{specialists: Specialists.list_specialist()})
    json(conn, %{data: %{specialists: result.specialists}})
  end

  def update_pending_approval_by_specialist(conn, params) do
    specialist_client = Specialists.find_specialist_client(params["specialist_id"], params["client_id"])
    case Specialists.update_pending_approval_by_specialist(specialist_client, params) do
      {:ok, _specialist} ->
        json(conn, %{data: %{status: 200, message: "The solicitude was approved by specialist"}})

      {:error, %Ecto.Changeset{} = changeset} ->
          errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

          conn
          |> put_status(404)
          |> json(%{error: %{status: 404, message: "Couldn't approved the solicitude", errors: errors}})
    end
  end



end
