defmodule VitalSignsWeb.TrackingView do
  use VitalSignsWeb, :view

  alias VitalSignsWeb.TrackingView

  def render("trackings.json", %{trackings: trackings}) do
    %{trackings: render_many(trackings, TrackingView, "tracking.json")}
  end

  def render("tracking.json", %{tracking: tracking}) do
    %{
      id: tracking.id,
      value: tracking.value,
      client_id: tracking.client_id,
      vital_sign_id: tracking.vital_sign_id,
      inserted_at: tracking.inserted_at,
      vital_sign_name: tracking.vital_sign_name || ""
    }
  end

end
