defmodule Logbook.Books.BookEntry do
  @moduledoc """
  BookEntry schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Books.{Book, BookEntryData}
  alias Logbook.Aircraft.Aircraft
  alias Logbook.Airports.Airport

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "book_entry" do
    field :date, :date
    field :route, :string

    timestamps()

    belongs_to :book, Book, foreign_key: :book_id, type: :binary_id
    belongs_to :aircraft, Aircraft, foreign_key: :aircraft_id, type: :binary_id
    belongs_to :airport_from, Airport, foreign_key: :apt_from_id, type: :binary_id
    belongs_to :airport_to, Airport, foreign_key: :apt_to_id, type: :binary_id

    has_many :book_entry_data, BookEntryData
  end
end
