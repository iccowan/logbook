defmodule Logbook.Books.BookGroup do
  @moduledoc """
  BookGroup schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Books.{Book, BookField}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "book_group" do
    field :name, :string

    timestamps()

    belongs_to :book, Book, foreign_key: :book_id, type: :binary_id

    has_many :book_fields, BookField
  end

  @type t :: %__MODULE__{
          id: UUID.t(),
          name: String.t(),
          book: Book.t(),
          book_id: UUID.t(),
          book_fields: [BookField.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }
end
