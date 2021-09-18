defmodule Logbook.Airports.Airport do
  @moduledoc """
  Airport schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Aircraft.Aircraft
  alias Logbook.Users.User
  alias Logbook.Books.BookEntry

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "airport" do
    field :code, :string
    field :name, :string
    field :location, :string
    field :is_favorite, :boolean

    timestamps()

    belongs_to :user, User, foreign_key: :user_id, type: :binary_id

    has_many :aircraft, Aircraft, foreign_key: :aircraft_type_id
    has_many :book_entries_arr, BookEntry, foreign_key: :apt_from_id
    has_many :book_entries_dest, BookEntry, foreign_key: :apt_to_id
  end
end