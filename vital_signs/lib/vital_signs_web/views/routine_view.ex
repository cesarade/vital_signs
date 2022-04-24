defmodule VitalSignsWeb.RoutineView do
  use VitalSignsWeb, :view

  alias VitalSignsWeb.RoutineView

  def render("routines.json", %{routines: routines}) do
    %{routines: render_many(routines, RoutineView, "routine.json")}
  end

  def render("routine.json", %{routine: routine}) do
    %{
      id: routine.id,
      type_sport_id: routine.type_sport_id,
      sport: routine.sport,
      client_id: routine.client_id,
      specialist_id: routine.specialist_id,
      init_date: routine.init_date,
      terminate: routine.terminate,
      details: routine.details
    }
  end

end
