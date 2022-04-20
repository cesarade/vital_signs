# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     VitalSigns.Repo.insert!(%VitalSigns.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias VitalSigns.Repo
alias VitalSigns.Specialists.TypeSpecialist
alias VitalSigns.Specialists.{Specialist, Client, ClientSpecialist}
alias VitalSigns.Users.User
alias VitalSigns.VitalSigns.VitalSign


angel = Repo.insert(%Client{
      id: "ec924ca4-cba7-4621-8b34-3805f226a31b",
      firt_name: "MAYERLI ALEXANDRA",
      last_name: "ANGEL GUTIERREZ",
      genre: "FEMALE",
      user_name: "angel",
      email: "angel@email.com",
      image_url: ".."
})

joselyn = Repo.insert(%Client{
      id: "fcadc270-75bd-4d61-bc83-5d542aefb516",
      firt_name: "JOSELYN ABIGAIL",
      last_name: "BANCHON YAGUAL",
      genre: "FEMALE",
      user_name: "joselyn",
      email: "joselyn@email.com",
      image_url: ".."
})

jose = Repo.insert(%Client{
      id: "c044e182-39e4-4326-8078-555a3a98b296",
      firt_name: "JOSE FRANCISCO",
      last_name: "CHAVARRIA AVILA",
      genre: "MALE",
      user_name: "jose",
      email: "jose@email.com",
      image_url: ".."
})

jordy = Repo.insert(%Client{
      id: "6835f848-2024-4d80-940e-933cd1e696d7",
      firt_name: "JORDY RAFAEL",
      last_name: "DEL PEZO MERCHAN",
      genre: "MALE",
      user_name: "jordy",
      email: "jordy@email.com",
      image_url: ".."
})

jorge = Repo.insert(%Client{
      id: "9593fbae-106f-4560-a248-cbd7e2c2a72c",
      firt_name: "JORGE ANDRES",
      last_name: "ECHEVERRIA ROSADO",
      genre: "MALE",
      user_name: "jorge",
      email: "jorge@email.com",
      image_url: ".."
})

johan = Repo.insert(%Client{
      id: "c884b9d0-94e0-4470-be35-cfce785336b3",
      firt_name: "JOHAN ELIAS",
      last_name: "GALARZA MERELO",
      genre: "MALE",
      user_name: "johan",
      email: "johan@email.com",
      image_url: ".."
})

maria = Repo.insert(%Client{
      id: "27da5b22-165c-48a4-b1ab-64fc6660138b",
      firt_name: "MARIA FRANCISCA",
      last_name: "GONZALEZ LAVAYEN",
      genre: "FEMALE",
      user_name: "maria",
      email: "maria@email.com",
      image_url: ".."
})


jean = Repo.insert(%Client{
      id: "22096e71-4fd0-42c9-a419-00eb7af76c26",
      firt_name: "JEAN PAUL",
      last_name: "GUEVARA VILLALOBOS",
      genre: "MALE",
      user_name: "jean",
      email: "jean@email.com",
      image_url: ".."
})

angelg = Repo.insert(%Client{
      id: "428a8548-37ac-48b2-8bb4-88f0832c42df",
      firt_name: "ANGEL GABRIEL",
      last_name: "HERNANDEZ ALEJANDRO",
      genre: "MALE",
      user_name: "angelg",
      email: "angelg@email.com",
      image_url: ".."
})

Repo.insert(%Client{
      id: "df206c29-bfd0-448d-940b-c7ca37617f20",
      firt_name: "LESLIE ANAHI",
      last_name: "MACIAS PAZ",
      genre: "FEMALE",
      user_name: "leslie",
      email: "leslie@email.com",
      image_url: ".."
})

Repo.insert!(%Client{
      id: "cfe8c81b-9c39-4ee1-96d7-f6ad28ff731b",
      firt_name: "MIGUEL ANGEL",
      last_name: "MALDONADO BRIONES",
      genre: "MALE",
      user_name: "miguel",
      email: "miguel@email.com",
      image_url: ".."
})


Repo.insert(%TypeSpecialist{description: "DOCTOR"})
Repo.insert(%TypeSpecialist{description: "PERSONAL TRAINING"})

doctor = Repo.get_by(TypeSpecialist, description: "DOCTOR")
personal = Repo.get_by(TypeSpecialist, description: "PERSONAL TRAINING")

Repo.insert!(%Specialist{
      id: "8ba687d3-5990-40bd-89c1-cc19f7630f13",
      firt_name: "CÉSAR ANDRÉS",
      last_name: "ALCÍVAR ARAY",
      genre: "MALE",
      user_name: "cesar",
      email: "cesar@email.com",
      image_url: "..",
      type_specialist: personal}
)

Repo.insert!(%Specialist{
      id: "876d654b-4bf8-49fc-8657-8ea8bcb033b6",
      firt_name: "JOSÉ LUIS",
      last_name: "CABRERA MIRANDA",
      genre: "MALE",
      user_name: "cabrera",
      email: "cabrera@email.com",
      image_url: "..",
      type_specialist: doctor}
)

cesar = Repo.get_by(Specialist, firt_name: "CÉSAR ANDRÉS")
cl1 = Repo.get_by(Client, firt_name: "MIGUEL ANGEL")
cl2 = Repo.get_by(Client, firt_name: "LESLIE ANAHI")
cl3 = Repo.get_by(Client, firt_name: "ANGEL GABRIEL")

Repo.insert!(%ClientSpecialist{specialist: cesar, client: cl1, pending_approval: 1})
Repo.insert!(%ClientSpecialist{specialist: cesar, client: cl2, pending_approval: 1})
Repo.insert!(%ClientSpecialist{specialist: cesar, client: cl3})

sp1 = Repo.get_by(Specialist, firt_name: "JOSÉ LUIS")
cl1 = Repo.get_by(Client, firt_name: "JEAN PAUL")
cl2 = Repo.get_by(Client, firt_name: "MARIA FRANCISCA")
cl3 = Repo.get_by(Client, firt_name: "JOHAN ELIAS")
cl4 = Repo.get_by(Client, firt_name: "JORGE ANDRES")
cl5 = Repo.get_by(Client, firt_name: "JORDY RAFAEL")
cl6 = Repo.get_by(Client, firt_name: "JOSELYN ABIGAIL")

Repo.insert!(%ClientSpecialist{specialist: sp1, client: cl1, pending_approval: 1})
Repo.insert!(%ClientSpecialist{specialist: sp1, client: cl2, pending_approval: 1})
Repo.insert!(%ClientSpecialist{specialist: sp1, client: cl3, pending_approval: 1})
Repo.insert!(%ClientSpecialist{specialist: sp1, client: cl4, pending_approval: 1})
Repo.insert!(%ClientSpecialist{specialist: sp1, client: cl5})
Repo.insert!(%ClientSpecialist{specialist: sp1, client: cl6})


user = %{"email" => "cesar@email.com", "password" => "12345678", "password_confirmation" => "12345678", "role" => "specialist"}
Repo.insert(User.changeset(%User{}, user))

user = %{"email" => "cabrera@email.com", "password" => "12345678", "password_confirmation" => "12345678", "role" => "specialist"}
Repo.insert(User.changeset(%User{}, user))


user = %{"email" => "leslie@email.com", "password" => "12345678", "password_confirmation" => "12345678", "role" => "user"}
Repo.insert(User.changeset(%User{}, user))

user = %{"email" => "joselyn@email.com", "password" => "12345678", "password_confirmation" => "12345678", "role" => "user"}
Repo.insert(User.changeset(%User{}, user))

Repo.insert!(%VitalSign{id: "899e6b2c-5fe7-4444-84ef-add3e28d7dc5",name: "heartRate"})
Repo.insert!(%VitalSign{id: "8a1f0cd7-59d3-4dcd-9637-97344883c610",name: "temperature"})
Repo.insert!(%VitalSign{id: "efc41bec-1ccf-4a3c-8d27-57076ff6174f",name: "steps"})
Repo.insert!(%VitalSign{id: "83251a7c-4213-4227-9f9f-28eb6fab0ace",name: "calories"})
Repo.insert!(%VitalSign{id: "0fbab19b-72e5-43c4-8c96-3989b15ff6f4",name: "blood pressure"})


# "899e6b2c-5fe7-4444-84ef-add3e28d7dc5"
# "8a1f0cd7-59d3-4dcd-9637-97344883c610"
# "efc41bec-1ccf-4a3c-8d27-57076ff6174f"
# "83251a7c-4213-4227-9f9f-28eb6fab0ace"
# "0fbab19b-72e5-43c4-8c96-3989b15ff6f4"

IO.puts ""
IO.puts "Success! Sample data has been added."
