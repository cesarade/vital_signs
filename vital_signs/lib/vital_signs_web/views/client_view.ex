defmodule VitalSignsWeb.ClientView do
  use VitalSignsWeb, :view

  alias VitalSignsWeb.ClientView

  def render("clients.json", %{clients: clients}) do
    %{clients: render_many(clients, ClientView, "client.json")}
  end

  def render("client.json", %{client: client}) do
    %{
      id: client.id,
      firt_name: client.firt_name,
      last_name: client.last_name,
      genre: client.genre,
      user_name: client.user_name,
      email: client.email,
      image_url: client.image_url
    }
  end

end
