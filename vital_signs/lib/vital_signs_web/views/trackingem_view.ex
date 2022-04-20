defmodule VitalSignsWeb.TrackingEmView do
  use VitalSignsWeb, :view

  alias VitalSignsWeb.TrackingEmView

  def render("trackingems.json", %{trackings: trackings}) do

    %{trackings: render_many(trackings, TrackingEmView, "trackingem.json")}
  end

  def render("trackingem.json", %{tracking: tracking}) do
    IO.puts("___________________")
    IO.inspect(tracking)
    %{
      vital_sign_id: tracking.vital_sign_id,
      vital_sign: tracking.vital_sign,
      date: tracking.date,
      value: tracking.value
    }
  end

end
