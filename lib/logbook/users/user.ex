defmodule Logbook.Users.User do
  @moduledoc """
  User schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Airports.Airport
  alias Logbook.Aircraft.AircraftType
  alias Logbook.Books.Book

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "user" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string

    timestamps()

    has_many :airports, Airport
    has_many :aircraft_types, AircraftType
    has_many :books, Book
  end
end
