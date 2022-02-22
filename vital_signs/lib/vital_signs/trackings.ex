defmodule VitalSigns.Trackings do
  import Ecto.Query
  alias VitalSigns.Repo
  alias VitalSigns.VitalSigns.{Tracking, VitalSign}


  def add_vital_signs(payload) do
    calories = %{
      "client_id" => payload["clientId"],
      "vital_sign_id" => payload["caloriesId"],
      "value" => payload["calories"]
    }

    heartRate = %{
      "client_id" => payload["clientId"],
      "vital_sign_id" => payload["heartRateId"],
      "value" => payload["heartRate"]
    }

    steps = %{
      "client_id" => payload["clientId"],
      "vital_sign_id" => payload["stepsId"],
      "value" => payload["steps"]
    }

    {:ok, calories} = create_tracking(calories)
    {:ok, heartRate} = create_tracking(heartRate)
    {:ok, steps} = create_tracking(steps)

    [
      assign_vital_sign(calories),
      assign_vital_sign(heartRate),
      assign_vital_sign(steps)
    ]
  end

  def assign_vital_sign(sign) do
    result = vital_signs()[sign.vital_sign_id]
    %{sign | vital_sign_name: result.name}
  end

  def create_tracking(attrs \\ %{}) do
    %Tracking{}
    |> Tracking.changeset(attrs)
    |> Repo.insert()
  end

  defp get_tracking_by_client_date_query(client_id, first_date, last_date) do
    # "df206c29-bfd0-448d-940b-c7ca37617f20"
    ndt_f = NaiveDateTime.from_iso8601!(first_date <> " 00:00:01")
    ndt_l = NaiveDateTime.from_iso8601!(last_date <> " 23:59:01")

    from t in Tracking,
    join: v in VitalSign, on: v.id == t.vital_sign_id,
    where: t.client_id == ^client_id and t.inserted_at >= ^ndt_f and t.inserted_at <= ^ndt_l,
    order_by: [desc: :inserted_at],
    select: %Tracking{
      id: t.id,
      value: t.value,
      client_id: t.client_id,
      inserted_at: t.inserted_at,
      vital_sign_id: t.vital_sign_id,
      vital_sign_name: v.name
    }
  end

  def get_tracking_by_client_date(client_id, first_date, last_date) do
    result = get_tracking_by_client_date_query(client_id, first_date, last_date)
    Repo.all(result)
  end

  def get_vital_signs() do
    Repo.all(VitalSign)
  end

  defp vital_signs() do
    %{
      "899e6b2c-5fe7-4444-84ef-add3e28d7dc5" => %{name: "heartRate"},
      "8a1f0cd7-59d3-4dcd-9637-97344883c610" => %{name: "temperature"},
      "efc41bec-1ccf-4a3c-8d27-57076ff6174f" => %{name: "steps"},
      "83251a7c-4213-4227-9f9f-28eb6fab0ace" => %{name: "calories"},
      "0fbab19b-72e5-43c4-8c96-3989b15ff6f4" => %{name: "blood pressure"}
    }
  end

end
