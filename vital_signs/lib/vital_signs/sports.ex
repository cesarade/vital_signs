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

  def get_routines_by_client_query(client_id) do
    from r in Routine,
    join: s in TypeSport, on: s.id == r.type_sport_id,
    where: r.client_id == ^client_id,
    order_by: [desc: :specialist_date],
    select: %Routine{
      id: r.id,
      type_sport_id: r.type_sport_id,
      sport: s.name,
      client_id: r.client_id,
      specialist_id: r.specialist_id,
      specialist_date: r.specialist_date,
      start_date: r.start_date,
      end_date: r.end_date,
      terminate: r.terminate,
      details: r.details
    }
  end

  def get_routines_by_client_query(client_id, terminate) do
    from r in Routine,
    join: s in TypeSport, on: s.id == r.type_sport_id,
    where: r.client_id == ^client_id and r.terminate == ^terminate,
    order_by: [desc: :specialist_date],
    select: %Routine{
      id: r.id,
      type_sport_id: r.type_sport_id,
      sport: s.name,
      client_id: r.client_id,
      specialist_id: r.specialist_id,
      specialist_date: r.specialist_date,
      start_date: r.start_date,
      end_date: r.end_date,
      terminate: r.terminate,
      details: r.details
    }
  end


  def get_rutine(id) do
    Repo.get(Routine, id)
  end

  def get_routines_by_client(client_id) do
    result = get_routines_by_client_query(client_id)
    Repo.all(result)
  end

  def get_routines_by_client(client_id, terminate) do
    result = get_routines_by_client_query(client_id, terminate)
    Repo.all(result)
  end


  def type_sports() do
    Repo.all(TypeSport)
  end


end
