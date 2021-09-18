defmodule Logbook.Books.BookField do
  @moduledoc """
  BookField schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Books.{BookField, BookGroup, BookEntryData, BookFieldType}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "book_field" do
    field :name, :string
    field :desc, :string

    timestamps()

    belongs_to :book_field_type, BookFieldType,
      foreign_key: :type_id,
      type: :integer

    belongs_to :book_group, BookGroup,
      foreign_key: :book_group_id,
      type: :binary_id

    has_many :book_entry_data, BookEntryData
  end

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          name: String.t(),
          desc: String.t(),
          book_field_type: BookFieldType.t(),
          type_id: integer(),
          book_group: BookGroup.t(),
          book_group_id: Ecto.UUID.t(),
          book_entry_data: [BookEntryData.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  def changeset(book_field = %BookField{}, attrs \\ %{}) do
    book_field
    |> cast(attrs, [:name, :desc, :type_id, :book_group_id])
    |> validate_required([:name, :book_group_id, :type_id])
  end
end
