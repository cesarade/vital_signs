defmodule VitalSignsWeb.SpecialistChannel do
  use Phoenix.Channel

  def join("specialist:" <> _id, _payload, socket) do
    {:ok, socket}
  end

end
