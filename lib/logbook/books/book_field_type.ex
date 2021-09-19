defmodule Logbook.Books.BookFieldType do
  @moduledoc """
  BookFieldType schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Books.{BookField, BookFieldType}

  schema "book_field_types" do
    field :name, :string
    field :desc, :string

    timestamps()

    has_many :book_fields, BookField, foreign_key: :type_id
  end

  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          desc: String.t(),
          book_fields: [BookField.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(book_field_type = %BookFieldType{}, attrs \\ %{}) do
    book_field_type
    |> cast(attrs, [:name, :desc])
    |> validate_required([:name])
  end
end
