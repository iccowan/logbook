defmodule Logbook.Books.BookEntryData do
  @moduledoc """
  BookEntryData schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Books.{BookEntry, BookField}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "book_entry_data" do
    field :value, :map

    timestamps()

    belongs_to :book_field, BookField, foreign_key: :book_field_id, type: :binary_id
    belongs_to :book_entry, BookEntry, foreign_key: :book_entry_id, type: :binary_id
  end
end
