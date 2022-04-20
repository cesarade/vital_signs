defmodule VitalSignsWeb.API.V1.SessionController do
  use VitalSignsWeb, :controller

  alias VitalSignsWeb.APIAuthPlug
  alias Plug.Conn

  alias VitalSignsWeb.ClientView
  alias VitalSignsWeb.SpecialistView
  alias VitalSigns.Specialists

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, %{"user" => user_params}) do
    conn
    |> Pow.Plug.authenticate_user(user_params)
    |> case do
      {:ok, %{assigns: %{current_user: current_user}} = conn} ->

        if current_user.role == "specialist" do
          specialist = Specialists.get_specialist(user_params["email"])
          result_sp = SpecialistView.render("specialist.json", %{specialist: specialist})

          clients = Specialists.find_clients_by_specialist(user_params["email"])
          result = ClientView.render("clients.json", %{clients: clients})

          json(conn, %{data: %{specialist: result_sp, clients: result.clients,access_token: conn.private.api_access_token, renewal_token: conn.private.api_renewal_token}})
        else
          client = Specialists.get_client(user_params["email"])
          result = ClientView.render("client.json", %{client: client})

          json(conn, %{data: %{client: result, access_token: conn.private.api_access_token, renewal_token: conn.private.api_renewal_token}})
        end

      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end

  @spec renew(Conn.t(), map()) :: Conn.t()
  def renew(conn, _params) do
    config = Pow.Plug.fetch_config(conn)

    conn
    |> APIAuthPlug.renew(config)
    |> case do
      {conn, nil} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid token"}})

      {conn, _user} ->
        json(conn, %{data: %{access_token: conn.private.api_access_token, renewal_token: conn.private.api_renewal_token}})
    end
  end

  @spec delete(Conn.t(), map()) :: Conn.t()
  def delete(conn, _params) do
    conn
    |> Pow.Plug.delete()
    |> json(%{data: %{}})
  end
end
