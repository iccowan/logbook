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
end
