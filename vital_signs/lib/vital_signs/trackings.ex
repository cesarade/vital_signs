defmodule VitalSigns.Trackings do
  # use Ecto.Repo
  import Ecto.Query
  alias VitalSigns.Repo
  alias VitalSigns.VitalSigns.{Tracking, VitalSign, TrackingEm}


  # def execute_and_load(sql, params, model) do
  #   Ecto.Adapters.SQL.query!(__MODULE__, sql, params)
  #   |> load_into(model)
  # end

  # defp load_into(response, model) do
  #   Enum.map response.rows, fn(row) ->
  #     fields = Enum.reduce(Enum.zip(response.columns, row), %{}, fn({key, value}, map) ->
  #       Map.put(map, key, value)
  #     end)

  #     Ecto.Schema.__load__(model, nil, nil, [], fields, &__MODULE__.__adapter__.load/2)
  #   end
  # end

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

  defp get_tracking_by_routine_date_query(client_id, first_date, last_date) do
    from t in Tracking,
    join: v in VitalSign, on: v.id == t.vital_sign_id,
    where: t.client_id == ^client_id and t.inserted_at >= ^first_date and t.inserted_at <= ^last_date,
    order_by: [asc: :inserted_at],
    select: %Tracking{
      id: t.id,
      value: t.value,
      client_id: t.client_id,
      inserted_at: t.inserted_at,
      vital_sign_id: t.vital_sign_id,
      vital_sign_name: v.name
    }
  end





  def get_tracking_by_client_day_date_query(client_id, first_date, last_date) do
    ndt_f = NaiveDateTime.from_iso8601!(first_date <> " 00:00:01")
    ndt_l = NaiveDateTime.from_iso8601!(last_date <> " 23:59:01")

    from t in Tracking,
    join: v in VitalSign, on: v.id == t.vital_sign_id,
    where: t.client_id == ^client_id and t.inserted_at >= ^ndt_f and t.inserted_at <= ^ndt_l,
    group_by: [fragment("to_date(to_char(?, 'YYYY/MM/DD'), 'YYYY/MM/DD')", t.inserted_at), v.id],
    order_by: fragment("to_date(to_char(?, 'YYYY/MM/DD'), 'YYYY/MM/DD')", t.inserted_at),
    select: %TrackingEm{
      vital_sign_id: v.id,
      vital_sign: max(v.name),
      date: fragment("to_date(to_char(?, 'YYYY/MM/DD'), 'YYYY/MM/DD')", t.inserted_at),
      value: avg(t.value)
    }
  end



  # def temp_query() do
  #   SELECT vital_sign_id, max(name) as vital_sign, to_date(to_char(tracking.inserted_at, 'YYYY/MM/DD'), 'YYYY/MM/DD') as date_i, avg(value) as value
	# FROM public.tracking
	# inner join public.vital_signs on tracking.vital_sign_id = vital_signs.id
	# where client_id = 'df206c29-bfd0-448d-940b-c7ca37617f20' and tracking.inserted_at>='2021-04-20 00:00:00' and tracking.inserted_at<='2022-04-20 23:59:59'
	# group by date_i, vital_sign_id
	# order by date_i


  #   from t in Tracking,
  #   join: v in VitalSign, on: v.id == t.vital_sign_id,
  #   group_by: [fragment("date_trunc('day',?)", t.inserted_at), v.id],
  #   select: %TrackingEm{
  #     vital_sign_id: v.id,
  #     vital_sign: max(v.name),
  #     date: max(t.inserted_at),
  #     value: avg(t.value)
  #   }

  # #   SELECT vital_sign_id, max(name) as vital_sign, max(tracking.inserted_at) as date, avg(value) as value
	# # FROM public.tracking
	# # inner join public.vital_signs on tracking.vital_sign_id = vital_signs.id
	# # where client_id = 'df206c29-bfd0-448d-940b-c7ca37617f20' and tracking.inserted_at>='2022-04-20 00:00:00' and tracking.inserted_at<='2022-04-20 23:59:59'
	# # group by date_trunc('day', tracking.inserted_at), vital_sign_id
  # end

  def get_tracking_by_client_date(client_id, first_date, last_date) do
    result = get_tracking_by_client_date_query(client_id, first_date, last_date)
    Repo.all(result)
  end

  def get_tracking_by_client_day_date(client_id, first_date, last_date) do
    result = get_tracking_by_client_day_date_query(client_id, first_date, last_date)
    Repo.all(result)
  end

  def get_tracking_by_routine_date(client_id, first_date, last_date) do
    result = get_tracking_by_routine_date_query(client_id, first_date, last_date)
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
