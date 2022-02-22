defmodule VitalSignsWeb.ClientChannel do
  use Phoenix.Channel

  alias VitalSigns.Trackings
  alias VitalSignsWeb.TrackingView

  def join("client:" <> _id, %{"specialist" => specialist} = _payload, socket) do
    {
      :ok,
      socket
      |> assign(:specialist, specialist)
    }
  end

  def handle_in("vital_signs", payload, socket) do

    vitals = Trackings.add_vital_signs(payload)

    VitalSignsWeb.Endpoint.broadcast(
      "specialist:#{socket.assigns.specialist}",
      "specialist",
      TrackingView.render("trackings.json", %{trackings: vitals})
    )

    {:noreply, socket}
  end

end
