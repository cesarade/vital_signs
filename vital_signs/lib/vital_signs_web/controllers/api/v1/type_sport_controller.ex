defmodule VitalSignsWeb.API.V1.TypeSportController do
  use VitalSignsWeb, :controller

  alias VitalSigns.Sports
  alias VitalSignsWeb.TypeSportView

  def type_sports(conn, _params) do
    sports = Sports.type_sports()
    result = TypeSportView.render("type_sports.json", %{type_sports:  sports  })
    json(conn, %{data: %{type_sports: result.type_sports}})
  end


end
