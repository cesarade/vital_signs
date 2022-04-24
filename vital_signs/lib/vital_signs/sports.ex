defmodule VitalSigns.Sports do
  import Ecto.Query
  alias VitalSigns.Repo

  alias VitalSigns.Sports.TypeSport


  def type_sports() do
    Repo.all(TypeSport)
  end


end
