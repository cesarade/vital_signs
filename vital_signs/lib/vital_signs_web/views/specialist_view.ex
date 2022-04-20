defmodule VitalSignsWeb.SpecialistView do
  use VitalSignsWeb, :view

  alias VitalSignsWeb.SpecialistView

  def render("specialists.json", %{specialists: specialists}) do
    %{specialists: render_many(specialists, SpecialistView, "specialist.json")}
  end

  def render("specialist.json", %{specialist: specialist}) do
    %{
      id: specialist.id,
      firt_name: specialist.firt_name,
      last_name: specialist.last_name,
      genre: specialist.genre,
      user_name: specialist.user_name,
      email: specialist.email,
      description: specialist.description,
      image_url: specialist.image_url
    }
  end

end
