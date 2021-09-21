import Ecto.Query

alias Logbook.Books.BookFieldType
alias Logbook.Repo

# Integer Number
if ! Repo.exists?(from bft in BookFieldType, where: bft.id == 0) do
  %BookFieldType{
    id: 0,
    name: "Integer",
    desc: "Whole Integer Number",
  }
  |> Repo.insert!()
end

# Decimal Number
if ! Repo.exists?(from bft in BookFieldType, where: bft.id == 1) do
  %BookFieldType{
    id: 1,
    name: "Decimal",
    desc: "Decimal Number"
  }
  |> Repo.insert!()
end

# Short Text (String)
if ! Repo.exists?(from bft in BookFieldType, where: bft.id == 2) do
  %BookFieldType{
    id: 2,
    name: "Short Text",
    desc: "Short Text"
  }
  |> Repo.insert!()
end

# Long Text (Long String)
if ! Repo.exists?(from bft in BookFieldType, where: bft.id == 3) do
  %BookFieldType{
    id: 3,
    name: "Long Text",
    desc: "Long Text"
  }
  |> Repo.insert!()
end
