defmodule VitalSigns.Specialists do

  import Ecto.Query
  alias VitalSigns.Repo
  alias VitalSigns.Specialists.{Client, Specialist, ClientSpecialist}


  defp find_clients_by_specialist_query(email) do
    from c in Client,
    join: cs in ClientSpecialist, on: c.id == cs.client_id,
    join: s in Specialist, on: s.id == cs.specialist_id,
    where: s.email == ^email and cs.pending_approval != 0
  end

  defp find_pending_approval_clients_query(email) do
    from c in Client,
    join: cs in ClientSpecialist, on: c.id == cs.client_id,
    join: s in Specialist, on: s.id == cs.specialist_id,
    where: s.email == ^email and cs.pending_approval == 0
  end

  def get_client(email) do
    Repo.get_by(Client, email: email)
  end

  def get_specialist(email) do
    Repo.get_by(Specialist, email: email)
  end

  def find_clients_by_specialist(email) do
    result = find_clients_by_specialist_query(email)
    Repo.all(result)
  end

  def find_pending_approval_clients(email) do
    result = find_pending_approval_clients_query(email)
    Repo.all(result)
  end

  def pending_approval_by_specialist(params) do
    %ClientSpecialist{}
    |> ClientSpecialist.changeset(params)
    |> Repo.insert
  end

  def list_specialist() do
    Repo.all(Specialist)
  end

  def update_pending_approval_by_specialist(%ClientSpecialist{} = clientSpecialist, params) do
    clientSpecialist
    |> ClientSpecialist.changeset(params)
    |> Repo.update()
  end

  def find_specialist_client(specialist_id, client_id) do
    Repo.get_by(ClientSpecialist, specialist_id: specialist_id, client_id: client_id)
  end

end
