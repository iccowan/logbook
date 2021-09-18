defmodule Logbook.Aircraft.Aircraft do
  @moduledoc """
  Aircraft schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Aircraft.AircraftType
  alias Logbook.Airports.Airport
  alias Logbook.Books.BookEntry

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "aircraft" do
    field :tail_number, :string
    field :notes, :string
    field :is_favorite, :boolean

    timestamps()

    belongs_to :aircraft_type, AircraftType,
      foreign_key: :aircraft_type_id,
      type: :binary_id

    belongs_to :home_base_airport, Airport,
      foreign_key: :home_base_apt_id,
      type: :binary_id

    has_many :book_entries, BookEntry
  end
end
