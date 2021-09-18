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

    belongs_to :book_field, BookField,
      foreign_key: :book_field_id,
      type: :binary_id

    belongs_to :book_entry, BookEntry,
      foreign_key: :book_entry_id,
      type: :binary_id
  end

  @type t :: %__MODULE__{
          id: UUID.t(),
          value: Map.t(),
          book_field: BookField.t(),
          book_field_id: UUID.t(),
          book_entry: BookEntry.t(),
          book_entry_id: UUID.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }
end
