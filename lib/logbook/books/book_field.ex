defmodule Logbook.Books.BookField do
  @moduledoc """
  BookField schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Books.{BookGroup, BookEntryData, BookFieldType}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "book_field" do
    field :name, :string
    field :desc, :string

    timestamps()

    belongs_to :book_field_type, BookFieldType, foreign_key: :type_id, type: :integer
    belongs_to :book_group, BookGroup, foreign_key: :book_group_id, type: :binary_id

    has_many :book_entry_data, BookEntryData
  end
end
