defmodule Logbook.Users.User do
  @moduledoc """
  User schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Airports.Airport
  alias Logbook.Aircraft.AircraftType
  alias Logbook.Books.Book
  alias Logbook.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string

    timestamps()

    has_many :airports, Airport
    has_many :aircraft_types, AircraftType
    has_many :books, Book
  end

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          first_name: String.t(),
          last_name: String.t(),
          email: String.t(),
          password: String.t(),
          airports: [Airport.t()],
          aircraft_types: [AircraftType.t()],
          books: [Book.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(user = %User{}, attrs \\ %{}) do
    user
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
