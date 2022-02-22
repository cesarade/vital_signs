defmodule VitalSignsWeb.API.V1.TrackingController do
  use VitalSignsWeb, :controller

  alias VitalSigns.Trackings
  alias VitalSignsWeb.TrackingView
  alias VitalSignsWeb.VitalSignView

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

end
