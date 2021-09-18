defmodule Logbook.Books.Book do
  @moduledoc """
  Book schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Logbook.Books.{BookEntry, BookGroup}
  alias Logbook.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "books" do
    belongs_to :user, User, foreign_key: :user_id, type: :binary_id

    timestamps()

    has_many :book_groups, BookGroup
    has_many :book_entries, BookEntry
  end

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          user: User.t(),
          user_id: Ecto.UUID.t(),
          book_groups: [BookGroup.t()],
          book_entries: [BookEntry.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }
end
