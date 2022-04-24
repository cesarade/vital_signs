defmodule VitalSignsWeb.TypeSportView do
  use VitalSignsWeb, :view

  alias VitalSignsWeb.TypeSportView

  def render("type_sports.json", %{type_sports: type_sports}) do
    %{type_sports: render_many(type_sports, TypeSportView, "type_sport.json")}
  end

  def render("type_sport.json", %{type_sport: type_sport}) do
    %{
      id: type_sport.id,
      name: type_sport.name
    }
  end

end
