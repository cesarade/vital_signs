defmodule VitalSigns.Sports do
  import Ecto.Query
  alias VitalSigns.Repo

  alias VitalSigns.Sports.TypeSport
  alias VitalSigns.Sports.Routine


  def create_routine(attrs \\ %{}) do
    %Routine{}
    |> Routine.changeset(attrs)
    |> Repo.insert()
  end


  def type_sports() do
    Repo.all(TypeSport)
  end


end
