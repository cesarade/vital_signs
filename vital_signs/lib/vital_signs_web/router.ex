defmodule VitalSignsWeb.Router do
  use VitalSignsWeb, :router

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  # scope "/api", VitalSignsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).


  pipeline :api do
    plug :accepts, ["json"]
    plug VitalSignsWeb.APIAuthPlug, otp_app: :vital_signs
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: VitalSignsWeb.APIAuthErrorHandler
  end

  # ...

  scope "/api/v1", VitalSignsWeb.API.V1, as: :api_v1 do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end

  scope "/api/v1", VitalSignsWeb.API.V1, as: :api_v1 do
    pipe_through [:api, :api_protected]


    get "/trackings/get_tracking_by_client_avg_date_query", TrackingController, :get_tracking_by_client_day_date
    get "/trackings/get_tracking_by_client_date_query", TrackingController, :get_tracking_by_client_date_query
    get "/trackings/vital_signs", TrackingController, :get_vital_signs

    # Your protected API endpoints here

    get "/specialists/find_clients_by_specialist", SpecialistController, :find_clients_by_specialist
    get "/specialists/find_pending_approval_clients", SpecialistController, :find_pending_approval_clients
    post "/specialists/pending_approval_by_specialist", SpecialistController, :pending_approval_by_specialist
    post "/specialists/update_pending_approval_by_specialist", SpecialistController, :update_pending_approval_by_specialist
    get "/specialists", SpecialistController, :list_specialist
  end



  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: VitalSignsWeb.Telemetry
    end
  end
end
