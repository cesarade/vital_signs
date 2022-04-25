defmodule VitalSignsWeb.API.V1.TrackingController do
  use VitalSignsWeb, :controller

  alias VitalSigns.Trackings
  alias VitalSignsWeb.TrackingView
  alias VitalSignsWeb.VitalSignView
  alias VitalSigns.Sports

  def get_vital_signs(conn, _params) do
    vital_signs = Trackings.get_vital_signs()
    result = VitalSignView.render("vital_signs.json", %{vital_signs: vital_signs})
    json(conn, %{data: %{vital_signs: result.vital_signs}})
  end

  def get_tracking_by_client_date_query(conn, params) do
    trackings = Trackings.get_tracking_by_client_date(params["client_id"], params["first_date"], params["last_date"])
    result = TrackingView.render("trackings.json", %{trackings:  trackings  })
    json(conn, %{data: %{trackings: result.trackings}})
  end

  def get_tracking_by_client_day_date(conn, params) do
    trackings = Trackings.get_tracking_by_client_day_date(params["client_id"], params["first_date"], params["last_date"])
    result = TrackingView.render("trackingems.json", %{trackings:  trackings  })
    json(conn, %{data: %{trackings: result.trackings}})
  end

  def get_tracking_by_routine_date(conn, params) do
    routine = Sports.get_rutine(params["id"])
    IO.inspect routine
    trackings = Trackings.get_tracking_by_routine_date(routine.client_id, routine.start_date, routine.end_date)
    result = TrackingView.render("trackings.json", %{trackings:  trackings  })
    json(conn, %{data: %{trackings: result.trackings}})
  end

end
